#!/usr/bin/env python3
"""Insert @type/@requires/@safe metadata and set -euo pipefail into exercise scripts."""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SHEBANG = "#!/bin/bash"
STRICT = "set -euo pipefail"
META_PREFIX = "# @"
INSTRUCTIONAL_MARKER = 'echo "This script demonstrates'

DESTRUCTIVE_PATTERNS = (
    re.compile(r"\bsudo\b"),
    re.compile(r"\buseradd\b"),
    re.compile(r"\bgroupadd\b"),
    re.compile(r"\busermod\b"),
    re.compile(r"\buserdel\b"),
    re.compile(r"\bgroupdel\b"),
    re.compile(r"\bchpasswd\b"),
    re.compile(r"\bpasswd\b"),
    re.compile(r"\bvisudo\b"),
    re.compile(r"\bfirewall-cmd\b"),
    re.compile(r"\bnmcli\b"),
    re.compile(r"\bsystemctl\b"),
    re.compile(r"\bdnf\b"),
    re.compile(r"\brpm\b"),
    re.compile(r"\bsemanage\b"),
    re.compile(r"\bsetsebool\b"),
    re.compile(r"\brestorecon\b"),
    re.compile(r"\bchcon\b"),
    re.compile(r"tee\s+-a\s+/etc/"),
    re.compile(r"\bmount\b"),
    re.compile(r"\bmkfs\."),
    re.compile(r"\blvcreate\b"),
    re.compile(r"\bvgcreate\b"),
    re.compile(r"\bpvcreate\b"),
    re.compile(r"\bparted\b"),
    re.compile(r"\bfdisk\b"),
    re.compile(r"\bcrontab\b"),
    re.compile(r"\bat\b"),
    re.compile(r"\bhostnamectl\b"),
    re.compile(r"\btimedatectl\s+set-"),
)


def executable_lines(content: str) -> list[str]:
    lines = []
    for line in content.splitlines():
        stripped = line.strip()
        if stripped and not stripped.startswith("#"):
            lines.append(line)
    return lines


def needs_root(content: str) -> bool:
    return any(
        pattern.search(line) for line in executable_lines(content) for pattern in DESTRUCTIVE_PATTERNS
    )


def infer_metadata(rel_path: str, content: str) -> tuple[str, str, str]:
    instructional = INSTRUCTIONAL_MARKER in content
    script_type = "instructional" if instructional else "executable"

    requires: list[str] = []
    if instructional:
        if "/dev/sdb" in content:
            requires.append("/dev/sdb")
    else:
        if needs_root(content):
            requires.append("root")
        if "/dev/sdb" in content:
            requires.append("/dev/sdb")

    # Chapters 2–3 logic scripts are safe to run without system changes.
    if instructional:
        safe = "yes"
    elif rel_path.startswith(("chapter_2/", "chapter_3/")) and not needs_root(content):
        safe = "yes"
    elif needs_root(content):
        safe = "no"
    else:
        safe = "yes"

    requires_value = ", ".join(dict.fromkeys(requires)) if requires else "none"
    return script_type, requires_value, safe


def strip_existing_header(lines: list[str]) -> list[str]:
    idx = 0
    if idx < len(lines) and lines[idx].strip() == SHEBANG:
        idx += 1

    while idx < len(lines):
        stripped = lines[idx].strip()
        if stripped == STRICT:
            idx += 1
            continue
        if stripped.startswith(META_PREFIX):
            idx += 1
            continue
        if stripped == "":
            idx += 1
            continue
        break

    return lines[idx:]


def build_header(script_type: str, requires: str, safe: str) -> list[str]:
    header = [
        SHEBANG,
        f"# @type: {script_type}",
        f"# @requires: {requires}",
        f"# @safe: {safe}",
    ]
    if script_type == "executable":
        header.append(STRICT)
    header.append("")
    return header


def process_file(path: Path) -> bool:
    rel_path = path.relative_to(ROOT).as_posix()
    original = path.read_text(encoding="utf-8")
    lines = original.splitlines(keepends=True)
    body_lines = [line.rstrip("\n") for line in strip_existing_header(lines)]
    body = "\n".join(body_lines)
    if body and not body.endswith("\n"):
        body += "\n"

    script_type, requires, safe = infer_metadata(rel_path, body)
    new_content = "\n".join(build_header(script_type, requires, safe)) + "\n" + body.lstrip("\n")

    if new_content != original:
        path.write_text(new_content, encoding="utf-8")
        return True
    return False


def main() -> None:
    changed = 0
    for path in sorted(ROOT.glob("chapter_*/*.sh")):
        if process_file(path):
            changed += 1
            print(f"updated {path.relative_to(ROOT)}")
    print(f"Done. Updated {changed} file(s).")


if __name__ == "__main__":
    main()
