// -------------------------------------------------------------
// Parameters valid for 433MHz ISM band antenna
//
// -------------------------------------------------------------
// Dimensions calculated with John Coppens webpage java script
// @ http://jcoppens.com/ant/qfh/calc.en.php
// Input params:
// Center frequency = 433 MHz  (443.4 MHz designed)
// Numbers of turns = 0.5
// Length of one turn = 1 lambda
// Bending radius = 2 mm
// Conductor diameter = 0.6 mm
// Width/height ratio = 0.84
//
// -------------------------------------------------------------
/*
$fn=20;


D1 = 123.2; // mm large helix1 diameter.
D2 = 117.1; // mm small helix2 diameter.
HH1 = 146.6; // mm height of H1.
HH2 = 139.4; // mm height of H2.

WIRE = 1; // mm diameter.

CYLH = 150; // mm height of support cylinder.
SLICES = 20;
EXTRUSION_WIDTH=0.67;
pedestal_height = 1;

*/

//####################################################################################

// -------------------------------------------------------------
// Parameters valid for 868MHz ISM band antenna
//
// Dimensions calculated with John Coppens webpage java script
// @ http://jcoppens.com/ant/qfh/calc.en.php
// Input params:
// Center frequency = 913 MHz
// Numbers of turns = 0.5
// Length of one turn = 1
// Bending radius = 1.5 mm
// Conductor diameter = 0.6 mm
// Width/height ratio = 0.44
//
// -------------------------------------------------------------


/*$fn=20;

D1 = 47.4; // mm large helix1 diameter.
D2 = 45.1; // mm small helix2 diameter.
HH1 = 107.9; // mm height of helix1.
HH2 = 102.6; // mm height of helix2.

WIRE = 1; // mm diameter.

CYLH = 118; // mm height of support cylinder.

SLICES = 20;
EXTRUSION_WIDTH=0.67;
pedestal_height = 1;
*/

// More robust lower variant

// Dimensions calculated with John Coppens webpage java script
// @ http://jcoppens.com/ant/qfh/calc.en.php
// Input params:
// Center frequency = 907.8 MHz
// Numbers of turns = 0.5
// Length of one turn = 1
// Bending radius = 1.5 mm
// Conductor diameter = 0.6 mm
// Width/height ratio = 0.85
//
// -------------------------------------------------------------


$fn=20;

D1 = 60.5; // mm large helix1 diameter.
D2 = 57.5; // mm small helix2 diameter.
HH1 = 71.1; // mm height of helix1.
HH2 = 67.6; // mm height of helix2.

WIRE = 0.8; // mm diameter.

CYLH = 80; // mm height of support cylinder.

SLICES = 20;
EXTRUSION_WIDTH=0.67;
pedestal_height = 1;
