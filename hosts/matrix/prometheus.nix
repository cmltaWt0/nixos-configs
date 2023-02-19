{ config, pkgs, ... }:

{
  services.prometheus = {
    enable = true;
    port = 9001;

    # Node exporters
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9002;
      };
    };

    # Scrappers
    scrapeConfigs = [
      {
        job_name = "matrix";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
      {
        job_name = "vpn";
        static_configs = [{
          targets = [ "3.64.157.159:9100" ];
        }];
      }
    ];
  };
}
