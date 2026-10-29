# 📱 Calculadora Móvil - Flutter

Aplicación móvil de Calculadora desarrollada en **Flutter / Dart** para la evaluación práctica de la materia **Programación III**. La aplicación cuenta con una interfaz moderna, limpia y responsiva, siguiendo las mejores prácticas de nomenclatura y el principio de diseño **KISS (Keep It Simple, Stupid)**.

---

## 👨‍💻 Información del Desarrollador

| Campo | Detalle |
| :--- | :--- |
| **Estudiante / Desarrollador** | Hamad El Troudi |
| **Materia** | Programación III |
| **Carrera** | Ingeniería en Informática |
| **Tecnología** | Flutter 3.x / Dart 3.x |
| **Versión** | 1.0.0 |

---

## 🎯 Características Principales

### 1. Pantalla Principal (`HomeScreen`)
* **Operaciones Matemáticas Básicas**:
  * ➕ **Suma (`+`)**
  * ➖ **Resta (`-`)**
  * ✖️ **Multiplicación (`×`)**
  * ➗ **División (`÷`)**
* **Funciones de Limpieza y Control**:
  * **`CE` (Clear Entry)**: Borra la operación completa y restablece la calculadora a cero (`0`).
  * **`C` (Clear Space)**: Borra un solo carácter de derecha a izquierda (función retroceso / backspace).
  * **`+/-`**: Alterna entre valores positivos y negativos.
  * **`.`**: Punto decimal con validación de un solo punto por número.
* **Pantalla de Visualización**:
  * Historial superior que muestra la operación previa.
  * Pantalla principal con escalado dinámico (`FittedBox`) para evitar desbordamientos visuales.
* **Navegación**:
  * Botón directo en la barra superior (`AppBar`) que redirige a la pantalla de información.

### 2. Pantalla de Información (`InfoScreen`)
* Muestra los datos del estudiante y de la materia académica.
* Tarjetas informativas con detalles de la aplicación y funcionalidades implementadas.
* Navegación de retorno fluida hacia la pantalla principal mediante el botón de la barra superior y botón de acción al pie de la pantalla.

---

## 📂 Estructura del Proyecto

El código fuente sigue una arquitectura organizada y limpia por responsabilidades:

```text
lib/
│
├── main.dart                 # Punto de entrada de la aplicación y configuración de temas
│
├── routes/
│   └── app_routes.dart       # Definición de rutas nombradas de navegación
│
├── screens/
│   ├── home_screen.dart      # Pantalla principal de la calculadora y lógica matemática
│   └── info_screen.dart      # Pantalla con la información del desarrollador
│
└── widgets/
    └── calc_button.dart      # Widget modular y reutilizable para los botones de la calculadora
```

---

## 🚀 Requisitos e Instalación

### Prerrequisitos
* [Flutter SDK](https://flutter.dev/docs/get-started/install) (versión 3.10 o superior)
* [Dart SDK](https://dart.dev/)
* Dispositivo móvil Android/iOS conectado, emulador, o navegador web (Edge / Chrome).

### Pasos para Ejecutar

1. **Clonar o descargar el repositorio**:
   ```bash
   git clone https://github.com/hamadtm7/calculadora.git
   cd calculadora
   ```

2. **Obtener las dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecutar las pruebas unitarias y de widgets**:
   ```bash
   flutter test
   ```

4. **Ejecutar la aplicación**:
   ```bash
   flutter run
   ```

---

## 🧩 Principios y Buenas Prácticas Aplicadas

* **KISS (Keep It Simple, Stupid)**: Código conciso, estructurado y fácil de mantener sin dependencias externas innecesarias.
* **Nomenclatura estándar**:
  * Archivos y directorios: `lower_snake_case` (ej. `home_screen.dart`, `app_routes.dart`).
  * Clases: `UpperCamelCase` (ej. `HomeScreen`, `CalcButton`, `AppRoutes`).
  * Variables y métodos: `camelCase` (ej. `_displayText`, `_onOperatorPressed`).
* **Manejo de Errores**: Prevención de división por cero mediante el estado `Error` y control de desbordamiento en pantalla.
* **Cero Comentarios en Código Fuente**: Código autoexplicativo según los requerimientos solicitados para la entrega.
