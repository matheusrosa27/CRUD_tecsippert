let express = require('express');
let mysql = require('mysql');
let app = express();
let conexao = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'TECSIPPERT'
});


app.use(express.static('public'));
conexao.connect(
    (erro) => {
        if (erro) {
            console.log('Erro ao conectar:');
            console.log(erro);
        } else {
            console.log('Conexão realizada com sucesso!');
        }
    }
);

app.get("/",(req,res) => {
    res.sendFile(__dirname+"/index.html");
});

app.get("/consultarCliente",(req,res) => {
    conexao.query("SELECT * FROM clientes",
    (erro,resultado) => {
        if(erro) {
            console.log(erro);
            res.send("Deu erro");
        } else {
            res.send(resultado);
        }
    });
});

app.get("/adicionarCliente",(req,res) => {
    let nome = req.query.nome;
    let endereço = req.query.endereço;
    let cep = req.query.cep;
    let telefone = req.query.telefone;;
    if (!nome || !endereço || !cep || !telefone){
        res.status(400).send('Nome, endereço, CEP e telefone são obrigatórios!')
    } else {
        conexao.query("INSERT INTO clientes (NOME, ENDEREÇO, CEP, TELEFONE) VALUES(?,?,?,?)", [nome, endereço, cep, telefone],
        (erro,resultado) => {
            if(erro) {
                console.log(erro);
                res.status(500).send(erro);
                res.send("Deu erro");
            } else {
                res.send(resultado);
            }
        });
    }
});

app.get("/removerCliente",(req,res) => {
    let id = req.query.id;

    if (!id){
        res.status(400).send('ID é obrigatório!');
    } else {
        conexao.query("DELETE FROM clientes WHERE id=?", [id],
        (erro,resultado) => {
            if(erro) {
                console.log(erro);
                res.status(500).send(erro);
                res.send("Deu erro");
            } else {
                res.send(resultado);
            }
        });
    }
});

app.listen(3000);