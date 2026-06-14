# CONSOLE10 — DESIGN DOCUMENT

**Version 3.3**
**Date: 2026-05-28**

---

## v3.3 changelog (vs v3.1)

1. **Top front bevel** added (built cleanly via `hull()`) — the top's front edge rakes to the 30 deg slant.
2. **M3 mounting screws**: socket-cap, **counterbored flush** — top **3/side**, bottom **4/side**, centered over each cheek — driving into **M3 heat-set inserts** in the cheek top + bottom edges.
3. **Tongue & groove equalized**: tongue + both walls all equal at 10/3 (~3.33 mm), centered (was a 4 mm tongue offset to the inside, unequal walls).
4. **Isogrid moved to the EXTERIOR face**, **5 mm deep** (was 1.8 mm on the interior), with the **outer ring filled solid** (`iso_edge_fill`, ~half a triangle spacing) so the deeper pockets clear the edge rabbets / inserts / rail holes.

## v3.1 changelog (vs v3.0)

1. **All parts are now parametric OpenSCAD**: `Console10_top.scad`, `Console10_bottom.scad`, `Console10_front_insert.scad` (reverse-engineered from the NASA STL models), plus the existing cheek `Console10_isogrid.scad` and an assembly `Console10_module.scad`.
2. **Symmetric ridge joinery**: the TOP now uses the SAME joinery as the bottom — a slab with two side ridges that seat into rabbets in the cheek **top** edge. The v3.0 top "wall + slot" scheme is dropped. The cheek now has a rabbet on **both** the top and bottom edges.
3. **Front insert** now spans BETWEEN the cheeks (~232.6 mm), sitting on the floor at the front, with its 30° face flush with the slant (was modeled as a slant-length wedge).
4. A 30° bevel on the top's front edge was tried and reverted here (re-added cleanly in v3.3).

## v3.0 changelog (vs v2.5) — MAJOR ARCHITECTURE CHANGE

The split-half + dovetail-castellation panel scheme (v2.4–v2.5) is **abandoned**. Top and bottom are now **single-piece panels** sized to the 10-inch mini-rack standard width, and joinery is **rabbet-based**, not centerline-dovetail.

1. **Top & bottom panels are one piece each** — no L/R split, no centerline dovetail. Their width now aligns with the **10" mini-rack standard (~253 mm)**, so each panel **prints as a single part on a 255 × 255 × 255 mm bed**. The bed-fit split that drove the v2.4 dovetail design is no longer needed.
2. **Joinery is now rabbet-based** (replaces cheek tab-channels + centerline dovetail):
   - **Bottom**: a **raised ridge along each side** seats into a matching **rabbet in the cheek's bottom edge** (one ridge per side).
   - **Top**: a **rabbet** on the top that **each cheek's top edge sits into**.
   - Final hold: **glue or fasteners** (type TBD).
3. **Front insert added** (`NASA_Insert_Front.stl`): a slant-length wedge **template** that can either be **merged into the bottom** part or **printed standalone and glued** along the slant.
4. **Top / bottom / front are now standalone STL models**, not SCAD-generated. The **cheek remains SCAD-driven** (`Console10_isogrid.scad`).
5. **Deprecated**: `Console10_top_panel_half.scad`, `Console10_bottom_panel_half.scad`, the centerline dovetail (old §8), and the cheek top/bottom **tab-channels** (old §6) — the cheek now needs **rabbets** instead of channels (SCAD update pending, see §12).

(Changelogs v2.1–v2.5 retained in §14 for history.)

---

## 1. What we're building

Console10 is a modular 10-inch mini-rack housing for desktop equipment, 3D-printed in PLA, styled after Apollo-era NASA mission-control hardware.

A module is **five printed parts**: two trapezoidal isogrid **cheeks** (L/R sides), a single-piece **top** panel, a single-piece **bottom** panel, and a **front** slant insert (which may be merged into the bottom). The **back** face is an open equipment-mounting plane; 1U faceplates are user-installed. The **front slant** is also a mounting plane, with the front insert serving as filler/template.

Panels register to the cheeks via **rabbet joinery** (§6–7) and are secured with glue or fasteners.

---

## 2. Standards compliance

- **Mounting standard**: EIA-310-D 10-inch mini-rack
- **1U height**: 44.45 mm
- **Per-U hole pattern**: 3 holes at offsets 6.35, 22.225, 38.10 mm
- **Capacity**: 4U (C4 variant)
- **Rail-to-rail hole spacing**: 236.525 mm
- **Panel width**: aligned to the 10" mini-rack standard (~253 mm)

---

## 3. Module architecture

### 3.1 Parts list (5 parts per module)

| Part | Count | File (current) | Source | Role |
|------|-------|----------------|--------|------|
| Cheek | 2 | `Console10_isogrid-new.stl` | `Console10_isogrid.scad` | Side panel, right-trapezoid, isogrid, 10 mm thick |
| Top | 1 | `NEW_NASA_TOP.stl` | STL model | Caps the top edge; rabbet receives the cheek top edges |
| Bottom | 1 | `new_nasa_bottom.stl` | STL model | Floor; raised side ridges seat into cheek bottom-edge rabbets |
| Front insert | 1 | `NASA_Insert_Front.stl` | STL model (template) | Slant filler; merge into bottom or print standalone + glue |

No split halves, no separate rails, no centerline dovetail. Rail-mount holes are integral to each cheek's edge faces (§5).

### 3.2 Material

Default **PLA**. PETG/ASA acceptable for cheeks. (Solvent-bond requirement from the old dovetail design no longer applies; bonding is now at the rabbet interfaces if glue is used.)

### 3.3 Hardware BOM (per module)

| Item | Count | Use |
|------|-------|-----|
| 10-32 brass heat-set inserts | 48 | Equipment mounting (24 per cheek: 12 slant + 12 back) |
| Glue or fasteners | as required | Top/bottom-to-cheek at the rabbet interfaces (type TBD) |

---

## 4. Cheek

### 4.1 Silhouette (LOCKED, unchanged)

Right trapezoid, slant on the **front** edge.

| Edge | Length (mm) |
|------|-------------|
| Bottom | 228.6 |
| Back (vertical) | 205.45 |
| Top | 109.975 |
| Slant (front) | 237.25 |
| Slant angle | 30° from vertical (isogrid-aligned) |

### 4.2 Thickness — 10 mm

Hosts ~8 mm-deep edge-drilled 10-32 inserts with adequate wall material.

### 4.3 Isogrid (v2.5)

- Tiling: {3, 6} triangular · Spacing: 20 mm · Rib: 2.5 mm · **Pocket depth: 5 mm** (or through-cut) · Fillet: 1.59 mm
- **Face: EXTERIOR** (v3.3 — pockets are on the outside face; interior is flat)
- Coverage: **whole-triangle filter** + **outer-ring fill** — a pocket is generated only when all three triangle vertices fall inside the silhouette inset by `iso_edge_fill` (~half a spacing). This fills the outer ring(s) solid so the 5 mm pockets clear the edge rabbets / inserts / rail holes.

### 4.4 Cheek edge features for panel joinery (v3.0 — pending SCAD update)

- **Bottom edge**: a **rabbet** to receive the bottom panel's raised side ridge.
- **Top edge**: seats into the rabbet on the top panel (the cheek top is the male feature here).
- NOTE: the current `Console10_isogrid.scad` still models the **old tab-channels** (`top_channel()` / `bottom_channel()`) on these edges. These must be replaced with rabbets to match v3.0. See §12.

---

## 5. Equipment mounting (cheek edges)

Rack equipment mounts via flanged rack ears bolted directly to the cheek **edge face**, into heat-set inserts in the cheek thickness. The cheek edge IS the mounting surface — no separate rail.

### 5.1 Slant edge rail
- 12 × 10-32 insert holes, axis perpendicular to slant face, EIA-310 pattern, 4U, 1U bottom gap, 15 mm top margin.
- Positions along slant from front-bottom corner (mm): `50.80, 66.675, 82.55, 95.25, 111.125, 127.00, 139.70, 155.575, 171.45, 184.15, 200.025, 215.90`
- Hole: 4.2 mm dia (10-32 pilot), 8 mm deep.

### 5.2 Back edge rail
- 12 × 10-32 insert holes, axis perpendicular to back face, EIA-310 pattern, 4U from floor.
- Positions from floor (mm): `6.35, 22.225, 38.10, 50.80, 66.675, 82.55, 95.25, 111.125, 127.00, 139.70, 155.575, 171.45`
- Same hole dia/depth as slant.

---

## 6. Cheek ↔ panel rabbet joinery (replaces old §6 channels + §8 dovetail)

- **Bottom**: raised ridge on each side of the bottom panel → rabbet in the cheek bottom edge. Registers the floor laterally and locates the cheeks.
- **Top**: raised ridge on each side of the top panel → rabbet in the cheek **top** edge (symmetric with the bottom — same joinery both ends).
- **Securing**: glue or fasteners across the rabbet interfaces (TBD).
- Exact ridge/rabbet dimensions and clearances: **TBD** — to be set when the cheek SCAD is updated and the panels are dimensioned against it.

---

## 7. Top, bottom, and front parts (measured, as-modeled)

| Part | W × D × H (mm) | Notes |
|------|----------------|-------|
| **Top** (`Console10_top.scad`) | 253 × 109.975 × 10 | Slab (6 mm) + two 4×4 side ridges. Ridges seat into the cheek **top** rabbets (flipped in the module). One-piece. |
| **Bottom** (`Console10_bottom.scad`) | 253 × 228.6 × 10 | Slab (6 mm) + two 4×4 side ridges → cheek **bottom** rabbets. One-piece. |
| **Front insert** (`Console10_front_insert.scad`) | ~232.6 × 21.94 × 38 | Triangular wedge spanning BETWEEN the cheeks, on the floor at the front; 30° face flush with the slant. Print standalone + glue, or merge into the bottom. |

(The original `NEW_NASA_TOP.stl` / `new_nasa_bottom.stl` / `NASA_Insert_Front.stl` models are retained for reference; the parametric `.scad` files above supersede them.)

The 253 mm width aligns with the 10" mini-rack standard and fits a 255 mm bed as a single part — no split required.

---

## 8. Centerline joint — REMOVED

The v2.4–v2.5 trapezoidal dovetail castellation at the panel centerline is **superseded** by the single-piece panels + rabbet joinery (§6). There is no centerline split in v3.0.

---

## 9. Manufacturing

### 9.1 Print bed
255 × 255 × 255 mm (also fits Bambu A1/P1/X1 256 mm class).

### 9.2 Fit on bed (all single-piece)

| Part | Footprint (mm) | Thickness/Height | Fits 255 bed |
|------|----------------|------------------|--------------|
| Cheek | 228.6 × 205.45 | 10 mm | ✓ |
| Top | 253.0 × 109.9 | 16 mm | ✓ |
| Bottom | 253.0 × 228.6 | 10 mm | ✓ |
| Front insert | 237.3 long | 20.6 × 38 | ✓ |

### 9.3 Print orientation
- **Cheek**: flat on bed, **interior face down** (the isogrid is now on the exterior, so its pockets face up — no overhang). M3 insert holes in the top/bottom edges; rail holes in the slant/back edges.
- **Top / bottom**: flat on bed (rabbet/ridge features may need light support depending on orientation).
- **Front insert**: orient wedge for minimal support.

### 9.4 Suggested settings (PLA)
- 0.2 mm layers, 25–40% infill, 3–4 walls, supports as needed for rabbet/ridge overhangs.

---

## 10. Module exterior dimensions

| Dimension | Value (mm) |
|-----------|-----------|
| Depth (bottom front-to-back) | 228.6 |
| Height (back edge) | 205.45 |
| Slant length | 237.25 |
| Top edge length | 109.975 |
| Top/bottom panel width | ~253 (10" mini-rack standard) |

(Old v2.x interior/exterior width figures of 261.525 / 281.525 are superseded; reconcile final width against the rabbet geometry — see §13.)

---

## 11. Variants

| Variant | Description | Status |
|---------|-------------|--------|
| **C4** | 4U, standard | current |
| C2 | 2U (shorter) | future |
| C6 | 6U (taller) | future |
| C4-E | C4 with sci-fi etching | deferred |

---

## 12. Files

| File | Status |
|------|--------|
| `designdoc.md` (this file) | ✓ v3.1 |
| `README.md` | ✓ (v3.0 layout; minor v3.1 joinery sync pending) |
| `Console10_isogrid.scad` (cheek) | ✓ v3.1 — silhouette/isogrid + rabbets on both top & bottom edges |
| `Console10_top.scad` | ✓ v3.1 — slab + side ridges (parametric) |
| `Console10_bottom.scad` | ✓ v3.1 — slab + side ridges (parametric) |
| `Console10_front_insert.scad` | ✓ v3.1 — front wedge, spans between cheeks (parametric) |
| `Console10_module.scad` | ✓ v3.1 — fit-check assembly (use<> all parts) |
| `NEW_NASA_TOP.stl` / `new_nasa_bottom.stl` / `NASA_Insert_Front.stl` | reference STL models (superseded by the `.scad` parts) |
| `Console10_top_panel_half.scad` / `..._bottom_panel_half.scad` | ✗ DEPRECATED (split-half design) — safe to delete |
| `Console10_isogrid-do-not-delete.stl` | old 6 mm cheek (superseded) |

---

## 13. Open items

- **Reconcile module width**: panels are 253 mm; confirm final interior/exterior width and rabbet engagement against the cheeks (old 261.525 interior is superseded).
- **Front insert**: decide merge-into-bottom vs standalone + glue.
- **Securing method**: finalize glue vs fasteners for top/bottom-to-cheek.
- **Ridge/rabbet fit clearance**: first-print validate the 0.4 mm clearance.
- **Shared params**: consider a `Console10_params.scad` so the ridge/rabbet dims can't drift between the cheek and the panels.
- **MiniRax faceplates** (`MiniRaxFacePlate1.stl`, `MiniRax-plain-mini-faceplate.stl`): integrate / parameterize as needed.

---

## 15. Slide-out Gridfinity drawer — WIP v0.1 (2026-05-30)

A 2U slide-out drawer for the module BOTTOM whose floor is a true Gridfinity
baseplate. New file: `Console10_drawer.scad` (parametric; `part =
"faceplate"|"drawer"|"assembly"`). Compiles clean + manifold in OpenSCAD;
fit-check previews at `preview/drawer_assembly_iso.png` / `_side.png`.

**Architecture (locked with John):** faceplate-anchored, no floor hardware.
- The **faceplate** is a 30° slanted bezel that bolts to the cheek **slant** rack
  inserts (2 screws/side). Its two **C-channel slide rails are integral**, running
  back along the floor into the cavity. It REPLACES `Console10_front_insert` on a
  drawer module.
- The **drawer** is a 5×4 Gridfinity box (210×168 mm field, standard 4.75 mm
  interface) with side **tongues** riding the rails; its own 30° front nests
  flush in the faceplate mouth (finger-pull slot).

**Key params (as built):** face 247×87.9 mm, mouth 222×74 mm; drawer body
220×183 mm; rail 8 mm / 6 mm slot, tongue 4×5 mm, `run_gap` 0.5; Gridfinity
pitch 42, no-magnet "lite" baseplate.

**NEXT STEPS to make it print-ready (none are open design questions):**
1. **Drawer stop** — add a rear bump-stop in the rails + a removable front
   retainer so the drawer can't pull fully out. (Not yet modeled.)
2. **Rail overhang** — the C-channel lip overhangs its slot; add a 45° chamfer
   under the lip and/or a split-rail print option. Decide print orientation.
3. **Fit validation (first article):** tongue/slot `run_gap` and the Gridfinity
   pocket fit are first-print tuning items.
4. **Docs:** fold this into the README parts table + a designdoc v3.4 changelog
   and the variants list once the geometry is frozen.

**State:** `Console10_drawer.scad` is untracked (not committed). Previews are new
files in `preview/`. Nothing else in the repo was changed.

---

## 16. Twin-MacroPad lower faceplate — v0.4 (2026-06-14)

A plain 2U faceplate (`Console10_macropad_pair_faceplate.scad`; `part =
"panel" | "mount_board" | "macropad_backplate"`) carrying **two Adafruit 5128
MacroPad RP2040s** mounted end-to-end, each rotated 90° so the long axis runs
across the panel (OLED/encoder ends out at the far left/right, PCBs butt at the
centre seam). Each board drops into a rear pocket+collar; keys stay proud through
the front.

**Two bolt circles per pad (this is the key geometry).** The MacroPad's own PCB
holes and the panel's backplate posts are **deliberately not concentric**:
- **PCB mounting holes** — pitch `mp_hx,mp_hy` = 52.07 × 81.28 mm (±26.04 × ±40.64),
  **but the 4-hole pattern is NOT centred on the board.** Measured from the 5128
  assembly STL (cross-sectioned + overlaid in OpenSCAD — *measure from the model,
  not photos*), it sits **`mp_hy_off` = +7.65 mm toward the OLED/encoder (+Y) end**.
  Holes are at (±26.04, ±40.64 **+ 7.65**). The earlier v0.2 board placed the
  standoffs centred, so they missed every hole by ~7.6 mm and the two pads could
  not be mounted back-to-back — this is the v0.3 fix.
- **Panel posts** — `mp_post_sx,mp_post_sy` = ±38 × ±44, pushed *outboard* of the
  pocket/collar wall (which reaches 32.65) so a backplate can bolt to the panel
  clear of the board. A Ø7 post can't sit on the PCB-hole axis without fouling the
  board, so the two circles stay offset by ~12 mm (across) / ~3.4 mm (along).
  (Seen edge-on this reads as "posts offset from the MacroPad holes" — it's by
  design, not a bug.)

**Mounting board — v0.3 (NEW, replaces the two loose per-pad backplates).**
`macropad_mount_board()` is **one** printed plate spanning both pads (~213 × 88 ×
4 mm) that **bridges** the two bolt circles:
- 8 × Ø3.4 flush holes on the post circle → bolts **down** onto all 8 panel posts.
- 8 × Ø7 standoffs (8.4 mm tall, Ø3.4 thru) on the **offset** PCB circle → screw
  **up** into the two PCBs (board bottom at z = −19, top on the post tips at
  z = −15, standoffs reach the PCB back at z = −6.6). The standoffs carry the
  `+mp_hy_off` shift, so the OLED-end pair lands ~3.8 mm from the board end →
  plate widened to ±106.4 mm to support them.
- Validated by overlaying the standoff centres on the STL PCB cross-section:
  residual < 0.1 mm at all 4 holes.
- Single welded solid, `Simple: yes`. Print flat-side down / standoffs up, no
  supports. Exported STL: `Console10_macropad_pair_backplate.stl`.
- The older per-pad `macropad_backplate()` is kept in-file for reference only
  (note: it still uses the *centred* hole assumption and is superseded).

**Possible next steps (not open design questions):** USB-C end relief at the
widened ends, a central lightening cutout, and/or a keyed corner; first-article
fit check of standoff height vs PCB seat and the post screw engagement.

**v0.4 changes (2026-06-14):**
- **Front lip cut flush to the PCB edge on both axes** (`mp_face_w = mp_pocket_w`,
  `mp_face_h = mp_pocket_h`). The old 56 × 100 opening left a ~2 mm lip overhanging
  the outer key columns (blocked keycaps) and the OLED/encoder ends (blocked the
  display). No front lip now — retention is the rear mount board; the centre
  divider stub is gone so the two openings read as one.
- **Extended 2U → 3U** (`n_u = 3`, 133.35 mm). MacroPads pushed to the TOP
  (`mp_cy = plate_h − U` = 88.9) with a blank skirt below, so the rear mount-board
  assembly sits high and **clears the shelf/floor** when mounted below a 7" monitor
  (the 2U rear stack collided with the floor). Mount rows → 3U `[50.80, 127.00]`.
  Re-exported `Console10_macropad_pair_faceplate.stl`.

## 17. Screen + Slider + OLED + guarded-toggle faceplate — v0.1 (2026-06-14)

A 3U faceplate (`Console10_screen_slider_panel.scad`; `part = "panel" |
"hyperpixel_backplate"`) — derived from the DSKY concept (`Console10_dsky_panel.scad`)
with the MacroPad removed — carrying four device groups:

- **Pimoroni HyperPixel 4.0 Square** (720×720 touch) — recessed pocket + front
  window lip; 2-stem rear backplate (below).
- **Adafruit NeoSlider 5295** vertical fader — metal housing **9.4 × 75.1 mm**
  (measured; CAD STEP 9.5 × 75.0), **SQUARE** flush cutout so the rectangular
  housing seats flush to the panel face (top at z = plate_t), knob proud.
- **Adafruit 0.91" 128×32 OLED 4440** — recessed in a **module-sized pocket** (the
  display module is bigger than the active window) so the glass sits ~0.5 mm behind
  the front lip; 4-screw rear mount, active area centred on the hole pattern.
- **3 × guarded toggle switches** in a row below the screen — COROTC SPST (12 mm
  bushing) + the printable "Space Shuttle Toggle Switch Guard" (ImAThingsGuy, public
  domain, 25 × 25 × 30 mm). Panel has a 12.4 mm bushing hole + a **square recess**
  for the guard base (anti-rotation), guards oriented rings-vertical. Screen raised
  to the top to clear the toggle row.

**Component dims pulled from Adafruit STEP CAD** (`Adafruit_CAD_Parts` repo), parsed
directly: NeoSlider holes **38.1 × 16.51** (the earlier 70-along value was wrong and
would have missed the PCB holes), OLED holes 27.94 × 16.51, OLED active 22.384 × 5.584.

**HyperPixel backplate** (`part = "hyperpixel_backplate"`): per the board photo, only
the **2 HAT holes on the FPC edge are usable** (the GPIO header + ribbon block the
other 2), so it mounts on 2 stems and bolts to 4 panel posts; a **cable slot runs out
through the GPIO edge** (open U) for the 40-pin IDC + ribbon.

STLs: `Console10_screen_slider_panel.stl`, `Console10_screen_slider_hp_backplate.stl`.
The toggle guard prints from the downloaded `space-shuttle-switch-guard.stl`.

**Open items:** HyperPixel HAT-hole positions still `[verify]`; guard cap is glue-on
(no non-rotating press-fit); confirm the GPIO cable-exit edge.

## 14. Revision history

- **v2.0** — project reset
- **v2.1** — geometry locked (silhouette, isogrid)
- **v2.2** — slant moved to front; rails integrated into cheeks; finger joint at centerline
- **v2.3** — slant angle set to 30° for isogrid alignment
- **v2.4** — major simplification: cheek 6→10 mm; rail holes to cheek edge faces; backing strips removed; panels tray→flat-panel-with-tabs; cheek channels added; centerline castellation rectangular→trapezoidal 30° (Apollo 13 ref); tab protrusion 12→6 mm; centerline joinery → PLA solvent/glue dovetail (no screws/inserts)
- **v2.5** — isogrid pocket filter (whole-triangle, no clipped perimeter pockets)
- **v3.0** — **major architecture change**: abandoned the split-half + centerline dovetail; top & bottom are now **single-piece** panels sized to the 10" mini-rack width (~253 mm), printable as one part on a 255 mm bed; joinery changed to **rabbet-based** (bottom side-ridges into cheek bottom rabbets; cheek tops into a top-panel rabbet); **front insert** added as a slant wedge template (merge into bottom or glue); top/bottom/front are now standalone STL models, cheek remains SCAD-driven; deprecated the `*_panel_half.scad` files and cheek tab-channels
- **v3.1** — all parts re-authored as parametric OpenSCAD (top/bottom/front/cheek + module assembly); symmetric ridge joinery (top now matches the bottom: slab + side ridges into cheek top rabbets; cheek rabbeted on both edges); front insert spans between the cheeks; a top front-edge bevel was tried and reverted
- **v3.3** — top front bevel re-added (hull-built); M3 counterbored socket-cap mounts (top 3/side, bottom 4/side) into heat-set inserts in the cheek edges; tongue/groove equalized to 10/3 (~3.33 mm) all-equal/centered; isogrid moved to the exterior face, 5 mm deep, outer ring filled (`iso_edge_fill`)
