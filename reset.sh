USER=$1
HOST=$2
DB=$3

# SO to the rescue: https://stackoverflow.com/questions/4774054
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo "$SCRIPTPATH"

echo "Dropping DB: $DB"
dropdb --if-exists -U $USER -h $HOST $DB
echo "Creating DB: $DB"
createdb -U $USER -h $HOST $DB
echo "Creating tables in $DB"
psql -U $USER -h $HOST $DB < ${SCRIPTPATH}/setup_snapper3_db.sql
echo "Creating functions in $DB"
psql -U $USER -h $HOST $DB < ${SCRIPTPATH}/add_psql_functions.sql
echo "Finished!"
