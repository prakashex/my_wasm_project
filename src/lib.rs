use wasm_bindgen::prelude::*;

// test change
// another test change
// This is the main entry point to the WASM module
#[wasm_bindgen]
pub fn greet() -> String {
    "Hello, world!".to_string()
}
