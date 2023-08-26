#!/bin/bash

# Set your desired installation path
INSTALL_PATH="/usr/local"

# Create a temporary directory for the build
BUILD_DIR=$(mktemp -d)

# Clone CMake source code from GitHub
git clone https://github.com/Kitware/CMake.git "$BUILD_DIR"

# Navigate to the build directory
cd "$BUILD_DIR"

# Configure CMake with the custom installation path
./bootstrap --prefix="$INSTALL_PATH"

# Build and install CMake
make
make install

# Clean up the temporary build directory
rm -rf "$BUILD_DIR"

echo "CMake has been installed to $INSTALL_PATH"

