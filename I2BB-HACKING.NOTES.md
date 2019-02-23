# Hacking on the Invisible Internet Browser Bundle

## Links

Collection of useful links:
* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Source_Code/Directory_structure
* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide
* https://dxr.mozilla.org/mozilla-central/source/
* https://developer.mozilla.org/en-US/docs/Mozilla/Signing_Mozilla_apps_for_Mac_OS_X
* https://developer.mozilla.org/en-US/docs/Mozilla/About_omni.ja_(formerly_omni.jar)
* https://firefox-source-docs.mozilla.org/index.html
* https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Mozilla_Release_Checklist
* https://developer.mozilla.org/en-US/docs/Mozilla/Setting_up_an_update_server
* https://developer.mozilla.org/en-US/docs/Mozilla/Chrome_Registration
* https://developer.mozilla.org/en-US/docs/Mozilla/JavaScript_code_modules

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


