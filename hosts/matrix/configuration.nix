{ pkgs, config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./openssh.nix
    ./postgresql.nix
    ./matrix.nix
    ./nginx.nix
    ./systemd.nix
    ./security.nix
    ./tailscale.nix
    ./grafana.nix
    ./prometheus.nix
    ./loki.nix
    ./promtail.nix

  ];

  boot.cleanTmpDir = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  zramSwap.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHe7SO2hNJi76umGXWTzswFnzEd4rrJYr69UBulKlLC8 cmltawt0@m1"
    ];
  };

  environment.systemPackages = [
    pkgs.vim
    pkgs.helix
    pkgs.git
    pkgs.htop
    pkgs.bottom
    pkgs.tailscale
  ];

  system.stateVersion = "22.11";
}
