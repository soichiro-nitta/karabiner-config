#!/bin/bash

# シンプルなアプローチ：
# Aquaが自動ペースト後、適切なタイミングでEnter送信

LOG_FILE="/tmp/karabiner-enter.log"

# 3秒待機（音声処理の完了を待つ）
sleep 3

# Aquaがペーストするまで少し待機（Aquaの自動ペースト時間を考慮）
sleep 1.5

# Enter送信（ペースト完了後）
osascript -e 'tell application "System Events" to keystroke return'

# ログ出力
echo "[$(date)] Enter sent after waiting for Aqua paste" >> "$LOG_FILE"