# convenient-karnaughs

In contrast to many other packages, this package is not inspired by any LaTeX
package, but tries to take full advantage of typst to be

- **⚡ powerfull**: unlimited number of variables
- **☀️ convenient**: draw implicants with typst functions, borders will never
  overlap
- **🎛️ configurable**: set label styles, colors and variables names
- **ℹ debuggable**: proper input validation and error messages

## Usage

<!-- TODO: link -->

[The full documentation can be found here.](https://www.github.com/p-98/convenient-karnaughs)

Here is a simple example for a common use case.
For the following truth table:

| a   | b   | c   |     |  f(a, b, c) |
| --- | --- | --- | --- | ----------- |
| 0   | 0   | 0   |     | 1           |
| 0   | 0   | 1   |     | 0           |
| 0   | 1   | 0   |     | 1           |
| 0   | 1   | 1   |     | 0           |
| 1   | 0   | 0   |     | 0           |
| 1   | 0   | 1   |     | 0           |
| 1   | 1   | 0   |     | 1           |
| 1   | 1   | 1   |     | 0           |

You can write the following code, where the order of the function values
directly corresponds to the truth table and the implicants are just typst
functions:

```typ
#import "@preview/convenient-karnaughs:1.0.0": karnaugh-map
#karnaugh-map(
  (1, 0, 1, 0, 0, 0, 1, 0),
  vars: ($a$, $b$, $c$),
  implicants: (
    (a, b, c) => not a and not c, // blue
    (a, b, c) => b and not c,     // red
  ),
)
```

Which results in:

<!-- TODO: link -->

![Karnaugh map showcase.](https://www.github.com/p-98/convenient-karnaughs)

Note how the borders of implicants will _never_ overlap.
(In fact, we even minimize the number of inset borders.)
