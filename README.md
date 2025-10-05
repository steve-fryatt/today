Today
=====

Today's the Day in History


Introduction
------------

Today was written and maintained by James Miskin between 1991 and 2006. In around 2006, it was updated for 32-bit use by Steve Fryatt.


Building
--------

Today needs to be built using the [Desktop Development Environment](https://www.riscosopen.org/content/sales/dde) from RISC OS Open.

It can be checked out from the GitHub repository directly on to a RISC OS system using the Git client from RISC OS Open.

You will need to have two utilities - BuildInfo and XMLMan - installed on your Run Path for the build to work. These can be obtained from <https://www.stevefryatt.org.uk/risc-os/programming-tools>, and the easiest way to ensure that they are found is to install them into Boot:Library.

With this setup complete and the DDE having been seen, running the Mk TaskObey file in the project folder should build the documentation and !RunImage file within the !Today application.


Releasing
---------

Creating release and package archives can be done from a Linux system, using the [SFTools build environment](https://github.com/steve-fryatt). It will be necessary to have suitable Linux system with a working installation of the [GCCSDK](http://www.riscos.info/index.php/GCCSDK) to be able to make use of this.

From the top-level folder of the project, run the `release.sh` script to create a distribution archive (with no source) and RiscPkg package in the folder within which the project folder is located. By default the output of `git describe` is used to version the build, but a specific version can be applied by supplying the `--version` parameter -- for example

	./release.sh --version 1.23


Licence
-------

Today is licensed under the EUPL, Version 1.2 only (the "Licence"); you may not use this work except in compliance with the Licence.

You may obtain a copy of the Licence at <http://joinup.ec.europa.eu/software/page/eupl>.

Unless required by applicable law or agreed to in writing, software distributed under the Licence is distributed on an "**as is**"; basis, **without warranties or conditions of any kind**, either express or implied.

See the Licence for the specific language governing permissions and limitations under the Licence.