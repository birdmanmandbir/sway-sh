// Functions for handling API headers

function getToken() {
  // Get token from environment variable
  const token = process.env.READWISE_TOKEN;
  if (!token) {
    throw new Error("READWISE_TOKEN environment variable is not set. Please add it to your .env file.");
  }
  return token;
}

function getHeaders(token: string) {
  const headers = {
    Authorization: `Token ${token}`,
    "Content-Type": "application/json",
  };
  return headers;
}

export function useDefaultHeaders() {
  return getHeaders(getToken());
}