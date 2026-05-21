# Research plan

Open questions blocking implementation. Each gets answered with findings inline.

## Q1. Org agenda injection mechanism
How does Emacs let external data replace its own parse? What's the supported hook/entry point so the agenda renders our items?
- [ ] Status: open

## Q2. Agenda line contract
What text properties must each agenda line carry for navigation, marking, and commands to work (e.g. `org-marker`, `org-hd-marker`, `type`, `org-category`)?
- [ ] Status: open

## Q3. Item metadata
Which fields define an agenda item: TODO state, scheduled, deadline, plain timestamps, tags, priority, category. What the engine must emit.
- [ ] Status: open

## Q4. Discovery marker
Where does `NEUTRON_PROJECT_STATUS` live — file-level keyword or property drawer — and the exact ripgrep pattern to match `active`.
- [ ] Status: open
