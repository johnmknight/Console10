// =============================================================================
// DESIGN NOTES — Elgato Stream Deck Mini, Proud-Bezel Mount with Rear Clips
//
// Extracted from Console10_streamdeck_faceplate.scad after physical print test
// passed (2026-05-30). Captured here as a reusable snippet for future panels.
// This file is NOT included in any build by default — `include<>` it explicitly
// if you want the Stream Deck back on a new panel.
//
// DEVICE: Elgato Stream Deck Mini (6-key, integrated stand, non-removable).
//   - Bezel face 85.2 W × 61.3 H mm (MEASURED)
//   - Body depth (face -> back, excludes stand) 17 mm (MEASURED)
//   - Integrated rear stand: ~41 mm additional depth (58 mm total)
//   - Hardwired USB-A cable, exits the rear near the stand
//
// MOUNT STRATEGY: PROUD BEZEL
//   The cutout is sized to the BUTTON-ROW span (54 × 34.7 mm MEASURED), NOT
//   the full bezel. The bezel rim (~15.6 mm / ~13.3 mm per side) is captured
//   behind the panel front from the back — the device inserts from the rear,
//   the bezel can't pull through forward. Rear clips snap over the body's
//   back corners to keep it from pushing inward.
//
// FINAL PRINTED-AND-TESTED CUTOUT (after iteration):
//   Real button-row dims: 54 × 34.7 mm (locked, don't change)
//   Per-side clearance:   1.0 mm  (cutout grew from 0 → 0.5 → 1.0 in testing)
//   Cutout dims:          56 × 36.7 mm  (sd_button_w_real + 2*1, etc.)
//   Corner radius:        3 mm  (matches button-block corner curvature)
//
// REAR RETENTION CLIPS:
//   4× printed-in clips on the panel back, one per body corner. Arms flex
//   outward as the body inserts from behind; rectangular hooks at the far
//   end catch the body back face. The body's rounded bezel corners act as
//   the insertion lead-in (no separate chamfer needed). Clip Y inset 6 mm
//   from body corner to clear the integrated stand stub.
//
// PARAMETERS BELOW are copy-paste-ready into a future panel. Position the SD
// on the panel via your own cx, cy (Stream Deck center), then call the cutout
// and corner_clip blocks shown in the EXAMPLE USAGE section at the bottom.
// =============================================================================

// ---------- the Stream Deck Mini (MEASURED) ----------
sd_w        = 85.2;       // bezel face width
sd_h        = 61.3;       // bezel face height
sd_d        = 17;         // body depth (face -> back), excludes integrated stand
sd_corner_r = 6;          // bezel corner radius (eyeballed)
sd_stand_d  = 41;         // additional depth the integrated stand projects behind

// ---------- button-area cutout (proud-bezel mount) ----------
sd_button_w_real = 54;    // button-row span W (MEASURED — DO NOT CHANGE)
sd_button_h_real = 34.7;  // button-row span H (MEASURED — DO NOT CHANGE)
cutout_extra     = 1.0;   // per-side clearance (locked at 1.0 after print test)
cutout_w    = sd_button_w_real + 2*cutout_extra;
cutout_h    = sd_button_h_real + 2*cutout_extra;
cutout_r    = 3;          // matches button-block corner curvature

// ---------- rear retention corner clips ----------
clip_t       = 2.5;       // clip arm thickness (X — flex direction)
clip_w       = 8;         // clip arm width (Y)
clip_gap     = 0.3;       // gap between clip inner face and body side
hook_d       = 1.5;       // hook engagement depth (overhang past body side)
hook_h       = 1.5;       // hook height (Z)
clip_inset_y = 6;         // clip center inset from body Y corner

// ---------- 2D rounded rectangle helper (for the cutout) ----------
module sd_rounded_rect_2d(w, h, r) {
    hull() {
        for (sx = [-1, 1])
            for (sy = [-1, 1])
                translate([sx*(w/2 - r), sy*(h/2 - r), 0]) circle(r);
    }
}

// ---------- CORNER CLIP — one per body corner ----------
// Arm runs from the panel back (z=0) rearward along the OUTSIDE of the body's
// +/-X side; rectangular hook at the far end catches the body's back face.
// `cy` here is the panel-Y of the Stream Deck center; pass it in or use a
// global. The body's rounded bezel corner doubles as the insertion lead-in.
module sd_corner_clip_pos_x(dy, cy) {
    arm_inner_x = sd_w/2 + clip_gap;
    arm_y_min   = cy + dy * (sd_h/2 - clip_inset_y) - clip_w/2;
    translate([arm_inner_x, arm_y_min, -(sd_d + hook_h)])
        cube([clip_t, clip_w, sd_d + hook_h]);
    translate([arm_inner_x - hook_d, arm_y_min, -(sd_d + hook_h)])
        cube([hook_d + clip_t, clip_w, hook_h]);
}
module sd_corner_clip(dx, dy, sd_cx, sd_cy) {
    translate([sd_cx, 0, 0])
        if (dx > 0) sd_corner_clip_pos_x(dy, sd_cy);
        else        mirror([1, 0, 0]) sd_corner_clip_pos_x(dy, sd_cy);
}

// =============================================================================
// EXAMPLE USAGE (copy into a panel's panel() module):
//
//   // INSIDE the panel's difference() — the button-area cutout:
//   translate([sd_cx, sd_cy, plate_t/2])
//       linear_extrude(plate_t + 2, center = true)
//           sd_rounded_rect_2d(cutout_w, cutout_h, cutout_r);
//
//   // INSIDE the panel's union() (after the slab/cuts) — the 4 corner clips:
//   for (dx = [-1, 1])
//       for (dy = [-1, 1])
//           sd_corner_clip(dx, dy, sd_cx, sd_cy);
//
// PANEL-LAYOUT CHAIN MATH (Stream Deck horizontal envelope, useful for
// chaining adjacent devices left/right of the SD):
//   left edge of SD's clip outer face:  sd_cx - (sd_w/2 + clip_gap + clip_t)
//   right edge of SD's clip outer face: sd_cx + (sd_w/2 + clip_gap + clip_t)
// =============================================================================

// ---------- mock (for fit-check renders; safe to drop in a sd_mock() module) ----
// Body, button-area visual, and integrated stand. Pass sd_cx, sd_cy, plate_t.
module sd_body_mock(sd_cx, sd_cy, plate_t) {
    color("DimGray")
        translate([sd_cx, sd_cy, -sd_d/2])
            linear_extrude(sd_d, center = true)
                sd_rounded_rect_2d(sd_w, sd_h, sd_corner_r);
    color("RoyalBlue")
        translate([sd_cx, sd_cy, plate_t - 0.55])
            linear_extrude(0.8, center = true)
                sd_rounded_rect_2d(sd_button_w_real, sd_button_h_real, max(cutout_r - 0.5, 0.1));
    color("DarkSlateGray")
        translate([sd_cx, sd_cy, -sd_d - sd_stand_d/2])
            linear_extrude(sd_stand_d, center = true)
                sd_rounded_rect_2d(sd_w * 0.5, sd_h * 0.5, 4);
}
