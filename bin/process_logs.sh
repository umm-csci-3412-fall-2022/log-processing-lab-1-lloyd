tmpfile=$(mktemp -d)
scriptloc="$(pwd)"
for file in "$@"
do
    foldername=${file::-4}
    chmod 777 "$file"
    mkdir "$foldername"
    tar -zxf "$file" -C "$foldername"
    source bin/process_client_logs.sh "$foldername"
    cd "$scriptloc" || exit
done
source bin/create_username_dist.sh log_files
source bin/create_hours_dist.sh log_files
source bin/create_country_dist.sh log_files
source bin/assemble_report.sh log_files
mv log_files/failed_login_summary.html "$scriptloc"
