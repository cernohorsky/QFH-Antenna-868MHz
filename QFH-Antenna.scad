
// OpenSCAD script for a "quadrifilar helix antenna".
// The design originated in: http://www.thingiverse.com/thing:634205

PI = 3.14159265358979;

include <parameters.scad>

CYLH2 = CYLH/2; // the half-height of the support cylinder.

HWIRE11 = CYLH2-HH1/2; // place the four hole-pairs at these heights.
HWIRE12 = CYLH2-HH2/2;
HWIRE21 = CYLH2+HH1/2;
HWIRE22 = CYLH2+HH2/2;

lightening_hole_size = (D1 * PI)/15;
lightening_hole_num = floor(CYLH/lightening_hole_size);

// some internal calculations. quite hairy math.
THETA1 = atan2(HH1,D1*PI/2); // Thetas are used for projecting the wirechannel cross-section onto the xy-plane.
THETA2 = atan2(HH2,D2*PI/2);
echo("theta1=",THETA1,"  -  theta2=",THETA2);

XSI1 = ((CYLH/HH1*180)-180); // extra rotation beyond the height of helix1. half above, half below.
XSI2 = ((CYLH/HH2*180)-180); // extra rotation beyond the height of helix2.
echo("xsi1=",XSI1," - xsi2=",XSI2);



//------------ Safety grid parameters---------------------------

nY = 5;
nX = 5;


meshX=D1*1.1;
meshY=D2*1.1;

// width of solid part of grid
meshSolid=1.2;

meshSpaceX = (meshX - meshSolid*nX)/nX;
meshSpaceY = (meshY - meshSolid*nY)/nY;




module base(){
    union()
    {
        for (i=[0:nX]) {
                 translate([i*(meshSolid+meshSpaceX) - meshSolid/2,0,0]) cube(size=[meshSolid, meshY, pedestal_height],center=false);
        }

        for (i=[0:nY]) {
                translate([0,i*(meshSolid+meshSpaceY) - meshSolid/2,0]) cube(size=[meshX, meshSolid, pedestal_height],center=false);

        }
    }
}

// definition of the wire channel by CSG.
// used for projecting outline onto the xy-plane.
module wirechannel()
{
	difference()
	{
        translate([-0.5,0,0])
		cube(size = [2*WIRE, 2*WIRE,2], center=true);

        cylinder(h=2, d=WIRE, center=true);

		translate([1.5*WIRE,0,0])
            cube([3*WIRE,WIRE,4], center=true);
	}
}

// definition of elliptic cylinder by CSG.
// used for projecting outline onto xy-plane.
module ellipse_base()
{
	scale([1,D2/D1,1])
        difference(){
            cylinder(h=1, r=(D1/2-WIRE/2), center = true);
            cylinder(h=2, r=(D1/2 - WIRE/2 - EXTRUSION_WIDTH), center = true);
        }
}

// the composite structure of support cylinder, wire channels, holes and cut-outs.
module composite()
{
	difference()
	{
		union()
		{
			// combine all elements in one extrude and twist.
			// helix1's.
			linear_extrude(height=HWIRE21, twist=-XSI1/2-180, slices=SLICES)
			{
				rotate([0,0,0-XSI1/2])
                    translate([D1/2,0,0])
                        projection()
                            scale([1,1/sin(THETA1),1])
                                wirechannel();

				rotate([0,0,180-XSI1/2])
                    translate([D1/2,0,0])
                        projection()
                            scale([1,1/sin(THETA1),1])
                                wirechannel();
			}
			// helix2's.
			linear_extrude(height=HWIRE22, twist=-XSI2/2-180, slices=SLICES)
			{
				rotate([0,0,90-XSI2/2])
                    translate([D2/2,0,0])
                        projection()
                            scale([1,1/sin(THETA2),1])
                                wirechannel();

				rotate([0,0,270-XSI2/2])
                    translate([D2/2,0,0])
                        projection()
                            scale([1,1/sin(THETA2),1])
                                wirechannel();
			}
			// elliptic support cylinder.
			linear_extrude(height=CYLH, twist=-XSI1/2-180, slices=SLICES)
			{
				rotate([0,0,0-XSI1/2]) projection(cut=true) ellipse_base();
			}
		}
		union()
		{
			// lower hole pairs.
			translate([0,0,HWIRE11])
                rotate([0,90,0])
                    cylinder(h=D1, d=WIRE, center=true);

			translate([0,0,HWIRE12])
                rotate([90,0,0])
                    cylinder(h=D2, d=WIRE, center=true);

			// upper hole slots.
			#translate([0,0,HWIRE21])
                rotate([0,90,0])
                    cylinder(h=D1, d=WIRE, center=true);
			#translate([0,0,HWIRE22])
                rotate([90,0,0])
                    cylinder(h=D2, d=WIRE, center=true);

			translate([0,0,HWIRE21+CYLH2]) cube([CYLH,WIRE,CYLH], center=true);
			translate([0,0,HWIRE22+CYLH2]) cube([WIRE,CYLH,CYLH], center=true);

            for (i=[0:lightening_hole_num]) {
                translate([0,0,i*lightening_hole_size])
                    rotate([0,0, +45 - XSI1/2 + i * ((180+XSI1/2)/(lightening_hole_num))])
                        rotate([45,0,0])
                            cube(size = [D1,lightening_hole_size,lightening_hole_size],center=true);

            }

            for (i=[0:lightening_hole_num]) {
                translate([0,0,i*lightening_hole_size])
                    rotate([0,0, -45 -XSI2/2 + i * ((180+XSI2/2)/lightening_hole_num)])
                        rotate([45,0,0])
                            cube(size = [D1,lightening_hole_size,lightening_hole_size],center=true);

            }


		}
	}
	translate([-meshX/2,-meshY/2,0])
		base();
}

//wirechannel();
//ellipse_base();
//base();

// MAIN()
composite();
