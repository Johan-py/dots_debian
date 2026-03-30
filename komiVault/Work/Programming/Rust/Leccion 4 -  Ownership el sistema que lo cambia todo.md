## Regla 1 
	- cada valor en Rust tiene un solo dueno.
##  En el ejemplo se transfiere la propiedad de s1 a s2 
	
```rust
let s1 = String::from("hola");
let s2 = s1; //ownership se mueve

println!("{}", s1); //ERROR
```


## Regla 2
- Cuando el dueño sale de scope, se libera la memoria.


## Regla 3
- Solo puede haber un dueno mutable o muchos inmutables
## En este caso no se transfiere si no que se presta 
```rust
let s1 = String::from("hola");
let s2 = &s1;  // 📚 te PRESTO el valor para LEER
println!("{}", s1); // ✅ s1 SIGUE siendo dueño
println!("{}", s2); // ✅ s2 puede leer
```


## Ejemplo critico
```rust
fn main(){
	let s = String::from("Rust");
	consumir(s);
	println!("{}", s); // es dueno
}
fn consumir(texto: String){
	println!("{}",texto);
}
```




# 🦀 ¿Qué pasa con el dueño cuando se transfiere el ownership?

Cuando transfieres la propiedad (**move**):

> 🔥 El dueño original queda **invalidado**  
> 🔥 El nuevo dueño es el único válido  
> 🔥 La memoria NO se copia (salvo tipos `Copy`)

---

## 🔬 Ejemplo canónico

fn main() {  
    let a = String::from("Hola");  
    let b = a; // move  
  
    println!("{}", a); // ❌ ERROR  
    println!("{}", b); // ✔️ OK  
}

### Qué ocurre internamente

Antes del move:

a ──► "Hola" (heap)

Después del move:

a  (INVALIDADO)  
b ──► "Hola" (heap)

**Importante:** la memoria en heap no se duplica.

---

## 🎯 Regla formal

Cuando haces:

let b = a;

y el tipo **NO implementa `Copy`**:

- se mueve el ownership
    
- el binding original queda inutilizable
    
- el compilador marca uso posterior como error
    

---

## 🧠 ¿Por qué Rust hace esto?

Para garantizar:

- ❌ no double free
    
- ❌ no use-after-free
    
- ❌ no data races
    
- ✅ memoria segura sin GC
    

Si `a` siguiera siendo válido, ambos intentarían liberar la misma memoria al salir del scope.

---

## 🔥 Cuándo NO se invalida (tipos Copy)

Tipos simples implementan `Copy`:

fn main() {  
    let x = 5;  
    let y = x;  
  
    println!("{}", x); // ✔️ válido  
    println!("{}", y); // ✔️ válido  
}

Aquí ocurre **copia bit a bit**, no move.

---

### Tipos `Copy` comunes

- enteros (`i32`, `u64`, etc.)
    
- `bool`
    
- `char`
    
- tuplas de tipos Copy
    

❌ `String` NO es Copy  
❌ `Vec` NO es Copy  
❌ `Box` NO es Copy