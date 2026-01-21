const { spawn } = require("child_process");

// Start backend
console.log("Starting backend...");
const backend = spawn("python", ["backend/app/app.py"], {
  stdio: "inherit",
  shell: true,
});

backend.on("close", (code) => {
  console.log(`Backend exited with code ${code}`);
});

// Start ngrok after backend
setTimeout(() => {
  console.log("Starting ngrok...");
  const ngrok = spawn("ngrok", ["http", "5000"], {
    stdio: "inherit",
    shell: true,
  });

  ngrok.on("close", (code) => {
    console.log(`Ngrok exited with code ${code}`);
  });
}, 3000);

// Start Expo after ngrok
setTimeout(() => {
  console.log("Starting Expo...");
  const frontend = spawn("npx", ["expo", "start"], {
    stdio: "inherit",
    shell: true,
  });

  frontend.on("close", (code) => {
    console.log(`Expo exited with code ${code}`);
  });
}, 6000);
