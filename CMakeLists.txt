cmake_minimum_required(VERSION 3.16)
project(arm-simd-interleaving LANGUAGES CXX ASM)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_ASM_COMPILER gcc)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)

# Use {fmt} for printing stuff
find_package(fmt)

# Nanobench to retrieve perf counters
include(FetchContent)
FetchContent_Declare(
    nanobench
    GIT_REPOSITORY https://github.com/martinus/nanobench.git
    GIT_TAG v4.3.11
    GIT_SHALLOW TRUE)
FetchContent_MakeAvailable(nanobench)

add_subdirectory(src)
