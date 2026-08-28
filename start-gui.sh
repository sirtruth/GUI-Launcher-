cat << 'EOF' > start-gui.sh
#!/bin/sh
# 1. Kill any existing displays
pkill Xvfb 2>/dev/null
pkill x11vnc 2>/dev/null

# 2. Start virtual display (800x600 resolution with 16-bit color for speed)
Xvfb :1 -screen 0 800x600x16 &
sleep 1

# 3. Launch Openbox and an initial Xterm inside display :1
DISPLAY=:1 openbox &
DISPLAY=:1 xterm -geometry 80x24+10+10 &

# 4. Expose the display over VNC on port 5900 without a password
x11vnc -display :1 -forever -nopw -rfbport 5900 &

echo "GUI is live! Connect via VNC to 127.0.0.1:5900"
EOF

chmod +x start-gui.sh
