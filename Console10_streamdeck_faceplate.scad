// =============================================================================
// CONSOLE10 — Stream Deck Mini Faceplate  v0.1  (2U, proud bezel mount)
//
// For the Elgato Stream Deck Mini (6-key, integrated stand, non-removable).
//
// DESIGN: 2U flat 3 mm faceplate that bolts to the cheek SLANT inserts (same
// pattern as the display faceplate). A rounded-rectangle through-cut in the
// middle exposes the button area; the device is inserted from BEHIND and its
// outer bezel rim overlaps the cutout edge from the back — captive proud bezel
// mount, no front-face recess. Retention from the rear is TBD (snap clips or
// a back-side bracket); for now the panel is the visible/locating part only.
//
// The body protrudes 14 mm behind the panel; the integrated stand sticks out a
// further ~41 mm (58 mm total depth from face). The hardwired USB-A cable
// exits near the stand at the rear — make sure nothing behind blocks it.
//
// MEASURED (provided): face 85.2 W x 61.3 H; body depth 17 mm.
// EYEBALLED (confirm with calipers): bezel corner radius ~6 mm; button-area
// extents (set cutout_w/cutout_h to those once measured).
// =============================================================================

// ---------- module geometry the plate must mate to ----------
panel_width   = 253;      // 10" mini-rack width (top/bottom panel width)
cheek_thick   = 10;
slant_angle   = 30;
U             = 44.45;    // 1U, mm
interior_half = panel_width/2 - cheek_thick;   // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5

// ---------- flat plate ----------
n_u      = 2;             // 2U faceplate
plate_w  = 253;
plate_h  = n_u * U;       // 88.9
plate_t  = 3;             // uniform thickness (rail-mount + bezel locating face)

// ---------- the Stream Deck Mini (provided / eyeballed) ----------
sd_w        = 85.2;       // bezel face width   (MEASURED)
sd_h        = 61.3;       // bezel face height  (MEASURED)
sd_d        = 17;         // body depth (face -> back), excludes integrated stand
sd_corner_r = 6;          // bezel corner radius (eyeballed; confirm)
sd_stand_d  = 41;         // additional depth the integrated stand projects behind

// ---------- button-area cutout (proud-bezel mount) ----------
// Cutout is centered, sized to the BUTTON-EDGE-TO-BUTTON-EDGE extents so the
// buttons appear flush through the panel and the entire bezel rim is captured
// behind the panel front (~15.6 mm / ~13.3 mm rim per side — generous retention).
cutout_w    = 54;         // button-row span W (MEASURED)
cutout_h    = 34.7;       // button-row span H (MEASURED)
cutout_r    = 3;          // corner radius — matches button-block corner curvature

// ---------- CF reader (press-fit, no retention features) ----------
// CF card reader to the LEFT of the Stream Deck. Simple rectangular through-cut
// sized to the device for a friction (pressure) fit — no clips or screws.
// Print tolerance will likely make the cut a hair loose; if so, reduce
// cf_press_clr (negative makes cut TIGHTER than device).
cf_w         = 13.8;      // CF reader width  (MEASURED)
cf_h         = 65.9;      // CF reader height (MEASURED)
cf_d         = 30;        // CF reader depth (also the support-sleeve depth)
cf_press_clr = 0;         // per-side cutout clearance (0 = matches device; -0.1 = tighter)
cf_wall_t    = 2.5;       // support-sleeve wall thickness (around the device)
// Position: centered in the open space between the LEFT slant-mount column
// (x ~ -116 at the cheek inner face) and the Stream Deck bezel (x = -42.6).
// Midpoint ~ x = -79.3, vertically centered on the plate.
cf_cx        = -79;       // CF cutout center X
cf_cy        = plate_h/2; // CF cutout center Y (panel vertical center)

// ---------- SD card holder (slides into front, sits proud, full-depth sleeve) ----
// Custom holder STL ("SD card holder 1x1x3.stl" from Downloads, bounding box
// 41.5 x 41.5 x 24.54 mm). Slides into the panel cutout FROM THE FRONT and
// sits a few mm proud so it can be grabbed and pulled out. Press-fit retention;
// full-depth rectangular sleeve on the back guides the body for its entire
// length so it stays square as it slides in/out.
holder_w         = 41.5;       // holder body width  (STL bounding box X)
holder_h         = 41.5;       // holder body height (STL bounding box Y)
holder_d         = 24.54;      // holder body depth  (STL bounding box Z)
holder_press_clr = 0;          // per-side cutout clearance
holder_wall_t    = 2.5;        // support-sleeve wall thickness AND back-floor thickness
holder_proud     = 5;          // proud height when bottomed on the sleeve floor (drives sleeve cavity depth)
// Derived: sleeve total depth so holder back rests on floor with holder_proud
// sticking out front. = (insertion depth below panel back) + floor thickness.
holder_sleeve_d  = (holder_d - plate_t - holder_proud) + holder_wall_t;

// ---------- USB-C panel mount (QIANRENON rectangular, screw-mounted, proud) ----
// Aluminum flange on the front + plastic body through the panel, retained by
// 2 M3 screws. Flange WON'T be flush — it sits proud of the panel by 3.6 mm.
usbc_body_w         = 17;     // body width (passes through cutout)
usbc_body_h         = 23;     // body height (passes through cutout)
usbc_body_d         = 26.4;   // body depth behind panel (= 30 - flange)
usbc_flange_w       = 19;     // flange face width (overlaps panel)
usbc_flange_h       = 36.6;   // flange face height
usbc_flange_t       = 3.6;    // flange thickness (proud of panel front)
usbc_screw_d        = 3.2;    // M3 clearance hole diameter
usbc_screw_y_pitch  = 30;     // screw hole center-to-center (vertical)
usbc_body_clr       = 0.2;    // per-side cutout clearance for the body

// ---------- horizontal layout ----------
// Three devices left-to-right: CF, holder, SD. Each device's outer footprint
// (sleeve outer or clip outer) is separated from the next by panel_layout_gap.
// CF stays at cf_cx; holder and SD centers derive from chain math.
panel_layout_gap = 5;
holder_cx = cf_cx + (cf_w - 2*cf_press_clr)/2 + cf_wall_t + panel_layout_gap
                  + (holder_w - 2*holder_press_clr)/2 + holder_wall_t;
holder_cy = plate_h/2;

// ---------- rear retention corner clips ----------
// 4 printed-in clips on the back of the panel that snap over the body's back
// corners (just outside the body footprint in X, inset in Y from the corners
// to clear the integrated stand). The arms flex outward as the body pushes in
// from behind; the rectangular hooks at the end catch the body back face.
// Body's rounded bezel corners (sd_corner_r) act as a built-in lead-in chamfer.
clip_t       = 2.5;       // clip arm thickness (X — flex direction)
clip_w       = 8;         // clip arm width (Y)
clip_gap     = 0.3;       // gap between clip inner face and body side
hook_d       = 1.5;       // hook engagement depth (overhang past body side)
hook_h       = 1.5;       // hook height (Z)
clip_inset_y = 6;         // clip center inset from body Y corner

// ---------- slant-insert mount holes (perpendicular through the flat plate) ----
// 2U plate spans s=0..88.9 along the slant. Only U-row 0 has cheek holes that
// fit on the plate: 50.80, 66.675, 82.55. Pick the wide pair (50.80, 82.55)
// for a 31.75 mm vertical grip. Inner hole (66.675) is unused but available.
mount_y      = [50.80, 82.55];
m10_32_clear = 5.5;

show_on_slant = false;    // true = fit-check: tilt the flat stack onto the slant
show_sd       = true;     // include the mock Stream Deck in the fit-check
floor_t       = 6;        // bottom-panel slab thickness (for the fit-check placement)

$fn = 48;
// cx/cy = STREAM DECK center. Derived so SD sits just right of holder sleeve
// outer with panel_layout_gap of clearance from the SD corner-clip outer face.
cx = holder_cx + (holder_w - 2*holder_press_clr)/2 + holder_wall_t + panel_layout_gap
              + sd_w/2 + clip_gap + clip_t;
cy = plate_h/2;

// USB-C connector center. Derived so the flange's left edge sits panel_layout_gap
// to the right of the SD corner-clip outer face.
usbc_cx = cx + sd_w/2 + clip_gap + clip_t + panel_layout_gap + usbc_flange_w/2;
usbc_cy = plate_h/2;

echo(str("STREAM DECK FACEPLATE v0.8 (+USB-C panel mount) ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | CF @ x=", cf_cx,
         " | HOLDER @ x=", holder_cx, " sleeve d=", holder_sleeve_d, " proud ", holder_proud,
         " | SD @ x=", cx,
         " | USB-C @ x=", usbc_cx, " (cutout ", usbc_body_w + 2*usbc_body_clr, "x", usbc_body_h + 2*usbc_body_clr,
         ", screws Φ", usbc_screw_d, " @ y±", usbc_screw_y_pitch/2, ")"));

// =============================================================================
// ROUNDED RECTANGLE — 2D footprint helper for the button-area cutout
// =============================================================================
module rounded_rect_2d(w, h, r) {
    hull() {
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([sx*(w/2 - r), sy*(h/2 - r), 0]) circle(r);
    }
}

// =============================================================================
// CF SUPPORT SLEEVE — rectangular tube on the panel back that wraps the CF
// reader for its full depth. Inner hole matches the panel cutout exactly;
// outer wall is cf_wall_t thick on all sides. Sleeve extends from z=0 (panel
// back) rearward to z=-cf_d.
// =============================================================================
module cf_support_sleeve() {
    inner_w  = cf_w - 2*cf_press_clr;
    inner_h  = cf_h - 2*cf_press_clr;
    outer_w  = inner_w + 2*cf_wall_t;
    outer_h  = inner_h + 2*cf_wall_t;
    translate([cf_cx, cf_cy, -cf_d/2])
        difference() {
            cube([outer_w, outer_h, cf_d],     center = true);
            cube([inner_w, inner_h, cf_d + 2], center = true);
        }
}

// =============================================================================
// HOLDER SUPPORT SLEEVE — rectangular cup behind the panel guiding the SD card
// holder as it slides in/out. CLOSED at the back (floor) so the holder can't
// fall through; the floor is the bottom-out stop that leaves the holder
// sitting holder_proud mm in front of the panel face.
// =============================================================================
module holder_support_sleeve() {
    inner_w   = holder_w - 2*holder_press_clr;
    inner_h   = holder_h - 2*holder_press_clr;
    outer_w   = inner_w + 2*holder_wall_t;
    outer_h   = inner_h + 2*holder_wall_t;
    cavity_d  = holder_sleeve_d - holder_wall_t;   // inner cavity depth (floor below it)

    difference() {
        // Outer block: world z = [-holder_sleeve_d, 0]
        translate([holder_cx - outer_w/2, holder_cy - outer_h/2, -holder_sleeve_d])
            cube([outer_w, outer_h, holder_sleeve_d]);
        // Inner cavity: open at +z (toward panel), closed at -z (floor below)
        translate([holder_cx - inner_w/2, holder_cy - inner_h/2, -cavity_d])
            cube([inner_w, inner_h, cavity_d + 1]);
    }
}

// =============================================================================
// CORNER CLIP — one per body corner. Arm runs from the panel back (z=0)
// rearward along the OUTSIDE of the body's +/-X side; rectangular hook at the
// far end catches the body's back face from outside. Body's rounded bezel
// corner doubles as the insertion lead-in.
// =============================================================================
module corner_clip_pos_x(dy) {
    arm_inner_x = sd_w/2 + clip_gap;                  // arm face nearest body
    arm_y_min   = cy + dy * (sd_h/2 - clip_inset_y) - clip_w/2;

    // arm column: from panel back (z=0) rearward to bottom of hook
    translate([arm_inner_x, arm_y_min, -(sd_d + hook_h)])
        cube([clip_t, clip_w, sd_d + hook_h]);

    // hook: rectangular catch at the far end, extending inward by hook_d
    translate([arm_inner_x - hook_d, arm_y_min, -(sd_d + hook_h)])
        cube([hook_d + clip_t, clip_w, hook_h]);
}
module corner_clip(dx, dy) {
    // Build clip in body-local frame, then translate to the SD center X
    translate([cx, 0, 0])
        if (dx > 0) corner_clip_pos_x(dy);
        else        mirror([1, 0, 0]) corner_clip_pos_x(dy);
}

// =============================================================================
// PANEL — flat 2U 3 mm slab, centered button-area through-cut with rounded
// corners, slant-insert mount holes, and 4 rear corner retention clips.
// Front face at Z=plate_t, back at Z=0.
// =============================================================================
module panel() {
    union() {
        difference() {
            translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);

            // --- button-area cutout (rounded rectangle, full through) ---
            translate([cx, cy, plate_t/2])
                linear_extrude(plate_t + 2, center = true)
                    rounded_rect_2d(cutout_w, cutout_h, cutout_r);

            // --- CF reader press-fit cutout (sharp rectangle, full through) ---
            translate([cf_cx, cf_cy, plate_t/2])
                cube([cf_w - 2*cf_press_clr, cf_h - 2*cf_press_clr, plate_t + 2], center = true);

            // --- SD card holder press-fit cutout (sharp rectangle, full through) ---
            translate([holder_cx, holder_cy, plate_t/2])
                cube([holder_w - 2*holder_press_clr, holder_h - 2*holder_press_clr, plate_t + 2], center = true);

            // --- USB-C panel-mount connector: body cutout + 2 M3 screw holes ---
            translate([usbc_cx, usbc_cy, plate_t/2])
                cube([usbc_body_w + 2*usbc_body_clr, usbc_body_h + 2*usbc_body_clr, plate_t + 2], center = true);
            for (dy = [-1, 1])
                translate([usbc_cx, usbc_cy + dy*usbc_screw_y_pitch/2, -1])
                    cylinder(d = usbc_screw_d, h = plate_t + 2);

            // --- slant-insert mount screws — 2 per side, straight through ---
            for (sx = [-cheek_ctr_x, cheek_ctr_x])
                for (y = mount_y)
                    translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);
        }

        // --- 4 rear corner retention clips (Stream Deck) ---
        for (dx = [-1, 1])
            for (dy = [-1, 1])
                corner_clip(dx, dy);

        // --- CF reader full-depth support sleeve ---
        cf_support_sleeve();

        // --- SD card holder full-depth support sleeve ---
        holder_support_sleeve();
    }
}

// =============================================================================
// MOCK STREAM DECK — fit-check only (not printed). Body block from BEHIND the
// panel's back face (z=0) going back by sd_d, with the bezel face represented
// just behind the panel front for visual reference. A simplified rear stand
// stub shows where the 41 mm rear protrusion lives.
// =============================================================================
module sd_mock() {
    // Body: rounded-corner block, behind the panel.
    // Top face of body sits AT the panel back (z=0); body extends back to z=-sd_d.
    color("DimGray")
        translate([cx, cy, -sd_d/2])
            linear_extrude(sd_d, center = true)
                rounded_rect_2d(sd_w, sd_h, sd_corner_r);

    // Active button area (visual): a thin glossy slab nudged 0.15 mm below the
    // panel front so it doesn't z-fight with the cutout plane.
    color("RoyalBlue")
        translate([cx, cy, plate_t - 0.55])
            linear_extrude(0.8, center = true)
                rounded_rect_2d(cutout_w - 1, cutout_h - 1, max(cutout_r - 0.5, 0.1));

    // Integrated stand — generic stub centered on the back, smaller footprint.
    color("DarkSlateGray")
        translate([cx, cy, -sd_d - sd_stand_d/2])
            linear_extrude(sd_stand_d, center = true)
                rounded_rect_2d(sd_w * 0.5, sd_h * 0.5, 4);

    // CF reader body — protrudes behind the panel by cf_d, press-fit in cutout.
    color("SlateGray")
        translate([cf_cx, cf_cy, -cf_d/2])
            cube([cf_w, cf_h, cf_d], center = true);

    // SD card holder body — sits proud by holder_proud in front, rest goes
    // into the support sleeve behind. Body Z range: [plate_t + holder_proud - holder_d, plate_t + holder_proud]
    color("Goldenrod")
        translate([holder_cx, holder_cy, plate_t + holder_proud - holder_d/2])
            cube([holder_w, holder_h, holder_d], center = true);

    // USB-C panel-mount connector: aluminum flange proud of panel + plastic body behind.
    color("Silver")
        translate([usbc_cx, usbc_cy, plate_t + usbc_flange_t/2])
            cube([usbc_flange_w, usbc_flange_h, usbc_flange_t], center = true);
    color("DimGray")
        translate([usbc_cx, usbc_cy, -usbc_body_d/2])
            cube([usbc_body_w, usbc_body_h, usbc_body_d], center = true);
}

// =============================================================================
// STACK — panel + (optional) mock device, in the local flat frame.
// =============================================================================
module sd_stack() {
    color("Gainsboro") panel();
    if (show_sd) sd_mock();
}

// Fit-check: lay the flat stack onto the 30 deg slant in the module frame.
module sd_on_slant() {
    translate([0, 0, floor_t])
        rotate([90 - slant_angle, 0, 0])
            sd_stack();
}

// Public entry the module assembly calls:
module streamdeck_faceplate_on_slant() { sd_on_slant(); }

if (show_on_slant) sd_on_slant();
else               sd_stack();
