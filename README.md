# FocusNotch

macOS-приложение, превращающее челку экрана в интерактивную панель с таймером Pomodoro и музыкой.

## Возможности

- **Pomodoro таймер** — 25/5/15 минут, длинный перерыв после N сессий, звуковые оповещения
- **Мини-таймер** — отображается поверх всех окон во время работы, показывает оставшееся время
- **Музыка** — управление Spotify, Apple Music и Yandex Music (play/pause, next, previous)
- **Настройки** — General, Timer, Notification, About
- **Язык** — английский / русский
- **Full Concentration** — отключение звуков приложения

## Управление

- Наведение на челку — появление блока вызова
- Клик — открытие основного окна
- Клик вне окна — закрытие

## Установка

### Вариант 1: Скачать готовый .app

1. Скачайте последнюю версию со [страницы релизов](https://github.com/Matot1/FocusNotch/releases)
2. Распакуйте архив и переместите `FocusNotch.app` в папку `Программы`
3. Запустите приложение (потребуется подтверждение Gatekeeper)

### Вариант 2: Собрать из исходного кода

```bash
git clone https://github.com/Matot1/FocusNotch.git
cd FocusNotch
./build.sh
open .build/debug/FocusNotch.app
```

> **Требования:** macOS 14+, Xcode 15+ или Command Line Tools

## Технологии

SwiftUI + AppKit, macOS 14+
