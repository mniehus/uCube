/*
					uCube: Modular 3D-printable optomechanical kit
					 Copyright (C) 2016 Mihails Delmans
							  m.delmans@gmail.com
							  
									 v.1.0
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
	
	
									uRails.scad
							   Parts rail cage system
								   
*/

railScrew = Screw(screwR = 1, capR = 2, capH = 2, insertH = 5, insertR = 2);

function Rail(size = 30, d = 6, screw = railScrew, gap = 0.4) = [
	["d", d],
	["screw", screw],
	["size", size],
	["gap", gap]
];

thorlabsRail = Rail();

module railClamp(rail = thorlabsRail, wallT = 2, length = 5, fixScrewR = 1){
	
	railR 	= getattr(rail, "d") * 0.5;
	gap		= getattr(rail, "gap");

	difference(){
		cylinder(length, railR + gap + wallT, railR + gap + wallT);
		cylinder(length, railR + gap, railR + gap);
		translate([0, railR + gap + 0.5*wallT, 0.5*length]) rotate([90, 0, 0]) cylinder(wallT * 2, fixScrewR, fixScrewR, center = true);
	}
}

module muRailFaceA(cubeSize = defaultCubeSize, rail = thorlabsRail){
	
	screw		= getattr(rail, "screw");
	cubeD		= getattr(cubeSize, "d");
	
	railSize	= getattr(rail, "size");

	difference(){
		if ($children == 0){
			uFace();
		}
		else{
			children(0);
		}
		translate([0.5*railSize, 0.5*railSize, 0.25*cubeD]) rotate([180, 0, 0]) screwHole(screw = screw, l = 0.5*cubeD);
		translate([0.5*railSize, -0.5*railSize, 0.25*cubeD]) rotate([180, 0, 0]) screwHole(screw = screw, l = 0.5*cubeD);
		translate([-0.5*railSize, 0.5*railSize, 0.25*cubeD]) rotate([180, 0, 0]) screwHole(screw = screw, l = 0.5*cubeD);
		translate([-0.5*railSize, -0.5*railSize, 0.25*cubeD]) rotate([180, 0, 0]) screwHole(screw = screw, l = 0.5*cubeD);
	}
}

module muRailFaceT(cubeSize = defaultCubeSize, rail = thorlabsRail){
	
	screw		= getattr(rail, "screw");
	cubeD		= getattr(cubeSize, "d");
	
	railSize	= getattr(rail, "size");
	railR		= getattr(rail, "d") * 0.5;

	gap		= getattr(rail, "gap");

	union(){
		difference(){
			if ($children == 0){
				uFace();
			}
			else{
				children(0);
			}

			translate([0.5*railSize, 0.5*railSize, 0])		cylinder(0.5*cubeD, railR + gap, railR + gap, center = true);
			translate([0.5*railSize, -0.5*railSize, 0])		cylinder(0.5*cubeD, railR + gap, railR + gap, center = true);
			translate([-0.5*railSize, 0.5*railSize, 0])		cylinder(0.5*cubeD, railR + gap, railR + gap, center = true);
			translate([-0.5*railSize, -0.5*railSize, 0])	cylinder(0.5*cubeD, railR + gap, railR + gap, center = true);
		}
		translate([0.5*railSize, 0.5*railSize, 0.25*cubeD])		railClamp();
		translate([0.5*railSize, -0.5*railSize, 0.25*cubeD])	rotate([0, 0, 180]) railClamp();
		translate([-0.5*railSize, 0.5*railSize, 0.25*cubeD])	railClamp();
		translate([-0.5*railSize, -0.5*railSize, 0.25*cubeD])	rotate([0, 0, 180]) railClamp();
	}
}