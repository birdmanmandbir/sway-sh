# Mathpix OCR Script

A simple toolkit for using the Mathpix API for OCR (Optical Character Recognition), especially suitable for images containing mathematical formulas. Written in TypeScript and run with Bun.

## Prerequisites

- [Bun](https://bun.sh/) runtime
- Mathpix API key (needs to be configured in the .env file)
- For screenshot functionality (Wayland environment): grim, slurp, wl-clipboard

## Installation

1. Clone or download this repository

2. Install Bun (if not already installed):
```bash
curl -fsSL https://bun.sh/install | bash
```

3. Install dependencies:
```bash
bun install
```

4. Make sure your .env file contains your Mathpix API key:
```
APIKEY=your_api_key_here
```

5. Add execute permissions to the scripts:
```bash
chmod +x mathpix_ocr.ts mathpix_screenshot_ocr.sh
```

## Usage

### Method 1: Process an existing image file

Basic usage:
```bash
bun mathpix_ocr.ts <image_path>
```

Command line options:
```
--text-only         Output plain text results only
--format FORMAT     Specify output format, options: text, latex, html, json
```

Examples:

```bash
# Default output (all formats)
bun mathpix_ocr.ts example.png

# Text output only
bun mathpix_ocr.ts example.png --text-only

# LaTeX output only
bun mathpix_ocr.ts example.png --format latex

# JSON output
bun mathpix_ocr.ts example.png --format json
```

### Method 2: Screenshot and immediate OCR

```bash
./mathpix_screenshot_ocr.sh
```

When you run this script:
1. You will be prompted to select a screen area to capture
2. If it's the first run, the script will install necessary dependencies
3. The screenshot will be automatically processed with OCR
4. The recognition result will be copied to the clipboard
5. A notification will indicate that processing is complete

## Build

If needed, you can build the TypeScript script into JavaScript:

```bash
bun run build
```

This will generate a `mathpix_ocr.js` file in the current directory.

## Output

The script will output the following based on the selected options:

- Extracted plain text (default or with `--text-only`)
- LaTeX format (with `--format latex`)
- HTML format (with `--format html`)
- Complete API response (with `--format json`)

## Notes

- Supported image formats: PNG, JPG, JPEG
- Ensure the image is clear and readable for best OCR results
- Mathpix API may have usage limitations, please refer to their official documentation for details
- This script is designed specifically for Wayland environments 