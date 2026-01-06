{ stdenvNoCC, nerd-font-patcher, lib, ... }:
stdenvNoCC.mkDerivation (final: {
  pname = "syne-mono-nerd-font";
  version = "1.0";

  src = ./SyneMono-Regular.ttf;
  nativeBuildInputs = [ nerd-font-patcher ];
  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype

    nerd-font-patcher -c -q --out "$out"/share/fonts/truetype $src 2> /dev/null;

    runHook postInstall
  '';

  meta = let inherit (lib) licenses platforms;
  in {
    license = licenses.ofl;
    platforms = platforms.unix;
  };
})
