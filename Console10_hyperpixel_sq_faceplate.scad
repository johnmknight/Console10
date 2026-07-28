// =============================================================================
// CONSOLE10 — HyperPixel 4.0 Square Faceplate  v0.1  (3 mm flat panel, 3U)
//
// For the Pimoroni HyperPixel 4.0 SQUARE *Touch* (720x720 IPS, capacitive).
// The Pi is OFF-PANEL (connected by ribbon) — this plate holds the DISPLAY ONLY.
//
// DESIGN: uniform 3 mm flat faceplate that bolts to the cheek SLANT inserts
// (same family as Console10_display_faceplate / _lcd_simple_faceplate). The
// square display drops into a RECESSED FRONT POCKET from the back; a front LIP
// frames the active area and overlaps the ~6 mm black bezel margin to capture
// the glass. A rear LOCATING COLLAR (open square tube) surrounds the board edges
// behind the plate to locate it and host retention (clips/screws — v0.2).
//
// Local frame (also the print orientation):
//   X = plate width,  Y = up the plate (= up the cheek slant),  Z = thickness.
//   +Z = front / operator side.  Front face at Z = plate_t, back at Z = 0.
//
// DIMENSIONS — CONFIRMED from the Pimoroni HyperPixel 4.0 Square mechanical
// drawing (2026-06-11). Items marked [CAL] still want a caliper pass before a
// final print.
//   hp_board   84.0   board W=H (touch; non-touch is 75x80). CONFIRMED
//   hp_active  72.0    active display W=H. CONFIRMED
//   hp_depth   9.5     glass front -> back of header. CONFIRMED
//   hp_rim_t   2.6     glass+PCB edge the lip/collar bears on. [CAL]
//   Bezel ~5.5 L/R, 4.5 top, 6.5 bottom (approx) -> active is NOT centered; it
//   sits ~1 mm toward the GPIO-header edge (see active_off_y). [CAL]
//   HAT holes: 58 x 49 grid, upper-left at (4.0, 6.5) from the board top-left,
//   M2.5 (forum reply, not datasheet) [CAL]. CONFIRMED CATCH: the right-hand
//   hole column lands INSIDE the 72 active glass -> no front bolt -> rear
//   retention (v0.2). The official GrabCAD/STEP link is dead as of 2026.
// =============================================================================

// ---------- module geometry the plate must mate to ----------
panel_width   = 253;      // 10" mini-rack width
cheek_thick   = 10;
slant_angle   = 30;       // front slant, degrees from vertical
U             = 44.45;    // 1U, mm
interior_half = panel_width/2 - cheek_thick;   // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5 (slant insert X centerline)

// ---------- flat plate ----------
n_u      = 3;             // 3U faceplate
plate_w  = 253;           // sides flush with the cheek outer faces (+/-126.5)
plate_h  = n_u * U;       // 133.35
plate_t  = 3;             // uniform panel thickness

// ---------- HyperPixel 4.0 Square Touch — CONFIRMED (Pimoroni mech drawing) ---
hp_board  = 84.0;         // board W = H (square, touch). CONFIRMED
hp_active = 72.0;         // active display W = H. CONFIRMED
hp_depth  = 9.5;          // glass front -> back of header. CONFIRMED
hp_rim_t  = 4.6;          // glass+PCB rim thickness under the lip. MEASURED 4.6

// Asymmetric bezel -> the active is offset toward the header edge. SIGN below
// assumes the GPIO-header edge is at the TOP of the plate (header-up); negate
// active_off_y if you mount it header-down.
bezel_top    = 4.5;       // [CAL]
bezel_bottom = 6.5;       // [CAL]
active_off_y = (bezel_bottom - bezel_top) / 2;   // +1.0 mm toward header  [CAL]

// ---------- HAT mounting holes — DOCUMENTED ONLY (not cut; under the glass) ---
// 58 x 49 grid; upper-left hole 4.0 from left / 6.5 from top of the 84 board.
hole_ul = [4.0, 6.5];     // upper-left hole from board top-left, M2.5  [CAL]
hole_dx = 58;  hole_dy = 49;
hole_xs = [-hp_board/2 + hole_ul[0], -hp_board/2 + hole_ul[0] + hole_dx]; // [-38, 20]
hole_ys = [ hp_board/2 - hole_ul[1],  hp_board/2 - hole_ul[1] - hole_dy]; // [35.5, -13.5]
hole_d  = 2.7;            // M2.5 clearance (reference marker only)

// ---------- front frame (pocket + lip + window) ----------
board_clr  = 0.3;                      // per-side clearance, board into the pocket
pocket     = hp_board + 2*board_clr;   // 84.6 — board cavity W = H
win_reveal = 0.5;                      // bezel reveal per side around the active
window     = hp_active + 2*win_reveal; // 73.0 — viewing aperture (frames active)
lip_t      = 1.5;                      // front frame thickness over the bezel

// ---------- rear locating collar (open square tube behind the plate) ----------
collar_h    = 6;          // wall height behind the plate (locates the board edges)
collar_wall = 2.5;        // wall thickness
collar_out  = pocket + 2*collar_wall;  // 89.6 outer

// ---------- v0.2 rear retention clips (reuse the print-TESTED Stream Deck Mini
// pattern). Flex fingers cut from the collar SIDE walls; an inward hook snaps
// over the board's MEASURED 4.6 mm-thick back edge to press the glass into the
// lip. SIDE edges only -> clears the GPIO header (top edge) + the FPC corner.
// NOTE: short fingers (collar only 6 mm) -> stiff snap; fit-test coupon first.
retention   = true;
clip_w      = 8;          // flex-finger width along the edge (Y)
clip_slot   = 1.2;        // slot width isolating each finger (flex gap)
hook_d      = 1.3;        // hook overhang past the cavity wall (~1.0 mm board grab)
hook_h      = 1.5;        // hook catch height (Z)
clip_ys_off = [-20, 20];  // finger Y = cy + these; avoid header/FPC  [CHECK FPC]

// ---------- placement ----------
cx = 0;
cy = plate_h/2;           // centered vertically on the 3U plate

// ---------- slant-insert mount holes (perpendicular through the flat plate) ----
mount_y      = [50.80, 127.00];
m10_32_clear = 5.5;       // 10-32 clearance

show_screen   = true;     // include the mock display in the fit-check
show_holes    = false;    // red markers at the 4 HAT holes (shows them vs glass)
show_on_slant = false;    // true = tilt the flat stack onto the 30 deg slant
floor_t       = 6;        // bottom-panel slab thickness (for the slant placement)

$fn = 64;

echo(str("HYPERPIXEL-SQ FACEPLATE v0.1  ", plate_w, " x ", plate_h, " (", n_u,
         "U) t", plate_t, " | board ", hp_board, " active ", hp_active,
         " | pocket ", pocket, " window ", window, " (reveal ", win_reveal,
         "/side) | active_off_y ", active_off_y, " | lip ", lip_t, " @ y=", cy));

// Z planes
seat_z = plate_t - lip_t;     // 1.5 — board glass front seats here (lip back face)

// =============================================================================
// PANEL — flat 3 mm slab + rear locating collar, minus the recessed pocket,
// the front viewing window, and the slant mount holes.
// =============================================================================
module panel() {
    difference() {
        union() {
            // the slab (front face at Z=plate_t, back at Z=0)
            translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);

            // rear locating collar: solid block (the pocket cut hollows it out)
            translate([cx, cy, -collar_h/2])
                cube([collar_out, collar_out, collar_h], center = true);
        }

        // --- recessed pocket: board cavity from Z=-collar_h up to seat_z ---
        // (carves the collar interior AND the plate's rear recess in one cut)
        pocket_d = seat_z + collar_h;                  // 1.5 + 6 = 7.5
        translate([cx, cy, (seat_z - collar_h)/2])     // center between -collar_h and seat_z
            cube([pocket, pocket, pocket_d + 0.02], center = true);

        // --- front viewing window through the lip (tracks the offset active) ---
        translate([cx, cy + active_off_y, plate_t - lip_t/2])
            cube([window, window, lip_t + 0.1], center = true);

        // --- slant-insert mount screws — 2 per side, straight through ---
        for (sx = [-cheek_ctr_x, cheek_ctr_x])
            for (y = mount_y)
                translate([sx, y, -collar_h - 1])
                    cylinder(d = m10_32_clear, h = plate_t + collar_h + 2);
    }
}

// =============================================================================
// MOCK SCREEN — fit-check only (not printed). Board block from the seated glass
// plane back by hp_depth, plus a glossy active face just behind the glass.
// =============================================================================
module screen_mock() {
    color("DimGray")
        translate([cx, cy, seat_z - hp_depth/2])
            cube([hp_board, hp_board, hp_depth], center = true);
    color("RoyalBlue")
        translate([cx, cy + active_off_y, seat_z - 0.55])
            cube([hp_active, hp_active, 0.8], center = true);
}

// =============================================================================
// HOLE MARKERS — fit-check only (not printed). Red discs on the glass plane at
// the 4 HAT holes, so a front render shows which fall INSIDE the active area.
// =============================================================================
module hole_markers() {
    color("Red")
    for (hx = hole_xs)
        for (hy = hole_ys)
            translate([cx + hx, cy + hy, seat_z + 0.2])
                cylinder(d = hole_d, h = 0.6, center = true);
}

// =============================================================================
// STACK — panel + (optional) mock screen, in the local flat frame.
// =============================================================================
module hp_stack() {
    color("Gainsboro") panel();
    if (show_screen) screen_mock();
    if (show_holes)  hole_markers();
}

// Fit-check: lay the flat stack onto the 30 deg slant (see display faceplate).
module hp_on_slant() {
    translate([0, 0, floor_t])
        rotate([90 - slant_angle, 0, 0])
            hp_stack();
}

// Public entry the module assembly can call:
module hyperpixel_sq_faceplate_on_slant() { hp_on_slant(); }

if (show_on_slant) hp_on_slant();
else               hp_stack();
