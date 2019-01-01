//$fn=50;
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

module cableMount() {
  gap=0.2;
    
  wThick = 2; // wall thickness
  cableGapW = 44-2*gap;
  cableGapD = wThick;
  cableGapH = 20;
  cableDiameter = 10;
  bottomHeight = 1;
  screwDiameter = 2.3;

  difference() {
  union() {
  // entry wall
  translate([0, 0, bottomHeight]) {
    cube([cableGapW, cableGapD, cableGapH]);
  };

  // plate
  translate([0,0+gap,bottomHeight]) {
    cube([cableGapW,60-2*gap,wThick]);
  };
  // bottom plate 1
  translate([0,10+gap,0]) {
    cube([cableGapW,15-2*gap,bottomHeight]);
  };
  // bottom plate 2
  translate([0,10+15+10+gap,0]) {
    cube([cableGapW,15-2*gap,bottomHeight]);
  };

  translate([0,10,bottomHeight+wThick]) {
  cableClamp(
    cableDiameter=6,
    screwDiameter=2.3,
    screwDistance=11,
    width=16,
    depth=4,
    height=7,
    ingress=1);
  };
  
  translate([11-gap,14,bottomHeight+wThick]) {
  cableClamp(
    cableDiameter=8,
    screwDiameter=2.3,
    screwDistance=13,
    width=18,
    depth=4,
    height=7,
    ingress=1);
  };
  
  translate([cableGapW-20,10,bottomHeight+wThick]) {
  cableClamp(
    cableDiameter=10,
    screwDiameter=2.3,
    screwDistance=15,
    width=20,
    depth=4,
    height=7,
    ingress=1);
  };
  }; // end union
  
  // left cable
  translate([8,0,wThick+bottomHeight+cableDiameter/2+1]) {
    rotate([-90,0,0]) {
       cylinder(h=cableGapD, r=cableDiameter/2);
    };
  };
  // middle cable
  translate([20-gap,0,wThick+bottomHeight+cableDiameter/2+1]) {
    rotate([-90,0,0]) {
       cylinder(h=cableGapD, r=cableDiameter/2);
    };
  };
  // right cable
  translate([cableGapW-10,0,wThick+bottomHeight+cableDiameter/2+1]) {
    rotate([-90,0,0]) {
       cylinder(h=cableGapD, r=cableDiameter/2);
    };
  };
  
  // holes for screws
  for(i = [0:2]) {
    translate([0-gap, i*25, bottomHeight]) {
      for(i = [1:4]) {
        translate([i*10-3, 5, 0]) {
          cylinder(r=(screwDiameter+.3)/2, h=wThick);
        };
      };
    };
  };
  
  }; // end difference
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

module displayCover() {
  dispWidth = 28.6;
  dispDepth = 27.4;
  dispHeight = 5;
  thick = 2;
  screwDist = 50;
  screwDepth = 10;
  
  // body  
  difference() {
    translate([-thick, -thick, 0]) {
      cube([dispWidth+2*thick, dispDepth+2*thick, dispHeight+thick]);
    };
    translate([dispWidth/2-(dispWidth-2*thick)/2, -thick, 0]) {
      cube([dispWidth-2*thick, dispDepth+2*thick, dispHeight+thick]);      
    };
    translate([0, 0, thick]) {
      cube([dispWidth, dispDepth, dispHeight]);
    };
  };
  // display support 2.2
  translate([0, 0, thick]) {
    cube([thick, thick, thick+.5]);
  };
  translate([dispWidth-thick, 0, thick]) {
    cube([thick, thick, thick+.5]);
  };
  translate([0, dispDepth-thick, thick]) {
    cube([thick, thick, thick+.5]);
  };
  translate([dispWidth-thick, dispDepth-thick, thick]) {
    cube([thick, thick, thick+.5]);
  };
  // screw support
  difference() {
    translate([dispWidth/2-(screwDist+screwDepth)/2,   dispDepth/2-(screwDepth)/2, 0]) {
      cube([screwDist+screwDepth, screwDepth, thick]);
    };
    translate([dispWidth/2-screwDist/2,   dispDepth/2, 0]) {
      cylinder(r=2.6/2, h=thick);
    };
    translate([dispWidth/2+screwDist/2,   dispDepth/2, 0]) {
      cylinder(r=2.6/2, h=thick);
    };
  };
};

module displayCover2() {
  dispWidth = 28.6;
  dispDepth = 27.4;
  dispHeight = 5;
  thick = 2;
  screwDist = 50;
  screwDepth = 10;
  
  // body  
  difference() {
    translate([-thick, -thick, 0]) {
      cube([dispWidth+2*thick, dispDepth+2*thick, dispHeight+thick]);
    };
    translate([dispWidth/2-(dispWidth-2*thick)/2, -thick, 0]) {
      cube([dispWidth-2*thick, dispDepth+thick, dispHeight+thick]);      
    };
    translate([0, 0, thick]) {
      cube([dispWidth, dispDepth, dispHeight]);
    };
  };
  translate([0, dispDepth+thick-26, 0]) {
    cube([dispWidth, thick, thick+thick+.5]);
  };
  // display support 2.2
  translate([0, 0, thick]) {
    cube([thick, thick, thick+.5]);
  };
  translate([dispWidth-thick, 0, thick]) {
    cube([thick, thick, thick+.5]);
  };
  translate([0, dispDepth-thick, thick]) {
    cube([thick, thick, thick+.5]);
  };
  translate([dispWidth-thick, dispDepth-thick, thick]) {
    cube([thick, thick, thick+.5]);
  };
  // screw support
  difference() {
    translate([dispWidth/2-(screwDist+screwDepth)/2,   dispDepth/2-(screwDepth)/2, 0]) {
      cube([screwDist+screwDepth, screwDepth, thick]);
    };
    translate([dispWidth/2-(dispWidth-2*thick)/2, -thick, 0]) {
      cube([dispWidth-2*thick, dispDepth+thick, dispHeight+thick]);
    };
    translate([dispWidth/2-screwDist/2,   dispDepth/2, 0]) {
      cylinder(r=2.6/2, h=thick);
    };
    translate([dispWidth/2+screwDist/2,   dispDepth/2, 0]) {
      cylinder(r=2.6/2, h=thick);
    };
  };
};

/*
* visible Display 33.6 x 17.3
*/
module displayMount(width, depth) {
  mWidth = width;
  mDepth = depth;
  mHeight = 2;
  mockWidth = 5;
  mockWidth2 = 17; // with holes
  mockBottomWidth2 = 5; // bottom part of mock with holes
  mockDepth = 11;
  mockGap = 24;
  mockGap2 = 1.5; // depth bottom top
  diameterHole = 2.6;
  mockHeight = 1.6;

  // base
  difference() {
    cube([mWidth, mDepth, mHeight]);
    // top
    for(i = [0:(mWidth/20)+1]) {
      translate([i*20-10, 0, 0]){
        cube([13, mockGap2, mHeight]);
      };
    };
    translate([0, 0, mockHeight]){
      cube([mWidth, mockGap2, mHeight-mockHeight]);
    };
    // bottom
    for(i = [0:(mWidth/20)+1]) {
      translate([i*20-10, mDepth-mockGap2, 0]){
        cube([13, mockGap2, mHeight]);
      };
    };
    translate([0, mDepth-mockGap2, mockHeight]){
      cube([mWidth, mockGap2, mHeight-mockHeight]);
    };
    // low ground for display
    translate([width/2, depth/2, mHeight/2+.5]){
    translate([0, -(25-32/2), 0]){
      cube([34, 32, mHeight-.5], center=true);
    };
    // visible Display
    translate([0, -(25-32/2)-(27.4/2-(4+14.8/2)), -.5]){
      cube([25.6, 14.8, 2], center=true);      
    };
    // screw Display cover
    translate([0, -(25-32/2), 0]){
      cube([60, 10, mHeight-.5], center=true);
    };
    // buttons
    translate([0, 14, 0]){
      cube([58, 22, mHeight-.5], center=true);      
    };
    };
  };
  
  // screw Display cover
  translate([width/2, depth/2, .5]){
    // Display
    translate([20, -(25-32/2)-5, 0]){
      difference() {
        cube([10, 10, 5], center=false);
        translate([5,5,0]) {
        cylinder(r=2.3/2, h=5);
      };
      };
    };
    translate([-30, -(25-32/2)-5, 0]){
      difference() {
        cube([10, 10, 5], center=false);
        translate([5,5,0]) {
        cylinder(r=2.3/2, h=5);
      };
      };
    };
    // Buttons
    translate([58.4/2-10/2, 1, 0]){
      difference() {
        cube([10, 10, 9], center=false);
        translate([5,5,0]) {
        cylinder(r=2.3/2, h=9);
      };
      };
    };
    translate([-58.4/2-10/2, 1, 0]){
      difference() {
        cube([10, 10, 9], center=false);
        translate([5,5,0]) {
        cylinder(r=2.3/2, h=9);
      };
      };
    };
  };

  // display cubes
  translate([width/2, depth/2-(25-32/2), .5]){
    translate([28.6/2-2, 27.4/2-2, 0]){
      cube([2, 2, 1.6], center=false);
    };
    translate([-28.6/2, 27.4/2-2, 0]){
      cube([2, 2, 1.6], center=false);
    };
    translate([28.6/2-2, -27.4/2, 0]){
      cube([2, 2, 1.6], center=false);
    };
    translate([-28.6/2, -27.4/2, 0]){
      cube([2, 2, 1.6], center=false);
    };
  };

  // right mock (no screws)
  // first
  translate([-mockWidth, mDepth/2+(mockGap/4+mockGap/2), 0]) {
    cube([mockWidth, mDepth/2-(mockGap/4+mockGap/2)-mockGap2, mHeight]);
  };
  // middle
  translate([-mockWidth, mDepth/2-mockDepth/2, 0]) {
    cube([mockWidth, mockDepth, mHeight]);
  };
  // last
  translate([-mockWidth, mockGap2, 0]) {
    cube([mockWidth, mDepth/2-(mockGap/4+mockGap/2)-mockGap2, mHeight]);
  };

  // left mock (with screw holes)
  translate([mWidth-mockWidth, 0, mHeight]) {
    difference() {
      translate([0, 2, 0]) {
        cube([mockWidth+mockWidth2, mDepth-4, mHeight]);
      };
      // first hole
      translate([mockWidth+mockWidth2-mockBottomWidth2/2, mDepth/2-mockGap, 0]) {
        cylinder(r=diameterHole/2, h=mHeight);
      };
      // middle hole
      translate([mockWidth+mockWidth2-mockBottomWidth2/2, mDepth/2, 0]) {
        cylinder(r=diameterHole/2, h=mHeight);
      };
      // last hole
      translate([mockWidth+mockWidth2-mockBottomWidth2/2, mDepth/2+mockGap, 0]) {
        cylinder(r=diameterHole/2, h=mHeight);
      };
    };
  };
  
  // todo:
  // display gap
  // display distance bolt  
  // display screw bolt
  // button screw bolt

  // back cover for display
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

module cableClamp(
cableDiameter,
screwDiameter,
screwDistance,
width,
depth,
height,
ingress=0 // ingress of cable - 0 .. half cable
) {
    if (cableDiameter==undef) {
        echo("cableDiameter is not set.");
        cableDiameter=10;
    };
    if (screwDiameter==undef) echo("screwDiameter is not set.");
    screwDistance= (screwDistance==undef) ? 2*cableDiameter:screwDistance;
    width= (width==undef) ? 3*cableDiameter : width;
    depth= (depth==undef) ? 2*screwDiameter : depth;
    height= (height==undef) ? .75*cableDiameter : height;
    
    difference() {
        // body
        cube([width,depth,height]);
        
        // cable
		rotate([90,0,0]) {
        translate([width/2,height-ingress,-depth]) {
            cylinder(h=depth, r=cableDiameter/2);
        };
        };
        // cable bay
        translate([width/2-cableDiameter/2,0,height-ingress]) {
            cube([cableDiameter,depth,ingress]);
        };
        // right screw
        translate([width/2+screwDistance/2,depth/2,0]) {
            cylinder(h=height, r=screwDiameter/2);
        };
        // left screw
        translate([width/2-screwDistance/2,depth/2,0]) {
            cylinder(h=height, r=screwDiameter/2);
        };
    };
};

module cableClamp1() {
  cableClamp(
    cableDiameter=6,
    screwDiameter=2.3,
    screwDistance=11,
    width=16,
    depth=4,
    height=5,
    ingress=-1);
};
  
module cableClamp2() {
  cableClamp(
    cableDiameter=8,
    screwDiameter=2.3,
    screwDistance=13,
    width=18,
    depth=4,
    height=5,
    ingress=-1);
};
  
module cableClamp3() {
  cableClamp(
    cableDiameter=10,
    screwDiameter=2.3,
    screwDistance=15,
    width=20,
    depth=4,
    height=5,
    ingress=-1);
};


module main() {
width = 85+50;
depth = 60;
height = 40;
wallThickness = 2;

bottom = false;
middle = false;
top = false;
uiMount = false;
displayCover = false;
displayCover2 = false;
cableMount = false;
//
//bottom = true;
//middle = true;
//top = true;
//uiMount = true;
//displayCover = true;
displayCover2 = true;
//cableMount = true;
//cableClamp1();
//cableClamp2();
//cableClamp3();

// bottom
if (bottom) {
bottomplate(width=width, depth=depth);
};

// middle
if (middle) {
translate([0, -depth-10, 0]) {
  bodyMiddle(width=width, depth=depth, height=30, innerheight=30);
};
};

// UI-Mount
if (uiMount) {
translate([-130, 0, 0]) {
  displayMount(width=98, depth=58);
};
};

// Display Cover
if (displayCover2) {
translate([-130, 70, 0]) {
  displayCover2();
};
};

// Display Cover
if (displayCover) {
translate([-130, 70, 0]) {
  displayCover();
};
};

// Cable-Mount
if (cableMount) {
translate([0, 70, 0]) {
  cableMount();
};
};

// top
if (top) {
translate([-190, -depth-10, 0]) {
  bodyTop(width=width, depth=depth, height=15);
};
};

//slottedHole(diameter=4, length=10, height=4, border=2, angle=0);
//case(bottomThickness=2,wallThickness=2,width=width,depth=depth,height=height);
};

main();