## Takes in name of directory, assuming each subdiretory is the name of a computer, each containing a failed_login_data.txt

scriptloc="$(pwd)"
tmpfile=$(mktemp -d)
filename="$1_hours.txt"
cd "$tmpfile" || exit
tmploc="$(pwd)"
for file in $(ls "$scriptloc/$1")
do
    if [ -d "$scriptloc/$1/$file" ];
    then
	awk 'match($0, /([A-Z].*)([" "].*)([" "].*)([" "].*)([" "].*)/, groups) {print groups[3]}' "$scriptloc/$1/$file/failed_login_data.txt" >> "$filename"
    fi
done	    
sort "$filename" > "${filename::-4}"_sorted.txt
uniq -c "${filename::-4}"_sorted.txt > "${filename::-4}"_counted.txt
awk 'match($0, /([0-9]+)([" "]+)([0-9].*)/, grouping) {print "data.addRow([""\047"grouping[3]"\047"", "grouping[1]"]);"}' "${filename::-4}"_counted.txt >> "${filename::-4}"_data.txt
cd "$scriptloc" || exit
source bin/wrap_contents.sh "$tmploc"/"${filename::-4}"_data.txt html_components/hours_dist "$1"/hours_dist.html
