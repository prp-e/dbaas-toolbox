# Toolbox for DBaaS 

This is just the base ground of my new company or startup I should say. In this project, I'm going to invent a new DBaaS. Everything is set, as far as I know. 

## API 

The API lives [here](api/). It's a very simple _proof of concept_ I wrote to put everything I made into the test. It takes a very simple JSON formatted input and outputs another JSON, with the basic credentials of your database. 

### Input (cURL example) 

When you run the API, it will be ran on port no. 4567. So imagine we need a database called `mydb`. We also need a username `mysql` and for simplicity, we'll put the password `mysql_pass` as well. We'll send request like this: 

```
curl -X POST -H "Content-Type: application/json" -d '{"database": "mydb", "username": "mysql", "password": "mysql_pass"}' http://localhost:4567/dbaas 
``` 

### Output (cURL example)

When you run the command from the previous section, it'll return a JSON object like : 

```
{"database": "mydb", "port": 6969} 
``` 

It's not perfect, but it can prove the concept. 

## TODO 

- [x] Randomizing the ports 
- [x] Check if port is already taken from the network adapter. 
- [x] Making a simple API for the basic tests 
- [x] Handling `MYSQL_USER` priveleges, so no `MYSQL_ROOT_PASSWORD` will be needed of course. 
- [ ] Integrating the whole thing with Rails application. 