//$fn=400;
$fn=50;
height = 60.0;
rInner = 11.0;
rOuter = 25.0;

magnetHeight = 1.8;
magnetRadius = 4.0;
magnetPipeHeight = height-(10+35);
magnetPipeDiameter = 6.0;
magnetDist = rInner+magnetPipeDiameter-1.0;

module pipe(rInner, rOuter, height, center=false) {
    difference() {
        cylinder(h=height, r=rOuter, center=center);
        cylinder(h=height, r=rInner, center=center);
    }    
}

/*
a - angle of rotation
r - radius from center
*/
module magnetPipe(a, r) {
    rotate(a=a, v=[0,0,1]) {
        translate([r, 0, 0]) {
            cylinder(h=height, r=magnetPipeDiameter, center=false);
            pipe(rInner=magnetRadius+0.1, rOuter=magnetPipeDiameter, height=magnetPipeHeight, center=false);
        };
    };
}

module magnetInnerPipes() {
    magnetInnerPipe(a=0, r=magnetDist);    
    magnetInnerPipe(a=120, r=magnetDist);    
    magnetInnerPipe(a=240, r=magnetDist);    
};

module magnetInnerPipe(a, r) {
    rotate(a=a, v=[0,0,1]) {
        translate([r, 0, 10]) {
        cylinder(r=magnetRadius, h=height, center=false);
        };
    };
};

module swimmerBody() {
    pipe(rInner=rInner, rOuter=rOuter, height=height, center=false);
    magnetPipe(a=0, r=magnetDist);
    magnetPipe(a=120, r=magnetDist);
    magnetPipe(a=240, r=magnetDist);
};

module schwimmer() {
    difference() {
        swimmerBody();
        magnetInnerPipes();
        translate([0,0,height-10]) {
            pipe(rInner=magnetDist-(magnetRadius+0.1), rOuter=magnetDist+(magnetRadius+0.1), height=10, center=false);
        };
    };
};

module top() {
    translate([0,0,5]) {
        pipe(rInner=rInner, rOuter=rOuter, height=2, center=false);
    };
    pipe(rInner=magnetDist-(magnetRadius+0.1), rOuter=magnetDist+(magnetRadius+0.1), height=5, center=false);
};

module magnetPlug() {
    cylinder(h=10.0, r=magnetRadius+0.1, center=false);    
};

module magnetPlugGroup() {
    for (i=[1:3]) {
        translate([i*2*(magnetRadius+1.5),0,0]) {
            magnetPlug();
        };
    };
};

module distanceRing() {
    cylinder(h=2.0, r=magnetRadius-0.2, center=false);
};

module distanceRingGroup() {
    for (i=[1:5]) {
        for (j=[1:5]) {
            translate([i*2*(magnetRadius-0.2),j*2*(magnetRadius-0.2),0]) {
                distanceRing();
            };
        };
    };
};

module scene() {
   // schwimmer();
    translate([0,60,0]) {
      //  top();
    }
    translate([0,-70,0]) {
        distanceRingGroup();
    };
    translate([60,0,0]) {
      //  magnetPlugGroup();
    };
};

scene();