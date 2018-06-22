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
  //scale([width, height, wallThickness]) {
  
    // base
    cube([1, 1, 1]);
    // sphere
    sphere(r = 10);

  //};
};

module gripRecess02() {
    
}

//gripRecess01();

 module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[3,4,0],[5,2,1]]
               );
}

module test() {
difference() {
prism(10, 10, 10);
    translate([1, 1, 0]) {
prism(8, 8, 8);
    };
};
};

test();