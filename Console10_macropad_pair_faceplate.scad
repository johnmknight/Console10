// =============================================================================
// CONSOLE10 — Twin-MacroPad Lower Faceplate  v0.2
//
// v0.2 (2026-06-17): added the guarded-switch row. OLED status display removed.
// Six toggle switches (14.7 x 29.1 x 26.8 body) in the skirt at Y=42, X in the
// post gaps [+/-24, +/-52, +/-80] so the bodies foul ONLY the mount board (which
// is relieved at each). Space-shuttle-style flip GUARDS are FUSED into two 3-gang
// banks (one per trio) — see guard_bank() / part="guard_bank". Panel carries 6
// bushing holes + 2 sharp-cornered gang locating pockets (86 x 25, 2.5 mm deep).
// Print: panel x1, mount_board x1, guard_bank3 x2. See Console10_macropad_pair_notes.md.
//
// The 2U panel that sits BENEATH the display faceplate (plain blank base, no
// isogrid), carrying TWO Adafruit MacroPad RP2040s. Each MacroPad is rotated 90
// deg so the long axis runs ACROSS the panel; the two boards meet PCB-to-PCB at
// the centre, leaving the encoder ("pot") + OLED ends out at the FAR ends.
//
//   [ OLED/enc | keys ........ | keys | OLED/enc ]
//        far-left   <- PCBs touch at centre ->   far-right
//
// Reuses the DSKY panel's MacroPad mounting solution:
//   - rear locating POCKET + COLLAR (PCB drops in from behind, keys stay proud,
//     lowered mp_lower behind the panel back)
//   - 4 panel POSTS per pad; a separate printed BACKPLATE bolts to those posts
//     and screws to the MacroPad's own 4 PCB holes.
// ONE adaptation for the touching-PCB layout: the inner short-ends meet at the
// centre seam with no room for a post/wall there, so the post pattern straddles
// the LONG sides and the inner posts land in the free space above/below the seam,
// staggered between the two pads so they never collide. (The two collars/pockets
// merge into one centre cavity — the boards butt together, no centre wall.)
//
// Local frame (also print orientation): X = width, Y = up the plate (= up the
// slant), Z = thickness. Front at Z = plate_t, back at Z = 0. MacroPad local
// frame: +Y = encoder/OLED end.
// =============================================================================

// ---------- module geometry the plate must mate to ----------
panel_width   = 253;
cheek_thick   = 10;
slant_angle   = 30;
U             = 44.45;
interior_half = panel_width/2 - cheek_thick;   // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5

// ---------- flat plate (3U: pads in the top, blank skirt below) ----------
// Extended from 2U -> 3U: the blank lower area keeps the MacroPads (and their rear
// mount-board assembly) HIGH so they clear the shelf/floor when mounted below the 7" monitor.
n_u      = 3;
plate_w  = 253;
plate_h  = n_u * U;       // 133.35
plate_t  = 3;

// ---------- slant-insert mount holes (3U rack rows, as the other 3U panels) ----------
mount_y      = [50.80, 127.00];
m10_32_clear = 5.5;

// ---------- MacroPad RP2040 (STL-measured envelope + fab-print PCB) ----------
mp_w       = 60.75;  mp_h = 105.25;            // board envelope (STL)
mp_board_w = 59.69;  mp_board_h = 104.14;      // PCB (fab print)
mp_pkt_clr = 0.3;
mp_pocket_w = mp_board_w + 2*mp_pkt_clr;       // 60.29
mp_pocket_h = mp_board_h + 2*mp_pkt_clr;       // 104.74
// Face opening = the pocket (PCB) edge on BOTH axes -> NO front lip at all. The
// old lip (56 x 100) overhung the outer key columns on the long sides AND the
// OLED/encoder on the ends, blocking keycaps and the displays. Cut flush to the
// PCB edge all round; retention is via the rear mount board (PCB screws to it).
mp_face_w  = mp_pocket_w;                       // 60.29  (long-side lip removed)
mp_face_h  = mp_pocket_h;                       // 104.74 (end lip removed -> clears the OLED)
mp_collar_wall = 2.5;
mp_lower    = 5;                               // recess the keypad this far behind the panel back
mp_collar_h = 6 + mp_lower;                    // 11 — pocket wall depth
mp_stl      = "C:/Users/john_/Downloads/5128 MacroPad RP2040-Assembly.stl";
mp_pcb_top_stl = 3;
mp_z_off    = -mp_pcb_top_stl - mp_lower;      // -8: STL z -> model z (PCB top at z = -mp_lower)

// MacroPad PCB mounting holes (the MP screws onto the backplate here).
// PITCH is 52.07 x 81.28 (2.05" x 3.20"), BUT the 4-hole pattern is NOT centred
// on the board -- measured from the 5128 assembly STL it sits 7.65 mm toward the
// OLED/encoder (+Y) end. So holes are at (+/-mp_hx, +/-mp_hy + mp_hy_off).
mp_hx = 52.07/2;  mp_hy = 81.28/2;             // 26.035 x 40.64  (half-pitch)
mp_hy_off = 7.65;                              // pattern offset toward +Y (OLED end)

// Backplate post pattern (LOCAL MacroPad frame). Across = ±sx (just outside the
// long-side collar wall, which reaches 32.65); along = ±sy (inboard of the board
// ends so, once rotated, the inner pair clears the centre seam).
mp_post_sx = 38;     // across the board (local X)  -> world Y after the 90 deg turn
mp_post_sy = 44;     // along the board  (local Y)  -> world X
mp_post_od = 7;  mp_post_pilot = 2.5;
mp_post_h  = 10 + mp_lower;                     // 15

// ---------- the two MacroPad centres (boards meet at x = 0) ----------
mp_gap = 0;                                     // 0 = PCBs touch; raise for a centre gap/wall
mp_cx  = mp_board_h/2 + mp_gap/2;               // 52.07
mp_cy  = plate_h - U;                           // 88.9 — pads pushed to the TOP (blank skirt below)
// left pad: rot +90 (OLED -> far left); right pad: rot -90 (OLED -> far right)

// =============================================================================
// LOWER-SKIRT ACCESSORIES: a ROW of switch guards across the TOP of the skirt
// (1 under the LEFT MacroPad + 5 right-aligned). The panel carries only the guard
// HOLES + square RECESSES — the printed shuttle guards are glued in separately.
// (OLED status display removed.)
// =============================================================================

// Switch guards (printed separately, GLUED in): panel gets only a 12 mm bushing
// hole + a square base recess. 1 under the left MacroPad, 5 right-aligned.
tog_hole_d = 12.4;  tog_recess = 25.6;  tog_recess_d = 2;
tog_cy = 42;                                  // switch row Y (original height, top of skirt)
// X positions chosen to sit in the CLEAR GAPS between the mount-board posts
// (posts at X = +/-8.07 and +/-96.07): each switch clears every post by >=4 mm,
// so the bodies foul ONLY the flat backplate (to be relieved there), never a post.
tog_x = [-80, -52, -24, 24, 52, 80];

// guard panel feature: just the toggle bushing hole (through). The base recess is
// now ONE gang pocket per trio (gang_recess), not a square per switch.
module guard_cut(cx)
    translate([cx, tog_cy, -1]) cylinder(d = tog_hole_d, h = plate_t + 2);

// ---- printed switch GUARD (space-shuttle style) — the part GLUED into the front
// recess. STL bbox measured = 25.0 x 25.0 x 30.0, centred in XY, Z -15..+15.
// NOTE: current recess (tog_recess = 25.6 sq x 2 mm deep) is too tight/shallow to
// seat this base — resize the recess to the guard base + clearance once orientation
// is confirmed. Tweak guard_z / guard_rx in the GUI to seat it on the front face.
guard_stl = "C:/3d files/NASA/switch guards/space-shuttle-switch-guard.stl";
show_guards = true;
// STL hole axis = guard Y (cage on +Y, flat mount face on -Y), hole centred in X/Z.
// rotate +90 about X puts the hole axis on the panel normal (Z) so it registers
// with the bushing; origin then sits 12.5 mm (half the body) in front, seating the
// -Y mount face on the panel front.
guard_rx  = 90;
guard_rz  = 90;               // spin about the panel normal so the cage reads vertical
guard_z   = plate_t + 12.5;   // mount face on the front, cage facing the user
module guard_mock(cx)
    translate([cx, tog_cy, guard_z]) rotate([0, 0, guard_rz]) rotate([guard_rx, 0, 0])
        import(guard_stl, convexity = 8);

// One guard in the mounting orientation, hole on the Z axis, centred at origin.
module one_guard()
    rotate([0, 0, guard_rz]) rotate([guard_rx, 0, 0]) import(guard_stl, convexity = 8);

// A BANK of n guards at the switch pitch, fused into ONE part (the overlapping
// cages union together — the shuttle "gang" guard). Centred on X for printing.
tog_pitch = tog_x[1] - tog_x[0];               // 28 — adjacent switch spacing
module guard_bank(n = 3)
    union() for (i = [0:n-1])
        translate([(i - (n-1)/2) * tog_pitch, 0, 0]) one_guard();

// ---- gang locating pocket: ONE per trio, sized to the fused 3-gang base ----
// Base measured from Console10_guard_bank3.stl = 86 (X) x 25 (Y).
gang_w  = 86;  gang_h = 25;  gang_clr = 0.5;  gang_recess_d = 2.5;
gang_cx = [ (tog_x[0]+tog_x[1]+tog_x[2])/3, (tog_x[3]+tog_x[4]+tog_x[5])/3 ];  // [-52, 52]
module gang_recess(cx)
    translate([cx, tog_cy, plate_t - gang_recess_d/2 + 0.05])
        linear_extrude(gang_recess_d + 0.1, center = true)
            square([gang_w + 2*gang_clr, gang_h + 2*gang_clr], center = true);   // sharp corners

// ---- guarded-switch MOCK (measured): mounts THROUGH the bushing hole — threaded
// bushing + nut poke out the front (into the guard), the rectangular body hangs
// behind the panel. Rendered exactly at each guard position so every clash
// (mount board, posts, OLED) is visible. Fit-check only, never printed.
sw_body_w   = 14.7;     // across the bushing
sw_body_h   = 29.1;     // the long side of the body
sw_body_d   = 26.8;     // depth BEHIND the panel back (z = 0 -> -sw_body_d)
sw_body_clr = 1.0;      // air gap we want to keep around the body
sw_body_vertical = true;   // true: 29.1 runs UP the plate (local Y); false: across (X)
sw_bush_d    = 12;      // threaded bushing (through the 12.4 hole)
sw_bush_proud = 8;      // bushing + nut sticking out the front face
module switch_mock(cx) {
    bw = sw_body_vertical ? sw_body_w : sw_body_h;
    bh = sw_body_vertical ? sw_body_h : sw_body_w;
    translate([cx, tog_cy, 0]) {
        // body behind the panel (semi-transparent so overlaps show through the board)
        color("Crimson", 0.5)
            translate([0, 0, -sw_body_d/2]) cube([bw + 2*sw_body_clr, bh + 2*sw_body_clr, sw_body_d], center = true);
        // threaded bushing + nut through the panel and proud at the front
        color("Silver") translate([0, 0, -2]) cylinder(d = sw_bush_d, h = plate_t + sw_bush_proud + 2);
        // toggle lever poking forward
        color("DimGray") translate([0, 0, plate_t + sw_bush_proud]) cylinder(d = 4, h = 9);
    }
}

// ---------- backplate ----------
mp_bp_t     = 4;
mp_bp_z     = -mp_post_h;                       // plate top at the post ends (-15)
mp_pcb_back = -mp_lower - 1.6;                  // -6.6: MP PCB board bottom
mp_bp_margin = 12;                              // plate margin around the post pattern

show_devices  = true;
show_backplate = true;
part = "panel";          // "panel" | "macropad_backplate"
$fn = 48;

echo(str("TWIN-MACROPAD FACEPLATE v0.2 ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | pads @ x=+/-", mp_cx, " (gap ", mp_gap, ") cy=", mp_cy,
         " | posts local +/-", mp_post_sx, " x +/-", mp_post_sy));

// ---------- helpers ----------
module rrect(w, h, r) {
    hull() for (sx = [-1,1]) for (sy = [-1,1])
        translate([sx*(w/2 - r), sy*(h/2 - r)]) circle(r);
}

// A solid tapped post on the panel back (z=0) extending back by h.
module post(x, y, h, od, pilot) {
    difference() {
        translate([x, y, -h]) cylinder(d = od, h = h);
        translate([x, y, -h - 0.1]) cylinder(d = pilot, h = h + 0.2);
    }
}

// place children at a MacroPad slot: shift to centre x, keep cy, turn by rot.
module place_pad(cx, rot) translate([cx, mp_cy, 0]) rotate([0, 0, rot]) children();

// ---- MacroPad features, defined in the pad's LOCAL frame (centred at origin) ----
module mp_collar_local()
    translate([0, 0, -mp_collar_h/2])
        cube([mp_pocket_w + 2*mp_collar_wall, mp_pocket_h + 2*mp_collar_wall, mp_collar_h], center = true);

module mp_face_cut_local()
    translate([0, 0, plate_t/2])
        linear_extrude(plate_t + 2, center = true) square([mp_face_w, mp_face_h], center = true);

module mp_pocket_cut_local()
    translate([0, 0, -mp_collar_h/2])
        cube([mp_pocket_w, mp_pocket_h, mp_collar_h + 0.02], center = true);

module mp_posts_local()
    for (sx = [-1,1]) for (sy = [-1,1])
        post(sx*mp_post_sx, sy*mp_post_sy, mp_post_h, mp_post_od, mp_post_pilot);

// USB-C exit notch: the connector is centred on the pad's OUTER (OLED) edge and
// pokes into the collar wall, so the wall is notched there for the board to seat
// and the cable to clear. After the 90 deg turn this lands at the pad's FAR end =
// a side notch. Behind the panel (z<0), not cut through the front face.
mp_usb_w = 14;       // slot width (USB-C ~9 mm + cable clearance)
module mp_usb_notch_local() {
    y0 = mp_pocket_h/2 - 2;                       // start just inside the pocket
    y1 = mp_pocket_h/2 + mp_collar_wall + 8;      // out past the collar wall (cable relief)
    translate([0, (y0 + y1)/2, (-mp_collar_h - 1)/2 + 0.05])
        cube([mp_usb_w, y1 - y0, mp_collar_h + 1.1], center = true);
}

// MacroPad STL mock, clipped to drop the STL's phantom bottom plate (keys proud).
module mp_mock_local()
    intersection() {
        translate([0, 0, mp_z_off]) import(mp_stl, convexity = 6);
        translate([0, 0, mp_z_off + 98]) cube([300, 300, 200], center = true);
    }

// =============================================================================
// BACKPLATE — one printed part (the two slots are mirror-symmetric, so the same
// part serves both). Bolts to the 4 panel posts; standoffs reach the MP PCB and
// the MP screws into them from behind through its 4 PCB holes.
// =============================================================================
module macropad_backplate() {
    so_h = mp_pcb_back - mp_bp_z;               // 8.4 standoff up to the PCB
    difference() {
        union() {
            // plate + holes share the MacroPad LOCAL frame (same as the panel posts),
            // so a single place_pad(cx, rot) lands the backplate squarely on its posts.
            translate([0, 0, mp_bp_z - mp_bp_t/2])
                cube([2*mp_post_sx + mp_bp_margin, 2*mp_post_sy + mp_bp_margin, mp_bp_t], center = true);
            for (sx = [-1,1]) for (sy = [-1,1])     // MP mounting standoffs
                translate([sx*mp_hx, sy*mp_hy, mp_bp_z]) cylinder(d = 7, h = so_h);
        }
        for (sx = [-1,1]) for (sy = [-1,1])         // panel-post clearance holes (match mp_posts_local)
            translate([sx*mp_post_sx, sy*mp_post_sy, mp_bp_z - mp_bp_t - 0.1])
                cylinder(d = 3.4, h = mp_bp_t + 0.2);
        for (sx = [-1,1]) for (sy = [-1,1])         // MP screw clearance (back -> PCB)
            translate([sx*mp_hx, sy*mp_hy, mp_bp_z - mp_bp_t - 0.1])
                cylinder(d = 3.4, h = so_h + mp_bp_t + 0.2);
    }
}

// =============================================================================
// MOUNTING BOARD (NEW) — ONE printed part spanning BOTH pads. Derived from the
// real top-down layout: it bolts DOWN onto all 8 panel posts (±mp_post_sx ×
// ±mp_post_sy per pad) and carries 8 standoffs UP to the two MacroPad PCBs
// (±mp_hx × ±mp_hy per pad). The two bolt circles are intentionally different
// (posts sit outboard of the pocket wall), so the board bridges them rather than
// trying to make them concentric. Replaces the two loose per-pad backplates.
// =============================================================================
mb_t      = 4;                  // board thickness
mb_z      = -mp_post_h;         // board top sits on the post tips (z = -15)
mb_margin = 6;                  // outline margin around the feature pattern
// the OLED-end standoffs sit furthest out: x = mp_cx + mp_hy + mp_hy_off
mb_half_w  = mp_cx + mp_hy + mp_hy_off + mb_margin;   // ~106.4
mb_half_h  = mp_post_sx + mb_margin;                  // 44  (posts at cy ± mp_post_sx)

// per-pad features, LOCAL MacroPad frame. MP holes carry the +mp_hy_off shift ---
module mb_standoffs_local(so_h)
    for (sx=[-1,1]) for (sy=[-1,1])              // sink 1mm into the plate so it fuses
        translate([sx*mp_hx, sy*mp_hy + mp_hy_off, mb_z - 1]) cylinder(d = 7, h = so_h + 1);

module mb_holes_local(so_h) {
    for (sx=[-1,1]) for (sy=[-1,1])              // panel-post screw clearance
        translate([sx*mp_post_sx, sy*mp_post_sy, mb_z - mb_t - 0.1])
            cylinder(d = 3.4, h = mb_t + 0.2);
    for (sx=[-1,1]) for (sy=[-1,1])              // MP screw clearance (back -> PCB)
        translate([sx*mp_hx, sy*mp_hy + mp_hy_off, mb_z - mb_t - 0.1])
            cylinder(d = 3.4, h = so_h + mb_t + 0.2);
}

// Relief through the backplate so a guarded-switch body passes cleanly (matches
// the switch_mock footprint + a little clearance). Opens the board's lower edge
// as a notch at each switch X — the switches sit in the post gaps, so these never
// reach a post or a PCB standoff.
module sw_board_relief(cx) {
    bw = sw_body_vertical ? sw_body_w : sw_body_h;
    bh = sw_body_vertical ? sw_body_h : sw_body_w;
    rc = sw_body_clr + 0.5;                      // clearance around the body
    translate([cx, tog_cy, mb_z - mb_t/2])
        cube([bw + 2*rc, bh + 2*rc, mb_t + 4], center = true);
}

module macropad_mount_board() {
    so_h = mp_pcb_back - mb_z;                   // 8.4 standoff up to the PCB back
    difference() {
        union() {
            translate([0, mp_cy, mb_z - mb_t/2])
                linear_extrude(mb_t, center = true) rrect(2*mb_half_w, 2*mb_half_h, 6);
            place_pad(-mp_cx,  90) mb_standoffs_local(so_h);
            place_pad( mp_cx, -90) mb_standoffs_local(so_h);
        }
        place_pad(-mp_cx,  90) mb_holes_local(so_h);
        place_pad( mp_cx, -90) mb_holes_local(so_h);
        for (cx = tog_x) sw_board_relief(cx);    // switch-body clearance reliefs
    }
}

// =============================================================================
// PANEL — plain 2U slab, two rotated MacroPad mounts, slant-insert mount holes.
// =============================================================================
module panel() {
    union() {
        difference() {
            union() {
                translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);
                place_pad(-mp_cx,  90) mp_collar_local();
                place_pad( mp_cx, -90) mp_collar_local();
            }
            // MacroPad face openings + rear PCB pockets
            place_pad(-mp_cx,  90) { mp_face_cut_local(); mp_pocket_cut_local(); }
            place_pad( mp_cx, -90) { mp_face_cut_local(); mp_pocket_cut_local(); }
            // merge the two face openings at the centre (the boards already butt at
            // x=0) so the pads read as ONE continuous touching unit, no panel bridge.
            // Height = full opening width so no divider stub remains at the seam ends.
            translate([0, mp_cy, plate_t/2])
                cube([2*(mp_cx - mp_face_h/2) + 12, mp_face_w, plate_t + 2], center = true);
            // USB-C side notches: open each pad's outer collar wall at the connector
            place_pad(-mp_cx,  90) mp_usb_notch_local();
            place_pad( mp_cx, -90) mp_usb_notch_local();
            // Switch-guard features: 6 toggle bushing holes + 2 gang locating pockets
            for (cx = tog_x) guard_cut(cx);
            for (cx = gang_cx) gang_recess(cx);
            // slant-insert mount screws
            for (sx = [-cheek_ctr_x, cheek_ctr_x])
                for (y = mount_y)
                    translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);
        }
        // backplate mounting posts (added after the cuts so the pockets don't eat them)
        place_pad(-mp_cx,  90) mp_posts_local();
        place_pad( mp_cx, -90) mp_posts_local();
    }
}

// =============================================================================
// DEVICES — fit-check mocks (not printed): the two MacroPad STLs in place.
// =============================================================================
module devices() {
    color("Chocolate") place_pad(-mp_cx,  90) mp_mock_local();
    color("Peru")      place_pad( mp_cx, -90) mp_mock_local();
    // guarded switches at their mount points (red body = watch for collisions)
    for (cx = tog_x) switch_mock(cx);
    // printed switch guards (the STL that glues into the front recess)
    if (show_guards) color("Khaki") for (cx = tog_x) guard_mock(cx);
}

// =============================================================================
// ON-SLANT placement for the module fit-check assembly. slant_up = how far up the
// 30 deg front slant the panel BASE (local Y=0) sits (mm along the slant); the
// panel TOP is at slant_up + plate_h. Matches the lower-blank slant transform.
// =============================================================================
floor_t = 6;     // bottom-panel slab thickness (assembly reference)
// with_devices / with_backplate added 2026-08-01 so a caller can ask for the
// PANEL ALONE. Defaults are true, so every existing call behaves exactly as
// before - this is purely additive.
//
// Why it was needed: the film's shot 08 exports this panel headless, and the
// export failed with "The given mesh is not closed! Unable to convert to
// CGAL_Nef_Polyhedron" (exit 0, 23.77 MB written anyway, 285.6 s). The cause is
// devices() - it imports third-party meshes that are not watertight, and
// mp_mock_local() wraps one in an intersection(), which is what forces the CGAL
// conversion that fails. Those imports are fit-check mocks, exactly as this
// file's own DEVICES header says. A render does not need them fused into the
// panel; it can load them as separate objects, where manifoldness is irrelevant.
//
// -D cannot reach show_devices from a file that pulls this one in with use<>,
// because -D binds only the MAIN file's top-level variables. Hence parameters.
module macropad_pair_on_slant(slant_up = 0, with_devices = true, with_backplate = true) {
    translate([0, sin(slant_angle)*slant_up, floor_t + cos(slant_angle)*slant_up])
        rotate([90 - slant_angle, 0, 0]) {
            color("Gainsboro") panel();
            if (show_devices && with_devices)  devices();
            if (show_backplate && with_backplate) color("Tan") macropad_mount_board();
        }
}

// =============================================================================
// OUTPUT
// =============================================================================
if (part == "macropad_backplate") {            // old per-pad plate (kept for ref)
    color("Tan") macropad_backplate();
} else if (part == "mount_board") {            // NEW single spanning board (print this)
    color("Tan") macropad_mount_board();
} else if (part == "guard_bank") {             // 3 guards fused into one shuttle-gang part
    color("Khaki") guard_bank(3);
} else {
    color("Gainsboro") panel();
    if (show_devices) devices();
    if (show_backplate) color("Tan") macropad_mount_board();
}
