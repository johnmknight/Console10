// =============================================================================
// CONSOLE10 — Bottom Panel Half  v2.4
// Flat 6 mm panel with 4 mm cheek-tabs at each outer edge and a trapezoidal
// dovetail castellation at the centerline (30° from vertical, Apollo 13
// command module flight console reference).
//
// Two parts: LEFT half (9 tabs) and RIGHT half (8 tabs). Set is_left_half
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
panel_depth       = 228.6;     // x: front-back
panel_thick       = 6;         // z: thickness
interior_width    = 261.525;
panel_half_width  = interior_width / 2;
cheek_tab         = 4;

// Castellation
n_segments        = 17;        // 9 tabs + 8 slots (LEFT); 8 tabs + 9 slots (RIGHT)
tab_protrude      = 6;
wedge_angle       = 30;

// ---------- DERIVED ---------------------------------------------------------
seg_pitch         = panel_depth / n_segments;                          // 13.4471 mm
tab_base          = seg_pitch;                                         // 13.4471 mm
tab_tip           = seg_pitch + 2 * tab_protrude * tan(wedge_angle);   // 20.375 mm

echo("=== Console10 bottom panel half v2.4 ===");
echo(str("  is_left_half  = ", is_left_half));
echo(str("  seg_pitch     = ", seg_pitch, " mm"));
echo(str("  tab_base/tip  = ", tab_base, " / ", tab_tip, " mm"));

// ---------- 2D HALF GEOMETRY ------------------------------------------------
function this_tab_segs()  = is_left_half ? [1,3,5,7,9,11,13,15,17] : [2,4,6,8,10,12,14,16];
function this_slot_segs() = is_left_half ? [2,4,6,8,10,12,14,16] : [1,3,5,7,9,11,13,15,17];

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

module body_rect_2d() {
    if (is_left_half) {
        translate([0, -(panel_half_width + cheek_tab)])
            square([panel_depth, panel_half_width + cheek_tab]);
    } else {
        square([panel_depth, panel_half_width + cheek_tab]);
    }
}

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
module bottom_panel_half() {
    linear_extrude(height = panel_thick)
        half_2d();
}

bottom_panel_half();
