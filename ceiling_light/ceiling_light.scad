lightHeight = 100;

slatWidth = 40;
slatHeight = 5;
slatAngle = 30;

slatCountFront = 3;
slatCountSide = 3;

/*
Place a hole for screw on bottom.
Is needed when you install a bottom plate.
*/
screwBottom = "yes";

module branch() {
  cube([20,20,10]);
};

module top() {
    
};

module body() {
  cube([20,20,lightHeight]);
};

module main() {
  body();
  translate([0,-30,0]) {
    branch(); 
  };
};

main();