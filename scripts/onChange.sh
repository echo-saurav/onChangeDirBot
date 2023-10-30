echo "on change $(date) $2 $3 $4"

# content="Change Detected: $2 $3 $4"
content=""
echo $content

orange=13517588
red=15401222
green=11258402

color=$orange
title="Dir Change"
description="description"
dir=$3
file=$4

case $2 in
    "CREATE,ISDIR")
        echo "Directory created: $dir/$file"
        description="Directory created: $dir/$file"
        color=$orange
        title="Directory created"
        ;;
    "CREATE")
        echo "File created: $dir/$file"
        description="File created: $dir/$file"
        color=$orange
        title="File created"
        ;;
    "MODIFY")
        echo "File modified: $dir/$file"
        description="File modified: $dir/$file"
        title="File modified"
        color=$green
        ;;
    "DELETE,ISDIR")
        echo "Directory deleted: $dir/$file"
        description="Directory deleted: $dir/$file"
        title="Directory deleted"
        color=$red
        ;;
    "DELETE")
        echo "File deleted: $dir/$file"
        description="File deleted: $dir/$file"
        title="File deleted"
        color=$red
        ;;
esac

json_payload='{
  "username": "onChangeScript",
  "avatar_url": "https://i.imgur.com/4M34hi2.png",
  "content": "'"$content"'",
  "embeds": [
    {
      "color": "'"$color"'",
      "title": "'$title'",
      "description": "'$description'"
    }
  ]
}'


curl -i -H "Accept: application/json" \
        -H "Content-Type:application/json" \
        -X POST \
        --data "$json_payload" \
        "$1"

