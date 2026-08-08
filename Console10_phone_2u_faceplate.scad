// =============================================================================
// CONSOLE10 — Phone Dock Faceplate  v0.2  (2U: Pixel 10 Pro XL, landscape)
//
// Minimal 2U flat 3 mm faceplate for the cheek SLANT inserts. The cased
// phone drops into a recessed pocket (screen out, landscape); a charger
// puck sits in a boss behind the floor with its face flush, so the phone
// back rests directly on it (magnetic hold). Fits the phone with or
// without its case (bare phone just sits deeper and looser).
//
// v0.2 (2026-08-08): finger notch REMOVED; sci-fi pull-down eject lever
// added (airlock-panel style). Lever on the right wing rides an M3 axle in
// two lugs behind the plate; its crank pin drives a slotted boss on an
// ejector that routes under the tub end wall to a plate behind the RIGHT
// relief window. 90 deg throw = 7.62 mm plate travel: 2.62 dead (parked
// recess so the camera bump clears — phone stays reversible) + 5 mm push
// off the puck magnets. Pushing the lever back up retracts the plate.
// Print parts: part="panel" / "lever" / "ejector". Pose: LEVER_ANGLE 0..90.
// Hardware: M3 x 35 + nyloc through the lugs.
//
// Phone dims measured by John 2026-08-08 (current case ON).
// Puck dims from PixelTabletFrame charger_puck.scad (measured).
// Plate/mount conventions copied from Console10_aux_2u_faceplate.scad.
//
// [TODO-verify] cam_end_relief_w: camera-bar offset from the phone end was
// not measured — both floor ends are relieved 36 mm so the bump floats
// either way in. Confirm the bar sits within 36 mm of the end (with case).
// [TODO v0.3] puck retention is friction-ring only; add snap nubs if loose.
// [TODO v0.3] lever detent/latch at the locked position (magnet or bump).
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

// ---------- phone (Pixel 10 Pro XL, cased, measured 2026-08-08) ----------
ph_w      = 169;      // [M] landscape width (with case)
ph_h      = 81;       // [M] landscape height, case body
ph_h_btn  = 81.6;     // [M] landscape height at the buttons
ph_t      = 11.4;     // [M] thickness
ph_t_cam  = 13.62;    // [M] thickness at the camera bump
cam_w     = 26.4;     // [M] camera bump band width
ph_clr    = 0.5;      // pocket clearance per side

// ---------- pocket / tub ----------
pk_w      = ph_w + 2*ph_clr;      // 170
pk_h      = ph_h_btn + 2*ph_clr;  // 82.6 (buttons govern)
pk_d      = ph_t + 1.0;           // 12.4 floor depth — cased face 1.0 sub-flush
wall_t    = 2.5;                  // tub wall
floor_t   = 3;                    // tub floor slab
cam_end_relief_w = 36;            // [TODO-verify] open floor window at EACH end

// ---------- charger puck (PixelTabletFrame charger_puck.scad, [M]) ----------
puck_d    = 60.1;     // [M] diameter
puck_h    = 8.9;      // [M] thickness
puck_clr  = 0.25;     // radial fit in the boss (friction)
boss_wall = 2.5;
cable_w   = 12;       // cable slot through the boss, exits downward

// ---------- eject mechanism (v0.2) ----------
// Sci-fi pull-down lever on the right wing -> bell-crank behind the panel ->
// ejector plate behind the RIGHT relief window pushes the phone back off the
// puck magnets. Plate parks plate_face_rec BELOW the floor plane so the
// camera bump can still sit over the right window (phone stays reversible);
// the crank throw covers that dead travel plus eject_out of real push.
LEVER_ANGLE = 0;      // pose: 0 = locked (handle up), 90 = pulled (ejected)
eject_out      = 5;                    // push proud of the floor at full throw
plate_face_rec = ph_t_cam - ph_t + 0.4;  // 2.62 parked recess (camera clears)
travel   = eject_out + plate_face_rec;   // 7.62 total plate travel
crank_R  = travel;    // 90 deg throw: travel = R*(1-cos90) = R
pin_d    = 5;
lev_x    = 100;       // lever centreline x (right wing)
arm_t    = 8;         // lever arm thickness along x
arm_w    = 10;        // lever arm width (radial face)
handle_R = 37;        // axle -> grip bar centre: at the parked/pulled 45 deg
                      // positions the knob skims ~1.5 mm over the plate face
                      // (bar underside ~3 mm)
grip_d   = 12;
grip_len = 26;        // L-handle: bar reaches RIGHT (outboard) from the arm so
                      // it never overhangs the phone; knob stays inside the
                      // panel edge (bar 96..122, knob to 125 < 126.5)
hub_d    = 14;
lug_t    = 5;         // axle pillow lugs
axle_d   = 3.4;       // M3 clearance
stem_t   = 3;         // ejector stem (routes UNDER the tub end wall)
stem_w   = 12;
plate_clr = 0.5;      // ejector plate fit in the window, per side

// ---------- slant-insert mount holes ----------
// Widest pair the EIA rows allow: 6.35 (lowest usable) + 82.55 = 76.2 mm grip.
// NOTE: local 6.35 only lands on a cheek hole when the panel base sits at
// s >= 44.45 (above the front gap) — true at the s=133.35 mount; a base-of-
// slant mount (s=0) would need the aux-style [50.80, 82.55] pair instead.
mount_y      = [6.35, 82.55];
m10_32_clear = 5.5;

show_phone = true;    // GUI mocks
show_puck  = true;

$fn = 96;
eps = 0.01;

yc = plate_h/2;                       // pocket / puck centreline
pk_hole_d  = puck_d + 2*puck_clr;     // 60.6
boss_od    = pk_hole_d + 2*boss_wall; // 65.6
boss_depth = puck_h + 0.5;            // puck face flush with floor top
floor_span = pk_w - 2*cam_end_relief_w; // central supported floor width

// ---- derived mechanism geometry ----
wall_bot_z = -(pk_d + floor_t);            // -15.4 tub wall/floor bottom
win_x0     = pk_w/2 - cam_end_relief_w;    // 49  right window left edge
win_x1     = pk_w/2;                       // 85  right window right edge
ep_face0   = -pk_d - plate_face_rec;       // parked ejector face z
stem_top0  = wall_bot_z - travel - 0.5;    // parked stem top (clears wall at full throw)
pin_z0     = stem_top0 - stem_t/2;         // parked crank-pin centre
axle_z     = pin_z0 + crank_R;             // axle depth behind the panel
axle_y     = yc;
lever_dz   = crank_R * (1 - cos(LEVER_ANGLE));   // posed plate displacement
// lever slot in the plate: arm sweeps +/-45 deg about straight-out
slot_hy    = (0 - axle_z) * tan(45) + arm_w/2 + 1.5;
slot_hx    = arm_t/2 + 1;
// along-axle layout (x): lug | arm hub | crank disc | pin -> stem boss | lug
arm_x0   = lev_x - arm_t/2;     // 96
crank_x0 = arm_x0 + arm_t;      // 104, disc 5 thick
pin_x0   = crank_x0 + 5;        // 109, pin reaches through the stem boss
boss_x0  = pin_x0 + 0.5;        // 109.5, boss 7 thick
lug_x    = [arm_x0 - 2 - lug_t, boss_x0 + 7 + 1.5];   // 89, 118

echo(str("PHONE FACEPLATE v0.1 (2U Pixel 10 Pro XL) ", plate_w, " x ", plate_h,
         " t", plate_t,
         " | pocket ", pk_w, " x ", pk_h, " x ", pk_d, " deep",
         " | floor span ", floor_span, " (", cam_end_relief_w, " relieved each end)",
         " | puck bore D", pk_hole_d, " boss OD", boss_od,
         " | rear stickout ", pk_d + floor_t + (boss_depth - floor_t)));

// =============================================================================
// PARTS
// =============================================================================

// flat plate with pocket cutout, lever slot, mount holes
module plate() {
    difference() {
        translate([-plate_w/2, 0, -plate_t]) cube([plate_w, plate_h, plate_t]);
        pocket_cut();
        lever_slot_cut();
        for (sx = [-1, 1], my = mount_y)
            translate([sx*cheek_ctr_x, my, -plate_t - eps])
                cylinder(d = m10_32_clear, h = plate_t + 2*eps);
    }
}

// lever arm track through the plate (rounded ends, photo-style)
module lever_slot_cut() {
    hull() for (sy = [-1, 1])
        translate([lev_x, axle_y + sy*(slot_hy - slot_hx), -plate_t - eps])
            cylinder(r = slot_hx, h = plate_t + 2*eps);
}

// tub: perimeter walls + central floor slab behind the plate
module tub() {
    difference() {
        // walls: pocket ring, plate back down to floor bottom
        translate([-pk_w/2 - wall_t, yc - pk_h/2 - wall_t, -(pk_d + floor_t)])
            cube([pk_w + 2*wall_t, pk_h + 2*wall_t, pk_d + floor_t - plate_t + eps]);
        pocket_cut();
        // end windows: full pocket height, through everything (camera relief)
        for (sx = [-1, 1])
            translate([sx*(pk_w/2 - cam_end_relief_w/2) - cam_end_relief_w/2,
                       yc - pk_h/2, -(pk_d + floor_t) - eps])
                cube([cam_end_relief_w, pk_h, floor_t + 2*eps]);
        // puck bore through the floor
        translate([0, yc, -(pk_d + floor_t) - eps])
            cylinder(d = pk_hole_d, h = floor_t + 2*eps);
    }
    puck_boss();
}

// friction ring behind the floor holding the puck, cable slot down
module puck_boss() {
    translate([0, yc, 0]) difference() {
        translate([0, 0, -(pk_d + boss_depth)])
            cylinder(d = boss_od, h = boss_depth - eps);
        translate([0, 0, -(pk_d + boss_depth) - eps])
            cylinder(d = pk_hole_d, h = boss_depth + 2*eps);
        // cable slot: bottom of the ring, full depth
        translate([-cable_w/2, -boss_od/2 - eps, -(pk_d + boss_depth) - eps])
            cube([cable_w, boss_od/2, boss_depth + 2*eps]);
    }
}

// pocket void: phone cavity through plate down to floor top
module pocket_cut() {
    translate([-pk_w/2, yc - pk_h/2, -pk_d])
        cube([pk_w, pk_h, pk_d + eps]);
}

// =============================================================================
// EJECT MECHANISM
// =============================================================================

// axle pillow lugs hanging from the plate back (part of the panel print)
module axle_lugs() {
    for (x0 = lug_x) difference() {
        hull() {
            translate([x0, axle_y - 8, -plate_t]) cube([lug_t, 16, eps]);
            translate([x0, axle_y, axle_z])
                rotate([0, 90, 0]) cylinder(d = 16, h = lug_t);
        }
        translate([x0 - eps, axle_y, axle_z])
            rotate([0, 90, 0]) cylinder(d = axle_d, h = lug_t + 2*eps);
    }
}

// moving lever: hub + arm + grip bar + crank disc + pin. Modelled with the
// arm pointing straight out (+z); posed by rotating (a-45) about the axle,
// so a=0 parks the handle 45 deg up and a=90 lays it 45 deg down.
module lever(a = LEVER_ANGLE) {
    translate([0, axle_y, axle_z]) rotate([a - 45, 0, 0]) difference() {
        union() {
            // hub spanning arm + crank zone
            translate([arm_x0 - 1.5, 0, 0])
                rotate([0, 90, 0]) cylinder(d = hub_d, h = arm_t + 5 + 3);
            // arm out through the plate slot
            translate([arm_x0, -arm_w/2, 0]) cube([arm_t, arm_w, handle_R]);
            // grip bar (L-shape: reaches RIGHT/outboard from the arm, clear
            // of the phone), knurled knob on the free end
            translate([lev_x - arm_t/2, 0, handle_R])
                rotate([0, 90, 0]) cylinder(d = grip_d, h = grip_len);
            translate([lev_x - arm_t/2 + grip_len - 3, 0, handle_R])
                rotate([0, 90, 0]) cylinder(d = grip_d + 3, h = 6, $fn = 14);
            // crank disc + drive pin (pre-rotated +45 so it points straight
            // behind (-z) at a=0)
            rotate([45, 0, 0]) {
                translate([crank_x0, 0, 0])
                    rotate([0, 90, 0]) cylinder(d = hub_d, h = 5);
                translate([pin_x0 - eps, 0, -crank_R])
                    rotate([0, 90, 0]) cylinder(d = pin_d, h = 7.5 + 1 + eps);
            }
        }
        // axle bore through hub + crank
        translate([lug_x[0] - 5, 0, 0])
            rotate([0, 90, 0]) cylinder(d = axle_d, h = 50);
    }
}

// ejector: plate in the right window + riser + stem under the end wall +
// slotted boss the crank pin drives. dz = posed forward displacement.
module ejector(dz = lever_dz) {
    translate([0, 0, dz]) {
        // plate (face parked plate_face_rec below the floor plane)
        translate([win_x0 + plate_clr, yc - pk_h/2 + plate_clr, ep_face0 - 3])
            cube([win_x1 - win_x0 - 2*plate_clr, pk_h - 2*plate_clr, 3]);
        // riser down to stem level (inside the window span)
        translate([win_x1 - 8, yc - stem_w/2, stem_top0 - eps])
            cube([7.5, stem_w, (ep_face0 - 3) - stem_top0 + 2*eps]);
        // stem out under the tub end wall to the boss
        translate([win_x1 - 8, yc - stem_w/2, stem_top0 - stem_t])
            cube([(boss_x0 + 7) - (win_x1 - 8), stem_w, stem_t]);
        // slotted boss: pin close-fit in z (drive), free in +y (arc rise)
        difference() {
            translate([boss_x0, yc - stem_w/2, pin_z0 - 4.7])
                cube([7, stem_w, 9.4]);
            hull() for (dy = [0, crank_R])
                translate([boss_x0 - eps, yc + dy, pin_z0])
                    rotate([0, 90, 0]) cylinder(d = pin_d + 0.6, h = 7 + 2*eps);
        }
    }
}

// =============================================================================
// MOCKS (GUI only)
// =============================================================================
module phone_mock() {
    color("dimgray", 0.5)
        translate([-ph_w/2, yc - ph_h/2, -pk_d])
            cube([ph_w, ph_h, ph_t]);
    // camera band shown at the LEFT end, mid of the relief window
    color("black", 0.5)
        translate([-pk_w/2 + (cam_end_relief_w - cam_w)/2, yc - ph_h/2,
                   -pk_d - (ph_t_cam - ph_t)])
            cube([cam_w, ph_h, ph_t_cam - ph_t]);
}

module puck_mock() {
    color("seagreen", 0.6)
        translate([0, yc, -pk_d - puck_h]) cylinder(d = puck_d, h = puck_h);
}

// =============================================================================
// ASSEMBLY ENTRIES
// =============================================================================
// Local frame matches the other faceplates for on-slant use: plate back on
// z=0 (slant plane), face at +plate_t, base edge at local Y=0. The part is
// modelled face-at-z=0, so the stack shifts it up by plate_t.
asm_floor_t = 6;     // bottom-panel slab thickness (assembly reference)

module phone_stack(with_devices = true) {
    translate([0, 0, plate_t]) {
        color("Gainsboro") { plate(); tub(); axle_lugs(); }
        color("DimGray")   lever();
        color("Firebrick") ejector();
        if (with_devices) {
            if (show_phone) phone_mock();
            if (show_puck)  puck_mock();
        }
    }
}

// slant_up = mm up the 30 deg slant where the panel BASE (local Y=0) sits.
// with_devices as a parameter because -D cannot reach this file's top-level
// flags through use<> (same reason as the macropad panel).
module phone_2u_faceplate_on_slant(slant_up = 0, with_devices = true) {
    translate([0, sin(slant_angle)*slant_up, asm_floor_t + cos(slant_angle)*slant_up])
        rotate([90 - slant_angle, 0, 0])
            phone_stack(with_devices);
}

// =============================================================================
// EXPORT SELECTOR
// =============================================================================
part = "assembly";   // "assembly" | "panel" | "lever" | "ejector"
show_on_slant = false;

if (show_on_slant)          phone_2u_faceplate_on_slant();
else if (part == "panel")   { plate(); tub(); axle_lugs(); }   // print face-down
else if (part == "lever")   rotate([0, -90, 0]) lever(45);      // arm flat on the bed
else if (part == "ejector") rotate([180, 0, 0]) ejector(0);     // face down
// assembly-frame exports (for Blender animation etc): shared coordinates,
// lever parked, ejector retracted
else if (part == "lever_asm")   lever(0);
else if (part == "ejector_asm") ejector(0);
else                        phone_stack();
