/**
* Name: NewModel
* Based on the internal empty template. 
* Author: valencia
* Tags: 
*/


model NewModel

/* Insert your model definition here */
global {
    int num_bins <- 10;
    int num_cleaners <- 2;
    int num_tenants <- 50;
    
    list<point> bin_positions <- [];
    
    // Global function to calculate Euclidean distance
    float distance(point p1, point p2) {
        return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
    }
    
    init {
    	create Bin number:num_bins;
    	create Cleaner number:num_cleaners;
    	create Tenant number:num_tenants;
    	
    }
}

species Bin {
    point location;
    int fill_level <- 0; // Current trash level
    int capacity <- 10;  // Max trash capacity
    
	aspect base {
        draw circle(2) color: (fill_level >= capacity ? #red : #green); // Full bins turn red
    }
    
    init {
        location <- {rnd(100), rnd(100)}; // Assign a random position from global bin list
    }
}

species Cleaner {
    point position;
    Bin target_bin <- nil;
    
    aspect base {
                draw triangle(2) color: #red; // Red cleaners
            }
            
    reflex check_bins {
        if (target_bin = nil) {
            target_bin <- one_of(Bin where (each.fill_level >= each.capacity)); // Find a full bin
        }
    }
    
    
    reflex move_to_bin {
        if (target_bin != nil) {
            position <- position + (target_bin.location - position) * 0.1; // Move towards bin
            
            if (distance(self.position, target_bin.location) < 2) { // If at bin
                target_bin.fill_level <- 0; // Empty bin
                target_bin <- nil; // Find new target
            }
        }
        
    }
    
    init {
        position <- {rnd(100), rnd(100)}; // Random start position for each cleaner
    }
}

species Tenant {
    point position;
    
    aspect base {
                draw square(2) color: #blue; // Blue tenants
    }
           
            
    reflex throw_trash {
        if (rnd(1) < trash_probability) { // Probability-based trash disposal
            create Trash at: self.position;
        }
    }
        
            
    init {
        position <- {rnd(100), rnd(100)}; // Random position for each tenant
    }
   
}


species Trash {
	point position;
    Bin target_bin <- nil;
	
	aspect base {
        draw circle(1) color: #brown; // Representing trash
    }
    
    
    init {
        target_bin <- one_of(Bin); // Pick a bin
    }
    
  
    reflex move_to_bin {
        if (target_bin != nil) {
            position <- position + (target_bin.location - position) * 0.2; // Move towards bin
            
            if (distance(self, target_bin) < 2) { // If at bin
                target_bin.fill_level <- min(target_bin.fill_level + 1, target_bin.capacity); // Increase bin fill level
                do die; // Trash disappears
            }
            
        }
            
    }
}

experiment optimize_waste_management type: gui {
    output {
        display "Building Simulation" background: #black{
            species Bin aspect:base;
            species Cleaner aspect:base;
            species Tenant aspect:base;      
            
        }
    }
}
