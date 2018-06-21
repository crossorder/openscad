module openBox(width=20, depth=10, height=10, wallThickness=1) {
    
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


module lid(
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

translate([0,15,0]) {
    openBox();
};
lid();
