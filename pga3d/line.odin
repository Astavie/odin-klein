package pga3d

import "core:math"
import "core:simd"
import "../detail"

Line :: struct {
    using branch : Branch,
    using ideal : Ideal_Line,
}

line :: proc {
    line_from_coords,
    line_from_ideal,
    line_from_branch,
}

@private
line_from_coords :: #force_inline proc "contextless" (a, b, c, d, e, f : f32) -> Line {
    return Line {
        branch(d, e, f),
        ideal_line(a, b, c),
    }
}

@private
line_from_ideal :: #force_inline proc "contextless" (l : Ideal_Line) -> Line {
    return Line {
        branch(0, 0, 0),
        l,
    }
}

@private
line_from_branch :: #force_inline proc "contextless" (l : Branch) -> Line {
    return Line {
        l,
        ideal_line(0, 0, 0),
    }
}

@private
squared_norm_line :: #force_inline proc "contextless" (l : Line) -> f32 {
    return squared_norm_branch(l.branch)
}

@private
norm_line :: #force_inline proc "contextless" (l : Line) -> f32 {
    return math.sqrt(squared_norm_line(l))
}

@private
normalize_line :: #force_inline proc "contextless" (l : ^Line) {
    b2 := detail.hi_dp_bc(l._p1, l._p1)
    s  := detail.rsqrt_nr1(b2)
    bc := detail.hi_dp_bc(l._p1, l._p2)
    t  := simd.mul(simd.mul(bc, detail.rcp_nr1(b2)), s)

    tmp  := simd.mul(l._p2, s)
    l._p2 = simd.sub(tmp, simd.mul(l._p1, t))
    l._p1 = simd.mul(l._p1, s)
}

@private
normalized_line :: #force_inline proc "contextless" (l : Line) -> Line {
    out := l
    normalize_line(&out)
    return out
}


@private
invert_line :: #force_inline proc "contextless" (l : ^Line) {
    b2     := detail.hi_dp_bc(l._p1, l._p1)
    s      := detail.rsqrt_nr1(b2)
    bc     := detail.hi_dp_bc(l._p1, l._p2)
    b2_inv := detail.rcp_nr1(b2)
    t      := simd.mul(simd.mul(bc, b2_inv), s)

    st   := simd.mul(s, t)
    st    = simd.mul(l._p1, st)
    l._p2 = simd.sub(simd.mul(l._p2, b2_inv), simd.add(st, st))
    l._p1 = simd.mul(l._p1, b2_inv)

    reverse_line(l)
}

@private
inverted_line :: #force_inline proc "contextless" (l : Line) -> Line {
    out := l
    invert_line(&out)
    return out
}

@private
reverse_line :: #force_inline proc "contextless" (l : ^Line) {
    reverse_branch(&l.branch)
    reverse_ideal_line(&l.ideal)
}

@private
reversed_line :: #force_inline proc "contextless" (l : Line) -> Line {
    return Line {
        reversed_branch(l.branch),
        reversed_ideal_line(l.ideal),
    }
}

@private
neg_line :: #force_inline proc "contextless" (l : Line) -> Line {
    return Line {
        neg_branch(l.branch),
        neg_ideal_line(l.ideal),
    }
}

@private
neg_ass_line :: #force_inline proc "contextless" (l : ^Line) {
    neg_ass_branch(&l.branch)
    neg_ass_ideal_line(&l.ideal)
}

@private
add_line :: #force_inline proc "contextless" (a, b : Line) -> Line {
    return Line {
        add_branch(a.branch, b.branch),
        add_ideal_line(a.ideal, b.ideal),
    }
}

@private
add_ass_line :: #force_inline proc "contextless" (a : ^Line, b : Line) {
    add_ass_branch(&a.branch, b.branch)
    add_ass_ideal_line(&a.ideal, b.ideal)
}

@private
sub_line :: #force_inline proc "contextless" (a, b : Line) -> Line {
    return Line {
        sub_branch(a.branch, b.branch),
        sub_ideal_line(a.ideal, b.ideal),
    }
}

@private
sub_ass_line :: #force_inline proc "contextless" (a : ^Line, b : Line) {
    sub_ass_branch(&a.branch, b.branch)
    sub_ass_ideal_line(&a.ideal, b.ideal)
}

@private
mul_line :: #force_inline proc "contextless" (a : Line, b : f32) -> Line {
    f := (#simd[4]f32)(b)
    return Line {
        Branch     { simd.mul(a._p1, f) },
        Ideal_Line { simd.mul(a._p2, f) },
    }
}

@private
mul_ass_line :: #force_inline proc "contextless" (a : ^Line, b : f32) {
    f := (#simd[4]f32)(b)
    a._p1 = simd.mul(a._p1, f)
    a._p2 = simd.mul(a._p2, f)
}

@private
div_line :: #force_inline proc "contextless" (a : Line, b : f32) -> Line {
    f := detail.rcp_nr1((#simd[4]f32)(b))
    return Line {
        Branch     { simd.mul(a._p1, f) },
        Ideal_Line { simd.mul(a._p2, f) },
    }
}

@private
div_ass_line :: #force_inline proc "contextless" (a : ^Line, b : f32) {
    f := detail.rcp_nr1((#simd[4]f32)(b))
    a._p1 = simd.mul(a._p1, f)
    a._p2 = simd.mul(a._p2, f)
}
