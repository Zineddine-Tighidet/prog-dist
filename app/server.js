/* jshint esversion: 10 */

// start by creating a simple express app
const express = require("express");
const app = express();
const {Client} = require('pg');

// establish the connexion with the pg db
const client = new Client({
    // host: "localhost",
    host: process.env.POSTGRES_SVC_SERVICE_HOST,
    user: process.env.USER_NAME,
    port:   5432,
    password: process.env.PASSWORD,
    database: "postgres"
});

client.connect();
const users = [];
var dico = {};

// in order to say to our server that we are using ejs syntax
app.set('view-engine', 'ejs');
app.use(express.urlencoded({extended: false}));

// some psql queries
app.post('/results', (req, ress) => {
    try{
        console.log('"' + req.body.planet_id + '"');
        client.query("SELECT * FROM planets;", async (err, res) => {
            if(!err){
                dico = res.rows;
                ress.render("results.ejs", {dico, sup_id: req.body.sup_id});
            }else{
                console.log(err.message);
            }
        });
    }catch{
        ress.redirect("#");
    }
});

/* set app a roots */
// send back the index.ejs file for the / path
app.get('/', (rep, res) => {
    res.render('index.ejs');
});

// redirect to index if he try to enter results by himself 
app.get('/results', (req, res) => {
    res.render('index.ejs');
});


// for static elements (like images ...)
app.use(express.static('public'));

// the app is listening from the 3000 port
app.listen(3000);