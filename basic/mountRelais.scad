/*
Copyright 2018 Michael Gläser

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// PCB Technical Data
pcbWidth = 18.2;
pcbDepth = 53.4;
pcbHeight = 1.5;

bottomGap = 3.5;

// holes
$fn = 50;
holeDiameter = 2.5;
holeDistanceX = 14.2; // distance between both holes
holeDistanceY = 49.2; // distance from pcb border

module pcb() {
    $fn = 50;
    holeDiameter = 3.0;
    holeDistanceX = 14.2; // distance between both holes
    holeDistanceY = 49.2; // distance from pcb border
    
    difference() {
        translate([-pcbWidth/2,-pcbDepth/2,0]) {
            cube([pcbWidth, pcbDepth, pcbHeight]);
        };
        translate([holeDistanceX/2,holeDistanceY/2,0]) {
            cylinder(h=pcbHeight, r=holeDiameter/2);
        };
        translate([-holeDistanceX/2,holeDistanceY/2,0]) {
            cylinder(h=pcbHeight, r=holeDiameter/2);
        };
        translate([holeDistanceX/2,-holeDistanceY/2,0]) {
            cylinder(h=pcbHeight, r=holeDiameter/2);
        };
        translate([-holeDistanceX/2,-holeDistanceY/2,0]) {
            cylinder(h=pcbHeight, r=holeDiameter/2);
        };
    };
}

module pierPlug() {
    borderX = 2;
    borderY = 3;
    borderZ = 2;
    pierDepth = 3;
    edgeX = 1.5;
    translate([-(pcbWidth/2+borderX),-pierDepth,0]) {
        difference() {
            cube([pcbWidth+2*borderX,borderY+pierDepth,bottomGap+pcbHeight+borderZ]);
            translate([borderX,0,bottomGap]) {
                cube([pcbWidth+0.2,pierDepth,pcbHeight+0.2]);
            };
            translate([borderX+edgeX,0,bottomGap+pcbHeight]) {
                cube([pcbWidth+0.2-2*edgeX,pierDepth,pcbHeight+borderZ]);
            };
        };
    };
};

module pierScrew() {
    borderX = 2;
    borderY = 2;
    pierDepth = 6;
    pinspaceX = pcbWidth-10;
    pinspaceY = pierDepth-4;
    pinspaceZ = 2;
    
    difference() {
        translate([-(pcbWidth/2+borderX),-(borderY),0]) {
            difference() {
                cube([pcbWidth+2*borderX,pierDepth+borderY,bottomGap+pcbHeight]);
                translate([borderX,borderY,bottomGap]) {
                    cube([pcbWidth+0.2,pierDepth,pcbHeight+0.2]);
                };
            };
        };
        // holes
        translate([holeDistanceX/2,0.8+holeDiameter/2,0]) {
            cylinder(h=bottomGap, r=holeDiameter/2);
        };
        translate([-holeDistanceX/2,0.8+holeDiameter/2,0]) {
            cylinder(h=bottomGap, r=holeDiameter/2);
        };
        // pin space
        translate([-pinspaceX/2,pierDepth-pinspaceY,bottomGap-pinspaceZ]) {
            cube([pinspaceX,pinspaceY,pinspaceZ]);
        };        
    };
};

module relaisMount() {
    //pcb();
    translate([0,pcbDepth+1.2,0]) {
        pierPlug();
    };
    translate([0,0,0]) {
        pierScrew();
    };
}

relaisMount();