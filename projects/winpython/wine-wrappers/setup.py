from distutils.core import setup
import py2exe
setup(
    console=["gcc.py", "g++.py", "dllwrap.py"],
    zipfile=None,
    options={"py2exe": {"bundle_files": 1, "compressed": True}}
)
