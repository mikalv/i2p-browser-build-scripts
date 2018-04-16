ansible-tbb-build:
	ansible-playbook -i inventory tbb-build.yml

fpcentral:
	ANSIBLE_CONFIG='$(@D)/ansible-fpcentral.cfg' ansible-playbook -i inventory --ask-become-pass fpcentral.yml

boklm-tbb-nightly-build:
	ansible-playbook -i inventory boklm-tbb-nightly-build.yml
