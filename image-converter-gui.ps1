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
$form.Text          = "Image Converter (PNG/JPG/AVIF -> WebP / AVIF)"
$form.StartPosition = "CenterScreen"
$form.Size          = New-Object System.Drawing.Size(700, 520)
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox   = $false

# ---------- folder selection ----------
$labelFolder        = New-Object System.Windows.Forms.Label
$labelFolder.Text   = "Folder:"
$labelFolder.Location = New-Object System.Drawing.Point(15, 20)
$labelFolder.AutoSize = $true
$form.Controls.Add($labelFolder)

$textFolder         = New-Object System.Windows.Forms.TextBox
$textFolder.Location = New-Object System.Drawing.Point(80, 15)
$textFolder.Size    = New-Object System.Drawing.Size(480, 25)
$form.Controls.Add($textFolder)

$buttonBrowse       = New-Object System.Windows.Forms.Button
$buttonBrowse.Text  = "Browse..."
$buttonBrowse.Location = New-Object System.Drawing.Point(570, 13)
$buttonBrowse.Size  = New-Object System.Drawing.Size(90, 28)
$form.Controls.Add($buttonBrowse)

$folderDialog       = New-Object System.Windows.Forms.FolderBrowserDialog

$buttonBrowse.Add_Click({
    if ($folderDialog.ShowDialog() -eq "OK") {
        $textFolder.Text = $folderDialog.SelectedPath
    }
})

# ---------- quality ----------
$labelQuality          = New-Object System.Windows.Forms.Label
$labelQuality.Text     = "Quality (0-100):"
$labelQuality.Location = New-Object System.Drawing.Point(15, 55)
$labelQuality.AutoSize = $true
$form.Controls.Add($labelQuality)

$textQuality           = New-Object System.Windows.Forms.TextBox
$textQuality.Location  = New-Object System.Drawing.Point(120, 52)
$textQuality.Size      = New-Object System.Drawing.Size(50, 25)
$textQuality.Text      = "85"
$form.Controls.Add($textQuality)

# ---------- output format ----------
$labelFormat           = New-Object System.Windows.Forms.Label
$labelFormat.Text      = "Output format:"
$labelFormat.Location  = New-Object System.Drawing.Point(200, 55)
$labelFormat.AutoSize  = $true
$form.Controls.Add($labelFormat)

$comboFormat           = New-Object System.Windows.Forms.ComboBox
$comboFormat.Location  = New-Object System.Drawing.Point(290, 52)
$comboFormat.Size      = New-Object System.Drawing.Size(80, 25)
$comboFormat.DropDownStyle = 'DropDownList'
[void]$comboFormat.Items.Add("webp")
[void]$comboFormat.Items.Add("avif")
$comboFormat.SelectedIndex = 0
$form.Controls.Add($comboFormat)

# ---------- checkboxes ----------
$checkDelete           = New-Object System.Windows.Forms.CheckBox
$checkDelete.Text      = "Delete original source files after conversion"
$checkDelete.Location  = New-Object System.Drawing.Point(15, 85)
$checkDelete.AutoSize  = $true
$checkDelete.Checked   = $true
$form.Controls.Add($checkDelete)

$checkRecursive        = New-Object System.Windows.Forms.CheckBox
$checkRecursive.Text   = "Include subfolders (recursive)"
$checkRecursive.Location = New-Object System.Drawing.Point(15, 110)
$checkRecursive.AutoSize = $true
$checkRecursive.Checked  = $false
$form.Controls.Add($checkRecursive)

# ---------- start button ----------
$buttonStart           = New-Object System.Windows.Forms.Button
$buttonStart.Text      = "Start conversion"
$buttonStart.Location  = New-Object System.Drawing.Point(15, 140)
$buttonStart.Size      = New-Object System.Drawing.Size(150, 35)
$form.Controls.Add($buttonStart)

# ---------- log textbox ----------
$logBox                = New-Object System.Windows.Forms.TextBox
$logBox.Location       = New-Object System.Drawing.Point(15, 190)
$logBox.Size           = New-Object System.Drawing.Size(645, 270)
$logBox.Multiline      = $true
$logBox.ScrollBars     = "Vertical"
$logBox.ReadOnly       = $true
$logBox.Font           = New-Object System.Drawing.Font("Consolas", 9)
$form.Controls.Add($logBox)

# ---------- start button logic ----------
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
            "ImageMagick 'magick' command not found in PATH.`r`nPlease install ImageMagick.",
            "ImageMagick not found",
            "OK",
            "Error"
        )
        return
    }

    # -------- FIXED QUALITY VALIDATION --------
    $qualityText = $textQuality.Text.Trim()

    [int]$quality = 0
    if (-not [int]::TryParse($qualityText, [ref]$quality)) {
        [System.Windows.Forms.MessageBox]::Show(
            "Quality must be an integer between 0 and 100.",
            "Error","OK","Error"
        )
        return
    }

    if ($quality -lt 0 -or $quality -gt 100) {
        [System.Windows.Forms.MessageBox]::Show(
            "Quality must be between 0 and 100.",
            "Error","OK","Error"
        )
        return
    }
    # ------------------------------------------

    $format = $comboFormat.SelectedItem
    $deleteOriginals = $checkDelete.Checked
    $recursive       = $checkRecursive.Checked

    $logBox.Clear()
    Add-Log "Starting conversion to $format ..." $logBox
    Add-Log "" $logBox

    $buttonStart.Enabled = $false

    try {
        if ($recursive) {
            $files = Get-ChildItem -Path $folder -File -Recurse | Where-Object {
                $_.Extension -in '.jpg', '.jpeg', '.png', '.avif', '.JPG', '.JPEG', '.PNG', '.AVIF'
            }
        } else {
            $files = Get-ChildItem -Path $folder -File | Where-Object {
                $_.Extension -in '.jpg', '.jpeg', '.png', '.avif', '.JPG', '.JPEG', '.PNG', '.AVIF'
            }
        }

        $total   = $files.Count
        $success = 0
        $fail    = 0

        if ($total -eq 0) {
            Add-Log "No PNG/JPG/JPEG/AVIF files found." $logBox
        } else {
            Add-Log "Found $total file(s)." $logBox
            Add-Log "" $logBox

            foreach ($file in $files) {

                $outPath = [System.IO.Path]::ChangeExtension($file.FullName, ".$format")

                Add-Log "Converting: $($file.FullName)" $logBox
                Add-Log "       -->  $outPath" $logBox

                & magick $file.FullName -auto-orient -quality $quality $outPath

                if (Test-Path $outPath) {
                    if ($deleteOriginals) {
                        Remove-Item $file.FullName -ErrorAction SilentlyContinue
                    }
                    $success++
                    Add-Log "  OK" $logBox
                } else {
                    $fail++
                    Add-Log "  ERROR: output not created." $logBox
                }

                Add-Log "" $logBox
            }

            Add-Log "-----------------------------" $logBox
            Add-Log "Done." $logBox
            Add-Log "Total:    $total" $logBox
            Add-Log "Success:  $success" $logBox
            Add-Log "Failed:   $fail" $logBox
        }
    }
    finally {
        $buttonStart.Enabled = $true
    }
})

[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.Application]::Run($form)
