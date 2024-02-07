# Benchmarking Arm SIMD de-interleaving loads

## About

This repository implements minimal code examples that measure the performance Arm SIMD (NEON and SVE) de-interleaving load instructions with 64-bit floating-point data: `ld2X`, `ld3X` and `ld4X`.
The assembly code is instrumented to measure the elapsed cycles of each routine implementation. Moreover, we also use the [`nanobench`]() library to assert the stability of the benchmarks and retrieve additional performance counters.


## Usage

### Pre-requisites

- C++17 conforming compiler
- CMake 3.16+

### Build

```sh
cmake -S . -B build
cmake --build build
```

### Run

```sh
./build/src/bench
```


## Results

benchmark                |               ns/op |                op/s |    err% |          ins/op |          cyc/op | cyc/op (instrument)|    IPC | total runtime (s)
:------------------------|--------------------:|--------------------:|--------:|----------------:|----------------:|-------------------:|-------:|:-----------------
 `Arm64 de-interleave 2D`|          106,791.62 |            9,364.03 |    0.6% |      917,516.11 |      269,140.54 |            270,364 |  3.409 | 0.37 
 `NEON de-interleave 2D` |          675,631.32 |            1,480.10 |    3.9% |    3,145,746.11 |    1,736,985.47 |          1,987,030 |  1.811 | 2.33 
 `SVE de-interleave 2D`  |          642,586.97 |            1,556.21 |    3.4% |    1,835,023.13 |    1,646,635.45 |          1,541,501 |  1.114 | 2.19 
 `Arm64 de-interleave 3D`|          156,505.43 |            6,389.55 |    0.2% |    1,179,661.13 |      398,217.41 |            396,931 |  2.962 | 0.54 
 `NEON de-interleave 3D` |        1,228,179.69 |              814.21 |    1.9% |    3,670,036.13 |    3,158,617.08 |          3,244,919 |  1.162 | 4.19 
 `SVE de-interleave 3D`  |        1,215,011.03 |              823.04 |    2.3% |    3,670,036.13 |    3,124,119.23 |          3,895,886 |  1.175 | 4.16 
 `Arm64 de-interleave 4D`|          267,079.80 |            3,744.20 |    0.3% |    1,441,807.13 |      685,236.43 |            687,992 |  2.104 | 0.91 
 `NEON de-interleave 4D` |        2,100,981.67 |              475.97 |    1.3% |    4,194,326.13 |    5,407,170.85 |          5,731,691 |  0.776 | 7.20 
 `SVE de-interleave 4D`  |        2,086,051.44 |              479.37 |    1.6% |    4,194,326.13 |    5,372,054.24 |          5,181,326 |  0.781 | 7.14 
