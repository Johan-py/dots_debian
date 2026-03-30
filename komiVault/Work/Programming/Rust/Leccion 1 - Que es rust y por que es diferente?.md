
Rust existe para resolver este triangulo imposible: Velocidad, Seguridad y Concurrencia.

Logra esto sin garbage collector(recolector de basura), usando un sistema de reglas en tiempo de compilacion llamado:
* Ownership + Borrowing + Lifetimes

Eso significa:
- No segmentacion faults
- No data races
- No null pointer exeptions
- Sin garbage collector
Todo verificado en compilacion, no en runtime.

## Como funciona un proyecto Rust
```Rust
leccion_1/
|---Cargo.toml    <- Config del proyecto
|---src/
	|---main.rs   <- punto de entrada
```


### Cargo es:
- gestor de paquetes
- compilador
- test runner
- benchmark tool


Rust es fuertemente tipado y estatico
```Rust
let x = "hola"; //&str

```

