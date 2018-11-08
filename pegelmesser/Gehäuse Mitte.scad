$fn=50;
$fn=150;

module case(
bottomThickness,
wallThickness,
// inner size
width,
depth,
height
) {
  difference() {
    minkowski() {
      cube([width,depth,height]);
      cylinder(r=2,h=bottomThickness);
    }
    translate([0,0,bottomThickness]) {
      cube([width,depth,height]);
    };
  }
}

/*
slotted hole
*/
module slottedHole(action="all", diameter=6, length=10, height=1, border=2, angle=0) {
  rotate(a=angle) {
    if (action=="all") {
    difference() {
      slottedHoleBase(diameter+2*border, length, height);
      slottedHoleBase(diameter, length, height);
    };
};
    if (action=="add") {
      slottedHoleBase(diameter+2*border, length, height);
    };
    if (action=="remove") {
      slottedHoleBase(diameter, length, height);
    };
  };
};

module slottedHoleBase(diameter=5, length=10, height=1) {
  cylinder(r=diameter/2, h=height);
  translate([-diameter/2, 0, 0]) {
    cube([diameter, length, height]);
  };
  translate([0, length, 0]) {
    cylinder(r=diameter/2, h=height);
  };    
};

module plate(width, depth, bottomThickness=2, elbow) {
  cube([width, depth, bottomThickness]);
  translate([0, depth/2, 0]) {
    resize(newsize=[2*elbow, depth, bottomThickness]) {
      cylinder(r=depth/2, h=bottomThickness);
    };
  };
  translate([width, depth/2, 0]) {
    resize(newsize=[2*elbow, depth, bottomThickness]) {
      cylinder(r=depth/2, h=bottomThickness);
    };
  };
};

module bottomplate(width,depth,bottomThickness=2) {    
  difference() {
    union() {
      plate(width=width, depth=depth, bottomThickness=2, elbow=19);
      installationHoles(action="add", width=width, depth=depth);
    };
    installationHoles(action="remove", width=width, depth=depth);
  };
  screwBoltCase(width,depth,bottomThickness);
  translate([50, 2, 2]) {
    screwBoltRelais();
  };
  translate([50, 2, 2]) {
    pcbSupport();
  };
  translate([0, 0, 2]) {
    cableEntry();
  };
};

module installationHoles(action="all", width, depth) {
  holeDiameter=4;
  holeLength=10;
  holeHeight=4;
  holeBorder=2;
  xdif=holeDiameter/2+holeBorder;

  // bottom left
  translate([-xdif, 6, 0]) {
  slottedHole(action=action, diameter=holeDiameter, length=holeLength, height=holeHeight, border=holeBorder, angle=30);
  };
  // top left
  translate([-xdif, depth-6, 0]) {
  slottedHole(action=action, diameter=holeDiameter, length=holeLength, height=holeHeight, border=holeBorder, angle=180-30);
  };
  // bottom right
  translate([width+xdif, 6, 0]) {
  slottedHole(action=action, diameter=holeDiameter, length=holeLength, height=holeHeight, border=holeBorder, angle=-30);
  };
  // top right
  translate([width+xdif, depth-6, 0]) {
  slottedHole(action=action, diameter=holeDiameter, length=holeLength, height=holeHeight, border=holeBorder, angle=180+30);
  };
  // middle left
  translate([-xdif, (depth/2)-holeLength/2, 0]) {
  slottedHole(action=action, diameter=holeDiameter, length=holeLength, height=holeHeight, border=holeBorder, angle=0);
  };
  // middle right
  translate([width+xdif, (depth/2)-holeLength/2, 0]) {
  slottedHole(action=action, diameter=holeDiameter, length=holeLength, height=holeHeight, border=holeBorder, angle=0);
  };
};

module screwBoltCase(width, depth, bottomThickness) {
  diameterBolt=10;
  diameterScrew=2.2;
  height=20;
  xdif=diameterBolt/2+9;
  translate([-xdif, depth/2, 0]) {
    screwBolt(diameterBolt=diameterBolt, diameterScrew=diameterScrew, height=height);
  };  
  translate([xdif+width, depth/2, 0]) {
    screwBolt(diameterBolt=diameterBolt, diameterScrew=diameterScrew, height=height);
  };  
};

 module screwBoltRelais() {
  diameterBolt=8;
  diameterScrew=2.2;
  height=5;
     
  zz=25.4; // Zoll

  // set position with origin pcb
  translate([.2*zz, .95*zz, 0]) {
  translate([0, 0, 0]) {
    screwBolt(diameterBolt=diameterBolt, diameterScrew=diameterScrew, height=height);
  };
  translate([1.925*zz, 0, 0]) {
    screwBolt(diameterBolt=diameterBolt, diameterScrew=diameterScrew, height=height);
  };
  translate([0, .55*zz, 0]) {
    screwBolt(diameterBolt=diameterBolt, diameterScrew=diameterScrew, height=height);
  };
  translate([1.925*zz, .55*zz, 0]) {
    screwBolt(diameterBolt=diameterBolt, diameterScrew=diameterScrew, height=height);
  };
  };
};

module pcbSupport() {
  h=5;
  translate([8, 10, 0]) {
    cube([6,4,h]);
  };
  translate([10, 53, 0]) {
    cube([70,3,h]);
  };
  translate([68, 8, 0]) {
    cube([5,2,h]);
  };
  translate([73, 20, 0]) {
    cube([2,6,h]);
  };
};

module cableEntry() {
  diameterScrew=2.2;
  depth=60;
  h=5;
  translate([0, 0, 0]) {
    cube([3,depth,h+2]);
  };
  translate([50-3, 0, 0]) {
    cube([3,depth,h+2]);
  };
  for(i = [0:2]) {
    translate([3, i*25, 0]) {
    difference() {
      cube([44, 10, h]);
      for(i = [1:4]) {
        translate([i*10-3, 5, 0]) {
          cylinder(r=diameterScrew/2, h=5);
        };
      };
    };
    };
  };
};

module screwBolt(diameterBolt, diameterScrew, height) {
  difference() {
    cylinder(r=diameterBolt/2, h= height);
    cylinder(r=diameterScrew/2, h= height);
  };
};

/*
* Mittelteil
*/
module body(width, depth, heigth, innerheight) {
  wThick = 2; // wall thickness
  gap = 0.15;
    
  cableGapW = 44;
  cableGapD = wThick;
  cableGapH = 20;
    
  difference() {
    plate(width, depth+2*wThick+2*gap, heigth, 19+wThick+gap);
    translate([0, wThick, 0]) {
      plate(width, depth+2*gap, innerheight, 19+gap);
    };
    translate([3, 0, 5]) {
      cube([cableGapW, cableGapD, cableGapH]);
    };
  };
};

module main() {
width = 85+50;
depth = 60;
height = 40;
wallThickness = 2;


//bottomplate(width=width, depth=depth);

translate([0, -depth-10, 0]) {
  body(width=width, depth=depth, heigth=30, innerheight=30);
};

//slottedHole(diameter=4, length=10, height=4, border=2, angle=0);
//case(bottomThickness=2,wallThickness=2,width=width,depth=depth,height=height);
};

main();