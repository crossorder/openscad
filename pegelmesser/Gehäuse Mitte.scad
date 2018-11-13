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

module screwGap(action="add", diameterBolt, diameterScrew, height) {
  diffH=5;
  if (action=="add") {
    difference() {
      cylinder(r=diameterBolt/2, h=height);
      translate([0,0,height-diffH]) {
        cylinder(r=3, h=diffH);
      };
      cylinder(r=diameterScrew/2, h=height-diffH);
    };
  };
  if (action=="remove") {
    cylinder(r=diameterBolt/2, h=height);
  };
};

/*
* heightTop - height of case top
*/
module screwGapCase(action="add", width, depth, heightTop) {
  diameterBolt=10;
  diameterScrew=2.2;
  height=heightTop+3;
  xdif=diameterBolt/2+9;
  
  translate([-xdif, depth/2, 0]) {
    screwGap(action=action, diameterBolt=diameterBolt, diameterScrew=diameterScrew, height=height);
  };  
  translate([xdif+width, depth/2, 0]) {
    screwGap(action=action, diameterBolt=diameterBolt,diameterScrew=diameterScrew, height=height);
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

module cubeWithHoles() {
    
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
module bodyMiddle(width, depth, height, innerheight) {
  wThick = 2; // wall thickness
  gap = 0.15;

  cableGapW = 44;
  cableGapD = wThick;
  cableGapH = 20;
    
  difference() {
    plate(width, depth+2*wThick+2*gap, height, 19+wThick+gap);
    translate([0, wThick, 0]) {
      plate(width, depth+2*gap, innerheight, 19+gap);
    };
    translate([3, 0, 5]) {
      cube([cableGapW, cableGapD, cableGapH]);
    };
  };
};

/*
* visible Display 33.6 x 17.3
*/
module displayMount() {
  cube([100, 60, 2]);
};

module buttonMount() {
  cube([20, 20, 5]);
};

module uiMount() {
  displayMount();
  buttonMount();
};

module uiMountHolder(displayW, displayD, gap) {
  thick = 2; // holder thickness (top / bottom)
  thick2 = 5; // holder thickness (left / right)
  height = 6; // general height
  dist2glass = 2.5;
  diameterScrew=2.2;
  
  // top
  translate([0, displayD+gap-thick, -height]) {
    difference() {
      cube([displayW, thick, height-dist2glass]);
      for(i = [0:displayW/20]) {
        translate([i*20, 0, 0]){
          cube([10, thick, height-dist2glass]);
        };
      };
    };
  };
  // bottom
  translate([0, -gap, -height]) {
    difference() {
      cube([displayW, thick, height-dist2glass]);
      for(i = [0:displayW/20]) {
        translate([i*20, 0, 0]){
          cube([10, thick, height-dist2glass]);
        };
      };
    };
  };
  // left
  translate([-(thick2+10), -gap, -dist2glass]) {
    difference() {
      cube([thick2, displayD+2*gap, dist2glass]);
      for(i = [0:displayD/24]) {
        translate([thick2/2, i*24+6+gap, 0]) {
          cylinder(r=diameterScrew/2, h=dist2glass);
        };
      };
      for(i = [0:displayD/24-1]) {
        translate([0, i*24+12+gap, 0]){
          cube([thick2, 12, dist2glass]);
        };
      };
    };
  };
  // right
  translate([displayW, -gap, -height]) {
    difference() {
      cube([thick2, displayD+2*gap, height]);
      for(i = [0:displayD/24]) {
        translate([0, i*24+gap, height-dist2glass]){
          cube([thick2, 12, dist2glass]);
        };
      };
    };
  };
};

/*
* body
* body border
* screw holes
* display gap
* ui mount
*/
module bodyTop(width, depth, height){
  wThick1 = 2; // wall thickness
  wThick2 = 1.5; // border wall thickness
  gap = 0.15;
  borderH = 3; // border outer height
  borderInnerH = 8; // border inner height
  heightBody = height+borderH;

  displayW = 96; // display width
  displayD = 56; // display depth
  displayB = 2; // display border

  // body + border
  difference() {
    // body
    plate(width, depth+2*wThick1+2*gap, heightBody, 19+wThick1+gap);
    // inner gap
    translate([0, wThick1+wThick2, 0]) {
      plate(width, depth+2*gap-2*wThick2, heightBody-wThick1, 19+gap-wThick2);   
    };
    // inner border gap
    translate([0, wThick1, borderInnerH]) {
      plate(width, depth+2*gap, heightBody-(borderInnerH+wThick1), 19+gap);
    };
    // outer border gap
    difference() {
      plate(width, depth+2*wThick1+2*gap, borderH, 19+wThick1+gap);
      translate([0, wThick1, 0]) {
        plate(width, depth+2*gap, borderH, 19+gap);
      };
    };
    // display gap, smaller gap
    translate([width/2-displayW/2, wThick1+gap+displayB, heightBody-wThick1]) {
        cube([displayW, displayD, wThick1]);
    };
    // display gap, bigger gap
    translate([width/2-(displayW+2*displayB)/2, wThick1, heightBody-wThick1]) {
        cube([(displayW+2*displayB), (displayD+2*displayB)+2*gap, wThick1-.5]);
    };
    // screw holes remove
    translate([0, wThick1+gap, 0]) {
      screwGapCase(action="remove", width=width, depth=depth, heightTop=height);
    };
  };
  // screw holes add
  translate([0, wThick1+gap, 0]) {
    screwGapCase(action="add", width=width, depth=depth, heightTop=height);
  };
  // ui mount holder
  translate([width/2-(displayW+2*displayB)/2, wThick1+gap, heightBody-wThick1]) {
    uiMountHolder(displayW=displayW+2*displayB, displayD=displayD+2*displayB, gap=gap);
  };
};

module main() {
width = 85+50;
depth = 60;
height = 40;
wallThickness = 2;

/*
bottomplate(width=width, depth=depth);

translate([0, -depth-10, 0]) {
  bodyMiddle(width=width, depth=depth, height=30, innerheight=30);
};

translate([-130, 0, 0]) {
  uiMount();
};*/

translate([-190, -depth-10, 0]) {
  bodyTop(width=width, depth=depth, height=15);
};

//slottedHole(diameter=4, length=10, height=4, border=2, angle=0);
//case(bottomThickness=2,wallThickness=2,width=width,depth=depth,height=height);
};

main();