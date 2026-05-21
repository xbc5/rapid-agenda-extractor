# Research

## Feeding Org our file list — ANSWERED

`org-agenda-files` resolves only as a list of paths or a filename string — never a function (`org.el`, `org-agenda-files`). So we cannot point it at a generator. Instead we make our ripgrep result *be* that list, recomputed on each agenda build.

Two options:

- Advise the `org-agenda-files` function to return our discovered paths. It is called on every build, so the list stays fresh. Preferred.
- Set the `org-agenda-files` variable to our result before each build (e.g. from a hook).

Either way Org then opens and parses only those files, exactly as normal.

## Discovery marker — SETTLED

File-level keyword `#+RAE_PROJECT_STATUS: active`, matched with `^#\+RAE_PROJECT_STATUS:\s*active`. Recorded in the spec.
