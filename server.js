'use strict';

// const express = require('express')
const port = 5000;
const host = '0.0.0.0';
const { HOSTNAME } = process.env ;

var express = require('express');
var app = express();
var fs = require('fs');

app.get('/', (req, res) => {
        res.send('<h1>Hello! My hostname is ' + HOSTNAME + '</h1>')
});

app.get('/test', function(req, res) {
    res.sendFile('test.html', {root: __dirname })
});

app.listen(port, host);
console.log(`Running on http://${host}:${port}`);
