/* This file contains definitions that are not used in this project anymore,
 * but are too useful to just throw them awayy.
 */

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
  let pos = vs.pos().map(_to-string)
  let named = vs.named().pairs().map(((k, v)) => k + ": " + _to-string(v))
  return (..pos, ..named).join(", ")
}

#let to-int(v) = if type(v) == bool {
  if v { 1 } else { 0 }
}

#let to-content(..vs) = vs.pos().map(v => [#v]).join()
