const express = require('express');
const app = express();

// Cloud Run supplies the PORT environment variable.
// If running locally, it defaults to 8080.
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
    const name = process.env.NAME || 'to DevOps HQ';

    // Serving a styled HTML response
    const html = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hello from Cloud Run</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #333;
            }
            .card {
                background: rgba(255, 255, 255, 0.95);
                padding: 3rem;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
                text-align: center;
                max-width: 400px;
                width: 90%;
                animation: float 6s ease-in-out infinite;
            }
            h1 {
                font-size: 2.5rem;
                margin-bottom: 0.5rem;
                color: #4a4a4a;
            }
            p {
                font-size: 1.1rem;
                color: #666;
                line-height: 1.6;
            }
            .badge {
                display: inline-block;
                margin-top: 1.5rem;
                padding: 0.5rem 1rem;
                background: #4285F4;
                color: white;
                border-radius: 50px;
                font-weight: bold;
                font-size: 0.9rem;
            }
            @keyframes float {
                0% { transform: translatey(0px); }
                50% { transform: translatey(-10px); }
                100% { transform: translatey(0px); }
            }
        </style>
    </head>
    <body>
        <div class="card">
            <h1>Hello World!</h1>
            <p>Welcome, <strong>${name}</strong>. Your Node.js service is successfully running on a container!</p>
            <div class="badge">Powered by Google Cloud Run</div>
        </div>
    </body>
    </html>
  `;

    res.send(html);
});

app.listen(port, () => {
    console.log(`App listening on port ${port}`);
});