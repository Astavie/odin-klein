package pga3d

add :: proc {
    add_dual,
    add_ass_dual,
    add_direction,
    add_ass_direction,
    add_point,
    add_ass_point,
    add_ideal_line,
    add_ass_ideal_line,
    add_branch,
    add_ass_branch,
    add_line,
    add_ass_line,
}

sub :: proc {
    sub_dual,
    sub_ass_dual,
    sub_direction,
    sub_ass_direction,
    sub_point,
    sub_ass_point,
    sub_ideal_line,
    sub_ass_ideal_line,
    sub_branch,
    sub_ass_branch,
    sub_line,
    sub_ass_line,
}

mul :: proc {
    mul_dual,
    mul_ass_dual,
    mul_direction,
    mul_ass_direction,
    mul_point,
    mul_ass_point,
    mul_ideal_line,
    mul_ass_ideal_line,
    mul_branch,
    mul_ass_branch,
    mul_line,
    mul_ass_line,
}

div :: proc {
    div_dual,
    div_ass_dual,
    div_direction,
    div_ass_direction,
    div_point,
    div_ass_point,
    div_ideal_line,
    div_ass_ideal_line,
    div_branch,
    div_ass_branch,
    div_line,
    div_ass_line,
}

neg :: proc {
    neg_dual,
    neg_ass_dual,
    neg_direction,
    neg_ass_direction,
    neg_point,
    neg_ass_point,
    neg_ideal_line,
    neg_ass_ideal_line,
    neg_branch,
    neg_ass_branch,
    neg_line,
    neg_ass_line,
}

normalize :: proc {
    normalize_direction,
    normalized_direction,
    normalize_point,
    normalized_point,
    normalize_branch,
    normalized_branch,
    normalize_line,
    normalized_line,
}

invert :: proc {
    invert_point,
    inverted_point,
    invert_branch,
    inverted_branch,
    invert_line,
    inverted_line,
}

reverse :: proc {
    reverse_point,
    reversed_point,
    reverse_ideal_line,
    reversed_ideal_line,
    reverse_branch,
    reversed_branch,
    reverse_line,
    reversed_line,
}

squared_ideal_norm :: proc {
    squared_norm_ideal_line,
}

ideal_norm :: proc {
    norm_ideal_line,
}

squared_norm :: proc {
    squared_norm_branch,
    squared_norm_line,
}

norm :: proc {
    norm_branch,
    norm_line,
}

x :: proc {
    x_direction,
    x_point,
    x_branch,
}

y :: proc {
    y_direction,
    y_point,
    y_branch,
}

z :: proc {
    z_direction,
    z_point,
    z_branch,
}

w :: proc {
    w_point,
}
