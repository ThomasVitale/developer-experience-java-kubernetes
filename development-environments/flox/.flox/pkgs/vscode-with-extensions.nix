{vscode, vscode-utils, vscode-extensions, vscode-with-extensions}:

vscode-with-extensions.override {
  inherit vscode;

  vscodeExtensions = with vscode-extensions; [
    bbenoist.nix
    redhat.java
    redhat.vscode-yaml
    vscjava.vscode-java-debug
    vscjava.vscode-java-test
    vscjava.vscode-java-dependency
    vscjava.vscode-spring-initializr
    visualstudioexptteam.vscodeintellicode
  ] ++ vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "flox";
      publisher = "flox";
      version = "0.0.2";
      hash = "sha256-wvRhPPSnCimpB1HEbAg7a0r9hFKzMZ/Z1vS+XVmviOM=";
    }
    {
      name = "vscode-spring-boot";
      publisher = "vmware";
      sha256 = "sha256-LDhhsvZsQzfdhHbo9SMAea7bcF6JcifTxuzsujdAFNo=";
      version = "2.0.2025072900";
    }
    {
      name = "vscode-spring-boot-dashboard";
      publisher = "vscjava";
      sha256 = "sha256-gtEn4UD5Ft+JJqHcz/Eh4t2njOZJg2NRVtfD8Hy4LT8=";
      version = "0.14.2025041702";
    }
  ];
}
