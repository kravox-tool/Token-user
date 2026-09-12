# Guía de Contribución

¡Gracias por tu interés en contribuir a IP-Tool! 🎉

## Cómo puedo contribuir

### Reportar Bugs 🐛

Antes de reportar un bug, verifica si ya existe un issue abierto sobre el mismo.

Cuando reportes un bug, incluye:

- **Descripción clara**: ¿Qué esperabas que sucediera y qué sucedió?
- **Pasos para reproducir**: Pasos específicos para reproducir el problema
- **Ejemplos específicos**: Proporciona ejemplos concretos
- **Versión**: ¿Qué versión de IP-Tool usas?
- **Sistema operativo**: Termux, Linux, etc.
- **Logs o capturas de pantalla**: Si es relevante

### Sugerir Mejoras 💡

Las sugerencias de mejora son bienvenidas. Cuando sugieras una mejora:

- Usa un título descriptivo
- Proporciona una descripción clara de la mejora sugerida
- Enumera algunos ejemplos de cómo funcionaría
- Explica por qué crees que esto sería útil

### Pull Requests 🔄

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## Estándares de código

### Bash/Shell

```bash
#!/bin/bash

# Comentarios descriptivos
function do_something() {
    # Documentación de función
    local var="value"  # Usa local para variables
    
    # Usa comillas para evitar word splitting
    echo "Variable: $var"
}
```

**Reglas:**
- Usa `#!/bin/bash` al inicio
- Comenta el código complejo
- Usa `local` para variables de función
- Comillas para variables que pueden contener espacios
- Nombres descriptivos para variables y funciones

### Nombres de variables

- `CONSTANTS_IN_UPPERCASE`
- `variables_in_lowercase`
- `functionNameInCamelCase`

### Comentarios

```bash
# Comentario de una línea

# Comentario multi-línea
# Segunda línea del comentario
# Tercera línea

# TODO: Implementar esto en v2.0
# FIXME: Esto necesita revisión
```

### Formato de código

- Indentación: 4 espacios
- Máximo 100 caracteres por línea
- Espacio después de `if`, `while`, `for`, etc.

## Proceso de revisión

1. **Verificación automática**: El código será revisado por linters
2. **Revisión manual**: Un maintainer revisará tu PR
3. **Cambios solicitados**: Si se necesitan cambios, se indicarán
4. **Aprobación**: Cuando todo esté correcto, se aprobará
5. **Merge**: Tu código será integrado al proyecto

## Commit Messages

### Formato

```
<tipo>: <asunto>

<cuerpo>

<pie>
```

### Tipos

- `feat`: Una nueva característica
- `fix`: Corrección de un bug
- `docs`: Cambios en la documentación
- `style`: Cambios que no afectan el código (espacios, formato, etc.)
- `refactor`: Refactorización de código
- `perf`: Mejoras de rendimiento
- `test`: Agregar o actualizar tests
- `chore`: Cambios en build, dependencies, etc.

### Ejemplos

```
feat: agregar función de traceroute

Implementa la funcionalidad de traceroute para rastrear
la ruta de paquetes hacia un destino.

Closes #123
```

```
fix: corregir error en parsing de DNS

El parser de DNS fallaba con ciertos formatos.
Se ha corregido la expresión regular.

Fixes #456
```

## Estructura del Proyecto

```
ip-tool/
├── ip-tool.sh           # Script principal
├── install.sh           # Script de instalación
├── README.md            # Documentación principal
├── CHANGELOG.md         # Historial de cambios
├── LICENSE              # Licencia MIT
├── CONTRIBUTING.md      # Esta guía
├── .gitignore           # Archivos ignorados
└── docs/                # Documentación adicional (opcional)
    └── advanced.md      # Guía avanzada
```

## Testing

Antes de enviar tu PR, prueba tu código:

```bash
# Ejecutar el script
./ip-tool.sh

# Probar funciones específicas
# 1) Obtener IP Pública
# 2) IP Local
# 3) Información completa
# ... etc
```

## Preguntas

¿Tienes preguntas? Abre un [Discussion](https://github.com/tuusuario/ip-tool/discussions) o contacta a los maintainers.

## Reconocimiento

¡Todos los contribuidores serán reconocidos en el archivo README!

---

**¡Gracias por contribuir! ⭐**

Para más información, consulta el [README.md](README.md)
