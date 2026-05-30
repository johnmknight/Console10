// =============================================================================
// CONSOLE10 — Slide-Out Gridfinity Drawer  v0.2  (parametric)
//
// A 2U slide-out drawer for the BOTTOM of a Console10 module. The drawer floor
// is a true Gridfinity baseplate (42 mm grid, standard 4.75 mm interface) so any
// off-the-shelf Gridfinity bin drops in and locks.
//
// ARCHITECTURE (v0.2 — faceplate-anchored, no floor hardware):
//   * The FACEPLATE is the only thing that mounts to the module. It is a 30 deg
//     slanted plate that bolts to the cheek SLANT rack inserts (2 screws/side,
//     the standard Console10 faceplate mount). Its two C-channel slide RAILS are
//     printed INTEGRAL to it and run straight back along the floor into the
//     cavity. Nothing touches or modifies the bottom panel — the faceplate is
//     the whole anchor, and the rails simply rest on the floor for load support.
//   * The DRAWER is a Gridfinity box with side TONGUES that ride in the rails. It
//     pulls out through the faceplate MOUTH; its own 30 deg front nests flush in
//     the mouth when closed (console look). On a drawer module the faceplate
//     fills the bottom-front wedge, so it REPLACES Console10_front_insert.
//
// TWO PRINTABLE PARTS from this one file (set `part`):
//   part = "faceplate" -> the fixed slanted faceplate + integral rails (print 1x)
//   part = "drawer"    -> the moving Gridfinity drawer (print 1x)
//   part = "assembly"  -> both, in the module frame, for fit-check (not printable)
//
// COORDINATE FRAME (shared with the cheek/bottom parts):
//   X = width  (0 = module centerline; interior spans +/-116.5)
//   Y = depth  (0 = front-bottom corner; +Y toward the open back at 228.6)
//   Z = height (0 = interior floor = TOP of the bottom-panel slab; +Z up)
// Everything is modeled in the MOUNTED (module) frame so the rails read level and
// the fit-check is real; print orientations are noted per part below.
//
// FIRST-PRINT ITEMS (as with the rest of the project, clearances are validated on
// the first article): the tongue/slot running fit (`run_gap`) and the Gridfinity
// pocket fit. Tune and re-slice; the geometry is fully parametric.
// =============================================================================

part = "assembly";   // "faceplate" | "drawer" | "assembly"

// ---------- MODULE INTERIOR (derived from the cheek + bottom parts) ----------
panel_width   = 253;      // 10" mini-rack width (= top/bottom panel width)
cheek_thick   = 10;       // cheek thickness — interior starts inboard of this
module_depth  = 228.6;    // bottom-edge length (front-bottom corner to back)
slant_angle   = 30;       // front slant, degrees from vertical (isogrid-aligned)
U             = 44.45;    // 1U, mm

interior_half = panel_width/2 - cheek_thick;   // 116.5  (cheek inner face, +/-X)
interior_w    = 2*interior_half;               // 233.0
slant_tan     = tan(slant_angle);              // 0.5774  (front recedes this*Z)
slant_sin     = sin(slant_angle);              // 0.5
slant_cos     = cos(slant_angle);              // 0.8660
cheek_ctr_x   = interior_half + cheek_thick/2; // 121.5  (slant insert X centerline)

// ---------- FACEPLATE (slanted bezel) ----------------------------------------
drawer_u      = 2;                  // rack-U tall
face_height   = drawer_u*U - 1.0;   // 87.9 — covers the bottom 2U of the slant
face_t        = 4;                  // bezel slab thickness (modeled along +Y)
face_w        = 247;                // bezel width — laps each cheek front face,
                                    // covers the slant insert at X=121.5, < panel 253
face_overlap  = (face_w - interior_w)/2;   // 7 — lap onto each cheek (flush + stop)

// faceplate -> slant mount (2 screws/side into the cheek slant inserts).
// `mount_s` = distance ALONG the slant from the front-bottom corner; these are
// two of the cheek's 12 slant-insert positions that fall within the 2U face.
mount_s       = [50.80, 95.25];     // along-slant -> Z = s*cos30 = 44.0, 82.5
m10_32_clear  = 5.5;                // 10-32 clearance through the bezel

// ---------- SLIDE: integral C-channel rails + drawer tongues -----------------
// Rail cross-section (X across, Z up), at the LEFT cheek face, mirrored at right.
// The channel mouth faces INWARD (+X); the drawer tongue rides in the slot
// between the bottom and top flanges. Rails rest on the floor (Z from 0) AND tie
// into the faceplate apron at the front, so there is no cantilever load.
rail_twall    = 2.0;     // rail back wall (against the cheek), X
rail_reach    = 6.0;     // flange reach inward from the cheek, X
rail_bf       = 3.0;     // bottom flange (tongue running surface top), Z
rail_tf       = 3.0;     // top flange (retaining lip), Z
rail_h        = 12.0;    // total rail height, Z  -> slot = rail_h-bf-tf = 6 mm
rail_back_y   = 190;     // rail rear end (Y) — sets supported travel
run_gap       = 0.5;     // running clearance, drawer-to-rail

tongue_t      = 5.0;     // tongue thickness (Z), rides in the 6 mm slot
tongue_reach  = 4.0;     // how far the tongue projects into the channel (X)

cheek_face_x  = -interior_half;                 // -116.5
mouth_x       = cheek_face_x + rail_reach;       // -110.5  (channel mouth)
slot_z0       = rail_bf;                          // 3
slot_z1       = rail_h - rail_tf;                 // 9
tongue_z0     = slot_z0 + (slot_z1-slot_z0-tongue_t)/2;  // centered in slot
side_wall_x   = mouth_x + run_gap;               // -110.0  drawer outer face

// ---------- FACEPLATE MOUTH (opening the drawer pulls through) ---------------
// Starts above the rail/apron band so the lower face is a solid apron tying the
// rails to the bezel; the side borders carry the mount screws.
mouth_z0      = rail_h;                  // 12  (above the apron/rails)
mouth_z1      = face_height - 2;         // 85.9 (thin top border)
mouth_w       = 2*side_wall_x*-1 + 2;    // 222 — drawer outer (220) + clearance

// ---------- GRIDFINITY STANDARD (baseplate interface) ------------------------
// Canonical profile: 42 mm pitch, 0.5 mm total XY clearance (bin = 41.5), and a
// 4.75 mm female interface = 2.15 (45) + 1.8 (vertical) + 0.8 (45) measured DOWN
// from the baseplate top; outer corner radius 4 mm. These make a standard bin
// foot seat — do not edit without breaking compatibility.
GF_PITCH   = 42.0;
GF_CLR     = 0.25;       // per side -> bin is 0.5 mm smaller than the pitch
GF_R       = 4.0;        // top outer corner radius
GF_C_TOP   = 2.15;       // upper 45 chamfer height
GF_VERT    = 1.8;        // vertical wall height
GF_C_BOT   = 0.8;        // lower 45 chamfer height
GF_BASE_H  = GF_C_TOP + GF_VERT + GF_C_BOT;   // 4.75

gf_nx      = 5;          // cells across (X)
gf_ny      = 4;          // cells deep   (Y)
gf_field_x = gf_nx*GF_PITCH;   // 210
gf_field_y = gf_ny*GF_PITCH;   // 168
floor_t    = 3;          // solid sub-floor under the pockets (drawer bottom)

// ---------- DRAWER BODY ------------------------------------------------------
wall_t        = 5;       // side/back wall thickness
wall_h        = 30;      // low guidance walls; the tall front does the retaining
gf_y0         = 10;      // Y where the gridfinity field starts (behind the front)
drawer_half   = gf_field_x/2 + wall_t;     // 110 — outer half-width (X)
back_wall_y   = gf_y0 + gf_field_y;        // 178 — front face of the back wall
body_depth    = back_wall_y + wall_t;      // 183 — total body depth (Y)
dfront_t      = 4;       // drawer slanted front thickness (along +Y)

$fn = 40;

echo(str("FACEPLATE  ", face_w, " x face ", face_height, " slant ", slant_angle,
         " | mouth ", mouth_w, " x [", mouth_z0, "..", mouth_z1, "]",
         " | mounts/side ", len(mount_s)));
echo(str("DRAWER     body ", 2*drawer_half, " x ", body_depth, " x walls ", wall_h,
         " | gridfinity ", gf_nx, "x", gf_ny, " (", gf_field_x, " x ", gf_field_y, ")"));
echo(str("SLIDE      rail ", rail_reach+rail_twall, "(X) x ", rail_h,
         "(Z) slot ", slot_z1-slot_z0, " | tongue ", tongue_reach, "x", tongue_t,
         " | run_gap ", run_gap));

// =============================================================================
// GENERIC: a 30 deg slanted slab (front face on the module slant), centered X.
//   w  = width, zb..zt = vertical extent, th = thickness (modeled along +Y)
// =============================================================================
module slanted_slab(w, zb, zt, th) {
    translate([-w/2, 0, 0])
        rotate([90,0,90])              // map the Y-Z polygon onto an X-extrusion
            linear_extrude(w)
                polygon([[zb*slant_tan,      zb],
                         [zt*slant_tan,      zt],
                         [zt*slant_tan + th, zt],
                         [zb*slant_tan + th, zb]]);
}

// =============================================================================
// GRIDFINITY BASEPLATE
// =============================================================================
module rsq(s, r) { offset(r = r) square([s - 2*r, s - 2*r], center = true); }

// One female pocket, TOP at z=0, opening up, cut DOWN to z = -GF_BASE_H. The
// three stacked sections mirror the bin-foot profile; a 45 chamfer of height h
// shrinks the square by 2h and the radius by h (keeps the inner square constant).
module gf_pocket() {
    top_s = GF_PITCH - 2*GF_CLR;   // 41.5
    mid_s = top_s - 2*GF_C_TOP;    // 37.2
    bot_s = mid_s - 2*GF_C_BOT;    // 35.6
    eps = 0.01;
    hull() {
        translate([0,0,-eps])      linear_extrude(eps) rsq(top_s, GF_R);
        translate([0,0,-GF_C_TOP]) linear_extrude(eps) rsq(mid_s, GF_R - GF_C_TOP);
    }
    translate([0,0,-(GF_C_TOP+GF_VERT)])
        linear_extrude(GF_VERT) rsq(mid_s, GF_R - GF_C_TOP);
    hull() {
        translate([0,0,-(GF_C_TOP+GF_VERT)+eps]) linear_extrude(eps) rsq(mid_s, GF_R - GF_C_TOP);
        translate([0,0,-GF_BASE_H])              linear_extrude(eps) rsq(bot_s, GF_R - GF_C_TOP - GF_C_BOT);
    }
}

// Baseplate slab + grid of pockets; top surface at z = floor_t + GF_BASE_H,
// field front edge at Y = gf_y0, centered on X.
module gridfinity_baseplate() {
    top_z = floor_t + GF_BASE_H;
    x0 = -gf_field_x/2 + GF_PITCH/2;
    y0 =  gf_y0        + GF_PITCH/2;
    difference() {
        translate([-gf_field_x/2, gf_y0, 0]) cube([gf_field_x, gf_field_y, top_z]);
        for (ix = [0:gf_nx-1], iy = [0:gf_ny-1])
            translate([x0 + ix*GF_PITCH, y0 + iy*GF_PITCH, top_z]) gf_pocket();
    }
}

// =============================================================================
// FACEPLATE  (fixed): slanted bezel with a mouth + integral C-channel rails
//   Print orientation: lay the bezel face-down on the bed; the rails then point
//   up — print with supports under the rail top-flange overhangs, or split the
//   rails and glue. (Flagged as a first-article tuning item.)
// =============================================================================

// One C-channel rail (left); runs Y=0 (at the bezel) back to rail_back_y.
module rail_left() {
    union() {
        // back wall against the cheek
        translate([cheek_face_x, 0, 0]) cube([rail_twall, rail_back_y, rail_h]);
        // bottom flange (tongue runs on top)
        translate([cheek_face_x, 0, 0]) cube([rail_reach, rail_back_y, rail_bf]);
        // top flange / retaining lip
        translate([cheek_face_x, 0, rail_h - rail_tf]) cube([rail_reach, rail_back_y, rail_tf]);
    }
}

// Through-hole for one slant mount screw at along-slant distance s, side X.
// Axis = perpendicular to the slant face (matches the cheek's slant inserts).
module slant_mount_hole(s, x) {
    translate([x, s*slant_sin, s*slant_cos])
        rotate([270 - slant_angle, 0, 0])
            translate([0,0,-(face_t+20)]) cylinder(d = m10_32_clear, h = 2*(face_t+20), $fn = 24);
}

module faceplate() {
    difference() {
        union() {
            // slanted bezel
            slanted_slab(face_w, 0, face_height, face_t);
            // integral rails (rest on floor, tie into the apron band below mouth)
            rail_left();
            mirror([1,0,0]) rail_left();
            // apron: solid lower band of the bezel already covers Z<mouth_z0 and
            // overlaps the rail fronts, tying them together.
        }
        // mouth through the bezel
        slanted_slab(mouth_w, mouth_z0, mouth_z1, face_t + 2);
        // slant mount screws, 2 per side
        for (x = [-cheek_ctr_x, cheek_ctr_x])
            for (s = mount_s) slant_mount_hole(s, x);
    }
}

// =============================================================================
// DRAWER  (moving): Gridfinity box + side tongues + slanted front + pull
//   Print orientation: floor down (as modeled). Support the slanted front, or
//   print the front as a separate glued piece (parameterize later if wanted).
// =============================================================================

// Finger pull: a shallow horizontal recess across the upper drawer front.
module dfront_pull() {
    pull_w = 90; pull_h = 12; pull_d = 4;
    z = mouth_z1 - 16;
    translate([-pull_w/2, z*slant_tan - 0.5, z]) cube([pull_w, pull_d, pull_h]);
}

module drawer() {
    difference() {
        union() {
            gridfinity_baseplate();
            // side walls (carry the tongues), run the body depth
            for (sx = [-1, 1])
                translate([sx*drawer_half - (sx<0?0:wall_t), 0, 0])
                    cube([wall_t, body_depth, wall_h]);
            // back wall
            translate([-drawer_half, back_wall_y, 0]) cube([2*drawer_half, wall_t, wall_h]);
            // slanted front — nests flush in the mouth when closed
            slanted_slab(mouth_w - 1, mouth_z0 + 0.5, mouth_z1 - 0.5, dfront_t);
            // side tongues — project outward into the rail slots, full body length
            for (sx = [-1, 1])
                translate([sx*side_wall_x, 0, tongue_z0])
                    translate([sx<0 ? -tongue_reach : 0, 0, 0])
                        cube([tongue_reach, body_depth, tongue_t]);
        }
        dfront_pull();
    }
}

// =============================================================================
// FIT-CHECK ASSEMBLY  (not printable)
// =============================================================================
module assembly() {
    color("Gainsboro") faceplate();
    drawer();
}

// ---------- OUTPUT -----------------------------------------------------------
if      (part == "faceplate") faceplate();
else if (part == "drawer")    drawer();
else                          assembly();
