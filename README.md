# PNG/JPG/JPEG/PNG/AVIF -> WebP/AVIF GUI Converter

A simple and beginner-friendly Windows tool for converting **PNG, JPG, JPEG and AVIF** images into modern **WebP** or **AVIF** formats.  
Perfect for **web developers**, designers, photographers and anyone who wants smaller, faster-loading images.

If you run into any problems or need help, **feel free to contact me anytime** — I’m always happy to help. 😊

---

## 👇 For Non-IT Users (Easy Explanation)

This program helps you **reduce the size of your images** without losing visible quality.  
Why is this useful?

- Your website loads faster  
- Your storage fills up slower  
- Your photos become easier to share  
- You don’t need to understand complicated software

### 🧩 Why do you need to install *ImageMagick*?

This converter uses a professional image processing engine called **ImageMagick** in the background.

Think of it like this:

➡️ *ImageMagick = the powerful engine*  
➡️ *This converter = the easy and friendly interface*

Without ImageMagick, the program would not be able to do the actual conversion.  
It would open, but it **could not transform** your images.

This is why you must install ImageMagick one time before using the tool.

It is safe, free, and used worldwide by developers, photographers and large companies.

---

### 🪄 How to use the program (simple steps)

1. Install **ImageMagick** from here:  
   https://imagemagick.org/script/download.php  
   (During installation, tick "Install legacy utilities".)

2. Download the **EXE version** from Releases:  
   https://github.com/martonalpha/png-jpg-jpeg-to-webp-avif-gui/releases  

3. Double-click the EXE  
4. Select a folder with your images  
5. Choose WebP or AVIF  
6. Press **Start conversion**

The program will automatically convert all images in that folder.

### 🛡 If Windows shows a blue protection screen:

Click:

**More info → Run anyway**

This is normal because the application is new and not digitally signed yet.

---

## 👇 For IT / Tech Users

The GUI is a PowerShell-based wrapper around ImageMagick’s `magick` binary.  
It batches PNG/JPG/JPEG/AVIF → WebP or AVIF with adjustable quality, orientation fixing and optional recursive traversal.  
Aimed to be a lightweight companion tool for frontend/web optimisation workflows.

---

## Overview

`png-jpg-jpeg-to-webp-avif-gui` is a lightweight Windows PowerShell graphical application that converts multiple images at once using [ImageMagick](https://imagemagick.org).

It supports:

- PNG, JPG, JPEG → WebP/AVIF  
- AVIF → WebP/AVIF  
- Optional recursive folder processing  
- Quality control (0–100)  
- Auto-orientation  
- Optional deletion of original files  

No PowerShell skills needed — the GUI handles everything.

---

## Download (EXE Version)

The easiest way to use the app is to download the ready-made **.exe** file:

👉 **Releases page:**  
https://github.com/martonalpha/png-jpg-jpeg-to-webp-avif-gui/releases

Just download the EXE and run it — no need to open PowerShell manually.  
(Except ImageMagick installation, which is required.)

If SmartScreen warns you, click:

**More info → Run anyway**

This is normal for new unsigned apps.

---

## Features

- **Supports PNG, JPG, JPEG, AVIF**
- **Outputs WebP or AVIF**
- **Batch conversion**
- **Recursive folder support**
- **Adjustable quality (0–100)**
- **Auto-orientation**
- **Optional deletion of originals**
- **AVIF → WebP support**
- **Detailed logging**

---

## Requirements

To run the program, you need:

- Windows 10 or 11  
- PowerShell  
- ImageMagick installed

Download ImageMagick here:  
https://imagemagick.org/script/download.php

During installation, enable:

```
Install legacy utilities (e.g. convert)
```

This ensures the `magick` command works correctly.

---

## Installation (Script Version)

If you prefer using the script instead of the EXE:

1. Install **ImageMagick**
2. Download this repository or the `.ps1` file
3. If PowerShell blocks scripts, run:

```powershell
Set-ExecutionPolicy RemoteSigned
```

4. Start the converter:

```powershell
.\image-converter-gui.ps1
```

---

## Tips

- **Quality 85** is recommended for websites  
- Converting to WebP/AVIF usually reduces image size by **60–90%**  
- The app never uploads your pictures — everything happens locally  
- Deleting originals is optional and safe  

---

## Need Help?

If you have questions, issues, or suggestions,  
**please feel free to contact me — I’m happy to assist!** 😊

---

## License

MIT License
