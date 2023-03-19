# import.tcl
################################################################################
# Package to make importing packages easier

# Copyright (C) 2023 Alex Baker, ambaker1@mtu.edu
# All rights reserved. 

# See the file "LICENSE" for information on usage, redistribution, and for a 
# DISCLAIMER OF ALL WARRANTIES.
################################################################################

# Preserve existing "import" command (for OpenSees 3.4 and beyond)
if {[info commands ::import] eq "::import"} {
    rename ::import ::oldload
}

# import --
#
# Helper procedure to handle the majority of cases for importing Tcl packages
# 
# import <$patterns from> $package <$version> <as $namespace>
# 
# $patterns:    Glob patterns for importing commands from package
# $package:     Package name (must have corresponding namespace)
# $version:     Package version (optional, uses most recent otherwise)
# $namespace:   Namespace to import into. Default current namespace.
# 
# Examples
# import foo
# import * from foo
# import bar from foo 1.0

proc ::import {args} {
    # Parse arguments
    if {[llength $args] == 0 || [llength $args] > 6} {
        return -code error "wrong # of args"
    }
    # Default optional settings
    set patterns *
    set version ""
    set ns [namespace current]
    # Switch for arity
    if {[llength $args] <= 2} {
        # Simplest case
        lassign $args package version
    } elseif {[lindex $args 1] eq "from"} {
        # User specified patterns
        lassign $args patterns from package version as ns
    } elseif {[lindex $args end-1] eq "as"} {
        # User specified namespace
        set package [lindex $args 0]
        set ns [lindex $args end]
        # Get optional version
        if {[llength $args] == 4} {
            set version [lindex $args 1]
        }
    } else {
        return -code error "incorrect input"
    }
    # Add prefixes to patterns
    set patterns [lmap pattern $patterns {string cat :: $package :: $pattern}]
    # Require package, import commands, and return version number
    set version [namespace eval :: [list package require $package {*}$version]]
    namespace eval $ns [list namespace import {*}$patterns]
    return $version
}

package provide import 0.2.0
