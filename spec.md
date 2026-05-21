I want you to create a means to rapidly extract Org agenda items from thousands of documents.

First, use ripgrep to determine if the NEUTRON_PROJECT_STATUS exists and set to "active".

From those discovered paths, use a third-party Org mode parser (like [haxorg](https://github.com/haxscramper/haxorg/)) to get all the agenda items. Collect them while preserving the necessary metadata to plug into Org agenda. Whatever data is required Org agenda items correctly work in an Org agenda view, collect it. For example, the file path, and possibly the cursor position. This allows users to navigate to the real agenda item, just like how Org agenda does normally.

Lastly, plug this data into Org agenda, such that when I open the agenda view, it activates this external parser, builds the agenda items, and displays them. The user should know no difference between the normal Agenda parser and the new parser, in terms of functionality.


Primary goals:
1. Rapid extraction of agenda items from thousands of documents.
2. Replace the current Org agenda parser with a new one that is faster and a one-to-one replacement.
3. Make it an installable package.

## Parser

All Org parsing goes through a single adapter interface. No other code touches a parser directly. The first implementation wraps [orgize](https://github.com/PoiScript/orgize) (Rust). Keeping parsing behind the interface lets the backend be swapped (e.g. for haxorg) without changing the rest of the system.

## Structure

```
rapid-agenda-extractor/
├── engine/          # Rust binary: discovery + parse + emit sexp
│   └── src/
│       └── parser/  # adapter trait + orgize impl
├── elisp/           # Emacs package
└── tests/
    └── corpus/      # sample .org files
```

## Configuration

All settings use a `neutron-` prefix. The root folder to scan is `neutron-directory`, which defaults to `org-directory`.

## Integration

Emacs is the front end; the Rust engine does the work. When the agenda opens, Emacs runs the engine as a subprocess. The engine returns the agenda items as sexp, which Emacs reads natively and feeds to the agenda.

## Testing

- Engine: tested with `cargo test`. Covers discovery (ripgrep finding the right paths), parsing, and metadata extraction.
- Emacs integration: tested with `ert` run under `emacs --batch`. Confirms the agenda uses the new parser and renders items.
- Speed and navigation: tested manually by the user, who opens the agenda on real files and confirms it's fast and that selecting an item jumps to the right spot.
