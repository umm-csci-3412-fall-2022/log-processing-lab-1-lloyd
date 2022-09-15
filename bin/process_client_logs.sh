cd "$1"
sed -nr 's/(\w\w\w [0-9]+ [0-9][0-9]):[0-9][0-9]:[0-9][0-9] \w+ sshd\[[0-9]+\]: Failed password for (invalid user )?(\w+) from ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*$/\1 \3 \4/w failed_login_data.txt' var/log/*
