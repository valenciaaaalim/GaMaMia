/**
* Name: NHPPTenant
* Based on the internal empty template. 
* Author: valencia
* Tags: 
*/


model NHPPTenant

/* Insert your model definition here */



global {
    float step <- 1 #minute; 
    int T <- 1380; // set to 24 hours (23 because 0 is coutned), total time for process to run
    list event_times_this_period;
    list current_cumulative_trash;
    list intensity_values_over_time;
    float cumulative_one_day;
    list daily_trash_log;
	
    init {
        create NHPP_function;
    }
}

species NHPP_function {    
	
	float mean_trash_amount <- 0.3;
    float sd_trash_amount <- 0.01;
    

    float trash_generate_now;
    list<float> intensity_values <- []; // stores intensity fn values for visualisation
    
    
    // h1 < h2
    float base_rate <- 0.003083;
    float amp1 <- 0.014778;
    int center1 <- 690;
    float amp2 <- 0.021514;
    int center2 <- 870;
    int fixed_width <- 60;
   

//	// h1 > h2
//    float base_rate <- 0.002704;
//    float amp1 <- 0.017833;
//    int center1 <- 690;
//    float amp2 <- 0.012104;
//    int center2 <- 870;
//    int fixed_width <- 60;
//
//    
//    // h1 = h2
//    float base_rate <- 0.002280;
//    float amp1 <- 0.018793;
//    int center1 <- 690;
//    float amp2 <- 0.018793;
//    int center2 <- 870;
//    int fixed_width <- 60;
 


   float lambda_t (int t) {
    	
    	float intensity <- base_rate;
    	intensity <- intensity + amp1 * exp((-1)*((t-center1)^2)/((2*(fixed_width)^2)));
    	intensity <- intensity + amp2 * exp((-1)*((t-center2)^2)/((2*(fixed_width)^2)));
    	
    	return max(0,intensity);
    	
    }
    
    float lambda_max <- max(lambda_t(center1), lambda_t(center2));
    
    
    // Generate non-homogeneous Poisson process events up to time T (24th hour)
    reflex generate_nhpp when: cycle mod T = 0{ 
    	
    	// reset intensity to see per day function (same result across all days)
        intensity_values_over_time <- [];
    	//reset events to see per day accumulation. remove if want to visualise perday, but in console will be accumulative from start time 0
    	event_times_this_period <- [];
        //reset trash_list to see per day trash distribution (will differ, remove if want to see across different days)
        current_cumulative_trash <- [];	
        //cumulative_trash_over_time <- [];
        
        cumulative_one_day<- 0.0;
       	int number_of_events_this_period <- 0;
        
        loop t from: 0 to: T-1 step: 1 {
        	
        	float intensity_at_t <- lambda_t(t);
        	intensity_values_over_time <- intensity_values_over_time + intensity_at_t; // Store intensity for plotting
       
        	float candidate <- rnd(0.0,1.0);
            float acceptance_prob <- 1-exp((-1)*(intensity_at_t)); //intensity_at_t / lambda_max;
            
     
            if (candidate < acceptance_prob) { 
                    float trash_generated_now <- gauss(mean_trash_amount, sd_trash_amount); //0.3;
	                current_cumulative_trash <- current_cumulative_trash + trash_generated_now;
	                cumulative_one_day <- cumulative_one_day + trash_generated_now;
	                number_of_events_this_period <- number_of_events_this_period + 1;
	                event_times_this_period <- event_times_this_period + t; // Store time if needed
                 	write "Event at t=" + t + ", trash=" + trash_generated_now + ", cumulative=" + current_cumulative_trash;
                 	write "intensity" + intensity_at_t;
            		write "acceptance" + acceptance_prob;
                 	write "Event count today = " + number_of_events_this_period;
            }
            else{
            	current_cumulative_trash <- current_cumulative_trash + 0;
            }
        
        }
        
        daily_trash_log <- daily_trash_log + cumulative_one_day;
        write "Period ended. Cumulative trash events on day " + int(cycle/T) + ": " + number_of_events_this_period; 
        write "Total cumulative trash at end of period: " + cumulative_one_day;
        
        

    }
    
}
        
     
 

experiment Benchmarking type: gui benchmark: true { }


experiment "Non-Homogeneous Poisson" type: gui {
    output {
        display "NHPP Visualization" type: 2d {
            chart "Intensity Function" type: series x_label:"Time (minutes)" y_label:"Intensity (Events per minute)" {
                data "Intensity Profile" value:intensity_values_over_time color: #coral ;
            }
        }
        display "Event Log" type: 2d{
			chart "Trash Generation Event Log Over 24-hours" type: histogram x_label:"Time (minutes)" y_label:"Volume of Trash (Litres)" {
                data "Trash Generation Event Log" value: current_cumulative_trash color: #blue style: spline;
            } 
        }
        display "Trash Log" type: 2d {
            chart "Day-on-day Total Trash Per Tenant" type: series x_label:"Day" y_label:"Volume of Trash (Litres)" {
                data "Daily Total Trash Per Tenant" value: daily_trash_log color: #green ;
            }
        }
   
   }
}
    
    
    