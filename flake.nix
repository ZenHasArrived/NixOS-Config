{
  description = "Nixos config flake";

  inputs = {
    #declare what nixpkgs to use
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #import NixOS hardware module
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";

    #imports home manager
     home-manager = {
       url = "github:nix-community/home-manager"; #sets url, same as inputs.home-manager.url = "blah"
       #tells homemanager to follow nixpkgs
       inputs.nixpkgs.follows = "nixpkgs";
     };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series1
      ];
    };
  };
}
