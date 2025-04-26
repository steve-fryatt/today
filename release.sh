#!/bin/bash
#
# Create release archives for Today.

# The target details.

ARCHIVE="today"
PACKAGE="Today"
PACKAGELOC="Miscellaneous"

# The build directories.

OUTDIR="Build"
PKGDIR="Package"
MANUAL="Manual"
PKGTREEDIR="Apps"
PKGCTRLDIR="RiscPkg"

# The name of the application folder, Licence and ReadMe files.

APP="!Today"
HELP="!Help"
LICENCE="Licence"
READMEHDR="Header"
README="ReadMe"
PKGCTRL="Control"
PKGCPY="Copyright"

# The flags to use for zipping and copying.

ZIPFLAGS='-x "*/.svn/*" -r -, -9'
PKGZIPFLAGS='-x "*/.svn/*" -r -, -9'
PKGRSFLAGS='-av --exclude=*.svn*'

# Extract the command line parameters.

usage()
{
	echo "usage: release [[-v version] | [-h]]"
}

VERSION=
PKG_VERSION=

while [ "$1" != "" ]; do
	case $1 in
		-v | --version )
			VERSION="$2"
			shift
			;;
		-h | --help )
			usage
			exit
			;;
		* )
			usage
			exit1
			;;
	esac

	shift
done

# The default version will be the Git commit hash.

if [ "$VERSION" == "" ]; then
	VERSION="$(git rev-parse --short=7 HEAD)"
	if [ "$PACKAGE" != "" ]; then
		PACKAGE="${PACKAGE}Unstable"
		PKG_VERSION="$($SFTOOLS_BIN/getpackagerev --index unstable --package $PACKAGE --revision $VERSION)"
	fi
else
	# Remove any dots from the version number.
	VERSION="$(echo $VERSION | tr -d '.')"

	if [ "$PACKAGE" != "" ]; then
		PKG_VERSION="$($SFTOOLS_BIN/getpackagerev --index stable --package $PACKAGE --revision $VERSION)"
	fi
fi

# Work out the target filenames.

ZIPFILE="$ARCHIVE$VERSION.zip"
PKGZIPFILE="${PACKAGE}_${PKG_VERSION}.zip"

echo "Releasing as version $VERSION and saving to $ZIPFILE"

if [ "$PACKAGE" != "" ]; then
	echo "Packaging as $PKG_VERSION and saving to $PKGZIPFILE"
fi

# Copy across the static files.

cp -a "${LICENCE}" "${OUTDIR}/${LICENCE}"
${SFTOOLS_BIN}/textmerge "${OUTDIR}/${README}" "${OUTDIR}/${APP}/${HELP}"  "${MANUAL}/${READMEHDR}" 5

# Assemble the standard distribution archive

rm -f "../$ZIPFILE"

pushd $OUTDIR
${GCCSDK_INSTALL_ENV}/bin/zip $ZIPFLAGS ../../$ZIPFILE $APP $README $LICENCE
popd

# Assemble the package.

if [ "$PACKAGE" != "" ]; then
	rm -f "../$PKGZIPFILE"
	mkdir -p "${OUTDIR}/${PKGDIR}/${PKGTREEDIR}/${PACKAGELOC}"
	mkdir -p "${OUTDIR}/${PKGDIR}/${PKGCTRLDIR}"
	rm -rf "${OUTDIR}/${PKGDIR}/${PKGTREEDIR}/${PACKAGELOC}/*"
	pushd "${OUTDIR}"
	rsync $PKGRSFLAGS "$APP" "${PKGDIR}/${PKGTREEDIR}/${PACKAGELOC}/"
	popd
	${SFTOOLS_BIN}/makecontrol --template "${PKGDIR}/${PKGCTRL}" --control "${OUTDIR}/${PKGDIR}/${PKGCTRLDIR}/${PKGCTRL}" --version $PKG_VERSION
	${SFTOOLS_BIN}/textmerge "${OUTDIR}/${PKGDIR}/${PKGCTRLDIR}/${PKGCPY}" "${OUTDIR}/${LICENCE}" "${PKGDIR}/${PKGCPY}" 5
	pushd "${OUTDIR}/${PKGDIR}"
	${GCCSDK_INSTALL_ENV}/bin/zip $PKGZIPFLAGS ../../../$PKGZIPFILE $PKGTREEDIR $PKGCTRLDIR
	popd
fi
