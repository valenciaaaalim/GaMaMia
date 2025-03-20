/**
* Name: NHPPClaude
* Based on the internal empty template. 
* Author: valencia
* Tags: 
*/
//
//
//model NHPPClaude
//
///* Insert your model definition here */
//
//
//
//global {
//    float step <- 1 #hour;
//    
//    float lambda_max <- 12.0;  // Peak intensity approximation
//    float T <- 24.0;           // Full day duration
//    float interval <- 1.0;     // Time interval for expected counts
//    
//    list<float> intensity_values;
//    list<int> time_points <- [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,119,20,21,22,23,24];
//    list<float> events;
//    
//    init {
//        // Generate time points for plotting (hourly intervals)
//        //time_points <- list_with(24, function(i) {return float(i);});
//        
//        // Calculate intensity values for each time point
//        intensity_values <- time_points collect lambda_t(each);
//        
//        // Generate NHPP events
//        do generate_nhpp(T, lambda_max);
//        
//        // Compute statistics
//        write "Generated NHPP Count: " + length(events);
//        if (length(events) > 0) {
//            write "Generated NHPP Mean Time: " + mean(events) + ", Variance: " + variance(events);
//        }
//        
//        // Calculate expected vs. actual counts per interval
//        do calculate_interval_counts();
//    }
//    
//    // Lambda function that returns intensity at time t
//    float lambda_t(float t) {
//        float base_rate <- 1.0;  // Minimum production rate
//        
//        // Using sum of Gaussian-like functions to model trash production peaks
//        float peak1 <- 10.0 * exp(-((t - 12.0) / 2.0) ^ 2);  // Lunch peak around 12 PM
//        float peak2 <- 8.0 * exp(-((t - 18.0) / 2.0) ^ 2);   // Dinner peak around 6 PM
//        float peak3 <- 6.0 * exp(-((t - 22.0) / 2.0) ^ 2);   // Closing peak around 10 PM
//        
//        return base_rate + peak1 + peak2 + peak3;  // Ensure non-negative intensity
//    }
//    
//    // Generate NHPP events
//    action generate_nhpp(float timeStamp, float lambda_m) {
//        float t <- 0.0;
//        
//        // Clear previous events
//        events <- [];
//        
//        while (t < simTime) {
//            float u1 <- rnd(0.0, 1.0);
//            t <- t + (-ln(u1) / lambda_m);  // Generate candidate arrival time
//            
//            if (t < simTime) {
//                float acceptance_prob <- lambda_t(t) / lambda_m;
//                float u2 <- rnd(0.0, 1.0);
//                
//                if (u2 <= acceptance_prob) {
//                    events <+ t;  // Accept the event
//                }
//            }
//        }
//    }
//    
//    // Calculate expected vs actual counts per interval
//    action calculate_interval_counts {
//        list<float> expected_counts <- [];
//        list<int> actual_counts <- [];
//        list<string> interval_labels <- [];
//        
//        loop i from: 0 to: int(T - interval) step: int(interval) {
//            float start_t <- float(i);
//            float end_t <- start_t + interval;
//            
//            // Expected count through numerical integration (trapezoidal rule)
//            float expected <- 0.0;
//            int steps <- 10; // Resolution for numerical integration
//            float step_size <- interval / steps;
//            
//            loop j from: 0 to: steps {
//                float t1 <- start_t + j * step_size;
//                float intensity1 <- lambda_t(t1);
//                
//                if (j < steps) {
//                    float t2 <- start_t + (j + 1) * step_size;
//                    float intensity2 <- lambda_t(t2);
//                    expected <- expected + (intensity1 + intensity2) * step_size / 2.0;
//                }
//            }
//            
//            // Actual count
//            int actual <- length(events where (each >= start_t and each < end_t));
//            
//            expected_counts <+ expected;
//            actual_counts <+ actual;
//            interval_labels <+ "[" + start_t + "," + end_t + "]";
//            
//            write "Interval " + interval_labels[length(interval_labels)-1] + 
//                  ": Expected = " + expected + ", Actual = " + actual;
//        }
//        
//        // Store for visualization
//        create IntervalData {
//            intervals <- interval_labels;
//            expected <- expected_counts;
//            actual <- actual_counts;
//        }
//    }
//    
//    // Reflex to regenerate events periodically if needed in a simulation run
//    reflex regenerate_events when: every(24 #cycle) {
//        do generate_nhpp(T, lambda_max);
//    }
//}
//
//// Species to store interval comparison data
//species IntervalData {
//    list<string> intervals;
//    list<float> expected;
//    list<int> actual;
//}
//
//experiment "Non-Homogeneous Poisson" type: gui {
//    output {
//        display "Intensity Function and Events" {
//            chart "Trash Production Rate and Events" type: series {
//                data "Intensity Function" value: intensity_values color: #blue;
//                data "NHPP Events" value: events accumulate_values: false 
//                    style: line marker: true marker_size: 1.0 color: #red;
//            }
//        }
//        
//        display "Interval Comparison" {
//            chart "Expected vs Actual Events per Interval" type: histogram {
//                data "Expected" value: first(IntervalData).expected color: #blue;
//                data "Actual" value: first(IntervalData).actual color: #red;
//            }
//        }
//    }
//}


/**
* Name: NHPP_Model
* A model implementing non-homogeneous Poisson process for trash generation
* Author: modified for user
* Tags: probability, NHPP, poisson
*/

model NHPP_Model

global {
    float step <- 1; // Each cycle represents 1 hour
    float lambda_max <- 12.0;
    float T <- 24.0;
    float interval <- 1.0;

    list<float> expected_counts;
    list<float> actual_counts;
    list<float> time_intervals;

    init {
        create NHPP_function;
    }
}

species NHPP_function {
    float base_rate <- 1.0;
    float peak1 <- 10.0;
    float peak2 <- 8.0;
    float peak3 <- 6.0;

    list<float> events <- [];
    list<float> time_points <- [];
    list<float> intensity_values <- [];
    
    // Calculate intensity at time t
    action lambda_t (float argt) {
        float intensity <- base_rate;
        intensity <- intensity + peak1 * exp(-((argt - 12) / 2)^2);  // Lunch peak
        intensity <- intensity + peak2 * exp(-((argt - 22) / 2)^2);  // Dinner peak
        intensity <- intensity + peak3 * exp(-((argt - 18) / 2)^2);  // Closing peak
        
        return intensity;
    }
    
    // Generate non-homogeneous Poisson process events
    action generate_nhpp (float argT, float amplitude) {
        float t <- 0.0;
        list<float> new_events <- [];
        
        loop while: (t < argT) {
            float u1 <- rnd(0.0, 1.0);  // First uniform random number
            t <- t - ln(u1) / amplitude;  // Generate next candidate time
            
            if (t < argT) {
                // Thinning approach: accept with probability lambda(t)/lambda_max
                float acceptance_prob <- lambda_t(t) / amplitude;
                float u2 <- rnd(0.0, 1.0);  // Second uniform random number
                
                if (u2 <= acceptance_prob) {
                    new_events <- new_events + t;
                }
            }
        }
        
        events <- new_events;
        write "Generated NHPP Count: " + length(events);
        
        if (length(events) > 0) {
            write "Mean event time: " + mean(events) + ", Variance: " + variance(events);
        }
        
        return events;
    }
    
    // Compute intensity function values for plotting
    action compute_intensity_function {
        time_points <- [];
        intensity_values <- [];
        
        // Create time points at finer resolution for smoother plotting
        loop i from: 0.0 to: T step: 0.5 {  // Using 0.5 hour intervals for smoother curve
            time_points <- time_points + i;
            intensity_values <- intensity_values + lambda_t(i);
        }
        
        // Also compute expected counts per interval
        expected_counts <- [];
        actual_counts <- [];
        time_intervals <- [];
        
        loop i from: 0.0 to: T-interval step: interval {
            time_intervals <- time_intervals + i;
            
            // Approximate integration using trapezoid rule
            float sum <- 0.0;
            int steps <- 10;  // Number of subintervals for integration
            float step_size <- interval / steps;
            
            loop j from: 0 to: steps-1 {
                float t1 <- i + j * step_size;
                float t2 <- i + (j+1) * step_size;
                sum <- sum + float(lambda_t(t1) + lambda_t(t2)) * step_size / 2;
            }
            
            expected_counts <- expected_counts + sum;
            
            // Count actual events in interval
            int count <- 0;
            loop evt over: events {
                if (evt >= i and evt < i+interval) {
                    count <- count + 1;
                }
            }
            actual_counts <- actual_counts + float(count);
            
            write "Interval [" + i + ", " + (i+interval) + "]: Expected = " 
                  + sum + ", Actual = " + count;
        }
        
        return intensity_values;
    }
    
    // Generate new NHPP events at the beginning and then every 24 hours
    reflex generate_trash when: cycle = 0 or every(24#cycle) {
        write "Cycle " + cycle + ": Generating new NHPP events";
        do generate_nhpp(T, lambda_max);
        do compute_intensity_function();
    }
}

experiment "Non-Homogeneous Poisson" type: gui {
    output {
        display "NHPP Visualization" type: 2d {
            chart "Intensity Function and Events" type: series {
                data "Lambda(t)" value: first(NHPP_function).intensity_values 
                      color: #blue style: line;
                      }
            chart "event" type: scatter{         
                data "Events" value: first(NHPP_function).events color: #red 
                      marker: true marker_size: 2.0;
            }
        }
        
//        display "Expected vs Actual" type: 2d {
//            chart "Events per Interval" type: series {
//                data "Expected" value: first(NHPP_function).expected_counts 
//                      color: #blue style: line;
//                data "Actual" value: first(NHPP_function).actual_counts 
//                      color: #red style: bar;
//                data "Time Intervals" value: first(NHPP_function).time_intervals 
//                      color: #black style: line visible: false;
//            }
//        }
    }
}