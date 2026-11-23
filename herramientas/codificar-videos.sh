#!/usr/bin/env bash
# Convierte en MP4 el recorrido que grabó la maqueta con window.__sala.grabarVarios(window.__sala.LISTA_VIDEOS).
# El video queda en su subcarpeta de cuadros (proceso); el script espera a que tenga su fin.json, lo codifica y borra los cuadros.
#
#   bash herramientas/codificar-videos.sh [carpeta-de-cuadros] [subcarpeta ...]
#
# Necesita ffmpeg con libx264.
set -euo pipefail
RAIZ="$(cd "$(dirname "$0")/.." && pwd)"
CUADROS="${1:-${TMPDIR:-${TEMP:-/tmp}}/planta-pupiales-cuadros}"; shift || true
SALIDA="$RAIZ/documentos/video"
mkdir -p "$SALIDA"
VF="scale=out_range=tv:out_color_matrix=bt709,format=yuv420p"
COLOR="-pix_fmt yuv420p -color_range tv -colorspace bt709 -color_primaries bt709 -color_trc bt709 -movflags +faststart"
LISTA=("$@")
[ ${#LISTA[@]} -gt 0 ] || LISTA=(proceso)

# Alta calidad (1080p): -tune animation conserva bordes y colores planos; ipratio/pbratio bajos reparten los bits
# también a los cuadros intermedios (si no, los detalles finos se lavan cuando la cámara se mueve)
X264="ipratio=1.1:pbratio=1.05:aq-mode=3:deblock=-1,-1"
hq() { # $1 carpeta, $2 salida
  ffmpeg -hide_banner -loglevel error -y -framerate 30 -i "$1/f_%05d.jpg" -vf "$VF" -c:v libx264 -preset slower -tune animation -crf 16 -g 60 -x264-params "$X264" -maxrate 20000k -bufsize 40000k $COLOR "$2"
}
# Liviana (720p) para WhatsApp
liviano() { # $1 carpeta, $2 tasa máxima, $3 salida
  ffmpeg -hide_banner -loglevel error -y -framerate 30 -i "$1/f_%05d.jpg" -vf "scale=1280:720:flags=lanczos,$VF" -c:v libx264 -preset slower -tune animation -crf 20 -g 60 -x264-params "$X264" -maxrate "$2" -bufsize "$((${2%k} * 2))k" $COLOR "$3"
}

for v in "${LISTA[@]}"; do
  d="$CUADROS/$v"
  until [ -f "$d/fin.json" ]; do sleep 15; done
  case "$v" in
    proceso)
      hq "$d" "$SALIDA/planta-pupiales-recorrido.mp4"
      liviano "$d" 2000k "$SALIDA/planta-pupiales-recorrido-liviano.mp4" ;;
  esac
  rm -rf "$d"
  echo "$(date +%H:%M:%S) listo: $v"
done
ls -la "$SALIDA"
