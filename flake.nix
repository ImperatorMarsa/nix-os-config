{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NUR
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware support
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { nixpkgs, home-manager, nur, nixos-hardware, nix-on-droid, ... }@inputs: {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#think-nix'
    nixOnDroidConfigurations.nexus = nix-on-droid.lib.nixOnDroidConfiguration {
      modules = [ ./nixos/droid/nix-on-droid.nix ];
    };

    nixosConfigurations = {
      # FIXME replace with your hostname
      think-nix = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [
          # nixos-hardware.nixosModules.lenovo-thinkpad-x220
          ./nixos/thinkpad/configuration.nix
          ./nixos/nix-settings.nix
          ./nixos/locale.nix
          ./nixos/fonts.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#timofey@think-nix'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "timofey@think-nix" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs nur; }; # Pass flake inputs to our config
        # > Our main home-manager configuration file <
        modules = [
          ./home-manager/home.nix
          ./home-manager/programs/nvim/nvim.nix
        ];
      };
    };
  };
}
