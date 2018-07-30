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
pcbWidth = 13.7;
pcbDepth = 15.1;
pcbHeight = 1.7;



module pcb() {
    $fn = 50;
    holeDiameter = 3.0;
    holeDistanceX = 8.2; // distance between both holes
    holeDistanceY = 9.2; // distance from pcb border
    
    difference() {
        translate([-pcbWidth/2,0,0]) {
            cube([pcbWidth, pcbDepth, pcbHeight]);
        };
        translate([holeDistanceX/2,holeDistanceY,0]) {
            cylinder(h=pcbHeight, r=holeDiameter/2);
        };
        translate([-holeDistanceX/2,holeDistanceY,0]) {
            cylinder(h=pcbHeight, r=holeDiameter/2);
        };
    };
}

module pcbHeader(side="up") {
    width = pcbWidth;
    depth = 3.1;
    height = 20.0;
    
    if (side=="up") {
        translate([-width/2,12,-1.3]) {
            cube([width,depth,height]);  
        };
    } else {
        translate([-wth/2,12,-height+pcbHeight+1.3]) {
            cube([width,depth,height]);  
        };
    };
};

module usbHeader() {


};

module usbMount() {
    
    pcb();
    pcbHeader("up");
    usbHeader();
}

usbMount();