import os
from setuptools import setup

def read(filename):
    with open(os.path.join(os.path.dirname(__file__), filename)) as file:
        return file.read()

setup(
    name = "stopwatch-cli",
    version = "0.3.0",
    description = "Time tracking cli app",
    long_description = read("README.md"),
    long_description_content_type = "text/markdown",
    license = "MIT",
    keywords = "stopwatch watch clock chronos timer",

    author = "Matej Kosiarcik",
    author_email = "matejkosiarcik@gmail.com",
    maintainer = "Matej Kosiarcik",
    maintainer_email = "matejkosiarcik@gmail.com",

    url = "https://github.com/matejkosiarcik/Stopwatch",
    download_url = "https://github.com/matejkosiarcik/Stopwatch/releases",

    packages = ["stopwatch"],
    entry_points = {
        "console_scripts": ["stopwatch = stopwatch:main"],
    },

    classifiers = [
        "Development Status :: 4 - Beta",
        "Environment :: Console",
        "Intended Audience :: End Users/Desktop",
        "License :: OSI Approved :: MIT License",
        "Natural Language :: English",
        "Operating System :: OS Independent",
        "Programming Language :: Python",
        "Topic :: Utilities",
    ]
)
