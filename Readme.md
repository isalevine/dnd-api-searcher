# Dnd Api Searcher
## just a little search tool for http://www.dnd5eapi.co/

## Goals/Functionality
* retrieve list of level 1 spells, with names and descriptions
* retrieve race(/language_desc/alignment/NOT-age/other?) [desc:] values, slice into separate sentences, and take ONLY THE MIDDLE 1-2 SENTENCES--out of context, they're both funny and a little bit descriptive! => use them as snippets...
* NOTE: when designing (backstory) snippets, make sure to give them an array that stores searchable tags of some kind, like class-names and race-names and etc...

## Current next steps:
* use @json_spells["count"] to iterate through spells and search
for all level 1 spells => and build it to get ANY level spells...
* for practice, consider building in a sql database to save a lot of the data to, then run queries on that?
