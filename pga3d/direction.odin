package pga3d

import "core:simd"
import "../detail"

Direction :: struct {
    _p3 : #simd[4]f32,
}

direction :: #force_inline proc "contextless" (x, y, z : f32) -> Direction {
    return Direction{#simd[4]f32{0, x, y, z}}
}

@private
x_direction :: #force_inline proc "contextless" (dir : Direction) -> f32 {
    return simd.extract(dir._p3, 1)
}

@private
y_direction :: #force_inline proc "contextless" (dir : Direction) -> f32 {
    return simd.extract(dir._p3, 2)
}

@private
z_direction :: #force_inline proc "contextless" (dir : Direction) -> f32 {
    return simd.extract(dir._p3, 3)
}

@private
normalize_direction :: #force_inline proc "contextless" (dir : ^Direction) {
    tmp := detail.rsqrt_nr1(detail.hi_dp_bc(dir._p3, dir._p3))
    dir._p3 = simd.mul(dir._p3, tmp)
}

@private
normalized_direction :: #force_inline proc "contextless" (dir : Direction) -> Direction {
    tmp := detail.rsqrt_nr1(detail.hi_dp_bc(dir._p3, dir._p3))
    return Direction { simd.mul(dir._p3, tmp) }
}

@private
neg_direction :: #force_inline proc "contextless" (dir : Direction) -> Direction {
    return Direction { simd.neg(dir._p3) }
}

@private
neg_ass_direction :: #force_inline proc "contextless" (dir : ^Direction) {
    dir._p3 = simd.neg(dir._p3)
}

@private
add_direction :: #force_inline proc "contextless" (a, b : Direction) -> Direction {
    return Direction { simd.add(a._p3, b._p3) }
}

@private
add_ass_direction :: #force_inline proc "contextless" (a : ^Direction, b : Direction) {
    a._p3 = simd.add(a._p3, b._p3)
}

@private
sub_direction :: #force_inline proc "contextless" (a, b : Direction) -> Direction {
    return Direction { simd.sub(a._p3, b._p3) }
}

@private
sub_ass_direction :: #force_inline proc "contextless" (a : ^Direction, b : Direction) {
    a._p3 = simd.sub(a._p3, b._p3)
}

@private
mul_direction :: #force_inline proc "contextless" (a : Direction, b : f32) -> Direction {
    return Direction { simd.mul(a._p3, (#simd[4]f32)(b)) }
}

@private
mul_ass_direction :: #force_inline proc "contextless" (a : ^Direction, b : f32) {
    a._p3 = simd.mul(a._p3, (#simd[4]f32)(b))
}

@private
div_direction :: #force_inline proc "contextless" (a : Direction, b : f32) -> Direction {
    return Direction { simd.mul(a._p3, detail.rcp_nr1((#simd[4]f32)(b))) }
}

@private
div_ass_direction :: #force_inline proc "contextless" (a : ^Direction, b : f32) {
    a._p3 = simd.mul(a._p3, detail.rcp_nr1((#simd[4]f32)(b)))
}
