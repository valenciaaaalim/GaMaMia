/**
* Name: NHPPgpt
* Based on the internal empty template. 
* Author: valencia
* Tags: 
*/


model NHPPgpt

/* Insert your model definition here */



global {
    float step <- 1;   // Each cycle represents 1 hour
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
    list<float> intensity_values <- [];
    
    action lambda_t (float argt) {
        float intensity <- base_rate;
        intensity <- intensity + peak1 * exp(-((argt - 12) / 2)^2);
        intensity <- intensity + peak2 * exp(-((argt - 22) / 2)^2);
        intensity <- intensity + peak3 * exp(-((argt - 18) / 2)^2);
        return intensity;
    }
    
    action generate_nhpp (float argT, float amplitude) {
        float t <- 0.0;
        list<float> new_events <- [];
        
        loop while: (t < argT) {
            float u <- rnd(0.1)/0.1;
            t <- t - log(u) / amplitude;  // Generate next candidate event
            
            if (t < argT and rnd(1.0) < float(lambda_t(t) / amplitude)) {
                new_events <- new_events + t;
            }
        }
        events <- new_events;
        write "Generated NHPP Count: " + length(events);
        return events;
    }
    
    action compute_intensity_function {
        list<float> time_values <- [];
        list<float> intensity_list <- [];
        
        loop i from: 0 to: T step: interval {
            time_values <- time_values + i;
            intensity_list <- intensity_list + lambda_t(i);
        }
        
        intensity_values <- intensity_list;
        write "Computed intensity function values.";
    }
    
    reflex generate_trash when: every(1#cycle) {
        events <- generate_nhpp(T, lambda_max);
        intensity_values <- compute_intensity_function();
    }
}

experiment "Non-Homogeneous Poisson" type: gui {
    output {
        display "NHPP Intensity" type: 2d {
            chart "Intensity Function" type: series {
                data "Lambda(t)" value: NHPP_function collect (each.intensity_values);
                data "Events" value: NHPP_function collect (each.events) marker: true style: stack;
            }
        }
    }
}
