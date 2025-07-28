#!/usr/bin/env python3
"""
update_moon_phase.py – overwrite `#define MOON_PHASE` in moon.glsl
so that it reflects today's lunar phase. Intended for daily cron use.
"""

import argparse
import logging
import math
import os
import re
import sys
from datetime import datetime, timezone
from pathlib import Path
from tempfile import NamedTemporaryFile

# ---------- Moon-phase math ---------------------------------------------------

SYNODIC = 29.530588853                # days
JD_REF  = 2451550.1                  # 2000-01-06 18:14 UTC

def julian(dt: datetime) -> float:    # dt must be TZ-aware
    return dt.timestamp() / 86400.0 + 2440587.5

def phase_fraction(dt_utc: datetime = None) -> float:
    dt_utc = dt_utc or datetime.now(timezone.utc)
    age    = (julian(dt_utc) - JD_REF) % SYNODIC
    return age / SYNODIC               # 0.0 … <1.0

# ---------- File patching -----------------------------------------------------

DEFINE_RE = re.compile(
    r'(^\s*#\s*define\s+MOON_PHASE\s+)([0-9]*\.?[0-9]+)(\s*.*$)',
    re.MULTILINE,
)

def patch_shader(path: Path, phase: float, dry_run: bool = False) -> None:
    logging.info("Reading %s", path)
    src = path.read_text()

    new_src, n = DEFINE_RE.subn(rf"\g<1>{phase:.6f}\g<3>", src)
    if n != 1:
        raise RuntimeError(f"Expected exactly one MOON_PHASE define, found {n}")

    if dry_run:
        print(new_src, end="")
        logging.info("Dry-run finished, no write.")
        return

    logging.info("Writing new phase %.6f", phase)
    with NamedTemporaryFile("w", delete=False, dir=path.parent) as tf:
        tf.write(new_src)
        temp_name = tf.name
    os.replace(temp_name, path)        # atomic on POSIX

# ---------- CLI / main --------------------------------------------------------

def make_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(description="Keep a GLSL moon-phase define up-to-date.")
    p.add_argument("shader", type=Path, nargs='?', 
                  default=Path(__file__).parent / "moon.glsl",
                  help="GLSL file to edit in-place (default: moon.glsl)")
    p.add_argument("--dry-run", action="store_true", help="Print result, do not write")
    return p

def main(argv: list = None) -> None:
    args = make_parser().parse_args(argv)
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")

    if not args.shader.exists():
        sys.exit(f"Shader file {args.shader} does not exist.")
    if not args.dry_run and not os.access(args.shader, os.W_OK):
        sys.exit(f"Shader file {args.shader} is not writable.")

    phase = phase_fraction()
    assert 0.0 <= phase < 1.0, "Phase calculation out of range?"

    patch_shader(args.shader, phase, dry_run=args.dry_run)
    logging.info("All done. Current moon phase: %.6f", phase)

if __name__ == "__main__":
    main()