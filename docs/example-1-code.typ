#import "/src/lib.typ": karnaugh-map

#karnaugh-map(
  vars: ($a$, $b$, $c$),
  (1, 0, 1, 0, 0, -1, 1, 0),
  // ⬑ truth table order
  implicants: (
    (a, b, c) => not a and not c,
    // ⬑ typst functions
    (a, b, c) => b and not c,
    // ⬑ borders don't overlap
  ),
)
