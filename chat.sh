#!/bin/bash


main(){
    local mensagem="$1"
    if [ -x "$API_KEY" ]; then
        echo "API_KEY is not set"
        exit 1
    fi

    local url="https://api.openai.com/v1/chat/completions"
    local header="Authorization: Bearer $API_KEY"
    local body="{\"model\": \"gpt-3.5-turbo\",\"messages\": [{\"role\": \"user\",\"content\": \"$mensagem\"}]}"
    local response=$(curl -s -H "Content-type: application/json" -X POST -H "$header" -d "$body" "$url")
    local chat_response=$(echo "$response" | jq -r '.choices[0].message.content')
    echo
    echo $chat_response
    echo
}

if [ -z "$1" ]; then
    echo ""
    echo "-----------------------------------------"
    echo "-----------------GPTerm------------------"
    echo "-----------------------------------------"
    echo ""
    echo "Please, inform the question."
    echo "Example: ./chat.sh \"What is the best programming language?\""    
    echo ""
    echo ""
    
    exit 1
fi
main "$1"