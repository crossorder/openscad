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

$fn=50;

module cableClamp(
cableDiameter,
screwDiameter,
screwDistance,
width,
depth,
height,
ingress=0 // ingress of cable - 0 .. half cable
) {
    if (cableDiameter==undef) {
        echo("cableDiameter is not set.");
        cableDiameter=10;
    };
    if (screwDiameter==undef) echo("screwDiameter is not set.");
    screwDistance= (screwDistance==undef) ? 2*cableDiameter:screwDistance;
    width= (width==undef) ? 3*cableDiameter : width;
    depth= (depth==undef) ? 2*screwDiameter : depth;
    height= (height==undef) ? .75*cableDiameter : height;
    
    difference() {
        // body
        cube([width,depth,height]);
        
        // cable
		rotate([90,0,0]) {
        translate([width/2,height-ingress,-depth]) {
            cylinder(h=depth, r=cableDiameter/2);
        };
        };
        // cable bay
        translate([width/2-cableDiameter/2,0,height-ingress]) {
            cube([cableDiameter,depth,ingress]);
        };
        // right screw
        translate([width/2+screwDistance/2,depth/2,0]) {
            cylinder(h=height, r=screwDiameter/2);
        };
        // left screw
        translate([width/2-screwDistance/2,depth/2,0]) {
            cylinder(h=height, r=screwDiameter/2);
        };
    };
};

//minkowski() {
cableClamp(
cableDiameter=10,
screwDiameter=2.5,
screwDistance=15,
width=20,
height=7,
ingress=0);
//    cylinder(r=2,h=1);
//};
