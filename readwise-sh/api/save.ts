import { useDefaultHeaders } from "./headers";
import { isValid } from "../utils/url";

async function save(url: string, author?: string) {
  const readerAPI = "https://readwise.io/api/v3/save/";
  const body = {
    url,
    saved_using: "raycast",
    ...(author && { author }),
  };

  const headers = useDefaultHeaders();

  const response = await fetch(readerAPI, {
    method: "POST",
    headers: headers,
    body: JSON.stringify(body),
  });
  return response;
}

export async function saveURL(url: string, author?: string) {
  if (!isValid(url)) {
    throw new Error("Invalid URL");
  }

  await save(url, author);
}
