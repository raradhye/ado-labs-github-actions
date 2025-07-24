const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hello from Rajesh Aradhye\'s Project 🚀');
});

app.get('/health', (req, res) => {
    res.send('OK');
});

app.get('/version', (req, res) => {
    res.send(`Version: ${process.env.VERSION || '1.0.0'}`);
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`App running on port ${port}`);
});