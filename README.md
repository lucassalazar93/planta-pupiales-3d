# Maqueta 3D · Planta de lácteos de Pupiales

Maqueta 3D conceptual de una planta de lácteos de unos 500 L/día en Pupiales (Nariño), proyecto de Omar Bravo. Sirve para mostrar el proceso y la distribución: del recibo de la leche en cantinas a la leche en bolsa, los yogures y el kumis, más una segunda fase con quesos, arequipe, crema y mantequilla.

**Industrias Equinox Colombia presenta** · diseñado y desarrollado por **[Lukbyte · Soluciones digitales](https://lukbyte-my-website.vercel.app/)**.

> Maqueta conceptual, no es un plano. Todavía no hay lote ni planos: la nave, las áreas, las medidas y las capacidades son orientativas y se ajustan en la cotización. No usa datos de ninguna otra planta. La página no aparece en buscadores (`noindex`): la abre quien tenga el enlace.

| Página | Dirección (cuando esté publicada) |
| --- | --- |
| Portada | https://planta-pupiales-3d.vercel.app |
| Maqueta 3D | https://planta-pupiales-3d.vercel.app/visor |
| Recorrido guiado | https://planta-pupiales-3d.vercel.app/visor#recorrido |
| Distribución 2D | https://planta-pupiales-3d.vercel.app/visor#plano |
| Caminar por la planta | https://planta-pupiales-3d.vercel.app/visor#caminar |

Si Vercel le pone otro nombre al proyecto, cambiar `SITIO` en `herramientas/documento.mjs` y `SITIO_URL` en `maqueta.html`, y correr `construir-index.mjs`.

---

## Qué hay en la maqueta

| Parte | Qué hace |
| --- | --- |
| **Vista 3D** | La nave con 11 zonas, 30 equipos (más un espacio reservado para un segundo tanque) y 13 líneas con el producto en movimiento. Los muros que tapan la vista se bajan solos. |
| **Distribución 2D** | Vista desde arriba con las zonas coloreadas por uso y su área aproximada, los equipos y las líneas. Sin cotas ni escala: no es un plano. |
| **Productos** | Los 13 productos de la solicitud. Al tocar uno se resaltan los equipos por los que pasa (ruta orientativa). |
| **Zonas** | Recibo y enfriamiento, laboratorio, bodega de insumos, servicios, oficina, vestier y baños, proceso de leche y fermentados, empaque, cuarto frío, despacho y la sala de quesos y derivados (fase 2). Afuera: plataforma de recibo, andén de despacho y el área reservada para ampliar. |
| **Fase 2** | La sala de quesos y derivados va en otro tono y se puede ocultar con «Fase 2». |
| **Color por origen** | Pinta cada equipo según sea de la línea Equinox (catálogo), complementario (proveedor por definir) o reserva para ampliar. |
| **Recorridos** | «Proceso completo» (14 paradas, 1:53) y uno por zona. La vista que no es la principal aparece en un recuadro. |
| **Caminar** | Recorrido a pie en primera persona desde la entrada del personal: vestier, lavabotas y proceso. Choca con muros, equipos y muebles. Esc para salir. |
| **Camión y operario** | El camión de leche junto a la plataforma; un operario entra cada cantina, la vacía en el volcador y regresa. Ilustrativo. |

### Equipos

- **Línea Equinox (catálogo):** tanque de enfriamiento de 500 L, pasteurizador de placas de 250 L/h, tanque de leche pasteurizada de 500 L, tanque de fermentación de 500 L, tanque de mezcla de 300 L, mesones, carro de canastillas; en la fase 2, tina de cuajado de 300 L, prensa neumática de 1 pistón, hiladora de 50 kg/h, carro con moldes, marmita de 50 L y mantequillera de 50 L. Las capacidades salen de la guía de dimensionamiento de Equinox para 500 L/día (`APLICACIONES[i].linea(500)` del sitio de Equinox).
- **Complementarios (proveedor por definir):** volcador, tanque recibidor con filtro, bombas, unidad condensadora, homogenizador, empacadora de bolsa para leche y semilíquidos, llenadora de vasos, generador de vapor, banco de agua helada, sistema CIP, descremadora, tajadora y empacadora al vacío.

### Supuestos por confirmar

- Lote o bodega: la nave (22,5 × 14 m, más un anexo de 12,5 × 5,5 m para la fase 2) es una propuesta, con 4 m de altura libre.
- Cómo se reparten los 500 L/día entre los productos; con eso se ajustan las capacidades.
- Si la unidad condensadora viene con el tanque de enfriamiento.
- Combustible del generador de vapor y capacidad del banco de agua helada.
- Formatos de bolsa y de vaso, y forma de desuerar el yogurt griego.
- Capacidad y temperatura del cuarto frío.

---

## Estructura del repositorio

```
index.html                Portada publicada (se genera desde portada.html, no se edita a mano)
visor.html                Maqueta publicada (se genera desde maqueta.html)
portada.html              Fuente de la portada
maqueta.html              Fuente de la maqueta: estilos, datos (zonas, equipos, líneas, productos) y código
favicon.svg  robots.txt  vercel.json  .vercelignore
assets/                   Logos de Equinox y Lukbyte, imágenes de la maqueta para la portada y la vista previa (og.jpg)
herramientas/
  servidor.mjs            Servidor local para probar, sacar imágenes y grabar el video
  documento.mjs           Envuelve cada página en su documento HTML (título, vista previa al compartir, noindex)
  construir-index.mjs     Genera index.html y visor.html
  codificar-videos.sh     Convierte en MP4 los cuadros del recorrido grabado
```

La página es HTML estático, sin paso de compilación. Three.js 0.160 se carga desde jsDelivr y las fuentes desde Google Fonts.

Los datos están al comienzo del script de `maqueta.html`: `ZONAS` (rectángulos en metros, X al oriente y Y al norte), `EQUIPOS` (posición, medidas en mm, capacidad, origen), `LINEAS`, `PRODUCTOS`, `MUROS` (con puertas y ventanas) y `PASOS` (el recorrido).

---

## Trabajar en local

Requiere Node 18 o superior.

```bash
node herramientas/servidor.mjs 5188
```

Abrir http://127.0.0.1:5188 (portada) y http://127.0.0.1:5188/visor (maqueta). El servidor arma las páginas desde `portada.html` y `maqueta.html` en cada recarga.

### Después de cambiar la portada o la maqueta

```bash
node herramientas/construir-index.mjs
```

Así `index.html` y `visor.html` quedan iguales a lo que se probó. Hacer commit de las fuentes y de las páginas generadas.

### Imágenes de la portada y de la vista previa

Con el servidor local abierto, desde la consola del navegador en la maqueta:

```js
await window.__sala.capturaLimpia('portada.jpg', { p: [x, y, z], t: [x, y, z] }, 2000, 1125)
```

Queda en `herramientas/salida/`; se mueve a `assets/`. `og.jpg` (1200 × 630, logo de Equinox al centro, menos de 300 kB) se arma sobre una captura de la maqueta; al cambiarla, subir `v=` en `herramientas/documento.mjs` para que WhatsApp no use la guardada.

### Video del recorrido (opcional)

En http://127.0.0.1:5188/visor, con la pestaña al frente y sin tocarla (en segundo plano el navegador frena la grabación):

```js
window.__sala.grabarVarios(window.__sala.LISTA_VIDEOS)
```

y en la terminal:

```bash
bash herramientas/codificar-videos.sh
```

Deja `documentos/video/planta-pupiales-recorrido.mp4` (1080p) y `planta-pupiales-recorrido-liviano.mp4` (720p, para WhatsApp). Al correr `construir-index.mjs`, el botón del video aparece solo en la portada y en la maqueta.

---

## Publicar en Vercel

1. En Vercel: **Add New → Project → Import** el repositorio `planta-pupiales-3d`.
2. **Framework Preset:** Other. Sin comando de build ni carpeta de salida.
3. **Deploy.**

Cada push a `main` publica una versión nueva. `vercel.json` agrega `noindex` a todas las respuestas; `robots.txt` deja pasar a los robots de vista previa (WhatsApp, Facebook, Telegram, LinkedIn…) para que se vea la imagen al compartir el enlace, y `.vercelignore` deja fuera del sitio este README, las herramientas y las fuentes.

---

## Créditos

**Industrias Equinox Colombia** presenta el proyecto. Fabrica en Copacabana, Antioquia, equipos en acero inoxidable para la industria láctea: los diseña, los fabrica y los instala.
WhatsApp de ventas +57 310 725 0200 · ventas@indequinoxcol.com · [indequinoxcol.com](https://indequinoxcol.com)

**Lukbyte · Soluciones digitales** diseñó y desarrolló la maqueta 3D, la distribución, el recorrido y el sitio. Software a medida que crece con tu empresa, desde Medellín.
[lukbyte-my-website.vercel.app](https://lukbyte-my-website.vercel.app/) · WhatsApp +57 315 039 9322

Maqueta conceptual del 19 de noviembre de 2026.
