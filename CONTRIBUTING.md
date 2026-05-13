# Contributing

Thank you for helping improve the exercise answer scripts for the [Red Hat RHCSA 10 Study Companion](https://link.springer.com/book/9798868822254).

## Before you start

- Match the book exercise numbering and intent.
- Use a **disposable RHEL 10 lab VM** when testing scripts that change system state.
- Do not run destructive scripts on production hosts or your daily workstation.

## Repository layout

| Path | Purpose |
|------|---------|
| `chapter_N/exercise_MM.sh` | Answer scripts grouped by book chapter |
| `chapters.yaml` | Chapter titles, summaries, and topics (used by the Pages site) |
| `scripts/build_site.py` | Builds the GitHub Pages site from `chapters.yaml` |
| `scripts/apply_script_headers.py` | Re-applies script metadata headers in bulk |

Chapter metadata belongs in **`chapters.yaml`** only. Update that file instead of duplicating titles or topic lists elsewhere.

## Script conventions

Every script must start with:

```bash
#!/bin/bash
# @type: executable | instructional
# @requires: none | root | /dev/sdb | root, /dev/sdb
# @safe: yes | no
```

- **`instructional`**: prints steps only; does not modify the system. Do **not** add `set -euo pipefail`.
- **`executable`**: runs commands. Add `set -euo pipefail` immediately after the metadata block.

Naming:

- Standard exercises: `exercise_NN.sh` (presented in the book)
- Extra exercises (chapters 2–3): `exercise_extra_NN.sh`

## Local validation

Install ShellCheck, then run:

```bash
# Syntax check
while IFS= read -r script; do bash -n "$script"; done < <(find chapter_* -name '*.sh' | sort)

# ShellCheck (same exclusions as CI)
find chapter_* -name '*.sh' -print0 | xargs -0 shellcheck -e SC1090,SC1091,SC2009,SC2034,SC2035,SC2038,SC2086,SC2154,SC2162
```

Build the static site locally:

```bash
pip install pyyaml
python3 scripts/build_site.py
open site/index.html
```

Re-apply metadata headers after bulk edits:

```bash
python3 scripts/apply_script_headers.py
```

## Pull requests

1. Keep changes focused on one chapter or concern when possible.
2. Run the validation commands above before opening a PR.
3. Update `chapters.yaml` if chapter titles or topics change.
4. Note in the PR whether scripts were tested on a lab VM and which exercises were affected.

## Questions

Open an issue in the [repository](https://github.com/andreyamarkelov/adminbook) with the chapter and exercise number.
