# Hacking on the Invisible Internet Browser Bundle

## Links worth checking out

### Build system

* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/How_Mozilla_s_build_system_works
* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Incremental_Build
* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Configuring_Build_Options
* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Mozilla_Release_Checklist
* https://developer.mozilla.org/en-US/docs/Mozilla/Signing_Mozilla_apps_for_Mac_OS_X

### Developer guide and similar

* https://developer.mozilla.org/en-US/docs/Mozilla/Bird_s_Eye_View_of_the_Mozilla_Framework
* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Source_Code/Directory_structure
* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide
* https://firefox-source-docs.mozilla.org/index.html
* https://developer.mozilla.org/en-US/docs/Mozilla/Setting_up_an_update_server

### Firefox UI

* https://developer.mozilla.org/en-US/docs/Mozilla/Using_popup_notifications
* https://www.xul.fr/tutorial/

### Preferences system

* https://developer.mozilla.org/en-US/docs/Mozilla/Preferences

### Security

* https://developer.mozilla.org/en-US/docs/Mozilla/Security

### Misc firefox internals

* https://developer.mozilla.org/en-US/docs/Mozilla/About_omni.ja_(formerly_omni.jar)
* https://developer.mozilla.org/en-US/docs/Mozilla/IPDL
* https://developer.mozilla.org/en-US/docs/Mozilla/Chrome_Registration
* https://developer.mozilla.org/en-US/docs/Mozilla/Adding_a_new_event

### Javascript API

* https://developer.mozilla.org/en-US/docs/Mozilla/JavaScript_code_modules
* https://developer.mozilla.org/en-US/docs/Mozilla/js-ctypes

### Debugging firefox

* https://developer.mozilla.org/en-US/docs/Mozilla/Debugging/Debugging_JavaScript
* https://developer.mozilla.org/en-US/docs/Mozilla/Debugging/Debugging_on_Mac_OS_X
* https://developer.mozilla.org/en-US/docs/Mozilla/Debugging/Debugging_on_Windows

### Java

* https://developer.mozilla.org/en-US/docs/Mozilla/JavaScript_code_modules/JNI.jsm

### Organisation/Management

* https://www.mozilla.org/en-US/about/governance/policies/module-ownership/

### Source code search/view

* https://dxr.mozilla.org/mozilla-central/source/

## Edit omni.ja without recompile

Editor script (first argument is full path to omni.ja):
```
#!/usr/bin/env bash
omnija_file="$1"
if [ -z "$EDITOR"  ]; then
    export EDITOR=vim
fi
temp_dir=$(mktemp -d)
cd $temp_dir
unzip $omnija_file
$EDITOR $(pwd)
rm -f $omnija_file
zip -qr9XD $omnija_file *
cd -
rm -fr $temp_dir
```


