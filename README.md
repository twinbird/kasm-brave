# kasm-brave

Kasm の Brave を Docker Compose で起動する（ブラウザ in ブラウザ）。
日本語入力（fcitx5 + Mozc）と Raindrop.io 拡張入り。

## 使い方

```bash
VNC_PW=<パスワード> docker compose up -d --build
```

ブラウザで `https://localhost:6901` を開く（自己署名証明書の警告はそのまま進む）。

- ユーザー名：`kasm_user` / パスワード：`VNC_PW` の値（未設定時は `password`）
- 日本語入力：`Ctrl+Space`

止める：

```bash
docker compose down
```
