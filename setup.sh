#!/bin/bash
# Setup script to initialize all submodules after cloning

set -e  # Exit on first error

echo "=========================================="
echo "Setting up React-Native-decoder project"
echo "=========================================="
echo ""

# Initialize and update all submodules
echo "Initializing submodules..."
git submodule update --init --recursive

# Optional: pull latest from all submodules
echo ""
echo "Fetching latest submodule content..."
git submodule foreach git fetch origin

echo ""
echo "=========================================="
echo "Setup complete! Submodules initialized."
echo "=========================================="
echo ""
echo "Submodule status:"
git submodule status
