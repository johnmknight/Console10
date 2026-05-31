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
//   STILL TO MEASURE: the corner screw-hole pitch (center-to-center). Flagged
//     "<-- MEASURE"; until then the bosses are placed from a corner-inset estimate.
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
hole_inset = 4;           // screw center inset from the LCD face corner  <-- MEASURE
hole_dx    = lcd_w - 2*hole_inset;   // corner-screw X pitch (until measured)
hole_dy    = lcd_h - 2*hole_inset;   // corner-screw Y pitch (until measured)
m3_tap     = 2.5;         // boss pilot for an M3 self-tapper / heat-set core
boss_d     = 8;           // boss outer diameter
post_len   = 6;           // boss length behind the seat plane (thread engagement)
anchor_off = 4;           // L-brace column sits this far outside the opening corner

// ---------- HDMI switch — mounted vertical (long axis up the panel) to LEFT of LCD ----
// Device body 11.02 W x 17.1 H x 75.2 D in the manufacturer's orientation. We
// ROTATE it so the long axis runs VERTICAL up the panel: original D (75.2)
// becomes the panel-face height, original H (17.1) becomes the depth behind
// the panel, original W (11.02) stays as the panel-face width. Cutout in panel
// face is 11.02 x 75.2. Rear sleeve is open both ends (no floor) so the device
// slides in from the front (or back) and is clamped by 2 M2 set screws drilled
// through opposite (L + R) side walls — a single X-axis cylinder makes both
// holes in one shot. The "back of device" in the rotated frame = the TOP end
// of the vertical sleeve; the M2 axis is 6.6 mm DOWN from there.
hsw_w               = 17.2;      // panel-face width  (X)  (MEASURED)
hsw_h               = 110.2;     // panel-face height (Y) — long axis vertical (MEASURED)
hsw_d               = 11;        // depth behind panel (Z) — sleeve extends this far back
hsw_press_clr       = 0;         // per-side cutout clearance (negative => tighter)
hsw_wall_t          = 2.5;       // sleeve wall thickness
hsw_screw_d         = 2.4;       // M2 clearance hole diameter
hsw_screw_from_back = 6.6;       // M2 axis distance below the TOP end of the sleeve
hsw_gap             = 5;         // visual gap between LCD opening edge and HSW sleeve outer
hsw_end_wall_d      = 75.4;      // top + bottom end walls extend this far back (rest stays at hsw_d)
hsw_u_lip           = 6;         // inward leg length on the top + bottom end walls (U-shape rail)

// LCD shifted RIGHT so the (HSW + LCD) composition is centered on the panel:
// composition center = X=0; LCD center offset = (HSW outer width + hsw_gap) / 2
lcd_shift_for_composition = ((hsw_w - 2*hsw_press_clr + 2*hsw_wall_t) + hsw_gap) / 2;

// Derived position: just left of the LCD opening, vertically centered.
hsw_cx = lcd_shift_for_composition - (open_w/2 + hsw_gap + (hsw_w - 2*hsw_press_clr)/2 + hsw_wall_t);
hsw_cy = plate_h/2;

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
// LCD center: shifted right so the (HSW slot + LCD opening) composition is
// centered on X=0 rather than the LCD alone being on the center.
cx = lcd_shift_for_composition;
cy = plate_h/2;

echo(str("DISPLAY FACEPLATE v0.16 (+HDMI switch, left of LCD, vertical) ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | LCD ", lcd_w, "x", lcd_h, " depth ", lcd_depth, " glass flush @ z=", plate_t,
         " | HSW ", hsw_w, "x", hsw_h, " sleeve d=", hsw_d, " @ x=", hsw_cx,
         " M2 holes Φ", hsw_screw_d, " @ y=", hsw_cy + hsw_h/2 - hsw_screw_from_back,
         " | bosses 4 @ ", hole_dx, "x", hole_dy, " seat z=", mount_z, " (MEASURE hole pitch)"));

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
// HDMI SWITCH REAR SLEEVE — open-ended rectangular tube on the panel back.
// Holds the rotated (long-axis-vertical) HDMI switch behind the LCD-left panel
// area. Two M2 clearance holes are drilled by a single X-axis cylinder through
// both side walls, 6.6 mm down from the TOP end of the sleeve.
// =============================================================================
module hdmi_switch_sleeve() {
    inner_w = hsw_w - 2*hsw_press_clr;
    inner_h = hsw_h - 2*hsw_press_clr;
    outer_w = inner_w + 2*hsw_wall_t;
    outer_h = inner_h + 2*hsw_wall_t;
    screw_y = hsw_cy + hsw_h/2 - hsw_screw_from_back;
    screw_z = -hsw_d/2;

    difference() {
        union() {
            // BOTTOM end wall — extends to full hsw_end_wall_d
            translate([hsw_cx - outer_w/2, hsw_cy - outer_h/2, -hsw_end_wall_d])
                cube([outer_w, hsw_wall_t, hsw_end_wall_d]);
            // TOP end wall — extends to full hsw_end_wall_d
            translate([hsw_cx - outer_w/2, hsw_cy + inner_h/2, -hsw_end_wall_d])
                cube([outer_w, hsw_wall_t, hsw_end_wall_d]);
            // LEFT side wall — short (hsw_d) only
            translate([hsw_cx - outer_w/2, hsw_cy - inner_h/2, -hsw_d])
                cube([hsw_wall_t, inner_h, hsw_d]);
            // RIGHT side wall — short (hsw_d) only
            translate([hsw_cx + inner_w/2, hsw_cy - inner_h/2, -hsw_d])
                cube([hsw_wall_t, inner_h, hsw_d]);
            // TOP U-rail lips — 2 legs hanging DOWN from the top wall edges
            translate([hsw_cx - outer_w/2, hsw_cy + inner_h/2 - hsw_u_lip, -hsw_end_wall_d])
                cube([hsw_wall_t, hsw_u_lip, hsw_end_wall_d]);
            translate([hsw_cx + outer_w/2 - hsw_wall_t, hsw_cy + inner_h/2 - hsw_u_lip, -hsw_end_wall_d])
                cube([hsw_wall_t, hsw_u_lip, hsw_end_wall_d]);
            // BOTTOM U-rail lips — 2 legs standing UP from the bottom wall edges
            translate([hsw_cx - outer_w/2, hsw_cy - inner_h/2, -hsw_end_wall_d])
                cube([hsw_wall_t, hsw_u_lip, hsw_end_wall_d]);
            translate([hsw_cx + outer_w/2 - hsw_wall_t, hsw_cy - inner_h/2, -hsw_end_wall_d])
                cube([hsw_wall_t, hsw_u_lip, hsw_end_wall_d]);
        }
        // M2 holes — single X-axis cylinder through both L+R side walls
        translate([hsw_cx - outer_w/2 - 1, screw_y, screw_z])
            rotate([0, 90, 0])
                cylinder(d = hsw_screw_d, h = outer_w + 2);
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

            // --- HDMI switch rear sleeve (open both ends + M2 side-clamp holes) ---
            hdmi_switch_sleeve();
        }

        // --- full-face LCD opening (flush) straight through the slab ---
        translate([cx, cy, plate_t/2])
            cube([open_w, open_h, plate_t + 2], center = true);

        // --- HDMI switch panel-face cutout (press-fit, full through) ---
        translate([hsw_cx, hsw_cy, plate_t/2])
            cube([hsw_w - 2*hsw_press_clr, hsw_h - 2*hsw_press_clr, plate_t + 2], center = true);

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

    // HDMI switch body (rotated vertical, behind panel)
    color("SlateGray")
        translate([hsw_cx, hsw_cy, -hsw_d/2])
            cube([hsw_w, hsw_h, hsw_d], center = true);
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
