# Sora2WatermarkRemover

Remove watermarks from Sora 2 generated videos and images using AI (Florence-2 detection + LaMa inpainting).

## Quick Start

### Install with pip

```bash
# Clone the repository
git clone https://github.com/bbfcfmars/Sora2WatermarkRemover.git
cd Sora2WatermarkRemover

# Install the application
pip install .
```

### Install with pip (development mode)

```bash
pip install -e .
```

### Install dependencies only (without package install)

```bash
pip install -r requirements.txt
```

> **Note:** For GPU acceleration, install the appropriate PyTorch version for your CUDA setup.
> See https://pytorch.org/get-started/locally/ for instructions.

### Download the LaMa inpainting model

```bash
iopaint download --model lama
```

## Usage

### Command-Line Interface (CLI)

After installation, use the `sora-remwm` command:

```bash
# Remove watermark from a single video
sora-remwm input_video.mp4 output_video.mp4

# Remove watermark from a single image
sora-remwm input_image.png output_image.png

# Process an entire directory
sora-remwm input_dir/ output_dir/ --overwrite

# Make watermark regions transparent (images only)
sora-remwm input.png output.png --transparent

# Force output format
sora-remwm input_video.mp4 output_video --force-format MP4

# Process every other frame for faster processing
sora-remwm input_video.mp4 output_video.mp4 --frame-step 2
```

Or run the script directly:

```bash
python remwm.py input_video.mp4 output_video.mp4
```

### Graphical User Interface (GUI)

After installation, launch the GUI with:

```bash
sora-remwm-gui
```

Or run the script directly:

```bash
python remwmgui.py
```

### CLI Options

| Option | Description |
|---|---|
| `--overwrite` | Overwrite existing output files |
| `--transparent` | Make watermark regions transparent (images only) |
| `--max-bbox-percent` | Maximum bounding box size as % of image (default: 10) |
| `--force-format` | Force output format: PNG, WEBP, JPG, MP4, AVI |
| `--frame-step` | Process every Nth frame (default: 1 = all frames) |
| `--target-fps` | Target output FPS (default: 0 = same as input) |

### Alternative Setup (Conda)

```bash
# Linux / macOS
bash setup.sh

# Windows
.\install_windows.bat
# or
.\install_windows.ps1
```

## Colab

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1Iqu4RZ9WAhcbO1Jn0wCkMOsw2l1p6z62?usp=sharing)

## Demo

### Removed watermark

[out.webm](https://github.com/user-attachments/assets/d902d040-f54c-4958-8d27-8b3c3bcbb6dd)

### Source

https://github.com/user-attachments/assets/8deffd66-b961-4ec2-9dc0-97695b0f91c5

## Awesome repos

- [SoraWatermarkCleaner](https://github.com/linkedlist771/SoraWatermarkCleaner) - Remove watermarks from Sora 2 videos with best quality
- [sweeta](https://github.com/Kuberwastaken/sweeta) - Remove Watermarks from SORA 2 Video Generations with LaMA inpainting

## Tutorial

[![](https://img.youtube.com/vi/HkXD4zwk6WY/0.jpg)](https://www.youtube.com/watch?v=HkXD4zwk6WY)



