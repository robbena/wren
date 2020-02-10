workspace "wren"
  configurations { "Release", "Debug" }
  platforms { "64bit", "32bit" }
  defaultplatform "64bit"
  startproject "wren_test"
  location ("../" .. _ACTION)

  filter "configurations:Debug"
    targetsuffix "_d"
    defines { "DEBUG" }
    symbols "On"

  filter "configurations:Release"
    defines { "NDEBUG" }
    optimize "On"

  filter "platforms:32bit"
    architecture "x86"

  filter "platforms:64bit"
    architecture "x86_64"

  filter "system:Windows"
    systemversion "latest"
    defines { "_CRT_SECURE_NO_WARNINGS" }

project "wren"
  kind "StaticLib"
  language "C"
  cdialect "C99"
  targetdir "../../lib"

  files {
    "../../src/**.h",
    "../../src/**.c"
  }

  includedirs {
    "../../src/include",
    "../../src/vm",
    "../../src/optional"
  }

project "wren_shared"
  kind "SharedLib"
  targetname "wren"
  language "C"
  cdialect "C99"
  targetdir "../../lib"

  files {
    "../../src/**.h",
    "../../src/**.c"
  }

  includedirs {
    "../../src/include",
    "../../src/vm",
    "../../src/optional"
  }

project "wren_test"
  kind "ConsoleApp"
  language "C"
  cdialect "C99"
  targetdir "../../bin"
  dependson "wren"
  links "wren"

  files {
    "../../test/test.c",
    "../../test/test.h",
    "../../test/api/*.c",
    "../../test/api/*.h"
  }

  includedirs {
    "../../src/include"
  }