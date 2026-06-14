// =============================================================================
// CONSOLE10 — Display Faceplate  v0.9  (3 mm flat panel, LCD behind, glass flush)
//
// For the ELECROW RC070 7" 1024x600 IPS touch (Amazon B08FMNDDSL).
//
// PANEL / MOUNT ONLY — the press-fit hood/bezel is deferred to a later pass.
//
// DESIGN: a UNIFORM 3 mm flat faceplate that bolts to the cheek SLANT inserts.
// The LCD drops into a full-face through-cut from the FRONT and its glass lands
// FLUSH with the 3 mm panel front. The LCD body (12.4 mm deep) sits BEHIND the
// panel; the 4 corner mounting bosses dangle behind at the LCD's rear-post seat
// plane (mount_z = -9.4) and are tied back to the panel slab by L-braces
// (horizontal arm + vertical column outside the opening). TOP and BOTTOM
// support walls run boss-to-boss flush against the back of the LCD PCB, so
// touch-press load distributes along the row instead of cantilevering on the
// corner arms. NO left/right walls — the PCB's L/R edges carry the HDMI port,
// USB micros, electrolytic cap, scroll wheel and headphone jack; vertical
// walls there would foul those components. The Pi is NOT on the back, so the
// structure is free to occupy the space behind. Screws enter from the BACK
// through each boss into the LCD's M3 post.
//
// Local frame (also the print orientation):
//   X = plate width,  Y = up the plate (= up the cheek slant),  Z = thickness.
//   +Z = front / operator side.  Front face at Z = plate_t, back at Z = 0.
//
//   MEASURED (John's calipers, 2026-05-30): LCD face 165.64 W x 102 H; front glass
//     to the top of the rear mounting posts = 12.4 mm.
//   MEASURED (2026-05-31, calipers): corner screw-hole pitch = 153.6 W x 91.5 H
//     (center-to-center). hole_dx/hole_dy are independent constants below, NOT
//     derived from the glass face — see the note there.
// =============================================================================

// ---------- module geometry the plate must mate to ----------
panel_width   = 253;      // 10" mini-rack width (top/bottom panel width)
cheek_thick   = 10;       // cheek thickness
slant_angle   = 30;       // front slant, degrees from vertical
U             = 44.45;    // 1U, mm
interior_half = panel_width/2 - cheek_thick;   // 116.5 (cheek inner face, +/-X)
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5 (slant insert X centerline)

// ---------- flat plate ----------
n_u      = 3;             // 3U faceplate
plate_w  = 253;           // FULL module width: sides flush with the cheek outer
                          // faces (+/-126.5). Puts the slant-mount holes (at the
                          // cheek mid-thickness, +/-121.5) a proper 5 mm in from
                          // the edge, backed by the cheek.
plate_h  = n_u * U;       // 133.35 — height up the plate (= along the slant)
plate_t  = 3;             // uniform panel thickness (rail-mount + LCD flush plane)

// ---------- the LCD: ELECROW RC070 (measured) ----------
lcd_w     = 165.64;       // front face width             (MEASURED)
lcd_h     = 102;          // front face height            (MEASURED)
lcd_depth = 12.4;         // glass front -> top of rear mounting posts (MEASURED)
lcd_clr   = 0.5;          // opening clearance per side (LCD body passes through)

open_w  = lcd_w + 2*lcd_clr;   // full-face through-cut (LCD body passes through)
open_h  = lcd_h + 2*lcd_clr;
mount_z = plate_t - lcd_depth; // -9.4: rear-post seat plane, BEHIND the panel

// ---------- corner mounting bosses (RC070: 4 corner screws) ----------
// Mounting-hole pitch is the BOARD's own spec — do NOT derive it from the glass
// face size (lcd_w/lcd_h). Independent measured constants so a bezel/face change
// can never drag the holes again. (Side inset 6.02 mm, top/bottom 5.25 mm — the
// insets differ per axis, which is why one shared hole_inset couldn't fit both.)
hole_dx    = 153.6;       // horizontal post-to-post, center-to-center  (MEASURED 2026-05-31, calipers)
hole_dy    = 91.5;        // vertical   post-to-post, center-to-center  (MEASURED 2026-05-31, calipers)
m3_tap     = 2.5;         // boss pilot for an M3 self-tapper / heat-set core
boss_d     = 8;           // boss outer diameter
post_len   = 6;           // boss length behind the seat plane (thread engagement)
anchor_off = 4;           // L-brace column sits this far outside the opening corner

// (HDMI switch removed — it used to mount vertical to the LEFT of the LCD, with the
//  LCD shifted right to centre the pair. Now the monitor holder is centred alone.)

// ---------- slant-insert mount holes (perpendicular through the flat plate) ----
// Two per side at the bezel SIDE margin (X=+/-121.5). Those columns are already
// outboard of the LCD (face only +/-82.8 wide), so the bolts clear the screen in X
// and the Y row is free to land on ANY real cheek rail hole.
// Cheek slant inserts sit at along-slant s = front_gap + u_idx*U + EIA, with
// front_gap = U = 44.45, EIA = {6.35, 22.225, 38.10}, u_idx = 0..3:
//   U0: 50.80, 66.675, 82.55   U1: 95.25, 111.125, 127.00
//   U2: 139.70, ...  (off the 133.35 plate)
// Pick the LOWEST real hole (50.80, U0-bottom) and the highest that still fits the
// 3U plate (127.00, U1-top) for a wide vertical grip. NOTE: s=22.225 is inside the
// front_gap and has NO cheek hole — don't use it.
mount_y      = [50.80, 127.00];
m10_32_clear = 5.5;       // 10-32 clearance

show_on_slant = false;    // true = fit-check: tilt the flat stack onto the slant
show_lcd      = true;     // include the mock LCD in the fit-check
floor_t       = 6;        // bottom-panel slab thickness (for the fit-check placement)

$fn = 48;
// Monitor (LCD) holder centered on the panel (HDMI switch removed).
cx = 0;
cy = plate_h/2;

echo(str("DISPLAY FACEPLATE v0.17 (monitor centred, HDMI switch removed) ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | LCD ", lcd_w, "x", lcd_h, " depth ", lcd_depth, " glass flush @ z=", plate_t, " centred @ x=", cx,
         " | bosses 4 @ ", hole_dx, "x", hole_dy, " seat z=", mount_z));

// ---------- isogrid SIDE DETAIL (EXPERIMENT) -------------------------------
// One column of the cheek's {3,6} alternating-triangle isogrid in each side
// strip (between the LCD opening and the slant-mount-hole column). Shallow front
// pockets (the plate is only 3 mm). Mirrors the cheek's spacing/rib/fillet.
iso_spacing = 20;     iso_rib = 2.5;   iso_fillet = 1.59;   // cheek values
iso_pocket  = 1.5;    // pocket depth into the 3 mm front face
iso_col_x   = 100;    // column centre X (mirrored ±) — clears LCD edge (83.3) & mount col (121.5)
iso_y0      = 16;     iso_y1 = 118;    // column Y span (alongside the LCD opening)
SQRT3f      = sqrt(3);
iso_inset   = iso_spacing - SQRT3f*iso_rib;
iso_inner   = iso_inset - 2*iso_fillet*SQRT3f;

module r_tri_up(side, rf) { h = side*SQRT3f/2; offset(r=rf) polygon([[-side/2,-h/3],[side/2,-h/3],[0,2*h/3]]); }
module r_tri_dn(side, rf) { h = side*SQRT3f/2; offset(r=rf) polygon([[-side/2,h/3],[0,-2*h/3],[side/2,h/3]]); }

// full {3,6} field, 2D, centred near origin
module iso_field(n = 6)
    for (j = [-n:n], i = [-n:n])
        let (fx = iso_spacing*i + iso_spacing*j/2, fy = iso_spacing*j*SQRT3f/2) {
            translate([fx + iso_spacing/2, fy + iso_spacing*SQRT3f/6]) r_tri_up(iso_inner, iso_fillet);
            translate([fx + iso_spacing,   fy + iso_spacing*SQRT3f/3]) r_tri_dn(iso_inner, iso_fillet);
        }

// one column on side sx (±1): the field, clipped to a single-triangle-wide strip
module iso_column_2d(sx) intersection() {
    translate([sx*iso_col_x, plate_h/2]) iso_field();
    translate([sx*iso_col_x - iso_spacing/2, iso_y0]) square([iso_spacing, iso_y1 - iso_y0]);
}

// =============================================================================
// CORNER BRACE — horizontal arm only, from a corner-boss position out to the
// outside-corner column anchor. The arm pairs with the support_wall at its boss
// end and with the connecting_wall at its outside-corner end (which carries the
// vertical column as its hull endpoint). Screw pilots are drilled at panel level.
// =============================================================================
module corner_brace(dx, dy) {
    bx = cx + dx*hole_dx/2;                 // boss position (LCD corner)
    by = cy + dy*hole_dy/2;
    ox = cx + dx*(open_w/2 + anchor_off);   // column position, just outside the opening
    oy = cy + dy*(open_h/2 + anchor_off);
    // horizontal arm behind the LCD (z <= mount_z), boss -> outside corner
    hull() {
        translate([bx, by, mount_z - post_len]) cylinder(d = boss_d, h = post_len);
        translate([ox, oy, mount_z - post_len]) cylinder(d = 6, h = post_len);
    }
}

// =============================================================================
// SUPPORT WALL — wide rectangular bar at z=[mount_z-post_len, mount_z] forming
// the "foot" of the rail on row dy. Inner edge sits at boss Y (flush against
// the LCD PCB back, hosts the screw bosses); outer edge reaches column Y so it
// merges with the connecting_wall above — no gap in the middle X-range.
// =============================================================================
module support_wall(dy) {
    by_in  = cy + dy*hole_dy/2;                    // boss Y (inner, LCD post seat)
    by_out = cy + dy*(open_h/2 + anchor_off);      // column Y (outer, merges with connecting_wall)
    hull() {
        translate([cx - hole_dx/2, by_in,  mount_z - post_len]) cylinder(d = boss_d, h = post_len);
        translate([cx + hole_dx/2, by_in,  mount_z - post_len]) cylinder(d = boss_d, h = post_len);
        translate([cx - hole_dx/2, by_out, mount_z - post_len]) cylinder(d = boss_d, h = post_len);
        translate([cx + hole_dx/2, by_out, mount_z - post_len]) cylinder(d = boss_d, h = post_len);
    }
}

// =============================================================================
// CONNECTING WALL — continuous vertical wall on row dy (+1 top, -1 bottom),
// sitting just outside the LCD opening at the column Y, spanning the full row
// from left column to right column. Extends from the support-bar bottom plane
// (mount_z - post_len) all the way up into the panel slab (z = plate_t), so the
// rear support is rigidly tied to the front panel along the entire row — not
// just at the four corners. Vertical columns are implicit as the hull endpoints.
// =============================================================================
module connecting_wall(dy) {
    cz_bot = mount_z - post_len;
    cz_h   = plate_t - cz_bot;
    hull() {
        translate([cx - (open_w/2 + anchor_off), cy + dy*(open_h/2 + anchor_off), cz_bot])
            cylinder(d = 6, h = cz_h);
        translate([cx + (open_w/2 + anchor_off), cy + dy*(open_h/2 + anchor_off), cz_bot])
            cylinder(d = 6, h = cz_h);
    }
}

// =============================================================================
// PANEL — flat 3 mm slab, full-face LCD through-cut, slant mount holes, 4 corner
// L-braces, and 2 boss-to-boss support walls. All adds are unioned first; all
// cuts (including screw pilots through the bosses) happen at the outer
// difference so the pilots pierce the wall + boss + brace stack cleanly.
// Front face at Z=plate_t, back at Z=0.
// =============================================================================
module panel() {
    difference() {
        union() {
            // the slab
            translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);

            // --- top + bottom rear support walls (boss-to-boss, flush against PCB) ---
            for (dy = [-1, 1]) support_wall(dy);

            // --- top + bottom connecting walls (rear support up to panel slab) ---
            for (dy = [-1, 1]) connecting_wall(dy);

            // --- 4 corner L-brace arms (bridge boss to outside-corner column) ---
            for (dx = [-1, 1])
                for (dy = [-1, 1])
                    corner_brace(dx, dy);

        }

        // --- full-face LCD opening (flush) straight through the slab ---
        translate([cx, cy, plate_t/2])
            cube([open_w, open_h, plate_t + 2], center = true);

        // --- isogrid side detail: 1 column each side, shallow FRONT pockets (EXPERIMENT) ---
        translate([0, 0, plate_t - iso_pocket]) linear_extrude(iso_pocket + 0.1)
            for (sx = [-1, 1]) iso_column_2d(sx);

        // --- slant-insert mount screws — 2 per side, straight through ---
        for (sx = [-cheek_ctr_x, cheek_ctr_x])
            for (y = mount_y)
                translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);

        // --- screw pilots, from BACK through each boss into the LCD's M3 post ---
        for (dx = [-1, 1])
            for (dy = [-1, 1])
                translate([cx + dx*hole_dx/2, cy + dy*hole_dy/2, mount_z - post_len - 1])
                    cylinder(d = m3_tap, h = post_len + 1.5);
    }
}

// =============================================================================
// MOCK LCD — fit-check only (not printed). Body block from the flush glass plane
// back by lcd_depth, plus a glossy active face nudged 0.15 mm below flush so the
// preview doesn't z-fight the coplanar panel front.
// =============================================================================
module lcd_mock() {
    color("DimGray")
        translate([cx, cy, (plate_t + mount_z)/2])
            cube([lcd_w, lcd_h, lcd_depth], center = true);
    color("RoyalBlue")
        translate([cx, cy, plate_t - 0.55])
            cube([lcd_w - 1, lcd_h - 1, 0.8], center = true);
}

// =============================================================================
// STACK — panel + (optional) mock LCD, in the local flat frame.
// =============================================================================
module display_stack() {
    color("Gainsboro") panel();
    if (show_lcd) lcd_mock();
}

// Fit-check: lay the flat stack onto the 30 deg slant in the module frame.
//   rotate([90 - slant_angle, 0, 0]) tilts the plate's +Y up-axis onto the slant.
//     This sends the glass normal (local +Z, the front face at Z=plate_t) to world
//     (0, -0.866, +0.5) = forward + up, i.e. OUT of the slant toward the operator.
//   translate([0,0,floor_t]) seats the bottom edge at the front-bottom corner.
module display_on_slant() {
    translate([0, 0, floor_t])
        rotate([90 - slant_angle, 0, 0])
            display_stack();
}

// Public entry the module assembly calls:
module faceplate_on_slant() { display_on_slant(); }

if (show_on_slant) display_on_slant();
else               display_stack();
