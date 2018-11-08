$fn=100;

module screwBolt(diameterBolt, diameterScrew, height) {
  difference() {
    cylinder(r=diameterBolt/2, h= height);
    cylinder(r=diameterScrew/2, h= height);
  };
};

module main() {
translate([0, 0, 0]) {
screwBolt(6, 2.2, 5);
};
translate([10, 0, 0]) {
screwBolt(8, 2.2, 5);    
}
translate([20, 0, 0]) {
screwBolt(10, 2.2, 5);    
}
translate([0, 10, 0]) {
screwBolt(6, 2.5, 5);    
}
translate([10, 10, 0]) {
screwBolt(8, 2.5, 5);    
}
translate([20, 10, 0]) {
screwBolt(10, 2.5, 5);    
}
translate([0, 20, 0]) {
screwBolt(6, 3, 5);    
}
translate([10, 20, 0]) {
screwBolt(8, 3, 5);    
}
translate([20, 20, 0]) {
screwBolt(10, 3, 5);    
}
};

main();