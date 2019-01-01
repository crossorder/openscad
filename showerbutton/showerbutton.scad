$fn = 100;

innerDiameter = 14.5;
shell = 3; // thickness wall
bottom = 2; // thickness bottom
outerDiameter = innerDiameter+2*shell;
buttonDiameter = 30;
mockHeight = 10;
screwDiameter = 5.5;

module showerbutton() {
  difference() {
    union() {
      cylinder(r=outerDiameter/2, h=mockHeight+buttonDiameter/2);
      translate([0,0,mockHeight+buttonDiameter/2]) {
        sphere(r=buttonDiameter/2);
      };
    };
    translate([0,0,bottom]) {
      cylinder(r=innerDiameter/2, h=mockHeight+buttonDiameter);
    };
    cylinder(r=screwDiameter/2, h=bottom);
  };
};

showerbutton();