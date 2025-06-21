#!/data/data/com.termux/files/usr/bin/bash

export GREEN='\033[0;32m'
export UYELLOW='\033[4;33m'
export WHITE='\033[0;37m'

termux_gpu_accel_install()
{
    set -e
    sleep 1
    echo -e "${GREEN}mesa 패키지 설치${WHITE}"
    pkg install -y mesa mesa-demos mesa-dev

    sleep 1
    echo -e "${GREEN}mesa-vulkan-icd-freedreno-dri3 설치 - Adreno GPU Vulkan API${WHITE}"
    pkg install -y mesa-vulkan-icd-freedreno-dri3
}

termux_gpu_accel_dev_install()
{
    sleep 1
    echo -e "${GREEN}clvk 설치 - OpenCL Vulkan 매핑 라이브러리${WHITE}"
    pkg install -y clvk

    sleep 1
    echo -e "${GREEN}clinfo 설치 - OpenCL 디바이스 정보 확인${WHITE}"
    pkg install -y clinfo

    sleep 1
    echo -e "${GREEN}gtkmm4 설치 - C++ GUI 라이브러리${WHITE}"
    pkg install -y gtkmm4

    sleep 1
    echo -e "${GREEN}libsigc++-3.0 설치 - 콜백 구현 라이브러리${WHITE}"
    pkg install -y libsigc++-3.0

    sleep 1
    echo -e "${GREEN}libcairomm-1.16 설치 - 2D 그래픽 라이브러리${WHITE}"
    pkg install -y libcairomm-1.16

    sleep 1
    echo -e "${GREEN}libglibmm-2.68 설치 - GLib C++ 래퍼${WHITE}"
    pkg install -y libglibmm-2.68

    sleep 1
    echo -e "${GREEN}libpangomm-2.48 설치 - 텍스트 렌더링 라이브러리${WHITE}"
    pkg install -y libpangomm-2.48

    sleep 1
    echo -e "${GREEN}swig 설치 - 바인딩 생성 도구${WHITE}"
    pkg install -y swig

    sleep 1
    echo -e "${GREEN}libpeas 설치 - GTK 플러그인 프레임워크${WHITE}"
    pkg install -y libpeas
}

echo -e "${UYELLOW}gpu 가속(mesa-zink, mesa-vulkan-icd-freedreno-dri3)을 설치하겠습니까? (y/n)${WHITE}"
read yn
case $yn in
    y|Y ) echo -e "${GREEN}gpu 가속을 설치합니다.${WHITE}"
        termux_gpu_accel_install
        ;;
    * ) echo -e "${GREEN}설치를 하지 않습니다.${WHITE}"
        ;;
esac

echo -e "${UYELLOW}gpu 가속 개발 패키지(clvk 등)를 설치하겠습니까? (y/n)${WHITE}"
read yn
case $yn in
    y|Y ) echo -e "${GREEN}gpu 가속 개발 패키지를 설치합니다.${WHITE}"
        termux_gpu_accel_dev_install
        ;;
    * ) echo -e "${GREEN}설치를 하지 않습니다.${WHITE}"
        ;;
esac
