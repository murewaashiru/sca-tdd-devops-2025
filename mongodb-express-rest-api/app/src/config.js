import dotenv from "dotenv";
dotenv.config();

export const baseUrl = process.env.BACKEND_URL || "http://localhost:5050";
