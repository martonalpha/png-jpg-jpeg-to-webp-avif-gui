# PNG/JPG/JPEG/PNG/AVIF → WebP/AVIF GUI Converter

A simple Windows PowerShell GUI tool to batch convert **PNG, JPG, JPEG and AVIF** images into modern **WebP** or **AVIF** formats.  
Perfect for **web developers**, designers and content creators optimizing images for the web.

---

## Overview

`png-jpg-jpeg-to-webp-avif-gui` is a lightweight Windows PowerShell graphical tool designed for developers and creators who need to optimise image assets fast.  
It takes batches of **PNG**, **JPG**, **JPEG**, or **AVIF** files from any selected folder (sub-folder support optional), and converts them into modern **WebP** or **AVIF** formats using [ImageMagick](https://imagemagick.org).

You can set quality, preserve orientation automatically, and optionally delete the original files after conversion.

---

## Features

- **Multiple input formats:** Supports PNG, JPG, JPEG and AVIF.
- **Two modern output formats:** WebP (default) and AVIF.
- **Batch conversion:** Converts all matching files in the selected folder.
- **Recursive mode:** Optionally convert images in all subfolders.
- **Adjustable quality:** Choose a compressed quality between 0 and 100.
- **Orientation preserved:** Uses `-auto-orient` to fix rotated photos.
- **Optional cleanup:** Can delete original PNG/JPG/JPEG/AVIF files after successful conversion.
- **Clear logging:** See every file processed, with success/failure counters.
- **AVIF → WebP support:** If output is set to WebP, AVIF files will also be converted.

---

## Requirements

- **Windows 10/11** with PowerShell enabled.
- **[ImageMagick](https://imagemagick.org/script/download.php)** installed  
  ✔ MUST have the `magick` command available in your PATH.  
  ✔ During installation, enable **"Install legacy utilities"** so ImageMagick registers properly.

---

## Installation

1. Download and install **ImageMagick**.
2. Download this repository (or only the `image-converter-gui.ps1` script).
3. (Optional) If your system blocks PowerShell scripts, run this once in *Administrator PowerShell*:

   ```powershell
   Set-ExecutionPolicy RemoteSigned
