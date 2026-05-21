# rapid-agenda-extractor

## Install

```sh
cargo install --path engine
```

`~/.doom.d/packages.el`:

```elisp
(package! neutron :recipe (:host github :repo "xbc5/rapid-agenda-extractor" :files ("elisp/*.el")))
```

```sh
doom sync
```

`config.el`:

```elisp
(setq neutron-directory "~/org")
```
