## Takes in name of directory, assuming each subdiretory is the name of a computer, each containing a failed_login_data.txt

scriptloc="$(pwd)"
tmpfile=$(mktemp -d)
filename="$1_usernames.txt"
cd "$tmpfile" || exit
tmploc="$(pwd)"
echo "$scriptloc/$1"
echo "$tmploc"
for file in $(ls "$scriptloc/$1")
do
    awk 'match($0, /([A-Z].*)([" "].*)([" "].*)([" "].*)([" "].*)/, groups) {print groups[4]}' $file >> "$filename"
done	    
sort "$filename" > "${filename::-4}"_sorted.txt
uniq -c "${filename::-4}"_sorted.txt > "$filename"
awk 'match($0, /([0-9].*)([" "].*)([A-Za-z0-9].*)/, grouping) {print data"."addRow("[" "\047" grouping[1] "\047" ,grouping[0]"]")}' > "${filename::-4}"_data.txt
cd "$scriptloc" || exit
echo $(pwd)
/bin/wrap_contents.sh "$tmploc"/"${filename::-4}"_data.txt ../username_dist username_dist.html

