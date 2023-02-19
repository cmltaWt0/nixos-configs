{ ... }:
{
  networking = {
    hostName = "matrix";
    domain = "rimikt.be";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 8448 ];
      checkReversePath = "loose";
    };
  };
}
