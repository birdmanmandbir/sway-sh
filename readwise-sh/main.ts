import { saveURL } from './api/save.ts';

async function main() {
  // Get URL from command line arguments
  const url = process.argv[2];
  
  if (!url) {
    console.error('Error: No URL provided');
    process.exit(1);
  }

  try {
    await saveURL(url);
    console.log('URL saved successfully');
  } catch (error: any) {
    console.error('Error saving URL:', error.message || String(error));
    process.exit(1);
  }
}

main(); 