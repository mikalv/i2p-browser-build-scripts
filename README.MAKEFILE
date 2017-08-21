Description of makefile rules
=============================


release
-------
Build Tor Browser for the release channel, for all supported platforms.
The resulting build can be found in directory release/$version.

release-{linux-x86_64,linux-i686,windows-i686,osx-x86_64}
---------------------------------------------------------
Same as release, for the selected platform only.

alpha
-----
Build Tor Browser for the alpha channel, for all supported platforms.
The resulting build can be found in directoryp alpha/$version.

alpha-{linux-x86_64,linux-i686,windows-i686,osx-x86_64}
-------------------------------------------------------
Same as alpha, for the selected platform only.

nightly
-------
Build Tor Browser for the nightly channel, for all supported platforms.
Many of the components will be based on the master branch. You might
want to run "make fetch" before, to fetch the latest commits from all
components.

The resulting build can be found in directory nightly/$date

nightly-{linux-x86_64,linux-i686,windows-i686,osx-x86_64}
---------------------------------------------------------
Same as nightly, for the selected platform only.

alpha_nightly
-------------
Build Tor Browser for the alpha channel, for all supported platforms.
This is the same as 'make alpha', but the output directory is different.
The resulting build can be found in directory alpha_nightly/$date

alpha_nightly-{linux-x86_64,linux-i686,windows-i686,osx-x86_64}
---------------------------------------------------------------
The same as alpha_nightly, for the selected platform only.

testbuild
---------
Build a Tor Browser test build. To make the build faster, only the en-US
locale is created, without mar files. By default it is based on the
alpha channel, but you can change that by editing rbm.conf.local.
The resulting build can be found in directory testbuild.

fetch
-----
Fetch new commits from all components. This is useful when you want to
build the nightly channel.

clean
-----
Clean files created during previous builds that are no longer used in
current builds. Before using this command, you first need to configure
in rbm.local.conf the channel(s) that you are building.

In other software, the clean rule is used to remove all build files,
but this is not the case here, where only obsolete build files are
removed. It is usually not necessary to remove all build files before
starting a new build as the need for rebuilding components is detected
automatically. If you want to remove all build files, you can remove
the out/ directory.

clean-dry-run
-------------
Print the files that would be removed when running 'make clean'.

signtag-{release,alpha}
-----------------------
Create a git signed tag for the selected channel, using the version and
build number defined as var/torbrowser_version and var/torbrowser_build.

incrementals-{release,alpha}
----------------------------
Create incremental mar files for an unsigned build in the release or
alpha channel.

dmg2mar-{release,alpha)
-----------------------
Generate updated mar files for the OSX bundles, from the dmg files, then
regenerate the OSX incremental mar files. You should run this after
signing the OSX dmg files.

update_responses-{release,alpha}
--------------------------------
Create update responses xml files for a signed build in the release or
alpha channel. The files can be found in a tar in the directory
{release,alpha}/update-responses.

