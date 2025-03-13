#!/usr/bin/env bun
/**
 * Mathpix OCR Script - TypeScript Version
 * Use Mathpix API for OCR recognition
 */

import { readFileSync } from 'fs';
import { resolve } from 'path';
import { parse } from 'dotenv';

// Command line arguments parsing
const args = process.argv.slice(2);
let imagePath = '';
let textOnly = false;
let outputFormat = 'text';

// Parse command line arguments
for (let i = 0; i < args.length; i++) {
  if (args[i] === '--text-only') {
    textOnly = true;
  } else if (args[i] === '--format' && i + 1 < args.length) {
    outputFormat = args[i + 1];
    i++;
  } else if (!imagePath) {
    imagePath = args[i];
  }
}

// Check if image path is provided
if (!imagePath) {
  console.error('Usage: bun mathpix_ocr.ts <image_path> [--text-only] [--format text|latex|html|json]');
  process.exit(1);
}

// Check file extension
if (!imagePath.toLowerCase().endsWith('.png') && 
    !imagePath.toLowerCase().endsWith('.jpg') && 
    !imagePath.toLowerCase().endsWith('.jpeg')) {
  console.error('Warning: File may not be a supported image format (PNG, JPG, JPEG)');
}

// Load environment variables
let apiKey = '';
try {
  const envPath = resolve(process.cwd(), '.env');
  const envFile = readFileSync(envPath, 'utf8');
  const env = parse(envFile);
  apiKey = env.APIKEY || '';
} catch (error) {
  console.error('Error: Unable to load .env file');
}

if (!apiKey) {
  console.error('Error: API key not found, please set APIKEY in the .env file');
  process.exit(1);
}

// Encode image to base64
function encodeImage(imagePath: string): string {
  try {
    const imageBuffer = readFileSync(imagePath);
    return imageBuffer.toString('base64');
  } catch (error) {
    console.error(`Error: File not found ${imagePath}`);
    process.exit(1);
  }
}

// Extract plain text from OCR result
function extractTextOnly(result: any): string {
  if (result.text && result.text.trim()) {
    return result.text;
  } else if (result.latex_styled && result.latex_styled.trim()) {
    return result.latex_styled;
  } else if (result.latex && result.latex.trim()) {
    return result.latex;
  } else if (result.html && result.html.trim()) {
    // Simple HTML tag removal (not perfect)
    return result.html.replace(/<[^>]+>/g, '');
  } else {
    return JSON.stringify(result, null, 2);
  }
}

// Use Mathpix API for OCR
async function ocrWithMathpix(imagePath: string) {
  console.error(`Processing image: ${imagePath}`);
  
  // Mathpix API endpoint
  const url = 'https://api.mathpix.com/v3/text';
  
  // Encode image
  const imageBase64 = encodeImage(imagePath);
  
  // Prepare request headers
  const headers = {
    'app_id': 'app',  // Default app_id
    'app_key': apiKey,
    'Content-type': 'application/json'
  };
  
  // Prepare request data
  const data = {
    src: `data:image/png;base64,${imageBase64}`,
    formats: ['text', 'data', 'html'],
    data_options: {
      include_asciimath: true,
      include_latex: true
    }
  };
  
  try {
    // Send request
    const response = await fetch(url, {
      method: 'POST',
      headers: headers,
      body: JSON.stringify(data)
    });
    
    if (!response.ok) {
      throw new Error(`API request failed: ${response.status} ${response.statusText}`);
    }
    
    // Parse response
    const result = await response.json();
    
    // Determine output content based on parameters
    if (textOnly) {
      console.log(extractTextOnly(result));
      return;
    }
    
    if (outputFormat !== 'text') {
      if (outputFormat === 'latex' && (result.latex_styled || result.latex)) {
        console.log(result.latex_styled || result.latex);
      } else if (outputFormat === 'html' && result.html) {
        console.log(result.html);
      } else if (outputFormat === 'json') {
        console.log(JSON.stringify(result, null, 2));
      }
      return;
    }
    
    // Default output all information
    console.log('\n===== OCR RESULT =====');
    
    if (result.text) {
      console.log('\n--- Text ---');
      console.log(result.text);
    }
    
    if (result.latex_styled || result.latex) {
      console.log('\n--- LaTeX ---');
      console.log(result.latex_styled || result.latex);
    }
    
    if (result.html) {
      console.log('\n--- HTML ---');
      console.log(result.html);
    }
    
    console.log('\n--- Complete Response ---');
    console.log(JSON.stringify(result, null, 2));
    
  } catch (error) {
    console.error(`Error: ${error.message}`);
    process.exit(1);
  }
}

// Execute OCR
ocrWithMathpix(imagePath); 