#import "./util.typ": example

#example(
  {
    show table.cell.where(x: 3): math.bold
    table(
      columns: 4,
      stroke: none,
      align: center,
      table.header($a$, $b$, $c$, table.vline(), $f$),
      table.hline(),
      $0$, $0$, $0$, $1$,
      $0$, $0$, $1$, $0$,
      $0$, $1$, $0$, $1$,
      $0$, $1$, $1$, $0$,
      $1$, $0$, $0$, $0$,
      $1$, $0$, $1$, $*$,
      $1$, $1$, $0$, $1$,
      $1$, $1$, $1$, $0$,
    )
  },
  "./example-1-code.typ",
)
