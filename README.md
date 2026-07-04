# ПСИХОПАСПОРТ — Клинический профиль личности

Веб-приложение на основе MMPI-2 для определения психологического профиля личности с учётом коррекции по полу и возрасту.

## 🎯 Особенности

- **260 вопросов** с шкалой оценки 1-5
- **25 диагностических шкал** включая нарциссизм, социопатию, СДВГ, ПРЛ и др.
- **Шкалы валидности** (L, F, K) для проверки надёжности результатов
- **Гендерная и возрастная коррекция** результатов
- **JSON экспорт** результатов с копированием и скачиванием
- **Полная автономность** — работает офлайн, один HTML-файл (~2.5 MB)
- **Telegram Web App** интеграция — BackButton, MainButton, HapticFeedback
- **iOS совместимость** — работает в браузере Telegram на iPhone
- **Матрица анимация** — динамичный фон

## 📱 Использование

### Как обычный сайт
1. Откройте `psychopassport_v6_tg.html` в браузере
2. Заполните тест
3. Получите результаты с экспортом JSON

### В браузере Telegram
1. Отправьте ссылку на `psychopassport_v6_tg.html` в Telegram
2. Откройте в Telegram браузере
3. Кнопка «назад» будет управляться Telegram

### Как Telegram Mini App

#### Минимальный код для бота (Python):

```python
from telegram import Update, WebAppInfo
from telegram.ext import Application, CommandHandler, ContextTypes
from telegram.constants import MenuButtonType

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    web_app = WebAppInfo(url="https://yourusername.github.io/psychopassport/psychopassport_v6_tg.html")
    button = KeyboardButton(text="🧠 Открыть ПСИХОПАСПОРТ", web_app=web_app)
    reply_markup = ReplyKeyboardMarkup([[button]])
    
    await update.message.reply_text(
        "Нажмите кнопку ниже, чтобы пройти тест психологического профиля",
        reply_markup=reply_markup
    )

if __name__ == '__main__':
    app = Application.builder().token("YOUR_BOT_TOKEN").build()
    app.add_handler(CommandHandler("start", start))
    app.run_polling()
```

#### Через webhook (Node.js):

```javascript
const TelegramBot = require('node-telegram-bot-api');
const token = process.env.BOT_TOKEN;
const bot = new TelegramBot(token);

bot.onText(/\/start/, (msg) => {
  const chatId = msg.chat.id;
  const webAppUrl = 'https://yourusername.github.io/psychopassport/psychopassport_v6_tg.html';
  
  bot.sendMessage(chatId, '🧠 Открыть тест психологического профиля', {
    reply_markup: {
      keyboard: [[{
        text: '🧠 ПСИХОПАСПОРТ',
        web_app: { url: webAppUrl }
      }]],
      one_time_keyboard: true
    }
  });
});
```

## 📊 Диагностические шкалы

1. Грандиозный нарцисс (8-40 баллов)
2. Дефицитарный нарцисс (8-40)
3. Социопат (9-45)
4. Психопат (11-55)
5. Эмпат (12-60)
6. Тёмный Эмпат (9-45)
7. СДВГ (11-55)
8. Пограничное РЛ (ПРЛ) (10-50)
9. Тревожник (12-60)
10. Гистрионное РЛ (9-45)
11. Ананкастное РЛ (10-50)
12. Паника (8-40)
13. Депрессия (10-50)
14. Шизоидное РЛ (9-45)
15. Шизотипическое РЛ (10-50)
16. Параноидное РЛ (9-45)
17. Биполярное РЛ (БАР) (10-50)
18. РАС/Аспергер (11-55)
19. Макиавеллизм (9-45)
20. Садизм (8-40)
21. Ипохондрия (10-50)
22. Пассивная агрессия (9-45)
23. Зависимое РЛ (8-40)
24. Алекситимия (10-50)
25. Здоровый профиль (12-60)

## 🔧 Технические детали

- **Язык**: JavaScript ванилла (без зависимостей)
- **Размер**: ~2.5 MB (с embedded шрифтами и изображениями)
- **Совместимость**: Chrome, Safari, Firefox, Edge, Telegram Browser
- **Поддержка**: iOS, Android, Desktop

### Встроенные активы (base64):
- Bowler.ttf шрифт
- Фото профиля (PNG, RGBA)
- Таро карты (PNG)

### Работает без интернета
Всё встроено в один HTML-файл — никаких сетевых запросов.

## 📥 Интеграция результатов

Приложение возвращает JSON результатов в формате:

```json
{
  "timestamp": "2026-07-04T15:30:00Z",
  "gender": "male",
  "ageGroup": "26-40",
  "scales": {
    "Грандиозный нарцисс": {
      "raw": 28,
      "corrected": 25.2,
      "percentile": 75
    },
    ...
  },
  "validityScales": {
    "L": 18,
    "F": 15,
    "K": 8
  },
  "valid": true
}
```

## 🚀 Развёртывание на GitHub Pages

1. Создайте репозиторий `psychopassport`
2. Загрузите `psychopassport_v6_tg.html` в корень
3. Включите GitHub Pages в Settings → Pages
4. URL будет: `https://yourusername.github.io/psychopassport/psychopassport_v6_tg.html`

## 📝 Лицензия

MIT

## ✉️ Контакты

Для вопросов об интеграции с Telegram Mini Apps создавайте Issues в репозитории.

---

**Разработано для Telegram Mini Apps SDK**
