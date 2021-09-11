'use strict';

const express = require('express');
const port = 8080;
const host = '0.0.0.0';

const app = express();
app.get('/', (req, res) => {
    res.send('Node docker container');
});

app.listen(port, host);
console.log(`Running on http://${port}:${host}`);