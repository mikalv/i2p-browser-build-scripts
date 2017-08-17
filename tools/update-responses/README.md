Tor Browser Update Responses script
===================================

This repository contains a script to generate responses for Tor Browser
updater.

See ticket [#12622](https://trac.torproject.org/projects/tor/ticket/12622)
for details.


Dependencies
------------

The following perl modules need to be installed to run the script:
  FindBin YAML File::Slurp Digest::SHA XML::Writer File::Temp
  IO::CaptureOutput Parallel::ForkManager XML::LibXML LWP JSON

On Debian / Ubuntu you can install them with:

```
  # apt-get install libfindbin-libs-perl libyaml-perl libfile-slurp-perl \
                    libdigest-sha-perl libxml-writer-perl \
                    libio-captureoutput-perl libparallel-forkmanager-perl \
                    libxml-libxml-perl libwww-perl libjson-perl
```

On Red Hat / Fedora you can install them with:

```
  # for module in FindBin YAML File::Slurp Digest::SHA XML::Writer \
                  File::Temp IO::CaptureOutput Parallel::ForkManager \
                  XML::LibXML LWP JSON
    do yum install "perl($module)"; done
```


URL Format
----------

The URL format is:
  https://something/$channel/$build_target/$tb_version/$lang?force=1

'build_target' is the OS for which the browser was built. The correspo
ndance between the build target and the OS name that we use in archive
files is defined in the config.yml file.

'tb_version' is the Tor Browser version.

'lang' is the locale.

