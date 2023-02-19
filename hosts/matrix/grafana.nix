{ config, pkgs, ... }:

{
  # grafana configuration
  services.grafana = {
    enable = true;
    settings.server = {
      domain = "grafana.rimikt.be";
      http_port = 2342;
      http_addr = "127.0.0.1";
    };
  };

  # nginx reverse proxy
  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
    locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
    };
  };
}
