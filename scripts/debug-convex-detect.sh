#!/bin/bash

echo "=== Convexプロジェクト検出デバッグ ==="
echo ""

# ポート3000の確認
echo "1. ポート3000の状況:"
lsof -i :3000 | grep LISTEN | head -5
echo ""

# ポート3000を使用しているプロセスの詳細
echo "2. ポート3000のプロセス詳細:"
PID=$(lsof -ti :3000 | head -1)
if [ -n "$PID" ]; then
    echo "PID: $PID"
    ps -p "$PID" -o comm=
    echo "作業ディレクトリ:"
    lsof -p "$PID" 2>/dev/null | grep cwd | head -1
fi
echo ""

# ポート3210の確認
echo "3. ポート3210（Convex）の状況:"
lsof -i :3210 | grep LISTEN || echo "ポート3210は使用されていません"
echo ""

# npm/pnpm devプロセスの確認
echo "4. dev実行中のプロセス:"
ps aux | grep -E "(npm|pnpm|yarn).*dev" | grep -v grep | head -5
echo ""

# ai-zaikoディレクトリの確認
echo "5. ai-zaikoプロジェクトの確認:"
if [ -d "/Users/soichiro/Work/ai-zaiko" ]; then
    echo "ディレクトリが存在します"
    echo "package.jsonのconvex確認:"
    grep -c "convex" /Users/soichiro/Work/ai-zaiko/package.json
else
    echo "ディレクトリが存在しません"
fi
echo ""

# 実行中のnodeプロセス
echo "6. 実行中のnodeプロセス（上位5件）:"
ps aux | grep node | grep -v grep | head -5