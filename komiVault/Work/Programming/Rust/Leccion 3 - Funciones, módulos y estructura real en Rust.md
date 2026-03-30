esta  leccion ensena como organizar codigo profeccional en rust, no scripts

## 1. Funciones:

```rust
fn suma(a: i32, b: i32) -> i32 {
	a + b
}
```
En Rust: 
- el ultimo valor se retorna sin return
- con ; se convierte en statement(al usar ; el compilador interpreta que la funcion no devuelve nada pero si no la lleva lo interpreta como un return)

```rust
fn saludo(nombre: &str){ 
		println!("hola {}",nombre);
}
```


## 2. Modulos
Estructura:
```rust
src/
|---main.rs
|---math.rs
```

### math.rs
```rust
pub fn doble(x: i32) -> i32 {

x*2

}
```
El (pub) lo hace visible fuera del modulo


### main.rs
```rust
mod math;

fn main() {
    let r = math::doble(5); // el :: funciona como el namespace mejor dicho como el punto para acceder a la funcion
    println!("{}", r);
}
```


## 3. Submodulos
```rust
src/
|---utils/
	  |---mod.rs
	  |---io.rs
```

### utils/mod.rs
```rust
pub mod io;
```
### utils/io.rs
```rust
pub fn imprimir(msg: &str) {
	println!("{msg}", msg);
}
```


## 4. Importar con use
```rust
use crate::utils::io::imprimir;
```

