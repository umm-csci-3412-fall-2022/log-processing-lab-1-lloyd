cd "$1" || exit
sed -nr 's/(\w\w\w)  ?([0-9]+ [0-9][0-9]):[0-9][0-9]:[0-9][0-9] \w+ sshd\[[0-9]+\]: Failed password for (invalid user )?(\w+) from ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*$/\1 \2 \4 \5/w failed_login_data.txt' var/log/*
