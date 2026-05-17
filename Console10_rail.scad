// =============================================================================
// CONSOLE10 — Rail
// Parametric OpenSCAD source, per Design Document v2.1 §3 / §5
//
// Vertical 3D-printed plastic rail. Rectangular bar cross-section.
// Front face: 10-32 heat-set insert pockets at EIA-310 vertical hole spacing.
// Side face (cheek-facing): M3 clearance holes; screws pass through into
// heat-set inserts in the cheek interior face.
//
// Default height = 52.73 mm = the front rail (1U usable, derived from the
// trapezoidal cheek front edge). Back rail = call with height = 160.
// =============================================================================

/* [Rail dimensions] */
rail_height = 52.73;   // [40:0.01:200] rail height (mm); 52.73 = front, 160 = back
rail_w      = 25;      // [15:1:40] width of the rail (X axis when placed)
rail_d      = 15;      // [10:1:25] depth toward module interior (Y axis when placed)

/* [Hole specs] */
insert_10_32_d     = 7;     // 10-32 brass heat-set insert hole diameter
insert_10_32_depth = 7;     // depth of 10-32 insert pocket
m3_clear_d         = 3.5;   // M3 clearance hole (screw passes through; no thread)

/* [Render quality] */
$fa = 2;
$fs = 0.3;

// =============================================================================
//                                  DERIVED
// =============================================================================
U = 44.45;                     // 1U vertical
eia_offsets = [6.35, 22.225, 38.10];  // EIA-310 hole positions within each U

// How many full U fit in this rail height
u_count = floor(rail_height / U);

// Generate flat list of all 10-32 hole z-positions
function flatten(l) = [for(a=l) for(b=a) b];
hole_zs = flatten([for(u_idx = [0:u_count-1])
                       [for(o = eia_offsets) u_idx*U + o]]);

// M3 cheek-mount hole positions: at least 2 (top + bottom 10mm in); add a
// middle position for rails > 80mm tall
m3_zs = (rail_height < 80)
        ? [10, rail_height - 10]
        : [10, rail_height / 2, rail_height - 10];

// =============================================================================
//                              RAIL BODY
// =============================================================================
module rail() {
    difference() {
        // Solid rectangular bar
        cube([rail_w, rail_d, rail_height]);

        // 10-32 heat-set insert pockets on the FRONT face (y = 0).
        // Pocket runs from y = 0 INTO the rail (toward +y).
        for (z = hole_zs)
            translate([rail_w/2, -0.01, z])
                rotate([-90, 0, 0])
                    cylinder(d = insert_10_32_d, h = insert_10_32_depth + 0.01);

        // M3 clearance holes on the SIDE face (x = 0, cheek-facing).
        // Pass-through: hole runs all the way across the rail width.
        for (z = m3_zs)
            translate([-0.01, rail_d/2, z])
                rotate([0, 90, 0])
                    cylinder(d = m3_clear_d, h = rail_w + 0.02);
    }
}

rail();
