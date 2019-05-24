rbm=./rbm/rbm

all: release

release: submodule-update
	$(rbm) build release --target release --target i2pbrowser-all

release-android-armv7: submodule-update
	$(rbm) build release --target release --target i2pbrowser-android-armv7

release-android-x86: submodule-update
	$(rbm) build release --target release --target torbrowser-android-x86

release-linux-x86_64: submodule-update
	$(rbm) build release --target release --target i2pbrowser-linux-x86_64

release-linux-x86_64-debug: submodule-update
	$(rbm) build release --target release --target i2pbrowser-linux-x86_64-debug

release-linux-i686: submodule-update
	$(rbm) build release --target release --target i2pbrowser-linux-i686

release-windows-i686: submodule-update
	$(rbm) build release --target release --target i2pbrowser-windows-i686

release-windows-x86_64: submodule-update
	$(rbm) build release --target release --target i2pbrowser-windows-x86_64

release-osx-x86_64: submodule-update
	$(rbm) build release --target release --target i2pbrowser-osx-x86_64

release-src: submodule-update
	$(rbm) build release --target release --target torbrowser-src

alpha: submodule-update
	$(rbm) build release --target alpha --target i2pbrowser-all

alpha-android-armv7: submodule-update
	$(rbm) build release --target alpha --target i2pbrowser-android-armv7

alpha-android-x86: submodule-update
	$(rbm) build release --target alpha --target torbrowser-android-x86

alpha-linux-x86_64: submodule-update
	$(rbm) build release --target alpha --target i2pbrowser-linux-x86_64

alpha-linux-x86_64-debug: submodule-update
	$(rbm) build release --target alpha --target i2pbrowser-linux-x86_64-debug

alpha-linux-i686: submodule-update
	$(rbm) build release --target alpha --target i2pbrowser-linux-i686

alpha-windows-i686: submodule-update
	$(rbm) build release --target alpha --target i2pbrowser-windows-i686

alpha-windows-x86_64: submodule-update
	$(rbm) build release --target alpha --target i2pbrowser-windows-x86_64

alpha-osx-x86_64: submodule-update
	$(rbm) build release --target alpha --target i2pbrowser-osx-x86_64

alpha-src: submodule-update
	$(rbm) build release --target alpha --target torbrowser-src

nightly: submodule-update
	$(rbm) build release --target nightly --target i2pbrowser-all

nightly-android-armv7: submodule-update
	$(rbm) build release --target nightly --target i2pbrowser-android-armv7

nightly-android-x86: submodule-update
	$(rbm) build release --target nightly --target torbrowser-android-x86

nightly-linux-x86_64: submodule-update
	$(rbm) build release --target nightly --target i2pbrowser-linux-x86_64

nightly-linux-x86_64-debug: submodule-update
	$(rbm) build release --target nightly --target i2pbrowser-linux-x86_64-debug

nightly-linux-i686: submodule-update
	$(rbm) build release --target nightly --target i2pbrowser-linux-i686

nightly-windows-i686: submodule-update
	$(rbm) build release --target nightly --target i2pbrowser-windows-i686

nightly-windows-x86_64: submodule-update
	$(rbm) build release --target nightly --target i2pbrowser-windows-x86_64

nightly-osx-x86_64: submodule-update
	$(rbm) build release --target nightly --target i2pbrowser-osx-x86_64

nightly-src: submodule-update
	$(rbm) build release --target nightly --target torbrowser-src

alpha_nightly: submodule-update
	$(rbm) build release --target alpha_nightly --target i2pbrowser-all

alpha_nightly-android-armv7: submodule-update
	$(rbm) build release --target alpha_nightly --target i2pbrowser-android-armv7

alpha_nightly-android-x86: submodule-update
	$(rbm) build release --target alpha_nightly --target torbrowser-android-x86

alpha_nightly-linux-x86_64: submodule-update
	$(rbm) build release --target alpha_nightly --target i2pbrowser-linux-x86_64

alpha_nightly-linux-i686: submodule-update
	$(rbm) build release --target alpha_nightly --target i2pbrowser-linux-i686

alpha_nightly-windows-i686: submodule-update
	$(rbm) build release --target alpha_nightly --target i2pbrowser-windows-i686

alpha_nightly-windows-x86_64: submodule-update
	$(rbm) build release --target alpha_nightly --target i2pbrowser-windows-x86_64

alpha_nightly-osx-x86_64: submodule-update
	$(rbm) build release --target alpha_nightly --target i2pbrowser-osx-x86_64

alpha_nightly-src: submodule-update
	$(rbm) build release --target alpha_nightly --target torbrowser-src

testbuild: submodule-update
	$(rbm) build release --target testbuild --target i2pbrowser-all

testbuild-android-armv7: submodule-update
	$(rbm) build release --target testbuild --target i2pbrowser-android-armv7

testbuild-android-x86: submodule-update
	$(rbm) build release --target testbuild --target torbrowser-android-x86

testbuild-linux-x86_64: submodule-update
	$(rbm) build release --target testbuild --target i2pbrowser-linux-x86_64

testbuild-linux-x86_64-debug: submodule-update
	$(rbm) build release --target testbuild --target i2pbrowser-linux-x86_64-debug

testbuild-linux-i686: submodule-update
	$(rbm) build release --target testbuild --target i2pbrowser-linux-i686

testbuild-windows-x86_64: submodule-update
	$(rbm) build release --target testbuild --target i2pbrowser-windows-x86_64

testbuild-windows-i686: submodule-update
	$(rbm) build release --target testbuild --target i2pbrowser-windows-i686

testbuild-osx-x86_64: submodule-update
	$(rbm) build release --target testbuild --target i2pbrowser-osx-x86_64

testbuild-src: submodule-update
	$(rbm) build release --target testbuild --target torbrowser-src-testbuild

signtag-release: submodule-update
	$(rbm) build release --step signtag --target release

signtag-alpha: submodule-update
	$(rbm) build release --step signtag --target alpha

incrementals-release: submodule-update
	$(rbm) build release --step update_responses_config --target release --target create_unsigned_incrementals
	tools/update-responses/download_missing_versions release
	tools/update-responses/gen_incrementals release
	$(rbm) build release --step hash_incrementals --target release

incrementals-alpha: submodule-update
	$(rbm) build release --step update_responses_config --target alpha --target create_unsigned_incrementals
	tools/update-responses/download_missing_versions alpha
	tools/update-responses/gen_incrementals alpha
	$(rbm) build release --step hash_incrementals --target alpha

update_responses-release: submodule-update
	$(rbm) build release --step update_responses_config --target release --target signed
	$(rbm) build release --step create_update_responses_tar --target release --target signed

update_responses-alpha: submodule-update
	$(rbm) build release --step update_responses_config --target alpha --target signed
	$(rbm) build release --step create_update_responses_tar --target alpha --target signed

dmg2mar-release: submodule-update
	$(rbm) build release --step update_responses_config --target release --target signed
	$(rbm) build release --step dmg2mar --target release --target signed
	tools/update-responses/download_missing_versions release
	CHECK_CODESIGNATURE_EXISTS=1 MAR_SKIP_EXISTING=1 tools/update-responses/gen_incrementals release

dmg2mar-alpha: submodule-update
	$(rbm) build release --step update_responses_config --target alpha --target signed
	$(rbm) build release --step dmg2mar --target alpha --target signed
	tools/update-responses/download_missing_versions alpha
	CHECK_CODESIGNATURE_EXISTS=1 MAR_SKIP_EXISTING=1 tools/update-responses/gen_incrementals alpha

submodule-update:
	git submodule update --init

fetch: submodule-update
	$(rbm) fetch

clean: submodule-update
	./tools/clean-old

clean-dry-run: submodule-update
	./tools/clean-old --dry-run

