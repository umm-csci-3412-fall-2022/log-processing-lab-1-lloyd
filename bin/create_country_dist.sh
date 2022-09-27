## Takes in name of directory, assuming each subdiretory is the name of a computer, each containing a failed_login_data.txt

scriptloc="$(pwd)"
tmpfile=$(mktemp -d)
filename="$1_countries.txt"
cd "$tmpfile" || exit
tmploc="$(pwd)"
for file in $(ls "$scriptloc/$1")
do
    awk 'match($0, /([A-Z].*)([" "].*)([" "].*)([" "].*)([" "].*)/, groups) {print groups[5]}' "$scriptloc/$1/$file/failed_login_data.txt" >> "$filename"
done
sort "$filename" > "${filename::-4}"_sorted.txt
awk 'match($0, /([0-9].*)/, grouping) {print grouping[0]}' "${filename::-4}"_sorted.txt >> "${filename::-4}"_spaceless.txt
join "${filename::-4}"_spaceless.txt "$scriptloc"/etc/country_IP_map.txt >> "${filename::-4}"_mapped.txt
awk 'match($0, /([0-9].*)([" "])([A-Z].*)/, grouping) {print grouping[3]}' "${filename::-4}"_mapped.txt >> "${filename::-4}"_country_list.txt
sort "${filename::-4}"_country_list.txt >> "${filename::-4}"_country_list_sorted.txt
uniq -c "${filename::-4}"_country_list_sorted.txt >> "${filename::-4}"_counted.txt
awk 'match($0, /([" "]+)([0-9]+)([" "])([A-Z]+)/, grouping) {print "data.addRow([""\047"grouping[4]"\047"", "grouping[2]"]);"}' "${filename::-4}"_counted.txt >> "${filename::-4}"_data.txt
cd "$scriptloc" || exit
source bin/wrap_contents.sh "$tmploc"/"${filename::-4}"_data.txt html_components/country_dist "$1"/country_dist.html
