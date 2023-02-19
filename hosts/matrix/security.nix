{ ... }:
{
  security = {
    acme = {
      acceptTerms = true;
      defaults = {
        email = "cmltawt0@gmail.com";
      };
      certs = {
        "rimikt.be" = {
          group = "matrix-synapse";
          postRun = "systemctl reload nginx.service; systemctl restart matrix-synapse.service";
          extraDomainNames = [ "matrix.rimikt.be"];
        };
      };
    };
  };
  users.users.nginx.extraGroups = [ "matrix-synapse" ];
}


