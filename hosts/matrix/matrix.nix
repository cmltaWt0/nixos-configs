{ config, pkgs, ... }:

let
  fullyQualifiedDomainName = "${config.networking.hostName}.${config.networking.domain}";
in {
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = config.networking.domain;
      max_upload_size = "512M";
      public_baseurl = "https://${fullyQualifiedDomainName}";
      listeners = [
        {
          port = 8008;
          bind_addresses = [ "::1" "127.0.0.1" ];
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [
            {
              names = [ "client" "federation" ];
              compress = true;
            }
          ];
        }
        {
          port = 8448;
          bind_addresses = [ "::" "0.0.0.0" ];
          type = "http";
          tls = true;
          x_forwarded = false;
          resources = [
            {
              names = [ "client" "federation" ];
              compress = false;
            }
          ];
        }
      ];
      enable_registration = false;
      enable_registration_without_verification = false;
      app_service_config_files = [
#        "/var/lib/matrix-appservice-discord/discord-registration.yaml"
      ];
      extraConfigFiles = [
        "/etc/keyring/matrix/matrix-shared-secret"
      ];
      trusted_key_servers = [
        {
          server_name = "matrix.org";
          verify_keys = {
            "ed25519:auto" = "Noi6WqcDj0QmPxCNQqgezwTlBKrfqehY1u2FyWP9uYw";
          };
        }
      ];
      suppress_key_server_warning = true;
      tls_certificate_path = "/var/lib/acme/${config.networking.domain}/fullchain.pem";
      tls_private_key_path = "/var/lib/acme/${config.networking.domain}/key.pem";
    };
  };

}

