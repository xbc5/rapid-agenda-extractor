# Rapid Agenda Extractor (rae)

Org agenda is slow because it scans every agenda file. This narrows Org down to only the files that hold active items, using ripgrep, then lets Org build the agenda as it normally does.

We do not reimplement the agenda. We only choose which files Org looks at. Org parses them, expands repeats, applies skips, and renders — so the result is identical to normal Org agenda, just faster.

## How it works

1. Ripgrep scans `rae-directory` for files marked active.
2. Those file paths are set as Org's agenda files.
3. Org builds the agenda from that short list as usual.

The speed win comes from step 1: ripgrep filtering thousands of files down to a handful, instead of Org opening and scanning them all.

## Discovery

A file is active when it contains the file-level keyword:

```
#+RAE_PROJECT_STATUS: active
```

Ripgrep pattern: `^#\+RAE_PROJECT_STATUS:\s*active`

## Toggle project status

A command, `rae-toggle-project-status`, flips the current file's `#+RAE_PROJECT_STATUS` between `active` and `inactive`.

## Configuration

All settings use a `rae-` prefix. The root folder to scan is `rae-directory`, which defaults to `org-directory`.

## Structure

```
rapid-agenda-extractor/
├── elisp/           # Emacs package
└── tests/
    └── corpus/      # sample .org files
```

## Testing

- Discovery and file-list selection: tested with `ert` under `emacs --batch`. Confirms ripgrep finds the right files and Org's agenda file list is set to them.
- Speed and navigation: tested manually by the user, who opens the agenda on real files and confirms it's fast and that selecting an item jumps to the right spot.

## Primary goals

1. Rapid agenda building across thousands of documents.
2. Exact replication of Org agenda — Org still does all parsing and rendering.
3. An installable package.
4. Simplicity. Write small functions. Don't reinvent the wheel. Less code is better. LESS CODE IS BETTER.
