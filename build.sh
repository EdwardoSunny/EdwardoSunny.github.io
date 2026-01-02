#!/bin/sh 
# runs emacs in script mode to build the site
# -Q to not use personal config deps.
emacs -Q --script build-site.el
