package pga3d

import "core:math"
import "core:simd"
import "../detail"

Ideal_Line :: struct {
    _p2 : #simd[4]f32,
}

ideal_line :: #force_inline proc "contextless" (a, b, c : f32) -> Ideal_Line {
    return Ideal_Line{#simd[4]f32{0, a, b, c}}
}

@private
squared_norm_ideal_line :: #force_inline proc "contextless" (l : Ideal_Line) -> f32 {
    return simd.extract(detail.hi_dp(l._p2, l._p2), 0)
}

@private
norm_ideal_line :: #force_inline proc "contextless" (l : Ideal_Line) -> f32 {
    return math.sqrt(squared_norm_ideal_line(l))
}

@private
reverse_ideal_line :: #force_inline proc "contextless" (l : ^Ideal_Line) {
    // flip sign bits of floats
    l._p2 = transmute(#simd[4]f32) simd.xor(
        transmute(#simd[4]u32) l._p2,
        #simd[4]u32{ 0, 1 << 31, 1 << 31, 1 << 31 },
    )
}

@private
reversed_ideal_line :: #force_inline proc "contextless" (l : Ideal_Line) -> Ideal_Line {
    // flip sign bits of floats
    return Ideal_Line {
        transmute(#simd[4]f32) simd.xor(
            transmute(#simd[4]u32) l._p2,
            #simd[4]u32{ 0, 1 << 31, 1 << 31, 1 << 31 },
        ),
    }
}

@private
neg_ideal_line :: #force_inline proc "contextless" (l : Ideal_Line) -> Ideal_Line {
    return Ideal_Line { simd.neg(l._p2) }
}

@private
neg_ass_ideal_line :: #force_inline proc "contextless" (l : ^Ideal_Line) {
    l._p2 = simd.neg(l._p2)
}

@private
add_ideal_line :: #force_inline proc "contextless" (a, b : Ideal_Line) -> Ideal_Line {
    return Ideal_Line { simd.add(a._p2, b._p2) }
}

@private
add_ass_ideal_line :: #force_inline proc "contextless" (a : ^Ideal_Line, b : Ideal_Line) {
    a._p2 = simd.add(a._p2, b._p2)
}

@private
sub_ideal_line :: #force_inline proc "contextless" (a, b : Ideal_Line) -> Ideal_Line {
    return Ideal_Line { simd.sub(a._p2, b._p2) }
}

@private
sub_ass_ideal_line :: #force_inline proc "contextless" (a : ^Ideal_Line, b : Ideal_Line) {
    a._p2 = simd.sub(a._p2, b._p2)
}

@private
mul_ideal_line :: #force_inline proc "contextless" (a : Ideal_Line, b : f32) -> Ideal_Line {
    return Ideal_Line { simd.mul(a._p2, (#simd[4]f32)(b)) }
}

@private
mul_ass_ideal_line :: #force_inline proc "contextless" (a : ^Ideal_Line, b : f32) {
    a._p2 = simd.mul(a._p2, (#simd[4]f32)(b))
}

@private
div_ideal_line :: #force_inline proc "contextless" (a : Ideal_Line, b : f32) -> Ideal_Line {
    return Ideal_Line { simd.mul(a._p2, detail.rcp_nr1((#simd[4]f32)(b))) }
}

@private
div_ass_ideal_line :: #force_inline proc "contextless" (a : ^Ideal_Line, b : f32) {
    a._p2 = simd.mul(a._p2, detail.rcp_nr1((#simd[4]f32)(b)))
}
