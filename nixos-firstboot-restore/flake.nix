# flake.nix
{
  description = "NixOS with first-boot Borg restore";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "aarch64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        nixosConfigurations.vmserver = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ config, lib, pkgs, ... }: {

              networking.hostName = "vmserver";
              time.timeZone = "UTC";

              users.users.root.initialPassword = "nixos";

              environment.systemPackages = [ pkgs.borgbackup ];

              systemd.targets."first-boot" = {
                description = "First boot target to restore state";
                requires = [ "borg-restore.service" ];
                after = [ "network-online.target" ];
                wantedBy = [ "default.target" ];
              };

              systemd.services.borg-restore = {
                description = "Restore system state from Borg backup";
                after = [ "network-online.target" ];
                serviceConfig = {
                  Type = "oneshot";
                  ExecStart = pkgs.writeShellScript "restore-and-switch" ''
                    echo "=== Starting Borg restore ==="
                    # Replace this with actual repo path
                    export BORG_REPO=/mnt/borg
                    export BORG_PASSPHRASE="changeme"
                    borg extract $BORG_REPO::latest
                    echo "=== Restore complete ==="
                    systemctl isolate multi-user.target
                  '';
                  StandardOutput = "journal+console";
                  StandardError = "journal+console";
                };
              };

              boot.loader.grub.device = "/dev/vda";
              boot.kernelParams = [ "console=ttyS0" ];
              services.getty.autoLogin.root = true;
              services.getty.defaultUser = "root";
              services.getty.extraArgs = [ "--noclear" ];
              console.enable = true;

              system.stateVersion = "24.05";
            })
          ];
        };
      });
}

