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
})


// for test
// const client = new Client({
//     host: "localhost",
//     user:  "root",
//     port:   5432,
//     password: "root",
//     database: "astro"
// })


client.connect();
const users = [];
var dico = {};

// in order to say to our server that we are using ejs syntax
app.set('view-engine', 'ejs');
app.use(express.urlencoded({extended: true}));
app.use(express.json());

// some psql queries


app.post("/add", (req, ress) =>{
    try{
        client.query(`INSERT INTO planet (name, mass, gravity, length_of_day, distance_from_sun, path) VALUES ('${req.body.name}', '${req.body.masse}', '${req.body.gravite}', '${req.body.long}', '${req.body.dist}', 'logo');`, async (err, res) => {
            if(!err){
                try{
                    client.query(`INSERT INTO descriptions (name, descr) VALUES ('${req.body.name}', '${req.body.desc}')`, async (errr, res_) => {
                        if(errr){
                            console.log(err.message);
                        }
                    });
                }catch{
                    ress.redirect("#");
                }

                ress.render("add.ejs", {ip : process.env.NODE_IP_ADDR});
            }else{
                console.log(err.message);
            }
        })
    }catch{
        ress.redirect("#");
    }
});



app.post("/delete", (req, ress) =>{
    try{
        client.query(`DELETE FROM planet WHERE name = '${req.body.planet_name}'`, (err, res) => {
            if(!err){
                try{
                    client.query("SELECT * FROM planet;", (errr, resss) => {
                        if(!errr){
                            dico = resss.rows
                            ress.render("delete.ejs", {dico, ip : process.env.NODE_IP_ADDR})
                        }else{
                            console.log(err.message);
                        }
                    });
                }catch{
                    res.redirect("#");
                }
                
            }else{
                console.log(err.message);
            }
        })
    }catch{
        ress.redirect("#");
    }
})



app.get('/delete', (req, ress) => {
    try{
        client.query("SELECT * FROM planet;", async (err, res) => {
            if(!err){
                dico = res.rows
                ress.render("delete.ejs", {dico, ip : process.env.NODE_IP_ADDR})
            }else{
                console.log(err.message);
            }
        });
    }catch{
        ress.redirect("#");
    }
});


app.post('/form_update', (req, ress) => {
    try{
        client.query("UPDATE planet set mass='" + req.body.masse + "', gravity ='" + req.body.gravite + "',   length_of_day ='" + req.body.long + "', distance_from_sun='" + req.body.dist + "' WHERE name = '" + req.body.name + "';", async (err, resss) => {
            var d = req.body.desc;
            d = d.replace("'", "`");
            var sql = ("UPDATE descriptions set descr='" + d + "' WHERE name='" + req.body.name +"';");
            console.log(sql);
            client.query(sql, async (err1, res1) =>{
                if(err){
                    console.log("erreur");
                }
            });
            
            if(!err){
                client.query("SELECT * FROM planet NATURAL JOIN descriptions WHERE name='" + req.body.name + "';", async (errr, res) => {
                    if(!err){
                        dico = res.rows;
                        ress.render("form_update.ejs", {dico, ip : process.env.NODE_IP_ADDR});
                    }else{
                        console.log(errr.message);
                    }
                });
            }else{
                console.log(err.message);
            }
        });
    }catch{
        ress.redirect("#");
    }
});


app.get('/form_update', (req, ress) => {
    try{
        client.query("SELECT * FROM planet NATURAL JOIN descriptions WHERE planet.name = '" + req.query.planet_name + "';", async (err, res) => {
            console.log(req.query.planet_name)
            if(!err){
                dico = res.rows
                ress.render("form_update.ejs", {dico, name : req.query.planet_name, ip : process.env.NODE_IP_ADDR})
            }else{
                console.log(err.message);
            }
        });
    }catch{
        ress.redirect("#");
    }
});

/* set app a roots */


app.get('/add', (req, res) => {
    res.render('add.ejs', {ip : process.env.NODE_IP_ADDR})
});

app.get('/update', (req, ress) => {
    try{
        client.query("SELECT * FROM planet;", async (err, res) => {
            if(!err){
                dico = res.rows;
                ress.render("update.ejs", {dico, ip : process.env.NODE_IP_ADDR});
            }else{
                console.log(err.message);
            }
        })
    }catch{
        ress.redirect("#")
    }
})

// for static elements (like images ...)
app.use(express.static('public'));

// the app is listening from the 3000 port
app.listen(3000);