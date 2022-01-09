// start by creat a simple express app
const express = require("express")
const app = express()
const {Client} = require('pg')

// establish the connexion with the pg db
const client = new Client({
    host: "localhost",
    user: "root",
    port:   5432,
    password: "root",
    database: "astro"
})

client.connect()
const users = []
var dico = {}

// in order to say to our server that we are using ejs syntax
app.set('view-engine', 'ejs')
app.use(express.urlencoded({extended: false}))

// some psql queries

app.get('/', (req, ress) => {
    try{
        client.query("SELECT * FROM planet;", async (err, res) => {
            if(!err){
                dico = res.rows
                ress.render("index.ejs", {dico    })
            }else{
                console.log(err.message)
            }
        })
    }catch{
        ress.redirect("#")
    }
})

app.post('/index_filter', (req, ress) => {
    try{
        client.query("SELECT * FROM planet WHERE type = '" + req.body.filtre + "';", async (err, res) => {
            if(!err){
                dico = res.rows
                ress.render("index.ejs", {dico    })
            }else{
                console.log(err.message)
            }
        })
    }catch{
        ress.redirect("#")
    }
})

app.post('/results', (req, ress) => {
    try{
        client.query("SELECT * FROM planet NATURAL JOIN descriptions WHERE planet.name = '" + req.body.planet_name + "';", async (err, res) => {
            console.log(res.rows)
            if(!err){
                dico = res.rows
                ress.render("results.ejs", {dico, name : req.body.planet_name})
            }else{
                console.log(err.message)
            }
        })
    }catch{
        ress.redirect("#")
    }
})

/* set app a roots */

// redirect to index if he try to enter results by himself 
app.get('/results', (req, res) => {
    res.render('index.ejs')
})

app.get('/filter', (req, res) => {
    res.render('filter.ejs')
})


// for static elements (like images ...)
app.use(express.static('public'))

// the app is listening from the 3000 port
app.listen(3000)