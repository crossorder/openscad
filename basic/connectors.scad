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

module beam_V_Female(
    beamLength=100, beamWidth=15, beamHeight=10,
    upperFlangeWidth=0, lowerFlangeWidth=0, flangeHeight=0
) {

    upperFlangeWidth= upperFlangeWidth==0 ? (beamWidth/3)*2 : upperFlangeWidth;
    lowerFlangeWidth= lowerFlangeWidth==0 ? upperFlangeWidth*.8 : lowerFlangeWidth;
    flangeHeight= flangeHeight==0 ? upperFlangeWidth/2 : flangeHeight;

    difference() {
    // base
    cube([beamLength, beamWidth, beamHeight]);
    // flange
    translate([0, beamWidth/2, 0]) {
        polyhedron(
            points=[
                [0,lowerFlangeWidth/2,0], [0,-lowerFlangeWidth/2,0], [0,-upperFlangeWidth/2,flangeHeight], [0,upperFlangeWidth/2,flangeHeight],
                [beamLength,lowerFlangeWidth/2,0], [beamLength,-lowerFlangeWidth/2,0], [beamLength,-upperFlangeWidth/2,flangeHeight], [beamLength,upperFlangeWidth/2,flangeHeight]
            ],
            faces=[[0,1,2,3],[0,3,7,4],[1,5,6,2],[3,2,6,7],[0,4,5,1],[7,6,5,4]]
        );
    };
};
};

module beam_V_Male(
    beamLength=100, beamWidth=15, beamHeight=10,
    upperFlangeWidth=0, lowerFlangeWidth=0, flangeHeight=0
) {
    
    upperFlangeWidth= upperFlangeWidth==0 ? (beamWidth/3)*2 : upperFlangeWidth;
    lowerFlangeWidth= lowerFlangeWidth==0 ? upperFlangeWidth*.8 : lowerFlangeWidth;
    flangeHeight= flangeHeight==0 ? upperFlangeWidth/2 : flangeHeight;
    
    // base
    cube([beamLength, beamWidth, beamHeight-flangeHeight]);
    // flange
    translate([0, beamWidth/2, beamHeight-flangeHeight]) {
        polyhedron(
            points=[
                [0,lowerFlangeWidth/2,0], [0,-lowerFlangeWidth/2,0], [0,-upperFlangeWidth/2,flangeHeight], [0,upperFlangeWidth/2,flangeHeight],
                [beamLength,lowerFlangeWidth/2,0], [beamLength,-lowerFlangeWidth/2,0], [beamLength,-upperFlangeWidth/2,flangeHeight], [beamLength,upperFlangeWidth/2,flangeHeight]
            ],
            faces=[[0,1,2,3],[0,3,7,4],[1,5,6,2],[3,2,6,7],[0,4,5,1],[7,6,5,4]]
        );
    };
};

module showroom() {
    translate([0, 0, 0]) {
        beam_V_Male();
    };
    translate([0, 20, 0]) {
        beam_V_Female();
    };  
};

showroom();