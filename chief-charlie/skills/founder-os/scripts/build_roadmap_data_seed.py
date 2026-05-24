#!/usr/bin/env python3
"""Concatenate the three paths' roadmap_defaults.json into one merged seed.

The merged seed (templates/roadmap_data.seed.json) is what onboarding copies
into every user's roadmap_data.json so the roadmap canvas can render full
detail tabs for every step regardless of the user's active path.

Run this whenever any paths/<path>/roadmap_defaults.json changes.
A consistency test fails if the committed seed drifts from the sources.
"""
import json
from pathlib import Path

FOS = Path(__file__).resolve().parent.parent
PATHS = ["pmf", "gtm", "scale"]
OUT = FOS / "templates" / "roadmap_data.seed.json"


def build():
    merged = {"schema_version": 1, "steps": {}}
    for path in PATHS:
        src = FOS / "paths" / path / "roadmap_defaults.json"
        data = json.loads(src.read_text())
        for step_id, step in data.get("steps", {}).items():
            if step_id in merged["steps"]:
                raise ValueError(f"duplicate step id {step_id!r} across paths")
            merged["steps"][step_id] = step
    return merged


if __name__ == "__main__":
    merged = build()
    OUT.write_text(json.dumps(merged, indent=2, ensure_ascii=False) + "\n")
    print(f"wrote {OUT} with {len(merged['steps'])} steps: {sorted(merged['steps'])}")
