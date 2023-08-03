# wasmify

[![Package Version](https://img.shields.io/hexpm/v/wasmify)](https://hex.pm/packages/wasmify)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/wasmify/)

Use WASM in Gleam !

## Usage
(see [`/example/src/example.gleam`](https://github.com/endercheif/wasmify/blob/master/example/src/example.gleam) for a demo)

decompiled `math.wasm`
```wasm
(module
  (import "gleam" "print" (func $print (param f32) (result f32)))
  (func (export "pythagorean") (param f32 f32) (result f32)
    (local $x f32)
    (local $y f32)

    local.get 0
    local.get 0
    f32.mul
    local.set $x

    local.get 1
    local.get 1
    f32.mul
    local.set $y

    local.get $x
    local.get $y
   	
    f32.add
	f32.sqrt

    call $print
  )
)

```

`mod.gleam`
```gleam
import gleam/float
import wasmify/types.{Get}
import wasmify/wasm.{function, get, instance, load_wasm, load_wasm_sync, module, namespace} // load_wasm_sync only works in non browser runtimes and returns Result(Promise(file), String)

fn print_float(value: Float) -> Float {
  io.println("result is: " <> float.to_string(value))
  value
}

pub fn main() {
    let assert Ok(file) = load_wasm_sync
    let wasm = module(file) |> instance([namespace("gleam", [#("print", function(print_int))])])

    let assert Ok(pythagorean): Get(fn (Float, Float) -> Float) = get(wasm, "pythagorean")

    let res = pythagorean(3.0, 4.0)

    case 5.0 == pythagorean(3.0, 4.0) {
        True -> io.print("all good!")
        False -> panic
    }
}

```

## Installation

This package can be added to your Gleam project:

```sh
gleam add wasmify
```

and its documentation can be found at <https://hexdocs.pm/wasmify>.
