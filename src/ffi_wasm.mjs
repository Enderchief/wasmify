import { Error, Ok } from "./gleam.mjs";

/**
 * this function is meant to work on any platform :3
 * @param {string} path
 */
export function load_wasm(path) {
  try {
    if (path.match(/http(s):\//) || typeof location !== "undefined") {
      return new Ok(fetch(path).then((v) => v.arrayBuffer()));
    } else if (typeof Deno === "object") return new Ok(Deno.readFile(path));
    else if (typeof process === "object" && typeof self === "undefined") {
      return new Ok(require("node:fs/promises").readFile(path));
    } else if (typeof process === "object" && typeof self === "object") {
      new Ok(import("node:fs/promises").then((v) => v.readFile(path)));
    } else {return new Error(
        "Invalid javascript runtime, please file an issue at https://github.com/endercheif/wasmify/issues",
      );}
  } catch (e) {
    return new Error(e.toString());
  }
}

export function load_wasm_sync(path) {
  try {
    if (typeof Deno === "object") return new Ok(Deno.readFileSync(path));
    else if (typeof process === "object" && (typeof self === "undefined")) {
      return new Ok(require("node:fs").readFileSync(path));
    } else return new Error("Only Deno and commonjs runtimes are supported");
  } catch (e) {
    return new Error(e.toString());
  }
}

export function module(content) {
  return new WebAssembly.Module(content);
}

export function instance(module, imports) {
  return new WebAssembly.Instance(module, imports);
}

/**
 * @param {WebAssembly.Instance} instance
 * @param {string} name
 * @param {*} _
 */
export function get_func(instance, name, _) {
  const fn = instance.exports[name];

  if (fn) return new Ok(fn);
  return new Error();
}
