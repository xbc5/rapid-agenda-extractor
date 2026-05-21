# rapid-agenda-extractor

> [!WARNING]
> 🔴 **LLM-GENERATED TRASH. USE WITH EXTREME PREJUDICE.**


## Install

`~/.doom.d/packages.el`:

```elisp
(package! rae :recipe (:host github :repo "xbc5/rapid-agenda-extractor" :files ("elisp/*.el")))
```

```sh
doom sync
```

`config.el`:

```elisp
(setq rae-directory "~/org")  ; defaults to `org-directory'
(rae-mode 1)                  ; build the agenda from active files only
```

## Use

Mark a file active or inactive with `M-x rae-toggle-project-status`. It
flips the file's `#+RAE_PROJECT_STATUS` keyword, inserting it as `active`
when the file has none.

With `rae-mode` on, every agenda build runs ripgrep over `rae-directory`
and points Org at only the files marked `#+RAE_PROJECT_STATUS: active`. Org
parses and renders them as usual, so the agenda is identical -- just faster.

## Development

| Command   | Description                                            |
| --------- | ------------------------------------------------------ |
| make test | Run the `ert` suite headless against `tests/corpus/`.  |
