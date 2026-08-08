// Console10_b860i_faceplate.scad
// ---------------------------------------------------------------------------
// 10-inch mini-rack 2U faceplate for the ASUS ROG STRIX B860-I GAMING WIFI
// (truenas2). The board is shelf-mounted with its rear I/O at the rack's
// front plane; this plate drops over the pre-mounted I/O shield and COVERS
// the empty area around it. One rectangular opening, nothing per-port.
//
// Standards (Console10 designdoc s2, EIA-310 10-inch mini rack):
//   1U = 44.45 mm; per-U holes at 6.35 / 22.225 / 38.10 from the U boundary;
//   rail-to-rail hole spacing = 236.525 mm.
// ---------------------------------------------------------------------------

/* ----------------------------- rack constants --------------------------- */
units     = 2;              // faceplate height in rack units
U         = 44.45;          // one rack unit, mm
plate_w   = 254;            // 10-inch standard faceplate width
plate_h   = units * U;      // 88.9 mm for 2U
plate_t   = 3;              // panel thickness -- rigid in PLA at this span
corner_r  = 3;              // outer corner radius

hole_span = 236.525;        // rail-to-rail hole spacing
slot_w    = 6.5;            // clears the rack's M6-class screws
slot_len  = 10;             // horizontal slot: forgives rail-width variance
// Outermost EIA hole rows sit 6.35 mm inside the top/bottom U boundaries.
hole_y    = plate_h/2 - 6.35;

/* ------------------------------ I/O opening ----------------------------- */
// The ATX rear-I/O aperture is 158.75 x 44.45 mm and the B860-I's integrated
// shield lives inside that footprint. The opening below adds clearance all
// around so the plate slides over the shield (and its Wi-Fi antenna posts)
// while the board stays bolted to its shelf. Tune open_x / open_y after a
// test fit if the board isn't dead-centre between the rails.
open_w  = 165;   // opening width  (158.75 aperture + ~3 mm/side)
open_h  = 50;    // opening height (44.45 aperture + ~2.8 mm top/bottom)
open_x  = 0;     // +right when facing the plate, mm
open_y  = 0;     // +up, mm
open_r  = 2;     // opening corner radius
chamfer = 0.8;   // front-edge chamfer around the opening -- reads machined

$fn = 48;

/* ------------------------------- helpers -------------------------------- */
// Rounded rectangle, centred. offset(r)offset(-r) rounds without changing
// the overall W x H, so every dimension above stays true.
module rrect(w, h, r) {
    offset(r) offset(-r) square([w, h], center=true);
}

/* -------------------------------- plate --------------------------------- */
module plate_2d() {
    difference() {
        rrect(plate_w, plate_h, corner_r);
        // the one big opening that frames the motherboard backplane
        translate([open_x, open_y]) rrect(open_w, open_h, open_r);
        // four rack-mount slots, outermost EIA rows. Stadium shape via
        // hull-of-circles: rrect() would degenerate at r == h/2.
        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx*hole_span/2, sy*hole_y])
                hull()
                    for (cx = [-1, 1])
                        translate([cx*(slot_len - slot_w)/2, 0])
                            circle(d = slot_w);
    }
}

// 45-degree chamfer ring sunk into the FRONT face around the opening.
// Built as a hull between the opening outline at depth and a grown outline
// at the surface -- no minkowski, stays fast and manifold.
module opening_chamfer() {
    translate([open_x, open_y, 0]) hull() {
        translate([0, 0, plate_t + 0.01])
            linear_extrude(0.01)
                rrect(open_w + 2*chamfer, open_h + 2*chamfer, open_r + chamfer);
        translate([0, 0, plate_t - chamfer])
            linear_extrude(0.01)
                rrect(open_w, open_h, open_r);
    }
}

module faceplate() {
    difference() {
        linear_extrude(plate_t) plate_2d();
        opening_chamfer();
    }
}

faceplate();
