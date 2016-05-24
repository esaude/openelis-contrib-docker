#!/bin/sh
chown -R postgres "$PGDATA"

if [ -z "$(ls -A "$PGDATA")" ]; then
    gosu postgres initdb
    sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PGDATA"/postgresql.conf

    : ${POSTGRES_USER:="postgres"}
    : ${POSTGRES_DB:=$POSTGRES_USER}

    if [ "$POSTGRES_PASSWORD" ]; then
      pass="PASSWORD '$POSTGRES_PASSWORD'"
      authMethod=md5
    else
      echo "==============================="
      echo "!!! Use \$POSTGRES_PASSWORD env var to secure your database !!!"
      echo "==============================="
      pass=
      authMethod=trust
    fi
    echo


    if [ "$POSTGRES_DB" != 'postgres' ]; then
      createSql="CREATE DATABASE $POSTGRES_DB;"
      echo $createSql | gosu postgres postgres --single -jE
      echo
    fi

    if [ "$POSTGRES_USER" != 'postgres' ]; then
      op=CREATE
    else
      op=ALTER
    fi

    #creating user that will be associated with the openelis application
    # 1 create a new user with login privileges and set password
    # 2 create new database owned by that user with UTF-8 encoding

        tempFile=$(mktemp)
      if [ ! -f "$tempFile" ]; then
          return 1
      fi

      cat <<-EOF > "$tempFile"
      		CREATE USER clinlims WITH PASSWORD 'clinlims';
      		CREATE DATABASE IF NOT EXISTS 'clinlims' CHARACTER SET utf8 COLLATE utf8_general_ci;
      		GRANT ALL PRIVILEGES ON database clinlims TO clinlims;
      	EOF

        psql --username "clinlims" --dbname "clinlims" < "$tempFile"
        rm -f "$tempFile"
    #Restore the database dump file ('oegClinical.backup') into the new database
    #This file is found in the current directory
        sudo -u postgres pg_restore -d clinlims oegClinical.backup

    #Once the restore is complete, bring the database up-to-date using Liquibase
    #This command is found in build.xml located in the current directory
        ant updateDB
    #end of creating openelis user and database
    userSql="$op USER $POSTGRES_USER WITH SUPERUSER $pass;"
    echo $userSql | gosu postgres postgres --single -jE
    echo

    # internal start of server in order to allow set-up using psql-client
    # does not listen on TCP/IP and waits until start finishes
    gosu postgres pg_ctl -D "$PGDATA" \
        -o "-c listen_addresses=''" \
        -w start

    echo
    for f in /docker-entrypoint-initdb.d/*; do
        case "$f" in
            *.sh)  echo "$0: running $f"; . "$f" ;;
            *.sql) echo "$0: running $f"; psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" < "$f" && echo ;;
            *)     echo "$0: ignoring $f" ;;
        esac
        echo
    done

    gosu postgres pg_ctl -D "$PGDATA" -m fast -w stop

    { echo; echo "host all all 0.0.0.0/0 $authMethod"; } >> "$PGDATA"/pg_hba.conf
fi

exec gosu postgres "$@"
Status