/*
Copyright 2018 Michael Gläser

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

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
               points=[[0,0,h*1.2], [l,0,h*1.2], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[3,4,0],[5,2,1]]
               );
}

module test() {
difference() {
    
    l=20;
    w=10;
    h=15;
    wallThickness=2;
    
    prism(l, w, h);
    translate([wallThickness, 2*wallThickness, wallThickness]) {
        prism(l-2*wallThickness,
        w-2*wallThickness,
        h-2*wallThickness);
    };
};
};


test();