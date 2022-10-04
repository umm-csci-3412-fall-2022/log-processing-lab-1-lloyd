tmpfile=$(mktemp)
cat "$1/country_dist.html" "$1/hours_dist.html" "$1/username_dist.html" > "$tmpfile"
source bin/wrap_contents.sh "$tmpfile" html_components/summary_plots "$1/failed_login_summary.html"
