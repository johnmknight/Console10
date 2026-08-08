# Console10 Phone Dock Faceplate — 2U, Pixel 10 Pro XL (v0.2, 2026-08-08)

Source: `C:\Users\john_\dev\Console10\Console10_phone_2u_faceplate.scad`
STLs:   `C:\Users\john_\dev\Console10\stl\Console10_phone_2u_panel.stl`
        `C:\Users\john_\dev\Console10\stl\Console10_phone_2u_lever.stl`
        `C:\Users\john_\dev\Console10\stl\Console10_phone_2u_ejector.stl`

2U (253 x 88.9 x t3) slant faceplate holding the CASED Pixel 10 Pro XL
landscape in a recessed pocket, wireless charger puck flush in the floor
(magnetic hold), and an airlock-style pull-down lever that ejects the phone
off the magnets. Blender demo scene:
`...\scratchpad\phone_eject_demo.blend` (session temp — re-buildable from
`build_eject_anim.py` pattern; kinematics below).

## Key dimensions (all measured, no guesses)

- Phone WITH case (John, 2026-08-08): 169 x 81 (81.6 at buttons) x 11.4;
  camera bump 13.62 thick, 26.4 wide. Bump position NOT measured
  → both floor ends relieved 36 mm (`cam_end_relief_w` [TODO-verify]).
- Pocket: 170 x 82.6 x 12.4 deep (0.5 clearance/side; buttons govern height).
  Bare phone fits looser/deeper — intended.
- Charger puck (from PixelTabletFrame `charger_puck.scad`): D60.1 x 8.9,
  bore D60.6 through the floor, friction boss behind (`puck_clr` 0.25/side).
- Mount: cheek slant inserts, wide pair `mount_y = [6.35, 82.55]`, Φ5.5.
  **Panel mounts at slant s = 133.35** (above the 3U macropad panel; holes
  land on the 139.70 / 215.90 rows). At s=0 the 6.35 row has no hole
  (front gap) — use [50.80, 82.55] instead.

## Eject mechanism

Lever on the right wing rides an M3 x 35 axle (+ nyloc — nylon-insert lock
nut so lever action can't back it off; leave it snug-not-tight) in two lugs
behind the plate. L-handle: arm through a rounded track slot, 26 mm grip bar
reaching OUTBOARD (never overlaps the phone), knurled knob, parked 45° up /
pulled 45° down (90° throw). `handle_R = 37` puts the knob ~1.5 mm off the
face at both ends of travel.

Crank disc on the hub carries a D5 pin at R = 7.62 that drives a slotted
boss (close-fit in push direction, elongated +y for the arc) on a stem
routing UNDER the tub end wall to the ejector plate behind the RIGHT relief
window. Plate parks 2.62 below the floor plane (camera bump clears → phone
stays reversible); travel = 2.62 dead + 5.0 push. dz = 7.62·(1 − cos θ).
Pushing the lever back up positively retracts the plate.

## Print & assembly

- `part="panel"` — face-down, no supports.
- `part="lever"` — as exported (bores vertical), no supports.
- `part="ejector"` — face-down; SUPPORT the stem+boss beam (~30 mm
  cantilever ~8 mm up).
- Pose the assembly in the GUI with `LEVER_ANGLE = 0..90`;
  `part="assembly"`, mocks via `show_phone` / `show_puck`.

## First-assembly tune points (single constants at top of file)

- Boss slot pin clearance: +0.6 on `pin_d` — the load-bearing fit.
- Stem-under-wall gap: 0.5 in `stem_top0`.
- Puck friction: `puck_clr = 0.25`.

## TODO v0.3

- Detent/latch at the locked position (magnet or bump) so the lever
  doesn't flop.
- Puck retention nubs if friction ring is loose.
- Verify camera-bar offset ≤ 36 mm from the phone end (with case).
- Cosmetic: raised bezel around the lever slot (airlock-panel look).
