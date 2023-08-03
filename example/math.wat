(module
  (import "gleam" "print" (func $print (param f32) (result f32)))
  (func (export "add") (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.add)
  (func (export "sub") (param i32 i32) (result i32)
    local.get 0
    local.get 1
    i32.sub)
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
