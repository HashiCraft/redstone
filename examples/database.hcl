http "main" {
  port   = 8080
  path   = "/"
  method = "GET"
}

queue "main" {
  source = resource.http.main.request
}

database_query "mine" {
  source   = "localhost:5432"
  username = "njackson"
  password = "password"
  database = "posgres"
  query    = "INSERT INTO USERS (name) VALUES ('{{queue.mine.message.name}}')"
}