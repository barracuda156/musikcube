if (${GENERATE_DEB} MATCHES "true" AND CMAKE_SYSTEM_NAME MATCHES "Linux")
  if (${BUILD_STANDALONE} MATCHES "true")
    set(RPM_ARCH "32bit")
    if (${DEB_ARCHITECTURE} MATCHES "amd64")
      set(RPM_ARCH "64bit")
    endif()
    message(STATUS "[generate-package] RPM_ARCH=${RPM_ARCH}")
    set(CPACK_PACKAGE_FILE_NAME "musikcube_standalone_${musikcube_VERSION}_${DEB_ARCHITECTURE}")
  else()
    set(DEB_BOOST_VERSION "1.55.0")
    set(DEB_MICROHTTPD_VERSION "10")
    set(DEB_LIBCURL_VERSION "3")
    set(DEB_AVUTIL_VERSION "55")
    set(DEB_AVFORMAT_VERSION "57")
    set(DEB_SWRESAMPLE_VERSION "2")
    set(DEB_NCURSES_VERSION "5")
    if (DEB_DISTRO MATCHES "buster")
      set(DEB_BOOST_VERSION "1.67.0")
      set(DEB_MICROHTTPD_VERSION "12")
      set(DEB_LIBCURL_VERSION "4")
      set(DEB_AVUTIL_VERSION "56")
      set(DEB_AVFORMAT_VERSION "58")
      set(DEB_SWRESAMPLE_VERSION "3")
    elseif (DEB_DISTRO MATCHES "bionic")
      set(DEB_BOOST_VERSION "1.65.1")
      set(DEB_MICROHTTPD_VERSION "12")
      set(DEB_LIBCURL_VERSION "4")
    elseif (DEB_DISTRO MATCHES "focal" OR DEB_DISTRO MATCHES "una")
      set(DEB_BOOST_VERSION "1.71.0")
      set(DEB_MICROHTTPD_VERSION "12")
      set(DEB_LIBCURL_VERSION "4")
      set(DEB_AVUTIL_VERSION "56")
      set(DEB_AVFORMAT_VERSION "58")
      set(DEB_SWRESAMPLE_VERSION "3")
      set(DEB_NCURSES_VERSION "6")
    elseif (DEB_DISTRO MATCHES "hirsute")
      set(DEB_BOOST_VERSION "1.71.0")
      set(DEB_MICROHTTPD_VERSION "12")
      set(DEB_LIBCURL_VERSION "4")
      set(DEB_AVUTIL_VERSION "56")
      set(DEB_AVFORMAT_VERSION "58")
      set(DEB_SWRESAMPLE_VERSION "3")
      set(DEB_NCURSES_VERSION "6")
    elseif (DEB_DISTRO MATCHES "impish" OR DEB_DISTRO MATCHES "bullseye")
      set(DEB_BOOST_VERSION "1.74.0")
      set(DEB_MICROHTTPD_VERSION "12")
      set(DEB_LIBCURL_VERSION "4")
      set(DEB_AVUTIL_VERSION "56")
      set(DEB_AVFORMAT_VERSION "58")
      set(DEB_SWRESAMPLE_VERSION "3")
      set(DEB_NCURSES_VERSION "6")
    endif()

    set(DEPENDENCIES "libboost-thread${DEB_BOOST_VERSION}, libboost-system${DEB_BOOST_VERSION}, libboost-chrono${DEB_BOOST_VERSION}, libboost-filesystem${DEB_BOOST_VERSION}, libboost-date-time${DEB_BOOST_VERSION}, libmicrohttpd${DEB_MICROHTTPD_VERSION}, libcurl${DEB_LIBCURL_VERSION}, libogg0, libvorbis0a, libvorbisfile3, libncursesw${DEB_NCURSES_VERSION}, libasound2, libpulse0, pulseaudio, libmp3lame0, libev4, libopenmpt0, libssl1.1")
    set(DEPENDENCIES "${DEPENDENCIES}, libavcodec-extra, libavutil${DEB_AVUTIL_VERSION}, libavformat${DEB_AVFORMAT_VERSION}, libswresample${DEB_SWRESAMPLE_VERSION}")

    if (${ENABLE_BUNDLED_TAGLIB} MATCHES "false")
      set(DEPENDENCIES "${DEPENDENCIES}, libtag1v5")
    endif()

    set(CPACK_PACKAGE_FILE_NAME "musikcube_${musikcube_VERSION}_${DEB_PLATFORM}_${DEB_DISTRO}_${DEB_ARCHITECTURE}")
    set(CPACK_DEBIAN_PACKAGE_DEPENDS ${DEPENDENCIES})

    set(CPACK_RPM_PACKAGE_REQUIRES "boost, libogg, libvorbis, ffmpeg-libs, ncurses, zlib, alsa-lib, pulseaudio-libs, openssl, libcurl, libmicrohttpd, lame, libev, taglib, libopenmpt")
  endif()

  set(CPACK_GENERATOR "DEB" "RPM")

  set(CPACK_PACKAGE_DESCRIPTION "musikcube, a terminal-based music player and library")
  set(CPACK_PACKAGE_VERSION_MAJOR "${musikcube_VERSION_MAJOR}")
  set(CPACK_PACKAGE_VERSION_MINOR "${musikcube_VERSION_MINOR}")
  set(CPACK_PACKAGE_VERSION_PATCH "${musikcube_VERSION_PATCH}")

  set(CPACK_DEBIAN_PACKAGE_MAINTAINER "casey langen")
  set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE ${DEB_ARCHITECTURE})

  set(CPACK_RPM_PACKAGE_LICENSE "BSD-3-Clause")
  set(CPACK_RPM_PACKAGE_ARCHITECTURE, ${DEB_ARCHITECTURE})
  set(CPACK_RPM_PACKAGE_URL "https://www.musikcube.com")
  set(CPACK_RPM_PACKAGE_VERSION "${musikcube_VERSION_MAJOR}.${musikcube_VERSION_MINOR}.${musikcube_VERSION_PATCH}")
  set(CPAKE_RPM_PACKAGE_PROVIDES
    "libboost_atomic.so.1.76.0()(${RPM_ARCH})"
    "libboost_chrono.so.1.76.0()(${RPM_ARCH})"
    "libboost_date_time.so.1.76.0()(${RPM_ARCH})"
    "libboost_filesystem.so.1.76.0()(${RPM_ARCH})"
    "libboost_system.so.1.76.0()(${RPM_ARCH})"
    "libboost_thread.so.1.76.0()(${RPM_ARCH})"
    "libmusikcore.so()(${RPM_ARCH})"
    "libncursesw.so.6(NCURSESW6_5.1.20000708)(${RPM_ARCH})"
    "libncursesw.so.6(NCURSESW6_5.3.20021019)(${RPM_ARCH})"
    "libncursesw.so.6(NCURSESW6_5.7.20081102)(${RPM_ARCH})"
    "libpanelw.so.6(NCURSESW6_5.1.20000708)(${RPM_ARCH})"
    "libtinfo.so.6(NCURSES6_TINFO_5.0.19991023)(${RPM_ARCH})")

  include(CPack)
endif()