# Video Compression Script

This PowerShell script compresses video files in a specified directory and its subdirectories using FFmpeg. It supports `.mp4` and `.mkv` formats and utilizes NVIDIA's hardware acceleration for faster processing.

## Features

- Checks if FFmpeg is installed and installs it if not.
- Recursively processes video files in the specified directory.
- Compresses videos and saves them in a separate "compressed" directory.
- Logs the output of the compression process.
- Allows stopping the script gracefully using a control file or Ctrl+C.

## Prerequisites

- **PowerShell**: This script is designed to run in a PowerShell environment.
- **7-Zip**: Required for extracting the FFmpeg archive. Ensure it is installed and the path is correct in the script.

## Getting Started

### Step 1: Clone the Repository

Clone this repository to your local machine using the following command:

```bash
git clone https://github.com/yourusername/repository-name.git
```

### Step 2: Open PowerShell

Open PowerShell as an administrator to ensure you have the necessary permissions to install software and modify system environment variables.

### Step 3: Run the Script

1. Navigate to the directory where the script is located:

   ```powershell
   cd path\to\your\script
   ```

2. Execute the script:

   ```powershell
   .\compressing.ps1
   ```

### Step 4: Monitor the Process

- The script will check for FFmpeg installation and install it if necessary.
- It will create a `compressed` directory in the same location as the script to store the compressed videos.
- The script logs the output of the compression process in `compress_videos.log`.

### Step 5: Stop the Script (Optional)

- To stop the script while it is running, you can create a control file by pressing `Ctrl+C`. This will stop the execution after the current video is processed.

## Notes

- Ensure that your videos are in the `.mp4` or `.mkv` format for the script to process them.
- The script will delete the original video files after successful compression. If there is an error during compression, the original file will be retained.
- You may need to adjust the FFmpeg command parameters in the script based on your specific compression needs.

## Troubleshooting

- If you encounter issues with FFmpeg installation, ensure that the URL for the FFmpeg archive is correct and that you have a working internet connection.
- Check the `compress_videos.log` file for detailed error messages if compression fails.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [FFmpeg](https://ffmpeg.org/) for the powerful multimedia framework.
- [7-Zip](https://www.7-zip.org/) for file extraction.

Feel free to contribute to this project by submitting issues or pull requests!
