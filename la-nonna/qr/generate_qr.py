#!/usr/bin/env python3
"""Genera el código QR de la Web de Clientes de Spicy Coconut.

Uso:
    pip install qrcode[pil]
    python3 generate_qr.py [URL]

Si no se pasa URL, usa la URL por defecto de despliegue.
Regenera el QR cada vez que cambie la URL definitiva.
"""
import sys

import qrcode
from qrcode.constants import ERROR_CORRECT_H

DEFAULT_URL = "https://spicy-coconut.netlify.app"

# Colores de marca Spicy Coconut
DARK = "#161310"
CREAM = "#F3EDE0"


def main() -> None:
    url = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_URL
    qr = qrcode.QRCode(error_correction=ERROR_CORRECT_H, box_size=20, border=2)
    qr.add_data(url)
    qr.make(fit=True)
    img = qr.make_image(fill_color=DARK, back_color=CREAM)
    img.save("qr.png")
    print(f"qr.png generado → {url} ({img.size[0]}x{img.size[1]} px)")


if __name__ == "__main__":
    main()
