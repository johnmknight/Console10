# CONSOLE10 — ANNOUNCEMENT FILM: STORYBOARD & SHOT PROMPTS

*Generated 2026-07-30 from `C:\Users\john_\dev\Console10\video_brief.md` v2.0.*
*This file is the shot-numbering source of truth. Before this existed, the shot numbers*
*in `C:\Users\john_\dev\Console10\wip\_RESTART.md` referred to a board that lived only in*
*a chat session and was never written to disk.*

## Revision 2026-07-30 — contradiction pass

Backup of the previous version: `C:\Users\john_\dev\Console10\wip\_storyboard_prefix.md.bak`
(SHA-256 prefix `22857A50FBAA15A6`). Full reasoning:
`C:\Users\john_\dev\Console10\wip\_storyboard_review.md`.

**Applied — mechanical, no creative content changed:**

| # | Was | Now |
|---|---|---|
| Section B beat markers | drifted ~4 s throughout; beats 6+7 read `01:28–01:28` (zero seconds) | re-timed to section C, the timing authority |
| Section C totals | "9 Blender shots = 58 s" | "8 Blender + 1 undecided" — the old line counted shot 09 as Blender while the same row marks it Open |
| Section D header | "supplied for all eleven shot numbers" | "nine of the eleven", with the two deliberate omissions named |
| Shot 05 overlay | 00:40–00:45, claimed to sit over the hold | 00:41–00:43; the hold is only 00:41.2–00:42.6 |
| Shot 08 | screen / keypad / blank, guards unmentioned | guarded toggle row required in frame; MacroPad state 2.5 s → 3.0 s |
| Shot 11 camera | three incompatible specs across fields 4, 5 and J | standardised on az −118°, `--framing 0` — matches the rendered asset |
| Shot 11 status | unrendered | ✅ rendered, `C:\Users\john_\dev\Console10\wip\_anim_shot11.mp4` |
| Section G SFX | "twelve soft ticks in 07" | twelve in 07a **and** twelve in 07b (predated the split) |
| Section H | shot 04 spanned 7 s while called "full 8 s"; 1.5 s gap; summed to 29.5 s | re-cut to sum to exactly 30.0 s |
| Section I Hook C | "footprint matches almost exactly" against A4 — **false** | replaced with the 19-inch width comparison; the measurements are recorded in place |
| Section J risk 3 | "unresolved" camera solve | marked **resolved**, with the verified 1.202 m figure |
| Section J guarded switches | recommended cutting the VO line | recommendation **withdrawn** — the switches were already on screen |

## Revision 2026-07-30b — the part count

John: *"the core product is 4 parts. The top, bottom and two cheeks/sides."*

**The film said five. The product is four.** The front slant insert is optional and is not a
cabinet part. Every "five" is now "four": section A, beat 2, the section C row and overlay,
and shot 05 fields 4, 5, 7, 8, 9, 10 and 12.

**Shot 05 was re-rendered 2026-07-30 and now shows four.** `C:\Users\john_\dev\Console10\wip\_anim_shot05.mp4`
previously showed five bodies against a VO that says four; the log now reads `keyframed 4 parts`
and the asset is 1.71 MB. Measured consequences (model validated against the logged 5-part
envelope before the re-render, which is why these numbers were trusted):

| | 5-part (superseded) | 4-part (on disk now) |
|---|---|---|
| Seated envelope | 253.0 × 228.6 × 217.4 mm | **unchanged** |
| Exploded envelope | 531.3 × 383.3 × 494.8 mm | 531.3 × **245.2** × 494.8 mm |
| Camera | 2.441 m | **2.278 m** |

**Shots 04, 07a, 07b and 11 are unaffected** — they frame on the seated envelope, which does
not change. Only shot 05 needed re-rendering, and it was, on 2026-07-30.

**The hold was NOT lengthened.** This paragraph originally said the hold was "being
lengthened to frames 77–137 at the same time since the re-render is mandatory anyway". That
never happened: the `--reseat` cycle fractions live inside `_anim_strip.py` (0.40 and 0.58
of the frame count) and were not changed, so the rendered asset holds **frames 77–111**, as
it always did. Corrected 2026-08-01 to match what is on disk. Lengthening the hold is still
available as an option — it needs the fractions parameterised and a ~4 min re-render — but
it is a choice, not a completed change.

Second-order finding, recorded in section J: this is the **second** optional part to be
counted as a cabinet part, after the slant cap. The root cause is that nothing in the export
path distinguishes cabinet from accessory. `C:\Users\john_\dev\Console10\designdoc.md` §1
also said five and was wrong at source — flagged but not edited for two sessions, because
that is the product authority and John's file. **Corrected 2026-08-01 on his instruction**,
along with six other live instances. See section J.

**Flagged, deliberately NOT applied — these are yours to call:**

1. **Narration pacing.** Beat 3 runs at 4.09 w/s against a 2.22 w/s film average, and it is
   the structural argument. Beat 1 runs at 1.03 w/s. It rebalances inside 88 s. See the
   pacing warning in section B.
2. ~~"Five printed parts" vs the optional front insert.~~ **CLOSED.** Resolved by John — it
   is four — and shot 05 was re-rendered 2026-07-30 (log: `keyframed 4 parts`).
3. **Shot 11's 5-second hold**, which section J already calls the weakest editorial choice.
4. **Shot 09's source** — the standing judgement call. Still open.
5. ~~`designdoc.md` L63 still says five printed parts.~~ **CLOSED 2026-08-01.** Corrected at
   source, along with six other live instances across `README.md`, this file and
   `wip\_RESTART.md`. See section J.

*List re-checked 2026-08-01. Only items 1, 3 and 4 remain open — all three are editorial
judgement calls for John, not work waiting on anyone.*

## Provenance note — why eleven shots, not eight or nine

The brief contradicts itself on shot count. Section D and the `<veo_technique>` block say
"8 or 9 shots… not 11". Section E ("all **eleven** VEO PROMPT fields"), section J
("continuity risk across the **eleven** shots") and `<working_agreements>` ("**Eleven**
shots at twelve fields each is already long") all say eleven. Three to two for eleven, and
the 8–9 figure reads as a later measured insert that was never propagated to the other
sections.

The 8–9 arithmetic also rests on a premise that no longer holds. It divides 75–90 s by
Veo's fixed ~10 s clip. But the standing decision is that product shots come from Blender,
and the brief itself says "Blender shots can be any length you specify, so use them to trim
the total". With three Veo shots at 10 s and eight Blender shots averaging ~7 s, eleven
shots total **88 s** — inside the target. The constraint dissolves rather than binds.

Keeping eleven also preserves the 192 frames already rendered as
`C:\Users\john_\dev\Console10\wip\anim\shot05_0001.png` … `shot05_0192.png` and the cut at
`C:\Users\john_\dev\Console10\wip\_anim_shot05.mp4`. Renumbering would have invalidated a
finished asset to satisfy a line the brief had already half-retracted.

**Flagged as instructed:** the brief is mistaken in section D. Proceeding with eleven as
written elsewhere.

---

## A. CREATIVE CONCEPT

Console10 is a rack that stopped pretending to be furniture. The film earns its credibility
the way the object does — by showing the joint, not the silhouette. It opens in the honest
mess of a home lab, where good equipment sits on a desk in a pile because the only
alternative is a nineteen-inch cabinet built for a room nobody has at home. Then it cuts to
a controlled studio and simply looks at the thing: a raked, trapezoid-sided cabinet the
width of a sheet of paper, and the four printed parts it comes apart into. The middle of the
film is structural argument rather than montage — the cheek edge *is* the mounting surface,
the rake and the rear plane are both real 4U planes, a rack ear bolts to printed plastic and
the bolt goes somewhere. It closes on a desk at dusk with the machine doing quiet work, and
on the only community claim that is true today: the files are public, the licence is MIT,
and the door is open. No crowd, no ecosystem, no numbers. The tone throughout is a competent
engineer showing you their work — warm, unhurried, and specific enough that an enthusiast
can check it.

---

## B. NARRATION SCRIPT

*Timed to 88 seconds. Recorded in post — never generated. Beat markers in brackets.*

*Beat markers re-timed 2026-07-30 to match section C, which is the timing authority.
They had drifted ~4 s throughout and beats 6+7 read "01:28–01:28" — zero seconds for
the closing VO. Section C sums to exactly 88 s and section G's music cues already
agreed with it, so B was the lone outlier.*

> **Pacing warning — unresolved, needs a decision.** Word counts against the picture
> time section C allocates: beat 1 = 31 words in 30 s (1.03 w/s), beat 2 = 53 words
> in 16 s (3.31 w/s), beat 3 = **45 words in 11 s (4.09 w/s)**, beat 4 = 38 in 18
> (2.11), beat 5 = 13 in 8 (1.62), beats 6+7 = 15 in 5 (3.00). The film averages
> 2.22 w/s, which suits the "warm, unhurried" tone. **Beat 3 runs at nearly double
> that, and beat 3 is the structural argument — the panels *are* the rails, ears bolt
> into 10 mm of printed wall, two 4U planes. The most credible material in the film is
> delivered fastest, while beat 1 spends 30 s saying "your desk is a mess" in 31 words.**
> At 2.2 w/s, beat 1 needs ~14 s, beat 2 ~24 s, beat 3 ~20 s. Slack in beats 1 and 5 is
> ~18 s; the shortfall in 2 and 3 is ~17 s, so **it rebalances inside 88 s without
> cutting a word or a shot** — trim shots 01–03 from 10 s to 6–7 s each and give the
> recovered time to shots 06 and 08. Not applied here because it changes the shot
> durations in section C and the 30-second cut in section H.

**[Beat 1 — The problem] 00:00–00:30**

> A Pi here. A switch there. A drive enclosure balanced on a book.
> (pause)
> Your equipment is real. Your rack shouldn't be a nineteen-inch cabinet
> built for a room you don't have.

**[Beat 2 — The reveal] 00:30–00:46**

> Console10 is a ten-inch rack in console form.
> About as wide as a sheet of paper. Raked, so the front face works at the angle
> your hands and eyes already want.
> Four printed parts. Two cheeks, a top, a bottom.
> Every one of them prints in a single piece.

**[Beat 3 — The system] 00:46–00:57**

> There is no rail part, because the side panels *are* the rails.
> Equipment bolts its rack ears straight into brass inserts set in ten millimetres
> of printed wall.
> Two mounting planes per module — the thirty-degree front, and the vertical rear.
> Four U on each.

**[Beat 4 — In use] 00:57–01:15**

> Swap the front and you change what the machine is for.
> A screen. A keypad. A row of guarded switches. A blank when you want quiet.
> It sits on a desk, next to the monitor, and it works.

**[Beat 5 — Customisation] 01:15–01:23**

> The source is parametric. Change a number, print the part, bolt it on.

**[Beats 6 & 7 — Open source, identity] 01:23–01:28**

> It's MIT licensed and the files are public.
> Print it. Change it. Make it yours.

*Note on the draft: the supplied draft closed with "built by makers, and ready to grow with
the community", which asserts a community that `<not_yet_true>` rules out. Replaced with
"Print it. Change it. Make it yours." — an invitation rather than a claim, and warmer for
being addressed to one person instead of a crowd.*

---

## C. STORYBOARD TABLE

| # | In–Out | Dur | Beat | Source | Description | Narration fragment | Overlay |
|---|---|---|---|---|---|---|---|
| 01 | 00:00–00:10 | 10s | 1 Problem | Veo | Loose small equipment scattered across a dark desk — a single-board computer, a switch, a drive enclosure on a book. No Console10 in frame. | "A Pi here. A switch there. A drive enclosure balanced on a book." | none |
| 02 | 00:10–00:20 | 10s | 1 Problem | Veo | A full-height nineteen-inch rack standing in a domestic room, absurdly oversized and mostly empty. No Console10 in frame. | "Your equipment is real." | none |
| 03 | 00:20–00:30 | 10s | 1 Problem | Veo | Slow push across the cluttered desk toward a clear empty space, as if the desk is waiting. No Console10 in frame. | "Your rack shouldn't be a nineteen-inch cabinet built for a room you don't have." | none |
| 04 | 00:30–00:38 | 8s | 2 Reveal | **Blender** ✅ | The assembled cabinet, slow 12° arc. First sight of the object. | "Console10 is a ten-inch rack in console form. About as wide as a sheet of paper." | `CONSOLE10` lower third, in at 00:32 |
| 05 | 00:38–00:46 | 8s | 2 Reveal | **Blender** ✅ | The **four** parts separate along their assembly axes, hold, and re-seat. Locked-off camera. | "Four printed parts. Two cheeks, a top, a bottom." | `4 PRINTED PARTS` upper right, 00:41–00:43 |
| 06 | 00:46–00:51 | 5s | 3 System | **Blender** ✅ | Macro on a real Ugreen CM753 1U panel bolting flat to the cheek edge face, screw entering an insert in the 10 mm wall. | "There is no rail part, because the side panels *are* the rails." | none |
| 07a | 00:51–00:54.5 | 3.5s | 3 System | **Blender** ✅ | The twelve front-slant insert positions illuminate bottom to top on both cheeks, then hold. Locked off at the established −118° angle. | "Two mounting planes per module." | `4U FRONT` centre, 00:52.5–00:54.5 |
| 07b | 00:54.5–00:57 | 2.5s | 3 System | **Blender** ✅ | Cut to behind the unit, looking into the open rear bay. The twelve rear-plane positions illuminate bottom to top, then hold. | "Four U on each." | `4U REAR` centre, 00:55.5–00:57 |
| 08 | 00:57–01:05 | 8s | 3→4 System/Use | **Blender** ⚠ | Faceplates exchange on the slant: screen, then the twin MacroPad (guarded toggle row visible in its lower skirt), then blank. | "Swap the front and you change what the machine is for." | none |
| 09 | 01:05–01:15 | 10s | 4 In use | **Open** ⚠ | The unit on a real desk at dusk beside a monitor, screen glowing, small status LEDs alive. | "It sits on a desk, next to the monitor, and it works." | none |
| 10 | 01:15–01:23 | 8s | 5 Custom | **Blender** | Parametric source on screen, a dimension changes, the part regenerates, then the printed part bolts on. | "The source is parametric. Change a number, print the part, bolt it on." | none |
| 11 | 01:23–01:28 | 5s | 6+7 Open/CTA | **Blender** ✅ | Return to the hero framing of 04, held, as overlay resolves. | "It's MIT licensed and the files are public. Print it. Change it. Make it yours." | `CONSOLE10` / `MIT LICENSED` / `github.com/…` stacked centre, in at 01:24 |

**Totals:** 3 Veo shots × 10 s = 30 s. 8 Blender shots = 48 s. 1 undecided (shot 09) = 10 s.
**88 s.** *Corrected 2026-07-30: the previous line read "9 Blender shots = 58 s", which
counted shot 09 as Blender while the same row marks it **Open** and section J recommends
Veo. The total is 88 s either way, but the old wording silently pre-empted an open decision.*

*Shot 07 was split into 07a and 07b on 2026-07-30. The two mounting planes face
in opposite directions, so no single restrained camera can show both — see the
shot 07 notes below. The split costs nothing: 3.5 s + 2.5 s = the 6 s the single
shot was budgeted, and the timeline is unchanged. Twelve rows, eleven shot
numbers.*

**Legend:** ✅ rendered and on disk. ⚠ blocked on geometry that does not exist yet — see
section J. **Open** = source not yet decided (shot 09 is the standing judgement call).

---

## D. SHOT PROMPTS

*Field 11 (VEO PROMPT) is supplied for **nine of the eleven** shot numbers. For the Blender
shots it is a **fallback only** — see the standing decision in section J. Where a Blender
render is the intended source, field 12 states which style_bible clauses do NOT apply to it.*

*The two deliberate omissions are **shot 05** and **shot 10**, and they are omissions rather
than oversights. Shot 05's whole job is counting the cabinet parts, and Veo is measured to
invent an extra panel; shot 10's whole credibility is that the on-screen source code is real,
and a generator asked to render code produces convincing nonsense. Reasoning in section J. Do not "complete
the set" by writing prompts for them.*

### SHOT 01

1. **SHOT** — 01
2. **DURATION** — ~10 s (Veo)
3. **PURPOSE** — Establish the problem physically, without naming it: good equipment living badly.
4. **VISUAL** — A dark desk seen at a low oblique angle. A bare single-board computer sits on its own antistatic bag, a small eight-port switch beside it with cables fanning off the back, and a 2.5-inch drive enclosure balanced on a hardback book to keep it level. Everything is real and working — small green link LEDs blink — and everything is provisional.
5. **CAMERA** — Short telephoto, 20 cm above desk height, a slow 15 cm dolly left to right that lets each object pass through the focal plane in turn.
6. **LIGHTING** — Single large soft key from upper left, late-afternoon quality. Fill weak. Background falls to charcoal. Status LEDs are the only saturated colour.
7. **PRODUCT ACTION** — Nothing moves but the camera and the blinking LEDs. A cable sways very slightly at the start and settles.
8. **NARRATION** — "A Pi here. A switch there. A drive enclosure balanced on a book."
9. **OVERLAY** — none.
10. **SOUND** — Ambient: quiet room tone, a distant fan. SFX: none. Music: nothing yet — the bed enters on shot 02.
11. **VEO PROMPT** — [continuity block from section E verbatim — *note: Console10 is NOT in this shot; use only the final style sentence of the block, not the object description*] Short-telephoto shot twenty centimetres above a dark wooden desk, dollying slowly fifteen centimetres from left to right, shallow depth of field so each object passes through focus in turn. On the desk sit a bare green single-board computer resting on its own antistatic bag, a small eight-port network switch with black cables fanning off its rear, and a small aluminium drive enclosure propped level on a hardback book. Thin green and amber link lights blink on the switch. Large soft key light from the upper left with the quality of late afternoon, weak fill, the background falling away into charcoal. Matte surfaces, real cable weight, cables hanging and bending under their own load. A plain domestic desk with no rack, no cabinet, no printed text, no labels and no visible screens anywhere in frame. Ambient: the quiet room tone of a home office with a distant fan. SFX: none.
12. **GENERATION NOTES** — Text-to-video; no reference stills needed and none should be attached, because Console10 must not appear. No timestamp prompting. **Most likely failure:** Veo tidies the desk into a styled flat-lay and loses the "provisional" read — the drive must look *propped*, not *placed*. If it comes back neat, re-roll with "balanced precariously on a hardback book to keep it level" moved to the front of the subject clause.

### SHOT 02

1. **SHOT** — 02
2. **DURATION** — ~10 s (Veo)
3. **PURPOSE** — Show the wrong answer at full scale, so the right answer needs no argument.
4. **VISUAL** — A full-height nineteen-inch rack cabinet standing against the wall of an ordinary room — carpet, skirting board, a door frame at the edge of shot. It holds one small switch near the top. The rest is empty air behind a mesh door.
5. **CAMERA** — Wide, low, static, slight upward tilt so the cabinet reads as tall. Deep focus.
6. **LIGHTING** — Flat domestic daylight from a window off-left. Deliberately unglamorous — this is the only shot in the film that is not lit like product.
7. **PRODUCT ACTION** — Nothing moves. The stillness is the point.
8. **NARRATION** — "Your equipment is real."
9. **OVERLAY** — none.
10. **SOUND** — Ambient: room tone, slightly hollow. SFX: the low hum of a single fan, too loud for the room. Music: the low sustained pad enters at 00:12.
11. **VEO PROMPT** — Wide static low-angle shot with a slight upward tilt, deep focus, of a tall black nineteen-inch server rack cabinet standing against the wall of an ordinary carpeted domestic room with a skirting board and a door frame visible at the edge of frame. The cabinet is nearly empty: a single small network switch is mounted near the top and the remaining space behind its mesh front door is bare. Flat unglamorous daylight enters from a window off to the left; no studio lighting, no rim light, no atmosphere. The cabinet dwarfs the room around it. A domestic interior with no data centre, no server room, no rows of other cabinets, no printed text, no signage and no labels in frame. Ambient: slightly hollow room tone. SFX: the low continuous hum of one cooling fan.
12. **GENERATION NOTES** — Text-to-video. No reference stills. **Most likely failure:** Veo fills the rack with equipment because "server rack" is a strong prior — the emptiness carries the entire argument. If it returns populated, re-roll with "almost entirely empty, one small switch at the top and nothing else" as the opening clause of the subject description.

### SHOT 03

1. **SHOT** — 03
2. **DURATION** — ~10 s (Veo)
3. **PURPOSE** — Clear the stage. End beat 1 on an empty space the product will occupy.
4. **VISUAL** — Back on the desk from shot 01. The camera pushes slowly past the scattered equipment toward a bare patch of desk beside a monitor — roughly A4-sized, conspicuously empty. The clutter drifts out of focus in the foreground.
5. **CAMERA** — Short telephoto, slow 25 cm push in at desk height, focus racking from the near clutter to the empty space beyond it.
6. **LIGHTING** — As shot 01, but the key has moved: the empty patch is the brightest thing in frame. Background near-black.
7. **PRODUCT ACTION** — Nothing moves. The rack focus does the work.
8. **NARRATION** — "Your rack shouldn't be a nineteen-inch cabinet built for a room you don't have."
9. **OVERLAY** — none.
10. **SOUND** — Ambient: room tone continues from 02. SFX: none. Music: the pad sustains and thins toward 00:29, leaving near-silence into the cut.
11. **VEO PROMPT** — Short-telephoto shot at desk height, pushing slowly twenty-five centimetres forward past scattered small computer equipment toward a bare empty rectangle of dark wooden desk surface beside a monitor, with focus racking from the near clutter to the empty space beyond. The foreground equipment — a small network switch, coiled black cables, a bare circuit board — falls out of focus as the camera passes. The empty patch of desk is roughly the size of a sheet of paper and is the brightest area in the frame. Large soft key light from the upper left, weak fill, the background falling away to near-black. Matte surfaces, real cable weight, shallow depth of field. A plain desk with no rack, no cabinet, no enclosure, no printed text and no labels anywhere in frame. Ambient: quiet home-office room tone. SFX: none.
12. **GENERATION NOTES** — Text-to-video. No reference stills. Continuity: same desk, same light direction, same monitor as shot 01 — attach the shot 01 output frame as a reference if Veo drifts. **Most likely failure:** the "empty space" reads as an accident rather than an invitation, or Veo fills it with an object. If filled, re-roll describing the space as "a deliberately cleared rectangle of bare desk".

### SHOT 04  ✅ RENDERED

1. **SHOT** — 04
2. **DURATION** — 8.0 s (Blender — 192 frames at 24 fps, complete)
3. **PURPOSE** — The reveal. Establish silhouette, rake, isogrid and desk scale in one uninterrupted look.
4. **VISUAL** — The assembled cabinet alone on near-black. The right-trapezoid cheek profile reads immediately: vertical rear edge, 30° raked front, the isogrid lattice sitting in its solid border on the outer face. The open rear equipment plane is visible as the arc passes. Nothing is mounted in it yet — this is the object, not a configuration.
5. **CAMERA** — 70 mm, elevation 16°, a slow 12° arc from azimuth −124° to −112°, framed on the *assembled* bounds (camera solves to 1.202 m, against shot 05's 2.441 m — the seated and exploded bounding radii differ by 2.03×). The arc is centred on −118°, so the midpoint of the move matches shot 05's locked-off angle exactly and the two cut together. Elevation and distance are held; only azimuth moves, so the object cannot change size across the shot.
6. **LIGHTING** — The established three-light rig: low grazing key at 15° elevation / 138° azimuth to rake across the isogrid pockets, cool fill from the right, warm rim behind. World near-black at 0.013.
7. **PRODUCT ACTION** — Nothing moves. All movement is camera. The isogrid shadows shift across the arc, which is the entire reason the key sits so low.
8. **NARRATION** — "Console10 is a ten-inch rack in console form. About as wide as a sheet of paper. Raked, so the front face works at the angle your hands and eyes already want."
9. **OVERLAY** — `CONSOLE10` in Eurostile or similar, lower third, fading in at 00:32 and out at 00:37.
10. **SOUND** — Ambient: studio silence — the room tone drops away entirely at the cut, which is the sonic reveal. SFX: none. Music: a single low tone lands on the cut at 00:30.
11. **VEO PROMPT** — *(fallback only)* [continuity block verbatim] Slow twelve-degree arcing shot on a seventy-millimetre lens, sixteen degrees above a single 3D-printed desktop rack cabinet standing alone on a near-black studio surface. The cabinet's sides are right trapezoids with a vertical rear edge and a front edge raked thirty degrees from vertical; the outer face of each side carries a recessed lattice of equilateral triangles framed by a solid unpocketed border. The rear of the cabinet is fully open. A low grazing key light rakes across the lattice so each pocket throws a defined shadow, a weak cool fill lifts the right side, and a warm rim separates the top edge from the background. Shallow depth of field. An empty studio with no desk clutter, no mounted equipment, no cables, no printed text and no labels in frame. Ambient: complete studio silence.
12. **GENERATION NOTES** — **Blender is the source, and it is rendered.** Built on `C:\Users\john_\dev\Console10\wip\_anim_strip.py`, *not* on `C:\Users\john_\dev\Console10\wip\_assemble.py` — see section J for why that file must not be used. Command: `"C:\Program Files\Blender Foundation\Blender 5.2\blender.exe" --background --python C:\Users\john_\dev\Console10\wip\_anim_strip.py -- --travel 0 --framing 0 --arc 12 --frames 192 --tag shot04`. The style_bible clauses calling for "fine visible 0.2 mm layer lines" and "brass inserts that read as brass" **do not apply** to this render; John has ruled both out for the Blender product images. **The anticipated failure was checked and did not occur:** the concern was that the arc would push the assembled bounds out of frame at the extremes, since the 0.86 pull-in factor fits a bounding *sphere* while the object is a box whose corners swing with azimuth. Frames 1 and 192 were rendered and inspected first — both sit inside frame with margin. The `--framing 0` solve was independently cross-checked: it computes the seated envelope as 253.0 × 228.6 × 217.5 mm, an exact match for `C:\Users\john_\dev\Console10\wip\_explode.log`.

### SHOT 05  ✅ RENDERED (four parts)

> **✅ THE CORE PRODUCT IS FOUR PARTS. RE-RENDERED 2026-07-30 — this shot now shows four.**
> Log: `keyframed 4 parts`, exploded envelope 531.3 × 245.2 × 494.8 mm, camera 2.278 m.
> The paragraphs below are kept as the record of why, not as outstanding work.
>
> John, 2026-07-30: *"the core product is 4 parts. The top, bottom and two cheeks/sides."*
> Preceded by: *"keep in mind the part that goes across the front is optional."*
>
> **The front slant insert is not a cabinet part.** It is optional, in the same category
> as the slant cap. The cabinet is: **two cheeks, a top, a bottom.**
>
> This supersedes an earlier note in this position which treated five as the default and
> four as a variant. That was my inference and it was wrong in emphasis — four is not a
> configuration of the product, it *is* the product. `C:\Users\john_\dev\Console10\designdoc.md`
> L63 ("A module is **five printed parts**… and a front slant insert") was therefore also
> wrong at source. **Corrected 2026-08-01** — designdoc.md §1 now reads "four printed
> parts" with the front slant insert named as an accessory, and README.md's Architecture
> line and Parts-list table were corrected with it. Backups with SHA-256 prefixes are in
> `C:\Users\john_\dev\Console10\wip\_pre0801_*.bak`.
>
> **This was wrong and has been fixed.** `C:\Users\john_\dev\Console10\wip\_anim_shot05.mp4`
> once rendered five bodies against a VO that says four — the identical defect to the slant
> cap leaking in as a sixth body, in the one shot whose entire job is letting the audience
> count. **Re-rendered 2026-07-30**; the log now reads `keyframed 4 parts` and frame 100
> shows four separated bodies.
>
> **The measured consequences, computed from the seated AABBs in**
> `C:\Users\john_\dev\Console10\wip\_probe_parts.txt` **(the model reproduces the logged
> 5-part envelope exactly, which is why these numbers are trusted):**
>
> | | 5-part (the old, wrong asset) | 4-part (what is now on disk) |
> |---|---|---|
> | Seated envelope | 253.0 × 228.6 × 217.4 mm | **unchanged** |
> | Exploded envelope | 531.3 × 383.3 × 494.8 mm | 531.3 × **245.2** × 494.8 mm |
> | Framing radius | 410.5 mm | 383.1 mm |
> | Camera distance | 2.441 m | **2.278 m** (6.7% closer) |
>
> Only the **depth** of the exploded envelope changes, because the front insert was the
> only part travelling toward −Y. The object ends up ~7% larger in frame, which improves
> a composition that was already loose.
>
> **Shots 04, 07a, 07b and 11 are unaffected** — they frame on the *seated* envelope,
> which does not change. No other render is invalidated.
>
> **Method:** gate `front` out the way `slant_cap` was — remove it from `DIRS` in
> `C:\Users\john_\dev\Console10\wip\_anim_strip.py` and
> `C:\Users\john_\dev\Console10\wip\_explode.py`, and add a `show_front`-style exclusion
> so it cannot leak back. Then re-run the shot 05 command. Verify the body count with
> `C:\Users\john_\dev\Console10\wip\_probe_parts.py`, never by eye.
>
> **The front insert is not banished from the film** — it is a real optional part and
> shot 08's slant-filler state is a natural home for it. It simply must not appear in the
> shot that counts the cabinet.

1. **SHOT** — 05
2. **DURATION** — 8.0 s (Blender — 192 frames at 24 fps, complete)
3. **PURPOSE** — Make the part count countable. This is the shot Veo structurally cannot do.
4. **VISUAL** — The assembled cabinet separates into its **four** printed parts, each travelling along the axis it actually assembles along — cheeks laterally, top up, bottom down. The parts hold apart long enough to be counted, then re-seat. Locked-off camera throughout, framed on the fully-exploded envelope so the seated and exploded states share one composition. *The optional front slant insert is excluded: it is not a cabinet part, and this is the shot that counts the cabinet.*
5. **CAMERA** — 70 mm, elevation 16°, azimuth −118°, locked off at **2.278 m** (was 2.441 m with the front insert included; the 4-part exploded envelope is 138.1 mm shallower in Y, so the framing radius drops from 410.5 to 383.1 mm). No camera move — the storyboard beat is the parts, and a move would compete with them.
6. **LIGHTING** — As shot 04. Identical rig, identical exposure, so 04 and 05 cut without a grade shift.
7. **PRODUCT ACTION** — Frames 1–77 separate to full travel (139.2 mm), **77–137 hold, 137–192 re-seat**. Ease-in/out at both ends so it reads as deliberate machinery rather than a linear slide. *Hold extended from 34 frames (1.4 s) to 60 (2.5 s), taken from the re-seat. Travel is unchanged at 139.2 mm — it is derived from the seated footprint (253.0 mm × 0.55), which the front insert never influenced.*
8. **NARRATION** — "Four printed parts. Two cheeks, a top, a bottom. Every one of them prints in a single piece."
9. **OVERLAY** — `4 PRINTED PARTS` upper right, in at **00:41**, out at **00:43.5**. *Two corrections, 2026-07-30. (a) The count is four, not five. (b) The old timing read 00:40–00:45, described as "timed to land during the hold" — but the hold is frames 77–111 of a shot starting at 00:38, i.e. **00:41.2–00:42.6**, so only ~1.4 s of the old 5 s card sat over the hold and the rest ran during the separation and 2.4 s into the re-seat, when the parts are closing and no longer separately countable.* **Hold lengthened to frames 77–137 (2.5 s)**, taken out of the re-seat — 1.4 s is short for counting, and since the re-render is now mandatory anyway this improvement is free. Overlay spans the new hold.
10. **SOUND** — Ambient: studio silence. SFX: **four** soft mechanical seats on the re-assembly, the last landing on the cut. Music: the low tone from 04 sustains.
11. **VEO PROMPT** — *(not applicable — see notes)*
12. **GENERATION NOTES** — ⚠ **SUPERSEDED — the asset on disk is the 5-part version and must not be used.** `C:\Users\john_\dev\Console10\wip\_anim_shot05.mp4` (1.57 MB) and `C:\Users\john_\dev\Console10\wip\anim\shot05_0001.png` … `shot05_0192.png` all show five bodies. **Do not delete them** (project rule: never delete without checking) — but do not cut with them either. Re-render prerequisites: exclude `front` from `DIRS` in `C:\Users\john_\dev\Console10\wip\_anim_strip.py` and `C:\Users\john_\dev\Console10\wip\_explode.py`, extend the hold to frames 77–137, then rebuild with `"C:\Program Files\Blender Foundation\Blender 5.2\blender.exe" --background --python C:\Users\john_\dev\Console10\wip\_anim_strip.py -- --frames 192 --reseat --tag shot05`. Expect the log to report an exploded envelope of **531.3 × 245.2 × 494.8 mm** and a camera at **2.278 m**; if it still says 383.3 / 2.441 the front insert is still loading. **No Veo prompt is supplied deliberately** — measurement on 2026-07-29 established that image seeding fixes silhouette and identity but never fixes part count, and a shot whose entire job is counting cannot be delegated to a generator that invents an extra panel. **Historical failures worth keeping — this shot has now had the wrong part count twice:** first the slant cap leaked in as a sixth body (fixed by gating `show_slant_cap`), now the front insert as a fifth. Both were optional parts that reached the render because nothing distinguished "cabinet" from "accessory" in the export path. **The real fix is upstream:** the SCAD should express that distinction once, so no future shot has to remember it. Verify with `C:\Users\john_\dev\Console10\wip\_probe_parts.py`; never count bodies by eye off a render, because overlapping parts merge visually and that produced a wrong count once already.

### SHOT 06

1. **SHOT** — 06
2. **DURATION** — 5 s (Blender)
3. **PURPOSE** — Prove the central structural claim in one image: the cheek edge *is* the mounting surface, and the screw goes into material.
4. **VISUAL** — Extreme macro on the raked front edge of a cheek. A flanged rack ear sits flat against the 10 mm edge face. An M-series socket-cap screw stands in the ear's slot, aligned with a heat-set insert seated in the printed wall. The screw turns and draws down until the flange pulls flush. The uneven grouped rhythm of the insert column runs away out of focus behind it.
5. **CAMERA** — Macro, locked off, perpendicular to the edge face so the flange-to-face contact is unambiguous. No move — a move here would let the viewer doubt what they saw.
6. **LIGHTING** — Tight grazing key almost parallel to the edge face, so the flange's approach to flush is legible as a closing shadow line. Weak cool fill. Everything beyond 30 mm falls to black.
7. **PRODUCT ACTION** — The screw rotates and descends ~4 mm over 5 s; the shadow gap between flange and cheek face closes to nothing and stops. Nothing else moves.
8. **NARRATION** — "There is no rail part, because the side panels *are* the rails."
9. **OVERLAY** — none. This shot must be believed in-camera, not captioned.
10. **SOUND** — Ambient: studio silence. SFX: the fine ratcheting of a hex driver, four clicks, then the dead stop of a screw seating. Music: pad only.
11. **VEO PROMPT** — *(fallback only)* [continuity block verbatim] Extreme macro locked-off shot, perpendicular to the ten-millimetre-thick raked edge of a matte off-white 3D-printed panel. A small flanged metal bracket rests flat against that edge face, and a dark socket-cap screw in the bracket's slot turns slowly and draws down until the bracket pulls flush against the plastic. A column of small brass threaded inserts sits flush in the edge face behind it, spaced in an uneven grouped rhythm, receding out of focus. A tight grazing key light almost parallel to the edge face makes the closing gap between bracket and panel read as a narrowing shadow line. Everything beyond a few centimetres falls to black. Shallow depth of field, no hands, no tools in frame, no printed text and no labels. Ambient: studio silence. SFX: the fine ratcheting of a hex driver, then a screw seating.
12. **GENERATION NOTES** — ✅ **RENDERED 2026-08-01.** `C:\Users\john_\dev\Console10\wip\_anim_shot06.mp4` — 120 frames, 64 spp, 149 s. Command: `... _anim_macro.py -- --frames 120 --spp 64 --key 4.0 --fill 0.35 --ev 0.0 --mblur 0.7 --tag shot06`.

    **The subject changed, and the change is the point.** This field previously called for a generic flanged L-bracket added to `Console10_module.scad` behind a `show_rack_ear` flag. Both halves of that were wrong.

    *No rack ear exists in the product.* Verified: a literal search for `rack_ear` across `C:\Users\john_\dev\Console10` returns four hits, all prose. Console10's own faceplates bolt straight into the cheek slant inserts — there is no third-party ear anywhere in the system. A bracket built to fill the gap was invented geometry, and it rendered as a blank switch plate on a white wall, because that is what it was.

    *The shot now uses a real panel John owns:* the **Ugreen CM753 10-inch rack mount**, `C:\3d files\mini-rack\Ugreen+2.5GBit+Switch+CM753+10-inch+rack+mount\Ugreen 2.5GBit Switch CM753 10-inch rack mount.stl`. Measured 254.0 × 44.5 × 110.4 mm — 10 inches exactly against Console10's 253, and 1U. He has printed it; there is a sliced `.gcode` beside the STL.

    *It is placed in Blender, not OpenSCAD, and deliberately so.* It is a third-party mesh, and pushing third-party meshes through OpenSCAD booleans is precisely what broke the shot 08 macropad export. Blender does not care about manifoldness and no boolean is needed — only a placement.

    *It bolts through a real EIA pair.* Console10's front slant list contains four pairs exactly 31.75 mm apart — (50.80, 82.55), (95.25, 127.00), (139.70, 171.45), (184.15, 215.90) — which is the standard 1U ear pattern. The panel centres at s = 111.125 with the screw on the upper hole at s = 127.00. Seating was confirmed with a wide diagnostic frame, not by eye.

    **Camera note.** Field 5 says "perpendicular to the edge face". Taken literally the flange lies flat to lens and the closing gap is fully foreshortened — the first test frame did exactly that and the edge was invisible. Rendered at 34° off-normal on a 28° bearing (mostly up-slant), so the insert column recedes past the bracket as field 4 asks.

    **Motion blur is on at 0.70 shutter**, because the script measured the screw spinning at 3.4 frames per apparent hex-socket period. Under 4 frames it strobes. The blur is also simply correct: a screw turning 27° inside a 1/24 s exposure smears on any real camera. The alternative — decoupling spin from the 0.79375 mm thread pitch — would make the pitch a lie to hide an artefact.

    Layer-line and brass style clauses **do not apply**.

### SHOT 07a + 07b  ✅ RENDERED

*One shot in the original board. Split into two on 2026-07-30 because the two
mounting planes face in opposite directions and no single restrained camera can
see both — the reasoning is in field 12 and in section J.*

1. **SHOT** — 07a (front plane) and 07b (rear plane), cut back to back
2. **DURATION** — 07a 3.5 s (84 frames) + 07b 2.5 s (60 frames) = 6.0 s, exactly the budget the single shot had
3. **PURPOSE** — Show that there are two mounting planes and that both are 4U, without a diagram.
4. **VISUAL** — *07a:* the assembled cabinet in three-quarter view; the twelve front-slant insert positions illuminate in sequence bottom to top on both cheeks, then hold. *07b:* cut to behind the unit, looking into the open rear bay; the twelve rear-plane positions do the same. The uneven grouped spacing reads in both — the same rhythm, on two different planes, which is the whole point of showing them consecutively.
5. **CAMERA** — *07a:* 70 mm, elevation 16°, locked off at azimuth −118° and 1.202 m — the established angle, so it cuts against 04 and 05 without a reframe. *07b:* same lens, elevation and distance, azimuth +62°, looking into the open back. A cut, not a move: reaching the rear plane from the front needs roughly 180° of arc, which the style_bible's "motion measured in centimetres, not metres" rules out.
6. **LIGHTING** — As shots 04/05, plus a subtle practical: the illuminating insert markers are the only new light source, warm amber and low-intensity, so the shot stays in the film's palette.
7. **PRODUCT ACTION** — No geometry moves in either shot. *07a:* markers rise bottom to top, staggered 5 frames with a 10-frame rise, all lit by frame 66 of 84, then hold. *07b:* staggered 3 frames with a 6-frame rise, all lit by frame 40 of 60, then hold. Both builds complete at ~75% so the narration and overlay land on a fully-lit hold.
8. **NARRATION** — "Two mounting planes per module. Four U on each."
9. **OVERLAY** — Split with the shots: `4U FRONT` centred over 07a, in at 00:52.5, out at 00:54.5; `4U REAR` centred over 07b, in at 00:55.5, out at 00:57. Each label now lands on the plane it names, which the single combined card could not do.
10. **SOUND** — Ambient: studio silence. SFX: a soft tick per marker, quiet enough to be felt rather than counted. Music: pad lifts slightly under the rear-plane reveal.
11. **VEO PROMPT** — *(fallback only — not recommended)* [continuity block verbatim] Slow eight-degree arcing shot on a seventy-millimetre lens around a matte off-white 3D-printed desktop rack cabinet on a near-black studio surface, moving from a front-biased three-quarter view to one that reveals the open rear. Small brass threaded inserts set into the thirty-degree raked front edge glow warm in sequence from bottom to top, hold, and fade; then the same happens along the vertical rear edge. The inserts sit in an uneven grouped rhythm rather than an even ladder. Low grazing key light rakes the triangular lattice on the outer side faces, weak cool fill, background near-black. Shallow depth of field. An empty studio with no mounted equipment, no cables, no printed text and no labels in frame. Ambient: studio silence.
12. **GENERATION NOTES** — ✅ **RENDERED 2026-07-30 as two shots.** `C:\Users\john_\dev\Console10\wip\_anim_shot07a.mp4` (84f) and `C:\Users\john_\dev\Console10\wip\_anim_shot07b.mp4` (60f). Commands: `... _anim_strip.py -- --travel 0 --framing 0 --markers front --frames 84 --tag shot07a` and `... --markers rear --azimuth 62 --frames 60 --tag shot07b`. The `--markers` implementation is verified: `add_insert_markers()` in `C:\Users\john_\dev\Console10\wip\_anim_strip.py` computes all 48 positions (12 front + 12 rear, per cheek) in the module world frame and asserts every one lies inside the cheek's actual mesh AABB before use. The assertion passes, and the mesh AABB comes back as x −126.5..126.5, y 0.0..228.6, z 6.0..211.5 — an exact match for the SCAD constants, so the world-frame mapping is confirmed. A probe render (`C:\Users\john_\dev\Console10\wip\anim\m07probe_0001.png`) shows the front-plane markers landing precisely on the front slant holes of both cheeks.

    **Why it became two shots — keep this, it is the reason the design is what it is.** The two mounting planes face in opposite directions: the front slant's outward normal points forward and up, the rear plane's points straight back at +Y. From the established camera at azimuth −118° (front-left) the rear plane is on the far side of the object. No 8° arc reveals it; reaching it needs roughly a 180° swing, which contradicts the style_bible's "motion measured in centimetres, not metres". This was predicted from the geometry and then confirmed with a probe render rather than trusted. **Do not "simplify" this back into one shot.** Rendering `--markers both` from a single angle silently hides half the markers and looks fine — which is exactly what the first probe did.

    **Marker look:** the first probe used proud amber spheres and read as vanity-mirror bulbs, wrong for this palette. They are now smaller (3.0 mm) and flattened along the bore axis so they sit *in* the edge face. If they still read as decorative at full size, the next step is lighting the bore recesses rather than adding surface geometry.

    **Do not count the dots by eye** off any of these renders. The count is correct by construction — 24 per plane, asserted against the mesh — and these images are exactly the kind `_RESTART.md` warns against counting, because adjacent markers merge visually at this scale.

    **Known stale:** field 11's Veo fallback prompt still describes the original single-shot 8° arc. It is fallback-only for a shot that is now rendered in Blender, so it has not been rewritten — if it is ever actually needed, split it into two prompts first.

    Positions come from the brief and are corroborated by the SCAD (front, from the front-bottom corner: 50.80 / 66.675 / 82.55 / 95.25 / 111.125 / 127.00 / 139.70 / 155.575 / 171.45 / 184.15 / 200.025 / 215.90 mm; rear, from the floor: 6.35 / 22.225 / 38.10 / 50.80 / 66.675 / 82.55 / 95.25 / 111.125 / 127.00 / 139.70 / 155.575 / 171.45 mm). Drive the markers from those constants, not by eye. Layer-line and brass style clauses **do not apply**. **Most likely failure:** the marker glow blows the pinned 0.00 exposure — meter the emissive intensity against the existing plastic values rather than adding light until it looks right, or 07 will not cut against 04/05.

### SHOT 08

1. **SHOT** — 08
2. **DURATION** — 8 s (Blender)
3. **PURPOSE** — Show that the front is the variable, and that changing it changes the machine's purpose.
4. **VISUAL** — Locked on the raked front plane. A screen faceplate is bolted in place; it lifts away and the **twin MacroPad faceplate** takes its position; that lifts away and a blank filler settles. Each lands flush against the slant, bolts aligned to the insert columns. The cabinet behind never moves. **The MacroPad faceplate carries the row of six guarded toggle switches in its lower skirt, and the shot must show them** — this is the state that delivers the VO's "a row of guarded switches", so the skirt sits inside the frame and is lit well enough for the guards to read as guards rather than as bumps. The printable Space Shuttle-style guards over 12 mm toggle bushings are one of the most distinctive things on the whole faceplate; framing them out would waste them.
5. **CAMERA** — 70 mm, locked off, square-ish to the slant so each faceplate is read on its own terms rather than in perspective.
6. **LIGHTING** — As 04/05, with the screen faceplate carrying a practical: abstract non-textual content, a slowly moving plot, low brightness.
7. **PRODUCT ACTION** — Three faceplate states across 8 s: screen (0–2.5 s), **MacroPad (3–6 s)**, blank (6.5–8 s), with ~0.5 s cross-moves. Faceplates travel along the slant normal so they never intersect the cheeks. *Re-balanced 2026-07-30: the MacroPad state now carries **two** VO items, "A keypad" and "A row of guarded switches", because the guards live on that faceplate. Seven words at the film's 2.2 w/s needs ~3.2 s, and the old 2.5 s window was short for it. The extra 0.5 s comes out of the blank, which carries the shortest line.*
8. **NARRATION** — "Swap the front and you change what the machine is for. A screen. A keypad. A row of guarded switches. A blank when you want quiet."
9. **OVERLAY** — none.
10. **SOUND** — Ambient: studio silence. SFX: a soft seat per faceplate, three in total, spaced to the cuts. Music: pad continues; a light rhythmic element enters at 01:00.
11. **VEO PROMPT** — *(fallback only)* [continuity block verbatim] Locked-off seventy-millimetre shot square to the thirty-degree raked front plane of a matte off-white 3D-printed desktop rack cabinet on a near-black studio surface. A rectangular faceplate carrying a small square display is bolted to the raked plane; it lifts away along the plane's normal and a second faceplate carrying two blocks of mechanical keys takes its place; that lifts away and a plain blank panel settles flush. Each panel seats against the raked face with its fasteners aligned to a column of brass inserts along the panel edge. The cabinet itself never moves. The display shows only an abstract slowly moving plot with no text or characters. Low grazing key light, weak cool fill, near-black background, shallow depth of field. No hands, no printed text, no labels, no logos anywhere in frame. Ambient: studio silence. SFX: three soft mechanical seating sounds.
12. **GENERATION NOTES** — ⚠ **BLOCKED, but not on what this field used to say.**

    **The old diagnosis was wrong.** It read "BLOCKED on asset placement… never been exported as world-position STLs". Placement was never the problem: `C:\Users\john_\dev\Console10\Console10_module.scad` already seats all three faceplates on the slant via `faceplate_on_slant()`, `macropad_pair_on_slant(0)` and `lower_blank_faceplate_on_slant()`. The export wrapper simply never exposed them. Fixed 2026-07-31 — `C:\Users\john_\dev\Console10\wip\_parts_export.scad` now has `display`, `macropad` and `blank` cases calling those same entry points, and all three are named in `ACCESSORY_PARTS`.

    **The real blocker.** The macropad export emits `ERROR: The given mesh is not closed! Unable to convert to CGAL_Nef_Polyhedron` — while still exiting 0 and writing 23.77 MB, so file size is *not* evidence of success. Cause: `devices()` in `Console10_macropad_pair_faceplate.scad` imports two third-party non-watertight STLs — `C:\Users\john_\Downloads\5128 MacroPad RP2040-Assembly.stl` (4.9 MB, imported twice inside an `intersection()`, which is what forces the CGAL conversion) and `C:\3d files\NASA\switch guards\space-shuttle-switch-guard.stl` (1.3 MB, unioned six times). That module's own header calls these "fit-check mocks (not printed)". 285.6 s against 14.1 s for the display faceplate.

    **The fix is to stop asking for the boolean.** Fusing visualisation meshes into one watertight solid is something only *printing* needs; a render does not need a single solid at all. Export `panel()` alone, and load the MacroPad and guard STLs into Blender directly as separate objects. Faster, no CGAL, and each component gets its own material — impossible once fused. **This technique is already proven:** shot 06 places John's Ugreen panel in Blender by matrix, and its AABB came back x −127.0..127.0, exactly the centred 254 mm.

    **Two things still outstanding.** (1) `-D show_devices=false` will *not* work through `p_macropad()`, because `-D` binds only the main file's top-level variables and `_parts_export.scad` reaches the macropad file via `use <>`; that needs optional parameters on `macropad_pair_on_slant()`. (2) No faceplate-swap animation mode exists in any script.

    **Fragility worth knowing:** two of the three assets this shot needs live outside the repo, one of them in `C:\Users\john_\Downloads\` — one cleanup from breaking the build, and not version-controlled.

    Layer-line and brass style clauses **do not apply**. **Most likely failure:** the faceplates are shown *sliding in* rather than bolting on, which `<not_yet_true>` explicitly rules out — almost everything in this project bolts, and the only sliding element is the WIP Gridfinity drawer. Motion must be along the slant normal and must end in a seat, never a slot.

### SHOT 09

1. **SHOT** — 09
2. **DURATION** — ~10 s (source undecided — see notes)
3. **PURPOSE** — Put the object in the world. This is the only shot that answers "what is it like to live with?"
4. **VISUAL** — The unit on a real desk at dusk, beside a monitor. Warm window light failing on one side, the mounted screen faceplate and a scatter of small amber and green status LEDs carrying the other. Cables leave the open rear plane and fall behind the desk with real weight. A mug, a notebook — the desk is used, not styled.
5. **CAMERA** — Short telephoto, slow 20 cm dolly in at desk height, shallow depth of field, focus landing on the raked face.
6. **LIGHTING** — The only shot lit as environment rather than product: motivated window light going cold and low, practicals doing the rest. This is deliberately the warmest frame in the film.
7. **PRODUCT ACTION** — Nothing moves but the screen content and the LEDs. A cable sways once and settles.
8. **NARRATION** — "It sits on a desk, next to the monitor, and it works."
9. **OVERLAY** — none.
10. **SOUND** — Ambient: evening room tone, a little traffic through glass. SFX: the single soft click of a relay or a key. Music: the rhythmic element resolves; the pad opens up.
11. **VEO PROMPT** — [continuity block verbatim] Short-telephoto shot at desk height, dollying slowly twenty centimetres toward a matte off-white 3D-printed desktop rack cabinet standing on a used wooden desk beside a computer monitor at dusk. The cabinet's sides are right trapezoids with a vertical rear edge and a thirty-degree raked front carrying a small square display showing an abstract slowly moving plot. Small amber and green indicator lights glow along the mounted equipment. Black cables leave the open rear of the cabinet and fall behind the desk under their own weight. Cold blue window light fails from the left; the display and the indicator lights are the warm sources. A mug and an open notebook sit nearby. Shallow depth of field with focus landing on the raked face. A lived-in home office with no data centre, no server racks, no printed text, no labels and no readable characters on any screen. Ambient: evening room tone with faint traffic through glass. SFX: one soft relay click.
12. **GENERATION NOTES** — ⚠ **THE OPEN JUDGEMENT CALL.** This shot is both a product shot and an atmosphere shot, and the standing decision splits on exactly that seam: product shots come from Blender because Veo cannot hold part count, but atmosphere — dusk light, a used desk, a room — is what Veo is genuinely good at and what Blender would cost days to fake. **My recommendation: seed Veo heavily and accept it.** The part-count risk is low here because the cabinet is largely occluded by mounted equipment and shot at a scale where nobody counts panels; the atmosphere risk in Blender is high. Attach two stills per the ingredients method. If it comes back with an invented extra panel on the visible cheek, fall back to Blender and light a simple desk plane. **Most likely failure:** readable text appears on the mounted display — Veo reliably invents convincing nonsense characters, and this is the only shot with a screen large enough for it to try.

### SHOT 10

1. **SHOT** — 10
2. **DURATION** — 8 s (Blender + screen capture)
3. **PURPOSE** — Show that "parametric" is a property of the source, not a marketing word.
4. **VISUAL** — Split across two states. First, a screen capture of the OpenSCAD source: a named constant is edited, a number changes, and the model in the preview pane regenerates to match. Then a cut to the printed part — the changed one — bolting onto the cabinet.
5. **CAMERA** — Locked-off screen capture for the first 4 s; then 70 mm macro, locked off, on the bolt-up for the last 4 s.
6. **LIGHTING** — Screen capture is self-lit. The macro half uses the established rig.
7. **PRODUCT ACTION** — A single numeric value changes; the geometry updates; the resulting part seats against the cabinet and a screw draws down.
8. **NARRATION** — "The source is parametric. Change a number, print the part, bolt it on."
9. **OVERLAY** — none — but see section J, because the source code visible in the screen capture is the one place readable text legitimately appears in-camera, and that is a deliberate exception to the no-text rule.
10. **SOUND** — Ambient: studio silence. SFX: three keystrokes, the soft rush of a viewport regenerating, then a screw seating. Music: pad plus rhythm, building.
11. **VEO PROMPT** — *(not applicable — see notes)*
12. **GENERATION NOTES** — **Not a generation job at all.** The first half is a literal screen recording of `C:\Users\john_\dev\Console10\Console10_module.scad` open in OpenSCAD with the preview pane visible; the second half is a Blender macro render. No Veo prompt is supplied because a video model asked to render source code will produce plausible nonsense, and this is the one shot whose entire credibility rests on the text being real. **Choose the edited parameter carefully** — it should visibly change the silhouette so the regeneration is legible at 4 s. Capture at 1920×1080 or higher and scale down; do not upscale a small window.

### SHOT 11  ✅ RENDERED

1. **SHOT** — 11
2. **DURATION** — 5.0 s (Blender — one frame looped, complete)
3. **PURPOSE** — Close on identity and the one community claim that is true: the door is open.
4. **VISUAL** — Return to shot 04's hero framing, now held perfectly still. The object alone on near-black, exactly as first seen, so the film ends where the reveal began.
5. **CAMERA** — 70 mm, elevation 16°, **azimuth −118°, `--framing 0` (seated bounds, camera solves to 1.202 m)**. Locked off, no move. *Standardised 2026-07-30. This shot was previously specified three incompatible ways: field 4 said "shot 04's hero framing" (`--framing 0`, tight), this field said "identical to shot 05's camera" (`--framing 1.0`, framed on the exploded envelope and 2.03× wider), and section J called it "a static hold of shot 04's **end state**" (azimuth −112°, where shot 04's arc finishes). Three readings, three different pictures. Resolved to **−118° and `--framing 0`**, because −118° is the angle shots 05, 07a and 11 already share — so the film's locked-off shots are one camera — and because shot 04's arc is deliberately **centred** on −118°, meaning the return should match the centre of the reveal, not its end. This matches the rendered asset.*
6. **LIGHTING** — Identical to 04/05. The last frame of the film should be gradeable against the first frame of the reveal without adjustment.
7. **PRODUCT ACTION** — Nothing moves at all for 5 s. The stillness is the close.
8. **NARRATION** — "It's MIT licensed and the files are public. Print it. Change it. Make it yours."
9. **OVERLAY** — Stacked centre, resolving in at 01:24 and holding to black: `CONSOLE10` / `MIT LICENSED` / the repository URL. The URL is the only address in the film and it appears exactly once.
10. **SOUND** — Ambient: studio silence. SFX: none. Music: everything resolves to the single low tone from shot 04, which decays into the black.
11. **VEO PROMPT** — *(fallback only)* [continuity block verbatim] Completely static seventy-millimetre shot, sixteen degrees above a single matte off-white 3D-printed desktop rack cabinet standing alone on a near-black studio surface, seen from the front-left three-quarter angle. The cabinet's sides are right trapezoids with a vertical rear edge and a front edge raked thirty degrees from vertical, the outer faces carrying a recessed triangular lattice framed by a solid border. Nothing moves for the entire duration. Low grazing key light rakes the lattice, weak cool fill, warm rim on the top edge, background falling to near-black. Shallow depth of field. An empty studio with no equipment mounted, no cables, no hands, no printed text and no labels anywhere in frame. Ambient: complete studio silence.
12. **GENERATION NOTES** — ✅ **RENDERED 2026-07-30.** `C:\Users\john_\dev\Console10\wip\_anim_shot11.mp4` — 5.00 s, 1920×1080, 24 fps, 254 KB, duration verified from the container rather than assumed. Command: `"C:\Program Files\Blender Foundation\Blender 5.2\blender.exe" --background --python C:\Users\john_\dev\Console10\wip\_anim_strip.py -- --travel 0 --framing 0 --arc 0 --frames 120 --only 1 --tag shot11`, then `C:\Users\john_\dev\Console10\wip\_encode11.ps1` loops the single PNG to 5 s. **One frame looped, not 120 rendered** — the option this field already sanctioned. It is not merely cheaper (1.7 s of render against ~4.6 min): it makes the hold **bit-identical**, so flicker is zero by construction rather than by measurement. crf 12 matches the other shots so grading stays consistent. Verified at render time: 5 parts, `max travel 0.0 mm`, framing envelope 253.0 × 228.6 × 217.5 mm — an exact match for `C:\Users\john_\dev\Console10\wip\_explode.log` — OptiX GPU, exposure pinned 0.00. Layer-line and brass style clauses **do not apply**. **Most likely failure:** none in the render — the risk here is editorial. Holding a static frame for 5 s is long, and it only works if the overlay resolves with weight. If the overlay design is not ready, shorten to 4 s rather than filling the time with a camera move that contradicts shot 04's arc. **Overlay note:** on this framing the centre of frame is the dark open bay, so the stacked white type in field 9 will read cleanly — but it lands *inside* the object rather than beside it. Check against the overlay artwork before lock.

---

## E. CONTINUITY BLOCK

*Goes verbatim at the head of every VEO PROMPT field above. 118 words.*

> A matte off-white 3D-printed desktop rack cabinet about the width of a sheet of paper,
> sitting at desk scale. Its two side panels are right trapezoids: the rear edge is
> vertical, the front edge rakes back thirty degrees from vertical, and the flat top is
> much shorter than the deep base. The outer face of each side panel is cut with a
> recessed lattice of equilateral triangles on a fine regular pitch, sunk a few
> millimetres deep with softly rounded corners, and framed all round by a solid
> unpocketed border. The interior faces are flat. Small brass threaded inserts sit flush
> in the ten-millimetre panel thickness, in columns running up both the raked front edge
> and the vertical rear edge, spaced in an uneven grouped rhythm. The rear is fully open.
> Matte PLA with fine visible print layer lines, on a near-black studio background.

---

## F. ASSET LIST

**Reference stills for Veo ingredients** — paste two per generation via the clipboard method.

- `C:\Users\john_\dev\Console10\wip\_x_seated.png` — assembled, the canonical identity still. Attach to shot 09.
- `C:\Users\john_\dev\Console10\wip\_asm_hero.png` — hero three-quarter, 55 mm.
- `C:\Users\john_\dev\Console10\wip\_asm_side.png` — orthogonal side, fixes the trapezoid proportion and the 30° rake better than any prose clause.
- `C:\Users\john_\dev\Console10\wip\_cheek_twoface.png` — isogrid face against flat interior face; the single best defence against the "through-cut lattice" failure.
- `C:\Users\john_\dev\Console10\wip\_probe_raking.png` — raking light on the pockets, establishes that they are recessed and not printed-on.
- `C:\Users\john_\dev\Console10\wip\_mod_front.png` — front elevation, shows the open bay.

**Stills for first-and-last-frame shots** — attach as a pair with "begin as the first image, end as the second".

- Shot 09 start / end: `C:\Users\john_\dev\Console10\wip\_x_seated.png` → `C:\Users\john_\dev\Console10\wip\_p_hero.png`.
- Shots 01, 02, 03 use text-to-video only; there is no Console10 still to seed with, and seeding them would risk introducing the object into beat 1, where its absence is the point.

**Screen-recording captures**

- `C:\Users\john_\dev\Console10\Console10_module.scad` open in OpenSCAD with the preview pane visible — the source of shot 10's first half. Capture at ≥1920×1080.

**Overlay artwork** — all text in the film lives here and nowhere else.

- `C:\Users\john_\dev\Console10\CONSOLE10_logo.svg` *(exists per commit 74f586d "Add MIT license, CONSOLE10 logo, and README branding"; confirm the exact filename before the edit — I have not opened it)*
- Lower-third wordmark for shot 04, `4 PRINTED PARTS` for 05, `4U FRONT · 4U REAR` for 07, and the stacked end card for 11 — to be produced; they do not exist yet.

**Gap, stated rather than papered over:** shots 06 and 08 have no usable reference still,
because the rack ear and the world-positioned faceplates do not exist as geometry. Their
stills can only be produced after the modelling work in section J.

---

## G. POST-PRODUCTION

**Editing rhythm.** Beat 1 is three even 10-second shots — deliberately a little slow, so the
cut to shot 04 lands. From 04 to 08 the film accelerates: 8, 8, 5, 6, 8, with the two
shortest shots carrying the densest structural claims, because a short shot reads as
confident and a long one reads as explaining. Shot 09 opens back out to 10 s — the only
place the film breathes — and 10 and 11 close it down again. Cut on motion settling, never
mid-move; every Blender shot is designed to start and end at rest so the editor has a clean
frame at both ends.

**Music.** One low sustained pad, entering at 00:12 under the nineteen-inch rack and never
leaving. A single low tone marks the reveal at 00:30 and returns as the last sound of the
film. A light rhythmic element — brushed, mechanical, not percussive-electronic — enters at
01:00 under the faceplate swaps and resolves at 01:15. No drop, no build, no swell into the
end card. The film should feel like it was scored by someone who also owns a torque driver.

**Typography.** One face, used four times. Eurostile or a close geometric-square relative
matches the Apollo-era reference without costume; IBM Plex Sans is the safer fallback and is
already in the portfolio's vocabulary. All-caps, wide tracking, thin weight, small size —
the overlays should feel like panel legends, not titles. White at 85% opacity. No boxes, no
rules, no animation beyond a 12-frame fade.

**Colour.** Grade the three Veo shots toward the Blender renders, not the reverse — the
Blender shots are the reference because they are internally consistent by construction and
share one pinned exposure. Hold near-black at a true 0.013-ish floor rather than crushing to
zero, so the background reads as a lit studio rather than a matte. The only saturated colour
in the film is equipment LEDs and the dusk window in shot 09.

**Sound-design bed.** Room tone under beat 1, then a hard drop to studio silence at 00:30 —
that silence is the reveal as much as the image is. Studio silence holds through 04–08, with
mechanical SFX carrying the structural beats: **four** seats in 05, four driver clicks in 06,
**twelve soft ticks in 07a and twelve in 07b** (corrected 2026-07-30 — the old "twelve in 07"
predated the split, and each shot lights its own plane's twelve positions), three seats in 08. Evening room tone returns for 09. Silence again
for 10 and 11.

---

## H. 30-SECOND CUT

Six shots, in this order: **03, 04, 05, 07a, 09, 11.**

- **03** (0:00–0:06.5, trimmed from 10 s) — open on the cleared desk. Losing 01 and 02 costs the problem statement, so the trimmed narration has to carry it alone.
- **04** (0:06.5–0:14.5) — the reveal, full 8 s. Untouched; it is the shot that sells.
- **05** (0:14.5–0:20.5, trimmed to 6 s) — trim the hold, not the separation. Cut into the move at frame 30 and out at the moment of full extension; the re-seat is expendable, the count is not.
- **07a** (0:20.5–0:24, full 3.5 s) — front plane only; 07b is dropped from this cut. The claim narrows to "the panels are the rails" and stops there. Useful consequence of the split: the 30 no longer needs a custom trim of shot 07, it takes 07a whole.
- **09** (0:24–0:28, trimmed to 4 s) — the last 4 s of the dolly, arriving rather than travelling.
- **11** (0:28–0:30) — 2 s, end card only.

*Timings corrected 2026-07-30. The previous in/out points contained two errors: shot 04
was given 0:06–0:13, a 7 s span, while the same line called it "full 8 s, untouched"; and
07a ended at 0:22.5 while 09 began at 0:24, leaving an unexplained **1.5 s gap**. The
described durations summed to 29.5 s, not 30. The list above preserves every stated
duration — 6.5 + 8 + 6 + 3.5 + 4 + 2 = 30.0 — by taking the missing half-second out of
shot 03, which is the most compressible.*

> **Dependency worth naming.** This cut depends on **shot 09**, the one shot whose source
> is still undecided and which does not exist in any form. If the 30 is the primary asset
> for a channel, it is currently blocked on the film's most uncertain shot. A 09-free
> variant would need a sixth shot — 06 is the natural substitute, and the note below
> already recommends swapping it in when the 30 has to stand alone.

Trimmed narration:

> Your equipment is real — your rack shouldn't need its own room.
> Console10. A ten-inch rack in console form, about as wide as a sheet of paper.
> Four printed parts. The side panels *are* the rails.
> MIT licensed. Print it, change it, make it yours.

Shots 06, 07b, 08 and 10 are the cuts. That is deliberate and slightly painful: 06 and 10 are
the two most credible shots in the film, and losing them makes the 30 a *trailer* rather than
a shorter film. If the 30 is the primary asset for a given channel, swap 07a for 06.

---

## I. THREE OPENING HOOKS

Three alternative shot 1s. Only one is used; the other two are discarded, not sequenced.

**Hook A — "The pile" (the board's current shot 01).** Loose equipment on a dark desk, a
drive propped level on a hardback book. *Rationale:* it is the most honest opening, because
it is a photograph of the actual problem and every person in the audience owns this desk. It
risks nothing and surprises nobody.

**Hook B — "The empty rack."** Open cold on shot 02's nearly-empty nineteen-inch cabinet,
holding four seconds longer than is comfortable before the narration starts. *Rationale:* it
opens on absurdity rather than on mess, and absurdity is funnier and more arguable than
clutter. The risk is that a server rack is a strong visual prior and some viewers will read
it as aspirational rather than ridiculous — the joke has to be lit badly enough to land.

**Hook C — "Half a rack."** Locked off at product distance: the assembled Console10 alone on
a dark surface, and a 19-inch rack's 482.6 mm width drawn or lit across the frame behind it,
so the object visibly occupies a little over half of it. No context, no room, no clutter.
*Rationale:* it leads with the single most surprising fact about the object — that a real
rack standard fits in that footprint — and it makes the scale claim in one image instead of
a sentence. It is the strongest hook of the three and the weakest opening, because it skips
beat 1 entirely and the film then has to argue backwards to the problem. Use it if the film
is being cut for an audience that already knows the problem. It also rhymes with shot 02,
which has just established the 19-inch cabinet at full height.

> **⚠ Corrected 2026-07-30 — the original version of this hook made a false claim.** It read:
> "Extreme macro, locked off: a sheet of A4 paper on a dark desk, and the assembled Console10
> lowered onto it **so the footprint matches almost exactly**." Measured against the verified
> assembly of **253.0 × 228.6 mm**:
>
> | Orientation | Sheet | Actual fit |
> |---|---|---|
> | A4 portrait | 210 × 297 mm | overhangs **21.5 mm each side**, falls **34.2 mm short** at each end |
> | A4 landscape | 297 × 210 mm | 22.0 mm margin each side, overhangs **9.3 mm** front and back |
> | Area | 624 cm² vs 578 cm² | Console10 covers **92.7%** |
>
> It matches in *area* and in **neither dimension**. At extreme macro a 21.5 mm overhang is
> not a near-miss, it is the subject of the shot — and this is the exact class of error the
> brief says the audience reads first ("they will notice if a screw goes nowhere"). Leading
> the film with its least defensible frame was the risk.
>
> **If you want the paper back**, it can be made honest: use A4 **landscape**, shoot at
> product distance rather than extreme macro, and say "covers about a sheet of paper" —
> true at 93% of the area. Do not say the footprint matches.
>
> Beat 2's VO, "about as wide as a sheet of paper", is **unaffected and stays**: 253 mm sits
> between A4's 210 and 297, so as loose spoken language it holds. It was only the literal
> on-camera overlay that failed.

---

## J. AUDIT

**Continuity risks across the eleven shots.** Three, one of them already realised.

The realised one: the slant cap. `Console10_module.scad` called `slant_cap_on_slant()` with
no visibility flag, so it exported as `_part_slant_cap.stl` and appeared as a sixth body in
shot 05 — against narration that then said five, and now says four. This is fixed (gated on `show_slant_cap`, default
false) but it is the template for the remaining risk, so it belongs here rather than in a
changelog. **Correction, already applied; verify with
`C:\Users\john_\dev\Console10\wip\_probe_parts.py` before any re-render.**

The second: shots 04, 05, 07 and 11 must share one exposure and one lighting rig or they will
not cut. They currently do — exposure is pinned at 0.00 rather than metered per shot,
precisely because a per-shot meter produced a +2.63 EV divergence once already. **Correction:
do not reintroduce auto-metering for any shot in this film, including new ones.**

The third, ~~unresolved~~ **RESOLVED 2026-07-30**: shot 04 needed a camera solve framed on
the *seated* bounds, where the existing solve framed on the *exploded* envelope, 2.03×
larger. Using the shot 05 camera for shot 04 would have left the object small in frame.
**Correction applied and verified.** `--framing 0` solves to **1.202 m** against shot 05's
2.441 m, and computes the seated envelope as 253.0 × 228.6 × 217.5 mm — an exact match for
`C:\Users\john_\dev\Console10\wip\_explode.log`. Shot 04 was rendered on it, and shot 11 now
uses the identical solve. Both are on disk. *Left in place rather than deleted so a future
session does not re-derive it; do not re-open.*

**Two shots that read as the same shot.** Shots 04 and 11 are deliberately the same framing —
that is the point of the return. But shot 11 as specified is a *static hold at the **centre**
of shot 04's arc* — corrected 2026-07-30 from "shot 04's end state", which implied azimuth
−112° where the arc finishes; shot 11 is −118°, the arc's centre and the angle shots 05 and
07a already use. At 5 s that is still a long time to look at something the audience saw 50
seconds ago with no new information. **Correction: either shorten 11 to 3–4 s and let the overlay do the
work, or give 11 a different azimuth so the return is thematic rather than literal.** I have
specified the literal return because it is stronger if the overlay design is good, but this is
the weakest editorial choice in the board and it should be tested both ways.

Separately, shots 06 and 08 both show something bolting to something. They survive as
distinct because 06 is extreme macro on a single fastener and 08 is a locked-off wide on a
whole plane — but if 06 is shot any wider, they will collapse into each other.

**Claims `<project_facts>` does not support.** Three, all now resolved.

**RESOLVED — the film said five printed parts. The product is four.** John, 2026-07-30:
*"the core product is 4 parts. The top, bottom and two cheeks/sides."*

The front slant insert is optional and is **not** a cabinet part — same category as the slant
cap. Every "five" in this board has been corrected to four: section A, beat 2, the section C
row and overlay, and shot 05 fields 4, 8, 9 and 10.

**This is the second time an optional part has been counted as a cabinet part**, and the two
failures share one root cause: nothing in the export path distinguishes *cabinet* from
*accessory*, so whatever `_parts_export.scad` emits ends up in the explode and gets counted.
The slant cap was fixed by adding one flag; the front insert needed another. A third optional
part would need a third. **The durable fix is upstream** — express the cabinet set once in
`C:\Users\john_\dev\Console10\Console10_module.scad` and have the export derive from it,
rather than each shot remembering which parts to exclude. Recorded here because the pattern
matters more than either instance.

**Consequence outside this file — now closed.** `C:\Users\john_\dev\Console10\designdoc.md` §1
read "A module is **five printed parts**: two cheeks, top, bottom, and a front slant insert",
which was wrong at the source. It was **flagged but deliberately not edited** for two sessions,
on the reasoning that the designdoc is the product authority and John's file to change.

**Corrected 2026-08-01** on John's instruction to bring the docs to reality. Seven live
instances were found across four files and all are now fixed: `designdoc.md` §1;
`README.md`'s Architecture line, its "Cabinet vs. accessories" line, and its **Parts list
table** — which still had its own "(5 printed parts)" heading listing the front insert as a
cabinet part; this file's shot 08 field 12; and `wip\_RESTART.md`. Every file was backed up
with a SHA-256 prefix to `C:\Users\john_\dev\Console10\wip\_pre0801_*.bak` first.

**The pattern worth keeping:** the last three instances were not in part-count *claims* — they
were in a table heading, a subordinate clause about the export path, and a gotcha note about
the slant cap. Prose drifts wherever nobody is looking, which is exactly why the count a render
uses now comes from `CABINET_PARTS` in the SCAD via `_parts.py`, with no fallback, rather than
from any sentence in any document.

The supplied narration draft closed with "built by makers, and ready to grow with the
community", which asserts an existing community that `<not_yet_true>` explicitly rules out.
Replaced with "Print it. Change it. Make it yours." Beat 6 in this board states only that the
files are public and MIT-licensed — an open door, not a description of traffic through it.

Shot 08's narration says "A row of guarded switches". **This audit's original recommendation
— cut the line — was wrong, and is withdrawn 2026-07-30.**

The reasoning that produced it was self-contradicting: the same paragraph noted that the twin
MacroPad faceplate v0.5 "carries six guarded toggles in the lower skirt", and that faceplate
**is shot 08's second state**. The switches were already on screen. The audit read the shot
*description*, which never mentions them, rather than the *object*, which has them — the same
failure mode as the shot 07 miss, where the text was checked and the geometry was not.

Confirmed by John, 2026-07-30: *"the dual macropad fits."*

**Correction as applied:** shot 08 field 4 now requires the guarded toggle row to be in frame
and lit to read as guards, and field 7 extends the MacroPad state from 2.5 s to 3.0 s because
it carries two VO items ("A keypad" and "A row of guarded switches" — seven words needs ~3.2 s
at the film's 2.2 w/s). No fourth state, no line cut, no runtime change. **A true, checkable
and distinctive claim was nearly discarded to fix a problem that did not exist** — printable
Space Shuttle-style guards over 12 mm bushings are exactly the detail this audience enjoys.

*General lesson, worth more than the fix: before cutting a claim as unsupported, check the
object, not the prose describing it.*

Nothing in the board depicts game consoles, sliding modules, a C2 or C6 variant, third-party
forks, or any count, star or download figure.

**Shots Veo is likely to fail, and what to do instead.** Measured evidence from 2026-07-29
says seeding fixes silhouette and identity but never fixes part count or interior truth. On
that basis: shots 04, 05, 06, 07, 08, 10 and 11 are all shots where a wrong panel count or an
invented interior would be visible, and all seven are specified as Blender. Shot 05 is the
extreme case and is deliberately given no Veo prompt at all. Shot 10 is given none either,
because a generator asked to render source code produces convincing nonsense and the entire
credibility of that shot is that the text is real.

Shots 01, 02 and 03 are safe for Veo because Console10 is not in them. Shot 09 is the genuine
coin-flip and is flagged as such in its own notes; my recommendation is seeded Veo, on the
grounds that the cabinet is largely occluded by mounted equipment at that scale, and that
Blender would spend days poorly imitating dusk light that Veo produces for free.

**Beats that would be better as two shots.** Two. One was found by building it.

Shot 07 was written as a single shot showing both mounting planes, and it cannot be made.
The planes face in opposite directions — front slant normal forward and up, rear plane normal
straight back at +Y — so no camera obeying the style_bible's "motion measured in centimetres"
sees both. **This audit missed it on the first pass**, because the shot was written from the
narration ("two mounting planes") without checking whether one camera could see both. It
surfaced only when the markers were implemented and a probe rendered. **Corrected and shipped:
07a (front, 3.5 s) and 07b (rear, 2.5 s), 6.0 s total — the original budget, timeline
unchanged.** The general lesson, worth more than the specific fix: a shot describing two
features of an object should be checked for whether those features are mutually visible before
the shot is written, not after it is built.

The second, anticipated rather than discovered: Beat 6 (open source) and beat 7
(identity and call to action) are both folded into shot 11's 5 seconds, and they are different
claims doing different jobs — one is a licence fact, the other is an invitation. **Correction:
if runtime allows, split 11 into an 11a (3 s, licence, over a slow macro of a printed part) and
an 11b (3 s, end card). That costs 1 s against the 88 s total, landing at 89 s, still inside
the 75–90 s target.** I have not split it in the board because the brief's shot count is
already contested and adding a twelfth shot would have muddied that argument.

Beat 4 (in use) is carried by shots 08 and 09 and is fine. Beat 1 gets three shots for one
idea, which is generous, and is where to find time if the runtime needs to come down.

**Overlay content a reader might expect in-camera.** Two, and one is a real exception.

`4 PRINTED PARTS` in shot 05 is overlay, but the shot is engineered so the claim is verifiable
in-camera — the parts hold apart specifically so they can be counted without the caption. That
is the correct relationship: the overlay names what the picture already proves. Same for
`4U FRONT · 4U REAR` in shot 07.

The real exception is shot 10. The `<generation_rules>` say all readable text lives in overlay
and never in footage, but shot 10 is a screen recording of OpenSCAD source, and the source code
is necessarily readable and necessarily in-camera. **This is a deliberate, single, stated
exception, and it is safe because the text is a real screen capture rather than generated
footage** — the rule exists to stop video models rendering plausible nonsense, and a screen
recording cannot do that. Flagging it explicitly so it is not "corrected" later by someone
applying the rule mechanically.

The repository URL in shot 11 appears exactly once in the film and only in overlay, as intended.
