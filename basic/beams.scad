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

/*
verschiedene Träger
Massiver Traäger, der innen Stützstruktur hat
T-, H-, L-Träger
mit Aussparungen gerade / diagonal usw.
eckig oder rund (Rohrrahmen)
*/

module beam_I(
    beamLength=100, beamHeight=15,
    flangeWidth=10, flangeThickness=2, webThickness=1
) {
    // lower flange
    cube([beamLength, flangeWidth, flangeThickness]);
    // upper flange
    translate([0, 0, beamHeight-flangeThickness]) {
        cube([beamLength, flangeWidth, flangeThickness]);
    };
    // web
    translate([0, flangeWidth/2-webThickness/2, 0]) {
        cube([beamLength, webThickness, beamHeight]);
    };
};

module beam_L(
    beamLength=100, beamHeight=15,
    flangeWidth=10, flangeThickness=2, webThickness=2
) {
    // lower flange
    cube([beamLength, flangeWidth, flangeThickness]);
    // web
    translate([0, 0, 0]) {
        cube([beamLength, webThickness, beamHeight]);
    };
};

module beam_U(
    beamLength=100, beamWidth=10,
    flangeHeight=15, flangeThickness=2, webThickness=2
) {
    // left flange
    cube([beamLength, flangeThickness, flangeHeight]);
    // right flange
    translate([0, beamWidth-flangeThickness, 0]) {
        cube([beamLength, flangeThickness, flangeHeight]);
    };
    // web
    cube([beamLength, beamWidth, webThickness]);
};

module beam_T(
    beamLength=100, beamHeight=15,
    flangeWidth=10, flangeThickness=2, webThickness=1
) {
    // upper flange
    translate([0, 0, beamHeight-flangeThickness]) {
        cube([beamLength, flangeWidth, flangeThickness]);
    };
    // web
    translate([0, flangeWidth/2-webThickness/2, 0]) {
        cube([beamLength, webThickness, beamHeight]);
    };
};

module showroom() {
    translate([0, 0, 0]) {
        beam_I();
    };
    translate([0, 15, 0]) {
        beam_L();
    };
    translate([0, 30, 0]) {
        beam_U();
    };
    translate([0, 45, 0]) {
        beam_T();
    };
};

showroom();


