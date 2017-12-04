activate_this = '{{ fpcentral_virtualenv }}/bin/activate_this.py'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

import sys
sys.path.insert(0, '{{ fpcentral_rootdir }}/fpcentral')
import os
os.chdir('{{ fpcentral_rootdir }}/fpcentral')
from run import app as application

# we include the fpcentral commit as a comment, to make sure the
# fpcentral.wsgi file is modified when the commit is updated, causing
# the process to be restarted:
# {{ fpcentral_git_commit }}
