"""
Console10 — Tri-Hex Isogrid preview generator.
Renders SVG from the same parametric math as the OpenSCAD source so the
two outputs stay in sync. Defaults per Design Doc v1.0.
"""
import math

# ----- Parameters (match Console10_isogrid.scad defaults) -----
S = 20.0           # spacing / cell side length (mm)
T = 2.5            # rib thickness (mm)
W = 230.0          # panel width (mm)
H = 160.0          # panel height (mm)

SQRT3 = math.sqrt(3)
INSET = T / 2

# Insetted cell sides (perpendicular distance from each edge = INSET)
HEX_SIDE_IN = S - 2 * INSET / SQRT3
TRI_SIDE_IN = S - 2 * SQRT3 * INSET

# Print derived dims for sanity
print(f"Hex pocket: side={HEX_SIDE_IN:.3f} mm, apothem={HEX_SIDE_IN*SQRT3/2:.3f} mm")
print(f"Tri pocket: side={TRI_SIDE_IN:.3f} mm, apothem={TRI_SIDE_IN*SQRT3/6:.3f} mm")
print(f"Triangle height: {S*SQRT3/2:.3f} mm")

# ----- Cell geometry -----
def hex_verts(cx, cy, side):
    return [(cx + side*math.cos(math.radians(60*k)),
             cy + side*math.sin(math.radians(60*k))) for k in range(6)]

def tri_up_verts(cx, cy, side):
    h = side * SQRT3 / 2
    return [(cx - side/2, cy - h/3),
            (cx + side/2, cy - h/3),
            (cx,          cy + 2*h/3)]

def tri_down_verts(cx, cy, side):
    h = side * SQRT3 / 2
    return [(cx - side/2, cy + h/3),
            (cx + side/2, cy + h/3),
            (cx,          cy - 2*h/3)]

# ----- Lattice -----
# Hex centers: P_ij = i*(2s, 0) + j*(s, s*sqrt(3))
# Per fundamental cell: 1 hex + 1 up-tri (offset (s, s*sqrt(3)/3)) + 1 down-tri (offset (0, -2s*sqrt(3)/3))
LIM = math.ceil((W + H) / S) + 5

hex_centers, up_centers, down_centers = [], [], []
for j in range(-LIM, LIM + 1):
    for i in range(-LIM, LIM + 1):
        cx = 2*S*i + S*j
        cy = S*SQRT3*j
        # Quick reject — only keep centers whose polygon could intersect panel
        if -2*S <= cx <= W + 2*S and -2*S <= cy <= H + 2*S:
            hex_centers.append((cx, cy))
        ucx, ucy = cx + S, cy + S*SQRT3/3
        if -2*S <= ucx <= W + 2*S and -2*S <= ucy <= H + 2*S:
            up_centers.append((ucx, ucy))
        dcx, dcy = cx, cy - 2*S*SQRT3/3
        if -2*S <= dcx <= W + 2*S and -2*S <= dcy <= H + 2*S:
            down_centers.append((dcx, dcy))

print(f"Hexes: {len(hex_centers)}, Up-tris: {len(up_centers)}, Down-tris: {len(down_centers)}")

# ----- SVG output -----
# Scale up for readability; flip y so +y is up (CAD convention)
SCALE = 3
def fmt(verts):
    return " ".join(f"{x*SCALE:.2f},{(H-y)*SCALE:.2f}" for x, y in verts)

# Aerospace-anodized palette
PANEL_FILL = "#3a4148"     # titanium gray
POCKET_FILL = "#15181c"    # shadow
RIB_HIGHLIGHT = "#5a6168"  # subtle top-edge highlight
BORDER = "#1a1d20"

svg = [
    f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {W*SCALE} {H*SCALE}" '
    f'width="{W*SCALE}" height="{H*SCALE}">',
    '<defs>',
    '  <clipPath id="panel">',
    f'    <rect width="{W*SCALE}" height="{H*SCALE}"/>',
    '  </clipPath>',
    '  <linearGradient id="panelGrad" x1="0" y1="0" x2="0" y2="1">',
    f'    <stop offset="0%" stop-color="{RIB_HIGHLIGHT}"/>',
    f'    <stop offset="40%" stop-color="{PANEL_FILL}"/>',
    f'    <stop offset="100%" stop-color="#2a3036"/>',
    '  </linearGradient>',
    '  <filter id="pocketShadow" x="-10%" y="-10%" width="120%" height="120%">',
    '    <feGaussianBlur in="SourceAlpha" stdDeviation="0.6"/>',
    '    <feOffset dx="0.4" dy="0.6" result="off"/>',
    '    <feMerge><feMergeNode in="off"/><feMergeNode in="SourceGraphic"/></feMerge>',
    '  </filter>',
    '</defs>',
    f'<rect width="{W*SCALE}" height="{H*SCALE}" fill="url(#panelGrad)"/>',
    f'<g clip-path="url(#panel)" filter="url(#pocketShadow)">',
]

for cx, cy in hex_centers:
    svg.append(f'  <polygon points="{fmt(hex_verts(cx, cy, HEX_SIDE_IN))}" fill="{POCKET_FILL}"/>')
for cx, cy in up_centers:
    svg.append(f'  <polygon points="{fmt(tri_up_verts(cx, cy, TRI_SIDE_IN))}" fill="{POCKET_FILL}"/>')
for cx, cy in down_centers:
    svg.append(f'  <polygon points="{fmt(tri_down_verts(cx, cy, TRI_SIDE_IN))}" fill="{POCKET_FILL}"/>')

svg.append('</g>')
# Panel outline
svg.append(f'<rect width="{W*SCALE}" height="{H*SCALE}" fill="none" stroke="{BORDER}" stroke-width="2"/>')
svg.append('</svg>')

with open("/home/claude/console10/Console10_preview.svg", "w") as f:
    f.write("\n".join(svg))
print("Wrote Console10_preview.svg")
