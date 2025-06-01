include <../zbeltDeckPanel/zbeltDeckPanel.scad>
include <../cubes/cubes.scad>
include <../hexagons/hexagons.scad>
include <../m3/m3.scad>

module splitZbeltDeckPanel_outlineLeft(){
    intersection() {
        difference() {
            zbeltDeckPanel_outline();

            translate([209/2,172/2+5])
                rotate([0,0,90])
                    hexagon(od=(146-112)/2+112.2);
        }

        translate([209/2,0,0])
            square([209/2-0.2,172]);
    }
}

module splitZbeltDeckPanel_outlineRight() {
    intersection() {
        difference() {
            zbeltDeckPanel_outline();

            translate([209/2,172/2+5])
                rotate([0,0,90])
                    hexagon(od=(146-112)/2+112.2);
        }
        square([209/2-0.2,172]);
    }
}

module splitZbeltDeckPanel_left() {
    let(logoD = (146-112)/2+112, screwR=(logoD/2)*cos(30)+4){
        difference() {
            linear_extrude(2.6) 
                splitZbeltDeckPanel_outlineLeft();
            
            intersection() {
                 translate([209,0,2.6]) 
                    mirror([0,0,1])
                        mirror([1,0,0]) 
                            beveledHexagonPanel(22,2,3,209/2-27,172+2.5,1.2,18,0);
                difference() {
                    linear_extrude(2.6) 
                        offset(delta=-10)
                            splitZbeltDeckPanel_outlineLeft();
                    
                    linear_extrude(2.6)
                        translate([209/2,172/2+5])
                            rotate([0,0,90])
                                hexagon(od=146);
                }
            }
            
            translate([209/2,172/2+5]) {
                union()
                    hexCycle(screwR) 
                        m3FHCS_counterSinkCutout();
                
                //splitZbeltDeckPanel_baffleEndScrewPattern()
                    //m3FHCS_counterSinkCutout();
            }
        }
    }
}

module splitZbeltDeckPanel_right() {
    let(logoD = (146-112)/2+112, screwR=(logoD/2)*cos(30)+4){
        difference() {
            linear_extrude(2.6) 
                splitZbeltDeckPanel_outlineRight();
            
            intersection() {
                 translate([0,0,2.6]) 
                    mirror([0,0,1]) 
                        beveledHexagonPanel(22,2,3,209/2-27,172+2.5,1.2,18,0);
                difference() {
                    linear_extrude(2.6) 
                        offset(delta=-10)
                            splitZbeltDeckPanel_outlineRight();
                    
                    linear_extrude(2.6)
                        translate([209/2,172/2+5])
                            rotate([0,0,90])
                                hexagon(od=146);
                }
            }
            
            translate([209/2,172/2+5]) {
                union()
                    hexCycle(screwR) 
                        m3FHCS_counterSinkCutout(); 
                
                //splitZbeltDeckPanel_baffleEndScrewPattern()
                    //m3FHCS_counterSinkCutout();
            }           
        }
    }
}

module splitZbeltDeckPanel_leftRaised() {
    let(logoD = (146-112)/2+112, screwR=(logoD/2)*cos(30)+4){
        difference() {
            union() {
                linear_extrude(2.6) 
                    splitZbeltDeckPanel_outlineLeft();
                
                intersection() {
                     translate([209,0,2.6])
                            mirror([1,0,0]) 
                                beveledHexagonPanel(22,2,3,209/2-27,172+2.5,1.2,18,0);
                    difference() {
                        linear_extrude(2.6+1.2) 
                            offset(delta=-10)
                                splitZbeltDeckPanel_outlineLeft();
                        
                        linear_extrude(2.6)
                            translate([209/2,172/2+5])
                                rotate([0,0,90])
                                    hexagon(od=146);
                    }
                }
            }
            
            translate([209/2,172/2+5]) {
                union() {
                    hexCycle(screwR) 
                        m3FHCS_counterSinkCutout();
                }
            }
        }
    }
}

module splitZbeltDeckPanel_rightRaised() {
    let(logoD = (146-112)/2+112, screwR=(logoD/2)*cos(30)+4){
        difference() {
            union() {
                linear_extrude(2.6) 
                    splitZbeltDeckPanel_outlineRight();
                
                intersection() {
                     translate([0,0,2.6])
                            beveledHexagonPanel(22,2,3,209/2-27,172+2.5,1.2,18,0);
                    difference() {
                        linear_extrude(2.6+1.21) 
                            offset(delta=-10)
                                splitZbeltDeckPanel_outlineRight();
                        
                        linear_extrude(2.6)
                            translate([209/2,172/2+5])
                                rotate([0,0,90])
                                    hexagon(od=146);
                    }
                }
            }
            
            translate([209/2,172/2+5]) {
                union()
                    hexCycle(screwR) 
                        m3FHCS_counterSinkCutout(); 
                
                //splitZbeltDeckPanel_baffleEndScrewPattern()
                    //m3FHCS_counterSinkCutout();
            }           
        }
    }
}

/*
module splitZbeltDeckPanel_baffleEndScrewPattern() {
    union() {
        translate([0,-1*((172-12)/2)+11,0]) {
            translate([4,0,0]) children();
            translate([-4,0,0]) children();
        }
    
        translate([0,((172-12)/2)-11,0]) {
            translate([4,0,0]) children();
            translate([-4,0,0]) children();
        }
    }
}
*/

module splitZbeltDeckPanel_baffle() {
    difference() {
        
        //union() {
            //translate([0,-5+(19/2)])
                //beveledCube([23,150],3,6);
        
            beveledHexagon(150,0,3,6);
        //}
        
        translate([0,0,6.1])
            mirror([0,0,1])
                beveledHexagon(114,0,3,6.1);
        
        union() {
            let(logoD = (146-112)/2+112, screwRbase=(logoD/2)*cos(30)){
                hexCycle(screwRbase-4) m3x5x4_ThreadedInsert();
                hexCycle(screwRbase+4) m3x5x4_ThreadedInsert();
            }
        }
        
        translate([0,-75,0])
            beveledCube([25,15],-3,6);

        
        //splitZbeltDeckPanel_baffleEndScrewPattern() m3x5x4_ThreadedInsert();
    }
}

module splitZbeltDeckPanel_center() {
    let(logoD = (146-112)/2+112, screwR=(logoD/2)*cos(30)-4){
        difference() {
            union() {
                translate([0,0,2.6])
                    scale([1.4,1.4,1])
                        voronLogo_beveledStripes(3,1.2);

                linear_extrude(2.6)
                    rotate([0,0,90])
                        hexagon(od=logoD);
            }
            hexCycle(screwR) m3FHCS_counterSinkCutout();
        }
    }
}

module splitZbeltDeckPanel_preview() {
    splitZbeltDeckPanel_left();
    splitZbeltDeckPanel_right();
    translate([209/2,172/2+5,2.6]) splitZbeltDeckPanel_baffle();
    translate([209/2,172/2+5]) splitZbeltDeckPanel_center();
}

module splitZbeltDeckPanel_previewRaised() {
    splitZbeltDeckPanel_leftRaised();
    splitZbeltDeckPanel_rightRaised();
    translate([209/2,172/2+5,2.6]) splitZbeltDeckPanel_baffle();
    translate([209/2,172/2+5]) splitZbeltDeckPanel_center();
}