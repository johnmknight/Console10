# Console10 — Twin-MacroPad Lower Panel (notes)

Source: `Console10_macropad_pair_faceplate.scad` (v0.2). The 3U panel beneath the
display, carrying **two Adafruit MacroPad RP2040s** (rotated 90°, PCB-to-PCB at
centre) plus a **row of guarded toggle switches** in the lower skirt.

## Parts to print
| Part | `part=` | STL | Qty |
|---|---|---|---|
| Panel / faceplate | `panel` (default) | `Console10_macropad_pair_panel.stl` | 1 |
| MacroPad mount board (backplate) | `mount_board` | `Console10_macropad_mount_board.stl` | 1 |
| 3-gang switch guard (fused) | `guard_bank` | `Console10_guard_bank3.stl` | **2** |

Export the panel with `show_devices=false show_backplate=false` (geometry only).

## MacroPads
- Two pads, each rotated 90°; boards butt at centre (`mp_gap=0`), OLED/encoder ends
  out at the far left/right. Pads pushed to the TOP (`mp_cy`), blank skirt below.
- Face openings cut flush to the PCB edge (no front lip) so keycaps + OLED clear.
- Retention: rear **mount board** spanning both pads — bolts down onto 8 panel posts
  (±`mp_post_sx` × ±`mp_post_sy` per pad), standoffs up to each MacroPad's 4 PCB holes.

## Guarded switches (v0.2)
- **6 toggle switches**, body **14.7 × 29.1 × 26.8 deep** (behind the panel),
  bushing through a **12.4 mm** hole.
- Row at **Y = 42**; X at **[−80, −52, −24, 24, 52, 80]** — chosen to sit in the
  GAPS between the mount-board posts (posts at X = ±8.07, ±96.07) so each switch
  body clears every post by ≥4 mm and fouls **only the flat mount board**.
- The mount board has a **clearance relief** (`sw_board_relief`) at each switch X so
  the bodies pass through it.
- **OLED status display removed** in v0.2 (was under the left pad).

## Switch guards — fused gangs (the "shuttle" look)
- The printed guard is `space-shuttle-switch-guard.stl` (base 25 × 25, 30 tall).
  Hole axis = guard Y; mounted via `guard_rx=90` (hole → panel normal) + `guard_rz=90`
  (cage reads vertical). At the 28 mm switch pitch the vertical cages overlap.
- `guard_bank(3)` **unions 3 guards into one part** (cages fuse) — printed once per
  trio. Both trios are identical → print the one STL twice.
- Panel seats each gang in a **sharp-cornered locating pocket** (`gang_recess`):
  **86 × 25 mm + 0.5 mm clearance, 2.5 mm deep**, centred at X = ±52, Y = 42, with
  the 3 bushing holes inside. (Plate is 3 mm thick → 2.5 mm pocket leaves 0.5 mm
  backing; thicken locally if a deeper pocket is needed.)

## Key tunables
`tog_x` (switch X list), `tog_cy` (row Y), `gang_w/gang_h/gang_clr/gang_recess_d`
(pocket), `guard_rx/guard_rz/guard_z` (guard orientation), `sw_body_*` (switch
body fit-check), `mp_post_sx/sy` (mount-board posts).
