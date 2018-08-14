# vimHttppie
es un plugin para vim que trabaja con **Httpie** y asi dar un preview de la la request rest en vim.

<br>

### Pre requisitos:
---
- Se debe tener instalado ***Httpie***.

<br>


### Variables:
---
. g:vimHttppieBrowser :
    esta varaible indica que navegador sera abierto al detectar que el archivo es de tipo
    html, esto hara que se abra el navegador con la informacion de dicho html,
    se puede configurar para que no sea asi y salga de manera normal por el buffer.

. g:vim_httppie_base :
    variable que evita escribir la url base del miso servidor en varias ocaciones puede ser
    modificada desde dentro de vim

<br>

### Ejemplo de uso:
---
- :Httpie GET base /api/sample
-  :Httpie POST http://localhost:8080/api/sample
-  :Httpie POST base /api/user/login email='email@gmail.com' password='123'

<br>


### Funciones:
---

- :call HttpieChangeBase("new base") cambia el url base dentro de vim

- :call HttpieGetBase()   obtiene la url base actual

<br>

### Opciones

- -b :
  descarga la respuesta y lo carga en el navegador
- -h -H --HEADER  -b -B --BODY:
  filtra la respuesta a solo el header o el body dependiendo del caso

<br>
### Licencia:

    One line to give the program's name and a brief description.
    Copyright © 2018 leonelsoriano3@gmail.com
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.
    
    You should have received a copy of the GNU General Public License
    along with this program; if not, see <http://www.gnu.org/licenses/>.
    
<br><br>
