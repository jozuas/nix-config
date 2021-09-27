{ pkgs ? import <nixpkgs> {}}:

let
  projectRoot = "~/TODO";

  rmq-start = pkgs.writeShellScriptBin "rmq-start" ''
    ${pkgs.rabbitmq-server}/bin/rabbitmq-server -detached
    ${pkgs.rabbitmq-server}/bin/rabbitmqctl wait \
    $RABBITMQ_MNESIA_BASE/rabbit@$(${pkgs.hostname}/bin/hostname).pid
  '';
  rmq-stop = pkgs.writeShellScriptBin "rmq-stop" ''
    ${pkgs.rabbitmq-server}/bin/rabbitmqctl stop
  '';
in pkgs.mkShell {
  buildInputs = with pkgs; [
    erlangR22
    elixir_1_9
    rabbitmq-server

    rmq-start
    rmq-stop
  ];
  # Configure a local RabbitMQ that listens on localhost:5672
  shellHook = ''
    export RABBITMQ_HOME="${projectRoot}/.rabbitmq";
    export RABBITMQ_MNESIA_BASE="$RABBITMQ_HOME/mnesia";
    export RABBITMQ_LOG_BASE="$RABBITMQ_HOME/logs";

    if [ ! -d $RABBITMQ_HOME ]; then
      mkdir -p $RABBITMQ_HOME
      mkdir -p $RABBITMQ_MNESIA_BASE
      mkdir -p $RABBITMQ_LOG_BASE

      ${rmq-start}
      rabbitmqctl add_user dev_dashboard dev_dashboard
      rabbitmqctl set_user_tags dev_dashboard administrator
      ${rmq-stop}
    fi
  '';
}
