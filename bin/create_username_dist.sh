## Takes in name of directory, assuming each subdiretory is the name of a computer, each containing a failed_login_data.txt

scriptloc="$(pwd)"
tmpfile=$(mktemp -d)
filename="$1_usernames.txt"
cd "$tmpfile" || exit
tmploc="$(pwd)"
for file in $(ls "$scriptloc/$1")
do
    awk 'match($0, /([A-Z].*)([" "].*)([" "].*)([" "].*)([" "].*)/, groups) {print groups[4]}' "$scriptloc/$1/$file/failed_login_data.txt" >> "$filename"
done	    
sort "$filename" > "${filename::-4}"_sorted.txt
uniq -c "${filename::-4}"_sorted.txt > "${filename::-4}"_counted.txt
awk 'match($0, /([0-9]+)([" "].*)([" "])([A-Za-z].*)/, grouping) {print "data.addRow([""\047"grouping[4]"\047"", "grouping[1]"]);"}' "${filename::-4}"_counted.txt >> "${filename::-4}"_data.txt
cd "$scriptloc" || exit
source bin/wrap_contents.sh "$tmploc"/"${filename::-4}"_data.txt html_components/username_dist "$1"/username_dist.html

