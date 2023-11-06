echo "on change $(date) $2 $3 $4"

# content="Change Detected: $2 $3 $4"
content=""
echo $content

orange=16751892
red=15401222
green=11258402
purple=5707375
blue=1811455

color=$orange
title=""
description=""
dir=$3
file=$4

case $2 in
    "CREATE,ISDIR")
        echo "Directory created: $dir/$file"
        description="Directory created: $dir/$file"
        color=$purple
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
    "MOVED_TO")
        echo "File or directory moved to: $dir/$file"
        description="File or directory moved to: $dir/$file"
        title="File or directory moved"
        color=$blue
        ;;
    "MOVED_FROM")
        echo "File or directory moved from: $dir/$file"
        description="File or directory moved from: $dir/$file"
        title="File or directory moved"
        color=$blue
        ;;
esac

if [ ! -z "$title" ] && [ ! -z "$description" ];then

  json_payload='{
    "username": "onChangeDetection",
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

fi









