{ gestures ? false
, stdenv, fetchurl, pkgconfig
, cairo, fontconfig, freetype, libXft, libXcursor, libXinerama
, libXpm, libXt, librsvg, libpng, fribidi, perl
, libstroke ? null
}:

assert gestures -> libstroke != null;

stdenv.mkDerivation rec {
  pname = "fvwm";
  version = "2.6.8";
  name = "${pname}-${version}";

  src = fetchurl {
    url = "https://github.com/fvwmorg/fvwm/releases/download/${version}/${name}.tar.gz";
    sha256 = "fb36c9235d157411efb7383d09d7d4d25a90fe02d0b2b4f752ca4acc7e9bf341";
  };

  buildInputs = [
    pkgconfig cairo fontconfig freetype
    libXft libXcursor libXinerama libXpm libXt
    librsvg libpng fribidi perl
  ] ++ stdenv.lib.optional gestures libstroke;

  meta = {
    homepage = "http://fvwm.org";
    description = "A multiple large virtual desktop window manager";
    license = stdenv.lib.licenses.gpl2Plus;
    platforms = stdenv.lib.platforms.linux;
    maintainers = with stdenv.lib.maintainers; [ edanaher ];
  };
}
