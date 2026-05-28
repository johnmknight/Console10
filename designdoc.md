# CONSOLE10 — DESIGN DOCUMENT

**Version 3.1**
**Date: 2026-05-28**

---

## v3.1 changelog (vs v3.0)

1. **All parts are now parametric OpenSCAD**: `Console10_top.scad`, `Console10_bottom.scad`, `Console10_front_insert.scad` (reverse-engineered from the NASA STL models), plus the existing cheek `Console10_isogrid.scad` and an assembly `Console10_module.scad`.
2. **Symmetric ridge joinery**: the TOP now uses the SAME joinery as the bottom — a slab with two side ridges that seat into rabbets in the cheek **top** edge. The v3.0 top "wall + slot" scheme is dropped. The cheek now has a rabbet on **both** the top and bottom edges.
3. **Front insert** now spans BETWEEN the cheeks (~232.6 mm), sitting on the floor at the front, with its 30° face flush with the slant (was modeled as a slant-length wedge).
4. A 30° bevel on the top's front edge was tried and **reverted** — the top front stays square for now.

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

- Tiling: {3, 6} triangular · Spacing: 20 mm · Rib: 2.5 mm · Pocket depth: 1.8 mm (or through-cut) · Fillet: 1.59 mm
- Coverage: **whole-triangle filter** — a pocket is generated only when all three triangle vertices fall inside the silhouette; clipped perimeter triangles are left solid.

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
- **Cheek**: flat on bed, exterior face down, isogrid pockets up (no overhang).
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

## 14. Revision history

- **v2.0** — project reset
- **v2.1** — geometry locked (silhouette, isogrid)
- **v2.2** — slant moved to front; rails integrated into cheeks; finger joint at centerline
- **v2.3** — slant angle set to 30° for isogrid alignment
- **v2.4** — major simplification: cheek 6→10 mm; rail holes to cheek edge faces; backing strips removed; panels tray→flat-panel-with-tabs; cheek channels added; centerline castellation rectangular→trapezoidal 30° (Apollo 13 ref); tab protrusion 12→6 mm; centerline joinery → PLA solvent/glue dovetail (no screws/inserts)
- **v2.5** — isogrid pocket filter (whole-triangle, no clipped perimeter pockets)
- **v3.0** — **major architecture change**: abandoned the split-half + centerline dovetail; top & bottom are now **single-piece** panels sized to the 10" mini-rack width (~253 mm), printable as one part on a 255 mm bed; joinery changed to **rabbet-based** (bottom side-ridges into cheek bottom rabbets; cheek tops into a top-panel rabbet); **front insert** added as a slant wedge template (merge into bottom or glue); top/bottom/front are now standalone STL models, cheek remains SCAD-driven; deprecated the `*_panel_half.scad` files and cheek tab-channels
- **v3.1** — all parts re-authored as parametric OpenSCAD (top/bottom/front/cheek + module assembly); symmetric ridge joinery (top now matches the bottom: slab + side ridges into cheek top rabbets; cheek rabbeted on both edges); front insert spans between the cheeks; a top front-edge bevel was tried and reverted
