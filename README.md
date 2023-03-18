# import-tcl
Tcl package to make importing of Tcl packages easier

Adds the command "import", which simplifies most use-cases of package import.
Returns version number of package imported.

## Syntax:
```
import <$patterns from> $package <$arg1 $arg2 ...>
```
* $patterns: List of commands or "glob" style patterns to import. Default "*"
* $package: Package to import
* $args: Additional arguments to pass to "package require" command.

## Examples:
```
import foo
import * from foo
import bar from foo
import b* from foo 1.0
```
