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
git clone https://github.com/Ichibaman/FFMPEG-Video-Compressing-with-GPU.git
```

### Step 2: Copy Video Files

Copy and paste the video files you want to compress into the same directory where the `compressing.ps1` script is located.

### Step 3: Open PowerShell

Open PowerShell as an administrator to ensure you have the necessary permissions to install software and modify system environment variables.

### Step 4: Run the Script

1. Navigate to the directory where the script is located:

   ```powershell
   cd path\to\your\script
   ```

2. Execute the script:

   ```powershell
   .\compressing.ps1
   ```

### Step 5: Monitor the Process

- The script will check for FFmpeg installation and install it if necessary.
- It will create a `compressed` directory in the same location as the script to store the compressed videos.
- The script logs the output of the compression process in `compress_videos.log`.

### Step 6: Stop the Script (Optional)

- To stop the script while it is running, you can create a control file by pressing `Ctrl+C`. This will stop the execution after the current video is processed.

Certainly! Below is a list of parameters you can choose when configuring the FFmpeg command for video compression, along with brief descriptions of each parameter. You can adjust these based on your specific requirements for quality, speed, and file size.

### Here some List of FFmpeg Parameters to Choose :

1. **Input File**:
   - `-i <input_file>`: Specify the input video file path.

2. **Video Codec**:
   - `-c:v <codec>`: Choose the video codec.
     - Examples: 
       - `h264_nvenc` (NVIDIA hardware-accelerated H.264)
       - `libx264` (software H.264)
       - `hevc_nvenc` (NVIDIA hardware-accelerated H.265)
       - `libx265` (software H.265)

3. **Preset**:
   - `-preset <preset>`: Control the encoding speed and quality.
     - Options: 
       - `ultrafast`
       - `superfast`
       - `veryfast`
       - `faster`
       - `fast`
       - `medium` (default)
       - `slow`
       - `veryslow`

4. **Video Bitrate**:
   - `-b:v <bitrate>`: Set the target video bitrate.
     - Example: `-b:v 5M` (5 megabits per second)

5. **Frame Rate**:
   - `-r <fps>`: Set the output frame rate.
     - Example: `-r 30` (30 frames per second)

6. **Audio Codec**:
   - `-c:a <codec>`: Choose the audio codec.
     - Examples:
       - `aac` (Advanced Audio Codec)
       - `libmp3lame` (MP3)
       - `copy` (copy the original audio without re-encoding)

7. **Audio Bitrate**:
   - `-b:a <bitrate>`: Set the audio bitrate.
     - Example: `-b:a 128k` (128 kilobits per second)

8. **Output File**:
   - `<output_file>`: Specify the output file path and name.

### Example Combinations

Here are a few example combinations of parameters you might choose based on different use cases:

1. **High-Quality Compression**:
   ```bash
   ffmpeg -i input.mp4 -c:v libx264 -preset slow -b:v 8M -r 30 -c:a aac -b:a 192k output.mp4
   ```

2. **Fast Compression for Streaming**:
   ```bash
   ffmpeg -i input.mp4 -c:v h264_nvenc -preset fast -b:v 4M -r 30 -c:a aac -b:a 128k output.mp4
   ```

3. **High Efficiency (H.265)**:
   ```bash
   ffmpeg -i input.mp4 -c:v hevc_nvenc -preset medium -b:v 5M -r 30 -c:a aac -b:a 128k output.mp4
   ```

4. **Copy Original Audio**:
   ```bash
   ffmpeg -i input.mp4 -c:v h264_nvenc -preset fast -b:v 5M -r 30 -c:a copy output.mp4
   ```

### Conclusion

When configuring the FFmpeg command, consider the trade-offs between quality, file size, and processing speed. Adjust the parameters based on your specific needs and the capabilities of your hardware.

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
