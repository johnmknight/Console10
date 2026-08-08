# CONSOLE10 — ANNOUNCEMENT VIDEO BRIEF v2.0

**Written for:** Claude Opus 5 (the model that will produce the storyboard and shot prompts)
**Video generated in:** Veo 3.1 for shots 01/02/03 only — **everything else is Blender**. See the revision note below.
**Source of truth:** `C:\Users\john_\dev\Console10\designdoc.md` (v3.3, 2026-05-28), `C:\Users\john_\dev\Console10\README.md`, `C:\Users\john_\dev\Console10\Console10_interface_specs.md`

---

> ## ⚠ REVISION 2026-08-01 — THIS BRIEF IS NO LONGER THE LIVE SPEC
>
> **Read `C:\Users\john_\dev\Console10\storyboard.md` instead.** This brief produced that
> storyboard and is kept as the record of the reasoning. Where the two disagree, the
> storyboard wins. Current build state is in
> `C:\Users\john_\dev\Console10\wip\_RESTART.md`, and a visual board against verified
> on-disk state is at `C:\Users\john_\dev\Console10\storyboard_board.html`.
>
> **What changed, and why it matters when reading the rest of this file:**
>
> 1. **Product images come from Blender, not Veo.** This brief is written throughout as
>    though Veo generates the product footage. It does not. Veo keeps only shots 01, 02
>    and 03 — the three where Console10 is not in frame. The reason is measured rather
>    than aesthetic: image seeding fixes Veo's silhouette and identity, but never fixes
>    **part count**. It invents extra panels. A film whose second beat asks the audience
>    to count four parts cannot use a generator that adds a fifth.
>
> 2. **Shot 09 is the one open judgement call** — it is both a product shot and an
>    atmosphere shot. Still undecided.
>
> 3. **The cabinet is FOUR printed parts**, not five: two cheeks, a top, a bottom. The
>    front slant insert is an accessory. Anywhere below that implies five is wrong; the
>    authoritative lists are `CABINET_PARTS` / `ACCESSORY_PARTS` in
>    `C:\Users\john_\dev\Console10\Console10_module.scad`.
>
> 4. **The "8–9 shots, not 11" arithmetic in the table below no longer holds.** It divides
>    75–90 s by Veo's ~10 s fixed clip. Blender shots can be any length, so the constraint
>    dissolves: three Veo shots at 10 s plus eight Blender shots averaging ~7 s totals
>    **88 s** across **eleven** shots. The storyboard is built on eleven.
>
> 5. **Six shots are already rendered** — 04, 05, 06, 07a, 07b, 11 — so the Veo prompts
>    below for those shots are dead letters, retained only as fallback.
>
> Backup of the pre-revision file: `C:\Users\john_\dev\Console10\wip\_pre0801_video_brief.md.bak`.

---

## PART 0 — HOW TO RUN THIS (do not paste this part)

1. Start a **fresh** Claude Opus 5 session. Effort: **xhigh**, thinking **on**.
2. Paste everything between `=== BEGIN PROMPT ===` and `=== END PROMPT ===`.
3. Attach the reference stills listed in PART 4 if you want Opus 5 to describe geometry it can see rather than geometry it's inferring from numbers.
4. Take the shot prompts it emits into the Gemini app.

**Three hard Veo constraints this brief is now built around** (from Google's Veo 3.1 documentation — see Sources at the end):

> **Revised 2026-07-29 against a real generation**, not against documentation. The figures
> below now come from a clip actually produced in the Gemini app and inspected with ffmpeg
> (`C:\Users\john_\dev\Console10\wip\_veo_test.mp4`). The API/Cloud docs describe a different
> envelope, and the consumer app does not match them.

| Constraint | Measured | Consequence for your brief |
|---|---|---|
| **Clip length** | **10.01 s** — one text-only generation, no length control offered in the UI | The docs' "4, 6 or 8 seconds" does not apply here. At ~10 s per clip, a 75–90 s film is **8–9 shots**, not 11. |
| **Resolution / frame rate** | **1280×720, 24 fps**, H.264, with a 48 kHz stereo AAC track | Not 1080p. Plan the edit as a 720p source; upscaling is a post decision. Audio is generated whether or not you ask for it. |
| **First-and-last-frame** | **No such control** in the UI — but **multiple images can be pasted** into the prompt box (Ctrl+V, repeat), which reproduces the behaviour | Attach the seated still and the exploded still, then prompt "begin as the first image, end as the second". Verified working 2026-07-29. |
| **Image seeding impact** | Transformative. Text-only produced a plausible *wrong* cabinet; two-image seeded produced a recognisable Console10 — correct 30° rake, fine bordered lattice, insert columns on the **edge** faces | Seed every Veo shot. It does not fix part count or interior geometry, so countable shots still go to Blender. |
| **Negative prompt** | **No field**, as documented | Unchanged: field 12 becomes an exclusion clause inside the prompt body, phrased as description. |
| **Watermark** | SynthID mark visible bottom-right of frame | Crop or frame around it, or accept it. |

**Caveat on the above: n = 1.** Every figure here is from a single generation. Confirm the
10 s / 720p behaviour across two or three more clips before treating it as the envelope —
it may be a default rather than a limit.

**What a real generation showed (2026-07-29).** A text-only prompt for the exploded view
produced genuinely convincing footage — matte PLA, visible layer lines, brass-toned insert
holes, a clean explode-and-reassemble with no morphing, and a final frame carrying a 30°
raked front, a triangular side lattice and hole columns up the edges. It is also **not
Console10**: the raked face came back *closed* rather than an open 4U mounting plane, the
lattice was a coarse through-cut grid instead of 20 mm-pitch 5 mm pockets inside a solid
border, an extra panel appeared that does not exist in the design, and the insert holes sat
on panel faces rather than the 10 mm edge faces.

**That is the whole argument for the Blender/Veo split.** Veo does not fail here by producing
something broken; it fails by producing something *plausible and wrong*, which is worse in
front of an audience that will go and read the repository. Use it where invention is an asset
(shots 01, 02, 03, 09) and keep it away from any shot making a mechanical claim.

**Continuity lever, revised.** "Ingredients to Video" (up to 3 reference images) is documented
for the API but is **not exposed in the consumer app**, and neither is first-and-last-frame.
What the app does accept is a **single pasted image** — put a PNG on the Windows clipboard and
Ctrl+V into the prompt box; there is no persistent `input[type=file]` in the DOM to target, and
the Upload button opens a native picker. Expect a one-time "Creating content from images and
files" rights dialog on first paste. Seed from `C:\Users\john_\dev\Console10\wip\_p_hero.png`
or `C:\Users\john_\dev\Console10\wip\_x_seated.png` — those are geometrically exact.

---

## PART 1 — THE PROMPT

```
=== BEGIN PROMPT ===

<role>
You are a commercial director and product cinematographer who also writes prompts for
Veo 3.1. You are directing the announcement film for Console10, an open-source hardware
project. You know the difference between a shot that reads beautifully on paper and one a
video model can actually generate, and you write for the second.
</role>

<project_facts>
Everything in this block is measured or specified in the project's design documents.
Treat it as fact. Anything not in this block is not established — see <not_yet_true>.

<identity>
Name: Console10.
One line: an open-source, 3D-printed 10-inch mini-rack in an Apollo-console-inspired form factor.
It is a rack in console form. It is not an accessory that mounts into a rack, and it is not a
decorative shell. It supplies the mounting standard itself — the side panels ARE the rails.
Aesthetic reference: Apollo-era NASA mission control hardware. Inspired by, not a replica of.
License: MIT, © 2026 John M. Knight.
Design document version 3.3, dated 2026-05-28.
</identity>

<why_it_exists>
A full 19-inch rack is oversized and overbuilt for a home lab full of small-form-factor gear.
Console10 is a desk-scale cabinet that still honours a real rack standard, so real rack-eared
equipment bolts into it — while its raked front plane puts screens, keys and switches at a
usable angle instead of flat against a vertical face.
</why_it_exists>

<geometry_locked>
These numbers are frozen. Every shot must depict the same object.

Architecture: four printed parts — two side panels ("cheeks"), one single-piece top,
one single-piece bottom. The back is an open equipment plane. The front slant insert is an
ACCESSORY, not a cabinet part. (Corrected 2026-08-01; this line read "five printed parts"
and counted the insert.)

Cheek silhouette: a right trapezoid, with the slant on the FRONT.
  Bottom edge (depth):        228.6 mm
  Back edge (height):         205.45 mm
  Top edge:                   109.975 mm
  Front slant edge:           237.25 mm
  Slant angle:                30° from vertical
  Cheek thickness:            10 mm
Top and bottom panel width:   ~253 mm  (aligned to the 10-inch mini-rack standard)

Isogrid: recessed triangular lattice on the cheeks' EXTERIOR faces (interior is flat).
  Tiling: {3,6} equilateral triangles
  Spacing: 20 mm     Rib width: 2.5 mm     Pocket depth: 5 mm     Fillet: 1.59 mm
  The outermost ring is filled solid, so a plain border frames the lattice.

Scale anchor for any shot needing it: ~253 mm wide is about the width of a sheet of
A4/Letter paper. This sits on a desk beside a monitor. It is not floor-standing furniture.
</geometry_locked>

<mounting_planes>
This is the structural idea that distinguishes Console10, and it should be legible on screen.

Console10 provides TWO 4U mounting planes per module:
  - the 30° raked FRONT plane
  - the vertical REAR plane

Rack equipment mounts by bolting its flanged rack ears directly to the cheek EDGE FACE,
into brass heat-set inserts set into the 10 mm cheek thickness. The cheek edge IS the
mounting surface. There is no separate rail part.

Standard: EIA-310-D 10-inch mini-rack.
  1U = 44.45 mm
  Rail-to-rail hole spacing = 236.525 mm
  Per-U hole pattern at 6.35 / 22.225 / 38.10 mm

Insert positions, 12 per plane per cheek — note the uneven, grouped rhythm; this is
visually distinctive and should stay consistent shot to shot:
  Front slant, measured from the front-bottom corner (mm):
    50.80, 66.675, 82.55, 95.25, 111.125, 127.00, 139.70, 155.575, 171.45, 184.15, 200.025, 215.90
  Rear plane, measured from the floor (mm):
    6.35, 22.225, 38.10, 50.80, 66.675, 82.55, 95.25, 111.125, 127.00, 139.70, 155.575, 171.45

Capacity: 4U. This variant is called C4.
</mounting_planes>

<materials_and_hardware>
Material: PLA by default. PETG or ASA acceptable for the cheeks.
Print settings: 0.2 mm layers, 25–40% infill, 3–4 walls.
Target print bed: 255 × 255 × 255 mm. Every part prints as a single piece — nothing is
  split and glued to fit the bed. (This is a real design achievement and worth a beat.)
Print orientation: cheeks flat, interior face down, isogrid pockets facing up.

Per module:
  48 × 10-32 brass heat-set inserts for equipment mounting
     (24 per cheek: 12 in the slant edge, 12 in the back edge)
  M3 socket-cap screws, counterbored flush, into M3 heat-set inserts in the cheek
     top and bottom edges — 3 per side at the top, 4 per side at the bottom.

Joinery: rabbet-based. The top and bottom panels each carry two raised side ridges that
seat into matching rabbets in the cheek top and bottom edges. Tongue and both walls are
equal at ~3.33 mm, centred. There is no centreline split and no dovetail.
</materials_and_hardware>

<accessories_that_exist>
Console10 the cabinet = 2 cheeks + top + bottom + front insert. Everything else is a
swappable faceplate that bolts to the cheek slant inserts. These exist in the repository:

  7-inch monitor faceplate (Elecrow RC070 / GeeekPi)        3U, slant     v0.17
  Lower blank filler                                        2U, slant     v0.1
  Twin MacroPad faceplate                                   3U            v0.5
     — 2 × Adafruit 5128 MacroPad RP2040, mounted end-to-end, long axis
       running across the panel, keys proud through the front
     — 0.91-inch 128×32 OLED beneath the left pad
     — a row of 6 guarded toggle switches in the lower skirt
  Screen + slider faceplate                                 3U            v0.1
     — Pimoroni HyperPixel 4.0 Square, 720×720 touch
     — Adafruit NeoSlider 5295 vertical fader, 9.4 × 75.1 mm housing, flush-seated
     — 0.91-inch OLED, recessed so the glass sits ~0.5 mm behind the front lip
     — 3 guarded toggle switches in a row below the screen
  DSKY-style faceplate                                      3U            v0.1
     — HyperPixel + MacroPad + slider + OLED on one panel
  Gridfinity slide-out drawer                               2U            WIP v0.1
  Aux 2U faceplate — CF card reader, SD card holder, panel-mount USB-C, large square cutout
  Assorted: Blu-ray faceplate, simple LCD faceplate, SD holder, hex bit holder

The switch guards are the printable "Space Shuttle Toggle Switch Guard" (ImAThingsGuy,
public domain), 25 × 25 × 30 mm, seated in square anti-rotation recesses over 12 mm
toggle bushings.
</accessories_that_exist>

<not_yet_true>
Do not depict or claim any of the following. If a beat seems to need one, write the beat
without it and flag the gap in your audit section rather than inventing coverage.

  - Game consoles. Nothing in the project supports them, and a 4U × 228.6 mm deep bay
    would not house one. The original brief listed them; they are out.
  - An existing contributor community, third-party modules, forks, or an ecosystem of
    modules made by other people. The project is MIT-licensed and public. That means
    anyone MAY fork it. It does not establish that anyone HAS.
  - Modules that slide in. Almost everything BOLTS — faceplates to the slant inserts,
    equipment ears to the cheek edge faces. The Gridfinity drawer is the only sliding
    element in the project, and it is work-in-progress v0.1.
  - The C2 (2U) and C6 (6U) variants — designated future. The C4-E etched variant — deferred.
    Only C4 exists. Do not show a family of sizes.
  - Any specific download count, star count, user count, or endorsement.
</not_yet_true>
</project_facts>

<audience>
Home-lab and self-hosting people. Makers and 3D-printing enthusiasts. Raspberry Pi and
mini-PC users. Network hobbyists. Retro-computing and space-hardware enthusiasts.
Open-source hardware contributors.

They can tell a real mechanical design from a render that ignores physics, and they will
notice if a screw goes nowhere. Credibility with them is the whole job.
</audience>

<tone>
Professional, technically credible, practical, cinematic without exaggeration.
The register of a polished open-source project launch, not a crowdfunding campaign.
Confident about what the project is; silent about what it isn't yet.
</tone>

<style_bible>
Realistic product cinematography.

Environment: a clean modern workshop or home-lab desk. Dark neutral backgrounds — charcoal,
graphite, warm near-black. Uncluttered. A hint of a wall or window edge for depth, never a
data centre and never a server room.

Light: soft directional studio light, large source, key from upper left, gentle fill,
a controlled specular edge on printed surfaces to reveal layer lines. Practical light from
equipment — the amber and green of small status LEDs, the glow of a mounted display — used
sparingly and in-frame. No coloured wash, no neon rim light, no volumetric haze beams.

Lens: macro and short-telephoto product work. Shallow depth of field. Focus that lands on
one mechanical feature at a time — an insert, a rib, a fastener head, a cable bend.

Camera: restrained. Slow dolly, slow arc, slow rack focus, locked-off macro. Motion measured
in centimetres, not metres. No whip pans, no crash zooms, no handheld shake, no drone moves.

Materials: matte 3D-printed PLA with fine visible 0.2 mm layer lines. Brass inserts that read
as brass. Black anodised or stainless socket-cap screws. Cables that hang and bend with real
weight. Nothing glossy, nothing chrome, nothing that looks injection-moulded.

The film's colour identity: near-black background, warm off-white or light grey printed
parts, brass accents, and small amber and green equipment LEDs.
</style_bible>

<veo_technique>
The shot prompts you write will be run in the Gemini app on Veo 3.1. Write for that target.

Prompt anatomy Veo responds to — assemble every generation prompt in this order:
  [Cinematography] + [Subject] + [Action] + [Context] + [Style & ambiance]
Prose, not keyword lists. Cinematographic vocabulary works: dolly, tracking shot, crane,
slow pan, macro lens, shallow depth of field, deep focus, low angle, extreme close-up.

Duration and format: the Gemini app offers no length control and returned a 10.0 second
clip at 1280x720, 24 fps, 16:9, with a generated audio track (measured 2026-07-29, one
sample). Plan every Veo shot at ~10 seconds and 720p. A 75-90 second film is therefore
8 to 9 Veo-or-Blender shots, not 11 - state the runtime maths from that number.

Excluding things: Veo has no negative-prompt field. Google's guidance is to describe the
absence concretely rather than negate abstractly — "a desolate landscape with no buildings
or roads" rather than "no man-made structures". So write exclusions as short descriptive
clauses inside the prompt body, naming the specific wrong thing you are ruling out.

Audio: Veo generates native audio. Do not put spoken narration in the generation prompt —
model-spoken VO is unreliable and asking for speech invites burnt-in captions. Prompt only
for ambient and effects, in Veo's own notation: "Ambient: the low hum of a quiet workshop."
"SFX: the click of a keycap." Narration is recorded and laid in post.

Image seeding: the app exposes no first-and-last-frame control and no "Ingredients"
picker, but it DOES accept multiple pasted images. Put a PNG on the Windows clipboard
and Ctrl+V into the prompt box; repeat for a second image. Two attached stills plus a
prompt that says "begin as the first image, end as the second" reproduces first-and-last
-frame behaviour by another route. Seed every Veo shot this way - it is the single
biggest quality lever available, by a wide margin.

Measured on this object (2026-07-29), same prompt intent, two runs:

  TEXT ONLY      - closed raked face instead of an open mounting plane; coarse
                   through-cut lattice instead of recessed pockets in a solid border;
                   an invented extra panel; insert holes on panel FACES not edge faces.
                   Beautiful footage of the wrong object.

  IMAGE SEEDED   - correct right-trapezoid cheeks with the 30 degree rake; fine
                   triangular lattice with its solid border; insert columns correctly
                   on the EDGE faces, front and rear; open front bay. Recognisably
                   Console10. Residual errors: part count inflates (cheeks duplicate
                   into lattice and plain versions), some invented strips, interior
                   geometry partly fabricated.

So: seeding fixes identity and silhouette. It does NOT fix part count or interior
truth. Any shot that must be COUNTABLE (twelve inserts, four parts) still belongs in
Blender; any shot that must merely be RECOGNISABLE can be seeded Veo.

*Corrected 2026-08-01: this read "five parts". It is four — two cheeks, a top, a bottom.
In practice the conclusion hardened further than written here: ALL product shots went to
Blender, not merely the countable ones, leaving Veo only shots 01/02/03 where Console10
is not in frame.*

Timestamp prompting: a single ~10-second generation can be directed as timed beats —
  [00:00-00:04] ...   [00:04-00:07] ...   [00:07-00:10] ...
Use this where a shot genuinely has internal movement. Do not use it to smuggle three
separate shots into one generation.

All Veo output carries a SynthID watermark.
</veo_technique>

<generation_rules>
Rules for the footage itself.

Keep all readable text, logos, URLs, repository names and interface graphics OUT of the
generated footage. Video models render text as convincing nonsense. Any screen that appears
in-frame shows abstract non-textual content — a waveform, a plot, a field of indicator
blocks, a slowly moving graph. All titles, labels and the project name go in a separate
post-production overlay field, which you will specify per shot.

Keep the object identical across every shot. The proportions in <geometry_locked> are the
same object each time: same 30° rake, same trapezoid profile, same isogrid pitch, same
insert count and spacing, same colour, same finish. Repeat the continuity block verbatim
in every prompt so each generation starts from the same description.

Show only mounting hardware that could actually work. Screws enter material. Brackets have
something to bracket to. Cables have a plausible origin and destination and hang under
their own weight. An enthusiast audience reads these details first.

Keep hands out unless a hand communicates something a static shot cannot — scale, or an
assembly action. Where a hand is required, specify adult hands, anatomically correct, five
fingers, natural grip, short clean nails, moving at a natural speed, entering from a
specified edge of frame.

Let equipment obey physics: it rests, it is bolted, it is held. It does not float, morph,
pass through other objects, or change size between cuts.

Anything you propose that is not in <project_facts> must be labelled SUGGESTION in the
shot's Purpose line, so it can be approved or cut before generation.
</generation_rules>

<narrative_arc>
Seven beats, in this order:
  1. The problem — small equipment loose on a desk; a 19-inch rack as the wrong answer
  2. The reveal — Console10 assembled, in a controlled studio shot
  3. The system — two mounting planes, faceplates, the U grid
  4. In use — realistic configurations doing real work
  5. Customisation — parametric source, edited, printed, installed
  6. Open source — MIT, forkable, buildable by anyone who wants to
  7. Identity and call to action

Beat 6 states what is true today: the design files are public and MIT-licensed, and anyone
can download, print, modify and redistribute them. Frame this as an open door, not as a
description of activity that has already happened. See <not_yet_true>.
</narrative_arc>

<output_spec>
Produce these sections, in this order, with these labels.

A. CREATIVE CONCEPT — one paragraph.

B. NARRATION SCRIPT — the full VO, timed to 88 seconds, marked with the beat each line
   belongs to. Improve on the draft below without adding claims. Draft to beat:
     "Your hardware doesn't need a full-size rack. It needs a system designed for the way
      you build. Compact. Modular. Printable. Adaptable. An open 10-inch rack platform —
      built by makers, and ready to grow with the community."
   Note: the closing clause of that draft asserts a community that <not_yet_true> rules out.
   Replace it with something true and no less warm.

C. STORYBOARD TABLE — one row per shot: number, timecode in/out, beat, one-line description,
   narration fragment, on-screen overlay text.

D. SHOT PROMPTS — 8 or 9 shots totalling 75–90 seconds. Veo shots run ~10 s (the app
   gives no length control); Blender shots can be any length you specify, so use them to
   trim the total to the target runtime. Each shot gets these twelve fields, in this
   order, at these lengths:

     1.  Shot number
     2.  Duration — ~10s for Veo shots; state the exact figure for Blender shots
     3.  Purpose — one sentence. Prefix with SUGGESTION: if it depicts anything outside
         <project_facts>.
     4.  Visual description — 2–4 sentences, for the human reading the storyboard
     5.  Camera — position, lens, and movement, in one or two sentences
     6.  Lighting and atmosphere — one or two sentences
     7.  Product action — what physically changes across the 8 seconds
     8.  Narration — the VO over this shot, recorded in post, not generated
     9.  Post-production overlay — every word of text that appears on screen, and where.
         This is the only place text is allowed to exist.
     10. Sound design — ambient bed, specific effects, and music cue, for the edit
     11. VEO PROMPT — the complete standalone generation prompt. Self-contained: it opens
         with the continuity block from section E verbatim, then follows Veo's
         [Cinematography] + [Subject] + [Action] + [Context] + [Style & ambiance] anatomy,
         then the exclusion clause, then the "Ambient:" and "SFX:" lines. No spoken dialogue.
         Prose paragraphs. 120–200 words.
     12. GENERATION NOTES — which reference stills to attach (by filename, from the asset
         list you produce in section F); whether to use first-and-last-frame instead of
         text-to-video; whether timestamp prompting applies; and the one failure mode most
         likely to appear in this specific shot, described concretely.

E. CONTINUITY BLOCK — a single paragraph, 90–130 words, describing the object in plain
   physical language a video model can act on. It goes verbatim at the head of all eleven
   VEO PROMPT fields. It must fix: the trapezoid side profile and the 30° rake, the isogrid
   pocket lattice on the outer faces and its solid border, the ~253 mm width and its desk
   scale, the brass insert columns up both the raked front and vertical rear edges, matte
   PLA with visible fine layer lines, and the near-black studio background. Numbers only
   where a number helps the model; otherwise describe the look.

F. ASSET LIST — what to supply from the repository, split into: reference stills for Veo
   ingredients, stills for first-and-last-frame shots, screen-recording captures, and
   overlay artwork. Write every path as a full absolute Windows path beginning
   C:\Users\john_\dev\Console10\ — never a bare filename or a relative path.

G. POST-PRODUCTION — editing rhythm, music direction, typography, colour, and the
   sound-design bed. Brief and specific.

H. 30-SECOND CUT — which shots survive, in what order, with the trimmed narration.

I. THREE OPENING HOOKS — three alternative shot 1s, each with a one-line rationale.

J. AUDIT — the review pass, as a deliverable section, not a process. Report:
   any continuity risk across the eleven shots; any two shots that read as the same shot;
   any claim that <project_facts> does not support; any shot Veo is likely to fail and what
   to do instead; any beat that would be better generated as two shots; and anything you
   placed in overlay that a reader might expect to be in-camera. Where you find a problem,
   state it and give the correction. If a section is empty, say so in one line rather than
   manufacturing findings.
</output_spec>

<example_shot>
This is the standard for section D. Match this level of specificity and this field order.
It is illustrative, not a shot to reuse.

  1. SHOT — 00
  2. DURATION — 8s
  3. PURPOSE — Establish the cheek as a precision structural part, not a decorative panel.
  4. VISUAL — A single Console10 cheek lies flat on a dark graphite work surface, isogrid
     face up. The triangular lattice runs edge to edge, stopping at a solid border. Along
     the near edge, a row of brass inserts catches the light in an uneven grouped rhythm.
     Faint concentric print lines cross the flat ribs.
  5. CAMERA — Macro lens, 15° above the panel, starting tight on three lattice cells and
     dollying back 20 cm to reveal the full trapezoid outline. Focus stays on the near ribs.
  6. LIGHTING — Large soft key from upper left at a low angle so the 5 mm pockets throw
     defined shadows into the lattice. Weak cool fill from the right. Background falls to
     near-black.
  7. PRODUCT ACTION — Nothing moves. All movement is camera. The brass inserts brighten as
     the key angle changes across the pull-back.
  8. NARRATION — none. Music and room tone only.
  9. OVERLAY — none.
  10. SOUND — Ambient: quiet workshop room tone. SFX: none. Music: a low sustained pad
      enters at 00:02.
  11. VEO PROMPT — [continuity block verbatim] Macro lens shot, fifteen degrees above a flat
      dark graphite workbench, beginning tight on three triangular lattice cells and slowly
      dollying back twenty centimetres to reveal the whole trapezoidal panel. The panel is a
      single flat 3D-printed part in matte off-white PLA, its outer face cut with a recessed
      lattice of equilateral triangles on a twenty-millimetre pitch, five millimetres deep,
      with softly filleted corners and a solid unpocketed border framing the pattern. Along
      the near edge, a row of small brass threaded inserts sits flush in the ten-millimetre
      thickness, spaced in an uneven repeating rhythm of threes. Large soft key light from
      the upper left at a low grazing angle casts defined shadows into each pocket; weak
      cool fill from the right; the background falls away to near-black. Fine horizontal
      print layer lines are visible across the flat ribs. Shallow depth of field, the near
      ribs held in focus. A clean empty workbench with no tools, no hands, no printed text
      and no labels anywhere in frame. Ambient: the quiet room tone of an empty workshop.
  12. GENERATION NOTES — Attach C:\Users\john_\dev\Console10\preview\cheek_perimeter_top.png
      and C:\Users\john_\dev\Console10\preview\cheek_perimeter_iso.png as references so the
      trapezoid proportion and lattice pitch survive. Text-to-video, not first-and-last-frame.
      No timestamp
      prompting; the move is continuous. Most likely failure: the lattice regularises into
      a uniform honeycomb and loses the solid border — check the border survives, and if it
      doesn't, re-roll with the border clause moved to the front of the description.
</example_shot>

<working_agreements>
Deliver sections A through J at the scope specified, and finish all of them. Make routine
creative calls yourself. Raise a question only where two readings of the brief would produce
materially different films. If part of the brief looks mistaken, say so in one sentence and
proceed with it as written rather than quietly changing it.

Match length to substance. Eleven shots at twelve fields each is already long; do not pad
it with restatements of the continuity block outside the VEO PROMPT fields, or with summary
sections that repeat the storyboard table.

Write sections A, B, G and J as prose. Use tables for section C and the field structure for
section D.

Work in one pass. Section J is a deliverable, not a re-checking loop over your own output.

Do not delegate this to subagents; it is one continuous creative document and splitting it
across agents will break continuity between shots.

=== END PROMPT ===
```

---

## PART 2 — WHAT CHANGED, AND WHY

### Corrections to the product description

Your original brief described "an open-source modular 10-inch rack system… for home labs, network equipment, small computers, storage devices, game consoles, Raspberry Pi systems, and custom electronics." That's the category, not your project. Replaced throughout with Console10's actual identity, geometry, and the two-plane mounting idea, which is the thing nothing else in the 10-inch space does.

The "modules slide or fasten into place" sequence you proposed doesn't match the mechanism. Faceplates bolt to slant inserts; equipment ears bolt to the cheek edge faces. Exactly one thing in the project slides, and it's the WIP Gridfinity drawer. Corrected, because an audience of makers will notice a bolted system depicted as a sliding one.

### Corrections forced by Veo

**Shot length.** You wrote "favor shots lasting 5–8 seconds." Veo generates 4, 6, or 8 — nothing else. And 8 seconds is *required* for both 1080p and reference images. So the whole film standardises at 8s, and 11 shots lands at 88 seconds, inside your 75–90 window. This is the change with the largest knock-on effect: it set the shot count.

**Your field 12 doesn't exist as a field.** You asked for "a negative prompt describing likely visual errors to prevent." Veo has no negative-prompt input. Google's documented technique is to describe the absence concretely inside the prompt — their example is *"a desolate landscape with no buildings or roads"* rather than *"no man-made structures."* So field 12 was repurposed into GENERATION NOTES (references, first-and-last-frame, failure modes) and the exclusion moved into the prompt body as a descriptive clause. You lose nothing; you just place it differently.

**Narration must not be generated.** Veo 3.1 produces native synchronised audio, including speech. Prompting for spoken narration is how you get unusable VO and burnt-in captions. The brief now instructs ambient and SFX only, with narration recorded and laid in post. This is a precaution based on the fact that Veo generates speech from prompts — Google's guide doesn't document a caption-suppression technique, so I'd rather route around it than rely on one.

**Reference images are the continuity answer.** You asked for continuity via "consistently repeating the important physical details." That helps, but Veo 3.1 takes up to 3 reference images to hold a subject consistent across shots, and you have real renders of the real geometry sitting in `C:\Users\john_\dev\Console10\preview\`. Text will not reliably reproduce a 30° raked trapezoid with 20 mm isogrid pitch. Your own renders will. The brief now asks for per-shot reference nominations.

Two Veo techniques you didn't ask for, added because they fit: **first-and-last-frame** (generate a start still and an end still, let Veo produce the transition — ideal for the exploded view) and **timestamp prompting** (`[00:00-00:03] … [00:03-00:06] …` inside one 8s generation, for shots with real internal movement).

### Opus 5 tuning

| Change | Why |
|---|---|
| Everything wrapped in XML sections | Anthropic's guidance: XML tags let the model parse mixed instructions, context, and examples unambiguously |
| Facts moved to the top, task moved to the bottom | Documented long-context behaviour — longform data first, query last, worth up to ~30% on complex multi-document inputs |
| One fully-worked example shot added | Examples are the most reliable way to steer output format and structure. This is the highest-value single addition in the rewrite |
| "Do not…" converted to positive instruction | "Tell Claude what to do instead of what not to do." Your negatives became "Keep text out of footage," "Show only hardware that could work," etc. |
| Your final "before finalizing, inspect for…" pass reframed as deliverable Section J | Opus 5 verifies its own work unprompted. Anthropic explicitly says to *remove* verification instructions — they cause over-verification and waste tokens with no quality gain. You still get the audit; it's just an output section instead of a process loop |
| Explicit length caps per field | Opus 5's written deliverables run long by default; the guidance is to add explicit length calibration |
| Scope-control paragraph added | Opus 5 tends to expand task scope. The `<working_agreements>` block is close to Anthropic's recommended wording |
| Subagent delegation blocked | Opus 5 delegates readily; here it would break shot-to-shot continuity |
| No CAPS, no "CRITICAL/MUST" | Newer models over-trigger on aggressive phrasing. Normal imperative reads better |
| Effort: xhigh, thinking on | Anthropic recommends xhigh for demanding creative and agentic work |

One thing I deliberately did **not** do: your instruction "Do not invent project features that I have not supplied" was good and stays, strengthened into an explicit `<not_yet_true>` enumeration. Naming what's false works better than a general prohibition.

---

## PART 3 — CLAIMS AUDIT

Every claim in your original brief the repository does not substantiate.

**"Game consoles"** — appears in your audience list and your uses list. No support anywhere in the project, and a 4U bay 228.6 mm deep won't take one. There's a Blu-ray faceplate; that's the nearest thing. *Removed.*

**"Community-driven," "built by makers," "ready to grow with the community"** — the repo has an MIT licence and a GitHub remote (`git@github.com:johnmknight/Console10.git`). That establishes that anyone *may* fork it. There's no contributor file, no third-party module, no issue history I can see from the working tree. *Reframed as an open door — true — rather than existing activity.*

**"Users can… design compatible modules, and contribute improvements"** — the first half is true and well supported: parametric OpenSCAD, documented interface specs, a locked U grid. The second half describes a contribution flow that isn't evidenced. *Kept the first half, dropped the second.*

**"A community-driven 10-inch rack ecosystem"** — "ecosystem" implies multiple participants. *Reduced to the system itself, which is real and substantial.*

**"Show modules sliding or fastening into place, including representative network, storage, computing, console, and utility modules"** — you hedged this yourself ("do not claim that every module already exists unless I confirm it"), correctly. The actual faceplate list is in `<accessories_that_exist>` and it's genuinely impressive. *Replaced invented module categories with the real ones.*

**Unverified, flagged rather than removed:** I read the git remote from `C:\Users\john_\dev\Console10\.git\config`. I did **not** check whether `https://github.com/johnmknight/Console10` is actually public and live — that's an SSH remote in a local config, which tells me where it pushes, not what the world can see. Confirm before the CTA points anyone at it.

**Project state worth knowing before you announce:** `designdoc.md` §13 still lists open items — final module width reconciliation, front-insert merge-vs-glue, glue-vs-fasteners, and first-print validation of the 0.4 mm ridge/rabbet clearance. §15 notes `Console10_drawer.scad` is untracked and uncommitted. None of this stops a video. It does mean the drawer shouldn't be a hero shot.

---

## PART 4 — ASSETS TO ATTACH

Real files, verified present.

**Strongest reference-image candidates for Veo ingredients**

```
C:\Users\john_\dev\Console10\preview\asm_room.png
C:\Users\john_\dev\Console10\preview\asm_macropad_iso.png
C:\Users\john_\dev\Console10\preview\asm_macropad_side.png
C:\Users\john_\dev\Console10\preview\cheek_perimeter_iso.png
C:\Users\john_\dev\Console10\preview\cheek_perimeter_top.png
C:\Users\john_\dev\Console10\preview\cheek_v22_through.png
C:\Users\john_\dev\Console10\preview\mp_pair_iso.png
C:\Users\john_\dev\Console10\preview\mp_pair_front.png
C:\Users\john_\dev\Console10\preview\dsky_iso.png
C:\Users\john_\dev\Console10\preview\dsky_front.png
C:\Users\john_\dev\Console10\preview\screen_slider_iso.png
C:\Users\john_\dev\Console10\preview\screen_slider_front.png
C:\Users\john_\dev\Console10\preview\hp_sq_iso.png
```

**Whole-object views**

```
C:\Users\john_\dev\Console10\_asm_iso.png
C:\Users\john_\dev\Console10\_asm_side.png
C:\Users\john_\dev\Console10\_module.png
C:\Users\john_\dev\Console10\_stl_iso.png
C:\Users\john_\dev\Console10\_top_iso.png
C:\Users\john_\dev\Console10\_u_iso.png
```

**Overlay artwork**

```
C:\Users\john_\dev\Console10\branding\console10_logo_dark.svg
C:\Users\john_\dev\Console10\branding\console10_logo_light.svg
C:\Users\john_\dev\Console10\branding\console10_mark.svg
C:\Users\john_\dev\Console10\branding\console10_social_preview.png
```

**Worth shooting or capturing yourself**, since Veo can't fabricate them credibly: a real print in progress on the Centauri Carbon; a real heat-set insert going in with an iron; an OpenSCAD screen recording of a parameter change re-rendering; and the assembled unit on your actual desk. Live-action inserts among generated footage will raise the credibility of the whole piece.

---

## Sources

- [Prompting Claude Opus 5 — Claude Docs](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5)
- [Prompting best practices — Claude Docs](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices)
- [Ultimate prompting guide for Veo 3.1 — Google Cloud Blog](https://cloud.google.com/blog/products/ai-machine-learning/ultimate-prompting-guide-for-veo-3-1)
- [Video generation in the Gemini API — Google AI for Developers](https://ai.google.dev/gemini-api/docs/video)
- `C:\Users\john_\dev\Console10\designdoc.md`
- `C:\Users\john_\dev\Console10\README.md`
- `C:\Users\john_\dev\Console10\Console10_interface_specs.md`
