/**
* Name: claude
* Based on the internal empty template. 
* Author: valencia
* Tags: 
*/


model claude

/* Insert your model definition here */

/**
 * Building Waste Management Optimization Model
 * An agent-based simulation to optimize bin placement, cleaner routes, and cleaning schedules
 * in a multi-story building environment.
 */


global {
    // Building configuration
    int nb_floors <- 2;
    float floor_height <- 4.0; // meters between floors
    float building_width <- 50.0;
    float building_length <- 50.0;
    
    // Agent counts
    int nb_bins <- 10 min: 5 max: 30;
    int nb_cleaners <- 2 min: 1 max: 5;
    int nb_tenants <- 50 min: 10 max: 100;
    
    // Bin parameters
    int bin_capacity <- 20 min: 5 max: 50;
    float bin_clear_threshold <- 0.7 min: 0.3 max: 0.9; // 70% of capacity
    
    // Cleaner parameters
    string cleaner_type <- "scheduled" among: ["scheduled", "wifi_enabled"];
    float cleaner_speed <- 1.0 min: 0.5 max: 2.0; // meters per second
    int scheduled_cleaning_interval <- 10 min: 5 max: 30; // simulation cycles between cleaning rounds
    
    // Tenant parameters
    float tenant_trash_probability <- 0.1 min: 0.01 max: 0.3; // Probability of producing trash per step
    float tenant_speed <- 1.2 min: 0.8 max: 2.0; // meters per second
    
    // Statistics
    int total_trash_produced <- 0;
    int total_trash_collected <- 0;
    int total_bin_overflow_events <- 0;
    float avg_tenant_travel_distance <- 0.0;
    float avg_cleaner_travel_distance <- 0.0;
    
    // Paths for cleaners
    graph building_graph;
    map<Bin, float> bin_last_cleared <- [];
    
    // Bin placement optimization
    list<point> optimal_bin_positions <- [];
    list<point> bin_candidates <- [];
    
    // Floor plan (for display purposes)
    geometry shape <- rectangle(building_width, building_length);
    list<geometry> floors <- [];
    
    init {
        // Create floors
        loop i from: 0 to: nb_floors - 1 {
            geometry floor_shape <- rectangle(building_width, building_length);
            floors << floor_shape;
        }
        
        // Generate candidate bin positions on a grid
        int grid_size <- 5; // 5x5 grid on each floor
        float cell_width <- building_width / grid_size;
        float cell_length <- building_length / grid_size;
        
        loop floor from: 0 to: nb_floors - 1 {
            loop i from: 0 to: grid_size - 1 {
                loop j from: 0 to: grid_size - 1 {
                    point p <- {cell_width / 2 + i * cell_width, 
                               cell_length / 2 + j * cell_length, 
                               floor * floor_height};
                    bin_candidates << p;
                }
            }
        }
        
        // Initially place bins randomly from candidates
        optimal_bin_positions <- nb_bins among bin_candidates;
        
        // Create bins at optimal positions
        loop i from: 0 to: length(optimal_bin_positions) - 1 {
            create Bin {
                location <- optimal_bin_positions[i];
                floor <- int(location.z / floor_height);
            }
        }
        
        // Create cleaners
        create Cleaner number: nb_cleaners {
            location <- {rnd(building_width), rnd(building_length), rnd(nb_floors - 1) * floor_height};
            floor <- int(location.z / floor_height);
            base_location <- copy(location);
            if (cleaner_type = "scheduled") {
                // Scheduled cleaners get assigned specific bins
                int bins_per_cleaner <- nb_bins / nb_cleaners;
                int start_idx <- int(self.name) * bins_per_cleaner;
                int end_idx <- min([start_idx + bins_per_cleaner, nb_bins]) - 1;
                loop i from: start_idx to: end_idx {
                    if (i < length(Bin)) {
                        assigned_bins << Bin[i];
                    }
                }
            }
        }
        
        // Create tenants
        create Tenant number: nb_tenants {
            location <- {rnd(building_width), rnd(building_length), rnd(nb_floors - 1) * floor_height};
            floor <- int(location.z / floor_height);
            office_location <- copy(location);
        }
        
        // Build walkable graph
        list<geometry> nodes <- (Bin collect each.location) + 
                              (Tenant collect each.location) +
                              (Cleaner collect each.location);
        building_graph <- as_edge_graph(nodes);
        
        // Initialize bin statistics
        ask Bin {
            bin_last_cleared[self] <- time;
        }
    }
    
    // Function to find nearest bin on the same floor
    Bin find_nearest_bin(point loc, int current_floor) {
        list<Bin> same_floor_bins <- Bin where (each.floor = current_floor);
        if (empty(same_floor_bins)) {
            return nil;
        }
        
        Bin nearest_bin <- same_floor_bins with_min_of (each distance_to loc);
        return nearest_bin;
    }
    
    // Function to calculate 3D distance (including floor height)
    float real_distance(point p1, point p2) {
        return sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2 + (p1.z - p2.z)^2);
    }
    
    // Optimize bin placement based on tenant traffic
    reflex optimize_bin_placement when: every(100) {
        // Simple optimization: move bins closer to areas with high tenant traffic
        map<point, int> traffic_heatmap <- [];
        
        // Count tenant visits to each point
        ask Tenant {
            if (target_bin != nil) {
                point bin_loc <- target_bin.location;
                if (traffic_heatmap.keys contains bin_loc) {
                    traffic_heatmap[bin_loc] <- traffic_heatmap[bin_loc] + 1;
                } else {
                    traffic_heatmap[bin_loc] <- 1;
                }
            }
        }
        
        
        // Sort bins by usage
        list<point> sorted_locations <- traffic_heatmap.keys sort_by traffic_heatmap[each];
        
        // Replace least used bin locations with new candidates if better
        if (length(sorted_locations) > 0) {
            int num_to_replace <- min([3, length(sorted_locations)]);
            loop i from: 0 to: num_to_replace - 1 {
                point least_used <- sorted_locations[i];
                point new_candidate <- one_of(bin_candidates);
                
                // Check if new position would be better (closer to more tenants)
                int current_score <- traffic_heatmap[least_used] ?? 0;
                int new_score <- 0;
                
                ask Tenant {
                    int current_floor <- int(location.z / floor_height);
                    int candidate_floor <- int(new_candidate.z / floor_height);
                    
                    if (current_floor = candidate_floor) {
                        float dist_to_new <- self.location distance_to new_candidate;
                        float dist_to_old <- self.location distance_to least_used;
                        if (dist_to_new < dist_to_old) {
                            new_score <- new_score + 1;
                        }
                    }
                }
                
                if (new_score > current_score) {
                    // Replace bin location
                    ask Bin {
                        if (location = least_used) {
                            location <- new_candidate;
                            floor <- int(location.z / floor_height);
                        }
                    }
                }
            }
        }
    }
    
    

    
    // Track statistics
    reflex update_statistics when: every(10) {
        // Calculate average tenant walking distance
        float total_distance <- 0.0;
        int count <- 0;
        
        ask Tenant {
            if (has_trash and target_bin != nil) {
                total_distance <- total_distance + (self.location distance_to target_bin.location);
                count <- count + 1;
            }
        }
        
        if (count > 0) {
            avg_tenant_travel_distance <- total_distance / count;
        }
        
        // Calculate average cleaner travel distance
        float total_cleaner_distance <- 0.0;
        int cleaner_count <- 0;
        
        ask Cleaner {
            if (target_bin != nil) {
                total_cleaner_distance <- total_cleaner_distance + (self.location distance_to target_bin.location);
                cleaner_count <- cleaner_count + 1;
            }
        }
        
        if (cleaner_count > 0) {
            avg_cleaner_travel_distance <- total_cleaner_distance / cleaner_count;
        }
    }
}

species Bin {
    rgb color <- #green;
    float fill_level <- 0.0; // Current fill level (0.0 to 1.0)
    int floor <- 0; // Which floor the bin is on
    list<Tenant> users <- []; // Tenants who use this bin
    
    aspect base {
        // Color based on fill level: green (empty) to red (full)
        color <- rgb(255 * fill_level, 255 * (1 - fill_level), 0);
        draw cylinder(1, 2) color: color border: #black;
        // Show fill level as a number
        draw string(int(fill_level * 100) + "%") color: #black size: 1.0 at: location + {0, 0, 3};
    }
    
    // Function to add trash to bin
    action add_trash {
        fill_level <- fill_level + (1 / bin_capacity);
        if (fill_level >= 1.0) {
            fill_level <- 1.0; // Cap at full
            total_bin_overflow_events <- total_bin_overflow_events + 1;
        }
    }
    
    // Function to empty bin
    action empty {
        float trash_collected <- fill_level * bin_capacity;
        total_trash_collected <- total_trash_collected + int(trash_collected);
        fill_level <- 0.0;
        bin_last_cleared[self] <- time;
    }
    
    // Alert for wifi-enabled bins
    reflex alert_full when: fill_level >= bin_clear_threshold and cleaner_type = "wifi_enabled" {
        // Find available cleaners
        list<Cleaner> available_cleaners <- Cleaner where (each.status = "idle" and each.floor = self.floor);
        if (!empty(available_cleaners)) {
            ask available_cleaners closest_to(self) {
                if (self.target_bin = nil) {
                    self.target_bin <- myself;
                    self.status <- "moving_to_bin";
                }
            }
        }
    }
}

species Cleaner skills: [moving] {
    rgb color <- #blue;
    point base_location; // Starting/resting position
    int floor <- 0; // Current floor
    Bin target_bin <- nil; // Current target bin
    string status <- "idle"; // idle, moving_to_bin, emptying, returning
    list<Bin> assigned_bins <- []; // For scheduled cleaners
    int bins_emptied <- 0; // Count of bins emptied
    float total_distance_traveled <- 0.0; // Track distance traveled
    point last_location; // To calculate distance traveled
    
    init {
        last_location <- location;
    }
    
    aspect base {
        draw pyramid(2) color: color border: #black;
        // Show status
        draw status color: #black size: 0.8 at: location + {0, 0, 3};
    }
    
    // For scheduled cleaners - clean based on schedule
    reflex scheduled_cleaning when: (status = "idle") and (cleaner_type = "scheduled") 
                                and every(scheduled_cleaning_interval) {
        // Find bins that need cleaning (prioritize fullest bins)
        list<Bin> bins_to_clean <- assigned_bins where (each.fill_level > 0) sort_by (-1 * each.fill_level);
        if (!empty(bins_to_clean)) {
            target_bin <- bins_to_clean[0]; // Choose fullest bin
            status <- "moving_to_bin";
        }
    }
    
    // For wifi-enabled cleaners - respond to alerts
    reflex check_alerts when: (status = "idle") and (cleaner_type = "wifi_enabled") {
        // Find bins above threshold on same floor
        list<Bin> alerting_bins <- Bin where (each.fill_level >= bin_clear_threshold and each.floor = self.floor);
        if (!empty(alerting_bins)) {
            // Select closest bin
            target_bin <- alerting_bins closest_to self;
            status <- "moving_to_bin";
        }
    }
    
    // Move to target bin
    reflex move_to_bin when: (status = "moving_to_bin") and (target_bin != nil) {
        // Handle floor transitions if necessary
        if (floor != target_bin.floor) {
            // Move to elevator/stairs (simplified as direct floor change)
            location <- {location.x, location.y, target_bin.floor * floor_height};
            floor <- target_bin.floor;
        } else {
            // Move toward bin on same floor
            do goto target: target_bin.location speed: cleaner_speed;
            
            // Calculate distance traveled
            float dist_moved <- self.location distance_to last_location;
            total_distance_traveled <- total_distance_traveled + dist_moved;
            last_location <- copy(location);
            
            // Check if reached bin
            if (location distance_to target_bin.location < 1.0) {
                status <- "emptying";
            }
        }
    }
    
    // Empty target bin
    reflex empty_bin when: (status = "emptying") and (target_bin != nil) {
        // Empty the bin
        ask target_bin {
            do empty;
        }
        
        bins_emptied <- bins_emptied + 1;
        
        // Check if there are more bins to empty (for efficiency)
        list<Bin> nearby_bins <- Bin where ((each.location distance_to location < 10) and 
                                            (each.fill_level > 0.5) and 
                                            (each.floor = floor));
        
        if (!empty(nearby_bins) and length(nearby_bins) > 0) {
            // Move to another nearby bin
            target_bin <- nearby_bins closest_to self;
            status <- "moving_to_bin";
        } else {
            // Return to base
            target_bin <- nil;
            status <- "returning";
        }
    }
    
    // Return to base location
    reflex return_to_base when: status = "returning" {
        // Handle floor transitions if necessary
        int base_floor <- int(base_location.z / floor_height);
        if (floor != base_floor) {
            // Move to elevator/stairs (simplified as direct floor change)
            location <- {location.x, location.y, base_floor * floor_height};
            floor <- base_floor;
        } else {
            // Move toward base location
            do goto target: base_location speed: cleaner_speed;
            
            // Calculate distance traveled
            float dist_moved <- self.location distance_to last_location;
            total_distance_traveled <- total_distance_traveled + dist_moved;
            last_location <- copy(location);
            
            // Check if reached base
            if (location distance_to base_location < 1.0) {
                status <- "idle";
            }
        }
    }
}

species Tenant skills: [moving] {
    rgb color <- #yellow;
    point office_location; // Office/apartment location
    int floor <- 0; // Current floor
    Bin target_bin <- nil; // Target bin when disposing trash
    bool has_trash <- false; // Whether tenant has trash to dispose
    float trash_size <- 1.0; // Size of trash (takes 1 unit of bin capacity)
    string status <- "working"; // working, moving_to_bin, returning
    float total_distance_traveled <- 0.0;
    point last_location;
    
    init {
        last_location <- location;
    }
    
    aspect base {
        draw sphere(0.8) color: color border: #black;
        if (has_trash) {
            // Show trash bag
            draw sphere(0.4) color: #brown at: location + {0, 0, 2};
        }
    }
    
    // Generate trash randomly
    reflex generate_trash when: status = "working" and !has_trash and flip(tenant_trash_probability) {
        has_trash <- true;
        total_trash_produced <- total_trash_produced + 1;
        
        // Find nearest bin on same floor
        target_bin <- find_nearest_bin(location, floor);
        
        if (target_bin != nil) {
            status <- "moving_to_bin";
        }
    }
    
    // Move to dispose trash
    reflex move_to_bin when: status = "moving_to_bin" and has_trash and target_bin != nil {
        // Handle floor transitions if necessary
        if (floor != target_bin.floor) {
            // Move to elevator/stairs (simplified as direct floor change)
            location <- {location.x, location.y, target_bin.floor * floor_height};
            floor <- target_bin.floor;
        } else {
            // Move toward bin on same floor
            do goto target: target_bin.location speed: tenant_speed;
            
            // Calculate distance traveled
            float dist_moved <- self.location distance_to last_location;
            total_distance_traveled <- total_distance_traveled + dist_moved;
            last_location <- copy(location);
            
            // Check if reached bin
            if (location distance_to target_bin.location < 1.0) {
                // Dispose trash
                if (target_bin.fill_level < 1.0) {
                    ask target_bin {
                        do add_trash;
                    }
                    has_trash <- false;
                } else {
                    // Bin is full - find another bin
                    list<Bin> other_bins <- Bin where (each != target_bin and each.floor = floor and each.fill_level < 1.0);
                    if (!empty(other_bins)) {
                        target_bin <- other_bins closest_to self;
                    } else {
                        // Leave trash by the bin if no alternatives
                        // In a real implementation, we might want to create a "trash pile" agent here
                        has_trash <- false;
                        total_bin_overflow_events <- total_bin_overflow_events + 1;
                    }
                }
                
                if (!has_trash) {
                    status <- "returning";
                }
            }
        }
    }
    
    // Return to office
    reflex return_to_office when: status = "returning" {
        // Handle floor transitions if necessary
        int office_floor <- int(office_location.z / floor_height);
        if (floor != office_floor) {
            // Move to elevator/stairs (simplified as direct floor change)
            location <- {location.x, location.y, office_floor * floor_height};
            floor <- office_floor;
        } else {
            // Move toward office location
            do goto target: office_location speed: tenant_speed;
            
            // Calculate distance traveled
            float dist_moved <- self.location distance_to last_location;
            total_distance_traveled <- total_distance_traveled + dist_moved;
            last_location <- copy(location);
            
            // Check if reached office
            if (location distance_to office_location < 1.0) {
                status <- "working";
            }
        }
    }
}

experiment building_waste_management_gui type: gui {
    parameter "Number of floors" var: nb_floors min: 1 max: 5 category: "Building";
    parameter "Number of bins" var: nb_bins min: 5 max: 30 category: "Optimization";
    parameter "Number of cleaners" var: nb_cleaners min: 1 max: 5 category: "Optimization";
    parameter "Number of tenants" var: nb_tenants min: 10 max: 100 category: "Building";
    parameter "Cleaner type" var: cleaner_type category: "Policy" among: ["scheduled", "wifi_enabled"];
    parameter "Scheduled cleaning interval" var: scheduled_cleaning_interval min: 5 max: 50 category: "Policy";
    parameter "Bin capacity" var: bin_capacity min: 5 max: 50 category: "Optimization";
    parameter "Bin clear threshold" var: bin_clear_threshold min: 0.3 max: 0.9 category: "Policy";
    parameter "Tenant trash probability" var: tenant_trash_probability min: 0.01 max: 0.3 category: "Simulation";
    
    output {
        display "3D Building View" type: opengl {
            // Display floors
            graphics "floors" {
                loop i from: 0 to: nb_floors - 1 {
                    draw rectangle(building_width, building_length)
                         at: {building_width / 2, building_length / 2, i * floor_height}
                         color: #lightgrey border: #black;
                }
            }
            
            species Bin aspect: base;
            species Cleaner aspect: base;
            species Tenant aspect: base;
            
            // Display axis for orientation
            graphics "axis" {
                draw line([{0, 0, 0}, {10, 0, 0}]) color: #red;
                draw line([{0, 0, 0}, {0, 10, 0}]) color: #green;
                draw line([{0, 0, 0}, {0, 0, 10}]) color: #blue;
            }
        }
        
        display "2D Floor View" {
            parameter "Current Floor" var: int(0) min: 0 max: nb_floors - 1 among: (range(nb_floors));
            
            graphics "floor_outline" {
                draw rectangle(building_width, building_length) color: #lightgrey border: #black;
            }
            
            species Bin aspect: base {
                draw circle(1) color: color;
                draw string(int(fill_level * 100) + "%") color: #black size: 0.8;
            }
            
            species Cleaner aspect: base {
                draw triangle(2) color: color;
            }
            
            species Tenant aspect: base {
                draw circle(0.8) color: color;
            }
        }
        
        display "Statistics" {
            chart "Bin Fill Levels" type: series {
                list<Bin> sorted_bins <- Bin sort_by each.name;
                loop bin over: sorted_bins {
                    data bin.name value: bin.fill_level * 100 color: bin.color;
                }
            }
            
            chart "System Performance" type: series {
                data "Avg. Tenant Travel Distance" value: avg_tenant_travel_distance color: #yellow;
                data "Avg. Cleaner Travel Distance" value: avg_cleaner_travel_distance color: #blue;
                data "Bin Overflow Events" value: total_bin_overflow_events color: #red;
            }
            
            chart "Trash Management" type: series {
                data "Trash Produced" value: total_trash_produced color: #brown;
                data "Trash Collected" value: total_trash_collected color: #green;
            }
        }
    }
}

// Optimization experiment to find best parameters
experiment building_waste_management_optimization type: batch repeat: 5 keep_seed: true until: (time > 1000) {
    parameter "Number of bins" var: nb_bins min: 5 max: 20 step: 5 category: "Optimization";
    parameter "Number of cleaners" var: nb_cleaners min: 1 max: 3 step: 1 category: "Optimization";
    parameter "Cleaner type" var: cleaner_type among: ["scheduled", "wifi_enabled"] category: "Policy";
    parameter "Scheduled cleaning interval" var: scheduled_cleaning_interval min: 10 max: 30 step: 10 category: "Policy";
    
    // Define optimization method and criteria
    method genetic maximize: total_trash_collected / total_distance_traveled pop_dim: 10 crossover_prob: 0.7 mutation_prob: 0.1;
    
    // Performance metrics
    permanent {
        display "Optimization Results" {
            chart "Performance by Parameters" type: series {
                data "Trash Collected" value: total_trash_collected;
                data "Overflow Events" value: total_bin_overflow_events;
                data "Total Distance" value: avg_tenant_travel_distance + avg_cleaner_travel_distance;
            }
        }
    }
}