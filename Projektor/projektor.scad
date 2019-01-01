$fn=100;

diameterPipe = 10;
thickness = 2;
height = 20;
partitionDepth = 0.65*diameterPipe+thickness;

diameterBit = 3;
heightBit = 3;

module projektorClip() {
    difference() {
        cylinder(r=(diameterPipe/2)+thickness, h=height, center = true);
        cylinder(r=diameterPipe/2, h=height, center=true);
        translate([-(diameterPipe/2+thickness), 
                -(diameterPipe+2*thickness)/2,
                -height/2]) {
            cube([diameterPipe+2*thickness-partitionDepth,
                    diameterPipe+2*thickness,
                    height],
                 center=false);
        };
for(angle=[-135, 135]){
rotate(v=[0,0,1], a=angle) {
        translate([diameterPipe/2, 
                -(diameterPipe+2*thickness)/2,
                -(height+1)/2]) {
            cube([diameterPipe+2*thickness-partitionDepth,
                    diameterPipe+2*thickness,
                    (height+1)],
                 center=false);
        };
    };
    };
};
    rotate(v=[0,1,0], a=90) {
        translate([0,0,diameterPipe/2-heightBit]) {
            cylinder(r=diameterBit/2, h=heightBit);
        };        
    };
};

projektorClip();