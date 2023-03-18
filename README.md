# import-tcl
Tcl package to make importing of Tcl packages easier

Adds the command "import", which simplifies most use-cases of package import.
Returns version number of package imported.

## Syntax:
```
import <$patterns from> $package <$reqs ...>
```
* $patterns: List of commands or "glob" style patterns to import. Default "*", or all exported commands.
* $package: Package to import
* $reqs: Package version requirements

## Examples:
```
import foo
import * from foo
import bar from foo
import b* from foo 1.0
```
