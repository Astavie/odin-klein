package test

import kln "../pga3d"
import "../detail"

import "core:fmt"
import "core:simd"

main :: proc() {
    dual := kln.Dual{1, 2}
    kln.add(&dual, dual)
    fmt.println(dual)

    dir := kln.direction(2, 4, 5)

    fmt.println(kln.x(dir))
    fmt.println(kln.y(dir))
    fmt.println(kln.z(dir))

    kln.add(&dir, kln.direction(-3, 9, 2))
    fmt.println(dir)

    kln.neg(&dir)
    fmt.println(dir)

    norm := kln.normalize(dir)
    fmt.println(norm)

    // Point with '2' as homogeonous coordinate
    p := kln.Point { #simd[4]f32 { 2, 1, 2, 3 } }
    fmt.println(p)
    fmt.println(kln.normalize(p))
    fmt.println(kln.invert(p))
    fmt.println(kln.neg(p))
    fmt.println(kln.reverse(p))

    il := kln.ideal_line(1, 1, 1)
    fmt.println(il)
    fmt.println(kln.ideal_norm(il))

    b := kln.branch(1, 1, 1)
    fmt.println(b)
    fmt.println(kln.norm(b))
    fmt.println(kln.normalize(b))
    fmt.println(kln.invert(b))

    l := kln.Line { b, il }
    fmt.println(l)
    fmt.println(kln.norm(l))
    fmt.println(kln.normalize(l))
    fmt.println(kln.invert(l))
    fmt.println(kln.invert(kln.invert(l)))
    fmt.println(kln.neg(l))
    fmt.println(kln.reverse(l))
    fmt.println(kln.div(l, 3))

    num := (#simd[4]f32)(2.89)
    fmt.printf("%.27f\n", simd.recip(simd.sqrt(num)))
    fmt.printf("%.27f\n", detail.rsqrt_nr1(num))
}
