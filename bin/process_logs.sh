tmpfile=$(mktemp -d)
for file in "$@"
do
    chmod 777 "$file"
    unzip=$(tar -zxf "$file")
    source bin/process_client_logs.sh "$unzip"
done
source bin/create_username_dist.sh "$unzip"
source bin/create_hours_dist.sh "$unzip"
source bin/create_country_dist.sh "$unzip"
source bin/assemble_report.sh "$unzip"
