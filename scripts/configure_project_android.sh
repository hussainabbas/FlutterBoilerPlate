if [ -f "../../.env.$1" ]; then

  export $(cat "../../.env.$1" | sed 's/#.*//g' | xargs)

fi

echo "$ENCODED_FILE_KEY" | base64 --decode > "filename.txt"