import wasmify/types.{Get}
import wasmify.{function, get, instance, load_wasm, module, namespace}
import gleam/javascript/promise
import gleam/io
import gleam/int
import gleam/float

fn print_float(value: Float) -> Float {
  io.println("result is: " <> float.to_string(value))
  value
}

fn void(_: a) {
  Nil
}

pub fn main() {
  case load_wasm("./math.wasm") {
    Ok(file) -> void(promise.await(file, run))
    Error(err) -> io.println(err)
  }
  Nil
}

fn run(bytes) {
  let wasm =
    module(bytes)
    |> instance([namespace("gleam", [#("print", function(print_float))])])

  let assert Ok(add) = get(wasm, "add")

  let res = add(1, 2)
  io.println(int.to_string(res))

  let assert Ok(sub) = get(wasm, "sub")

  let res = sub(1, 2)
  io.println(int.to_string(res))

  let assert Ok(pythagorean): Get(fn(Float, Float) -> Float) =
    get(wasm, "pythagorean")

  case 5.0 == pythagorean(3.0, 4.0) {
    True -> io.print("all good")
    False -> panic
  }

  promise.resolve(Nil)
}
