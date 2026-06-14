// =============================================================================
// CONSOLE10 — DSKY-inspired combined control faceplate  v0.1 (LAYOUT PROPOSAL)
//
// One Console10 faceplate carrying FOUR devices, Apollo DSKY idiom (square
// display over keypad, with a side control column):
//   - Pimoroni HyperPixel 4.0 Square Touch  (720x720 display)     CONFIRMED dims
//   - Adafruit MacroPad RP2040 (keypad)      STL-measured envelope 60.75 x 105.25
//   - Adafruit STEMMA QT slide potentiometer (vertical fader)     [VERIFY dims]
//   - Adafruit 128x32 OLED (readout, ABOVE the slider)            [VERIFY dims]
//
// LAYOUT (this proposal): three side-by-side columns, all vertically centered —
//   MacroPad keypad (left) | HyperPixel screen (center) | slider+OLED (right,
//   vertical fader with the OLED readout above it). MacroPad USB-C is NOT cut
//   (cabled to the off-panel host behind). Side-by-side fits 3U.
//
// Local frame: X = width, Y = up the plate, Z = thickness. Front at Z=plate_t.
// THIS IS A LAYOUT BLOCK-OUT for arrangement approval — retention (rear bosses /
// support walls, 7"-display style) and exact slider/OLED cutouts come next.
// =============================================================================

// ---------- module geometry ----------
panel_width  = 253;  cheek_thick = 10;  U = 44.45;  slant_angle = 30;
interior_half = panel_width/2 - cheek_thick;        // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2;      // 121.5

// ---------- flat plate ----------
n_u     = 3;                  // side-by-side columns fit 3U
plate_w = 253;
plate_h = n_u * U;            // 133.35
plate_t = 3;

// ---------- HyperPixel 4.0 Square (CONFIRMED) ----------
hp_board = 84;  hp_active = 72;  hp_depth = 9.5;  hp_rim_t = 4.6;
hp_lip   = 1.5; hp_winrev = 0.5;
hp_window = hp_active + 2*hp_winrev;        // 73
hp_clr   = 0.3; hp_pocket = hp_board + 2*hp_clr;   // 84.6
hp_cx = 12;                                 // center column
// hp_cy is set in the right-column block below (needs the MacroPad position)

// ---------- MacroPad RP2040 (STL-measured envelope) ----------
mp_w = 60.75;  mp_h = 105.25;  mp_face_w = 56;  mp_face_h = 100;  // exposed face (no USB cut)
mp_cx = -75;                                      // left column
mp_cy = plate_h/2;                                // vertically centered
mp_stl = "C:/Users/john_/Downloads/5128 MacroPad RP2040-Assembly.stl";
mp_keytop_z = 29.64;          // STL +Z extent = ENCODER KNOB top (not the keycaps)
mp_pcb_top_stl = 3;           // PCB top surface in STL z (mesh histogram); phantom plate is below z=-2
mp_lower = 5;                 // lower the whole keypad this far behind the panel back (keys still proud)
mp_z_off = -mp_pcb_top_stl - mp_lower;   // STL->model z: puts the PCB top at z = -mp_lower
// MacroPad rear locating pocket (PCB drops in from behind; keys stay proud)
mp_board_w = 59.69; mp_board_h = 104.14;          // PCB (fab print)
mp_pkt_clr = 0.3;
mp_pocket_w = mp_board_w + 2*mp_pkt_clr;          // 60.29
mp_pocket_h = mp_board_h + 2*mp_pkt_clr;          // 104.74
mp_collar_wall = 2.5;
mp_collar_h    = 6 + mp_lower;                    // deepened so the lowered PCB still locates
// MacroPad backplate mounting posts (4): the printed backplate screws to these,
// and the MP mounts to that backplate via its own 4 PCB holes (separate part).
mp_post_dx = 74; mp_post_dy = 118;               // post pattern (just outside the collar)
mp_post_od = 7;  mp_post_pilot = 2.5;            // M3 self-tap
mp_post_h  = 10 + mp_lower;                       // deepened with the lowered keypad

// ---------- slider + OLED right column (Adafruit STEP CAD: repo Adafruit_CAD_Parts) ----------
// OLED 4440: PCB 33.02 x 21.46, 4 holes 27.94 x 16.51 (M2.5) centred on the board,
//   active glass 22.384 x 5.584 centred on the hole pattern (CAD-confirmed both axes).
// NeoSlider 5295: PCB 76.2 x 21.59; 4 holes at +-19.05 (along) x +-8.255 (across) =
//   38.1 x 16.51 pattern; slide-pot HOUSING 75 x 9.5 sits FLUSH, top 6.5 mm proud of
//   the PCB, knob protrudes to 15.5 mm. Mounted VERTICAL (long axis up the plate).
oled_bw = 33.02;  oled_bh = 21.46;  oled_aw = 22.384;  oled_ah = 5.584;  // CAD PCB / active
oled_hole_dx = 27.94;  oled_hole_dy = 16.51;  oled_hole_d = 2.6;         // 4 corner holes (M2.5)
sld_bw  = 21.59;  sld_bh = 76.2;             // CAD PCB (vertical orientation)
sld_house_w = 9.5;  sld_house_h = 75;        // slide-pot housing footprint = flush cutout (CAD)
sld_house_z = 6.5;                           // housing top above PCB front (CAD)
sld_clr = 0.4;                               // cut clearance around the housing
sld_hole_dx = 16.51;  sld_hole_dy = 38.1;    // 4 PCB holes (across x along), vertical mount (CAD)
sld_hole_d  = 2.6;                            // M2.5 clearance
col_cx  = 87;                                        // right column
// tops aligned to the MacroPad top (mp_cy/mp_h defined above):
hp_cy   = mp_cy + mp_h/2 - hp_board/2;               // screen TOP aligned with the MacroPad top
oled_cy = mp_cy + mp_h/2 - oled_bh/2;                // OLED TOP aligned with the MacroPad top
sld_cy  = oled_cy - oled_bh/2 - 0.5 - sld_bh/2;      // slider raised: ~0.5 mm gap to the OLED PCB

// ---------- slant-insert mount holes (perpendicular through the plate) ----------
mount_y = [50.80, 127.00];            // real cheek rows for 3U
m10_32_clear = 5.5;

show_devices = true;
part = "panel";           // "panel" | "macropad_backplate"
show_backplate = true;    // show the (real) backplate behind the MP for fit-check
$fn = 40;
seat_z = plate_t - hp_lip;            // 1.5

echo(str("DSKY PANEL v0.1  ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | HP@(", hp_cx, ",", hp_cy, ") MacroPad@(", mp_cx, ",", mp_cy,
         ") OLED@(", col_cx, ",", oled_cy, ") slider@(", col_cx, ",", sld_cy, ")"));

module rrect(w, h, r) {
    hull() for (sx = [-1,1]) for (sy = [-1,1])
        translate([sx*(w/2 - r), sy*(h/2 - r)]) circle(r);
}

// ---------- retention: rear standoff bosses (each PCB screws on from behind) ---
boss_od    = 6;                       // standoff outer diameter
boss_pilot = 2.1;                     // M2.5 self-tap pilot
mp_kc2pcb  = 15.3;                    // keycap top -> PCB top (MEASURED)
mp_pcb_z   = -mp_lower;               // PCB top, lowered behind the panel back
sld_pcb_z  = plate_t - sld_house_z;   // -3.6   slider PCB front (6.6 housing sits flush)
mp_hx = 52.07/2;  mp_hy = 81.28/2;        // MacroPad holes (2.05 x 3.20")
sld_hx = sld_hole_dx/2; sld_hy = sld_hole_dy/2;   // slider holes: 8.255 across x 19.05 along
oled_hx = oled_hole_dx/2; oled_hy = oled_hole_dy/2;   // OLED 4 corners (27.94 x 16.51)

// A tapped post from the panel back (z=0) out to z_seat (negative); the PCB
// seats on the far end and is screwed in from behind.
module standoff(x, y, z_seat) {
    difference() {
        translate([x, y, z_seat]) cylinder(d = boss_od, h = -z_seat);
        translate([x, y, z_seat - 0.1]) cylinder(d = boss_pilot, h = -z_seat + 0.2);
    }
}

// A solid tapped post on the panel back (z=0) extending back by h.
module post(x, y, h, od, pilot) {
    difference() {
        translate([x, y, -h]) cylinder(d = od, h = h);
        translate([x, y, -h - 0.1]) cylinder(d = pilot, h = h + 0.2);
    }
}

// =============================================================================
// MACROPAD BACKPLATE — a real printed part that REPLACES the STL's phantom plate.
// A flat plate behind the MP. Two hole sets, by design:
//   * 4 standoffs at the MP rear-PCB pattern (52.07 x 81.28) — the MP screws onto
//     these; the standoffs clear the rear sockets/USB between them.
//   * 4 clearance holes at the panel-post pattern (74 x 118) — bolts to the posts.
// Plate top sits at the panel-post ends (z = -mp_post_h).
// =============================================================================
mp_bp_t     = 4;                  // plate thickness
mp_bp_z     = -mp_post_h;         // plate top at the panel-post ends
mp_pcb_back = -mp_lower - 1.6;    // MP PCB board bottom (PCB top at z = -mp_lower)

module macropad_backplate() {
    so_h = mp_pcb_back - mp_bp_z;  // standoff height up to the PCB (8.4)
    difference() {
        union() {
            translate([mp_cx, mp_cy, mp_bp_z - mp_bp_t/2])
                cube([mp_post_dx + 12, mp_post_dy + 12, mp_bp_t], center = true);
            for (sx = [-1,1]) for (sy = [-1,1])              // MP mounting standoffs
                translate([mp_cx + sx*mp_hx, mp_cy + sy*mp_hy, mp_bp_z]) cylinder(d = 7, h = so_h);
        }
        for (sx = [-1,1]) for (sy = [-1,1])                  // panel-post clearance holes
            translate([mp_cx + sx*mp_post_dx/2, mp_cy + sy*mp_post_dy/2, mp_bp_z - mp_bp_t - 0.1])
                cylinder(d = 3.4, h = mp_bp_t + 0.2);
        // MP screws enter from the BACK of the backplate, pass through the plate
        // + standoff, and thread into the PCB's existing mounting holes (M3 clear).
        for (sx = [-1,1]) for (sy = [-1,1])
            translate([mp_cx + sx*mp_hx, mp_cy + sy*mp_hy, mp_bp_z - mp_bp_t - 0.1])
                cylinder(d = 3.4, h = so_h + mp_bp_t + 0.2);
    }
}

// =============================================================================
// HYPERPIXEL BACKPLATE — same methodology as the MacroPad. Screws to the screen's
// 4 HAT holes (58 x 49) from the BACK of the plate (HAT holes are board-through,
// so a rear plate reaches them even with the right column under the front glass);
// bolts to 4 panel posts. Plate sits behind the GPIO header (z = -8).
//
// TODO: cut a header-cable exit through this plate, LARGE ENOUGH for the GPIO
//   ribbon connector + cable bend radius (the off-panel Pi plugs in here). The
//   plate is solid behind the screen right now and would foul the cable. Size
//   and locate the opening from the header-edge photos in  g:\my drive\ .
// =============================================================================
hp_board_back = seat_z - hp_rim_t;        // -3.1, screen PCB back plane
hp_hat_xs = [-38, 20];                     // HAT hole X, board-centered (58 wide)  [verify]
hp_hat_ys = [35.5, -13.5];                 // HAT hole Y (49 tall)                   [verify]
hp_post_dx = 80;  hp_post_dy = 96;         // panel-post pattern (clears the neighbours)
hp_post_h  = 10;                            // post length behind the panel
hp_bp_t = 4;
hp_bp_z = -hp_post_h;

module hyperpixel_backplate() {
    so_h = hp_board_back - hp_bp_z;          // standoff to the screen PCB back
    difference() {
        union() {
            translate([hp_cx, hp_cy, hp_bp_z - hp_bp_t/2])
                cube([hp_post_dx + 12, hp_post_dy + 12, hp_bp_t], center = true);
            for (hx = hp_hat_xs) for (hy = hp_hat_ys)        // HAT mounting standoffs (overlap plate 0.5)
                translate([hp_cx + hx, hp_cy + hy, hp_bp_z - 0.5]) cylinder(d = 6, h = so_h + 0.5);
        }
        for (sx = [-1,1]) for (sy = [-1,1])                  // panel-post clearance (M3)
            translate([hp_cx + sx*hp_post_dx/2, hp_cy + sy*hp_post_dy/2, hp_bp_z - hp_bp_t - 0.1])
                cylinder(d = 3.4, h = hp_bp_t + 0.2);
        for (hx = hp_hat_xs) for (hy = hp_hat_ys) {          // HAT screws from the BACK: M2.5 clear + head counterbore
            translate([hp_cx + hx, hp_cy + hy, hp_bp_z - hp_bp_t - 0.1])
                cylinder(d = 2.8, h = so_h + hp_bp_t + 0.2);
            translate([hp_cx + hx, hp_cy + hy, hp_bp_z - hp_bp_t - 0.1])
                cylinder(d = 5.0, h = 2.6);                  // recess the head flush with the back face (PiSquare-style)
        }
    }
}

// =============================================================================
// PANEL — slab + HyperPixel rear collar, minus all device openings + mounts.
// =============================================================================
module panel() {
    union() {
        difference() {
            union() {
                translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);
                // HyperPixel rear locating collar
                translate([hp_cx, hp_cy, -3]) cube([hp_pocket + 5, hp_pocket + 5, 6], center = true);
                // MacroPad rear locating collar (pocket walls)
                translate([mp_cx, mp_cy, -mp_collar_h/2])
                    cube([mp_pocket_w + 2*mp_collar_wall, mp_pocket_h + 2*mp_collar_wall, mp_collar_h], center = true);
            }
            // HyperPixel: recessed pocket + front window
            translate([hp_cx, hp_cy, (seat_z - 6)/2])
                cube([hp_pocket, hp_pocket, seat_z + 6 + 0.02], center = true);
            translate([hp_cx, hp_cy, plate_t - hp_lip/2])
                cube([hp_window, hp_window, hp_lip + 0.1], center = true);

            // MacroPad face opening (keys/encoder/OLED show; NO USB cutout)
            translate([mp_cx, mp_cy, plate_t/2])
                linear_extrude(plate_t + 2, center = true) rrect(mp_face_w, mp_face_h, 4);

            // MacroPad pocket: PCB cavity behind the opening (board seats on the panel back)
            translate([mp_cx, mp_cy, -mp_collar_h/2])
                cube([mp_pocket_w, mp_pocket_h, mp_collar_h + 0.02], center = true);

            // Slider: slide-pot HOUSING flush cutout (knob proud; PCB screwed behind)
            translate([col_cx, sld_cy, plate_t/2])
                linear_extrude(plate_t + 2, center = true)
                    rrect(sld_house_w + 2*sld_clr, sld_house_h + 2*sld_clr, (sld_house_w + 2*sld_clr)/2);

            // OLED active window
            translate([col_cx, oled_cy, plate_t/2])
                cube([oled_aw, oled_ah, plate_t + 2], center = true);

            // OLED: 4 tapped pilots in the panel back (board screws flat against it)
            for (sx = [-1,1]) for (sy = [-1,1])
                translate([col_cx + sx*oled_hx, oled_cy + sy*oled_hy, -0.1])
                    cylinder(d = boss_pilot, h = 2.7);

            // Slant-insert mount screws
            for (sx = [-cheek_ctr_x, cheek_ctr_x])
                for (y = mount_y)
                    translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);
        }
        // --- rear standoffs (added after the cuts so the pocket doesn't eat them) ---
        // MacroPad: PCB flat on the panel back, keys proud -> screw via the 4 M3
        // holes (52.07 x 81.28). 2 holes fall inside the opening -> bridge bosses
        // on arms (7"-display L-brace pattern); next pass.
        for (sx = [-1,1]) for (sy = [-1,1]) standoff(col_cx + sx*sld_hx, sld_cy + sy*sld_hy, sld_pcb_z); // slider 3.6
        // MacroPad: 4 backplate mounting posts (the printed backplate screws here)
        for (sx = [-1,1]) for (sy = [-1,1]) post(mp_cx + sx*mp_post_dx/2, mp_cy + sy*mp_post_dy/2, mp_post_h, mp_post_od, mp_post_pilot);
        // HyperPixel: 4 backplate mounting posts (same methodology; backplate also
        // screws to the screen's HAT holes from the back, PiSquare-style).
        for (sx = [-1,1]) for (sy = [-1,1]) post(hp_cx + sx*hp_post_dx/2, hp_cy + sy*hp_post_dy/2, hp_post_h, mp_post_od, mp_post_pilot);
    }
}

// =============================================================================
// MOCK DEVICES — fit-check only (not printed).
// =============================================================================
module devices() {
    // HyperPixel
    color("DimGray")  translate([hp_cx, hp_cy, seat_z - hp_depth/2]) cube([hp_board, hp_board, hp_depth], center = true);
    color("RoyalBlue") translate([hp_cx, hp_cy, seat_z - 0.5]) cube([hp_active, hp_active, 0.8], center = true);

    // MacroPad — real STL, CLIPPED to drop the STL's phantom bottom plate (the
    // real PCB has none). PCB top at z = -mp_lower; keys proud above the panel.
    color("Chocolate")
    intersection() {
        translate([mp_cx, mp_cy, mp_z_off]) import(mp_stl, convexity = 6);
        translate([mp_cx, mp_cy, mp_z_off + 98]) cube([300, 300, 200], center = true);  // keep STL z > -2
    }

    // OLED (active = cyan)
    color("DimGray") translate([col_cx, oled_cy, -2]) cube([oled_bw, oled_bh, 6], center = true);
    color("Cyan")    translate([col_cx, oled_cy, seat_z - 0.4]) cube([oled_aw, oled_ah, 0.8], center = true);

    // Slider: housing flush (top at panel face) + knob proud to 15.5 mm above PCB (9 mm proud)
    color("SeaGreen") translate([col_cx, sld_cy, plate_t - sld_house_z/2]) cube([sld_house_w, sld_house_h, sld_house_z], center = true);
    color("Black")    translate([col_cx, sld_cy, plate_t + 4.5]) cube([4, 6, 9], center = true);
}

if (part == "macropad_backplate") {
    color("Tan") macropad_backplate();
} else if (part == "hyperpixel_backplate") {
    color("Tan") hyperpixel_backplate();
} else {
    color("Gainsboro") panel();
    if (show_devices) devices();
    if (show_backplate) { color("Tan") macropad_backplate(); color("Tan") hyperpixel_backplate(); }
}
