# Console10

Modular desktop **10" mini-rack housing system**, styled after NASA Mission Operations Control Room consoles. Each module is a self-contained 3D-printed enclosure that houses small-form-factor 10" mini-rack equipment (Pi mounts, small routers, Stream Decks, mini displays).

See `designdoc.md` (**v3.0**) for the full specification.

## Architecture (v3.0)

A module is **5 printed parts**: 2 isogrid **cheeks** + a one-piece **top** + a one-piece **bottom** + a **front** slant insert. The back is an open equipment plane.

The v2.4–v2.5 split-half + centerline-dovetail panel scheme is **abandoned**. Top and bottom are now **single-piece** panels whose width aligns with the 10" mini-rack standard (~253 mm) — so each prints as **one part on a 255 mm bed**. Joinery is **rabbet-based** (no dovetail):

- **Bottom** → raised side ridges seat into **rabbets in the cheek bottom edges**.
- **Top** → a rabbet receives each **cheek's top edge**.
- Secured with glue or fasteners (TBD).

## Repository layout / file status

| File | Role | Status |
|------|------|--------|
| `designdoc.md` | Design spec | ✓ v3.0 |
| `README.md` | This file | ✓ v3.0 |
| `Console10_isogrid.scad` | **Cheek** (parametric source) | ✓ geometry current; top/bottom edge features still old tab-channels — **replace with rabbets** |
| `NEW_NASA_TOP.stl` | **Top** panel (standalone model) | ✓ current |
| `new_nasa_bottom.stl` | **Bottom** panel (standalone model) | ✓ current |
| `NASA_Insert_Front.stl` | **Front** insert template (standalone model) | ✓ current |
| `Console10_isogrid-new.stl` | Exported cheek (10 mm, current) | ✓ |
| `Console10_isogrid-do-not-delete.stl` | Old 6 mm cheek | superseded |
| `Console10_top_panel_half.scad` | Split-half top | ✗ DEPRECATED |
| `Console10_bottom_panel_half.scad` | Split-half bottom | ✗ DEPRECATED |
| `Console10_module.scad` | Full assembly (import cheek + 3 STLs) | ⏳ pending |
| `preview/` | Rendered previews | — |

## Standards (locked)

- **10" mini-rack** (EIA-310-D): 1U = 44.45 mm; rail-to-rail = 236.525 mm; per-U holes at 6.35 / 22.225 / 38.10 mm
- **Equipment mounting**: 10-32 brass heat-set inserts in the cheek edge faces (24 per cheek)
- **Capacity**: 4U (C4)
- **Target bed**: 255 × 255 × 255 mm (all parts single-piece)

## Module dimensions (v3.0)

| Dimension | Value |
|-----------|-------|
| Cheek silhouette | Right trapezoid, slant on FRONT |
| Bottom / depth | **228.6 mm** |
| Back-edge height | **205.45 mm** |
| Top-edge length | **109.975 mm** |
| Front (slant) length | **237.25 mm** |
| Slant angle | **30° from vertical** (isogrid-aligned) |
| Cheek thickness | **10 mm** |
| Top/bottom panel width | **~253 mm** (10" mini-rack standard, single-piece bed-fit) |

## Parts list (5 printed parts)

| Part | Count | Print orientation |
|------|-------|-------------------|
| Cheek (L + R mirror) | 2 | Flat, exterior face down, isogrid up |
| Top panel | 1 | Flat (support rabbet overhang as needed) |
| Bottom panel | 1 | Flat (support ridge overhang as needed) |
| Front insert | 1 | Wedge oriented for minimal support |

## OpenSCAD usage

```
openscad Console10_isogrid.scad     # cheek (parametric)
openscad Console10_module.scad      # full assembly — pending (import cheek + NASA STLs)
```

Top / bottom / front are currently **standalone STL models** (`NEW_NASA_TOP.stl`, `new_nasa_bottom.stl`, `NASA_Insert_Front.stl`), not SCAD-generated. They can be `import()`-ed into an assembly file for fit-checking, or remodeled parametrically.

## Open items

See `designdoc.md` §13. Highlights: replace cheek tab-channels with rabbets; reconcile final width vs rabbet geometry; correct front wedge to 30° if it must mate flush; finalize glue vs fasteners; build the `Console10_module.scad` assembly.

## Variants

- **C4** (4U, current) · C2 (2U, future) · C6 (6U, future) · C4-E (sci-fi etched, deferred)
