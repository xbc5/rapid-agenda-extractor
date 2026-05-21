I want you to create a means to rapidly extract Org agenda items from thousands of documents.

First, use ripgrep to determine if the NEUTRON_PROJECT_STATUS exists and set to "active".

From those discovered paths, use a third-party Org mode parser (like [haxorg](https://github.com/haxscramper/haxorg/)) to get all the agenda items. Collect them while preserving the necessary metadata to plug into Org agenda. Whatever data is required Org agenda items correctly work in an Org agenda view, collect it. For example, the file path, and possibly the cursor position. This allows users to navigate to the real agenda item, just like how Org agenda does normally.

Lastly, plug this data into Org agenda, such that when I open the agenda view, it activates this external parser, builds the agenda items, and displays them. The user should know no difference between the normal Agenda parser and the new parser, in terms of functionality.


Primary goals:
1. Rapid extraction of agenda items from thousands of documents.
2. Replace the current Org agenda parser with a new one that is faster and a one-to-one replacement.
3. Make it an installable package.
