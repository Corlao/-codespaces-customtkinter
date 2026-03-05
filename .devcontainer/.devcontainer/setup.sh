#!/bin/bash

# Atualizar sistema
sudo apt-get update

# Instalar dependências para GUI
sudo apt-get install -y \
    python3-tk \
    python3-pip \
    xvfb \
    x11vnc \
    novnc \
    websockify \
    supervisor \
    fluxbox \
    firefox

# Instalar CustomTkinter
pip3 install customtkinter

# Criar script de inicialização
cat > /home/vscode/start-gui.sh << 'EOF'
#!/bin/bash

# Iniciar Xvfb (display virtual)
Xvfb :99 -screen 0 1024x768x24 &
export DISPLAY=:99

# Iniciar window manager (fluxbox)
fluxbox &

# Iniciar VNC server
x11vnc -display :99 -forever -shared -rfbport 5901 -nopw &

# Iniciar noVNC
novnc --listen 6080 --vnc localhost:5901 &

echo "✅ GUI iniciada!"
echo "🌐 Acesse a porta 6080 no navegador"
EOF

chmod +x /home/vscode/start-gui.sh

# Criar diretório de trabalho
mkdir -p /home/vscode/app
