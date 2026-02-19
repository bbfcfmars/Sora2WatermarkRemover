#!/usr/bin/env bash
# ============================================================
#  Sora2WatermarkRemover — macOS Installer
#  Double-click this file in Finder to install and set up
#  the application.  It will open a Terminal window
#  automatically.
# ============================================================

set -e

# cd to the directory where this script lives (the repo root)
cd "$(dirname "$0")"

SCRIPT_DIR="$PWD"

echo "===================================="
echo "  Sora2WatermarkRemover Installer"
echo "===================================="
echo ""

# ------------------------------------------------------------------
# 1. Detect Python 3
# ------------------------------------------------------------------
PYTHON=""
if command -v python3 &>/dev/null; then
    PYTHON="python3"
elif command -v python &>/dev/null && python --version 2>&1 | grep -q "Python 3"; then
    PYTHON="python"
fi

if [ -z "$PYTHON" ]; then
    echo "ERROR: Python 3 is not installed."
    echo ""
    echo "Please install Python 3.10 or later."
    echo "  • Homebrew:  brew install python"
    echo "  • Official:  https://www.python.org/downloads/"
    echo ""
    read -n 1 -s -r -p "Press any key to exit..."
    exit 1
fi

PYTHON_VERSION=$($PYTHON --version 2>&1)
echo "Found $PYTHON_VERSION"
echo ""

# ------------------------------------------------------------------
# 2. Create (or reuse) a virtual environment
# ------------------------------------------------------------------
VENV_DIR="$PWD/.venv"

if [ -d "$VENV_DIR" ]; then
    echo "Virtual environment already exists at $VENV_DIR"
    read -r -p "Recreate it from scratch? (y/N) " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
        echo "Removing old virtual environment..."
        rm -rf "$VENV_DIR"
        echo "Creating new virtual environment..."
        $PYTHON -m venv "$VENV_DIR"
    fi
else
    echo "Creating virtual environment..."
    $PYTHON -m venv "$VENV_DIR"
fi

# Activate
# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"
echo "Virtual environment activated."
echo ""

# ------------------------------------------------------------------
# 3. Upgrade pip
# ------------------------------------------------------------------
echo "Upgrading pip..."
pip install --upgrade pip
echo ""

# ------------------------------------------------------------------
# 4. Install dependencies
# ------------------------------------------------------------------
echo "Installing dependencies from requirements.txt..."
pip install -r requirements.txt
echo ""

echo "Installing the application..."
pip install .
echo ""

# ------------------------------------------------------------------
# 5. Download the LaMa inpainting model
# ------------------------------------------------------------------
echo "Downloading the LaMa inpainting model..."
if iopaint download --model lama; then
    echo "LaMa model downloaded successfully."
else
    echo ""
    echo "WARNING: Failed to download the LaMa model."
    echo "You can retry later with:  iopaint download --model lama"
fi
echo ""

# ------------------------------------------------------------------
# 6. Done — offer to launch the GUI
# ------------------------------------------------------------------
echo "===================================="
echo "  Installation complete!"
echo "===================================="
echo ""
echo "To launch the application later:"
echo "  1. Open Terminal"
echo "  2. cd $SCRIPT_DIR"
echo "  3. source .venv/bin/activate"
echo "  4. sora-remwm-gui          (GUI)"
echo "     sora-remwm <in> <out>   (CLI)"
echo ""

read -r -p "Launch the GUI now? (Y/n) " launch
if [[ ! "$launch" =~ ^[Nn]$ ]]; then
    echo "Starting Sora2WatermarkRemover GUI..."
    sora-remwm-gui
fi

echo ""
read -n 1 -s -r -p "Press any key to close this window..."
echo ""
