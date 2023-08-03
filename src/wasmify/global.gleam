import wasmify/types.{Global}

@external(javascript, "../ffi_wasm.mjs", "global_i32")
pub fn i32(value: Int, mutable: Bool) -> Global

@external(javascript, "../ffi_wasm.mjs", "global_i64")
pub fn i64(value: Int, mutable: Bool) -> Global

@external(javascript, "../ffi_wasm.mjs", "global_f32")
pub fn f32(value: Float, mutable: Bool) -> Global

@external(javascript, "../ffi_wasm.mjs", "global_f64")
pub fn f64(value: Float, mutable: Bool) -> Global

@external(javascript, "../ffi_wasm.mjs", "global_v128")
pub fn v128(value: a, mutable: Bool) -> Global
