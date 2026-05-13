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

# Commands that only inspect the system (matched at the start of the command body).
READ_ONLY_COMMAND = re.compile(
    r"(?:"
    r"man\b|info\b|apropos\b|whatis\b|help\b|"
    r"cut\b|sort\b|uniq\b|head\b|tail\b|sed\b|awk\b|grep\b|pgrep\b|"
    r"id\b|getent\b|whoami\b|groups\b|"
    r"ip\s+(?:addr|a|route|link)\b|"
    r"ps\b|jobs\b|"
    r"ls\b|cat\b|wc\b|file\b|stat\b|type\b|which\b|"
    r"df\b|du\b|"
    r"getenforce\b|sestatus\b|"
    r"vimtutor\b|"
    r"systemctl\s+(?:status|list|is-|show)\b|"
    r"journalctl\b|"
    r"dnf\s+(?:list|info|search|repolist|provides)\b|"
    r"rpm\s+-q[a-z]*\b|"
    r"nmcli\s+(?:general|device|dev|connection|con)\s+(?:show|status)?\b|"
    r"nmcli\s+(?:device|dev|connection|con)\b|"
    r"firewall-cmd\s+--(?:list|get|state)\b|"
    r"ss\b|"
    r"atq\b|"
    r"findmnt\s+--verify\b|"
    r"blkid\b|"
    r"timedatectl\s+(?:status|show)\b|"
    r"hostnamectl\s+status\b|"
    r"nice\b|"
    r"sleep\b"
    r")"
)

MUTATING_PATTERNS = (
    re.compile(r"\buseradd\b"),
    re.compile(r"\bgroupadd\b"),
    re.compile(r"\busermod\b"),
    re.compile(r"\buserdel\b"),
    re.compile(r"\bgroupdel\b"),
    re.compile(r"\bchpasswd\b"),
    re.compile(r"(?:^|\s)passwd\s+\S"),
    re.compile(r"\bvisudo\b"),
    re.compile(r"\bfirewall-cmd\b.*--(?:add|remove|new|delete|set|reload)\b"),
    re.compile(r"\bnmcli\b.*\b(?:add|modify|mod|delete|up|down|import)\b"),
    re.compile(
        r"\bsystemctl\s+(?:start|stop|restart|reload|enable|disable|mask|unmask|"
        r"daemon-reload|set-default|link|reboot|poweroff|halt|suspend)\b"
    ),
    re.compile(r"\bdnf\s+(?:install|remove|erase|update|upgrade|reinstall|downgrade|autoremove|swap)\b"),
    re.compile(r"\brpm\s+(?:-i|-e|-U|--install|--erase|--upgrade|-F|--freshen)\b"),
    re.compile(r"\bsemanage\b"),
    re.compile(r"\bsetsebool\b"),
    re.compile(r"\brestorecon\b"),
    re.compile(r"\bchcon\b"),
    re.compile(r"\btee\b.*(?:/etc/|>>\s*/etc/)"),
    re.compile(r"(?<!\w)mount\b(?!mnt\s+--verify)"),
    re.compile(r"\bmkfs\."),
    re.compile(r"\bmkswap\b"),
    re.compile(r"\bswapon\b"),
    re.compile(r"\bswapoff\b"),
    re.compile(r"\blvcreate\b"),
    re.compile(r"\bvgcreate\b"),
    re.compile(r"\bpvcreate\b"),
    re.compile(r"\blvremove\b"),
    re.compile(r"\bvgremove\b"),
    re.compile(r"\bpvremove\b"),
    re.compile(r"\blvextend\b"),
    re.compile(r"\bparted\b"),
    re.compile(r"\bfdisk\b"),
    re.compile(r"\bcrontab\b.*\s-u\s"),
    re.compile(r"^\s*at\s+"),
    re.compile(r"\bhostnamectl\s+set\b"),
    re.compile(r"\btimedatectl\s+set-"),
    re.compile(r"\bflatpak\s+install\b"),
    re.compile(r"\bflatpak\s+remote-add\b"),
    re.compile(r"\bupdate-crypto-policies\b"),
)

USER_SPACE_MUTATING_PATTERNS = (
    re.compile(r"\bmkdir\b"),
    re.compile(r"\bchmod\b"),
    re.compile(r"\bchown\b"),
    re.compile(r"\bchattr\b"),
    re.compile(r"\bln\s+-s\b"),
    re.compile(r"\bssh-keygen\b"),
    re.compile(r"\bkill\b"),
    re.compile(r"\brenice\b"),
    re.compile(r"\bfallocate\b"),
    re.compile(r"\bssh-copy-id\b"),
    re.compile(r"\bcrontab\b(?!.*\s-l\b)"),
)

USER_SCOPE_RE = re.compile(r"(?:flatpak\b[^\n]*\s--user\b|ssh-copy-id\b)")

SYSTEM_PATH_RE = re.compile(
    r"""(?:^|[\s"'`=])(?:/etc(?:/|\s|$)|/mnt(?:/|\s|$)|/usr(?:/|\s|$)|"""
    r"""/var(?:/|\s|$)|/opt(?:/|\s|$)|/srv(?:/|\s|$)|/root(?:/|\s|$)|/boot(?:/|\s|$))"""
)


def references_system_path(line: str) -> bool:
    return bool(SYSTEM_PATH_RE.search(line))


def executable_lines(content: str) -> list[str]:
    lines = []
    for line in content.splitlines():
        stripped = line.strip()
        if stripped and not stripped.startswith("#"):
            lines.append(stripped)
    return lines


def command_body(line: str) -> str:
    """Return the command after sudo and trailing background operators."""
    body = re.sub(r"\s*&\s*$", "", line.strip())
    body = re.sub(r"^(?:sudo\s+)+", "", body)
    return body.strip()


def line_is_read_only(line: str) -> bool:
    if not line.strip():
        return True
    if re.match(r"^[A-Za-z_][A-Za-z0-9_]*=", line):
        return True
    body = command_body(line)
    if body.startswith(("echo ", "printf ")):
        return True
    return bool(READ_ONLY_COMMAND.match(body))


def line_is_mutating(line: str) -> bool:
    if not line.strip() or line_is_read_only(line):
        return False
    if any(pattern.search(line) for pattern in MUTATING_PATTERNS):
        return True
    if any(pattern.search(line) for pattern in USER_SPACE_MUTATING_PATTERNS):
        return True
    if re.search(r"\bsudo\b", line):
        return not line_is_read_only(line)
    return False


def line_needs_root(line: str) -> bool:
    if not line.strip() or line_is_read_only(line):
        return False
    if USER_SCOPE_RE.search(line):
        return False
    if re.search(r"\bsudo\b", line):
        return True
    if any(pattern.search(line) for pattern in MUTATING_PATTERNS):
        return True
    if any(pattern.search(line) for pattern in USER_SPACE_MUTATING_PATTERNS):
        return references_system_path(line)
    return False


def is_mutating(content: str) -> bool:
    return any(line_is_mutating(line) for line in executable_lines(content))


def needs_root(content: str) -> bool:
    return any(line_needs_root(line) for line in executable_lines(content))


def is_safe(content: str) -> bool:
    """Safe when read-only or mutations stay in the current user's scope."""
    if INSTRUCTIONAL_MARKER in content:
        return True
    for line in executable_lines(content):
        if line_is_read_only(line):
            continue
        if line_needs_root(line):
            return False
    return True


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

    safe = "yes" if is_safe(content) else "no"

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
