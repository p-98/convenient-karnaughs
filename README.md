# convenient-karnaughs

In contrast to many other packages, this package is not inspired by any LaTeX
package, but tries to take full advantage of typst to be

- **☀️ convenient**: different formats for function values (e.g. array in
  truth-table order) and implicants (e.g. typst functions)
- **🎛️ flexibel**: different label styles, unlimited number of variables
- **🔋 batteries included**: input validation and error messages, implicant
  borders don't overlap while visual impact is minimized.

This project was 100% written by humans.

## Usage

<!-- TODO: link -->

[The documentation can be found here.](https://www.github.com/p-98/convenient-karnaughs/releases)

<!-- The following examples illustrate common use cases.

A karnaugh map for a thruth table:

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

<!-- TODO: link -- >

![Karnaugh map showcase.](https://www.github.com/p-98/convenient-karnaughs)

Note how the borders of implicants will _never_ overlap.
(In fact, we even minimize the number of inset borders.)

A karnaugh map for a function and with different label styles: -->
