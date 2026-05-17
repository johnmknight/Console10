# Console10

Modular desktop **10" mini-rack housing system**, styled after NASA Mission Operations Control Room consoles. Each module is a self-contained 3D-printed plastic enclosure that houses small-form-factor 10" mini-rack equipment (Pi mounts, small routers, Stream Decks, mini displays).

See `designdoc.md` (**v2.3**) for the full design specification.

## Repository layout

```
Console10/
├── designdoc.md                       Design Document v2.3
├── README.md                          This file
│
├── Console10_isogrid.scad             CHEEK — integrated front + back rail hole patterns
├── Console10_top_panel_half.scad      TOP TRAY half (L/R mirror via parameter) — TBD
├── Console10_bottom_panel_half.scad   BOTTOM TRAY half (L/R mirror via parameter) — TBD
├── Console10_module.scad              Full module assembly (6 parts in position) — TBD
│
└── preview/                           Rendered previews (refreshed on each SCAD change)
    ├── cheek_top.png                  Orthographic top-down view of cheek
    ├── cheek_iso.png                  Isometric perspective of cheek
    └── module_render.png              3D perspective of assembled module — TBD
```

**Status (v2.3):**

| File | Status |
|------|--------|
| `designdoc.md` | ✓ v2.3 — slant aligned to {3,6} isogrid |
| `Console10_isogrid.scad` | ✓ v2.3 cheek — slant aligned to isogrid, integrated rails, perimeter strip, 6 mm thickness |
| `Console10_top_panel_half.scad` | ⏳ pending |
| `Console10_bottom_panel_half.scad` | ⏳ pending |
| `Console10_module.scad` | ⏳ pending (assembly file) |
| `Console10_rail.scad` | ✗ DELETED in v2.2 (rails are absorbed into cheek) |

## Standards locked

- **10" mini-rack** compatible (Geerling / Project MINI RACK):
  - 1U = 44.45 mm
  - Hole spacing = 236.525 mm (rail-to-rail)
  - EIA-310 vertical hole pattern within each U
- **Equipment-mounting hardware**: 10-32 heat-set inserts (DeskPi convention)
- **Internal assembly hardware**: M3 + brass heat-set inserts universally
- **All parts 3D-printed plastic**
- **Target printer bed**: 256 × 256 × 256 mm

## Module dimensions (per v2.3 §4 / §10)

| Dimension | Value |
|-----------|-------|
| Cheek silhouette | Right trapezoid, slant on FRONT |
| Bottom (depth) | **228.6 mm** (9", locked) |
| Back-edge height | **205.45 mm** (8.09") |
| Top-edge length | **109.975 mm** (4.33") |
| Front (slant) length | **237.25 mm** |
| Slant angle | **30° from vertical** (= atan(√3/3), locked — aligned to isogrid) |
| Cheek thickness | 6 mm |
| Module interior width (cheek-to-cheek) | 261.525 mm (pinned by rack standard) |
| Module exterior width (with cheeks) | ~271.5 mm |
| Front rail capacity | **4U** (with 1U bottom gap + 15 mm top margin) |
| Back rail capacity | **4U** (from floor) |

## Parts list (per module — 6 printed parts)

| Part | Count | Print orientation |
|------|-------|-------------------|
| Cheek (L + R mirror) | 2 | Flat on bed, exterior face down |
| Top panel half (L + R) | 2 | Flat panel face on bed, flanges up |
| Bottom panel half (L + R) | 2 | Same as top |

Rails are integrated into the cheeks. Top/bottom supports are integrated as front flanges of the top/bottom panels.

## OpenSCAD usage

Each SCAD file can be opened standalone:

```
openscad Console10_isogrid.scad         # cheek (with integrated rails)
openscad Console10_top_panel_half.scad  # top tray half (when built)
openscad Console10_bottom_panel_half.scad
openscad Console10_module.scad          # full 6-part assembly (when built)
```

For printing, export each part as STL. The module assembly file is for visualization and fit-checking, not direct print.

## Open items (deferred, see designdoc.md §14)

- M3 heat-set insert holes for top/bottom panel attachment — placed when panel SCAD is laid out
- Sci-fi etching pattern reference (variants C4 / T2) — TBD
- Filament selection (PETG default)
- Custom equipment rack-ear template for slanted front rail
- Confirm 10-32 insert hole sizing on first print

## Variants

- **Cheek**: C1 solid · C2 open isogrid (default) · C3 closed isogrid etched · C4 closed sci-fi etched
- **Top**: T1 plain · T2 sci-fi etched
- All parametric via OpenSCAD variables at the top of each `.scad` file
