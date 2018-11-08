bodyWidth = 130;
bodyDepth = 80;
bodyHeight = 40;

shellThickness = 4;
glassThickness = 2.1;

inlayHeight = 18;

module bottom() {
  borderThickness = 1.5;
  difference() {
    cube([bodyWidth, bodyDepth, bodyHeight]);
    // upper clearance
    translate([shellThickness,
            shellThickness,
            bodyHeight-(2*glassThickness+inlayHeight)]) {
      cube([
        bodyWidth-2*shellThickness,
        bodyDepth-2*shellThickness,
        2*glassThickness+inlayHeight]);
    };
    // lower clearance
    translate([shellThickness+borderThickness,
            shellThickness+borderThickness,
            shellThickness]) {
      cube([
        bodyWidth-2*shellThickness-2*borderThickness,
        bodyDepth-2*shellThickness-2*borderThickness,
        bodyHeight-(shellThickness+2*glassThickness+inlayHeight)]);
    };
  };
}

module bridge() {
  translate([
    bodyWidth/2-.5*shellThickness,
    shellThickness,
    shellThickness]) {
      cube([
        shellThickness,
        bodyDepth-2*shellThickness,
        bodyHeight-shellThickness-2*glassThickness]);
  };
}

module body() {
  difference() {
    bottom();
    // Nut für Glasscheibe
    translate([
        shellThickness/2,
        shellThickness/2,
        bodyHeight-2*glassThickness
    ]) {
      cube([
        bodyWidth-shellThickness,
        bodyDepth,
        glassThickness
        ]);
    };
  };
  bridge();
}

module displayHolder(width, depth, height, wallThickness) {
    // Leiterplatte 38,8 mm x 28,7 mm x 1,7 mm
    pcbWidth = 38.8;
    pcbDepth = 28.7;
    pcbHeight = 1.7;
    pinHeaderHeightFemale = 8.3;
    pinHeaderHeightMale = 2.5;
    displayHeight = 2.8;
    distancePcbToBorder = 10.0;
    distanceHeaderSide = 1.5;
    displayButtonsDepth = 53;
    headerGap = 0.3;

  // height of pcb over bottom line
  h1 = height-(displayHeight+pinHeaderHeightMale+pinHeaderHeightFemale+pcbHeight);

  difference() {
    cube([width,depth,height]);
    // pcb rails
    translate([wallThickness,0,h1]) {
      cube([pcbWidth,pcbDepth+distancePcbToBorder, pcbHeight]);
    };
    // pcb header space
    translate([wallThickness+distanceHeaderSide,0,0]) {
      cube([pcbWidth-(2*distanceHeaderSide),
        depth-wallThickness,
        h1+pcbHeight+pinHeaderHeightFemale+headerGap]);
    };
    // display space
    translate([wallThickness,distancePcbToBorder,height-displayHeight]) {
      cube([pcbWidth,
        displayButtonsDepth,
        displayHeight]);
    };
    // pcb display space
    translate([wallThickness+5,
    distancePcbToBorder,
    h1+pcbHeight+pinHeaderHeightFemale+headerGap]) {
      cube([pcbWidth-10,
        displayButtonsDepth,
        pinHeaderHeightMale-headerGap]);
    };
    translate([wallThickness,
    distancePcbToBorder,
    h1+pcbHeight+pinHeaderHeightFemale+headerGap]) {
      cube([pcbWidth,
        displayButtonsDepth-5,
        pinHeaderHeightMale-headerGap]);
    };
  };
};

module inlay() {
  width = bodyWidth-2*shellThickness;
  depth = bodyDepth-2*shellThickness;
  height = inlayHeight;
  wallThickness = 2;
  holderWidth = 38.8+2*wallThickness;
    
  difference() {
    // body
    cube([width,depth,height]);
    //// remove inner body
    //translate([wallThickness,wallThickness,0]) {
    //  cube([
    //    width-2*wallThickness,
    //    depth-2*wallThickness,
    //    height-wallThickness]);
    //};
    // remove inner body
    translate([2*wallThickness,0,0]) {
      cube([
        width-2*2*wallThickness,
        depth,
        height-wallThickness]);
    };
    // remove inner body
    translate([0,2*wallThickness,0]) {
      cube([
        width,
        depth-2*2*wallThickness,
        height-wallThickness]);
    };
    // make space for display holder
    translate([(width-holderWidth)/2,0,0]) {
      cube([
        holderWidth,
        depth,
        height]);
    };
  };
  // insert display holder
  translate([(width-holderWidth)/2,0,0]) {
    displayHolder(holderWidth, depth, height, wallThickness);
  };
}

module onlyDisplayHolder() {
  width = bodyWidth-2*shellThickness;
  depth = bodyDepth-2*shellThickness;
  height = inlayHeight;
  wallThickness = 2;
  holderWidth = 38.8+2*wallThickness;
  displayHolder(holderWidth, depth, height, wallThickness);    
}

//body();
//inlay();
onlyDisplayHolder();
