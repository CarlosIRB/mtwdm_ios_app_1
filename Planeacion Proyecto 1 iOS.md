Planeacion Proyecto 1 iOS

Tematica: Aplicacion para visualizar noticias, con filtros por categoria y pais, una vista para buscar o recomendar noticias y guardado de noticias o de fuentes de noticias.

Descripción del proyecto: Agregador de Noticias Multifuente con personalización por país/categoría

Defiinición de pantallas:

### **1\. HomeView (Inicio / Dashboard)**

* Muestra las categorías principales de noticias.

* Acceso rápido a “Top Headlines”.

* Incluye navegación al resto de vistas.

**API sugerida:**

* **News API** – Endpoint: `/top-headlines`  
   Muestra titulares principales por defecto o según país configurado.

**Propósito del API en esta vista:**

* Presentar titulares destacados.

* Dar una previsualización rápida antes de entrar a listas más profundas.

### **2\. NewsListView (Listado por categoría o fuente)**

* Lista dinámica con datos del API.

* Uso de imágenes remotas.

* Integración de filtros (categoría, país, fuente).

**News API** – Endpoints:

* `/top-headlines?category={categoria}`

* `/top-headlines?sources={source}`

* `/everything?q={keyword}` (si aplica)

### **3\. NewsDetailView (Detalle de una noticia)**

* Muestra título, imagen, contenido y enlace externo  
* Es una vista distinta, con su propio propósito.  
* Sin llamar de nuevo al api. El mismo objeto del listado trae toda la información necesaria.

### **4\. SearchView (Búsqueda de noticias)**

* Barra de búsqueda.

* Lista de resultados proveniente del API.

* Estado loading/error/success.  
  **News API**

* Endpoint principal:  
   `/everything?q={searchText}`

* Usado para búsquedas manuales y para mostrar noticias relacionadas con el tema generado aleatoriamente.

  **Random Word API** (o API equivalente, como API-Ninjas Random Word)

* Ejemplo de endpoint:  
   `https://random-word-api.herokuapp.com/word`

* Genera una palabra aleatoria que se usa como “tema sorpresa”.

**API sugerida:**

* **News API** – Endpoint: `/everything?q={searchText}`

### **5\. PinnedView (Favoritos locales)**

* Guarda artículos seleccionados en local storage (@State / @Observable).

* Permite eliminar elementos.

### **6\. SettingsView (Configuración)**

### **Descripción funcional**

La vista permite ajustar las preferencias globales del usuario que afectan directamente las consultas a las APIs.  
 Incluye dos configuraciones principales:

1. **Selección de país** (usando códigos ISO) para personalizar las noticias mostradas.

2. **Selección de categorías mediante checks**, donde el usuario puede activar o desactivar las categorías de interés.

   ### **¿Usa API?**

✔️ **Sí** (si se desea cargar los países dinámicamente)

* **REST Countries API** – `/v3.1/all`  
   Permite cargar la lista de países y sus códigos ISO de manera dinámica para configurar NewsAPI.

✖️ **No requiere API** para las categorías (son valores predefinidos por NewsAPI).

### **Configuración de categorías (nueva funcionalidad)**

La vista presenta una lista de categorías soportadas por **NewsAPI**:

* `business`

* `entertainment`

* `general`

* `health`

* `science`

* `sports`

* `technology`

Cada categoría aparece con un **Toggle / CheckBox** asociado.

---

## **Pantallas opcionales si deseas llegar a 7 u 8 vistas**

### **7\. SourcesView (Listado de fuentes de noticias)**

* Consumo de un endpoint de fuentes.

* Al seleccionar una fuente, abre otra lista con artículos.

### **8\. AboutView (Información de la app)**

* Información técnica.

* No es un loader ni modal; cuenta como vista con propósito único.

