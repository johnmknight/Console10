# Console10 — Faceplate Interface Reference

Measured/derived dimensions for every device interface used across the Console10 faceplates. Each entry includes the source device, measured envelope, panel cutout (with clearance), and any rear-side support / retention features. Pull from this file when designing a new faceplate.

All dimensions in **mm** unless noted.

---

## Slant-insert mount holes (every faceplate)

Bolts the panel to the cheek slant inserts.

| | Value |
|---|---|
| Hole diameter | 5.5 (10-32 clearance) |
| X positions | ±121.5 (`±cheek_ctr_x`) |
| Y positions (3U plate, 133.35 tall) | 50.80, 127.00 |
| Y positions (2U plate, 88.9 tall) | 50.80, 82.55 |

Y positions are along-slant `s`, derived from `front_gap=U=44.45 + u_idx*U + EIA{6.35, 22.225, 38.10}`. Skip `s=22.225` — it's inside the front_gap and has no cheek hole.

---

## CF card reader (press-fit + full-depth open sleeve)

USB CF card reader, slim vertical form. Press-fit retention only, no screws.

| | Value |
|---|---|
| Body W × H × D | 13.8 × 65.9 × 30 |
| Panel cutout | 13.8 × 65.9 (sharp corners) — `cf_press_clr = 0` |
| Rear sleeve | wraps body for full depth, **open both ends** |
| Sleeve wall thickness | 2.5 (`cf_wall_t`) |
| Sleeve outer | 18.8 × 70.9 × 30 |

If press-fit feels loose after print, set `cf_press_clr` negative (e.g., `-0.1`).

---

## SD card holder (press-fit + closed-back sleeve, sits proud)

Custom 3D-printed holder (STL: `SD card holder 1x1x3.stl`). Slides into the panel from the front, bottoms on the sleeve floor leaving the body sitting proud so the user can grab it.

| | Value |
|---|---|
| Body W × H × D | 41.5 × 41.5 × 24.54 |
| Panel cutout | 41.5 × 41.5 (sharp corners) — `holder_press_clr = 0` |
| Proud height when bottomed | 5 (`holder_proud`) |
| Sleeve wall + floor thickness | 2.5 (`holder_wall_t`) |
| Extra cavity depth (after print test) | 6 (`holder_sleeve_extra_d`) |
| Derived sleeve total depth | 25.04 |
| Cavity depth (above floor) | 22.54 |
| Sleeve back | **closed** — floor is the bottom-out stop |

---

## USB-C panel mount (QIANRENON rectangular, 2× M3 screw, proud flange)

USB-C 3.1 female-to-female 10 Gbps panel mount adapter. Aluminum flange sits proud of the panel front by 3.6 mm; body protrudes 26.4 mm behind.

| | Value |
|---|---|
| Body (through cutout) W × H × D | 17 × 23 × 26.4 |
| Front flange W × H × T | 19 × 36.6 × 3.6 |
| Cutout W × H | 17.4 × 23.4 (per-side clearance 0.2 via `usbc_body_clr`) |
| Screw hole diameter | 3.2 (M3 clearance) |
| Screw hole pitch (vertical) | 30 (`usbc_screw_y_pitch`) |
| Total depth | 30 (flange 3.6 + body 26.4) |

Flange overlaps the panel around the cutout and is retained by 2 M3 screws through the panel.

---

## Big square hole (84.1 × 84.1)

Generic large cutout — purpose TBD. Sharp corners, no rear features.

| | Value |
|---|---|
| Cutout W × H | 84.1 × 84.1 |

---

## Stream Deck Mini (proud-bezel mount, 4 rear corner clips)

**Removed from the aux faceplate after print-test passed.** Design notes saved separately in [`design_notes_streamdeck_mini_pocket.scad`](design_notes_streamdeck_mini_pocket.scad) — re-`include<>` to put it back on a future panel.

| | Value |
|---|---|
| Bezel face W × H | 85.2 × 61.3 |
| Body depth (face → back, excludes stand) | 17 |
| Integrated rear stand depth | 41 (total 58 from face) |
| Bezel corner radius | ~6 |
| Real button-row span (MEASURED) | 54 × 34.7 |
| Cutout extra clearance (locked after testing) | 1.0 per side |
| **Final cutout** | 56 × 36.7, r=3 |
| Corner clip arm | 2.5 (X) × 8 (Y) × (sd_d + hook_h) tall |
| Corner clip hook engagement | 1.2 (= hook_d 1.5 − clip_gap 0.3) |

The cutout exposes only the button area; the bezel rim (~15.6 / ~13.3 mm per side) is captured behind the panel.

---

## HDMI switch (vertical, rear sleeve, M2 set screws)

QIANRENON-style HDMI switch mounted with its long axis vertical on the **display faceplate** (not the aux faceplate). Press-fit cutout + rear sleeve with 2 M2 clearance holes through L+R walls for set screws clamping the device sides.

| | Value |
|---|---|
| Device W × H × D (in mount orientation) | 11.02 × 75.2 × 17.1 |
| Panel cutout | 11.02 × 75.2 (sharp corners) |
| Sleeve depth (deepened after test) | 35 (`hsw_d`) |
| Sleeve wall thickness | 2.5 |
| M2 set screw axis | Single X-axis cylinder drilled through both L/R sleeve walls |
| M2 hole diameter | 2.4 (M2 clearance) |
| M2 Y position | top of sleeve − 6.6 (from "back" of device in rotated orientation) |
| M2 Z position | sleeve mid-depth (−hsw_d/2) |

---

## Faceplate-attachment mount holes (Stream Deck era — kept in design notes)

Two M3 clearance holes on diagonally-opposite panel corners for attaching the bracket to a faceplate. Currently unused on the aux faceplate (slant-insert holes do the mounting).

| | Value |
|---|---|
| Hole diameter | 3.2 (`fp_mount_d`) |
| Inset from panel corner | 4 (`fp_mount_inset`) |

---

## Horizontal layout chain (current aux faceplate)

Devices auto-positioned left-to-right with `panel_layout_gap = 10` between adjacent device outer footprints (sleeve outer / flange edge / clip outer).

```
CF (-79)  →  HOLDER (-36.35)  →  USB-C (+6.4)  →  BIG HOLE (+67.95)
```

CF X is fixed; downstream centers derive via chain math (each = previous outer + gap + this device half-width + this device wall/clip thickness).

---

*Generated 2026-05-30. Update when a new device joins the project or measurements change.*
