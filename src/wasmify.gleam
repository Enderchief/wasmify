import wasmify/types
@target(javascript)
import gleam/javascript/promise.{Promise}

/// Asynchronous load *.wasm as a Uint8Array/Buffer
/// Error can occur if the file does not exist. Should work in all JavaScript runtimes
@external(javascript, "./ffi_wasm.mjs", "load_wasm")
pub fn load_wasm(path: String) -> Result(Promise(types.Uint8Array), String)

/// Syncronously load *.wasm as a Uint8Array/Buffer
/// Error can occur if the file does not exist. Only works in Deno, NodeJS (commonjs), and Bun. 
@external(javascript, "./ffi_wasm.mjs", "load_wasm_sync")
pub fn load_wasm_sync(path: String) -> Result(types.Uint8Array, String)

/// Create a WebAssembly Module
@external(javascript, "./ffi_wasm.mjs", "module")
pub fn module(content: types.Uint8Array) -> types.WebAssemblyModule

/// Create an Instance and supply imports to be acessed in WebAssembly
@external(javascript, "./ffi_wasm.mjs", "instance")
pub fn instance(
  module: types.WebAssemblyModule,
  imports: List(types.Imports),
) -> types.WebAssemblyInstance

/// Converts a function to be accessable in WASM
@external(javascript, "../gleam_stdlib/gleam_stdlib.mjs", "identity")
pub fn function(v: a) -> types.Imports

/// Get a exported function (if it exists)
@external(javascript, "./ffi_wasm.mjs", "get_func")
pub fn get(
  instance: types.WebAssemblyInstance,
  name: String,
) -> Result(func, Nil)

@external(javascript, "./ffi_wasm.mjs", "namespace")
pub fn namespace(
  name: String,
  o: List(#(String, types.Imports)),
) -> types.Imports
