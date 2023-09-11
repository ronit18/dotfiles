#!/bin/bash
walldir="$HOME/pix/save"
maxpage=7
tagoptions="#minimalism\n#Cyberpunk 2077\n#fantasy girl\n#digital art\n#anime\n#4K\n#nature"
if [ -z $1 ]; then
query=$(echo -e $tagoptions | dmenu -p "Search Wallhaven: " -i)
else
query=$1
fi
sortoptions="date_added\nrelevance\nrandom\nviews\nfavorites\ntoplist"
sorting=$(echo -e $sortoptions | dmenu -p "Sort Order: " -i)
query="$(sed 's/#//g' <<<$query)"
query="$(sed 's/ /+/g' <<<$query)"
echo $query
for i in $(seq 1 5);
do
curl -s https://wallhaven.cc/api/v1/search\?atleast\=1920x1080\&sorting\=$sorting\&q\=$query\&page\=$i > tmp.txt
page=$(cat tmp.txt | jq '.' | grep -Eoh "https:\/\/w\.wallhaven.cc\/full\/.*(jpg|png)\b")
wget -nc -P $walldir $page S
done 
rm tmp.txt
mv $walldir/* ~/pix/wall/
