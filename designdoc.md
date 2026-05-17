# CONSOLE10 — DESIGN DOCUMENT
*Version 2.3 — Slant angle aligned to isogrid.*
*Prepared for John M. Knight, 2026-05-17.*

> v2.0 reset the project. v2.1 locked initial geometry. v2.2 corrects the cheek-silhouette orientation, locks rail offsets and supports, integrates rails into cheeks, and locks construction & assembly for a 256 × 256 × 256 mm printer bed. v2.3 adjusts the slant angle from atan(0.5) = 26.57° to atan(√3/3) = 30° from vertical so the slant edge runs parallel to one set of {3,6} isogrid triangle edges; back height and top length update accordingly. v2.3 adjusts the slant angle from atan(0.5) = 26.57° to atan(√3/3) = 30° from vertical so the slant edge runs parallel to one set of {3,6} isogrid triangle edges; back height and top length update accordingly.

---

## 1. What we're building

**Console10** is a modular, desktop-sized housing system for **10" mini-rack** equipment, styled after NASA Mission Operations Control Room (MOCR) consoles.

A Console10 *module* is a single self-contained enclosure that:

- conforms to the 10" mini-rack standard (Geerling / Project MINI RACK) so compatible rack-mount equipment can drop in
- houses homelab / streamer gear (routers, Stream Decks, mini PCs, mini displays, PoE devices, Pi mounts)
- presents an aerospace-inspired aesthetic — slanted **front panel**, side cheeks with isogrid / etched detail, castellated panel-half seams (Apollo-style)
- aligns side-by-side with other Console10 modules to span a desk

The trapezoidal silhouette intentionally limits compatibility — not all 10" mini-rack equipment will fit. Console10 is a reuse of the 10" mini-rack standard for small-form-factor gear, not full compatibility.

## 2. Standards compliance — 10" mini-rack

| Spec | Value |
|------|-------|
| 1U height | **44.45 mm** (1.75") |
| Mounting hole spacing (rail-to-rail) | **236.525 mm** (9.312") |
| Vertical hole pattern within a U | EIA-310: 6.35 / 22.225 / 38.10 mm from U bottom |
| Equipment-mounting threads | **10-32** (DeskPi convention) |

Console10 follows EIA-310 hole spacing **along the slant** for the front rail (equipment is tilted to match the slant) and **vertically** for the back rail.

## 3. Module architecture

### 3.1 Parts list (per module — 6 printed parts)

| Part | Count | Role |
|------|-------|------|
| Cheek | 2 | Side panel with integrated isogrid + integrated front-rail and back-rail hole patterns |
| Top panel half | 2 | L/R halves of the slanted-top "tray" with integrated front/back/side flanges |
| Bottom panel half | 2 | L/R halves of the bottom "tray" with integrated front/back/side flanges |

No separate rail parts (front or back) — both rails are absorbed into the cheek. No separate top/bottom support beams — both are absorbed into the panel flanges.

### 3.2 Material

Every Console10 part is **3D-printed plastic**. No metal frame components, no off-the-shelf rails. Full material consistency for aesthetic and manufacturing simplicity.

### 3.3 Fastener standard

- **M3 with brass heat-set inserts** for all *internal* Console10 assembly (top/bottom panel halves to cheeks; finger-joint seam reinforcement)
- **10-32 heat-set inserts** in the cheek interior face for *equipment mounting* (24 per cheek — 12 front-rail positions + 12 back-rail positions)

No visible fasteners on cheek or top exterior surfaces.

## 4. Cheek silhouette (LOCKED)

**Right trapezoid**, oriented with the slant on the FRONT (operator-facing). The slanted edge IS the equipment-mounting face for front-rail gear. Equipment tilts to match the slant.

| Vertex | (x, y) mm | Position |
|--------|-----------|----------|
| Front-bottom | (0, 0) | Floor / front lower corner |
| Back-bottom | (228.6, 0) | Floor / back lower corner |
| Back-top | (228.6, 205.45) | Back upper corner |
| Front-top | (118.625, 205.45) | Front upper corner — top end of slant |

### 4.1 Edge lengths

| Edge | Length | Notes |
|------|--------|-------|
| Bottom | **228.6 mm** (9") | **LOCKED** — pinned dimension |
| Back (vertical) | **205.45 mm** (8.09") | Derived |
| Top (horizontal) | **109.975 mm** (4.33") | Derived |
| Front (slant) | **237.25 mm** | Derived |

### 4.2 Locked invariants

- **Slant angle = 30° from vertical** (= atan(√3/3)) — **LOCKED** — aligned to {3,6} isogrid triangle edges
- **Bottom depth = 228.6 mm** — **LOCKED**
- **1U bottom gap** (no rail holes in the bottom 1U region of the slant) — **LOCKED** structural requirement
- **4U front-rail mounting** — **MINIMUM** target capacity (always exactly 4U in current geometry)
- **Top + bottom margins** — flexible parametrically; in current v2.2 lock, top margin = 15 mm, bottom margin = the 1U gap exactly

These five locks reduce the cheek to a single degree of freedom (front_len, which then derives back and top). The v2.3 lock picks `slant_angle = 30°` and `top_margin = 15 mm` → `front_len = 237.25 mm` → back_h = 205.45 mm, top_len = 109.975 mm.

### 4.3 Cheek thickness & isogrid

| Spec | Value |
|------|-------|
| Cheek base thickness | ~5 mm (sufficient for 10-32 heat-set insert depth) |
| Isogrid pattern | Regular triangular tiling `{3,6}` |
| Rib width | 2.5 mm |
| Pocket depth (or through-cut) | 1.8 mm |
| Cell spacing | 20 mm |
| Solid nodes | At every 6-rib intersection |

**Local solid backing strips** suppress the isogrid pockets in the rail regions (along the slant 4U band and along the back-vertical 4U band), so heat-set inserts bear on continuous material rather than thin ribs.

## 5. Front rail — integrated into cheek

The cheek absorbs the front rail entirely. No separate rail part.

### 5.1 Hole layout along the slant

Slant length = 237.25 mm, allocated as:

| Region | Slant range (mm) | Length | Notes |
|--------|------------------|--------|-------|
| Bottom gap | 0 → 44.45 | 44.45 mm (1U) | No holes — floor-cutoff zone |
| 4U mounting | 44.45 → 222.25 | 177.8 mm (4U) | EIA-310 hole pattern |
| Top margin | 222.25 → 237.25 | 15 mm | No holes — reserved for top support |

### 5.2 Front-rail hole positions (per cheek)

12 × 10-32 heat-set inserts at the following slant positions (measured from front-bottom corner along the slant), 3 holes per U:

| U slot | Slant pos 1 | Slant pos 2 | Slant pos 3 |
|--------|-------------|-------------|-------------|
| U1 | 50.80 | 66.68 | 82.55 |
| U2 | 95.25 | 111.13 | 127.00 |
| U3 | 139.70 | 155.58 | 171.45 |
| U4 | 184.15 | 200.03 | 215.90 |

All values in mm along the slant.

### 5.3 Insert axis

Heat-set inserts are installed **perpendicular to the cheek interior face** (i.e., in the module-width direction). Equipment mounts via 10-32 screws threaded into the inserts; screws are perpendicular to the cheek face. Equipment side flanges (rack ears) lie flat against the cheek interior face with bolt holes at the corresponding slant positions.

### 5.4 Front-mount equipment depth (perpendicular to slant)

| U slot | Max depth | Binding |
|--------|-----------|---------|
| U1 | 77.0 mm (3.03") | Floor at U1 bottom |
| U2 | 154.0 mm (6.06") | Floor at U2 bottom |
| U3 | 161.3 mm (6.35") | Back face at U3 top |
| U4 | 135.7 mm (5.34") | Back face at U4 top |

Depth measured perpendicular to the slanted front face, assuming rigid rectangular gear with body perpendicular to its mounting face.

## 6. Back rail — integrated into cheek

The cheek also absorbs the back rail. No separate rail part.

### 6.1 Hole layout along the back vertical edge

Back edge length = 205.45 mm. Back rail is 4U starting at the floor (no bottom offset — floor cutoff is not an issue on a vertical edge).

| Region | Vertical range (mm) | Length | Notes |
|--------|---------------------|--------|-------|
| 4U mounting | 0 → 177.80 | 177.80 mm (4U) | EIA-310 hole pattern |
| Top stub | 177.80 → 205.45 | 27.65 mm | Unused (slant geometry) |

### 6.2 Back-rail hole positions (per cheek)

12 × 10-32 heat-set inserts at the following vertical positions (measured from floor):

| U slot | Vertical pos 1 | Vertical pos 2 | Vertical pos 3 |
|--------|----------------|----------------|----------------|
| U1 | 6.35 | 22.23 | 38.10 |
| U2 | 50.80 | 66.68 | 82.55 |
| U3 | 95.25 | 111.13 | 127.00 |
| U4 | 139.70 | 155.58 | 171.45 |

### 6.3 Rear-mount equipment depth (horizontal)

| U slot | Max depth | Notes |
|--------|-----------|-------|
| U1 | 202.9 mm (7.99") | Bottom — deepest |
| U2 | 177.3 mm (6.98") | |
| U3 | 151.6 mm (5.97") | |
| U4 | 125.9 mm (4.96") | Top — clipped by slant |

## 7. Top + bottom supports — integrated into panels

### 7.1 Top support

Triangular cross-section in side view, fills the 15 mm top margin region of the slant. Hypotenuse along the slant, right angle at the cheek-interior corner. Legs: 7.50 mm horizontal × 12.99 mm vertical (= 15 × sin/cos 30°).

In the v2.2 lock, this support is **integrated as the front flange of the top panel** — the panel's front edge has a downward-extending triangular flange that fills the top margin region and joins both cheeks.

### 7.2 Bottom support

Right triangle fills the 1U bottom gap. Cross-section legs: 22.225 mm horizontal × 38.494 mm vertical, with hypotenuse along the slant.

Integrated as the **front flange of the bottom panel** — the panel's front edge has an upward-extending triangular flange that fills the 1U gap and joins both cheeks.

### 7.3 Why integrated

Eliminates two separate support parts (4 fewer SCAD files, 4 fewer printed pieces, 4 fewer assembly steps). The top and bottom panels become *trays* with integrated stiffeners on all four edges.

## 8. Top + bottom panels — construction

### 8.1 Panel dimensions

| Panel | Depth (front-back) | Width (cheek-to-cheek) |
|-------|--------------------|------------------------|
| Top panel | 109.975 mm | 261.525 mm |
| Bottom panel | 228.6 mm | 261.525 mm |

**Interior width = 261.525 mm**, derived from: rail hole spacing (236.525 mm) + rail width (25 mm). Pinned by the 10" mini-rack standard.

### 8.2 Tray architecture

Each panel is an open-bottomed (top) or open-topped (bottom) **shallow tray** with flanges on all four perimeter edges:

- **Front flange** — triangular cross-section matching the support geometry of §7
- **Back flange** — rectangular, 15 mm deep
- **Left flange** — rectangular, 15 mm deep, engages left cheek interior face
- **Right flange** — rectangular, 15 mm deep, engages right cheek interior face

Heat-set M3 inserts in the left and right flanges (count and exact position TBD when laying out the SCAD) attach the panel to the cheek.

### 8.3 Forced split — left/right halves

Both panels exceed the 256 mm printer bed in the cheek-to-cheek dimension (261.525 mm). They must split into halves. Front-back split would still overflow for the top panel (261.5 > 256), so **left/right split is the only viable scheme** for both panels.

Each half = ~130.76 mm wide × full depth × full flange height.

- Top half: 130.76 × 109.975 × 15 mm (with triangular front flange) → fits 256 bed
- Bottom half: 130.76 × 228.6 × 15 mm (with triangular front flange) → fits 256 bed

Each half inherits the front + back + ONE side flange (left or right). The centerline mating edge has no flange.

### 8.4 Centerline seam — castellated finger joint (Apollo-style)

Apollo command-module-panel-style castellated edge — alternating tabs and slots interlock for shear strength and self-alignment. The two halves mate at the centerline with a finger pattern, and the pattern continues *through* the front and back flanges where they cross the centerline (giving the seam shear strength in all three planes).

#### Top panel seam

| Param | Value |
|-------|-------|
| Pattern | 5 tabs + 4 slots (T-S-T-S-T-S-T-S-T, symmetric) |
| Segment count | 9 |
| Segment width | 12.22 mm (109.975 mm ÷ 9) |
| Tab protrusion past centerline | 12 mm |
| Tab orientation | Left half has 5 tabs; right half has 4 tabs (mirror, interlocking) |

#### Bottom panel seam

| Param | Value |
|-------|-------|
| Pattern | 9 tabs + 8 slots (symmetric, starts/ends with tab) |
| Segment count | 17 |
| Segment width | 13.45 mm (228.6 mm ÷ 17) |
| Tab protrusion past centerline | 12 mm |

(Bottom panel uses more tabs because its depth is ~1.87× the top panel's depth.)

### 8.5 Seam reinforcement

4 × M3 screws per seam (one at each corner of the assembled tray) tie the two halves together. The finger joint provides shear stiffness; the screws provide tensile clamp.

## 9. Manufacturing — printer bed

| Spec | Value |
|------|-------|
| Target bed dimensions | **256 × 256 × 256 mm** (Bambu A1 / P1 / X1 class) |

### 9.1 Fit-on-bed status (per part)

| Part | Footprint | Fits | Notes |
|------|-----------|------|-------|
| Cheek | 228.6 × 205.45 × ~5 mm + isogrid features | ✓ | Prints flat; longest dim 228.6 mm |
| Top panel half | 130.76 × 109.975 × 15 mm | ✓ | Prints with flat side on bed, flanges up |
| Bottom panel half | 130.76 × 228.6 × 15 mm | ✓ | Same as top, deeper |

### 9.2 Print orientation

- **Cheek**: lays flat on the bed, exterior face down (smooth visible surface), rail-region material features up. Heat-set inserts installed from the up-facing (interior) side after printing.
- **Panel halves**: flat panel surface down on bed (becomes the visible exterior of the tray top or bottom), flanges extending up. Heat-set inserts installed from the up-facing side.

## 10. Module exterior dimensions

| Dimension | Value | Notes |
|-----------|-------|-------|
| Width (cheek-to-cheek, with 5 mm cheeks) | ~271.5 mm | 261.525 interior + 2 × 5 mm cheek |
| Depth (bottom edge) | 228.6 mm (9") | Same as cheek |
| Height (back) | 205.45 mm (8.09") | Same as cheek back edge |
| Height (front, top of slant) | 205.45 mm | Front-top corner is at the same y as back-top |
| Front face height (along slant) | 237.25 mm | Length of slanted face |
| Front face angle from vertical | 30° | Operator-facing slant, aligned to isogrid |

## 11. Variants (preserved from v2.1)

### 11.1 Cheek variants

| ID | Name | Description |
|----|------|-------------|
| **C1** | Solid | Plain closed panel, no surface or through-cut detail |
| **C2** | Open isogrid | Triangular isogrid pattern, through-cut or deep recess (default) |
| **C3** | Closed, isogrid etched | Solid panel with isogrid pattern surface-etched (decorative only) |
| **C4** | Closed, sci-fi etched | Solid panel with engraved sci-fi greeble / instrumentation pattern (*pattern reference TBD*) |

### 11.2 Top variants

| ID | Name | Description |
|----|------|-------------|
| **T1** | Plain | Solid horizontal top panel, no surface detail |
| **T2** | Sci-fi etched | Solid with engraved sci-fi pattern matching C4 visual language |

### 11.3 Bottom

Plain solid, single variant.

## 12. Hardware BOM — per module

| Item | Count | Use |
|------|-------|-----|
| 10-32 brass heat-set inserts | 48 | Equipment mounting (24 per cheek × 2 cheeks) |
| M3 brass heat-set inserts | ~16-24 (TBD) | Panel-to-cheek attachment |
| M3 screws (for finger-joint seam corners) | 8 | 4 per panel × 2 panels |
| M3 screws (for panel-to-cheek) | ~16-24 (TBD) | Matches insert count above |

Exact M3 counts pinned when SCAD layout is final.

## 13. SCAD files

| File | Status (v2.2) |
|------|--------------|
| `Console10_isogrid.scad` (cheek) | **Rebuild required** — new silhouette + integrated rail hole patterns + solid backing strips |
| `Console10_rail.scad` | **DELETE** — no longer needed (rails integrated into cheek) |
| `Console10_top_panel_half.scad` | **NEW** — tray with finger-joint seam + integrated triangular front flange + rectangular back/side flanges |
| `Console10_bottom_panel_half.scad` | **NEW** — same architecture as top, deeper, more fingers |
| `Console10_module.scad` | **Rebuild** — assembles all 6 parts |

## 14. Open items (deferred, not blocking)

1. **Sci-fi etching reference imagery** — needed only for C4 / T2 variants
2. **Filament selection** — PETG default for indoor use; ABS/ASA if heat resistance matters
3. **Finish/color** — natural filament or post-print finish
4. **Heat-set insert specs** — defaulting to standard brass M3 × 5 mm and 10-32 × 6 mm
5. **Custom equipment rack-ear pattern** — Console10 equipment uses custom rack ears (holes at slant positions for front rail; vertical positions for back rail). Standard EIA-310 equipment will NOT fit the front rail because rack-ear holes are vertically spaced rather than slant-spaced. Define a Console10 equipment rack-ear template at some later point.
6. **Exact M3 insert count and position** — pinned during SCAD layout
7. **Cheek thickness final value** — currently ~5 mm; pin when validating heat-set insert depth on first print

## 15. Appendix

### 15.1 Terminology

- **Cheek** — side panel of a module (left or right)
- **Tray** — top or bottom panel with integrated perimeter flanges
- **Flange** — perimeter rib on a panel edge (front/back/left/right)
- **Castellated seam** — alternating tab/slot finger joint at the panel centerline
- **U** — rack unit; 1U = 44.45 mm
- **MOCR** — Mission Operations Control Room (Apollo era)
- **Isogrid** — triangular-rib structural pattern
- **Heat-set insert** — brass threaded insert pressed into 3D-printed plastic with heat
- **C1–C4, T1, T2** — variant IDs

### 15.2 Revision history

- **v1.0 – v1.3** — Speculative cheek panel design before the project was formalized
- **v2.0** — Project reset. Captured the actual project: modular desktop 10" mini-rack housing with MOCR-inspired aesthetics
- **v2.1** — All v2.0 open questions resolved (silhouette, modularity, top deck, mounting, removability, material, rail source, hole pattern)
- **v2.2** — Major rework:
  1. **Cheek silhouette flipped** — slant is now on the FRONT (operator-facing), not the TOP. Front rail mounts equipment on the slant. (Previously v2.1 had the slant on the top deck — geometrically the same trapezoid but the rail was on the wrong face.)
  2. **New cheek dimensions** — 228.6 × 212.2 × 122.5 mm at 26.57° from vertical (= atan(0.5)); front_len 237.25 mm
  3. **1U bottom gap locked** on the front rail — eliminates the unusable bottom slot where the floor cuts off perpendicular equipment depth
  4. **Top margin = 15 mm locked** — reserves room for an integrated top support
  5. **4U front-rail capacity** (was 1U) and **4U back-rail capacity** (was 3U) — major capacity increase
  6. **Top + bottom supports designed** as triangular fillets, integrated as front flanges of the top/bottom panels
  7. **Front rails integrated into cheeks** — no separate rail part; the cheek's slant region carries the 10-32 insert pattern directly
  8. **Back rails integrated into cheeks** — same approach for the back-vertical edge
  9. **Top + bottom panels split into L/R halves** — forced by 261.5 mm interior width vs 256 mm printer bed
  10. **Castellated finger joint at panel centerlines** — Apollo command-module style; 5 tabs + 4 slots on top panel, 9 tabs + 8 slots on bottom panel
  11. **Part count down to 6 per module** (from 10 in v2.1)
- **v2.3** — Slant angle aligned to isogrid:
  1. **Slant angle 26.57° → 30° from vertical** (= atan(√3/3); rise:run = √3:1). The new angle places the slant exactly parallel to one set of {3,6} isogrid triangle edges, eliminating the 3.43° visual delta between slant and isogrid present in v2.2.
  2. **Cascading dimension updates**: back_h 212.20 → 205.45 mm, top_len 122.50 → 109.975 mm. Equipment-depth tables (§5.4, §6.3), bottom support legs (§7.2), top support legs (§7.1), top panel depth (§8.1, §8.3), and top panel finger-joint segment width (§8.4) all recalculated.
  3. **Bottom edge** stays aligned with the 0° isogrid edge set (was already aligned in v2.2). **Back vertical edge** remains the only un-aligned cheek edge — geometrically unavoidable for any 60°-symmetric isogrid pattern with a horizontal floor.
  4. **No standards changes** — 10" mini-rack compliance, EIA-310 hole pattern, 1U bottom gap, 4U mounting, 15 mm top margin, 256 mm bed all preserved.

### 15.3 References

- Project MINI RACK — https://mini-rack.jeffgeerling.com
- 10" mini-rack standard discussion — https://github.com/geerlingguy/mini-rack
- EIA-310-D rack standard (vertical hole pattern)
- DeskPi 3DPrint-Models — https://github.com/DeskPi-Team/3DPrint-Models (referenced for hardware conventions only; sled architecture NOT adopted)
- Apollo command module Panel 18 — castellated edge pattern inspiration for the centerline finger joint
