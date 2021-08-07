{ pkgs ? import <nixpkgs> {}}:

let
  pg_root = builtins.toString ./. + "/.postgres";

  pg_user = "juozas";
  pg_password = "12345";
  pg_db = "projectdb";
  pg_bind = "127.0.0.1";

  pg-start = pkgs.writeShellScriptBin "pg-start" ''
    ${pkgs.postgresql}/bin/pg_ctl start -l $PGLOG \
      -o '-c listen_addresses=${pg_bind} -c unix_socket_directories=$PGHOST'
  '';
  pg-stop = pkgs.writeShellScriptBin "pg-stop" ''
    ${pkgs.postgresql}/bin/pg_ctl stop
  '';
in pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    postgresql
    pg-start
    pg-stop
  ];
  shellHook = ''
    ## Variables used by psql and convenience scripts ##

    export PGUSER=${pg_user}
    export PGDATABASE=${pg_db}

    export PGDATA=${pg_root}/data
    export PGHOST=${pg_root}/postgres
    export PGLOG=$PGHOST/pg.log

    ## Initialise PostgreSQL if have not already ##

    if [ ! -d ${pg_root} ]; then
      mkdir -p $PGHOST
      mkdir -p $PGDATA

      log_file=${pg_root}/db-init.log

      initdb $PGDATA --auth=trust > $log_file 2>&1

      pg_ctl start -l $PGLOG -o '-c listen_addresses= -c unix_socket_directories=$PGHOST'
      psql postgres -c "CREATE USER ${pg_user} WITH PASSWORD '${pg_password}';"
      psql postgres -c "CREATE DATABASE ${pg_db};"
      psql postgres -c "GRANT ALL PRIVILEGES ON DATABASE ${pg_db} TO ${pg_user};"
      pg_ctl stop
    fi
  '';
}
