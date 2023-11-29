#!/usr/bin/env sh


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "============================================="
echo "               Unpacking Discord             "
echo "============================================="

if (( $(ls /home/$SUDO_USER/Downloads | grep -i "discord.*.tar.gz" | wc -l) == 0)); then
    echo "Please Put the tar.gz Discord file into the Downloads Folder!"
    exit 1
fi

tar -xvzf "/home/$SUDO_USER/Downloads/$(ls /home/$SUDO_USER/Downloads | grep -i "discord.*.tar.gz")" -C /opt

echo "============================================="
echo "               Updating Sym Link            "
echo "============================================="

if(( $(ls /opt | grep -i "Discord" | wc -l) == 0 )); then
    echo "Failed to extract Discord!"
    exit 1
fi

ln -sf /opt/Discord/Discord /usr/bin/Discord


echo "============================================="
echo "           Updating Icon and Menu            "
echo "============================================="

sed -i "s#Exec=.*#Exec=/usr/bin/Discord#g" /opt/Discord/discord.desktop
sed -i "s#Icon=.*#Icon=/opt/Discord/discord.png#g" /opt/Discord/discord.desktop
cp -r /opt/Discord/discord.desktop /usr/share/applications
