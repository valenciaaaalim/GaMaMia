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

	font agent_font <- font("Helvetica", 14, #bold );
	


	
    // set each step to be 1 minute
    float step <- 1 #second;
    
    //set the date
	date starting_date <- date([2025,1,1,0,0,0]); // 1 Jan 2025, at 00:00:00
    
    
    // set display text size
    int displayTextSize <- 5;
    
    float ReadyToClear_multiplier <- 0.6;
//	float ReadyToClear_multiplier <- 0.6 parameter:true category: "Experiment Settings";
	float AboutToBeFull_multiplier <- 0.9;
	
	int total_complaints <- 0;
	float total_time_bin_overflowed <- 0.0;
	
	
////////////////////////////////////////// LEVEL 1 //////////////////////////////////////////
	// visualisation of layout for lvl 1
	shape_file free_spaces_1_shape_file <- shape_file("../includes/vidacity_shapes/floor_1_outerwall.shp");
	
	// store blocks
	file store_floor_1_file <- file("../includes/vidacity_shapes/floor_1_blockdict.shp");
	
	// routes for lvl 1
	shape_file pedestrian_paths_floor_1_shape_file <- shape_file("../includes/vidacity_shapes/floor_1_path_segments.shp");

	// store boundaries for lvl 1
	file wall_floor_1_shapefile <- file("../includes/vidacity_shapes/floor_1_tenant_lines.shp");
	
	//bin locations for lvl 1
	file bin_location_floor_1 <- file("../includes/vidacity_shapes/floor_1_bins.shp");
	
	// tenant spawn location for lvl 1
	file agent_spawn_locations_floor_1 <- file("../includes/vidacity_shapes/floor_1_agent.shp");
	


	// For 9 stores on level 1:
	
	int lvl1_store_0_no_tenants <- 5 parameter:true category:"Level 1";

	int lvl1_store_1_no_tenants <- 2 parameter:true category:"Level 1"; // current issue is it doesnt create agents specific to each store initialised

	int lvl1_store_2_no_tenants <- 2 parameter:true category:"Level 1";
	
	int lvl1_store_3_no_tenants <- 1 parameter:true category:"Level 1";

	int lvl1_store_4_no_tenants <- 5 parameter:true category:"Level 1";

	int lvl1_store_5_no_tenants <- 5 parameter:true category:"Level 1";

	int lvl1_store_6_no_tenants <- 5 parameter:true category:"Level 1";

	int lvl1_store_7_no_tenants <- 5 parameter:true category:"Level 1";
	
	int lvl1_store_8_no_tenants <- 5 parameter:true category:"Level 1";
	
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
	
	list<point> store_text_location_1 <-[
		{-50,250,0},
		{38,140,0},
		{135,344,0},
		{212,285,0},
		{120,110,0},
		{270,145,0},
		{405,253,0},
		{474,256,0},
		{410,162,0}
		
	];
	
////////////////////////////////////////// LEVEL 1 //////////////////////////////////////////


    
	//Set environment size
	geometry shape <- envelope(first(free_spaces_1_shape_file.contents));
	
////////////////////////////////////////// LEVEL 2 //////////////////////////////////////////
	// visualisation of layout for lvl 1
	shape_file free_spaces_2_shape_file <- shape_file("../includes/vidacity_shapes/floor_2_outerwall.shp");
	
	// store blocks
	file store_floor_2_file <- file("../includes/vidacity_shapes/floor_2_blockdict.shp");
	
	// routes for lvl 1
	shape_file pedestrian_paths_floor_2_shape_file <- shape_file("../includes/vidacity_shapes/floor_2_path_segments.shp");

	// store boundaries for lvl 1
	file wall_floor_2_shapefile <- file("../includes/vidacity_shapes/floor_2_tenant_lines.shp");
	
	//bin locations for lvl 1
	file bin_location_floor_2 <- file("../includes/vidacity_shapes/floor_2_bins.shp");
	
	// tenant spawn location for lvl 1
	file agent_spawn_locations_floor_2 <- file("../includes/vidacity_shapes/floor_2_agent.shp");
	


	// For 13 stores on level 2:
	
	int lvl2_store_0_no_tenants <- 5 parameter:true category:"Level 2";

	int lvl2_store_1_no_tenants <- 5 parameter:true category:"Level 2"; // current issue is it doesnt create agents specific to each store initialised

	int lvl2_store_2_no_tenants <- 5 parameter:true category:"Level 2";
	
	int lvl2_store_3_no_tenants <- 5 parameter:true category:"Level 2";
	
	int lvl2_store_4_no_tenants <- 5 parameter:true category:"Level 2";

	int lvl2_store_5_no_tenants <- 5 parameter:true category:"Level 2";

	int lvl2_store_6_no_tenants <- 5 parameter:true category:"Level 2";

	int lvl2_store_7_no_tenants <- 5 parameter:true category:"Level 2";
	
	int lvl2_store_8_no_tenants <- 5 parameter:true category:"Level 2";
	
	int lvl2_store_9_no_tenants <- 5 parameter:true category:"Level 2";
	
	int lvl2_store_10_no_tenants <- 5 parameter:true category:"Level 2";
	
	int lvl2_store_11_no_tenants <- 5 parameter:true category:"Level 2";
	
	int lvl2_store_12_no_tenants <- 5 parameter:true category:"Level 2";
	
	
	
	list no_of_tenants_per_store_lvl2 <- [
		lvl2_store_0_no_tenants,
		lvl2_store_1_no_tenants,
		lvl2_store_2_no_tenants,
		lvl2_store_3_no_tenants,
		lvl2_store_4_no_tenants,
		lvl2_store_5_no_tenants,
		lvl2_store_6_no_tenants,
		lvl2_store_7_no_tenants,
		lvl2_store_8_no_tenants,
		lvl2_store_9_no_tenants,
		lvl2_store_10_no_tenants,
		lvl2_store_11_no_tenants,
		lvl2_store_12_no_tenants
		
	];
	
	list<point> store_text_location_2 <-[
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0}
		
	];
	
////////////////////////////////////////// LEVEL 2 //////////////////////////////////////////

////////////////////////////////////////// LEVEL 3 //////////////////////////////////////////
	// visualisation of layout for lvl 1
	shape_file free_spaces_3_shape_file <- shape_file("../includes/vidacity_shapes/floor_3_outerwall.shp");
	
	// store blocks
	file store_floor_3_file <- file("../includes/vidacity_shapes/floor_3_blockdict.shp");
	
	// routes for lvl 1
	shape_file pedestrian_paths_floor_3_shape_file <- shape_file("../includes/vidacity_shapes/floor_3_path_segments.shp");

	// store boundaries for lvl 1
	file wall_floor_3_shapefile <- file("../includes/vidacity_shapes/floor_3_tenant_lines.shp");
	
	//bin locations for lvl 1
	file bin_location_floor_3 <- file("../includes/vidacity_shapes/floor_3_bins.shp");
	
	// tenant spawn location for lvl 1
	file agent_spawn_locations_floor_3 <- file("../includes/vidacity_shapes/floor_3_agent.shp");
	


	// For 7 stores on level 2:
	
	int lvl3_store_0_no_tenants <- 5 parameter:true category:"Level 3";

	int lvl3_store_1_no_tenants <- 5 parameter:true category:"Level 3"; // current issue is it doesnt create agents specific to each store initialised

	int lvl3_store_2_no_tenants <- 5 parameter:true category:"Level 3";
	
	int lvl3_store_3_no_tenants <- 5 parameter:true category:"Level 3";
	
	int lvl3_store_4_no_tenants <- 5 parameter:true category:"Level 3";

	int lvl3_store_5_no_tenants <- 5 parameter:true category:"Level 3";

	int lvl3_store_6_no_tenants <- 5 parameter:true category:"Level 3";


	

	
	list no_of_tenants_per_store_lvl3 <- [
		lvl2_store_0_no_tenants,
		lvl2_store_1_no_tenants,
		lvl2_store_2_no_tenants,
		lvl2_store_3_no_tenants,
		lvl2_store_4_no_tenants,
		lvl2_store_5_no_tenants,
		lvl2_store_6_no_tenants
	];
	
	list<point> store_text_location_3 <-[
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0}
		
	];
	
////////////////////////////////////////// LEVEL 3 //////////////////////////////////////////

////////////////////////////////////////// LEVEL 4//////////////////////////////////////////
	// visualisation of layout for lvl 1
	shape_file free_spaces_4_shape_file <- shape_file("../includes/vidacity_shapes/floor_4_outerwall.shp");
	
	// store blocks
	file store_floor_4_file <- file("../includes/vidacity_shapes/floor_4_blockdict.shp");
	
	// routes for lvl 1
	shape_file pedestrian_paths_floor_4_shape_file <- shape_file("../includes/vidacity_shapes/floor_4_path_segments.shp");

	// store boundaries for lvl 1
	file wall_floor_4_shapefile <- file("../includes/vidacity_shapes/floor_4_tenant_lines.shp");
	
	//bin locations for lvl 1
	file bin_location_floor_4 <- file("../includes/vidacity_shapes/floor_4_bins.shp");
	
	// tenant spawn location for lvl 1
	file agent_spawn_locations_floor_4 <- file("../includes/vidacity_shapes/floor_4_agent.shp");
	


	// For 4 stores on level 2:
	
	int lvl4_store_0_no_tenants <- 5 parameter:true category:"Level 4";

	int lvl4_store_1_no_tenants <- 5 parameter:true category:"Level 4"; // current issue is it doesnt create agents specific to each store initialised

	int lvl4_store_2_no_tenants <- 5 parameter:true category:"Level 4";
	
	int lvl4_store_3_no_tenants <- 5 parameter:true category:"Level 4";
	
	
	list no_of_tenants_per_store_lvl4 <- [
		lvl2_store_0_no_tenants,
		lvl2_store_1_no_tenants,
		lvl2_store_2_no_tenants,
		lvl2_store_3_no_tenants

	];
	
	list<point> store_text_location_4 <-[
		{0,0,0},
		{0,0,0},
		{0,0,0},
		{0,0,0}
		
	];
	
////////////////////////////////////////// LEVEL 4 //////////////////////////////////////////

 	list total_tenant_list <- 
 		no_of_tenants_per_store_lvl1 +
 		no_of_tenants_per_store_lvl2 +
 		no_of_tenants_per_store_lvl3 +
 		no_of_tenants_per_store_lvl4
 	;
 	
 	list total_store_text_loc_list <-
 		store_text_location_1 +
 		store_text_location_2 +
 		store_text_location_3 +
 		store_text_location_4
 	;
 	
	
    // Graph for navigation
    graph pedestrian_network_1;
    graph pedestrian_network_2;
    graph pedestrian_network_3;
    graph pedestrian_network_4;
    
    list<graph> pedestrian_network_list;
    
   
	
    
    ///////////////////////    NHPP    /////////////////////    NHPP    /////////////////////    NHPP    /////////////////////
    
    int T <- 82800; // 1380 ; // set to 24 hours (23 because 0 is coutned), total time for process to run
    list event_times_this_period;
    list current_cumulative_trash;
    list intensity_values_over_time;
    float cumulative_one_day;
    
    
    ///////////////////////    NHPP    /////////////////////    NHPP    /////////////////////    NHPP    /////////////////////
    
    

    init {
    	
    	
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
		
		
		
		
    	
    	// create path for tenants
	    create pedestrian_path from: pedestrian_paths_floor_1_shape_file with:(
	    	floor_no:1
	    	
	    ){
	    	pedestrian_network_1 <- as_edge_graph(self);
	    }
	    
	    create pedestrian_path from: pedestrian_paths_floor_2_shape_file with:(
	    	floor_no:2
	    ){
	    	pedestrian_network_2 <- as_edge_graph(self);
	    }
	    create pedestrian_path from: pedestrian_paths_floor_3_shape_file with:(
	    	floor_no:3
	    ){
	    	pedestrian_network_3 <- as_edge_graph(self);
	    }
	    create pedestrian_path from: pedestrian_paths_floor_4_shape_file with:(
	    	floor_no:4
	    ){
	    	pedestrian_network_4 <- as_edge_graph(self);
	    }
	   
	    
//	    ask pedestrian_path{
//	    	if (self.floor_no = 1){
//	    		pedestrian_network_1 <- as_edge_graph(self);
//	    		}
//	    	
//	    }
//	    
//	    ask pedestrian_path{
//	    	if (self.floor_no = 2){
//	    		pedestrian_network_2 <- as_edge_graph(self);
//	    		}
//	    	
//	    }
//	    
//	    ask pedestrian_path{
//	    	if (self.floor_no = 3){
//	    		pedestrian_network_3 <- as_edge_graph(self);
//	    		}
//	    	
//	    }
//	    
//	    ask pedestrian_path{
//	    	if (self.floor_no = 4){
//	    		pedestrian_network_4 <- as_edge_graph(self);
//	    		}
//	    	
//	    }
	    
		
		pedestrian_network_list <- [
			pedestrian_network_1,
			pedestrian_network_2,
			pedestrian_network_3,
			pedestrian_network_4
		];
		
//		write"peddy network L " + length(pedestrian_network_list);
		
		
 
 ////////////////////////////////////////// LEVEL 1 //////////////////////////////////////////
    	    	    	
        // Create obstacles
        create obstacle from: wall_floor_1_shapefile{
        	floor_no <- 1;
        }
        
        create vida_lvl_layout_1 from: free_spaces_1_shape_file;

				
		create bin from: bin_location_floor_1{
			floor_no <- 1;
            current_capacity <- 0.0;
            // set at 45L (450 units)
            max_capacity <- 30.0; //originally 45
            // set by slider, else 0.6 & 0.9
            ReadyToClear_capacity <- ReadyToClear_multiplier * max_capacity;
			AboutToBeFull_capacity<- AboutToBeFull_multiplier * max_capacity;
            ask central_bin{
            	myself.distance_to_central_bin <- self.location distance_to myself.location;
            }
		}
		
		
		create store from: agent_spawn_locations_floor_1 with: (
			floor_file:store_floor_1_file,
			floor_no:1,
			tenant_store_list:total_tenant_list,
			text_loc_list:total_store_text_loc_list
			
		);
		
		
		
		create store_floor from: store_floor_1_file with:(
			floor_no:1
		);
		
		
////////////////////////////////////////// LEVEL 1 //////////////////////////////////////////
////////////////////////////////////////// LEVEL 2 //////////////////////////////////////////
    	    	    	
        // Create obstacles
        create obstacle from: wall_floor_2_shapefile{
        	floor_no <- 2;
        }
        
        create vida_lvl_layout_2 from: free_spaces_2_shape_file;

				
		create bin from: bin_location_floor_2{
			floor_no <- 2;
            current_capacity <- 0.0;
            // set at 45L (450 units)
            max_capacity <- 30.0; //originally 45
            // set by slider, else 0.6 & 0.9
            ReadyToClear_capacity <- ReadyToClear_multiplier * max_capacity;
			AboutToBeFull_capacity<- AboutToBeFull_multiplier * max_capacity;
            ask central_bin{
            	myself.distance_to_central_bin <- self.location distance_to myself.location;
            }
		}
		
		
		
		
		create store from: agent_spawn_locations_floor_2 with: (
			floor_file:store_floor_2_file,
			floor_no:2,
			tenant_store_list:total_tenant_list,
			text_loc_list:total_store_text_loc_list
			
		);
		
		
		
		create store_floor from: store_floor_2_file with:(
			floor_no:2
		);
		
////////////////////////////////////////// LEVEL 2 //////////////////////////////////////////
////////////////////////////////////////// LEVEL 3 //////////////////////////////////////////
    	    	    	
        // Create obstacles
        create obstacle from: wall_floor_3_shapefile{
        	floor_no <- 3;
        }
        
        create vida_lvl_layout_3 from: free_spaces_3_shape_file;

				
		create bin from: bin_location_floor_3{
			floor_no <- 3;
            current_capacity <- 0.0;
            // set at 45L (450 units)
            max_capacity <- 30.0; //originally 45
            // set by slider, else 0.6 & 0.9
            ReadyToClear_capacity <- ReadyToClear_multiplier * max_capacity;
			AboutToBeFull_capacity<- AboutToBeFull_multiplier * max_capacity;
            ask central_bin{
            	myself.distance_to_central_bin <- self.location distance_to myself.location;
            }
		}
		
		
		create store from: agent_spawn_locations_floor_3 with: (
			floor_file:store_floor_3_file,
			floor_no:3,
			tenant_store_list:total_tenant_list,
			text_loc_list:total_store_text_loc_list
			
		);
		
		create store_floor from: store_floor_3_file with:(
			floor_no:3
		);
		
////////////////////////////////////////// LEVEL 3 //////////////////////////////////////////
////////////////////////////////////////// LEVEL 4 //////////////////////////////////////////
    	    	    	
        // Create obstacles
        create obstacle from: wall_floor_4_shapefile{
        	floor_no <- 4;
        }
        
        create vida_lvl_layout_4 from: free_spaces_4_shape_file;

				
		create bin from: bin_location_floor_4{
			floor_no <- 4;
            current_capacity <- 0.0;
            // set at 45L (450 units)
            max_capacity <- 30.0; //originally 45
            // set by slider, else 0.6 & 0.9
            ReadyToClear_capacity <- ReadyToClear_multiplier * max_capacity;
			AboutToBeFull_capacity<- AboutToBeFull_multiplier * max_capacity;
            ask central_bin{
            	myself.distance_to_central_bin <- self.location distance_to myself.location;
            }
		}
		
		
		create store from: agent_spawn_locations_floor_4 with: (
			floor_file:store_floor_4_file,
			floor_no:4,
			tenant_store_list:total_tenant_list,
			text_loc_list:total_store_text_loc_list
			
		);
		
		create store_floor from: store_floor_4_file with:(
			floor_no:4
		);
		
////////////////////////////////////////// LEVEL 4 //////////////////////////////////////////

 		
    }
    
}


// Create central rubbish bin agent
species central_bin{
	
	aspect default {
		draw square(15) color: #cadetblue depth: 15;
	}
	
}

// Species for pedestrian paths
species pedestrian_path skills: [pedestrian_road] {
	int floor_no;
	
    
    aspect floor_1 {
 		if floor_no = 1{
 			draw shape color: #gray;
 		}
    }
    
    aspect floor_2 {
 		if floor_no = 2{
 			draw shape color: #gray;
 		}
    }
    
    aspect floor_3 {
 		if floor_no = 3{
 			draw shape color: #gray;
 		}
    }
    
    aspect floor_4 {
 		if floor_no = 4{
 			draw shape color: #gray;
 		}
    }
}

// Species for vidacity_lvl_1_outline
species vida_lvl_layout_1 {
    aspect default {
        draw shape color: #gray border: #black at:{location.x,location.y,location.z-0.1} perspective:false;
    }
}

species vida_lvl_layout_2 {
    aspect default {
        draw shape color: #gray border: #black at:{location.x,location.y,location.z-0.1} perspective:false;
    }
}

species vida_lvl_layout_3 {
    aspect default {
        draw shape color: #gray border: #black at:{location.x,location.y,location.z-0.1} perspective:false;
    }
}

species vida_lvl_layout_4 {
    aspect default {
        draw shape color: #gray border: #black at:{location.x,location.y,location.z-0.1} perspective:false;
    }
}

// Species for obstacles
species obstacle {
	int floor_no;

	aspect floor_1 {
		if floor_no = 1{
			draw shape + (0.45/2.0) color: #black depth: 10;
		}
	}
	aspect floor_2 {
		if floor_no = 2{
			draw shape + (0.45/2.0) color: #black depth: 10;
		}
	}
	aspect floor_3 {
		if floor_no = 3{
			draw shape + (0.45/2.0) color: #black depth: 10;
		}
	}
	aspect floor_4 {
		if floor_no = 4{
			draw shape + (0.45/2.0) color: #black depth: 10;
		}
	}
}

species store_floor {
	int floor_no;
	
	aspect floor_1 {
		if floor_no = 1{
			draw shape color: #orange;
		}
	}
	aspect floor_2 {
		if floor_no = 2{
			draw shape color: #orange;
		}
	}
	aspect floor_3 {
		if floor_no = 3{
			draw shape color: #orange;
		}
	}
	aspect floor_4 {
		if floor_no = 4{
			draw shape color: #orange;
		}
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
	int bin_width <- 6;
	int bin_displayTextSize <- displayTextSize - 2;
	int floor_no;
	
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
	
    
    aspect floor_1 {
		if floor_no = 1{
			draw square(bin_width) color: bin_color depth: bin_width;
		draw ("Bin " + self.index) color:#black size:bin_displayTextSize at:{location.x-3,location.y+bin_width*2} font:agent_font perspective:true;
		draw ("Fill: " + round(current_capacity*100)/100)  color:#black size:bin_displayTextSize font:agent_font at:{location.x-3,location.y+bin_width*2+bin_displayTextSize*2} perspective:true;
		}
	}
	aspect floor_2 {
		if floor_no = 2{
			draw square(bin_width) color: bin_color depth: bin_width;
		draw ("Bin " + self.index) color:#black size:bin_displayTextSize at:{location.x-3,location.y+bin_width*2} font:agent_font perspective:true;
		draw ("Fill: " + round(current_capacity*100)/100)  color:#black size:bin_displayTextSize font:agent_font at:{location.x-3,location.y+bin_width*2+bin_displayTextSize*2} perspective:true;
		}
	}
	aspect floor_3 {
		if floor_no = 3{
			draw square(bin_width) color: bin_color depth: bin_width;
		draw ("Bin " + self.index) color:#black size:bin_displayTextSize at:{location.x-3,location.y+bin_width*2} font:agent_font perspective:true;
		draw ("Fill: " + round(current_capacity*100)/100)  color:#black size:bin_displayTextSize font:agent_font at:{location.x-3,location.y+bin_width*2+bin_displayTextSize*2} perspective:true;
		}
	}
	aspect floor_4 {
		if floor_no = 4{
			draw square(bin_width) color: bin_color depth: bin_width;
		draw ("Bin " + self.index) color:#black size:bin_displayTextSize at:{location.x-3,location.y+bin_width*2} font:agent_font perspective:true;
		draw ("Fill: " + round(current_capacity*100)/100)  color:#black size:bin_displayTextSize font:agent_font at:{location.x-3,location.y+bin_width*2+bin_displayTextSize*2} perspective:true;
		}
	}
}

species store{
	list text_loc_list;
	point text_loc <- (text_loc_list at self.index);
	list tenant_store_list;
	int tenant_no <- (tenant_store_list at self.index);
	list<agent> tenants_in_store;
	int current_tenants_in_store;
	float store_bin <- 0.0;
	float store_bin_clear_threshold <- 3.0;
	int store_size <- 20;
	int floor_no;
	file floor_file;
	geometry store_area <- rectangle({location.x-(store_size/2),location.y-(store_size/2)}, {location.x+(store_size/2),location.y+(store_size/2)});
	geometry spawn_pts <- (pedestrian_network_list at (floor_no-1)) first_with (each intersects store_area and any(floor_file) covers (each));
	init{
		
		
		write"SPAWN POINTS: " + spawn_pts;
		
		write "my tenant nummber is: " + tenant_no;
		
		create people number:tenant_no{
				name <- ("Tenant " + host.index + "." + self.index);
				location <- any_location_in(spawn_pts);
//				write "Tenant location at: " + location;
	    		has_trash <- false;
	    		trash_on_hand<- 0.0;
	        	home_base <- location;
//	        	write name + " is hosted by " + host;
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
	
	
	aspect floor_1 {
		if floor_no = 1{
			draw square(store_size) color: #burlywood at:{location.x,location.y, location.z-1} ;
			draw ("Store " + self.index + ": " + current_tenants_in_store + "/" + tenant_no ) font:agent_font color:#black size:displayTextSize at:{text_loc.x+5,text_loc.y+5+displayTextSize} perspective:true;
			draw ("Fill: " + string(round(store_bin*100)/100)) + "/" + store_bin_clear_threshold color: #black font:agent_font size: displayTextSize at: {text_loc.x +5 ,text_loc.y +20} perspective:true;
		}
	}
	aspect floor_2 {
		if floor_no = 2{
			draw square(store_size) color: #burlywood at:{location.x,location.y, location.z-1} ;
			draw ("Store " + self.index + ": " + current_tenants_in_store + "/" + tenant_no ) font:agent_font color:#black size:displayTextSize at:{text_loc.x+5,text_loc.y+5+displayTextSize} perspective:true;
			draw ("Fill: " + string(round(store_bin*100)/100)) + "/" + store_bin_clear_threshold color: #black font:agent_font size: displayTextSize at: {text_loc.x +5 ,text_loc.y +20} perspective:true;
		}
	}
	aspect floor_3 {
		if floor_no = 3{
			draw square(store_size) color: #burlywood at:{location.x,location.y, location.z-1} ;
			draw ("Store " + self.index + ": " + current_tenants_in_store + "/" + tenant_no ) font:agent_font color:#black size:displayTextSize at:{text_loc.x+5,text_loc.y+5+displayTextSize} perspective:true;
			draw ("Fill: " + string(round(store_bin*100)/100)) + "/" + store_bin_clear_threshold color: #black font:agent_font size: displayTextSize at: {text_loc.x +5 ,text_loc.y +20} perspective:true;
		}
	}
	aspect floor_4 {
		if floor_no = 4{
			draw square(store_size) color: #burlywood at:{location.x,location.y, location.z-1} ;
			draw ("Store " + self.index + ": " + current_tenants_in_store + "/" + tenant_no ) font:agent_font color:#black size:displayTextSize at:{text_loc.x+5,text_loc.y+5+displayTextSize} perspective:true;
			draw ("Fill: " + string(round(store_bin*100)/100)) + "/" + store_bin_clear_threshold color: #black font:agent_font size: displayTextSize at: {text_loc.x +5 ,text_loc.y +20} perspective:true;
		}
	}
	




	// Species for people with pedestrian skill
	species people skills: [pedestrian]{
		
		
		float trash_generation_lambda;
		float trash_on_hand;
	    
	    rgb color <- rnd_color(255);
	    float speed <- 3 #km/#h; //0.05 #km/#h; //should be 4km/h irl, this is just for visualisation
	    bin target_bin;
	    point current_target;
	    point home_base;
		path path_to_bin;
		int len_path_to_bin;
		bool has_trash;
		int floor_no <- host.floor_no;
		int indice_selector <- floor_no-1;
		list<bin> same_floor_bin_list;
		
		
	    
	 
		
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
	    float base_rate <- 0.002704/60;
	    float amp1 <- 0.017833/60;
	    float center1 <- 690*60.0;
	    float amp2 <- 0.012104/60.0;
	    float center2 <- 870*60.0;
	    float fixed_width <- 60*60.0;
//	
//	    
//	    //	h1 = h2
//	    float base_rate <- 0.002280;
//	    float amp1 <- 0.018793;
//	    int center1 <- 690;
//	    float amp2 <- 0.018793;
//	    int center2 <- 870;
//	    int fixed_width <- 60;
		float lambda_t (float t) {
    	
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
    	
    	reflex print_time when: every(60#cycle){
    		
    	}
    	
    	
    	
    	action create_trash {
    		int t <- (cycle mod T);
    		float intensity_at_t <- lambda_t(cycle mod T);
	        float candidate <- rnd(0.0,1.0);
	        float acceptance_prob <- 1-exp((-1)*(intensity_at_t)); //intensity_at_t / lambda_max;
	        if (candidate < acceptance_prob) { 
	               trash_generated_now <- gauss(mean_trash_amount, sd_trash_amount);
	               write "Current time is: " + t /3600 + " (hours)";	
    		}
    		else{
    			trash_generated_now <- 0.0;
    		}
    	}
	    
    ///////////////////////   END NHPP    /////////////////////   END NHPP    /////////////////////   END NHPP    /////////////////////
		
		
		
	    
	    // Find target bin if none is set and if the agent has trash
	    action search_target {
	    	ask bin{
	    		if self.floor_no = myself.floor_no{
	    			myself.same_floor_bin_list <- myself.same_floor_bin_list + self;
	    		}
	    	}
			ask self.same_floor_bin_list closest_to(self) {
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
	           do goto (target: home_base, on: pedestrian_network_list at indice_selector);
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
	            do goto (target: target_bin.location, on: pedestrian_network_list at indice_selector);
	//			  do goto (target: target_bin.location);
	            
	            
			}
	     }
	    		
	    }
	    	
	   
	    aspect floor_1 {
			if floor_no = 1{
				if has_trash{
					draw (string("Trash on-hand: " + round(trash_on_hand*100)/100)) font:agent_font color:#black size:displayTextSize at:{location.x-10,location.y+displayTextSize*4} perspective:true; 
		    	}
		        
		        draw triangle(6) color: color rotate: heading + 90.0 depth: 6;
		        
		        if (current_path != nil) {
					draw current_path.shape color: #red;
				}
			}
		}
		aspect floor_2 {
			if floor_no = 2{
				if has_trash{
					draw (string("Trash on-hand: " + round(trash_on_hand*100)/100)) font:agent_font color:#black size:displayTextSize at:{location.x-10,location.y+displayTextSize*4} perspective:true; 
		    	}
		        
		        draw triangle(6) color: color rotate: heading + 90.0 depth: 6;
		        
		        if (current_path != nil) {
					draw current_path.shape color: #red;
				}
			}
		}
		aspect floor_3 {
			if floor_no = 3{
				if has_trash{
					draw (string("Trash on-hand: " + round(trash_on_hand*100)/100)) font:agent_font color:#black size:displayTextSize at:{location.x-10,location.y+displayTextSize*4} perspective:true; 
		    	}
		        
		        draw triangle(6) color: color rotate: heading + 90.0 depth: 6;
		        
		        if (current_path != nil) {
					draw current_path.shape color: #red;
				}
			}
		}
		aspect floor_4 {
			if floor_no = 4{
				if has_trash{
					draw (string("Trash on-hand: " + round(trash_on_hand*100)/100)) font:agent_font color:#black size:displayTextSize at:{location.x-10,location.y+displayTextSize*4} perspective:true; 
		    	}
		        
		        draw triangle(6) color: color rotate: heading + 90.0 depth: 6;
		        
		        if (current_path != nil) {
					draw current_path.shape color: #red;
				}
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
	float speed <- 3 #km/#h; //0.0666 #km/#h; //should be 3km/h irl, this is just for visualisation
    bool return_to_rest <- false;
    point central_bin_location;
    bin bin_to_clean;
	list<bin> readyBins <- [];
	list<bin> BinsAboutToBeFull <- [];
	list<bin> bins_to_clean_order;
	list<point> route <- [resting_location];
	list<float> distance;
	float total_time_travelled; //in seconds
	int current_floor_no <- 1;
	int indice_selector <- current_floor_no-1;
	
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
//	 		write" ready count is: " + readyCount + "and BinsAboutToBeFull is: " + BinsAboutToBeFull;
	 		trigger <- true;
	 		check <- false;
	 		do trigger_clean;
	 		
	 	}
	 	else if ((self.location distance_to resting_location) > 0.1){
	 		
			do goto (target:resting_location, on:indice_selector);
			total_time_travelled <- total_time_travelled + 1;
	 		
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
		write "Length of bins to clear: " + length(bins_to_clean_order);
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
		//
		total_time_travelled <- total_time_travelled + 1;
        
        if (length(bins_to_clean_order) > 0 and location distance_to (bins_to_clean_order at 0) > 0.01){
        	bin_to_clean <- bins_to_clean_order at 0;
//			write "Cleaning " + bin_to_clean + "now!";
        	do goto (target:bin_to_clean, on:indice_selector);
        }
        
        // once first bin in the list has been reached
        else if (length(bins_to_clean_order) > 0){
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
					do goto (target:central_bin_location, on:indice_selector);
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
	
	
    aspect floor_1 {
		if current_floor_no = 1{
			draw circle(6) color: is_cleaning ? #green : #gray depth: 6;
       		draw string(trash_on_hand) color:#black size:(displayTextSize) font:agent_font at:{location.x,location.y+(displayTextSize)} perspective:false;
		}
	}
	aspect floor_2 {
		if current_floor_no = 2{
			draw circle(6) color: is_cleaning ? #green : #gray depth: 6;
        	draw string(trash_on_hand) color:#black size:(displayTextSize) font:agent_font at:{location.x,location.y+(displayTextSize)} perspective:false;
		}
	}
	aspect floor_3 {
		if current_floor_no = 3{
			draw circle(6) color: is_cleaning ? #green : #gray depth: 6;
        	draw string(trash_on_hand) color:#black size:(displayTextSize) font:agent_font at:{location.x,location.y+(displayTextSize)} perspective:false;
		}
	}
	aspect floor_4 {
		if current_floor_no = 4{
			draw circle(6) color: is_cleaning ? #green : #gray depth: 6;
        	draw string(trash_on_hand) color:#black size:(displayTextSize) font:agent_font at:{location.x,location.y+(displayTextSize)} perspective:false;
		}
	}
    
}






experiment pedestrian_navigation type: gui {
    float minimum_cycle_duration <- 0.000001;
	parameter "Ready-to-clear Threshold" category:"Waste Bin Thresholds" var: ReadyToClear_multiplier min: 0.0  max: 1.0 step: 0.05 ;
	parameter "About-to-be-full Threshold" category:"Waste Bin Thresholds" var: AboutToBeFull_multiplier min: 0.0  max: 1.0 step: 0.05;
//	text string("Total number of complaints: ")  category: "Success Metrics" color: #white background: #black font: font("Helvetica",14,#bold); 
//	parameter "Float (with on_change listener)" category:"Success Metrics" var: total_complaints {write ""+total_complaints;}
	
		
    	
    output {
    	
//    	monitor "TOTAL COMPLAINTS" value: total_complaints refresh: every(step);
//    	monitor "ACUMULATED TIME OF BINS OVERFLOWED (MINS): " value: total_time_bin_overflowed/60 refresh: every(step);

        display vidacity_lvl_1 type: opengl {
        	
        	// Legend 
             overlay position: { 20, 20 } size: { 1200 #px, 220 #px } background: # gray transparency: 0 border: #black rounded: true
            {
                float y <- 30#px;
                
                    draw "Legend" at: {20#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
                    draw "Failure Metrics" at: {285#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
                    y <- y + 30#px;
					
					// tenant
                    draw triangle(25#px) at: { 30#px, y } color: #red border: #white;
                    draw "Tenant" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
                	draw ("TOTAL COMPLAINTS: " + total_complaints)  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
                    
                    y <- y + 40#px;
                    
                    // Central bin
                    draw square(25#px) at: { 30#px, y } color: #cadetblue border: #white;
                    draw "Central Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
                	draw ("ACUMULATED TIME OF BINS OVERFLOWED (MINS): " + total_time_bin_overflowed/60)  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
                    
                    y <- y + 40#px;
                    
                    // Floor's bin
                    draw square(25#px) at: { 30#px, y } color: #green border: #white;
                    draw "Floor's Trash Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
                    ask cleaner{                	
                    	draw ("CLEANER DISTANCE TRAVELLED: " + (self.total_time_travelled/3600*self.speed*1000) + "m")  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
                    }
                    
                    y <- y + 40#px;
                    
                    // Cleaner
                    draw circle(12.5#px) at: { 30#px, y } color: #gray border: #white;
                    draw "Cleaner" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
                    y <- y + 40#px;

            }
            

            
        	
    		species pedestrian_path aspect:floor_1 transparency: 0.5;
            	
            species bin aspect: floor_1;
            
            species cleaner aspect: floor_1;
            species central_bin aspect: default;
            

            species obstacle aspect: floor_1 transparency: 0.80;
            
            species store aspect: floor_1 {
				species people aspect: floor_1;
	
			}
            	
            species store_floor aspect: floor_1 transparency: 0.8;
            species vida_lvl_layout_1 transparency: 0.88;
            
            }
            
//             display vidacity_lvl_2 type: opengl {
//        	
//        	// Legend 
//             overlay position: { 20, 20 } size: { 1200 #px, 220 #px } background: # gray transparency: 0 border: #black rounded: true
//            {
//                float y <- 30#px;
//                
//                    draw "Legend" at: {20#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
//                    draw "Failure Metrics" at: {285#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
//                    y <- y + 30#px;
//					
//					// tenant
//                    draw triangle(25#px) at: { 30#px, y } color: #red border: #white;
//                    draw "Tenant" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                	draw ("TOTAL COMPLAINTS: " + total_complaints)  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    
//                    y <- y + 40#px;
//                    
//                    // Central bin
//                    draw square(25#px) at: { 30#px, y } color: #cadetblue border: #white;
//                    draw "Central Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                	draw ("ACUMULATED TIME OF BINS OVERFLOWED (MINS): " + total_time_bin_overflowed/60)  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    
//                    y <- y + 40#px;
//                    
//                    // Floor's bin
//                    draw square(25#px) at: { 30#px, y } color: #green border: #white;
//                    draw "Floor's Trash Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    ask cleaner{                	
//                    	draw ("CLEANER DISTANCE TRAVELLED: " + (self.total_time_travelled/3600*self.speed*1000) + "m")  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    }
//                    
//                    y <- y + 40#px;
//                    
//                    // Cleaner
//                    draw circle(12.5#px) at: { 30#px, y } color: #gray border: #white;
//                    draw "Cleaner" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    y <- y + 40#px;
//
//            }
//            
//
//            
//        	
//    		species pedestrian_path aspect:floor_2 transparency: 0.5;
//            	
//            species bin aspect: floor_2;
//            
////            species cleaner aspect: floor_2;
////            species central_bin aspect: default;
//            
//
//            species obstacle aspect: floor_2 transparency: 0.80;
//            
//            species store aspect: floor_2 {
//				species people aspect: floor_2;
//	
//			}
//            	
//            species store_floor aspect: floor_2 transparency: 0.8;
//            species vida_lvl_layout_2 transparency: 0.88;
//            
//            }
//            
//             display vidacity_lvl_3 type: opengl {
//        	
//        	// Legend 
//             overlay position: { 20, 20 } size: { 1200 #px, 220 #px } background: # gray transparency: 0 border: #black rounded: true
//            {
//                float y <- 30#px;
//                
//                    draw "Legend" at: {20#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
//                    draw "Failure Metrics" at: {285#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
//                    y <- y + 30#px;
//					
//					// tenant
//                    draw triangle(25#px) at: { 30#px, y } color: #red border: #white;
//                    draw "Tenant" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                	draw ("TOTAL COMPLAINTS: " + total_complaints)  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    
//                    y <- y + 40#px;
//                    
//                    // Central bin
//                    draw square(25#px) at: { 30#px, y } color: #cadetblue border: #white;
//                    draw "Central Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                	draw ("ACUMULATED TIME OF BINS OVERFLOWED (MINS): " + total_time_bin_overflowed/60)  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    
//                    y <- y + 40#px;
//                    
//                    // Floor's bin
//                    draw square(25#px) at: { 30#px, y } color: #green border: #white;
//                    draw "Floor's Trash Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    ask cleaner{                	
//                    	draw ("CLEANER DISTANCE TRAVELLED: " + (self.total_time_travelled/3600*self.speed*1000) + "m")  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    }
//                    
//                    y <- y + 40#px;
//                    
//                    // Cleaner
//                    draw circle(12.5#px) at: { 30#px, y } color: #gray border: #white;
//                    draw "Cleaner" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    y <- y + 40#px;
//
//            }
//            
//
//            
//        	
//    		species pedestrian_path aspect:floor_3 transparency: 0.5;
//            	
//            species bin aspect: floor_3;
//            
////            species cleaner aspect: floor_3;
////            species central_bin aspect: default;
//            
//
//            species obstacle aspect: floor_3 transparency: 0.80;
//            
//            species store aspect: floor_3 {
//				species people aspect: floor_3;
//	
//			}
//            	
//            species store_floor aspect: floor_3 transparency: 0.8;
//            species vida_lvl_layout_3 transparency: 0.88;
//            
//            }
//            
//            display vidacity_lvl_4 type: opengl {
//        	
//        	// Legend 
//             overlay position: { 20, 20 } size: { 1200 #px, 220 #px } background: # gray transparency: 0 border: #black rounded: true
//            {
//                float y <- 30#px;
//                
//                    draw "Legend" at: {20#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
//                    draw "Failure Metrics" at: {285#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
//                    y <- y + 30#px;
//					
//					// tenant
//                    draw triangle(25#px) at: { 30#px, y } color: #red border: #white;
//                    draw "Tenant" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                	draw ("TOTAL COMPLAINTS: " + total_complaints)  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    
//                    y <- y + 40#px;
//                    
//                    // Central bin
//                    draw square(25#px) at: { 30#px, y } color: #cadetblue border: #white;
//                    draw "Central Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                	draw ("ACUMULATED TIME OF BINS OVERFLOWED (MINS): " + total_time_bin_overflowed/60)  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    
//                    y <- y + 40#px;
//                    
//                    // Floor's bin
//                    draw square(25#px) at: { 30#px, y } color: #green border: #white;
//                    draw "Floor's Trash Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    ask cleaner{                	
//                    	draw ("CLEANER DISTANCE TRAVELLED: " + (self.total_time_travelled/3600*self.speed*1000) + "m")  at: { 285#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    }
//                    
//                    y <- y + 40#px;
//                    
//                    // Cleaner
//                    draw circle(12.5#px) at: { 30#px, y } color: #gray border: #white;
//                    draw "Cleaner" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    y <- y + 40#px;
//
//            }
//            
//
//            
//        	
//    		species pedestrian_path aspect:floor_4 transparency: 0.5;
//            	
//            species bin aspect: floor_4;
//            
////            species cleaner aspect: floor_4;
////            species central_bin aspect: default;
//            
//
//            species obstacle aspect: floor_4 transparency: 0.80;
//            
//            species store aspect: floor_4 {
//				species people aspect: floor_4;
//	
//			}
//            	
//            species store_floor aspect: floor_4 transparency: 0.8;
//            species vida_lvl_layout_4 transparency: 0.88;
//            
//            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
//             display vidacity_lvl_2 type: opengl {
//        	
//        	// Legend 
//             overlay position: { 20, 20 } size: { 1200 #px, 220 #px } background: # gray transparency: 0 border: #black rounded: true
//            {
//                float y <- 30#px;
//                
//                    draw "Legend" at: {20#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
//                    draw "Failure Metrics" at: {280#px, y + 3#px } color: # white font: font("Helvetica", 28, #bold  #italic);
//                    y <- y + 30#px;
//					
//					// tenant
//                    draw triangle(25#px) at: { 30#px, y } color: #red border: #white;
//                    draw "Tenant" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                	draw ("TOTAL COMPLAINTS: " + total_complaints)  at: { 280#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    
//                    y <- y + 40#px;
//                    
//                    // Central bin
//                    draw square(25#px) at: { 30#px, y } color: #cadetblue border: #white;
//                    draw "Central Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                	draw ("ACUMULATED TIME OF BINS OVERFLOWED (MINS): " + total_time_bin_overflowed/60)  at: { 280#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    
//                    y <- y + 40#px;
//                    
//                    // Floor's bin
//                    draw square(25#px) at: { 30#px, y } color: #green border: #white;
//                    draw "Floor's Trash Bin" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    ask cleaner{                	
//                    	draw ("CLEANER DISTANCE TRAVELLED: " + (self.total_time_travelled/3600*self.speed*1000) + "m")  at: { 280#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    }
//                    
//                    y <- y + 40#px;
//                    
//                    // Cleaner
//                    draw circle(12.5#px) at: { 30#px, y } color: #gray border: #white;
//                    draw "Cleaner" at: { 60#px, y + 7#px } color: # white font: font("Helvetica", 25, #bold);
//                    y <- y + 40#px;
//
//            }
//            
//            
//        	
//
//            species pedestrian_path transparency: 0.5;
//            species bin aspect: default;
//            
//            species cleaner aspect: default;
//            species central_bin aspect: default;
//            
//
//            species obstacle transparency: 0.80;
//            
//            species store aspect: default {
//				species people aspect: default;
//	
//			}
//            	
//            species store_floor aspect: default transparency: 0.8;
//            species vida_lvl_1 transparency: 0.88;
//            
//            }

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

