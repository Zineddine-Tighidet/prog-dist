/* jshint esversion: 10 */

// start by creating a simple express app
const express = require("express");
const app = express();
const {Client} = require('pg');

// establish the connexion with the pg db
const client = new Client({
    host: process.env.POSTGRES_SVC_SERVICE_HOST,
    user:  process.env.USER_NAME,
    port:   5432,
    password: process.env.PASSWORD,
    database: "astro"
});


client.connect();
const users = [];
var dico = {};

// in order to say to our server that we are using ejs syntax
app.set('view-engine', 'ejs');
app.use(express.urlencoded({extended: true}));
app.use(express.json())

// some psql queries
app.get('/', (req, ress) => {
    try{
        client.query("SELECT * FROM planet;", async (err, res) => {
            if(!err){
                dico = res.rows;
                ress.render("index.ejs", {dico, ip : process.env.NODE_IP_ADDR});
            }else{
                console.log(err.message);
            }
        })
    }catch{
        ress.redirect("#");
    }
})

app.get('/index_filter', (req, ress) => {
    try{
        client.query("SELECT * FROM planet WHERE type = '" + req.query.filtre + "';", async (err, res) => {
            if(!err){
                dico = res.rows;
                ress.render("index.ejs", {dico, ip : process.env.NODE_IP_ADDR})
            }else{
                console.log(err.message)
            }
        })
    }catch{
        ress.redirect("#")
    }
})

app.get('/results', (req, ress) => {
    try{
        client.query("SELECT * FROM planet NATURAL JOIN descriptions WHERE planet.name = '" + req.query.planet_name + "';", async (err, res) => {
            console.log(req.query.planet_name);
            if(!err){
                dico = res.rows;
                ress.render("results.ejs", {dico, name : req.query.planet_name, ip : process.env.NODE_IP_ADDR});
            }else{
                console.log(err.message);
            }
        });
    }catch{
        ress.redirect("#");
    }
});


/* set app a roots */

// redirect to index if he try to enter results by himself 
app.get('/results', (req, res) => {
    res.render('index.ejs', {ip : process.env.NODE_IP_ADDR});
});

app.get('/filter', (req, res) => {
    res.render('filter.ejs', {ip : process.env.NODE_IP_ADDR})
})

// for static elements (like images ...)
app.use(express.static('public'));

// the app is listening from the 3000 port
app.listen(4000);