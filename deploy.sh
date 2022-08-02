sed -i '' 's/sqlite.db/\:memory\:/g' package.json
cds build
cp -r db/data gen/srv/srv/data
cf push