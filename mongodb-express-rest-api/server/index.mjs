import express from "express";
import cors from "cors";
import path from "path";
import { fileURLToPath } from "url";
import "./loadEnvironment.mjs";
import "express-async-errors";
import posts from "./routes/posts.mjs";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const PORT = process.env.PORT || 5050;
const app = express();

app.use(cors());
app.use(express.json());

// Load the /posts routes
app.use("/posts", posts);

// Serve static files from the React app build directory
app.use(express.static(path.join(__dirname, 'public')));

// Catch all handler: send back React's index.html file for any non-API routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Global error handling
app.use((err, _req, res, next) => {
  res.status(500).send("Uh oh! An unexpected error occured.")
})

// start the Express server
app.listen(PORT, () => {
  console.log(`Server is running on port: ${PORT}`);
});
