/**
* Name: FirstFloor
* Based on the internal empty template. 
* Author: valencia
* Tags: 
*/


model FirstFloor



global {
//	
//	file wall_shapefile <- file("../includes/walls.shp");
//	shape_file free_spaces_shape_file <- shape_file("../includes/free spaces.shp");
//	shape_file open_area_shape_file <- shape_file("../includes/open area.shp");
//	shape_file pedestrian_paths_shape_file <- shape_file("../includes/pedestrian paths.shp");
//	shape_file open_area_shape_file <- shape_file("../includes/vidacity_shapes/floor_1_outerwall.shp");

	// visualisation of layout for lvl 1
	shape_file free_spaces_shape_file <- shape_file("../includes/vidacity_shapes/floor_1_outerwall.shp");
	
	// store blocks
	file store_floor_file <- file("../includes/vidacity_shapes/floor_1_blockdict.shp");
	
	// routes for lvl 1
	shape_file pedestrian_paths_shape_file <- shape_file("../includes/vidacity_shapes/floor_1_path_segments.shp");

	// store boundaries for lvl 1
	file wall_shapefile <- file("../includes/vidacity_shapes/floor_1_tenant_lines.shp");
	
	//bin locations for lvl 1
	file bin_location_floor_1 <- file("../includes/vidacity_shapes/floor_1_bins.shp");
	
	// tenant spawn location for lvl 1
	file agent_spawn_locations_floor_1 <- file("../includes/vidacity_shapes/floor_1_agent.shp");
	
	//Set environment size
	geometry shape <- envelope(first(free_spaces_shape_file.contents));
	
    // set each step to be 1 minute
    float step <- 1 #minute;
    
    //set the date
	date starting_date <- date([2025,1,1,0,0,0]); // 1 Jan 2025, at 00:00:00
    
    
    // set display text size
    int displayTextSize <- 5;
    
    float ReadyToClear_multiplier <- 0.6;
//	float ReadyToClear_multiplier <- 0.6 parameter:true category: "Experiment Settings";
	float AboutToBeFull_multiplier <- 0.9;
	
	int total_complaints <- 0;
	float total_time_bin_overflowed <- 0.0;

	// For 9 stores on level 1:
	
	int lvl1_store_0_no_tenants <- 1 parameter:true category:"Level 1";

	int lvl1_store_1_no_tenants <- 3 parameter:true category:"Level 1"; // current issue is it doesnt create agents specific to each store initialised

	int lvl1_store_2_no_tenants <- 1 parameter:true category:"Level 1";
	
	int lvl1_store_3_no_tenants <- 1 parameter:true category:"Level 1";

	int lvl1_store_4_no_tenants <- 1 parameter:true category:"Level 1";

	int lvl1_store_5_no_tenants <- 1 parameter:true category:"Level 1";

	int lvl1_store_6_no_tenants <- 1 parameter:true category:"Level 1";

	int lvl1_store_7_no_tenants <- 1 parameter:true category:"Level 1";
	
	int lvl1_store_8_no_tenants <- 1 parameter:true category:"Level 1";
	
	list no_of_tenants_per_store_lvl1 <- [
		lvl1_store_0_no_tenants,
		lvl1_store_1_no_tenants,
		lvl1_store_2_no_tenants,
		lvl1_store_3_no_tenants,
		lvl1_store_4_no_tenants,
		lvl1_store_5_no_tenants,
		lvl1_store_6_no_tenants,
		lvl1_store_7_no_tenants,
		lvl1_store_8_no_tenants
	];
    

    // Graph for navigation
    graph pedestrian_network;
    
	geometry vida_layout_floor_1 <-first(free_spaces_shape_file);
	
    
    ///////////////////////    NHPP    /////////////////////    NHPP    /////////////////////    NHPP    /////////////////////
    
    int T <- 1380; // set to 24 hours (23 because 0 is coutned), total time for process to run
    list event_times_this_period;
    list current_cumulative_trash;
    list intensity_values_over_time;
    float cumulative_one_day;
    
    
    ///////////////////////    NHPP    /////////////////////    NHPP    /////////////////////    NHPP    /////////////////////
    
    

    init {
    	
    
    	 
    	    	    	
        // Create obstacles
        create obstacle from: wall_shapefile;
        create vida_lvl_1 from: free_spaces_shape_file;


		// create path for tenants
        create pedestrian_path from: pedestrian_paths_shape_file;
		pedestrian_network <- as_edge_graph(pedestrian_path);
		
		
		
//		// get number of tenants per store created, starting from index 0
//		create people number: no_of_tenants_per_store_lvl1 at self.index{
//			location <- self.location;
//			write "tenant location at: " + location;
//    		has_trash <- false;
//    		trash_on_hand<- 0.0;
//        	home_base <- location;
//        	trash_generation_lambda <- rnd(0.3, 1.0);
//			
//		}
		
		
        // create cleaner agent
        create cleaner{
        	location <- {97,90,0};
			is_cleaning <- false;
			trash_on_hand <- 0.0;
			max_trash_capacity <- 180.0;
			resting_location <- location;
        }
        
		
		//create central rubbish bin agent
		create central_bin{	
			location <- {178,90,0};
		}		
		
				
		create bin from: bin_location_floor_1{
            current_capacity <- 0.0;
            // set at 45L (450 units)
            max_capacity <- 45.0;
            // set by slider, else 0.6 & 0.9
            ReadyToClear_capacity <- ReadyToClear_multiplier * max_capacity;
			AboutToBeFull_capacity<- AboutToBeFull_multiplier * max_capacity;
            ask central_bin{
            	myself.distance_to_central_bin <- self.location distance_to myself.location;
            }
		}
		
		
		create store from: agent_spawn_locations_floor_1;
		
		
		create store_floor from: store_floor_file;
    
 		
    }
    
}


// Create central rubbish bin agent
species central_bin{
	
	aspect default {
		draw square(15) color: #purple depth: 15;
	}
	
}

// Species for pedestrian paths
species pedestrian_path skills: [pedestrian_road] {
    aspect default {
        draw shape color: #gray;
    }
}

// Species for vidacity_lvl_1_outline
species vida_lvl_1 {
    aspect default {
        draw shape color: #gray border: #black at:{location.x,location.y,location.z-0.1} perspective:false;
    }
}

// Species for obstacles
species obstacle {
	aspect default {
		draw shape + (0.45/2.0) color: #gray border: #black depth: 0;
	}
}

species store_floor {
	aspect default{
		draw shape color: #orange;
	}
}

// Species for trash bins
species bin {
	rgb bin_color <- #green;
	float max_capacity;
	float current_capacity <- 0.0;
	// Statuses: Empty, Filling, ReadyToClear, AboutToBeFull, Full
	string current_status <- "Empty";
	float ReadyToClear_capacity;
	float AboutToBeFull_capacity;
	float distance_to_central_bin;
	float current_distance_to_cleaner <- 0.0;
	int bin_width <- 10;
	
	reflex check_bin_trash_level{
		
		// set different colours of bins based on threshold
		if (current_capacity >= 0.0 and current_capacity < ReadyToClear_capacity){
			current_status <- "Filling";
			bin_color <- #green;
		}
		
		else if (current_capacity >= ReadyToClear_capacity and current_capacity < AboutToBeFull_capacity){
			bin_color <- #yellow;
			current_status <- "ReadyToClear";
		}
		
		else if (current_capacity >= AboutToBeFull_capacity and current_capacity < max_capacity){
			bin_color <- #orange;
			current_status <- "AboutToBeFull";
		}
		
		
		else if (current_capacity >= max_capacity){
			bin_color <- #red;
			current_status <- "Full"; 
			total_time_bin_overflowed <- total_time_bin_overflowed + 1.0;
		}
		
	}
	
    aspect default {
        draw square(bin_width) color: bin_color depth: bin_width-5;
		draw ("Bin " + self.index) color:#black size:displayTextSize at:{location.x-bin_width,location.y+bin_width+displayTextSize} perspective:false;
		draw ("Fill: " + round(current_capacity*100)/100);
		draw ("Fill Level: " + int((current_capacity / max_capacity) * 100) + " %") color:#black size:displayTextSize at:{location.x-bin_width,location.y+bin_width+displayTextSize*3} perspective:false; 
        draw ("Status: " + current_status) color:#black size:(displayTextSize) at:{location.x-bin_width,location.y+bin_width+displayTextSize*5} perspective:false;
    
    }
}

species store{
	
	int tenant_no <- (no_of_tenants_per_store_lvl1 at self.index);
	list<agent> tenants_in_store;
	int current_tenants_in_store;
	float store_bin <- 0.0;
	int store_bin_clear_threshold <- 5;
	int store_size <- 20;
	geometry store_area <- rectangle({location.x-(store_size/2),location.y-(store_size/2)}, {location.x+(store_size/2),location.y+(store_size/2)});
	geometry spawn_pts <- pedestrian_path first_with (each overlaps store_area and any(store_floor_file) covers(each));
	init{
		
		write"SPAWN POINTS: " + spawn_pts;
		
		write "my tenant nummber is: " + tenant_no;
		
		create people number:tenant_no{
				name <- ("Tenant " + host.index + "." + self.index);
				location <- any_location_in(spawn_pts);
				write "Tenant location at: " + location;
	    		has_trash <- false;
	    		trash_on_hand<- 0.0;
	        	home_base <- location;
	        	write name + " is hosted by " + host;
			}
		
	}
		
	
	
	reflex refresh_agent_in_store_count{
		
		ask agents {
				
				
				if (myself.store_area covers(self.location)) and !(myself.tenants_in_store contains self) {
					myself.tenants_in_store <- 	myself.tenants_in_store + self;
					
				}
				
				else if !(myself.store_area covers(self.location)) and (myself.tenants_in_store contains self){
					myself.tenants_in_store <- 	myself.tenants_in_store - self;
				}
//				if (self.location distance_to self.host < 1) and !(myself.tenants_in_store contains self) {
//					myself.tenants_in_store <- 	myself.tenants_in_store + self;
//					
//				}
//				
//				else if (self.location distance_to self.host > 1) and (myself.tenants_in_store contains self){
//					myself.tenants_in_store <- 	myself.tenants_in_store - self;
//				}
		
			
		}
		
		current_tenants_in_store <- length(tenants_in_store);
		
	}
	
	


	aspect default {
		draw square(store_size) color: #burlywood at:{location.x,location.y, location.z-1};
		draw ("Store " + self.index + " has " + current_tenants_in_store + "/" + tenant_no + " tenants.") color:#magenta size:displayTextSize at:{location.x+5,location.y+5+displayTextSize} perspective:false;
		draw circle(2) depth: 2 color: #magenta at:{location.x,location.y, location.z-1};
		draw ("Fill: " + string(round(store_bin*100)/100)) + "/" + store_bin_clear_threshold color: #magenta size: displayTextSize at: {location.x +5 ,location.y +20, location.z-1} perspective:false;
		draw ("Fill Level: " + int((store_bin / store_bin_clear_threshold) * 100) + " %") color:#magenta size:displayTextSize at:{location.x+5,location.y+25+displayTextSize} perspective:false; 
	}
	




	// Species for people with pedestrian skill
	species people skills: [pedestrian]{
		
		
		float trash_generation_lambda;
		float trash_on_hand;
	    
	    rgb color <- rnd_color(255);
	    float speed <- 0.05 #km/#h; //should be 4km/h irl, this is just for visualisation
	    bin target_bin;
	    point current_target;
	    point home_base;
		path path_to_bin;
		int len_path_to_bin;
		bool has_trash;
		
		
	    
	 
		
    ///////////////////////    START NHPP    /////////////////////   START  NHPP    /////////////////////    START NHPP    /////////////////////
		
		float mean_trash_amount <- 0.3;
	    float sd_trash_amount <- 0.01;
	    	   
	    float trash_generated_now;
	    list<float> intensity_values <- []; // stores intensity fn values for visualisation
	    
	    list daily_trash_log;
	    
//	    // h1 < h2
//	    float base_rate <- 0.003083;
//	    float amp1 <- 0.014778;
//	    int center1 <- 690;
//	    float amp2 <- 0.021514;
//	    int center2 <- 870;
//	    int fixed_width <- 60;
	    
	    //	h1 > h2
	    float base_rate <- 0.002704;
	    float amp1 <- 0.017833;
	    int center1 <- 690;
	    float amp2 <- 0.012104;
	    int center2 <- 870;
	    int fixed_width <- 60;
//	
//	    
//	    //	h1 = h2
//	    float base_rate <- 0.002280;
//	    float amp1 <- 0.018793;
//	    int center1 <- 690;
//	    float amp2 <- 0.018793;
//	    int center2 <- 870;
//	    int fixed_width <- 60;
		float lambda_t (int t) {
    	
	    	float intensity <- base_rate;
	    	intensity <- intensity + amp1 * exp((-1)*((t-center1)^2)/((2*(fixed_width)^2)));
	    	intensity <- intensity + amp2 * exp((-1)*((t-center2)^2)/((2*(fixed_width)^2)));
	    	
	    	return max(0,intensity);
    	
    	}
    
    	float lambda_max <- max(lambda_t(center1), lambda_t(center2));
    	
    	reflex default when: self.location = home_base and has_trash = false {
    		do create_trash;
    		store_bin <- store_bin + trash_generated_now;
    		// trash_on_hand <- trash_on_hand + trash_generated_now;
    		
    		if (store_bin >= store_bin_clear_threshold){
	        	has_trash <- true;
	        	trash_on_hand <- store_bin;
	        	
	        	// transfered trash to tenant hand
	        	store_bin <- 0.0;
	        	do search_target;
	        }
	     
    	}
    	
    	
    	
    	action create_trash {
    		int t <- (cycle mod T);
    		float intensity_at_t <- lambda_t(cycle mod T);
	        float candidate <- rnd(0.0,1.0);
	        float acceptance_prob <- 1-exp((-1)*(intensity_at_t)); //intensity_at_t / lambda_max;
	        if (candidate < acceptance_prob) { 
	               trash_generated_now <- gauss(mean_trash_amount, sd_trash_amount);
	               write "Current t is: " + t;	
    		}
    		else{
    			trash_generated_now <- 0.0;
    		}
    	}
	    
    ///////////////////////   END NHPP    /////////////////////   END NHPP    /////////////////////   END NHPP    /////////////////////
		
		
		
	    
	    // Find target bin if none is set and if the agent has trash
	    action search_target {
			ask bin closest_to(self) {
				    	// write "my target is: " + self + "i am:" + myself;
			        	
			            myself.target_bin <- self;
			            myself.current_target <- self.location;
			        }
	    }
	    
	    
	    reflex move when: current_target != nil {
	    	
	    	
	    	//in tenant store chilling
	    	if not has_trash and current_target = home_base{
	    		if self.location distance_to home_base < 0.1 {
		            current_target <- nil;
	//	            write name + " has reached home! Time to make trash...";
		        }
	        //go back to store
	        else{
	           do goto (target: home_base, on: pedestrian_network);
			}
	    		
	    		
	    		
	    	}
	    	//disposing of trash
	    	if has_trash and current_target = target_bin.location{
	    		
	    		
	    		if self.location distance_to target_bin.location < 0.1 {
	    			
	    			//add complaint?
	    			if target_bin.current_status = "Full"{
	    				
	    				total_complaints <- total_complaints + 1;
	    			}
	    			
		  			target_bin.current_capacity <- (target_bin.current_capacity + trash_on_hand); 
		            has_trash <- false;
		            trash_on_hand <- 0.0;
		            current_target <- home_base;
	//	            write name + " has reached the bin!";
		        }
		    //walking to bin
	        else{
	            do goto (target: target_bin.location, on: pedestrian_network);
	//			  do goto (target: target_bin.location);
	            
	            
			}
	     }
	    		
	    }
	    	
	    
	    aspect default {
//			draw ("Trash on hand:") color:#black size:displayTextSize at:{location.x-5,location.y+displayTextSize*2} perspective:false; 
			draw (string(round(trash_on_hand*100)/100)) color:#black size:displayTextSize at:{location.x-10,location.y+displayTextSize*4} perspective:false; 
	    	
	        
	        draw triangle(6) color: color rotate: heading + 90.0 depth: 6;
	        
	        if (current_path != nil) {
				draw current_path.shape color: #red;
			}
	       
	    }
	}
	
	}
	

	

species cleaner skills:[pedestrian]{
	bool is_cleaning <- false;
	float trash_on_hand;
	float max_trash_capacity;
	point current_target;
	int readyCount;
	point resting_location;
	float speed <- 0.0666 #km/#h; //should be 3km/h irl, this is just for visualisation
    bool return_to_rest <- false;
    point central_bin_location;
    bin bin_to_clean;
	list<bin> readyBins <- [];
	list<bin> BinsAboutToBeFull <- [];
	list<bin> bins_to_clean_order;
	list<point> route <- [resting_location];
	list<float> distance;
	
	bool trigger <- false;
	bool check <- true;
	
	// is clearing, return to rest, check
	// check for clearing when false, false, true
	// trigger clearing: true, false, false
	// clearing when true, false, false
	// at dumpster: false, true, false
	// return to rest when false, true, false
	// return to rest : false, false, true
	// actually rest: false, false, true
 

	reflex add_bins_to_activated_list when: check = true{
		//write "add bins to activated";

		ask agents of_species bin{
			
	 		// for each bin, if bins not inside readyBins list yet, add the bin into the list.
	 		if (self.current_status = "ReadyToClear" or self.current_status = "Full" or self.current_status = "AboutToBeFull"){
	 			if (myself.readyBins contains self = false){
	 				myself.readyBins <- myself.readyBins + self;
	 				
	 			}
	 		}
	 		
	 		// for each bin, check if they are about to be full, if so, trigger cleaning fn on readyBins
	 		if ( self.current_status = "Full" or self.current_status = "AboutToBeFull"){
	 			if (myself.BinsAboutToBeFull contains self = false){
	 				myself.BinsAboutToBeFull <- myself.BinsAboutToBeFull + self;
	 				
	 			}
	 		}
	 	}	 
	 	
	 	
	 	readyCount <- length(readyBins);
	 	   
	 	//write "Ready bin count: " + readyCount;
	 	
	 	// sort cleaning order and activate cleaner
	 	if (readyCount >= 4) or (length(BinsAboutToBeFull) > 0){
	 		write" ready count is: " + readyCount + "and BinsAboutToBeFull is: " + BinsAboutToBeFull;
	 		trigger <- true;
	 		check <- false;
	 		do trigger_clean;
	 		
	 	}
	 	else if ((self.location distance_to resting_location) > 0.1){
	 		
			do goto (target:resting_location, on:pedestrian_network);
	 		
	 	}

	 	
	 	
//	 	else if (readyCount < 4) and (length(BinsAboutToBeFull) = 0) and (location != resting_location) and (return_to_rest = false){
//	        	return_to_rest <- true;
//	        	write "Cleaner is returning to rest...";
//	    }
	    

	 	
	 	
	 	
	 	
	}
	
	action trigger_clean{
		write " action trigger clean";
		trigger <- false;
		bins_to_clean_order <- readyBins sort_by (each.distance_to_central_bin);
		write "Length of bins to cleaer: " + length(bins_to_clean_order);
	    loop i over: bins_to_clean_order{
	    	route <- route + i.location;
	    }
		do get_central_bin_location;
		route <- route + central_bin_location + resting_location;
	            
//	            loop i over: route{
//	            distance <- distance + count(edge_between(pedestrian_network, i:: i+1));
//	            
//	            }
       write "Cleaner activated! Cleaning bins..." ;
       //write "Route is " + route;
       //write "Distance list is: " + distance;
       //write "Total Route distance: " + sum(distance);
	            
	   is_cleaning <- true;
	   return_to_rest <- false;	        	
	}

	action get_central_bin_location{
		write "get dumpster location";
		ask central_bin{
			myself.central_bin_location <- self.location;
		}
	}      

	
  
	            
	reflex clean_bins when: is_cleaning = true and return_to_rest = false and check = false{
		
        
        if (length(bins_to_clean_order) > 0 and location distance_to (bins_to_clean_order at 0) > 0.01){
        	write "go to next bin";
        	bin_to_clean <- bins_to_clean_order at 0;
//			write "Cleaning " + bin_to_clean + "now!";
        	do goto (target:bin_to_clean, on:pedestrian_network);
        }
        
        // once first bin in the list has been reached
        else if (length(bins_to_clean_order) > 0){
        	write "at bin to clear";
        	// increase trash on hand
			trash_on_hand <- trash_on_hand + bin_to_clean.current_capacity;
        	bin_to_clean.current_capacity <- 0.0;
			bin_to_clean.current_status <- "Empty";
			write "Finished clearing" + bin_to_clean;
			//remove bin from readyBins so that bin can start filling again while cleaner is cleaning other bins
			remove item: bin_to_clean from:readyBins;
			if BinsAboutToBeFull contains bin_to_clean {
				remove item: bin_to_clean from: BinsAboutToBeFull;
			
			}
			remove item: bin_to_clean.location from: route;
        	remove item: bin_to_clean from:bins_to_clean_order;
        	
        	if (length(bins_to_clean_order) > 0){
	        	ask bin {
	        		self.current_distance_to_cleaner <- myself.location distance_to self.location;
	        	}
	        	bins_to_clean_order <- bins_to_clean_order sort_by (each.current_distance_to_cleaner);
        	}
        }
        
        //once done with the last bin
        else{
//        	// increase trash on hand
//			trash_on_hand <- trash_on_hand + bin_to_clean.current_capacity;
//        	bin_to_clean.current_capacity <- 0.0;
//			bin_to_clean.current_status <- "Empty";
//			write "Finished clearing" + bin_to_clean;
//			//remove bin from readyBins so that bin can start filling again while cleaner is cleaning other bins
//			write "BEFORE removal" + readyBins + "and" + bins_to_clean_order;
//			remove item: bin_to_clean from:readyBins;
//        	remove item: bin_to_clean from:bins_to_clean_order; // should now be empty
//			write "AFTER removal" + readyBins + "and" + bins_to_clean_order;

			// go to central trash bin to throw trash
			

				
			// write "central bin location is: "  + central_bin_location;
				
        	if location distance_to central_bin_location > 0.1{
					do goto (target:central_bin_location, on:pedestrian_network);
			}
			
			// to let first reflex function run
			else if location distance_to central_bin_location <= 0.1{
				write "Dumping trash into DUMSPTER";
				trash_on_hand <- 0.0;
        		is_cleaning <- false;
        		check<- true;
        		
//        		return_to_rest <- true;
        	}
        	else { write "BROKEN";}
        	
        }
	}
	          
	            
	
//	            
//	reflex return_to_rest_process when: is_cleaning = false and return_to_rest = true{
////		write "after dumpster now returning to rest";
////		check <- true;
//		if location distance_to resting_location > 0.01{
//			do goto (target:resting_location, on:pedestrian_network);
////			return_to_rest <- false;
////			check <- true;
//		}
//				
//		else{
//			write "Cleaner has started rest.";
//			return_to_rest <- false;
//			check<- true;
//		}
//		
//	}
//	            
	
	
	aspect default {
		
        draw circle(6) color: is_cleaning ? #green : #gray depth: 6;
        draw ("Trash on hand: " + trash_on_hand) color:#black size:(displayTextSize) at:{location.x,location.y+(displayTextSize)} perspective:false;
        
    }
}






experiment pedestrian_navigation type: gui {
    float minimum_cycle_duration <- 0.1;
	
	parameter "Ready-to-clear Threshold" category:"Waste Bin Thresholds" var: ReadyToClear_multiplier min: 0.0  max: 1.0 step: 0.05;
	parameter "About-to-be-full Threshold" category:"Waste Bin Thresholds" var: AboutToBeFull_multiplier min: 0.0  max: 1.0 step: 0.05;
//	text string("Total number of complaints: ")  category: "Success Metrics" color: #white background: #black font: font("Helvetica",14,#bold); 
//	parameter "Float (with on_change listener)" category:"Success Metrics" var: total_complaints {write ""+total_complaints;}
	
		
    	
    output {
    	
    	monitor "TOTAL COMPLAINTS" value: total_complaints refresh: every(step);
    	monitor "ACUMULATED TIME OF BINS OVERFLOWED (MINS): " value: total_time_bin_overflowed/60 refresh: every(step);

    	
//		inspect "inspector_name" value: success_metrics attributes: ["total_complaints"];
    	
        display vidacity_lvl_1 type: opengl {
        	

            species obstacle transparency: 0.5;
            species pedestrian_path transparency: 0.5;
            species bin aspect: default;
            
            species cleaner aspect: default;
            species central_bin aspect: default;
            
            species store aspect: default {
            	species people aspect: default;
            	
            	}
            species store_floor aspect: default transparency: 0.8;
            species vida_lvl_1 transparency: 0.88;
            
//            overlay position: { 10, 10 } size: { 360 #px, 180 #px } background: # black transparency: 0.5 border: #black rounded: true
//            {
//                
//                    draw string("Total Complaints: " + total_complaints) size: 500000  at: { 40#px, 60#px } color: #black;
//                    
//
//                
//
//            }
            }

//        display "Event Log" type: 2d{
//			chart "Trash Generation Event Log Over 24-hours" type: histogram x_label:"Time (minutes)" y_label:"Volume of Trash (Litres)" {
//                data "Trash Generation Event Log" value: current_cumulative_trash color: #blue style: spline;
//            } 
//        }
//        display "Trash Log" type: 2d {
//            chart "Daily Total Trash Per Tenant" type: series x_label:"Day" y_label:"Volume of Trash (Litres)" {
//                //data people collect (each.daily_trash_log) value: people collect (each.daily_trash_log);
//            }
//        }
//        display "Store Bins" type: 2d {
//            chart "Store Bins" type: series x_label:"Day" y_label:"Volume of Trash (Litres)" {
//                datalist store(0) collect (each.store_bin) value: store collect (each.store_bin);
//            
//   
////    	display "my_display"{
////	   		chart "my_chart" type: series{
////				datalist people collect (each.name) value:  people collect (each.trash_on_hand) color: people collect (each.color) marker: false style: spline thickness:2;
//		    }
//		}
	}
}

