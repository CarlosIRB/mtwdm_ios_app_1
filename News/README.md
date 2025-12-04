# 📰 Aplicación de Noticias: Agregador Multifuente

---

## 📝 Descripción del Proyecto

Proyecto de aplicación móvil para un **Agregador de Noticias Multifuente** con funcionalidades clave de **personalización por país y categoría**. El objetivo es ofrecer una experiencia de usuario configurable y rica en contenido.

---

## ✨ Definición de Pantallas y Funcionalidades

| # | Vista (View) | Propósito y Descripción | API Sugerida / Endpoint |
| :---: | :--- | :--- | :--- |
| **1** | **HomeView (Inicio / Dashboard)** | * Muestra las categorías principales. * Acceso rápido a **“Top Headlines”**. * Incluye navegación al resto de vistas. | **News API** – `/top-headlines` |
| **2** | **NewsListView (Listado por Categoría o Fuente)** | * Lista dinámica con **imágenes remotas**. * Integración de filtros (categoría, país, fuente). | **News API** – `/top-headlines?category={categoria}`, `/top-headlines?sources={source}`, `/everything?q={keyword}` (opcional). |
| **3** | **NewsDetailView (Detalle de una Noticia)** | * Muestra **título, imagen, contenido y enlace externo**. * **NO** requiere llamada al API (usa el objeto de noticia del listado). | Sin API. |
| **4** | **SearchView (Búsqueda de Noticias)** | * **Barra de búsqueda** con manejo de estados. * Incluye funcionalidad de "tema sorpresa" con una palabra aleatoria. | **News API** – `/everything?q={searchText}`. **Random Word API** (o similar). |
| **5** | **PinnedView (Favoritos Locales)** | * **Guarda artículos seleccionados** en *local storage* (`@State` / `@Observable`). * Permite **eliminar** elementos. | Sin API. |
| **6** | **SettingsView (Configuración)** | Permite ajustar las **preferencias globales**: * **Selección de país** (códigos ISO). * **Selección de categorías** mediante *checks*. | **REST Countries API** – `/v3.1/all` (Opcional, para cargar países). |

---

## ⚙️ Detalle de Configuración (SettingsView)

### Configuración de Preferencias

La vista permite al usuario establecer preferencias que personalizan el contenido de las noticias:

1.  **Selección de País:** Usa códigos ISO para filtrar los resultados de **News API**.
    * *API Opcional para Países:* **REST Countries API** (`/v3.1/all`).
2.  **Selección de Categorías:** Configuración de categorías predefinidas por NewsAPI, mostradas con Toggles/Checkboxes.

### Categorías Soportadas por NewsAPI

* `business`
* `entertainment`
* `general`
* `health`
* `science`
* `sports`
* `technology`

---

## ➕ Pantallas Opcionales (para 7 u 8 vistas)

* **7. SourcesView (Listado de Fuentes de Noticias):** Muestra fuentes disponibles y permite navegar a un listado de artículos por fuente seleccionada.
* **8. AboutView (Información de la App):** Vista dedicada a mostrar información técnica o créditos de la aplicación.
