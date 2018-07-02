
mkdir archive
cd archive
../01_download-2017.sh
../02_unpack.sh
../03_convert.sh
cd ..
python 04_extract.py "profiles/all.jsonprofile" "archive/*.json"
python 05_parsesplit.py output.csv
