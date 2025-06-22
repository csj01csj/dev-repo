#!/data/data/com.termux/files/usr/bin/bash

# 기본 패키지 설치
pkg update -y && pkg upgrade -y
pkg install -y proot-distro wget git x11-repo pulseaudio termux-x11

# box64 다운로드
mkdir -p ~/wine64-box
cd ~/wine64-box
wget https://github.com/ptitSeb/box64/releases/download/v0.2.2/box64 -O box64
chmod +x box64

# proot-distro 우분투 설치
proot-distro install ubuntu
proot-distro login ubuntu --shared-tmp -- bash -c "apt update && apt install -y wine64"

# Wine 실행 스크립트 생성
cat << 'EOF' > ~/startwine64
#!/data/data/com.termux/files/usr/bin/bash

killall -9 termux-x11 Xwayland pulseaudio 2>/dev/null
termux-wake-lock
XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :1.0 &

sleep 1
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
sleep 1

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

proot-distro login ubuntu --shared-tmp -- bash -c "DISPLAY=:1.0 box64 wine64 explorer"
EOF

chmod +x ~/startwine64
ln -sf ~/startwine64 $PREFIX/bin/startwine64

echo -e "\n✅ Wine64 설치 완료!"
echo -e "👉 'startwine64' 입력하면 바로 실행됨!"
