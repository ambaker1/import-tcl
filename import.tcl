# import.tcl
################################################################################
# Package to make importing packages easier

# Copyright (C) 2023 Alex Baker, ambaker1@mtu.edu
# All rights reserved. 

# See the file "LICENSE" for information on usage, redistribution, and for a 
# DISCLAIMER OF ALL WARRANTIES.
################################################################################

# import --
#
# Helper procedure to handle the majority of cases for importing Tcl packages
# 
# import <$patterns from> $package <$reqs ...>
# 
# $patterns:    Patterns for namespace import (appends to package namespace)
# $package:     Package name (must have corresponding namespace)
# $reqs:        Package version requirements
# 
# Examples
# import foo 1.0
# import bar from foo 1.0
# import * from foo
# import b* from foo 1.0

proc import {args} {
    if {[lindex $args 1] eq "from"} {
        # User specified pattern(s)
        set patterns [lindex $args 0]
        set pkgArgs [lrange $args 2 end]
        set version [uplevel 1 [list package require {*}$pkgArgs]]
        foreach pattern $patterns {
            uplevel 1 [list namespace import [lindex $pkgArgs 0]::$pattern]
        }
    } else {
        # Default case (import all)
        set version [uplevel 1 [list package require {*}$args]]
        uplevel 1 [list namespace import [lindex $args 0]::*]
    }
    return $version
}

package provide import 0.1.0
