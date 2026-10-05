#import "./util.typ": example

#let placeholder = {
  show table.cell.where(x: 3): math.bold
  table(
    columns: 4,
    $0$, $0$, $0$, $0$,
  )
}
#example(
  context block(
    width: measure(placeholder).width,
    $ f(x_1, x_2) \ = \ x_1 ∧ x_2 $,
  ),
  "./example-2-code.typ",
)
