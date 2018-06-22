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

/*
Creates a simple box.
*/
module simpleBox01(width=20, depth=10, height=10, wallThickness=1) {
    
    difference() {
        cube([width, depth, height]);
        translate([wallThickness, wallThickness, wallThickness]) {
            cube([
                width-2*wallThickness,
                depth-2*wallThickness,
                height-wallThickness
            ]);
        };
    };
};

/*
Creates the lid that fits to simple box 01.
*/
module lid01(
    width=20,
    depth=10,
    height=1,
    wallThickness=1,
    inlayThickness=1
) {
    cube([width, depth, height]);
    translate([wallThickness, wallThickness, height]) {
        cube([
            width-2*wallThickness,
            depth-2*wallThickness,
            inlayThickness
        ]);
    };
};

/*
Creates a simple box with an inner shell to hold the lid.
*/
module simpleBox02(width=20, depth=10, height=10, wallThickness=1) {
    
    difference() {
        cube([width, depth, height]);
        translate([wallThickness, wallThickness, wallThickness]) {
            cube([
                width-2*wallThickness,
                depth-2*wallThickness,
                height-wallThickness
            ]);
        };
    };
};

/*
Creates the lid that fits to simple box 02.
*/
module lid02(
    width=20,
    depth=10,
    height=1,
    wallThickness=1,
    inlayThickness=1
) {
    cube([width, depth, height]);
    translate([wallThickness, wallThickness, height]) {
        cube([
            width-2*wallThickness,
            depth-2*wallThickness,
            inlayThickness
        ]);
    };
};

module gridBox01(
    width=20,
    depth=10,
    height=10,
    lineThickness=3
) {
    difference() {
        cube([width, depth, height]);
        translate([lineThickness, lineThickness, 0]) {
            cube([
                width-2*wallThickness,
                depth-2*wallThickness,
                height
            ]);
        };
        translate([lineThickness, 0, lineThickness]) {
            cube([
                width-2*wallThickness,
                depth,
                height-2*wallThickness
            ]);
        };
        translate([0, lineThickness, lineThickness]) {
            cube([
                width,
                depth-2*wallThickness,
                height-2*wallThickness
            ]);
        };
    };
};

module showroom() {
    translate([0,15,0]) {
        simpleBox01();
    };
    lid01();

    translate([-25,0,0]) {
        translate([0,15,0]) {
            simpleBox02();
        };
        lid02();
    };

    translate([-25,-25,0]) {
        gridBox01();
    };
};

showroom();
