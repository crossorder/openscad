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
    translate([-pcbWidth/2,0,0]) {
        difference() {
            cube([pcbWidth+2*borderX,6,bottomGap+pcbHeight+2]);
                translate([borderX,0,bottomGap]) {
                    cube([pcbWidth+0.2,3,pcbHeight+0.2]);
                };
        };
    };
};

module pierScrew() {
    borderX = 2;
    borderY = 2;
    pierDepth = 4;
    translate([-pcbWidth/2,-(pierDepth+borderY),0]) {
        difference() {
            cube([pcbWidth+2*borderX,pierDepth+borderY,bottomGap+pcbHeight]);
            translate([borderX,borderY,bottomGap]) {
                cube([pcbWidth+0.2,pierDepth,pcbHeight+0.2]);
            };
            // holes
            // ...
        };
    };
};

module relaisMount() {
    //pcb();
    translate([0,5,0]) {
        pierPlug();
    };
    translate([0,0,0]) {
        pierScrew();
    };
}

relaisMount();