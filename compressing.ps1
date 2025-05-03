# Function to check if FFmpeg is installed
function Check-FFmpeg {
    $ffmpegPath = Get-Command ffmpeg -ErrorAction SilentlyContinue
    if (-not $ffmpegPath) {
        Write-Host "FFmpeg is not installed. Installing FFmpeg..."
        Install-FFmpeg
    } else {
        Write-Host "FFmpeg is already installed at: $ffmpegPath"
    }
}

# Function to install FFmpeg
function Install-FFmpeg {
    # Download the latest FFmpeg release
    $ffmpegUrl = "https://ffmpeg.org/releases/ffmpeg-release-full.7z"
    $outputPath = "$env:TEMP\ffmpeg.7z"

    # Download the FFmpeg archive
    Invoke-WebRequest -Uri $ffmpegUrl -OutFile $outputPath

    # Extract the downloaded archive
    $sevenZipPath = "C:\Program Files\7-Zip\7z.exe"  # Ensure 7-Zip is installed
    & $sevenZipPath x $outputPath -o"$env:ProgramFiles\ffmpeg" -y

    # Add FFmpeg to the system PATH
    $ffmpegBinPath = "$env:ProgramFiles\ffmpeg\ffmpeg-*\bin"
    [System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$ffmpegBinPath", [System.EnvironmentVariableTarget]::Machine)

    Write-Host "FFmpeg installed successfully. Please restart your PowerShell session."
}

# Root directory with videos or subdirectories with videos
$rootDir = $PSScriptRoot # This sets the root directory to the location of the script
$compressedDir = Join-Path -Path $rootDir -ChildPath "compressed"

# Create the compressed directory if it doesn't exist
if (-not (Test-Path -Path $compressedDir)) {
    New-Item -Path $compressedDir -ItemType Directory
}

# Control file to stop the script
$controlFile = Join-Path -Path $PSScriptRoot -ChildPath "compress_videos_control"
# Log file to track the script
$logFile = Join-Path -Path $PSScriptRoot -ChildPath "compress_videos.log"

# Function to process videos
function Process-Videos {
    param (
        [string]$directory
    )

    Get-ChildItem -Path $directory -Recurse | ForEach-Object {
        if ($_.PSIsContainer) {
            # If it's a directory, recurse into it
            Process-Videos $_.FullName
        } elseif ($_.Extension -eq ".mp4" -or $_.Extension -eq ".mkv") {
            # Check if the file is already processed (ends with "_c")
            if ($_.Name -like "*_c.mp4") {
                Write-Host "Skipping already processed file: $($_.FullName)"
                return
            }

            $outputFile = Join-Path -Path $compressedDir -ChildPath "$($_.BaseName)_c.mp4"
            Write-Host "Processing: $($_.FullName) -> $outputFile"

            # Run FFmpeg command
            & ffmpeg -i $_.FullName -c:v h264_nvenc -preset fast -b:v 5M -r 60 -c:a aac -b:a 128k $outputFile 2>&1 | Tee-Object -FilePath $logFile

            # Show the current status and overall progress
            Write-Host "Last ffmpeg logs:"
            Get-Content $logFile -Tail 10 | Select-String -Pattern 'Error|frame|time='

            if ($LASTEXITCODE -eq 0) {
                # If compression is successful
                Write-Host "Compression successful. Deleting original file: $($_.FullName)"
                Remove-Item $_.FullName -Force
            } else {
                Write-Host "Error compressing $($_.FullName). Original file will not be deleted."
            }
        }

        # Check the control file to see if the script should stop
        if (Test-Path $controlFile) {
            Write-Host "Stopping execution as requested."
            exit
        }
    }
}

# Function to stop the script
function Stop-Script {
    New-Item -Path $controlFile -ItemType File -Force
    Write-Host "Control file created. The script will stop after the current process."
}

# Remove control file on exit
function Remove-ControlFile {
    Remove-Item -Path $controlFile -ErrorAction SilentlyContinue
}

# Register event handlers
Register-EngineEvent PowerShell.Exiting -Action { Remove-ControlFile }

# Register Ctrl+C handler
$handler = Register-ObjectEvent -InputObject $host -EventName "KeyDown" -Action { Stop-Script }

# Start processing videos
Process-Videos $rootDir

# Cleanup
if ($handler -ne $null) {
    Unregister-Event -SourceIdentifier $handler.SourceIdentifier
}
