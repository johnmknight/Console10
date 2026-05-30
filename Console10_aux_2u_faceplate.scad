// =============================================================================
// CONSOLE10 — Aux Faceplate  v0.1  (2U: CF reader + SD holder + USB-C)
//
// Regular 2U flat 3 mm faceplate that bolts to the cheek SLANT inserts.
// Hosts three devices left-to-right: CF reader, SD-card holder, USB-C panel
// mount.
//
// Split off from the 3U LCD-hole faceplate on 2026-05-30. See
// `Console10_interface_specs.md` for the canonical device dimensions.
// =============================================================================

// ---------- module geometry the plate must mate to ----------
panel_width   = 253;
cheek_thick   = 10;
slant_angle   = 30;
U             = 44.45;
interior_half = panel_width/2 - cheek_thick;   // 116.5
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5

// ---------- flat plate ----------
n_u      = 2;             // 2U faceplate
plate_w  = 253;
plate_h  = n_u * U;       // 88.9
plate_t  = 3;

// ---------- CF reader (press-fit, full-depth open sleeve) ----------
cf_w         = 13.8;
cf_h         = 65.9;
cf_d         = 30;
cf_press_clr = 0;
cf_wall_t    = 2.5;
cf_cx        = -99.25;     // shifted left so 3 holders + USB-C fit symmetrically
cf_cy        = plate_h/2;

// ---------- SD card holder (press-fit, closed-back sleeve, sits proud) ----
holder_w         = 41.5;
holder_h         = 41.5;
holder_d         = 24.54;
holder_press_clr = 0;
holder_wall_t    = 2.5;
holder_proud     = 5;
holder_sleeve_extra_d = 6;
holder_sleeve_d  = (holder_d - plate_t - holder_proud) + holder_wall_t + holder_sleeve_extra_d;

// ---------- USB-C panel mount (QIANRENON rectangular, screw-mounted, proud) ----
usbc_body_w         = 17;
usbc_body_h         = 23;
usbc_body_d         = 26.4;
usbc_flange_w       = 19;
usbc_flange_h       = 36.6;
usbc_flange_t       = 3.6;
usbc_screw_d        = 3.2;
usbc_screw_y_pitch  = 30;
usbc_body_clr       = 0.2;

// ---------- horizontal layout ----------
// Devices left-to-right: CF, holder1, holder2, holder3, USB-C. 3 holders
// grouped consecutively; USB-C anchors the far right. Each device's outer
// footprint separated from the next by panel_layout_gap. Layout symmetric
// around X=0 (cf_cx chosen to balance).
panel_layout_gap = 10;
holder_cy = plate_h/2;

// Half-widths used in chain math
_cf_half     = (cf_w - 2*cf_press_clr)/2 + cf_wall_t;            //  9.4
_holder_half = (holder_w - 2*holder_press_clr)/2 + holder_wall_t; // 23.25

holder1_cx = cf_cx + _cf_half + panel_layout_gap + _holder_half;
holder2_cx = holder1_cx + 2*_holder_half + panel_layout_gap;
holder3_cx = holder2_cx + 2*_holder_half + panel_layout_gap;
usbc_cx    = holder3_cx + _holder_half + panel_layout_gap + usbc_flange_w/2;
usbc_cy    = plate_h/2;

// All holder X centers (loop over this in panel/mocks)
holder_cxs = [holder1_cx, holder2_cx, holder3_cx];

// ---------- slant-insert mount holes ----------
// 2U plate: only U0-row cheek holes fit (50.80, 66.675, 82.55).
// Wide pair = 50.80 + 82.55 → 31.75 mm vertical grip.
mount_y      = [50.80, 82.55];
m10_32_clear = 5.5;

show_on_slant = false;
show_devices  = true;
floor_t       = 6;

$fn = 48;

echo(str("AUX FACEPLATE v0.2 (2U: CF + 3 holders + USB-C) ", plate_w, " x ", plate_h, " (", n_u, "U) t", plate_t,
         " | CF @ x=", cf_cx,
         " | HOLDERS @ x=", holder_cxs, " (sleeve d=", holder_sleeve_d, " proud ", holder_proud, ")",
         " | USB-C @ x=", usbc_cx, " (cutout ", usbc_body_w + 2*usbc_body_clr, "x", usbc_body_h + 2*usbc_body_clr,
         ", screws Φ", usbc_screw_d, " @ y±", usbc_screw_y_pitch/2, ")"));

// =============================================================================
// CF SUPPORT SLEEVE — open both ends, wraps the CF reader full depth.
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
// HOLDER SUPPORT SLEEVE — closed back (floor is the bottom-out stop).
// Takes a cx parameter so multiple holders can share the same module.
// =============================================================================
module holder_support_sleeve(cx) {
    inner_w   = holder_w - 2*holder_press_clr;
    inner_h   = holder_h - 2*holder_press_clr;
    outer_w   = inner_w + 2*holder_wall_t;
    outer_h   = inner_h + 2*holder_wall_t;
    cavity_d  = holder_sleeve_d - holder_wall_t;

    difference() {
        translate([cx - outer_w/2, holder_cy - outer_h/2, -holder_sleeve_d])
            cube([outer_w, outer_h, holder_sleeve_d]);
        translate([cx - inner_w/2, holder_cy - inner_h/2, -cavity_d])
            cube([inner_w, inner_h, cavity_d + 1]);
    }
}

// =============================================================================
// PANEL — flat 2U 3 mm slab + cutouts + rear sleeves.
// =============================================================================
module panel() {
    union() {
        difference() {
            translate([-plate_w/2, 0, 0]) cube([plate_w, plate_h, plate_t]);

            // CF reader press-fit cutout
            translate([cf_cx, cf_cy, plate_t/2])
                cube([cf_w - 2*cf_press_clr, cf_h - 2*cf_press_clr, plate_t + 2], center = true);

            // 3 SD card holder press-fit cutouts
            for (cx = holder_cxs)
                translate([cx, holder_cy, plate_t/2])
                    cube([holder_w - 2*holder_press_clr, holder_h - 2*holder_press_clr, plate_t + 2], center = true);

            // USB-C panel-mount: body cutout + 2 M3 screw holes
            translate([usbc_cx, usbc_cy, plate_t/2])
                cube([usbc_body_w + 2*usbc_body_clr, usbc_body_h + 2*usbc_body_clr, plate_t + 2], center = true);
            for (dy = [-1, 1])
                translate([usbc_cx, usbc_cy + dy*usbc_screw_y_pitch/2, -1])
                    cylinder(d = usbc_screw_d, h = plate_t + 2);

            // Slant-insert mount screws — 2 per side
            for (sx = [-cheek_ctr_x, cheek_ctr_x])
                for (y = mount_y)
                    translate([sx, y, -1]) cylinder(d = m10_32_clear, h = plate_t + 2);
        }

        cf_support_sleeve();
        for (cx = holder_cxs) holder_support_sleeve(cx);
    }
}

// =============================================================================
// MOCKS — fit-check only.
// =============================================================================
module device_mocks() {
    color("SlateGray")
        translate([cf_cx, cf_cy, -cf_d/2])
            cube([cf_w, cf_h, cf_d], center = true);

    for (cx = holder_cxs)
        color("Goldenrod")
            translate([cx, holder_cy, plate_t + holder_proud - holder_d/2])
                cube([holder_w, holder_h, holder_d], center = true);

    color("Silver")
        difference() {
            translate([usbc_cx, usbc_cy, plate_t + usbc_flange_t/2])
                cube([usbc_flange_w, usbc_flange_h, usbc_flange_t], center = true);
            for (dy = [-1, 1])
                translate([usbc_cx, usbc_cy + dy*usbc_screw_y_pitch/2, plate_t - 1])
                    cylinder(d = usbc_screw_d, h = usbc_flange_t + 2);
        }
    color("DimGray")
        translate([usbc_cx, usbc_cy, -usbc_body_d/2])
            cube([usbc_body_w, usbc_body_h, usbc_body_d], center = true);
}

module aux_stack() {
    color("Gainsboro") panel();
    if (show_devices) device_mocks();
}

module aux_on_slant() {
    translate([0, 0, floor_t])
        rotate([90 - slant_angle, 0, 0])
            aux_stack();
}

// Public entry the module assembly calls:
module aux_2u_faceplate_on_slant() { aux_on_slant(); }

if (show_on_slant) aux_on_slant();
else               aux_stack();
