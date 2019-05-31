domain=""
tg_chat_id=""
tg_token=""

files=$(curl -sS "https://www.nic.it/it/droptime" | grep -oE "/droptime/files/([0-9]+).txt")

while read -r path
do
  echo "Checking $path"
  if curl -sS "https://www.nic.it$path" | grep -q "^$domain$"
  then
    echo "FOUND"
    curl -d "chat_id=$tg_chat_id&text=Trovato $domain in $path" "https://api.telegram.org/bot$tg_token/sendMessage"
  fi
done <<< $files
