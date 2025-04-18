# Makefile for exampleapp

COMPONENT = today

# The name of the linked file defaults to COMPONENT, which is often the case
# for single-file programs. But when the linked file lives in an application
# directory, it is normally called !RunImage.
TARGET = !Today.!RunImage

# The list of source/object files defaults to TARGET, which again is often
# the case for single-file programs. But we don't want our source file to be
# called !RunImage.
OBJS = main

INSTDIR ?= <Obey$Dir>

# The shared makefiles don't attempt to guess the application directory name
# Usually you'll want to place it inside INSTDIR, which is passed in from
# either the MkInstall file, or (for !Builder builds) the components file.
# SEP expands to the directory separator character - we use this instead of
# a literal '.' character to help with cross-compilation.
INSTAPP = ${INSTDIR}${SEP}!Today

# You need to specify all the files that go into the application directory.
# The shared makefiles handle merging the various subdirectories of the
# Resources directory for you.
INSTAPP_FILES = !Boot !Run !Sprites !Sprites11 !Sprites22 !RunImage

CINCLUDES = -IC: -ISFlib: -IOSLib:
LIBS = C:o.toolboxlib C:o.wimplib C:o.eventlib C:o.renderlib C:o.flexlib SFLib:o.SFLib OSLib:o.OSLib32

C_NO_FNAMES =

include CApp

clean::
	${WIPE} ${INSTAPP} ${WFLAGS}

# Dynamic dependencies:
o.main:	c.main
o.main:	C:h.kernel
o.main:	C:h.swis
o.main:	C:h.flex
o.main:	C:h.colourdbox
o.main:	C:h.toolbox
o.main:	C:h.wimp
o.main:	C:h.window
o.main:	C:h.gadgets
o.main:	C:h.dcs
o.main:	C:h.drawfile
o.main:	C:h.event
o.main:	C:h.fileinfo
o.main:	C:h.fontmenu
o.main:	C:h.iconbar
o.main:	C:h.menu
o.main:	C:h.printdbox
o.main:	C:h.proginfo
o.main:	C:h.quit
o.main:	C:h.saveas
o.main:	C:h.scale
o.main:	C:h.toolbox
o.main:	C:h.wimp
o.main:	C:h.wimplib
o.main:	OSLib:oslib.h.messagetrans
o.main:	OSLib:oslib.h.types
o.main:	OSLib:oslib.h.os
o.main:	OSLib:oslib.h.oscore32
o.main:	OSLib:oslib.h.osf32
o.main:	OSLib:oslib.h.os
o.main:	OSLib:oslib.h.osword
o.main:	OSLib:oslib.h.territory
o.main:	SFlib:sflib.h.debug
o.main:	SFlib:sflib.h.msgs
o.main:	OSLib:oslib.h.messagetrans
o.main:	h.main
o.main:	h.buildinfo
