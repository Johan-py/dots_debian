## 1. Inmutavilidad por defecto:

En rust , todo es inmutable por defecto:
```rust
let x = 10;
x = 20 //x error 
```

Para modificar:
```rust
let mut x = 10;
x = 20 //done
```
Esto evita efectos colaterales y bugs


## 2. Shadowing(redefinicion segura)
```rust
let x = 5;
let x = x+1; // nuevo x
let x = x*2; //nuevo x

println!("{}",x) // 12

```
No es mutacion: es una nueva variable.

## 3. Tipos explicitos

```rust
let edad: u8 = 20 // enteros
let promedio: f32 = 3.34 //flotantes
let activo: bool = true //booleanos
```

## 4. Control de flujo
if como expresion:
```rust
let n = 10;
let par = if n % 2 == 0 {"par"} else {"impar};
```

loop
```rust
let mut i = 0;
loop {
	if i == 3 {breack;}
	println!("{}",i);
	i+=1;
}
```

while
```rust
let mut i = 0;
while i < 3 {
	println!("{}",i);
	i+=1;
	}
```

for
```rust
for i in 0..5{
	println!("{}",i)
}
```