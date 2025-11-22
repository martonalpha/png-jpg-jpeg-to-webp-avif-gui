# png-jpg-jpeg-to-webp-avif-gui
A simple Windows PowerShell GUI tool to batch convert PNG/JPG/JPEG images into modern WebP or AVIF formats. Perfect for web developers optimizing images for the web.

# PNG/JPG/JPEG to WebP/AVIF GUI

## Overview

`png-jpg-jpeg-to-webp-avif-gui` is a simple Windows PowerShell graphical tool designed for web developers and content creators who need to optimise their image assets.  It takes batches of **PNG**, **JPG**, **JPEG**, or **AVIF** files from a selected folder (with an option to recurse into sub‑folders) and converts them into modern **WebP** or **AVIF** formats using [ImageMagick](https://imagemagick.org).  During the conversion you can control the quality level, preserve the correct image orientation, and optionally remove the original source files.

### Features

- **Multiple input formats:** Accepts PNG, JPG, JPEG and AVIF files.
- **Two modern output formats:** Choose between WebP (default) and AVIF.
- **Batch processing:** Converts every matching file in a folder; optional recursive mode processes sub‑directories as well.
- **Adjustable quality:** Specify a quality value between 0 and 100 for lossy compression.
- **Automatic rotation:** Uses `-auto-orient` so converted images preserve the correct orientation based on EXIF data.
- **Optional clean‑up:** Delete original PNG/JPG/AVIF files after a successful conversion.
- **Clear logging:** See each file as it is processed along with success/failure counts.

## Requirements

- **Windows 10/11** with PowerShell available.
- **[ImageMagick](https://imagemagick.org/script/download.php)** installed and the `magick` command available in your `PATH`.
  - During installation, choose the option to **Install legacy utilities** so that the `magick` command is added.

## Installation

1. Install ImageMagick from the official website and confirm that running `magick` in a command prompt works.
2. Download this repository or the `image-converter-gui.ps1` script file to your local machine.
3. Optional: if your PowerShell execution policy is restrictive, run the following once in an Administrator PowerShell:

   ```powershell
   Set-ExecutionPolicy RemoteSigned
