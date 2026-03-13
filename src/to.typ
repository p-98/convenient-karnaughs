#import "src/util.typ": is-int, max-by, partition

#let to-bool(v) = if (type(v) == int) {
  if v == 0 { false } else { true }
} else {
  panic("Cannot convert to bool.")
}

#let to-int(v) = if type(v) == bool {
  if v { 1 } else { 0 }
}

#let _to-string(v) = if type(v) == array {
  let elements = v.map(_to-string)
  "(" + elements.join(", ") + if elements.len() == 1 { "," } + ")"
} else if type(v) == dictionary {
  let elements = v.pairs().map(((k, v)) => "" + k + ": " + _to-string(v))
  "(" + elements.join(", ") + if elements.len() == 0 { ":" } + ")"
} else if type(v) == int {
  str(v)
} else if type(v) == bool {
  if v { "true" } else { "false" }
} else if type(v) == str {
  "\"" + v + "\""
} else if type(v) == float {
  str(v)
} else if type(v) == type {
  str(v)
} else if type(v) == type(none) {
  "none"
} else if type(v) == length {
  str(v.em) + "em"
} else {
  panic("Cannot convert values of type " + str(type(v)) + " to string.")
}
#let to-string(..vs) = {
  let pos = vs.pos().map(_to-string).join(", ")
  let named = vs
    .named()
    .pairs()
    .map(((k, v)) => k + ": " + _to-string(v))
    .join(", ")

  pos + if vs.pos().len() > 0 and vs.named().len() > 0 { ", " } + named
}

#let to-content(..vs) = vs.pos().map(v => [#v]).join()

/// Convert dictionaries to arguments. Main use case is dynamic argument names.
///
/// Numeric keys are treated as positional arguments.
#let to-arguments(v) = if type(v) == dictionary {
  let (pos, named) = partition(v.pairs(), f: ((k, _)) => is-int(k))
  let pos-sorted = pos.map(((k, v)) => (int(k), v)).sorted(key: ((k, _)) => k)
  assert(
    pos-sorted.map(((k, _)) => k) == range(pos-sorted.len()),
    message: "All numeric keys between 0 and the maximum key must be present.",
  )
  arguments(..pos-sorted.map(((_, v)) => v), ..named.to-dict())
} else {
  panic("Cannot convert values of type " + str(type(v)) + " to arguments.")
}
