package detail

import "core:simd"

USE_NATIVE_SIMD :: false

when USE_NATIVE_SIMD && (ODIN_ARCH == .i386 || ODIN_ARCH == .amd64) {

    import "x86"

    hi_dp     :: x86.hi_dp
    hi_dp_bc  :: x86.hi_dp_bc
    rsqrt_nr1 :: x86.rsqrt_nr1
    rcp_nr1   :: x86.rcp_nr1
    
} else {

    hi_dp :: #force_inline proc "contextless" (a, b : #simd[4]f32) -> #simd[4]f32 {
        // TODO: check if this is faster or if reduce_add_ordered would be faster
        bits := transmute(#simd[4]u32) hi_dp_bc(a, b)
        mask :: #simd[4]u32 { 0xFFFFFFFF, 0, 0, 0 }
        return transmute(#simd[4]f32) simd.and(bits, mask)
    }

    hi_dp_bc :: #force_inline proc "contextless" (a, b : #simd[4]f32) -> #simd[4]f32 {
        // TODO: check if this is faster or if reduce_add_ordered would be faster
        out := simd.mul(a, b)
        o1  := simd.swizzle(out, 1, 1, 1, 1)
        o2  := simd.swizzle(out, 2, 2, 2, 2)
        o3  := simd.swizzle(out, 3, 3, 3, 3)
        return simd.add(o1, simd.add(o2, o3))
    }

    rsqrt_nr1 :: #force_inline proc "contextless" (a : #simd[4]f32) -> #simd[4]f32 {
        return simd.recip(simd.sqrt(a))
    }

    rcp_nr1 :: #force_inline proc "contextless" (a : #simd[4]f32) -> #simd[4]f32 {
        return simd.recip(a)
    }    

}
