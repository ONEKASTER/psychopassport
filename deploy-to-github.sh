#!/bin/bash

# ПСИХОПАСПОРТ — Deploy to GitHub Pages
# Этот скрипт создаёт репо и загружает файлы безопасно

set -e

echo "╔════════════════════════════════════════════════════════╗"
echo "║  ПСИХОПАСПОРТ Deploy to GitHub                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Проверка Git
if ! command -v git &> /dev/null; then
    echo "❌ Git не установлен. Установи Git и повтори."
    exit 1
fi

# Спросить username
read -p "🔑 Введи свой GitHub username (не токен!): " GITHUB_USER

if [ -z "$GITHUB_USER" ]; then
    echo "❌ Username не может быть пустым"
    exit 1
fi

REPO_NAME="psychopassport"
REPO_URL="https://github.com/$GITHUB_USER/$REPO_NAME.git"

echo ""
echo "📦 Будет создан репо: $REPO_URL"
echo ""
echo "⚠️  ВАЖНО: GitHub попросит авторизацию"
echo "   1. При запросе пароля введи личный токен (не пароль!)"
echo "   2. Токен нужен с правами: public_repo"
echo "   3. Если у тебя нет токена, создай на:"
echo "      https://github.com/settings/tokens"
echo ""

# Создать временную папку
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "📁 Рабочая папка: $TEMP_DIR"
echo ""

# Инициализировать репо локально
echo "1️⃣  Инициализирую git репо..."
git init
git config user.email "psychopassport@local"
git config user.name "ПСИХОПАСПОРТ Bot"

# Скопировать файлы (они должны быть в /mnt/user-data/outputs/)
echo "2️⃣  Копирую файлы..."

FILES=(
    "psychopassport_v6_tg.html"
    "index.html"
    "README.md"
    "GITHUB_SETUP.md"
    "QUICK_START.txt"
    "FILES_FOR_GITHUB.txt"
)

for file in "${FILES[@]}"; do
    if [ -f "/mnt/user-data/outputs/$file" ]; then
        cp "/mnt/user-data/outputs/$file" .
        echo "   ✓ $file"
    else
        echo "   ⚠️  Файл не найден: $file"
    fi
done

# Создать .gitignore
cat > .gitignore << 'GITIGNORE'
.DS_Store
Thumbs.db
.vscode/
.idea/
*.log
node_modules/
GITIGNORE

echo "   ✓ .gitignore"
echo ""

# Добавить в git
echo "3️⃣  Добавляю файлы в git..."
git add .
git commit -m "Initial commit: ПСИХОПАСПОРТ — Clinical psychology test"

echo ""
echo "4️⃣  Создаю удалённый репо на GitHub..."
echo "   Переходу на https://github.com/new"
echo ""
echo "   📝 ЗАПОЛНИ ФОРМУ:"
echo "   - Repository name: psychopassport"
echo "   - Description: Clinical psychology test - MMPI-2 based"
echo "   - Public: ✓ (обязательно)"
echo "   - Add .gitignore: нет (у нас уже есть)"
echo "   - Add README: нет (у нас уже есть)"
echo "   - License: MIT"
echo ""
echo "   ✅ После создания репо нажми кнопку с SSH ссылкой"
echo "   Скопируй её и вставь ниже"
echo ""

read -p "🔗 Вставь SSH или HTTPS URL нового репо (или Enter для автоматического): " REMOTE_URL

if [ -z "$REMOTE_URL" ]; then
    REMOTE_URL="$REPO_URL"
fi

echo ""
echo "5️⃣  Загружаю файлы на GitHub..."
git remote add origin "$REMOTE_URL"
git branch -M main
git push -u origin main

echo ""
echo "6️⃣  Включаю GitHub Pages..."
echo "   📍 Перейди в Settings репо"
echo "   📍 Левая панель: Pages"
echo "   📍 Source: Deploy from a branch"
echo "   📍 Branch: main, folder: /root"
echo "   📍 Save"
echo ""
echo "   Через 1-2 минуты сайт будет доступен по адресу:"
echo "   🌐 https://$GITHUB_USER.github.io/psychopassport/"
echo ""

echo "✅ ГОТОВО!"
echo ""
echo "📚 Документация:"
echo "   - README.md — описание проекта"
echo "   - GITHUB_SETUP.md — детальная инструкция"
echo "   - QUICK_START.txt — интеграция с Telegram"
echo ""
echo "🧹 Очистка: rm -rf $TEMP_DIR"
echo ""

