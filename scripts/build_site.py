#!/usr/bin/env python3
"""Build the GitHub Pages static site from chapters.yaml and exercise scripts."""

from __future__ import annotations

import html
import re
import shutil
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
SITE_DIR = ROOT / "site"

HIGHLIGHT_CSS = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/github-dark.min.css"
HIGHLIGHT_JS = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"
BASH_JS = "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/bash.min.js"

BASE_STYLE = """
body{font-family:Arial,Helvetica,sans-serif;max-width:1080px;margin:2rem auto;padding:0 1rem;line-height:1.45;color:#1f1f1f}
a{color:#0b57d0;text-decoration:none}a:hover{text-decoration:underline}
h1,h2,h3{line-height:1.2}
.muted{color:#555}
li{margin:.35rem 0}
hr{margin:1.5rem 0;border:none;border-top:1px solid #ddd}
.toc{background:#f6f8fa;border:1px solid #e1e4e8;border-radius:.5rem;padding:1rem 1.25rem;margin:1.25rem 0}
.toc ul{margin:.5rem 0 0;padding-left:1.25rem}
.exercise{margin:2rem 0 2.5rem}
.exercise-header{display:flex;flex-wrap:wrap;align-items:center;gap:.75rem;margin-bottom:.75rem}
.badge{display:inline-block;padding:.15rem .55rem;border-radius:999px;font-size:.8rem;font-weight:600}
.badge-safe{background:#e6f4ea;color:#137333}
.badge-unsafe{background:#fce8e6;color:#c5221f}
.badge-instructional{background:#e8f0fe;color:#174ea6}
.badge-executable{background:#f1f3f4;color:#3c4043}
.code-wrap{position:relative}
.copy-btn{position:absolute;top:.5rem;right:.5rem;border:1px solid #444;background:#222;color:#f4f4f4;border-radius:.35rem;padding:.35rem .6rem;font-size:.8rem;cursor:pointer}
.copy-btn:hover{background:#333}
pre{margin:0;padding:1rem;border-radius:.5rem;overflow:auto}
code.hljs{font-family:ui-monospace,SFMono-Regular,Menlo,Consolas,monospace;font-size:.92rem}
.actions{display:flex;flex-wrap:wrap;gap:.75rem;margin-top:.5rem}
.actions a{font-size:.9rem}
.site-header{margin-bottom:1.5rem}
.figure{margin:1.25rem 0;text-align:center}
.figure img{max-width:100%;height:auto;border:1px solid #ddd;border-radius:.5rem}
.figure figcaption{margin-top:.5rem;font-size:.9rem;color:#555}
.guide-section{margin:2rem 0}
.guide-section pre{background:#111;color:#f4f4f4;padding:1rem;border-radius:.5rem;overflow:auto}
.guide-section code{font-family:ui-monospace,SFMono-Regular,Menlo,Consolas,monospace}
.guide-toc{background:#f6f8fa;border:1px solid #e1e4e8;border-radius:.5rem;padding:1rem 1.25rem;margin:1.25rem 0}
.guide-toc ul{margin:.5rem 0 0;padding-left:1.25rem}
"""

COPY_SCRIPT = """
document.querySelectorAll('.copy-btn').forEach((button) => {
  button.addEventListener('click', async () => {
    const code = button.closest('.code-wrap').querySelector('code');
    try {
      await navigator.clipboard.writeText(code.innerText);
      const original = button.textContent;
      button.textContent = 'Copied';
      setTimeout(() => { button.textContent = original; }, 1500);
    } catch (error) {
      button.textContent = 'Failed';
    }
  });
});
hljs.highlightAll();
"""


def load_config() -> dict:
    with (ROOT / "chapters.yaml").open(encoding="utf-8") as handle:
        return yaml.safe_load(handle)


def load_lab_vm_page() -> dict | None:
    path = ROOT / "content" / "lab-vm-setup.yaml"
    if not path.exists():
        return None
    with path.open(encoding="utf-8") as handle:
        return yaml.safe_load(handle)


def render_inline_markdown(text: str) -> str:
    escaped = html.escape(text)
    escaped = re.sub(r"\*\*(.+?)\*\*", r"<strong>\1</strong>", escaped)
    escaped = re.sub(
        r"\[([^\]]+)\]\(([^)]+)\)",
        lambda match: f'<a href="{html.escape(match.group(2), quote=True)}">{html.escape(match.group(1))}</a>',
        escaped,
    )
    return escaped


def render_markdown_body(body: str) -> str:
    chunks: list[str] = []
    pattern = re.compile(r"```([a-zA-Z0-9_-]*)\n(.*?)```", re.DOTALL)
    pos = 0
    for match in pattern.finditer(body):
        before = body[pos : match.start()].strip()
        if before:
            chunks.append(render_markdown_paragraphs(before))
        language = match.group(1) or "bash"
        code = html.escape(match.group(2).strip("\n"))
        chunks.append(
            f'<pre><code class="language-{html.escape(language)}">{code}</code></pre>'
        )
        pos = match.end()
    tail = body[pos:].strip()
    if tail:
        chunks.append(render_markdown_paragraphs(tail))
    return "\n".join(chunks)


def render_markdown_paragraphs(text: str) -> str:
    parts: list[str] = []
    for block in re.split(r"\n\s*\n", text.strip()):
        block = block.strip()
        if not block:
            continue
        image = re.fullmatch(r"!\[([^\]]*)\]\(([^)]+)\)", block)
        if image:
            alt = html.escape(image.group(1))
            src = html.escape(image.group(2), quote=True)
            parts.append(
                f'<figure class="figure"><img src="./{src}" alt="{alt}">'
                f"<figcaption>{alt}</figcaption></figure>"
            )
            continue
        lines = [line.strip() for line in block.splitlines() if line.strip()]
        if lines and all(line.startswith("- ") for line in lines):
            items = "".join(
                f"<li>{render_inline_markdown(line[2:])}</li>" for line in lines
            )
            parts.append(f"<ul>{items}</ul>")
            continue
        parts.append(f"<p>{render_inline_markdown(block.replace(chr(10), ' '))}</p>")
    return "\n".join(parts)


def render_guide_page(page: dict, book: dict) -> str:
    toc_items = []
    sections = []
    for section in page["sections"]:
        anchor = section["id"]
        heading = html.escape(section["heading"])
        toc_items.append(f'<li><a href="#{anchor}">{heading}</a></li>')
        body_html = render_markdown_body(section["body"])
        sections.append(
            f'<section class="guide-section" id="{anchor}">'
            f"<h2>{heading}</h2>{body_html}</section>"
        )

    return (
        '<nav class="guide-toc"><h2>On this page</h2><ul>'
        + "".join(toc_items)
        + "</ul></nav><hr>"
        + "".join(sections)
    )


def copy_lab_vm_assets() -> None:
    src_dir = ROOT / "assets" / "lab-vm"
    if not src_dir.exists():
        return
    dest_dir = SITE_DIR / "assets" / "lab-vm"
    dest_dir.mkdir(parents=True, exist_ok=True)
    for image in src_dir.glob("*.png"):
        shutil.copy2(image, dest_dir / image.name)


def parse_script_meta(content: str) -> dict[str, str]:
    meta = {"type": "executable", "requires": "none", "safe": "no"}
    for line in content.splitlines():
        stripped = line.strip()
        if stripped in ("#!/bin/bash", "set -euo pipefail") or not stripped:
            continue
        if not stripped.startswith("# @"):
            break
        match = re.match(r"# @(\w+):\s*(.+)", stripped)
        if match:
            meta[match.group(1)] = match.group(2).strip()
    return meta


def slugify(name: str) -> str:
    return re.sub(r"[^a-zA-Z0-9_-]+", "-", name).strip("-").lower()


def badge_html(meta: dict[str, str]) -> str:
    badges = []
    script_type = meta.get("type", "executable")
    type_class = "badge-instructional" if script_type == "instructional" else "badge-executable"
    badges.append(f'<span class="badge {type_class}">{html.escape(script_type)}</span>')

    safe = meta.get("safe", "no")
    safe_class = "badge-safe" if safe == "yes" else "badge-unsafe"
    badges.append(f'<span class="badge {safe_class}">safe: {html.escape(safe)}</span>')

    requires = meta.get("requires", "none")
    if requires != "none":
        badges.append(
            f'<span class="badge badge-executable">requires: {html.escape(requires)}</span>'
        )
    return " ".join(badges)


def page_shell(*, title: str, description: str, book: dict, body: str) -> str:
    cover = html.escape(book["cover_image"])
    book_url = html.escape(book["isbn_url"])
    pages_url = html.escape(book["pages_url"])
    repo_url = html.escape(book["repo_url"])
    subtitle = html.escape(book["subtitle"])
    author = html.escape(book["author"])

    return f"""<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{html.escape(title)}</title>
  <meta name="description" content="{html.escape(description)}">
  <meta property="og:title" content="{html.escape(title)}">
  <meta property="og:description" content="{html.escape(description)}">
  <meta property="og:type" content="website">
  <meta property="og:url" content="{pages_url}">
  <link rel="stylesheet" href="{HIGHLIGHT_CSS}">
  <style>{BASE_STYLE}</style>
</head>
<body>
  <header class="site-header">
    <p><a href="./index.html">&larr; All chapters</a> · <a href="{book_url}">Book</a> · <a href="{repo_url}">Repository</a></p>
    <h1>{html.escape(title)}</h1>
    <p class="muted">{subtitle} by {author} ({html.escape(book["published"])}).</p>
  </header>
  {body}
  <script src="{HIGHLIGHT_JS}"></script>
  <script src="{BASH_JS}"></script>
  <script>{COPY_SCRIPT}</script>
</body>
</html>
"""


def render_exercise_section(
    *,
    script_path: Path,
    chapter_id: str,
    book: dict,
) -> tuple[str, str]:
    script_name = script_path.name
    anchor = slugify(script_name)
    rel_download = f"scripts/{chapter_id}/{script_name}"
    download_path = SITE_DIR / rel_download
    download_path.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(script_path, download_path)

    content = script_path.read_text(encoding="utf-8")
    meta = parse_script_meta(content)
    escaped_source = html.escape(content)
    github_url = f"{book['repo_url']}/blob/main/{chapter_id}/{script_name}"

    section = f"""
<section class="exercise" id="{anchor}">
  <div class="exercise-header">
    <h2>{html.escape(script_name)}</h2>
    {badge_html(meta)}
  </div>
  <div class="actions">
    <a href="./{html.escape(rel_download)}" download>Download .sh</a>
    <a href="{html.escape(github_url)}">View on GitHub</a>
  </div>
  <div class="code-wrap">
    <button type="button" class="copy-btn" aria-label="Copy code for {html.escape(script_name)}">Copy</button>
    <pre><code class="language-bash">{escaped_source}</code></pre>
  </div>
</section>
"""
    toc_item = f'<li><a href="#{anchor}">{html.escape(script_name)}</a></li>'
    return toc_item, section


def build_site() -> None:
    config = load_config()
    book = config["book"]
    chapters = config["chapters"]

    if SITE_DIR.exists():
        shutil.rmtree(SITE_DIR)
    SITE_DIR.mkdir()

    cover_src = ROOT / book["cover_image"]
    if cover_src.exists():
        shutil.copy2(cover_src, SITE_DIR / book["cover_image"])

    copy_lab_vm_assets()

    lab_vm_page = load_lab_vm_page()
    lab_vm_link = ""
    if lab_vm_page:
        guide_body = render_guide_page(lab_vm_page, book)
        guide_html = page_shell(
            title=lab_vm_page["title"],
            description=lab_vm_page["description"],
            book=book,
            body=guide_body,
        )
        guide_filename = lab_vm_page.get("page", "lab-vm-setup.html")
        (SITE_DIR / guide_filename).write_text(guide_html, encoding="utf-8")
        lab_vm_link = (
            f'<li><a href="./{html.escape(guide_filename)}">{html.escape(lab_vm_page["title"])}</a> '
            f'<span class="muted">(virtual machine setup)</span></li>'
        )

    chapter_links: list[str] = []
    for chapter in chapters:
        chapter_id = chapter["id"]
        chapter_title = chapter["title"]
        chapter_page = f"{chapter_id}.html"
        scripts = sorted((ROOT / chapter_id).glob("exercise*.sh"))

        toc_items: list[str] = []
        exercise_sections: list[str] = []
        for script_path in scripts:
            toc_item, section = render_exercise_section(
                script_path=script_path,
                chapter_id=chapter_id,
                book=book,
            )
            toc_items.append(toc_item)
            exercise_sections.append(section)

        topics = "".join(f"<li>{html.escape(topic)}</li>" for topic in chapter["topics"])
        body = (
            f"<h2>Topics</h2><ul>{topics}</ul>"
            f'<nav class="toc"><h2>Exercises</h2><ul>{"".join(toc_items)}</ul></nav>'
            "<hr>"
            f'{"".join(exercise_sections)}'
        )

        page = page_shell(
            title=f"{chapter_title} Answers",
            description=f"Exercise answer scripts for {chapter_title}.",
            book=book,
            body=body,
        )
        (SITE_DIR / chapter_page).write_text(page, encoding="utf-8")

        summary = html.escape(chapter.get("summary", ""))
        chapter_links.append(
            f'<li><a href="./{chapter_page}">{html.escape(chapter_title)}</a>'
            f' <span class="muted">({summary})</span></li>'
        )

    index_body = f"""
<p><a href="{html.escape(book['isbn_url'])}">
  <img src="./{html.escape(book['cover_image'])}" alt="{html.escape(book['subtitle'])}" width="320">
</a></p>
<p class="muted">Browse chapter answers below. Script metadata (<code>@type</code>, <code>@requires</code>, <code>@safe</code>) is shown on each exercise page.</p>
<p><strong>Warning:</strong> Many scripts change system configuration. Use a disposable lab VM only.</p>
<h2>Getting started</h2>
<ul>
{lab_vm_link}
</ul>
<h2>Chapters</h2>
<ul>
{"".join(chapter_links)}
</ul>
"""
    index_page = page_shell(
        title=book["title"],
        description=book["subtitle"],
        book=book,
        body=index_body,
    )
    (SITE_DIR / "index.html").write_text(index_page, encoding="utf-8")


def main() -> None:
    build_site()
    print(f"Site written to {SITE_DIR}")


if __name__ == "__main__":
    main()
