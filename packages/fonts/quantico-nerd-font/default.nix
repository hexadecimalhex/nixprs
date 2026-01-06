{ stdenvNoCC, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation (final: {
  pname = "quantico-nerd-font";
  version = "1.0";

  src = ./quantico;
  nativeBuildInputs = [ nerd-font-patcher ];
  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype


    for file in $src/*.ttf; do 
      nerd-font-patcher -c -q --out "$out"/share/fonts/truetype $file 2> /dev/null;
    done;

    runHook postInstall
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    license = licenses.ofl;
    platforms = platforms.unix;
  };
})
