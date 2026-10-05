#import "/src/lib.typ": karnaugh-map

#karnaugh-map(
  vars: 3,
  (x2, x1, x0) => not x1 and x0,
  implicants: (
    (-1, 0, 1),
  ),
  style: (labels: "bitstring"),
)
