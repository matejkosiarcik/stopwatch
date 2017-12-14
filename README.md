# Stopwatch

> Stopwatch is command line application and library for time tracking.

![](Examples/example-start.png)

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Testing](#testing)
- [License](#license)

## Requirements

To **use**:

- macOS 10.9+

*Linux support is in the works*.

To **compile**:

- Swift 4.0+
- Xcode 9.0+ (optional)

## Installation

### Download release

Download precompiled binary file from
[releases](https://github.com/matejkosiarcik/Stopwatch/releases).

### Build from source

Clone the repository `$ git clone git@github.com:matejkosiarcik/Stopwatch.git`
or download repository manually as `.zip` file and unzip it.

Navigate to project root `$ cd Stopwatch` and run `$ swift build -c release`.
Your resulting binary can be found at `$ ./.build/release/swatch`.

## Usage

Run the binary `$ ./swatch`.
App prints controls at start, e.g (`space` to pause).
Laps are reported in format: `(from first start) : (from last recorded lap)`,
example:

![](Examples/example-laps.png)

If you are experiencing troubles, see help page with `$ ./swatch -h` or
`$ ./swatch --help`.

## Testing

To test the swift part of project, just run `$ swift test` in project root.
To test whole project including swift, shell and other sources, run
`$ ./Utils/test` in project root.

Not all parts of the app are testable, so always make sure the resulting
executable runs correctly.

## License

This project is licensed under the MIT License,
see [LICENSE.txt](LICENSE.txt) file for full license details.
