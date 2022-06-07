package pga3d

Dual :: struct {
    scalar, e0123 : f32,
}

@private
neg_dual :: #force_inline proc "contextless" (a : Dual) -> Dual {
    return Dual {
        -a.scalar,
        -a.e0123,
    }
}

@private
neg_ass_dual :: #force_inline proc "contextless" (a : ^Dual) {
    a.scalar = -a.scalar
    a.e0123  = -a.e0123
}

@private
add_dual :: #force_inline proc "contextless" (a, b : Dual) -> Dual {
    return Dual {
        a.scalar + b.scalar,
        a.e0123  + b.e0123,
    }
}

@private
add_ass_dual :: #force_inline proc "contextless" (a : ^Dual, b : Dual) {
    a.scalar += b.scalar
    a.e0123  += b.e0123
}

@private
sub_dual :: #force_inline proc "contextless" (a, b : Dual) -> Dual {
    return Dual {
        a.scalar - b.scalar,
        a.e0123  - b.e0123,
    }
}

@private
sub_ass_dual :: #force_inline proc "contextless" (a : ^Dual, b : Dual) {
    a.scalar -= b.scalar
    a.e0123  -= b.e0123
}

@private
mul_dual :: #force_inline proc "contextless" (a : Dual, b : f32) -> Dual {
    return Dual {
        a.scalar * b,
        a.e0123  * b,
    }
}

@private
mul_ass_dual :: #force_inline proc "contextless" (a : ^Dual, b : f32) {
    a.scalar *= b
    a.e0123  *= b
}

@private
div_dual :: #force_inline proc "contextless" (a : Dual, b : f32) -> Dual {
    return Dual {
        a.scalar / b,
        a.e0123  / b,
    }
}

@private
div_ass_dual :: #force_inline proc "contextless" (a : ^Dual, b : f32) {
    a.scalar /= b
    a.e0123  /= b
}
