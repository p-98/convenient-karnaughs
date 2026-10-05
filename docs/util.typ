#import "/src/lib.typ" as lib

#let manifest = toml("/typst.toml")

#let local-import = "#import \"/src/lib.typ\": karnaugh-map"
#let universe-import = (
  "#import \"@preview/"
    + manifest.package.name
    + ":"
    + manifest.package.version
    + "\": karnaugh-map"
)

#let show-raw-block = block.with(
  fill: silver.lighten(70%),
  inset: 0.75em,
  radius: 0.5em,
)

#let example(function, path) = grid(
  columns: 3,
  gutter: 1.5em,
  align: center + horizon,
  function,
  show-raw-block(raw(
    read(path).replace(local-import, universe-import),
    block: true,
    lang: "typ",
  )),
  include path,
)

#let example-page = page.with(
  width: auto,
  height: auto,
  margin: 1pt, // prevent table borders to be cut
)
