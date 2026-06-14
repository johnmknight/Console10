// =============================================================================
// CONSOLE10 — Screen + Slider + OLED faceplate  v0.1
//
// Derived from Console10_dsky_panel.scad with the MacroPad keypad (and all its
// retention: opening, pocket, collar, posts, backplate) REMOVED. Three devices:
//   - Pimoroni HyperPixel 4.0 Square Touch  (720x720 display)     CONFIRMED dims
//   - Adafruit NeoSlider 5295 (vertical fader)         dims from Adafruit STEP CAD
//   - Adafruit 0.91" 128x32 OLED 4440 (readout)        dims from Adafruit STEP CAD
//   - 3x guarded toggle switches in a row below the screen (Shuttle switch guard)
//
// LAYOUT: the screen (left/center) and the slider+OLED column (right) are
// re-centred as a balanced pair across the 3U plate now that the keypad is gone.
//
// Local frame: X = width, Y = up the plate, Z = thickness. Front at Z=plate_t.
// =============================================================================

// ---------- module geometry ----------
panel_width  = 253;  cheek_thick = 10;  U = 44.45;  slant_angle = 30;
interior_half = panel_width/2 - cheek_thick;        // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2;      // 121.5

// ---------- flat plate ----------
n_u     = 3;                  // slider+OLED column (~98.5 mm) needs 3U
plate_w = 253;
plate_h = n_u * U;            // 133.35
plate_t = 3;

// ---------- HyperPixel 4.0 Square (CONFIRMED) ----------
hp_board = 84;  hp_active = 72;  hp_depth = 9.5;  hp_rim_t = 4.6;
hp_lip   = 1.5; hp_winrev = 0.5;
hp_window = hp_active + 2*hp_winrev;        // 73
hp_clr   = 0.3; hp_pocket = hp_board + 2*hp_clr;   // 84.6
hp_cx = -30;                                // screen column, left of centre

// ---------- 3 guarded toggle switches (row below the screen) ----------
// Guard: ImAThingsGuy "Space Shuttle Toggle Switch Guard" (25 x 25 x 30, STL-meas;
// public domain). Switch: COROTC SPST, 12 mm bushing; its own nut clamps the guard
// to the FRONT face, so the panel only needs a 12 mm hole per switch.
tog_n      = 3;
tog_hole_d = 12.4;                          // 12 mm bushing + clearance
tog_guard  = 25;                            // guard footprint (square) for spacing
tog_pitch  = 32;                            // centre-to-centre (25 guard + ~7 gap)
tog_cx     = hp_cx;                         // row centred under the screen
tog_cy     = 19;                            // row height above the bottom edge
tog_gap    = 7;                             // clear gap: screen bottom -> guard tops
tog_recess   = 25.6;                        // square recess for the guard base (25 + 0.3/side)
tog_recess_d = 2;                           // recess depth into the 3 mm panel (~1 mm floor left)
tog_guard_rot = 90;                         // spin the guards about their axis (ring/opening direction)
tog_guard_stl = "C:/3d files/NASA/switch guards/space-shuttle-switch-guard.stl";

// Screen RAISED (was plate_h/2 centred) so the guard row fits beneath it.
hp_cy = tog_cy + tog_guard/2 + tog_gap + hp_board/2;   // ~80.5

// ---------- slider + OLED right column (Adafruit STEP CAD: repo Adafruit_CAD_Parts) ----------
// OLED 4440: PCB 33.02 x 21.46, 4 holes 27.94 x 16.51 (M2.5) centred on the board,
//   active glass 22.384 x 5.584 centred on the hole pattern (CAD-confirmed both axes).
// NeoSlider 5295: PCB 76.2 x 21.59; 4 holes at +-19.05 (along) x +-8.255 (across) =
//   38.1 x 16.51 pattern; slide-pot HOUSING 75 x 9.5 sits FLUSH, top 6.5 mm proud of
//   the PCB, knob protrudes to 15.5 mm. Mounted VERTICAL (long axis up the plate).
oled_bw = 33.02;  oled_bh = 21.46;  oled_aw = 22.384;  oled_ah = 5.584;  // CAD PCB / active
oled_hole_dx = 27.94;  oled_hole_dy = 16.51;  oled_hole_d = 2.6;         // 4 corner holes (M2.5)
oled_mod_w = 30.5;  oled_mod_h = 12;         // display-module footprint (CAD ~30 x 11.5) -> pocket
oled_glass_off = 2.5;                        // glass front above the PCB front (CAD)
oled_lip = plate_t - oled_glass_off;         // 0.5 front window lip; glass sits just behind it
oled_pkt_clr = 0.4;                          // pocket clearance around the module
oled_post_h  = 5;                            // tapped post depth behind the PCB (screws from rear)
sld_bw  = 21.59;  sld_bh = 76.2;             // CAD PCB (vertical orientation)
sld_house_w = 9.4;  sld_house_h = 75.1;      // slide-pot metal housing (measured; CAD STEP = 9.5 x 75.0)
sld_house_z = 6.5;                           // housing top above PCB front (CAD)
sld_clr = 0.4;                               // cut clearance around the housing
sld_hole_dx = 16.51;  sld_hole_dy = 38.1;    // 4 PCB holes (across x along), vertical mount (CAD)
sld_hole_d  = 2.6;                            // M2.5 clearance
col_cx  = 60;                                // right column, right of centre
// slider+OLED stack: PCBs TOUCHING (OLED on top, slider below), the column
// vertically CENTRED on the right — decoupled from the screen, which is now raised
// (keeping the old "5 mm below screen bottom" would push the OLED off the top).
sld_cy  = plate_h/2 - oled_bh/2;                           // centres the touching stack
oled_cy = sld_cy + sld_bh/2 + oled_bh/2;                   // OLED on top, PCB edges touching (0 gap)

// ---------- slant-insert mount holes (perpendicular through the plate) ----------
mount_y = [50.80, 127.00];            // real cheek rows for 3U
m10_32_clear = 5.5;

show_devices = true;
part = "panel";           // "panel" | "hyperpixel_backplate"
show_backplate = true;    // show the (real) backplate behind the screen for fit-check
$fn = 40;
seat_z = plate_t - hp_lip;            // 1.5

echo(str("SCREEN+SLIDER PANEL v0.1  ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | HP@(", hp_cx, ",", hp_cy, ") OLED@(", col_cx, ",", oled_cy,
         ") slider@(", col_cx, ",", sld_cy, ")"));

module rrect(w, h, r) {
    hull() for (sx = [-1,1]) for (sy = [-1,1])
        translate([sx*(w/2 - r), sy*(h/2 - r)]) circle(r);
}

// ---------- retention: rear standoff bosses (each PCB screws on from behind) ---
boss_od    = 6;                       // standoff outer diameter
boss_pilot = 2.1;                     // M2.5 self-tap pilot
sld_pcb_z  = plate_t - sld_house_z;   // -3.5   slider PCB front (6.5 housing sits flush)
post_merge = 0.6;                     // posts/standoffs sink this far into the slab so they fuse cleanly
sld_hx = sld_hole_dx/2; sld_hy = sld_hole_dy/2;   // slider holes: 8.255 across x 19.05 along
oled_hx = oled_hole_dx/2; oled_hy = oled_hole_dy/2;   // OLED 4 corners (27.94 x 16.51)

// A tapped post from the panel back (z=0) out to z_seat (negative); the PCB
// seats on the far end and is screwed in from behind.
module standoff(x, y, z_seat) {
    difference() {
        translate([x, y, z_seat]) cylinder(d = boss_od, h = -z_seat + post_merge);   // overlap into slab
        translate([x, y, z_seat - 0.1]) cylinder(d = boss_pilot, h = -z_seat + 0.2);
    }
}

// A solid tapped post on the panel back (z=0) extending back by h.
module post(x, y, h, od, pilot) {
    difference() {
        translate([x, y, -h]) cylinder(d = od, h = h + post_merge);                   // overlap into slab
        translate([x, y, -h - 0.1]) cylinder(d = pilot, h = h + 0.2);
    }
}

// =============================================================================
// HYPERPIXEL BACKPLATE — screws to the screen's HAT holes from the BACK; bolts to
// 4 panel posts. Per the board photo, only the 2 HAT holes on the FPC/touch-flex
// edge are usable — the other 2 are blocked by the GPIO header + ribbon cable — so
// the plate mounts on 2 stems and has a clearance WINDOW for the GPIO connector +
// cable on the opposite (GPIO) edge.
// =============================================================================
hp_board_back = seat_z - hp_rim_t;        // -3.1, screen PCB back plane
hp_hat_xs = [-38, 20];                     // HAT hole X, board-centered (58 wide)  [verify]
hp_hat_ys = [35.5, -13.5];                 // HAT hole Y (49 tall)                   [verify]
hp_hat_use_y = hp_hat_ys[0];               // 35.5 = the usable (FPC-edge) HAT pair; flip to ys[1] if mirrored
// GPIO connector + ribbon-cable slot — OPEN through the GPIO edge so the cable routes out
hp_gpio_w = 58;                            // slot width (40-pin IDC ~53 + cable)
hp_gpio_inner_y = -19;                     // slot inner end (board-rel Y); runs out past the edge
hp_post_dx = 80;  hp_post_dy = 96;         // panel-post pattern (clears the neighbours)
hp_post_h  = 10;                            // post length behind the panel
hp_bp_t = 4;
hp_bp_z = -hp_post_h;
hp_bp_half_h = (hp_post_dy + 12)/2;        // 54 — backplate half-height (slot runs to this edge)
mp_post_od = 7;  mp_post_pilot = 2.5;      // panel-post OD / M3 self-tap pilot

module hyperpixel_backplate() {
    so_h = hp_board_back - hp_bp_z;          // standoff to the screen PCB back
    difference() {
        union() {
            translate([hp_cx, hp_cy, hp_bp_z - hp_bp_t/2])
                cube([hp_post_dx + 12, hp_post_dy + 12, hp_bp_t], center = true);
            for (hx = hp_hat_xs)                             // 2 usable HAT standoffs (FPC edge only)
                translate([hp_cx + hx, hp_cy + hp_hat_use_y, hp_bp_z - 0.5]) cylinder(d = 6, h = so_h + 0.5);
        }
        for (sx = [-1,1]) for (sy = [-1,1])                  // panel-post clearance (M3)
            translate([hp_cx + sx*hp_post_dx/2, hp_cy + sy*hp_post_dy/2, hp_bp_z - hp_bp_t - 0.1])
                cylinder(d = 3.4, h = hp_bp_t + 0.2);
        for (hx = hp_hat_xs) {                               // HAT screws (2 usable holes) from the BACK
            translate([hp_cx + hx, hp_cy + hp_hat_use_y, hp_bp_z - hp_bp_t - 0.1])
                cylinder(d = 2.8, h = so_h + hp_bp_t + 0.2);
            translate([hp_cx + hx, hp_cy + hp_hat_use_y, hp_bp_z - hp_bp_t - 0.1])
                cylinder(d = 5.0, h = 2.6);                  // recess the head flush with the back face
        }
        // GPIO connector + ribbon-cable slot — runs from the inner end OUT through the
        // GPIO edge (6 mm past it) so the cable exits the board edge.
        translate([hp_cx, hp_cy + (hp_gpio_inner_y - hp_bp_half_h - 6)/2, hp_bp_z - hp_bp_t/2])
            cube([hp_gpio_w, hp_gpio_inner_y + hp_bp_half_h + 6, hp_bp_t + 4], center = true);
    }
}

// =============================================================================
// PANEL — slab + HyperPixel rear collar, minus the screen/slider/OLED openings.
// =============================================================================
module panel() {
    union() {
        difference() {
            union() {
                translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);
                // HyperPixel rear locating collar
                translate([hp_cx, hp_cy, -3]) cube([hp_pocket + 5, hp_pocket + 5, 6], center = true);
            }
            // HyperPixel: recessed pocket + front window
            translate([hp_cx, hp_cy, (seat_z - 6)/2])
                cube([hp_pocket, hp_pocket, seat_z + 6 + 0.02], center = true);
            translate([hp_cx, hp_cy, plate_t - hp_lip/2])
                cube([hp_window, hp_window, hp_lip + 0.1], center = true);

            // Slider: slide-pot HOUSING flush cutout — SQUARE rectangle (not rounded)
            // so the rectangular metal housing seats flush to the panel face (knob
            // proud; PCB screwed behind). Housing top sits at z = plate_t.
            translate([col_cx, sld_cy, plate_t/2])
                cube([sld_house_w + 2*sld_clr, sld_house_h + 2*sld_clr, plate_t + 2], center = true);

            // OLED active window — through the thin front lip only
            translate([col_cx, oled_cy, plate_t - oled_lip/2])
                cube([oled_aw, oled_ah, oled_lip + 0.1], center = true);
            // OLED display-module pocket — recess from the back so the glass nests up
            // to the front lip (the module is bigger than the active window)
            translate([col_cx, oled_cy, (plate_t - oled_lip)/2 - 0.05])
                cube([oled_mod_w + 2*oled_pkt_clr, oled_mod_h + 2*oled_pkt_clr, plate_t - oled_lip + 0.1], center = true);

            // Toggle switches — square guard-base recess in the front face + bushing hole
            for (i = [0 : tog_n-1]) {
                tx = tog_cx + (i - (tog_n-1)/2)*tog_pitch;
                translate([tx, tog_cy, -1])
                    cylinder(d = tog_hole_d, h = plate_t + 2);                              // bushing hole (through)
                translate([tx, tog_cy, plate_t - tog_recess_d/2 + 0.05])
                    cube([tog_recess, tog_recess, tog_recess_d + 0.1], center = true);      // square base recess (front)
            }

            // Slant-insert mount screws
            for (sx = [-cheek_ctr_x, cheek_ctr_x])
                for (y = mount_y)
                    translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);
        }
        // --- rear standoffs (added after the cuts so the pocket doesn't eat them) ---
        for (sx = [-1,1]) for (sy = [-1,1]) standoff(col_cx + sx*sld_hx, sld_cy + sy*sld_hy, sld_pcb_z); // slider 3.6
        // OLED: PCB seats flat on the panel back (z=0); 4 tapped posts behind for rear screws
        for (sx = [-1,1]) for (sy = [-1,1]) post(col_cx + sx*oled_hx, oled_cy + sy*oled_hy, oled_post_h, boss_od, boss_pilot);
        // HyperPixel: 4 backplate mounting posts (backplate also screws to the
        // screen's HAT holes from the back, PiSquare-style).
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

    // OLED — PCB flat on the panel back (front at z=0); display module nests in the
    // pocket; active glass sits just behind the front lip.
    color("DimGray") translate([col_cx, oled_cy, -0.8]) cube([oled_bw, oled_bh, 1.6], center = true);          // PCB
    color("DarkSlateGray") translate([col_cx, oled_cy, oled_glass_off/2]) cube([oled_mod_w, oled_mod_h, oled_glass_off], center = true);  // display module
    color("Cyan")    translate([col_cx, oled_cy, plate_t - oled_lip - 0.05]) cube([oled_aw, oled_ah, 0.3], center = true);  // active glass at the lip

    // Slider: housing flush (top at panel face) + knob proud to 15.5 mm above PCB (9 mm proud)
    color("SeaGreen") translate([col_cx, sld_cy, plate_t - sld_house_z/2]) cube([sld_house_w, sld_house_h, sld_house_z], center = true);
    color("Black")    translate([col_cx, sld_cy, plate_t + 4.5]) cube([4, 6, 9], center = true);

    // Guarded toggle switches — guard standing on the panel: square base seated in the
    // recess (base bottom at the recess floor), ring vertical (rotate 90 about X).
    color("Silver") for (i = [0 : tog_n-1])
        translate([tog_cx + (i - (tog_n-1)/2)*tog_pitch, tog_cy, plate_t - tog_recess_d + 12.5])
            rotate([0, 0, tog_guard_rot]) rotate([90, 0, 0]) import(tog_guard_stl, convexity = 6);
}

if (part == "hyperpixel_backplate") {
    color("Tan") hyperpixel_backplate();
} else {
    color("Gainsboro") panel();
    if (show_devices) devices();
    if (show_backplate) color("Tan") hyperpixel_backplate();
}
