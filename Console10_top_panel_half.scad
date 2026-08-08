// =============================================================================
// CONSOLE10 — Top Panel Half  v2.4
// Flat 6 mm panel with 4 mm cheek-tabs at each outer edge and a trapezoidal
// dovetail castellation at the centerline (30° from vertical, Apollo 13
// command module flight console reference).
//
// Two parts: LEFT half (5 tabs) and RIGHT half (4 tabs). Set is_left_half
// below to choose which half this build produces.
//
// Halves are joined by PLA solvent/glue along the dovetail seam. No screws,
// no heat-set inserts, no rabbet.
//
// Print orientation: flat on bed, either face down (geometry is symmetric
// across the panel-thickness midplane).
// =============================================================================

is_left_half = true;       // true = LEFT, false = RIGHT

// ---------- LOCKED PARAMETERS -----------------------------------------------
panel_depth       = 109.975;   // x: front-back
panel_thick       = 6;         // z: thickness
interior_width    = 261.525;   // cheek-interior-to-cheek-interior
panel_half_width  = interior_width / 2;
cheek_tab         = 4;         // extension into cheek channel (each side)

// Castellation
n_segments        = 9;         // 5 tabs + 4 slots (LEFT); 4 tabs + 5 slots (RIGHT)
tab_protrude      = 6;         // tab extension past centerline
wedge_angle       = 30;        // wedge angle from vertical, degrees

// ---------- DERIVED ---------------------------------------------------------
seg_pitch         = panel_depth / n_segments;                          // 12.2194 mm
tab_base          = seg_pitch;                                         // 12.2194 mm (= full segment at y=0)
tab_tip           = seg_pitch + 2 * tab_protrude * tan(wedge_angle);   // 19.147 mm (dovetail tip)

echo("=== Console10 top panel half v2.4 ===");
echo(str("  is_left_half  = ", is_left_half));
echo(str("  seg_pitch     = ", seg_pitch, " mm"));
echo(str("  tab_base/tip  = ", tab_base, " / ", tab_tip, " mm"));

// ---------- 2D HALF GEOMETRY ------------------------------------------------
// Local frame:
//   x = 0 .. panel_depth          (front to back)
//   y = 0 is the centerline
//   LEFT  half body sits in y < 0; tabs extend into y > 0; slots cut into y < 0
//   RIGHT half body sits in y > 0; tabs extend into y < 0; slots cut into y > 0

function this_tab_segs()  = is_left_half ? [1,3,5,7,9] : [2,4,6,8];
function this_slot_segs() = is_left_half ? [2,4,6,8] : [1,3,5,7,9];

// Tab polygon — this half pushes into the OTHER half's territory.
// Base at y=0 (full segment width); tip at y=±tab_protrude (wider, dovetail).
module tab_at(seg_idx) {
    cx = (seg_idx - 0.5) * seg_pitch;
    dir = is_left_half ? 1 : -1;
    polygon([
        [cx - tab_base/2, 0],
        [cx + tab_base/2, 0],
        [cx + tab_tip/2,  dir * tab_protrude],
        [cx - tab_tip/2,  dir * tab_protrude]
    ]);
}

// Slot polygon — cut into THIS half's body (matches the OTHER half's tab).
module slot_at(seg_idx) {
    cx = (seg_idx - 0.5) * seg_pitch;
    dir = is_left_half ? -1 : 1;
    polygon([
        [cx - tab_base/2, 0],
        [cx + tab_base/2, 0],
        [cx + tab_tip/2,  dir * tab_protrude],
        [cx - tab_tip/2,  dir * tab_protrude]
    ]);
}

// Half-body rectangle (excludes castellation).
module body_rect_2d() {
    if (is_left_half) {
        translate([0, -(panel_half_width + cheek_tab)])
            square([panel_depth, panel_half_width + cheek_tab]);
    } else {
        square([panel_depth, panel_half_width + cheek_tab]);
    }
}

// Assembled 2D half = body + tabs - slots
module half_2d() {
    difference() {
        union() {
            body_rect_2d();
            for (s = this_tab_segs()) tab_at(s);
        }
        for (s = this_slot_segs()) slot_at(s);
    }
}

// ---------- ASSEMBLED HALF --------------------------------------------------
module top_panel_half() {
    linear_extrude(height = panel_thick)
        half_2d();
}

top_panel_half();
