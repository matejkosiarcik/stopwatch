# Stopwatch

> Stopwatch is a simple time tracking cli app

![Program screen](docs/example.png)

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Requirements

- Python
  - version `2.6+` or `3.2+`

Stopwatch does *not* have any external (3rd party) dependencies.

## Installation

### With package manager

This method is *not* available yet.

### Locally

```console
$ git clone https://github.com/matejkosiarcik/Stopwatch.git # or download as zip
$ cd Stopwatch
$ pip install .
```

*Alternatively* just put file `/stopwatch/stopwatch.py` somewhere under your
`$PATH`.

### Uninstallation

```console
$ pip uninstall stopwatch-cli
```

## Usage

Run the program `$ stopwatch`.

Controls:

Key | description
--- | ---
&lt;Enter&gt; | new lap
&lt;Space&gt; | pause/continue
&lt;ESC&gt; or &lt;Q&gt; | quit

If you are experiencing troubles, see help page with `$ stopwatch -h` or
`$ stopwatch --help`.

## License

This project is licensed under the MIT License, see [LICENSE.txt](LICENSE.txt)
file for full license details.
