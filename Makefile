# Makefile for exampleapp

COMPONENT = Today

# The name of the linked file defaults to COMPONENT, which is often the case
# for single-file programs. But when the linked file lives in an application
# directory, it is normally called !RunImage.
TARGET = Build.!Today.!RunImage

# The list of source/object files defaults to TARGET, which again is often
# the case for single-file programs. But we don't want our source file to be
# called !RunImage.
OBJS = main

CINCLUDES = -IC: -ISFlib: -IOSLib:
LIBS = C:o.toolboxlib C:o.wimplib C:o.eventlib C:o.renderlib C:o.flexlib SFLib:o.SFLib OSLib:o.OSLib32

include CApp

C_NO_FNAMES =

clean::
	${WIPE} Build.!Today.!Help ${WFLAGS}
	${WIPE} Build.ReadMe ${WFLAGS}
	${WIPE} Build.Licence ${WFLAGS}
#	${WIPE} ${TARGET} ${WFLAGS}
#	${WIPE} ${INSTAPP} ${WFLAGS}

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
