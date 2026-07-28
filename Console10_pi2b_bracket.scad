// =============================================================================
// CONSOLE10 — Raspberry Pi 2B / 3B Bracket  v0.3  (flat panel + rear standoffs)
//
// Parametric bracket for the Raspberry Pi 2B (also fits Pi 3B / 3B+ — same B+
// form factor with 85.6 × 56.5 mm board, 58 × 49 mm M2.5 mounting pattern).
//
// DESIGN — flat panel, Pi behind it, parallel mount:
//   - Front face (operator side) at Z = +panel_t
//   - Panel back face at Z = 0
//   - 4 standoffs project rearward from the panel back to Z = -standoff_h
//   - Pi PCB sits at the top of the standoffs, PARALLEL to the panel
//   - Pi's USB + RJ45 ports stick UP from the PCB *toward* the panel
//     and exit through 3 cutouts in the panel face
//   - 4 M2.5 screws thread from the FRONT face into the standoffs
//   - 2 corner mounting holes attach the bracket to a 2U faceplate slot
//
// LAYOUT (looking at the panel face from the front):
//   X = horizontal (Pi long axis lies along X, 85.6 mm)
//   Y = vertical   (Pi short axis lies along Y, 56.5 mm; USB+ETH edge at Y_min)
//   Z = depth      (panel face at +Z, bracket extends in -Z)
//
// PORT POSITIONS (Pi USB+RJ45 along ONE long edge — needs calipers verification):
//   RJ45 ethernet     ~16 × 12 mm, X center ≈ 10 mm from Pi left corner
//   USB stack 1       ~13 × 14 mm, X center ≈ 30 mm
//   USB stack 2       ~13 × 14 mm, X center ≈ 48 mm
// =============================================================================

// ---------- Pi 2B board geometry (B+ form factor) ----------
pi_w           = 85.6;     // long axis (along panel X)
pi_h           = 56.5;     // short axis (along panel Y)
pi_pcb_t       = 1.6;

// ---------- Pi mounting hole pattern ----------
// Hole pattern is 58 × 49 mm, OFFSET on the long axis: 3.5 from one short
// edge, 24.1 from the other (USB-stack side has the 24.1 offset).
mount_xspan    = 58;       // along Pi long axis (= panel X)
mount_yspan    = 49;       // along Pi short axis (= panel Y)
mount_xinset_L = 3.5;      // X inset from Pi LEFT short edge (the non-USB end)
mount_yinset   = 3.75;     // Y inset from each long edge (56.5 - 49) / 2
m25_clear      = 2.75;     // M2.5 clearance hole (also drilled in the Pi)

// ---------- Pi placement on panel (Pi PCB centered on panel) ----------
// Pi origin (left/bottom corner) in panel coords
pi_origin_x    = -pi_w/2;
pi_origin_y    = -pi_h/2;

// ---------- Port positions (X from Pi LEFT corner, along long edge with USB+ETH) ----------
// TUNE THESE — calipers on a real Pi 2B will give exact values.
rj45_xc        = 10;       rj45_w  = 16;    rj45_h  = 13;
usb1_xc        = 30;       usb1_w  = 13;    usb1_h  = 14.5;
usb2_xc        = 48;       usb2_w  = 13;    usb2_h  = 14.5;
port_clr       = 0.5;      // per-side cutout clearance
// USB+RJ45 edge of Pi: at Y=0 in Pi coords (the LONG edge opposite GPIO)
ports_y_edge   = pi_origin_y;   // panel-Y of Pi's port-side long edge

// ---------- standoff ----------
standoff_d     = 5;        // outer diameter
standoff_h     = 5;        // distance from panel back to Pi PCB

// ---------- panel envelope ----------
panel_margin_x = 5;        // X margin around Pi
panel_margin_y = 5;        // Y margin around Pi
panel_w        = pi_w + 2*panel_margin_x;     // 95.6
panel_h        = pi_h + 2*panel_margin_y;     // 66.5
panel_t        = 3;

// ---------- faceplate-attachment mount holes ----------
fp_mount_d     = 3.2;      // M3 clearance
fp_mount_inset = 4;

show_pi        = true;
$fn            = 48;

// Derived: Pi mounting hole positions in panel coords
mount_hole_xs  = [pi_origin_x + mount_xinset_L,
                  pi_origin_x + mount_xinset_L + mount_xspan];
mount_hole_ys  = [pi_origin_y + mount_yinset,
                  pi_origin_y + mount_yinset + mount_yspan];

echo(str("PI 2B BRACKET v0.3 (parallel mount) | panel ", panel_w, " x ", panel_h, " x ", panel_t,
         " | standoff h=", standoff_h, " d=", standoff_d,
         " | Pi mount holes at X=", mount_hole_xs, " Y=", mount_hole_ys,
         " | ports: RJ45 xc=", rj45_xc, "  USB1 xc=", usb1_xc, "  USB2 xc=", usb2_xc));

// =============================================================================
// PORT CUTOUTS — rectangular openings on the panel face along the Pi's USB edge
// Each port cutout is centered horizontally at port_xc (Pi coords + offset),
// vertically just above the port-edge Y, with size port_w × port_h.
// =============================================================================
module port_cutouts() {
    for (p = [
        [rj45_xc,  rj45_w,  rj45_h],
        [usb1_xc,  usb1_w,  usb1_h],
        [usb2_xc,  usb2_w,  usb2_h]
    ]) {
        xc = pi_origin_x + p[0];
        yc = ports_y_edge + p[2]/2;
        translate([xc, yc, panel_t/2])
            cube([p[1] + 2*port_clr, p[2] + 2*port_clr, panel_t + 2], center = true);
    }
}

// =============================================================================
// PI MOUNTING HOLES — 4 small holes through the panel for M2.5 screws
// =============================================================================
module pi_mount_holes() {
    for (x = mount_hole_xs)
        for (y = mount_hole_ys)
            translate([x, y, panel_t/2])
                cylinder(d = m25_clear, h = panel_t + 2, center = true);
}

// =============================================================================
// STANDOFFS — 4 cylinders projecting REARWARD from panel back to PCB plane
// =============================================================================
module standoffs() {
    for (x = mount_hole_xs)
        for (y = mount_hole_ys)
            translate([x, y, -standoff_h])
                cylinder(d = standoff_d, h = standoff_h);
}

// =============================================================================
// FACEPLATE MOUNT HOLES — 2 small holes on diagonally-opposite panel corners
// =============================================================================
module fp_mount_holes() {
    for (corner = [[-1, +1], [+1, -1]]) {
        translate([corner[0] * (panel_w/2 - fp_mount_inset),
                   corner[1] * (panel_h/2 - fp_mount_inset),
                   panel_t/2])
            cylinder(d = fp_mount_d, h = panel_t + 2, center = true);
    }
}

// =============================================================================
// BRACKET
// =============================================================================
module pi2b_bracket() {
    difference() {
        union() {
            // panel slab
            translate([-panel_w/2, -panel_h/2, 0])
                cube([panel_w, panel_h, panel_t]);
            // 4 rear standoffs
            standoffs();
        }
        // cuts
        port_cutouts();
        pi_mount_holes();
        fp_mount_holes();
    }
}

// =============================================================================
// MOCK PI — fit-check only. PCB lies parallel to panel at Z = -standoff_h.
// =============================================================================
module pi_mock() {
    // PCB
    color("DarkGreen")
        translate([pi_origin_x, pi_origin_y, -standoff_h - pi_pcb_t])
            cube([pi_w, pi_h, pi_pcb_t]);

    // Port mocks — protrude UP from PCB toward panel, exiting through cutouts
    // Z range: from PCB top (z = -standoff_h) up to panel front (z = panel_t)
    for (p = [
        [rj45_xc,  rj45_w,  rj45_h, "Silver"],
        [usb1_xc,  usb1_w,  usb1_h, "DimGray"],
        [usb2_xc,  usb2_w,  usb2_h, "DimGray"]
    ]) {
        xc = pi_origin_x + p[0];
        yc = ports_y_edge + p[2]/2;
        color(p[3])
            translate([xc - p[1]/2, yc - p[2]/2, -standoff_h])
                cube([p[1], p[2], standoff_h + panel_t]);
    }
}

// ---------- render ----------
color("Gainsboro") pi2b_bracket();
if (show_pi) pi_mock();
