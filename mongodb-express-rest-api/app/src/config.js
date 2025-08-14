import dotenv from "dotenv";

dotenv.config();

console.log("Environment Variables Loaded: ", process.env.BACKEND_URL);
export const baseUrl = process.env.BACKEND_URL || "http://localhost:5050";
