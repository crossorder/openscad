module gripRecess01(
  width=10,
  height=10,
  wallThickness=2,
  gripDepth=5
) {
  // make a default grip recess and finally scale it accordingly to width and height
  // outer sphere
  // inner sphere
  // cut on top
  // cut on front
  // sourrounding wall

  // scale it
  scale([width, height, wallThickness]) {
  
  // base
  cube([width, wallThickness, height]);
    // sphere
    sphere($fn = 0, $fa = 12, $fs = 2, r = 1);

    };
  };
