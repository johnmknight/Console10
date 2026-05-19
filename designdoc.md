# CONSOLE10 — DESIGN DOCUMENT

**Version 2.5**
**Date: 2026-05-17**

---

## v2.5 changelog (vs v2.4)

1. **Isogrid pocket filter** - pockets are only generated for triangles that fit entirely inside the cheek silhouette. Triangles the silhouette would clip are dropped, leaving solid cheek material along the perimeter. This replaces the previous full-coverage-with-clipping approach (which left half-pockets and slivers at the boundary).

## v2.4 changelog (vs v2.3)

1. **Cheek thickness** 6 → **10 mm** — depth for edge-drilled 10-32 inserts.
2. **Rail mount holes** moved from cheek interior face to cheek **edge faces** (slant + back). Axis perpendicular to the edge face.
3. **Solid backing strips** along slant + back removed; no longer needed.
4. **New channels** in cheek top + bottom edges, 4 mm deep × 6 mm tall, accepting panel tabs.
5. **Top + bottom panels** changed from tray-with-flanges to **flat panel with tabs**.
6. **Centerline castellation** changed from rectangular to **trapezoidal at 30° from vertical** (Apollo 13 command module flight console reference).
7. **Tab protrusion past centerline** 12 → **6 mm** — bound by geometric constraint that adjacent tab tips must not overlap at depth (`tab_protrude < seg_pitch · √3/2`); 6 mm leaves comfortable margin and matches panel thickness.
8. **Centerline joinery simplified**: no rabbet, no M3 screws, no heat-set inserts. Halves bond with PLA solvent/glue along the dovetail seam. Dovetail interlock + cheek-channel constraint + glue bond replace the prior screw mechanism.

---

## 1. What we're building

Console10 is a modular 10-inch mini-rack housing for desktop equipment, 3D-printed in PLA. Each module is six parts: two trapezoidal cheek panels, a top panel (split L/R for bed-fit), and a bottom panel (split L/R). The front (slant) and back faces are open equipment-mounting planes — 1U faceplates are installed by the user.

The panel halves are joined at the centerline with PLA solvent/glue along a trapezoidal dovetail castellation. Rack equipment mounts to the cheek edge faces via 10-32 heat-set inserts.

Visual reference: Apollo-era NASA mission control hardware; centerline castellation derived from the Apollo 13 command module flight console.

---

## 2. Standards compliance

- **Mounting standard**: EIA-310-D 10-inch mini-rack
- **1U height**: 44.45 mm
- **Per-U hole pattern**: 3 holes at offsets 6.35, 22.225, 38.10 mm
- **Capacity**: 4U (C4 variant — v2.4 specifies C4 only)

---

## 3. Module architecture

### 3.1 Parts list (6 parts per module)

| Part | Count | Role |
|------|-------|------|
| Cheek | 2 | Side panel, trapezoidal, 10 mm thick |
| Top panel half | 2 | L + R halves joined at centerline by trapezoidal dovetail castellation + glue |
| Bottom panel half | 2 | L + R halves; same joinery as top |

No separate rails; no separate backing strips. Rail-mount holes are integral to each cheek's edge faces.

### 3.2 Material

Default: **PLA** (required for solvent/cement bonding at the centerline seam). PETG and ASA acceptable for the cheeks but the panel halves should be PLA so the solvent works. ABS not recommended (warping on large flat parts).

### 3.3 Hardware BOM (per module)

| Item | Count | Use |
|------|-------|-----|
| 10-32 brass heat-set inserts | 48 | Equipment mounting (24 per cheek: 12 slant + 12 back) |
| PLA solvent / cement (dichloromethane or 3D Gloop, etc.) | as required | Centerline glue bond on top + bottom panels |

---

## 4. Cheek

### 4.1 Silhouette (LOCKED, unchanged from v2.3)

Right trapezoid, slant on the **front** edge.

| Edge | Length (mm) |
|------|-------------|
| Bottom | 228.6 |
| Back (vertical) | 205.45 |
| Top | 109.975 |
| Slant (front) | 237.25 |
| Slant angle | 30° from vertical (isogrid-aligned) |

### 4.2 Thickness — 10 mm (v2.4 change from 6 mm)

Increased to host ~8 mm-deep edge-drilled 10-32 inserts with adequate wall material around each insert.

### 4.3 Isogrid

- Tiling: {3, 6} triangular
- Spacing: 20 mm
- Rib width: 2.5 mm
- Pocket depth: 1.8 mm (or through-cut)
- Fillet radius: 1.59 mm
- Coverage: **whole-triangle filter** - a pocket is generated only when all three triangle vertices fall inside the silhouette. Partial/clipped triangles at the perimeter are filled (left as solid cheek material)

---

## 5. Equipment mounting (cheek edges)

Rack equipment mounts via flanged rack ears that bolt directly to the cheek **edge face**. Bolts pass perpendicular to the edge into heat-set inserts embedded in the cheek thickness. The cheek edge IS the mounting surface — no separate rail plate.

### 5.1 Slant edge rail

- 12 × 10-32 heat-set insert holes
- Hole axis perpendicular to slant face (in the cheek silhouette plane)
- EIA-310 pattern, 4U capacity, 1U bottom gap, 15 mm top margin

Slant positions (mm along slant from front-bottom corner):
```
50.80, 66.675, 82.55, 95.25, 111.125, 127.00,
139.70, 155.575, 171.45, 184.15, 200.025, 215.90
```

- Hole diameter: 4.2 mm (10-32 pilot)
- Hole depth: 8 mm into cheek thickness

### 5.2 Back edge rail

- 12 × 10-32 heat-set insert holes
- Hole axis perpendicular to back face (horizontal, in cheek silhouette plane)
- EIA-310 pattern, 4U capacity from floor

Back positions (mm from floor along back edge):
```
6.35, 22.225, 38.10, 50.80, 66.675, 82.55,
95.25, 111.125, 127.00, 139.70, 155.575, 171.45
```

- Same hole diameter and depth as slant.

---

## 6. Cheek top + bottom panel channels

Channels cut into the cheek **interior face** along the top and bottom edges, accepting the panel tabs (§7.3).

### 6.1 Top channel
- Depth into cheek thickness: 4 mm
- Height (along top edge direction): 6 mm
- Length: 109.975 mm (full top edge)

### 6.2 Bottom channel
- Depth: 4 mm
- Height: 6 mm
- Length: 228.6 mm (full bottom edge)

---

## 7. Top + bottom panels

### 7.1 Architecture (v2.4: flat panel with tabs)

Each panel is a flat 6 mm sheet with a 4 mm tab extending outward at each cheek-facing end. The main panel body sits between the cheeks; the tabs slide into the cheek channels (§6). No flanges, no tray cavity.

### 7.2 Top panel dimensions

| Dimension | Value |
|-----------|-------|
| Depth (front-back) | 109.975 mm |
| Width (cheek-tab to cheek-tab) | 269.525 mm |
| Width (between cheek interior faces) | 261.525 mm |
| Thickness | 6 mm |
| Tab length (each side) | 4 mm |

### 7.3 Bottom panel dimensions

| Dimension | Value |
|-----------|-------|
| Depth (front-back) | 228.6 mm |
| Width | 269.525 mm |
| Thickness | 6 mm |
| Tab length | 4 mm |

### 7.4 Bed-fit split

Total panel width 269.525 mm exceeds the 256 mm Bambu A1/P1/X1 bed limit. Each panel splits L + R at the centerline, joined per §8.

Per-half footprints:
- Top panel half: ~140.76 × 109.975 mm
- Bottom panel half: ~140.76 × 228.6 mm

Both fit on a 256 mm bed.

---

## 8. Centerline joint (top + bottom panels)

### 8.1 Trapezoidal dovetail castellation

- Wedge angle: **30° from vertical** (Apollo 13 command module flight console reference)
- Tab protrusion past centerline: **6 mm**
- Tab tip wider than base → positive in-plane mechanical lock (dovetail). The two halves engage by sliding along the seam axis (x), not by pressing edge-to-edge.

### 8.2 Top panel castellation
- 9 segments: LEFT half has 5 tabs + 4 slots (T-S-T-S-T-S-T-S-T); RIGHT half mirrors (4 tabs + 5 slots).
- Segment pitch: 109.975 / 9 = **12.2194 mm**
- Tab base width (at y=0, centerline): seg_pitch = **12.219 mm** — fills full segment.
- Tab tip width (at y=±protrude): seg_pitch + 2·protrude·tan(30°) = **19.147 mm** — flares 3.464 mm per side.

### 8.3 Bottom panel castellation
- 17 segments: LEFT half has 9 tabs + 8 slots; RIGHT half mirrors (8 tabs + 9 slots).
- Segment pitch: 228.6 / 17 = **13.4471 mm**
- Tab base width: **13.447 mm**
- Tab tip width: **20.375 mm**

### 8.4 Assembly

1. Print both halves flat on the bed.
2. Apply PLA solvent or cement to the matching dovetail faces of LEFT and RIGHT.
3. Slide RIGHT into LEFT along the seam axis (x direction) — the dovetail does not allow edge-on insertion in y; it must slide in from one end.
4. Hold for solvent set time.
5. Install in module: panel halves slide into cheek top/bottom channels (§6) before the cheeks are placed at final position, or after if the assembly procedure allows.

### 8.5 Structural mechanism

The joint resists separation through three independent constraints:
- **Y-axis (pull-apart)**: dovetail tip > base; cannot pull straight out.
- **X-axis (slide-out)**: cheek channels at panel ends clamp the panel halves along the depth direction.
- **Z-axis (lift-off)**: solvent bond covers the full dovetail contact area.

No metal hardware is required at the centerline.

---

## 9. Manufacturing

### 9.1 Print bed
256 × 256 × 256 mm (Bambu A1, P1, X1 class).

### 9.2 Fit on bed

| Part | Footprint (mm) | Thickness | Fits |
|------|----------------|-----------|------|
| Cheek | 228.6 × 205.45 | 10 mm | ✓ |
| Top panel half | ~140.76 × 109.975 | 6 mm | ✓ |
| Bottom panel half | ~140.76 × 228.6 | 6 mm | ✓ |

### 9.3 Print orientation
- **Cheek**: flat on bed, exterior face down. Isogrid pockets face up (no overhang).
- **Top + bottom panel halves**: flat on bed, either face down. The panel-thickness geometry is symmetric across the midplane (no rabbet, no countersinks).

### 9.4 Suggested print settings (PLA)
- Layer height: 0.2 mm
- Infill: 25–40 %
- Walls: 3–4 perimeters
- Supports: none required for the orientations above
- Solvent bond: clean dovetail faces with isopropyl before glue application.

---

## 10. Module exterior dimensions

| Dimension | Value (mm) |
|-----------|-----------|
| Width (cheek-outside to cheek-outside) | 281.525 |
| Depth (bottom front-to-back) | 228.6 |
| Height (back edge) | 205.45 |
| Slant length | 237.25 |
| Top edge length | 109.975 |

---

## 11. Variants

| Variant | Description | Status |
|---------|-------------|--------|
| **C4** | 4U, standard | v2.4 (current) |
| C2 | 2U (shorter) | future |
| C6 | 6U (taller) | future |
| C4-E | C4 with sci-fi etching | deferred |

---

## 12. SCAD files

| File | Status |
|------|--------|
| `designdoc.md` (this file) | ✓ v2.4 |
| `README.md` | ✓ v2.4 inventory |
| `Console10_isogrid.scad` (cheek) | ✓ v2.4 |
| `Console10_top_panel_half.scad` | ✓ v2.4 |
| `Console10_bottom_panel_half.scad` | ✓ v2.4 |
| `Console10_module.scad` (assembly) | ⏳ pending |

---

## 13. Open items

- First-print fit validation: dovetail slide-engagement clearance (may need 0.1–0.2 mm tolerance on slot dimensions)
- Friction-fit tolerance at panel tabs ↔ cheek channels
- PLA solvent selection (test dichloromethane vs commercial 3D Gloop vs Tamiya cement)
- Sci-fi etching variant (C4-E) — deferred

---

## 14. Revision history

- **v2.0** — project reset
- **v2.1** — geometry locked (silhouette, isogrid)
- **v2.2** — slant moved to front; rails integrated into cheeks; finger joint at centerline
- **v2.3** — slant angle set to 30° for isogrid alignment
- **v2.4** — major architectural simplification:
  1. Cheek thickness 6 → 10 mm
  2. Rail holes relocated to cheek edge faces (slant + back)
  3. Solid backing strips removed
  4. Top + bottom panels: tray-with-flanges → flat-panel-with-tabs
  5. Channels added to cheek top + bottom edges
  6. Centerline castellation: rectangular → trapezoidal at 30° (Apollo 13 reference)
  7. Tab protrusion 12 → 6 mm
  8. Centerline joinery simplified: no rabbet, no M3 screws, no inserts — PLA solvent/glue bond along the dovetail seam
- **v2.5** - isogrid pocket filter: pockets only where the full triangle fits inside the cheek silhouette (no clipped/partial pockets along the perimeter)
