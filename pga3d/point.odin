package pga3d

import "core:simd"
import "../detail"

Point :: struct {
    _p3 : #simd[4]f32,
}

point :: #force_inline proc "contextless" (x, y, z : f32) -> Point {
    return Point{#simd[4]f32{1, x, y, z}}
}

@private
normalize_point :: #force_inline proc "contextless" (p : ^Point) {
    tmp := detail.rcp_nr1(simd.swizzle(p._p3, 0, 0, 0, 0))
    p._p3 = simd.mul(p._p3, tmp)
}

@private
normalized_point :: #force_inline proc "contextless" (p : Point) -> Point {
    tmp := detail.rcp_nr1(simd.swizzle(p._p3, 0, 0, 0, 0))
    return Point { simd.mul(p._p3, tmp) }
}

@private
invert_point :: #force_inline proc "contextless" (p : ^Point) {
    tmp := detail.rcp_nr1(simd.swizzle(p._p3, 0, 0, 0, 0))
    p._p3 = simd.mul(p._p3, tmp)
    p._p3 = simd.mul(p._p3, tmp)
}

@private
inverted_point :: #force_inline proc "contextless" (p : Point) -> Point {
    tmp := detail.rcp_nr1(simd.swizzle(p._p3, 0, 0, 0, 0))
    return Point { simd.mul(simd.mul(p._p3, tmp), tmp) }
}

@private
x_point :: #force_inline proc "contextless" (p : Point) -> f32 {
    return simd.extract(p._p3, 1)
}

@private
y_point :: #force_inline proc "contextless" (p : Point) -> f32 {
    return simd.extract(p._p3, 2)
}

@private
z_point :: #force_inline proc "contextless" (p : Point) -> f32 {
    return simd.extract(p._p3, 3)
}

@private
w_point :: #force_inline proc "contextless" (p : Point) -> f32 {
    return simd.extract(p._p3, 0)
}

@private
reverse_point :: #force_inline proc "contextless" (p : ^Point) {
    p._p3 = simd.neg(p._p3)
}

@private
reversed_point :: #force_inline proc "contextless" (p : Point) -> Point {
    return Point { simd.neg(p._p3) }
}

// NOTE: Leaves homogeneous coordinate untouched!
//
// This isn't the correct maths, but the original Klein library did this too
@private
neg_point :: #force_inline proc "contextless" (p : Point) -> Point {
    // flip sign bits of floats
    return Point {
        transmute(#simd[4]f32) simd.xor(
            transmute(#simd[4]u32) p._p3,
            #simd[4]u32{ 0, 1 << 31, 1 << 31, 1 << 31 },
        ),
    }
}

// NOTE: Leaves homogeneous coordinate untouched!
//
// This isn't the correct maths, but the original Klein library did this too
@private
neg_ass_point :: #force_inline proc "contextless" (p : ^Point) {
    // flip sign bits of floats
    p._p3 = transmute(#simd[4]f32) simd.xor(
        transmute(#simd[4]u32) p._p3,
        #simd[4]u32{ 0, 1 << 31, 1 << 31, 1 << 31 },
    )
}

@private
add_point :: #force_inline proc "contextless" (a, b : Point) -> Point {
    return Point { simd.add(a._p3, b._p3) }
}

@private
add_ass_point :: #force_inline proc "contextless" (a : ^Point, b : Point) {
    a._p3 = simd.add(a._p3, b._p3)
}

@private
sub_point :: #force_inline proc "contextless" (a, b : Point) -> Point {
    return Point { simd.sub(a._p3, b._p3) }
}

@private
sub_ass_point :: #force_inline proc "contextless" (a : ^Point, b : Point) {
    a._p3 = simd.sub(a._p3, b._p3)
}

@private
mul_point :: #force_inline proc "contextless" (a : Point, b : f32) -> Point {
    return Point { simd.mul(a._p3, (#simd[4]f32)(b)) }
}

@private
mul_ass_point :: #force_inline proc "contextless" (a : ^Point, b : f32) {
    a._p3 = simd.mul(a._p3, (#simd[4]f32)(b))
}

@private
div_point :: #force_inline proc "contextless" (a : Point, b : f32) -> Point {
    return Point { simd.mul(a._p3, detail.rcp_nr1((#simd[4]f32)(b))) }
}

@private
div_ass_point :: #force_inline proc "contextless" (a : ^Point, b : f32) {
    a._p3 = simd.mul(a._p3, detail.rcp_nr1((#simd[4]f32)(b)))
}
