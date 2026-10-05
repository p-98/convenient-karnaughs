#{
  import "@preview/tidy:0.4.3"
  import "/src/lib.typ" as lib

  let default-style = tidy.styles.default
  let my-style = (
    ..dictionary(default-style),
    colors: (..default-style.colors, bool-like: default-style.colors.bool),
    show-outline: (module-doc, style-args: (:)) => {
      text("Functions", weight: "bold")
      default-style.show-outline(module-doc, style-args: style-args)

      text("Types", weight: "bold")
      list(link(<bool-like>)[bool-like])
    },
    show-parameter-block: (
      function-name: none,
      name,
      types,
      content,
      style-args,
      show-default: false,
      default: none,
    ) => context {
      let break-param-descriptions = (
        measure(content).height > page.height * 0.5
      )
      tidy.styles.default.show-parameter-block(
        function-name: function-name,
        name,
        types,
        content,
        (..style-args, break-param-descriptions: break-param-descriptions),
        show-default: show-default,
        default: default,
      )
    },
    show-function: (
      fn,
      style-args,
    ) => {
      if style-args.colors == auto { style-args.colors = colors }

      [
        #heading(
          "Function " + raw(fn.name),
          level: style-args.first-heading-level + 1,
        )
        #if style-args.enable-cross-references {
          label(style-args.label-prefix + fn.name + "()")
        }
      ]

      default-style.eval-docstring(fn.description, style-args)

      block(breakable: style-args.break-param-descriptions, {
        heading(
          default-style.get-local-name("parameters", style-args: style-args),
          level: style-args.first-heading-level + 2,
        )
        (style-args.style.show-parameter-list)(fn, style-args: style-args)
      })

      for (name, info) in fn.args {
        if style-args.omit-private-parameters and name.starts-with("_") {
          continue
        }
        let types = info.at("types", default: ())
        let description = info.at("description", default: "")
        if description == "" and style-args.omit-empty-param-descriptions {
          continue
        }
        (style-args.style.show-parameter-block)(
          name,
          types,
          default-style.eval-docstring(description, style-args),
          style-args,
          show-default: "default" in info,
          default: info.at("default", default: none),
          function-name: style-args.label-prefix + fn.name,
        )
      }
      v(4.8em, weak: true)
    },
    show-variable: (
      var,
      style-args,
    ) => {
      if style-args.colors == auto { style-args.colors = colors }
      let type = if "type" not in var { none } else {
        default-style.show-type(var.type, style-args: style-args)
      }

      stack(
        dir: ltr,
        spacing: 1.2em,
        if style-args.enable-cross-references [
          #heading(
            "Variable " + raw(var.name),
            level: style-args.first-heading-level + 1,
          )
          #label(style-args.label-prefix + var.name)
        ] else [
          #heading(
            "Variable " + raw(var.name),
            level: style-args.first-heading-level + 1,
          )
        ],
        type,
      )

      default-style.eval-docstring(var.description, style-args)
      v(4.8em, weak: true)
    },
  )

  let show-types = (..ts) => ts
    .pos()
    .map(my-style.show-type.with(style-args: my-style))
    .join([ #text("or", size: .6em) ])
  let first-heading-level = 1
  let show-parameter-sub-block(
    function-name: none,
    parameter-name: none,
    name,
    types,
    content,
  ) = block(breakable: false, inset: (left: 0.5em), {
    box[
      #heading(level: first-heading-level + 4, parameter-name + "." + name)
      #if function-name != none and parameter-name != none {
        label(function-name + "." + parameter-name + "." + name)
      }
    ]
    h(1.2em)
    show-types(..types)
    parbreak()
    content
  })

  show link: set text(maroon)
  [
    = #toml("/typst.toml").package.name

    This is the manual containing the full API documentation.
    But first a few examples to illustrate some common use cases.

    A karnaugh map for a truth table:
    #scale(include "./example-1.typ", 84%, reflow: true)

    A karnaugh map for a function and with different label styles:
    #scale(include "./example-2.typ", 84%, reflow: true)
  ]
  tidy.show-module(
    tidy.parse-module(
      read("/src/karnaugh-map.typ"),
      scope: (
        ..dictionary(lib),
        bool-like: link(<bool-like>, [boolean-like]),
        show-parameter-sub-block: show-parameter-sub-block,
        show-types: show-types,
      ),
    ),
    style: my-style,
    colors: ("bool-like": green),
    first-heading-level: first-heading-level,
    omit-private-definitions: true,
    omit-private-parameters: true,
    sort-functions: none,
  )

  [
    == Type `bool-like` <bool-like>
    A type representing a boolean or "don't care".
    Anywhere this type is required, one of the values ```typc true```, ```typc false```,
    ```typc none```, ```typc 1```, ```typc 0```, or ```typc -1``` is expected.

    The values ```typc true``` and ```typc false``` represent the respective
    boolean values while ```typc none``` represents a #box["don't care"]. For
    convenience, the integers ```typc 1```, ```typc 0```, and ```typc -1``` can
    be used, respectively.
  ]
}
