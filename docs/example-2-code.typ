#import "/src/lib.typ": karnaugh-map

#karnaugh-map(
  3,
  (x2, x1, x0) => not x1 and x0,
  // ⬑ Typst functions
  implicants: (
    (-1, 0, 1),
    // ⬑ variable assignments
  ),
  style: (labels: "bitstring"),
)
