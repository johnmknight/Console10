"""Which parts make a Console10 cabinet? Ask the SCAD, never guess.

Console10_module.scad carries CABINET_PARTS and ACCESSORY_PARTS. This module
parses them. It is the only place any render learns the cabinet set, and it has
NO hardcoded fallback on purpose: a fallback list is exactly how the count
drifted twice already (the slant cap, then the front slant insert). If the SCAD
cannot be read, the render must fail loudly rather than quietly render the
wrong number of bodies against a narration that states a number.

Usage:
    from _parts import CABINET, ACCESSORY, cabinet_only
    DIRS = cabinet_only(DIRS)

Importable from a Blender headless script: pure stdlib, no bpy.
"""
import os
import re

SCAD = r"C:\Users\john_\dev\Console10\Console10_module.scad"


def _read_list(name, src):
    m = re.search(re.escape(name) + r"\s*=\s*\[(.*?)\]", src, re.S)
    if not m:
        raise RuntimeError(
            "%s not found in %s.\n"
            "The SCAD is the authority for the cabinet set. Do not add a\n"
            "fallback list here to make this error go away - that reintroduces\n"
            "the drift this module exists to prevent. Fix the SCAD." % (name, SCAD))
    return [s.strip().strip('"').strip("'")
            for s in m.group(1).split(",") if s.strip()]


def _load():
    if not os.path.exists(SCAD):
        raise RuntimeError("cabinet set unavailable - missing %s" % SCAD)
    with open(SCAD, encoding="utf-8", errors="replace") as fh:
        src = fh.read()
    cab = _read_list("CABINET_PARTS", src)
    acc = _read_list("ACCESSORY_PARTS", src)
    overlap = set(cab) & set(acc)
    if overlap:
        raise RuntimeError("a part cannot be both cabinet and accessory: %s"
                           % sorted(overlap))
    return cab, acc


CABINET, ACCESSORY = _load()


def cabinet_only(dirs):
    """Filter a part->direction dict down to the cabinet set.

    Raises if the dict is missing a cabinet part, because a silently short
    explode is the failure this whole module exists to stop. Accessories are
    dropped quietly - they are legitimately present in the export.
    """
    missing = [p for p in CABINET if p not in dirs]
    if missing:
        raise RuntimeError(
            "DIRS is missing cabinet part(s) %s. The cabinet set is %s "
            "(from %s). Every cabinet part needs a travel direction."
            % (missing, CABINET, SCAD))
    return dict((k, v) for k, v in dirs.items() if k in CABINET)


def describe():
    return ("cabinet set (%d): %s   |   accessories (%d): %s"
            % (len(CABINET), ", ".join(CABINET),
               len(ACCESSORY), ", ".join(ACCESSORY)))


if __name__ == "__main__":
    print(describe())
