# Karabiner Config Backup

このリポジトリは Karabiner-Elements 設定のバックアップ用です。

## 含まれるもの
- `karabiner.json` / `karabiner.json.backup`: 現行設定
- `assets/complex_modifications/aqua_fn_shift_send.json`: Aqua 音声入力用の Fn→右Ctrl 送信ルール
- `scripts/`: Karabiner から呼び出す補助スクリプト

## 使い方
1. `~/.config/karabiner` にこの内容を配置
2. Karabiner-Elements を再読み込み（Preferences を開き直すなど）
3. Complex Modifications で「Aqua: Fn + Right Ctrl then send on Ctrl down」を有効化

バックアップ取得日: $(date '+%Y-%m-%d %H:%M:%S')
