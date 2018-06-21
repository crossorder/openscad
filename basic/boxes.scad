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
};

showroom();
