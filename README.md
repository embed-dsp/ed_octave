
# Compile and Install of the Octave Tool

This repository contains a **make** file for easy compile and install of [Octave](https://octave.org).

# Get Source Code

## ed_octave

```bash
git clone https://github.com/embed-dsp/ed_octave.git
```

## Octave

```bash
# Enter the ed_octave directory.
cd ed_octave

# Edit the Makefile for selecting the Octave source version.
vim Makefile
PACKAGE_VERSION = 8.1.0
```

```bash
# Download Octave source package into src/ directory.
make download
```


# Build

```bash
# Unpack source code into build/ directory.
make prepare
```

```bash
# Configure source code.
make configure
```

```bash
# Compile source code using 8 simultaneous jobs (Default).
make compile
```


# Install

```bash
# Install build products.
sudo make install
```

# References

* https://octave.org
* https://gnu-octave.github.io/packages/
* https://github.com/gnu-octave
