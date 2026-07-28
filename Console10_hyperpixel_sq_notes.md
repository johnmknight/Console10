# Console10 — HyperPixel 4.0 Square Faceplate — Working Notes

**Status:** v0.1 frame built & validated (manifold). **Dimensions CONFIRMED 2026-06-11** from the Pimoroni mechanical drawing — window tightened to **73** (0.5 mm reveal/side) and an **active offset** applied for the asymmetric bezel. The "holes under glass" catch is now visually proven (`preview/hp_sq_holes.png`). Retention (v0.2) is the only design work left; it needs a **rim caliper + a photo of the board BACK** (and the board's mounting orientation locked).
**Started:** 2026-06-11
**File:** `Console10_hyperpixel_sq_faceplate.scad`
**Previews:** `preview/hp_sq_iso.png`, `preview/hp_sq_front.png`, `preview/hp_sq_rear.png`
**STL check:** `preview/hp_sq.stl` — `Simple: yes` (manifold/printable)

---

## 1. What we're building

A Console10 3U faceplate for the **Pimoroni HyperPixel 4.0 Square *Touch*** (720×720 IPS,
capacitive). Same family as `Console10_display_faceplate.scad` / `Console10_lcd_simple_faceplate.scad`:
a uniform **3 mm flat plate** that bolts to the cheek **slant inserts**, screen behind the front face.

**Decisions locked (with John):**

| Decision | Choice |
|---|---|
| Variant | Square 4.0 **Touch** (board 84×84×9.5 mm, active ~72×72) |
| Orientation | n/a (square) |
| Pi | **Off-panel**, connected by ribbon — plate holds the **display only**, no Pi bracket |
| Retention | **Front pocket + lip**; screen held by its **own mounting holes** (pattern TBD — see §4) |
| Panel height | **3U** (133.35 mm) |

Nice tie-in: the project already had an **84.1 × 84.1 "purpose-TBD" cutout** in
`Console10_interface_specs.md` and `Console10_lcd_simple_faceplate.scad` (= board + 0.1 mm).
This display was the intended occupant.

---

## 2. What v0.1 contains (the frame)

Modeled on the display-faceplate pattern. Local frame: X = width, Y = up the plate
(= up the slant), Z = thickness; **front face at Z = plate_t (3), back at Z = 0.**

- **3 mm flat 3U slab**, 253 mm wide (sides flush with cheek outer faces ±126.5).
- **Slant-insert mount holes** — 4× Ø5.5 (10‑32 clearance) at **X = ±121.5**, **Y = [50.80, 127.00]**.
  Same pair the LCD/display faceplates use; lands on real cheek rail holes.
- **Recessed front pocket** (84.6 mm) the board drops into **from the back**.
- **Front lip** (1.5 mm thick) framing the active area, overlapping the ~6 mm black bezel margin
  to capture the glass. Glass ends up recessed ~1.5 mm behind the panel front.
- **74 mm viewing window** through the lip (frames the ~72 mm active with ~1 mm bezel reveal/side;
  lip inner edge clears the active area by ~1 mm).
- **Rear locating collar** — open square tube behind the plate, **6 mm deep, 2.5 mm wall**
  (outer 89.6) — locates the board edges and will host retention in v0.2.

### Current parameters (all in the `.scad`)

| Param | Value | Note |
|---|---|---|
| `plate_t` | 3 | uniform panel thickness |
| `n_u` / `plate_h` | 3 / 133.35 | 3U |
| `hp_board` | 84.0 | board W=H — **VERIFY** |
| `hp_active` | 72.0 | active W=H, centered — **VERIFY** |
| `hp_depth` | 9.5 | glass front → back of header — **VERIFY** |
| `hp_rim_t` | 2.6 | glass+PCB rim under the lip — **MEASURE** |
| `board_clr` | 0.3 | per-side, board into pocket |
| `pocket` | 84.6 | = hp_board + 2·board_clr |
| `win_reveal` | 1.0 | bezel reveal around active |
| `window` | 74.0 | = hp_active + 2·win_reveal |
| `lip_t` | 1.5 | front frame thickness / glass recess |
| `collar_h` / `collar_wall` | 6 / 2.5 | rear locating collar |

---

## 3. THE design catch — why retention isn't front-bolted

**CONFIRMED (Pimoroni drawing).** The 58 × 49 HAT pattern's upper-left hole is at (4.0, 6.5)
from the board top-left. In board-centered coords that puts the holes at **x ∈ {−38, +20},
y ∈ {+35.5, −13.5}** — so the **right-hand column (x = +20) is inside the 72 active glass**,
and the left column (x = −38) sits in the ~6 mm left bezel (≈2 mm off the active edge, one side
only). Either way the screen **cannot be front-bolted** with a usable pattern. Proven visually by
the red markers in `preview/hp_sq_holes.png` (render with `-D show_holes=true`).

Retention must come from the **rear** — the locating collar + clips, or a rear clamp frame.

---

## 4. Measurements — mostly obtained (Pimoroni drawing, 2026-06-11)

DONE (from the official drawing): ✅ board 84×84×9.5 · ✅ active 72×72 · ✅ HAT pattern
58×49, upper-left at (4.0, 6.5) · ✅ bezel ~5.5 L/R, 4.5 top, 6.5 bottom (→ active offset).

Still wanted before cutting a final panel (all marked `[CAL]` in the `.scad`):

1. **Rim thickness** at the edge — glass + PCB the lip/clips bear on (assumed 2.6 mm). Drives
   clip-hook engagement and the glass recess.
2. **M2.5** standoff/screw confirm (only from a forum reply, not the datasheet).
3. **Active offset** — caliper the real top/bottom bezel to confirm the ~1 mm shift and its
   direction; the window currently assumes **header-up**.
4. **Photo of the board BACK** — to place clips/clamp that clear the GPIO header (top, protrudes
   ~8.5 mm) + the FPC/touch connector. Gates the retention geometry.

---

## 5. Next steps (v0.2 — retention)

- **Option A (recommended, screwless):** 4 rear **corner clips** on the locating collar that hook
  the board's back edge — reuses the proven Stream Deck Mini clip pattern
  (`design_notes_streamdeck_mini_pocket.scad`). Hook engagement set from `hp_rim_t`. Prints with
  the plate, no fasteners. **Can be modeled before measuring the holes** (only needs rim thickness).
- **Option B (screwed):** rear **standoff bosses** at the measured mounting-hole pattern, M2.5 from
  behind — only viable if the holes sit in the bezel margin (not under the glass). Needs §4.3.
- After retention: print a **first-article frame**, fit-test the pocket/lip/clip clearances, then
  fold into `designdoc.md` (parts table + changelog) and the README.

---

## 6. How to pick this up (render loop)

```
cd C:\Users\john_\dev\Console10

# iso
"C:\Program Files\OpenSCAD\openscad.exe" -o preview/hp_sq_iso.png ^
  --imgsize=1100,820 --viewall --autocenter ^
  --camera=0,0,0,55,0,25,520 --colorscheme=Tomorrow ^
  Console10_hyperpixel_sq_faceplate.scad

# front (ortho)
"C:\Program Files\OpenSCAD\openscad.exe" -o preview/hp_sq_front.png ^
  --imgsize=900,900 --viewall --autocenter --projection=ortho ^
  --camera=0,0,0,0,0,0,520 --colorscheme=Tomorrow ^
  Console10_hyperpixel_sq_faceplate.scad

# rear (collar), hide the mock screen
"C:\Program Files\OpenSCAD\openscad.exe" -o preview/hp_sq_rear.png ^
  --imgsize=1100,820 --viewall --autocenter ^
  --camera=0,0,0,235,0,25,520 --colorscheme=Tomorrow ^
  -D "show_screen=false" Console10_hyperpixel_sq_faceplate.scad

# STL + manifold check (look for "Simple: yes")
"C:\Program Files\OpenSCAD\openscad.exe" -o preview/hp_sq.stl ^
  -D "show_screen=false" Console10_hyperpixel_sq_faceplate.scad
```

Flags in the `.scad`: `show_screen` (mock display on/off), `show_on_slant` (tilt onto the 30° slant).

---

*Memory: `console10-hyperpixel-sq-faceplate` in MEMORY.md.*
