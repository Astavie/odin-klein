package pga3d

import "core:math"
import "core:simd"
import "../detail"

Branch :: struct {
    _p1 : #simd[4]f32,
}

branch :: #force_inline proc "contextless" (a, b, c : f32) -> Branch {
    return Branch{#simd[4]f32{0, a, b, c}}
}

@private
squared_norm_branch :: #force_inline proc "contextless" (l : Branch) -> f32 {
    return simd.extract(detail.hi_dp(l._p1, l._p1), 0)
}

@private
norm_branch :: #force_inline proc "contextless" (l : Branch) -> f32 {
    return math.sqrt(squared_norm_branch(l))
}

@private
normalize_branch :: #force_inline proc "contextless" (l : ^Branch) {
    tmp := detail.rsqrt_nr1(detail.hi_dp_bc(l._p1, l._p1))
    l._p1 = simd.mul(l._p1, tmp)
}

@private
normalized_branch :: #force_inline proc "contextless" (l : Branch) -> Branch {
    tmp := detail.rsqrt_nr1(detail.hi_dp_bc(l._p1, l._p1))
    return Branch { simd.mul(l._p1, tmp) }
}

@private
invert_branch :: #force_inline proc "contextless" (l : ^Branch) {
    tmp := detail.rsqrt_nr1(detail.hi_dp_bc(l._p1, l._p1))
    l._p1 = simd.mul(l._p1, tmp)
    l._p1 = simd.mul(l._p1, tmp)
    reverse_branch(l)
}

@private
inverted_branch :: #force_inline proc "contextless" (l : Branch) -> Branch {
    out := l
    invert_branch(&out)
    return out
}

@private
x_branch :: #force_inline proc "contextless" (l : Branch) -> f32 {
    return simd.extract(l._p1, 1)
}

@private
y_branch :: #force_inline proc "contextless" (l : Branch) -> f32 {
    return simd.extract(l._p1, 2)
}

@private
z_branch :: #force_inline proc "contextless" (l : Branch) -> f32 {
    return simd.extract(l._p1, 3)
}

@private
reverse_branch :: #force_inline proc "contextless" (l : ^Branch) {
    // flip sign bits of floats
    l._p1 = transmute(#simd[4]f32) simd.xor(
        transmute(#simd[4]u32) l._p1,
        #simd[4]u32{ 0, 1 << 31, 1 << 31, 1 << 31 },
    )
}

@private
reversed_branch :: #force_inline proc "contextless" (l : Branch) -> Branch {
    // flip sign bits of floats
    return Branch {
        transmute(#simd[4]f32) simd.xor(
            transmute(#simd[4]u32) l._p1,
            #simd[4]u32{ 0, 1 << 31, 1 << 31, 1 << 31 },
        ),
    }
}

@private
neg_branch :: #force_inline proc "contextless" (l : Branch) -> Branch {
    return Branch { simd.neg(l._p1) }
}

@private
neg_ass_branch :: #force_inline proc "contextless" (l : ^Branch) {
    l._p1 = simd.neg(l._p1)
}

@private
add_branch :: #force_inline proc "contextless" (a, b : Branch) -> Branch {
    return Branch { simd.add(a._p1, b._p1) }
}

@private
add_ass_branch :: #force_inline proc "contextless" (a : ^Branch, b : Branch) {
    a._p1 = simd.add(a._p1, b._p1)
}

@private
sub_branch :: #force_inline proc "contextless" (a, b : Branch) -> Branch {
    return Branch { simd.sub(a._p1, b._p1) }
}

@private
sub_ass_branch :: #force_inline proc "contextless" (a : ^Branch, b : Branch) {
    a._p1 = simd.sub(a._p1, b._p1)
}

@private
mul_branch :: #force_inline proc "contextless" (a : Branch, b : f32) -> Branch {
    return Branch { simd.mul(a._p1, (#simd[4]f32)(b)) }
}

@private
mul_ass_branch :: #force_inline proc "contextless" (a : ^Branch, b : f32) {
    a._p1 = simd.mul(a._p1, (#simd[4]f32)(b))
}

@private
div_branch :: #force_inline proc "contextless" (a : Branch, b : f32) -> Branch {
    return Branch { simd.mul(a._p1, detail.rcp_nr1((#simd[4]f32)(b))) }
}

@private
div_ass_branch :: #force_inline proc "contextless" (a : ^Branch, b : f32) {
    a._p1 = simd.mul(a._p1, detail.rcp_nr1((#simd[4]f32)(b)))
}
