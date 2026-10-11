#import "/src/lib.typ": karnaugh-map

#karnaugh-map(
  ($a$, $b$, $c$),
  (1, 0, 1, 0, 0, -1, 1, 0),
  // ⬑ truth table order
  implicants: (
    (a, b, c) => not a and not c,
    // ⬑ Typst functions
    (a, b, c) => b and not c,
    // ⬑ borders don't overlap
  ),
)
