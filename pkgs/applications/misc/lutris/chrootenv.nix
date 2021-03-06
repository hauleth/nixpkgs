{ lib, buildFHSUserEnv, lutris-unwrapped
, steamSupport ? true
}:

let

  qt5Deps = pkgs: with pkgs.qt5; [ qtbase qtmultimedia ];
  gnome3Deps = pkgs: with pkgs.gnome3; [ zenity gtksourceview gnome-desktop libgnome-keyring webkitgtk ];
  xorgDeps = pkgs: with pkgs.xorg; [
    libX11 libXrender libXrandr libxcb libXmu libpthreadstubs libXext libXdmcp
    libXxf86vm libXinerama libSM libXv libXaw libXi libXcursor libXcomposite
    xrandr
  ];

in buildFHSUserEnv {
  name = "lutris";

  runScript = "lutris";

  targetPkgs = pkgs: with pkgs; [
    lutris-unwrapped

    # Common
    libsndfile libtheora libogg libvorbis libopus libGLU libpcap libpulseaudio
    libao libusb libevdev libudev libgcrypt libxml2 libusb libpng libmpeg2 libv4l
    libjpeg libxkbcommon libass libcdio libjack2 libsamplerate libzip libmad libaio
    libcap libtiff libva libgphoto2 libxslt libtxc_dxtn libsndfile giflib zlib glib
    alsaLib zziplib bash dbus keyutils zip cabextract freetype unzip coreutils
    readline gcc SDL SDL2 curl graphite2 gtk2 gtk3 udev ncurses wayland libglvnd
    vulkan-loader xdg_utils sqlite

    # Adventure Game Studio
    allegro dumb

    # Desmume
    lua agg soundtouch openal desktop-file-utils pangox_compat atk

    # DGen // TODO: libarchive is broken

    # Dolphin
    bluez ffmpeg gettext portaudio wxGTK30 miniupnpc mbedtls lzo sfml gsm
    wavpack gnutls-kdh orc nettle gmp pcre vulkan-loader

    # DOSBox
    SDL_net SDL_sound

    # GOG
    glib-networking

    # Higan // TODO: "higan is not available for the x86_64 architecture"

    # Libretro
    fluidsynth hidapi mesa libdrm

    # MAME
    qt48 fontconfig SDL2_ttf

    # Mednafen
    freeglut mesa_glu

    # MESS
    expat

    # Minecraft
    nss

    # Mupen64Plus
    boost dash

    # Osmose
    qt4

    # PCSX2 // TODO: "libgobject-2.0.so.0: wrong ELF class: ELFCLASS64"

    # PPSSPP
    glew snappy

    # Redream // "redream is not available for the x86_64 architecture"

    # ResidualVM
    flac

    # rpcs3 // TODO: "error while loading shared libraries: libz.so.1..."
    llvm_4

    # ScummVM
    nasm sndio

    # Snes9x
    epoxy minizip

    # Vice
    bison flex

    # WINE
    perl which p7zip gnused gnugrep psmisc cups lcms2 mpg123 cairo unixODBC
    samba4 sane-backends openldap opencl-headers ocl-icd utillinux

    # ZDOOM
    soundfont-fluid bzip2 game-music-emu
  ] ++ qt5Deps pkgs
    ++ gnome3Deps pkgs
    ++ xorgDeps pkgs
    ++ lib.optional steamSupport pkgs.steam;

  extraInstallCommands = ''
    mkdir -p $out/share
    ln -sf ${lutris-unwrapped}/share/applications $out/share
    ln -sf ${lutris-unwrapped}/share/icons $out/share
  '';
}
