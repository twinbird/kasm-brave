# kasmweb/brave に日本語入力（fcitx5 + mozc）と日本語フォントを追加する派生イメージ
FROM kasmweb/brave:1.18.0

USER root

RUN apt-get update \
 && apt-get install -y \
      fcitx5-mozc \
      fcitx5-frontend-gtk3 \
      fcitx5-frontend-qt5 \
      fonts-noto-cjk \
      language-pack-ja \
 && rm -rf /var/lib/apt/lists/*

# Raindrop.io 拡張機能を起動時に強制インストールする管理ポリシー
COPY extensions.json /etc/brave/policies/managed/extensions.json

ENV GTK_IM_MODULE=fcitx \
    QT_IM_MODULE=fcitx \
    XMODIFIERS=@im=fcitx \
    LANG=ja_JP.UTF-8

# fcitx5 の自動起動と Mozc の事前登録
RUN mkdir -p /home/kasm-user/.config/autostart /home/kasm-user/.config/fcitx5 \
 && printf '[Desktop Entry]\nType=Application\nName=Fcitx5\nExec=fcitx5\nX-GNOME-Autostart-enabled=true\n' \
      > /home/kasm-user/.config/autostart/fcitx5.desktop \
 && printf '[Groups/0]\nName=Default\nDefault Layout=us\nDefaultIM=mozc\n\n[Groups/0/Items/0]\nName=keyboard-us\nLayout=\n\n[Groups/0/Items/1]\nName=mozc\nLayout=\n\n[GroupOrder]\n0=Default\n' \
      > /home/kasm-user/.config/fcitx5/profile \
 && chown -R 1000:1000 /home/kasm-user/.config

USER 1000
