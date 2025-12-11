#!/bin/bash

# ホームディレクトリを動的に取得
HOME_DIR="$HOME"

# convexプロセスを探してプロジェクトディレクトリを取得
PROJECT_DIR=""

# 方法1: convex devプロセスから取得
CONVEX_PID=$(pgrep -f "convex dev" | head -1)
if [ -n "$CONVEX_PID" ]; then
    PROJECT_DIR=$(lsof -p "$CONVEX_PID" 2>/dev/null | grep cwd | awk '{print $NF}')
fi

# 方法2: pnpm devプロセスから取得
if [ -z "$PROJECT_DIR" ]; then
    # pnpm devを実行しているプロセスを探す
    for pid in $(pgrep -f "pnpm.*dev"); do
        dir=$(lsof -p "$pid" 2>/dev/null | grep cwd | awk '{print $NF}')
        if [ -n "$dir" ] && [ -f "$dir/package.json" ]; then
            # convexが含まれているか確認
            if grep -q "convex" "$dir/package.json" 2>/dev/null; then
                PROJECT_DIR="$dir"
                break
            fi
        fi
    done
fi

# プロジェクトが見つからない場合はエラー
if [ -z "$PROJECT_DIR" ] || [ ! -d "$PROJECT_DIR" ]; then
    osascript -e 'display notification "convex devが実行されていません" with title "DB Reset エラー"'
    exit 1
fi

# Terminal.appで実行
osascript <<EOF
tell application "Terminal"
    activate
    -- ログは表示しつつ、コマンドラインは見やすく
    set w to do script "clear && echo '🔄 DB Reset実行中...' && echo '📁 $PROJECT_DIR' && echo '' && cd '$PROJECT_DIR' && npx convex run seedData:resetAndSeedAll && echo '' && echo '✅ DB Reset完了!'"
    set wID to id of front window
    
    -- コマンドが完了するまで待機
    repeat
        delay 1
        if not busy of w then exit repeat
    end repeat
    
    -- 完了後1秒待ってから閉じる（Convexのリアルタイム同期）
    delay 1
    close window id wID
end tell
EOF