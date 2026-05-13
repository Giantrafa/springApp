#!/bin/bash

set -e

BASE_URL="http://localhost:8080/api/v1/users"

echo "Teste API Spring Boot"

echo -e "\n1 - Hello World"
curl -s "$BASE_URL/hello"
echo -e "\n"

echo -e "\n2 - Criando usuários"

create_user() {
  local username=$1
  local password=$2
  local age=$3

  curl -s -X POST "$BASE_URL/add" \
    -H "Content-Type: application/json" \
    -d "{
      \"username\": \"$username\",
      \"password\": \"$password\",
      \"age\": $age
    }"
}

create_user "pedro" "111111" 20 | jq
create_user "joao" "999999" 23 | jq
create_user "petrus" "123456" 18 | jq

echo -e "\n\n3 - Listando usuários"
curl -s "$BASE_URL/allUsers" | jq

echo -e "\n\n4 - Buscando usuário por ID (1)"
curl -s "$BASE_URL/user/1" | jq

echo -e "\n\n5 - Atualizando usuário (1)"

curl -s -X PUT "$BASE_URL/update/1" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "Lucas",
    "password": "777777",
    "age": 21
  }' | jq

echo -e "\n\n6 - Deletando usuário (1)"
curl -s -X DELETE "$BASE_URL/user/1" -i

echo -e "\n\n7 - Listando usuários após delete"
curl -s "$BASE_URL/allUsers" | jq