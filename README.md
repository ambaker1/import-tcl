# import-tcl
Tcl package to make importing of Tcl packages easier

Adds the command "import", which simplifies most use-cases of package import.
Returns version number of package imported.

Simply call "package require import", and the import command will be added.

## Syntax:
```
import <$patterns from> $package <$version> <as $namespace>
```
* $patterns: List of commands or "glob" style patterns to import. Default "*", or all exported commands.
* $package: Package to import
* $version: Package version (optional)
* $namespace: Namespace to import into (default current namespace)

## Examples:
```
import foo
import bar from foo
import foo 1.0 as f
```

## License
See the file "LICENSE" for information on usage, redistribution, and for a DISCLAIMER OF ALL WARRANTIES.
