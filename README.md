# PNG/JPG/JPEG/PNG/AVIF → WebP/AVIF GUI Converter (Windows)

A fast, free and beginner-friendly **Windows image converter** that turns **PNG, JPG, JPEG and AVIF** files into modern **WebP** or **AVIF** formats with just a few clicks.  
Perfect for **web developers, designers, photographers** and anyone who wants **smaller, faster-loading images**.

If you have any problems or need help, **feel free to contact me — happy to assist!** 😊

---

# 👤 For Non-IT Users (Simple Explanation)

This tool helps you **reduce the size of your images** without losing noticeable quality.

### Why this is useful:
- Websites load much faster  
- Images take up far less space  
- Perfect for uploading galleries or sharing images  
- No technical knowledge required  

---

# 🧩 Why you need ImageMagick

This tool uses **ImageMagick** as the “engine” in the background:

➡️ ImageMagick = the powerful engine  
➡️ This program = the easy click-and-go interface

Without ImageMagick, the program cannot convert the images.  
It is safe, free, and widely used by professionals.

Download ImageMagick here:  
https://imagemagick.org/script/download.php  
*(Enable “Install legacy utilities” during installation.)*

---

# 🪄 How to Use the Program (VERY Easy)

1. Install **ImageMagick**  
2. Download the **EXE version** from Releases:  
   https://github.com/martonalpha/png-jpg-jpeg-to-webp-avif-gui/releases  
3. Open the EXE  
4. Choose your folder  
5. Select WebP or AVIF  
6. Press **Start conversion**

The app automatically converts all images in the folder (and subfolders, if enabled).

### SmartScreen warning?
Click:

**More info → Run anyway**  
(This happens because the app is new and unsigned.)

---

# 👨‍💻 For Developers / Technical Users

This tool is a PowerShell-based GUI wrapper around **ImageMagick’s `magick` binary**, offering:

- PNG/JPG/JPEG/AVIF → WebP/AVIF  
- Quality parameter (0–100)  
- Auto-orientation (fixes rotated photos)  
- Optional recursive traversal  
- Optional cleanup of originals  
- Detailed logging  

Ideal for web optimisation workflows and batch image processing.

---

# 🚀 Features

- Supports **PNG, JPG, JPEG, AVIF**
- Outputs **WebP** or **AVIF**
- Batch conversion
- Recursive folder support
- Adjustable quality (0–100)
- Auto-orientation
- Optional deletion of originals
- AVIF → WebP support
- Detailed log output
- Runs entirely offline

---

# 📥 Download (EXE Version)

👉 **Latest Release:**  
https://github.com/martonalpha/png-jpg-jpeg-to-webp-avif-gui/releases

Simply download the EXE, install ImageMagick once, and you’re ready.

---

# 🔧 Requirements

- Windows 10 or 11  
- PowerShell  
- ImageMagick installed  

During ImageMagick installation, turn on:

```
Install legacy utilities (e.g. convert)
```

---

# ⚙ Installation (Script Version)

If you prefer running the `.ps1` script:

1. Install **ImageMagick**  
2. Download the repository  
3. If PowerShell blocks scripts, run:

```powershell
Set-ExecutionPolicy RemoteSigned
```

4. Launch:

```powershell
.\image-converter-gui.ps1
```

---

# 💡 Tips

- **Quality 85** is ideal for websites  
- WebP/AVIF can reduce file sizes by **60–90%**  
- Everything runs locally — your images stay private  
- Deleting originals is optional  

---

# 💬 Support

If you have questions, issues or suggestions,  
**please contact me — I’m happy to help!** 😊

---

# 📄 License

MIT License
