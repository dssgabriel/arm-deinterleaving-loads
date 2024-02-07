#include <array>
#include <cstddef>
#include <cstdint>
#include <fmt/core.h>
#include <nanobench.h>
#include <ranges>
#include <string>
#include <locale>
#include <vector>

struct f64x2 {
    double a;
    double b;
};

struct f64x3 {
    double a;
    double b;
    double c;
};

struct f64x4 {
    double a;
    double b;
    double c;
    double d;
};

extern "C" uint64_t scalar_deinterleave2d(size_t n, f64x2 const* vs, double* va, double* vb);
extern "C" uint64_t neon_deinterleave2d(size_t n, f64x2 const* vs, double* va, double* vb);
extern "C" uint64_t sve_deinterleave2d(size_t n, f64x2 const* vs, double* va, double* vb);

extern "C" uint64_t scalar_deinterleave3d(size_t n, f64x3 const* vs, double* va, double* vb, double* vc);
extern "C" uint64_t neon_deinterleave3d(size_t n, f64x3 const* vs, double* va, double* vb, double* vc);
extern "C" uint64_t sve_deinterleave3d(size_t n, f64x3 const* vs, double* va, double* vb, double* vc);

extern "C" uint64_t scalar_deinterleave4d(size_t n, f64x4 const* vs, double* va, double* vb, double* vc, double* vd);
extern "C" uint64_t neon_deinterleave4d(size_t n, f64x4 const* vs, double* va, double* vb, double* vc, double* vd);
extern "C" uint64_t sve_deinterleave4d(size_t n, f64x4 const* vs, double* va, double* vb, double* vc, double* vd);

namespace nb = ankerl::nanobench;

auto main() -> int32_t {
    std::locale::global(std::locale("en_US.UTF-8"));

    std::array<std::string, 9> names{
        "Arm64 de-interleave 2D", "NEON de-interleave 2D", "SVE de-interleave 2D",
        "Arm64 de-interleave 3D", "NEON de-interleave 3D", "SVE de-interleave 3D",
        "Arm64 de-interleave 4D", "NEON de-interleave 4D", "SVE de-interleave 4D",
    };
    std::array<uint64_t, 9> cycles{ 0 };

    constexpr size_t N = 1048576; // 256 MiB in FP64
    std::vector<f64x2> src_x2(N);
    std::vector<f64x3> src_x3(N);
    std::vector<f64x4> src_x4(N);
    std::vector<double> dst_a(N);
    std::vector<double> dst_b(N);
    std::vector<double> dst_c(N);
    std::vector<double> dst_d(N);

    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[0], [&] {
        cycles[0] = scalar_deinterleave2d(N, src_x2.data(), dst_a.data(), dst_b.data());
    });
    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[1], [&] {
        cycles[1] = neon_deinterleave2d(N, src_x2.data(), dst_a.data(), dst_b.data());
    });
    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[2], [&] {
        cycles[2] = sve_deinterleave2d(N, src_x2.data(), dst_a.data(), dst_b.data());
    });

    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[3], [&] {
        cycles[3] = scalar_deinterleave3d(N, src_x3.data(), dst_a.data(), dst_b.data(), dst_c.data());
    });
    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[4], [&] {
        cycles[4] = neon_deinterleave3d(N, src_x3.data(), dst_a.data(), dst_b.data(), dst_c.data());
    });
    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[5], [&] {
        cycles[5] = neon_deinterleave3d(N, src_x3.data(), dst_a.data(), dst_b.data(), dst_c.data());
    });

    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[6], [&] {
        cycles[6] = scalar_deinterleave4d(N, src_x4.data(), dst_a.data(), dst_b.data(), dst_c.data(), dst_d.data());
    });
    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[7], [&] {
        cycles[7] = neon_deinterleave4d(N, src_x4.data(), dst_a.data(), dst_b.data(), dst_c.data(), dst_d.data());
    });
    nb::Bench().minEpochIterations(100).epochs(31).warmup(3).run(names[8], [&] {
        cycles[8] = neon_deinterleave4d(N, src_x4.data(), dst_a.data(), dst_b.data(), dst_c.data(), dst_d.data());
    });

    // Dump code-instrumented cycles measurements
    fmt::print("\n");
    for (size_t i = 0; i < 9; ++i) {
        fmt::print("{}:\t\t{:L} c\n", names[i], cycles[i]);
    }

    return 0;
}
