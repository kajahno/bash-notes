---
title: Introducción
weight: 10
disableToc: true
---

![logo de Bash](/bash-notes/en/basics/introduction/images/bash-logo-web.png)

[La GNU Bourne-Again SHell](https://www.gnu.org/software/bash/) es una shell muy pupular ya que combina funcionalidades tanto para uso interactive y programático.

### Otras shells
* [C shell - `csh`](https://en.wikipedia.org/wiki/C_shell)
* [KornShell - `ksh`](https://en.wikipedia.org/wiki/KornShell)
* [Bourne shell - `sh`](https://en.wikipedia.org/wiki/Bourne_shell)
* [Z shell - `zsh`](https://en.wikipedia.org/wiki/Z_shell) en combinación con [Oh-my-zsh](https://ohmyz.sh/)
* [Debian Almquist shell - `dash`](https://en.wikipedia.org/wiki/Almquist_shell)


## ¿Qué es una 'shell' entonces?
Es un programa el cual recibe como entrada lo que se escribe en el teclado, y redirecciona dicha entrada hacia el sistema operativo. Fue la primera clase de interfaces de usuario usada en sistemas operativos.

## ¿Qué es una 'terminal [emulador]'?
Hoy en día, gran mayoria de los sistemas operativos proveen una Interfaz Gráfica de Usuario (GUI). Un emulador de terminal es un programa que hace posible la interaccion con una shell. Ejemplos de emuladores de terminal incluyen: gnome-terminal, terminator.

## Iniciar bash

Asumiendo que estás en un sistema operativo que tiene una GUI, basta con abrir tu emulador de terminal favorito y escribit lo siguiente:
```bash
$ bash
```

Imprimir la versión de bash:
```bash
$ bash --version
GNU bash, version 4.3.48(1)-release (x86_64-pc-linux-gnu)
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>

This is free software; you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

## Modos de ejecución

En bash se puede ya se  escribir y ejecutar los comandos inmediatamente (modo interactivo), o incluir los comandos en un archivo de texto y ejecutarlos en modo batch (tambien conocido como bash script).


### Modo interactivo

Imprime el directorio actual:
```bash
$ pwd
/home/vagrant
```
Lista los archivos y directorios en el directorio actual:
```bash
$ ls
```

### Modo no-interactivo (bash script)

Crea un archivo de texto (llamado `myfile`) y escribe el siguiente contenido dentro:
```
pwd
ls
```

Ejecuta el fichero con la lista de comandos usando bash
```bash
$ bash myfile 
/home/vagrant
myfile
```

![Magic](/bash-notes/en/basics/introduction/images/magic.gif?classes=shadow)
