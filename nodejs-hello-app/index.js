// index.js

// Express import karo
const express = require('express');
const app = express();

// Port define karo
const port = 3000;

// Simple GET route
app.get('/', (req, res) => {
  res.send('Hello Wajid from Node.js on Kubernetes!');
});

// Optional: Health check endpoint (good for Kubernetes liveness/readiness)
app.get('/health', (req, res) => {
  res.json({ status: 'UP', message: 'App is healthy!' });
});

// Start server on all network interfaces
app.listen(port, '0.0.0.0', () => {
  console.log(`App running on http://0.0.0.0:${port}`);
});

