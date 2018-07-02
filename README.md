
# gh-archive-networks

Community Networks Classification of GitHub Archive Data.

This tool downloads all of the GitHub Archive data and transforms it into an edgelist based on commits, issue conversations, pull requests and more.
The edgelist preserves the datetime of interaction, the source and target person of an interaction and the repository the interactions belongs to.
In general, the five scripts numbered 01-05... are executed sequentially.

The default settings allow you to download everything from January, 2017 and it is filtered to the top 50 projects found in the file `2018-05-24-list-gh-repositories-filtered.txt`.
You can change the parameters in the .sh scripts. In `01_download-2017.sh` you can comment in the the other months of 2017 or also include other years. In `03_convert.sh` you can disable the filtering of the projects and include all projects (warning: very large amount of data). If you want to change the extracted columns, you can do so in the profiles folder. See the existing ones as examples. However, the `05_parsesplit.py` is hardcoded with the `all.jsonprofile` in mind.

To just run everything in default settings:
```
  ./00_run-all.sh
```

Some other example runs for the `04_extract.py`:
```
  # Extracts interesting issue details from all logs
  python 04_extract.py "profiles/issue.jsonprofile" "archive/*.json"

  # Extracts all details relevant to to create a social network
  python 04_extract.py "profiles/all.jsonprofile" "archive/*.json"
```
