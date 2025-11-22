Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ---------- helper: log to textbox ----------
function Add-Log {
    param(
        [string]$Message,
        [System.Windows.Forms.TextBox]$LogBox
    )
    $LogBox.AppendText($Message + [Environment]::NewLine)
    $LogBox.SelectionStart = $LogBox.Text.Length
    $LogBox.ScrollToCaret()
}

# ---------- main form ----------
$form               = New-Object System.Windows.Forms.Form
$form.Text          = "PNG/JPG/AVIF -> WebP / AVIF Converter"
$form.StartPosition = "CenterScreen"
$form.Size          = New-Object System.Drawing.Size(780, 580)
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox   = $false
$form.AllowDrop     = $true
$form.Font          = New-Object System.Drawing.Font("Segoe UI", 9)

# ---------- title ----------
$labelTitle                  = New-Object System.Windows.Forms.Label
$labelTitle.Text             = "Image Converter for Web (PNG/JPG/AVIF -> WebP / AVIF)"
$labelTitle.Location         = New-Object System.Drawing.Point(15, 10)
$labelTitle.AutoSize         = $true
$labelTitle.Font             = New-Object System.Drawing.Font("Segoe UI Semibold", 11)
$form.Controls.Add($labelTitle)

$labelSubtitle               = New-Object System.Windows.Forms.Label
$labelSubtitle.Text          = "Select a folder with images, set quality and output format, then click Start."
$labelSubtitle.Location      = New-Object System.Drawing.Point(15, 35)
$labelSubtitle.AutoSize      = $true
$labelSubtitle.ForeColor     = [System.Drawing.Color]::Gray
$form.Controls.Add($labelSubtitle)

# ---------- folder selection ----------
$groupFolder                 = New-Object System.Windows.Forms.GroupBox
$groupFolder.Text            = " Source folder "
$groupFolder.Location        = New-Object System.Drawing.Point(15, 65)
$groupFolder.Size            = New-Object System.Drawing.Size(740, 80)
$form.Controls.Add($groupFolder)

$labelFolder                 = New-Object System.Windows.Forms.Label
$labelFolder.Text            = "Folder:"
$labelFolder.Location        = New-Object System.Drawing.Point(10, 30)
$labelFolder.AutoSize        = $true
$groupFolder.Controls.Add($labelFolder)

$textFolder                  = New-Object System.Windows.Forms.TextBox
$textFolder.Location         = New-Object System.Drawing.Point(70, 27)
$textFolder.Size             = New-Object System.Drawing.Size(540, 24)
$textFolder.AllowDrop        = $true
$groupFolder.Controls.Add($textFolder)

$buttonBrowse                = New-Object System.Windows.Forms.Button
$buttonBrowse.Text           = "Browse..."
$buttonBrowse.Location       = New-Object System.Drawing.Point(620, 25)
$buttonBrowse.Size           = New-Object System.Drawing.Size(90, 28)
$groupFolder.Controls.Add($buttonBrowse)

$folderDialog                = New-Object System.Windows.Forms.FolderBrowserDialog

$buttonBrowse.Add_Click({
    if ($folderDialog.ShowDialog() -eq "OK") {
        $textFolder.Text = $folderDialog.SelectedPath
    }
})

# Drag & Drop to folder textbox
$textFolder.Add_DragEnter({
    if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) {
        $_.Effect = 'Copy'
    } else {
        $_.Effect = 'None'
    }
})

$textFolder.Add_DragDrop({
    $paths = $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    if ($paths -and $paths.Length -gt 0) {
        $first = $paths[0]
        if (Test-Path $first -PathType Container) {
            $textFolder.Text = $first
        } else {
            $textFolder.Text = [System.IO.Path]::GetDirectoryName($first)
        }
    }
})

# ---------- settings ----------
$groupSettings               = New-Object System.Windows.Forms.GroupBox
$groupSettings.Text          = " Settings "
$groupSettings.Location      = New-Object System.Drawing.Point(15, 155)
$groupSettings.Size          = New-Object System.Drawing.Size(740, 110)
$form.Controls.Add($groupSettings)

# Quality
$labelQuality                = New-Object System.Windows.Forms.Label
$labelQuality.Text           = "Quality (0-100):"
$labelQuality.Location       = New-Object System.Drawing.Point(10, 30)
$labelQuality.AutoSize       = $true
$groupSettings.Controls.Add($labelQuality)

$textQuality                 = New-Object System.Windows.Forms.TextBox
$textQuality.Location        = New-Object System.Drawing.Point(120, 27)
$textQuality.Size            = New-Object System.Drawing.Size(50, 24)
$textQuality.Text            = "85"
$groupSettings.Controls.Add($textQuality)

$labelQualityHint            = New-Object System.Windows.Forms.Label
$labelQualityHint.Text       = "(85 is a good default for web)"
$labelQualityHint.Location   = New-Object System.Drawing.Point(180, 30)
$labelQualityHint.AutoSize   = $true
$labelQualityHint.ForeColor  = [System.Drawing.Color]::Gray
$groupSettings.Controls.Add($labelQualityHint)

# Output format
$labelFormat                 = New-Object System.Windows.Forms.Label
$labelFormat.Text            = "Output format:"
$labelFormat.Location        = New-Object System.Drawing.Point(10, 65)
$labelFormat.AutoSize        = $true
$groupSettings.Controls.Add($labelFormat)

$comboFormat                 = New-Object System.Windows.Forms.ComboBox
$comboFormat.Location        = New-Object System.Drawing.Point(120, 62)
$comboFormat.Size            = New-Object System.Drawing.Size(100, 24)
$comboFormat.DropDownStyle   = 'DropDownList'
[void]$comboFormat.Items.Add("webp")
[void]$comboFormat.Items.Add("avif")
$comboFormat.SelectedIndex   = 0
$groupSettings.Controls.Add($comboFormat)

# ---------- options ----------
$groupOptions                = New-Object System.Windows.Forms.GroupBox
$groupOptions.Text           = " Options "
$groupOptions.Location       = New-Object System.Drawing.Point(15, 275)
$groupOptions.Size           = New-Object System.Drawing.Size(740, 90)
$form.Controls.Add($groupOptions)

$checkDelete                 = New-Object System.Windows.Forms.CheckBox
$checkDelete.Text            = "Delete original source files after successful conversion"
$checkDelete.Location        = New-Object System.Drawing.Point(10, 25)
$checkDelete.AutoSize        = $true
$checkDelete.Checked         = $true
$groupOptions.Controls.Add($checkDelete)

$checkRecursive              = New-Object System.Windows.Forms.CheckBox
$checkRecursive.Text         = "Include subfolders (recursive)"
$checkRecursive.Location     = New-Object System.Drawing.Point(10, 50)
$checkRecursive.AutoSize     = $true
$groupOptions.Controls.Add($checkRecursive)

# ---------- start button ----------
$buttonStart                 = New-Object System.Windows.Forms.Button
$buttonStart.Text            = "Start conversion"
$buttonStart.Location        = New-Object System.Drawing.Point(15, 380)
$buttonStart.Size            = New-Object System.Drawing.Size(160, 36)
$buttonStart.Font            = New-Object System.Drawing.Font("Segoe UI Semibold", 9)
$form.Controls.Add($buttonStart)

# ---------- log output ----------
$labelLog                    = New-Object System.Windows.Forms.Label
$labelLog.Text               = "Log output:"
$labelLog.Location           = New-Object System.Drawing.Point(15, 425)
$labelLog.AutoSize           = $true
$form.Controls.Add($labelLog)

$logBox                      = New-Object System.Windows.Forms.TextBox
$logBox.Location             = New-Object System.Drawing.Point(15, 445)
$logBox.Size                 = New-Object System.Drawing.Size(740, 90)
$logBox.Multiline            = $true
$logBox.ScrollBars           = "Vertical"
$logBox.ReadOnly             = $true
$logBox.Font                 = New-Object System.Drawing.Font("Consolas", 9)
$form.Controls.Add($logBox)

# ---------- start logic ----------
$buttonStart.Add_Click({
    $folder = $textFolder.Text.Trim()
    if ([string]::IsNullOrWhiteSpace($folder) -or -not (Test-Path $folder)) {
        [System.Windows.Forms.MessageBox]::Show("Please select a valid folder.","Error","OK","Error")
        return
    }

    # Check ImageMagick
    $magickCmd = Get-Command magick -ErrorAction SilentlyContinue
    if (-not $magickCmd) {
        [System.Windows.Forms.MessageBox]::Show(
            "ImageMagick 'magick' command not found.`r`nPlease install ImageMagick.",
            "ImageMagick not found",
            "OK",
            "Error"
        )
        return
    }

    # Quality validation
    $qualityText = $textQuality.Text.Trim()
    [int]$quality = 0

    if (-not [int]::TryParse($qualityText, [ref]$quality)) {
        [System.Windows.Forms.MessageBox]::Show("Quality must be an integer between 0 and 100.","Error","OK","Error")
        return
    }

    if ($quality -lt 0 -or $quality -gt 100) {
        [System.Windows.Forms.MessageBox]::Show("Quality must be between 0 and 100.","Error","OK","Error")
        return
    }

    $format = $comboFormat.SelectedItem
    $deleteOriginals = $checkDelete.Checked
    $recursive       = $checkRecursive.Checked

    $logBox.Clear()
    Add-Log "Starting conversion..." $logBox
    Add-Log "Folder: $folder" $logBox
    Add-Log "Format: $format" $logBox
    Add-Log "Quality: $quality" $logBox
    Add-Log "Recursive: $recursive" $logBox
    Add-Log "Delete originals: $deleteOriginals" $logBox
    Add-Log "" $logBox

    $buttonStart.Enabled = $false

    try {
        if ($recursive) {
            $files = Get-ChildItem -Path $folder -File -Recurse | Where-Object {
                $_.Extension -in '.jpg','.jpeg','.png','.avif','.JPG','.JPEG','.PNG','.AVIF'
            }
        } else {
            $files = Get-ChildItem -Path $folder -File | Where-Object {
                $_.Extension -in '.jpg','.jpeg','.png','.avif','.JPG','.JPEG','.PNG','.AVIF'
            }
        }

        $total   = $files.Count
        $success = 0
        $fail    = 0

        foreach ($file in $files) {
            $outPath = [System.IO.Path]::ChangeExtension($file.FullName, ".$format")

            Add-Log "Converting: $($file.Name)" $logBox

            & magick $file.FullName -auto-orient -quality $quality $outPath

            if (Test-Path $outPath) {
                if ($deleteOriginals) {
                    Remove-Item $file.FullName -ErrorAction SilentlyContinue
                }
                $success++
                Add-Log "  OK" $logBox
            } else {
                $fail++
                Add-Log "  ERROR" $logBox
            }
        }

        Add-Log "" $logBox
        Add-Log "Done." $logBox
        Add-Log "Total: $total" $logBox
        Add-Log "Success: $success" $logBox
        Add-Log "Failed: $fail" $logBox
    }
    finally {
        $buttonStart.Enabled = $true
    }
})

[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.Application]::Run($form)
