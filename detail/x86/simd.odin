//+build i386, amd64
package x86

import "core:simd/x86"
import "core:simd"

hi_dp :: #force_inline proc "contextless" (a, b : #simd[4]f32) -> #simd[4]f32 {
    return x86._mm_dp_ps(a, b, 0b11100001)
}

hi_dp_bc :: #force_inline proc "contextless" (a, b : #simd[4]f32) -> #simd[4]f32 {
    return x86._mm_dp_ps(a, b, 0b11101111)
}

// Reciprocal sqrt with an additional single Newton-Raphson refinement.
rsqrt_nr1 :: #force_inline proc "contextless" (a : #simd[4]f32) -> #simd[4]f32 {
    xn   := x86._mm_rsqrt_ps(a)
    axn2 := simd.mul(a, simd.mul(xn, xn))
    xn3  := simd.sub((#simd[4]f32)(3), axn2)
    return  simd.mul(simd.mul((#simd[4]f32)(0.5), xn), xn3)
}

// Reciprocal with an additional single Newton-Raphson refinement
rcp_nr1 :: #force_inline proc "contextless" (a : #simd[4]f32) -> #simd[4]f32 {
    xn  := x86._mm_rcp_ps(a)
    axn := simd.mul(a, xn)
    return simd.mul(xn, simd.sub((#simd[4]f32)(2), axn))
}
