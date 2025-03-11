/**
* Name: rat3
* Based on the internal empty template. 
* Author: valencia
* Tags: 
*/


model rat3

/* Insert your model definition here */

/**
 * Rat Infection Simulation
 * Simple ABM showing infection spread among rats in a two-floor building
 */

global {
    // Environment parameters
    int building_width <- 50;
    int building_height <- 50;
    int nb_floors <- 2;
    
    // Rat population parameters
    int nb_rats <- 30;
    float rat_speed <- 1.0;
    float infection_rate <- 0.7;
    float infection_distance <- 2.0;
    
    // Statistics
    int nb_infected_rats update: rats count (each.is_infected);
    
    init {
        // Create the building structure (floors)
        create floor number: nb_floors {
            location <- {building_width/2, building_height/2, myself.grid_value};
        }
        
        // Create stairs connecting floors
        create stair number: 2 {
            location <- {building_width * (1.0 - 0.8 * self.grid_value), building_height/2, 0};
        }
        
        // Create initial rat population (with 3 infected)
        create rat number: nb_rats {
            location <- {rnd(building_width), rnd(building_height), rnd(nb_floors)};
            current_floor <- int(location.z);
            is_infected <- flip(0.1); // 10% initially infected
        }
    }
    
    reflex update_display {
        write "Day " + (cycle / 24) + " - Infected rats: " + nb_infected_rats + "/" + nb_rats;
    }
}

// Floor species - represents each level of the building
species floor {
    aspect default {
        draw rectangle(building_width, building_height) color: #gray depth: 0.1 at: {location.x, location.y, location.z};
    }
}

// Stair species - allows rats to move between floors
species stair {
    aspect default {
        draw cylinder(2, building_height/4) color: #brown at: location;
    }
}

// Rat species - the main agents in the simulation
species rat skills: [moving] {
    bool is_infected <- false;
    rgb color <- #green;
    int current_floor;
    float infection_timer <- 0.0;
    
    // Rat behavior: move randomly and potentially use stairs
    reflex move {
        // Random movement on current floor
        do wander speed: rat_speed bounds: rectangle(building_width, building_height);
        
        // Occasionally try to change floors using stairs
        if (flip(0.01)) {
            list<stair> nearby_stairs <- stair at_distance 3.0;
            if (!empty(nearby_stairs)) {
                stair target <- one_of(nearby_stairs);
                current_floor <- (current_floor + 1) mod nb_floors;
                location <- {location.x, location.y, current_floor};
            }
        }
    }
    
    // Infection spread between rats
    reflex infect when: is_infected {
        ask rat at_distance infection_distance {
            if (!self.is_infected and flip(infection_rate)) {
                self.is_infected <- true;
                self.infection_timer <- 0.0;
            }
        }
    }
    
    // Update rat appearance based on infection status
    reflex update_status {
        if (is_infected) {
            color <- #red;
            infection_timer <- infection_timer + 1;
        }
    }
    
    aspect default {
        draw sphere(1) color: color at: {location.x, location.y, location.z};
    }
}

experiment rat_infection type: gui {
    output {
        display main_display type: opengl {
            species floor aspect: default;
            species stair aspect: default;
            species rat aspect: default;
        }
        
        display "Infection Chart" {
            chart "Infection Progress" type: series {
                data "Infected" value: nb_infected_rats color: #red;
                data "Healthy" value: nb_rats - nb_infected_rats color: #green;
            }
        }
    }
}