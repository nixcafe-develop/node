{
  inputs,
  pkgs,
  mkShell,
  system,
  ...
}:
let
  commitCheck = inputs.self.checks.${system}.pre-commit-check.shellHook;
in
mkShell {
  packages = with pkgs; [
    node2nix
    nodejs
    corepack
  ];

  shellHook = ''
    ${commitCheck}

    # Disable download prompt for corepack
    export COREPACK_ENABLE_DOWNLOAD_PROMPT=0
    echo "node version: `${pkgs.nodejs}/bin/node --version`"
  '';

  buildInputs = inputs.self.checks.${system}.pre-commit-check.enabledPackages;
}
