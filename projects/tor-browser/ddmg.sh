[% SET src = c('dmg_src', { error_if_undef => 1 }) -%]
find [% src %] -executable -exec chmod 0755 {} \;
find [% src %] ! -executable -exec chmod 0644 {} \;

find [% src %] -exec [% c("var/touch") %] {} \;

dmg_tmpdir=\$(mktemp -d)
[% SET filelist = '"\$dmg_tmpdir/filelist.txt"' %]
pushd [% src %] 
find . -type f | sed -e 's/^\.\///' | sort | xargs -i echo "{}={}" > [% filelist %]
find . -type l | sed -e 's/^\.\///' | sort | xargs -i echo "{}={}" >> [% filelist %]

export LD_PRELOAD=[% c("var/faketime_path") %]
export FAKETIME="[% USE date; GET date.format(c('timestamp'), format = '%Y-%m-%d %H:%M:%S') %]"

genisoimage -D -V "Tor Browser" -no-pad -R -apple -o "\$dmg_tmpdir/tbb-uncompressed.dmg" -path-list [% filelist %] -graft-points -gid 20 -dir-mode 0755 -new-dir-mode 0755

dmg dmg "\$dmg_tmpdir/tbb-uncompressed.dmg" [% c('dmg_out', { error_if_undef => 1 }) %]
popd

rm -Rf "\$dmg_tmpdir"
