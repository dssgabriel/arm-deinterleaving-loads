add_executable(bench main.cpp asm/scalar_deinterleave.S asm/neon_deinterleave.S asm/sve_deinterleave.S)
target_include_directories(bench PUBLIC ../include)
target_compile_options(bench PUBLIC "-mcpu=neoverse-v1")
target_link_libraries(bench PUBLIC fmt::fmt nanobench)
