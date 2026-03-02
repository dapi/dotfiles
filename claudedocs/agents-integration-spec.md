# Спецификация: Интеграция ~/.agents в Dotfiles

## 🎯 Цели

1. Версионировать Claude Skills конфигурацию через dotfiles
2. Автоматизировать установку/обновление skills
3. Синхронизировать skills между машинами через git

## 📐 Архитектурное Решение

### Принцип: Симлинк всей директории

```
~/.agents → ~/dotfiles/agents  (симлинк)
```

**Обоснование:**
- ✅ Простота: один симлинк вместо нескольких
- ✅ Claude Code автоматически читает ~/.agents/skills/
- ✅ Всё версионируется автоматически (skills + lock файл)
- ✅ Нет необходимости в git submodules

### Структура

```
~/dotfiles/agents/
├── Makefile              # Автоматизация управления skills
├── README.md             # Документация
├── .skill-lock.json      # Lock файл (создаётся npx @claude/skills)
└── skills/               # Директория с установленными skills
    ├── playwriter/
    ├── find-skills/
    └── adr-writing/
```

## 🛠️ Компоненты

### 1. Makefile (`~/dotfiles/agents/Makefile`)

**Default target:** `make` → обновить все skills

```makefile
.PHONY: all install update sync list

# Default target - установить и обновить всё
all: update

# Установить skills из .skill-lock.json
install:
	@echo "📦 Installing skills from .skill-lock.json..."
	@if [ -f .skill-lock.json ]; then \
		cat .skill-lock.json | jq -r '.skills | keys[]' | while read skill; do \
			if [ ! -d "skills/$$skill" ]; then \
				source=$$(cat .skill-lock.json | jq -r ".skills.$$skill.source"); \
				echo "  📥 Installing $$skill from $$source"; \
				npx @claude/skills install $$source; \
			else \
				echo "  ✅ $$skill already installed"; \
			fi; \
		done; \
	else \
		echo "⚠️  No .skill-lock.json found"; \
	fi

# Обновить все skills
update:
	@echo "🔄 Updating all skills..."
	@npx @claude/skills update

# Показать установленные skills
list:
	@echo "📋 Installed skills:"
	@npx @claude/skills list

# Синхронизировать с git
sync:
	@echo "💾 Syncing to git..."
	@cd ~/dotfiles && git add agents/
	@cd ~/dotfiles && git status
```

### 2. README.md (`~/dotfiles/agents/README.md`)

```markdown
# Claude Skills Management

## Быстрый старт

\`\`\`bash
cd ~/.agents
make          # Обновить все skills
make install  # Установить из .skill-lock.json (первый раз)
make list     # Показать установленные
make sync     # Синхронизировать с git
\`\`\`

## Установка нового skill

\`\`\`bash
npx @claude/skills install <source>

# Примеры:
npx @claude/skills install remorses/playwriter
npx @claude/skills install vercel-labs/commit-commands
\`\`\`

## Структура

\`\`\`
~/.agents/
├── Makefile           # Автоматизация (симлинк → ~/dotfiles/agents/)
├── README.md          # Эта инструкция (симлинк → ~/dotfiles/agents/)
├── .skill-lock.json   # Lock файл (симлинк → ~/dotfiles/agents/)
└── skills/            # Установленные skills (симлинк → ~/dotfiles/agents/)
\`\`\`

**Всё симлинки на `~/dotfiles/agents/`** - автоматически версионируется в git!
```

### 3. Модуль dotfiles (`makefiles/agents.mk`)

```makefile
# makefiles/agents.mk
DOTFILES:=${DOTFILES} ~/.agents
```

**Обоснование:**
- Не нужны PACKAGES (npx уже установлен глобально)
- Не нужны APPLIES (skills устанавливаются через make в ~/.agents)

## 🔄 Workflow Сценарии

### Сценарий 1: Установка на новой машине

```bash
# 1. Клонировать dotfiles
git clone <repo> ~/dotfiles

# 2. Установить dotfiles
cd ~/dotfiles
make              # Создаст ~/.agents → ~/dotfiles/agents

# 3. Установить skills
cd ~/.agents
make install      # Установит все skills из .skill-lock.json
```

### Сценарий 2: Добавление нового skill

```bash
# 1. Установить skill
cd ~/.agents
npx @claude/skills install vercel-labs/new-skill

# 2. Синхронизировать с git
make sync

# 3. Коммитнуть
cd ~/dotfiles
git commit -m "Add new-skill"
git push
```

### Сценарий 3: Обновление skills

```bash
# 1. Обновить все skills
cd ~/.agents
make              # = make update

# 2. Синхронизировать с git (если были изменения)
make sync
cd ~/dotfiles
git commit -m "Update skills"
git push
```

### Сценарий 4: Удаление skill

```bash
# 1. Удалить skill
cd ~/.agents
npx @claude/skills remove playwriter

# 2. Синхронизировать
make sync
cd ~/dotfiles
git commit -m "Remove playwriter skill"
git push
```

## 📋 План Реализации

### Этап 1: Подготовка

```bash
# 1. Создать директорию в dotfiles
mkdir -p ~/dotfiles/agents

# 2. Переместить существующие данные
cp -r ~/.agents/* ~/dotfiles/agents/
rm -rf ~/.agents

# 3. Создать Makefile
cat > ~/dotfiles/agents/Makefile << 'EOF'
[содержимое из раздела "Компоненты"]
EOF

# 4. Создать README.md
cat > ~/dotfiles/agents/README.md << 'EOF'
[содержимое из раздела "Компоненты"]
EOF
```

### Этап 2: Интеграция в dotfiles

```bash
# 1. Создать модуль
cat > ~/dotfiles/makefiles/agents.mk << 'EOF'
DOTFILES:=${DOTFILES} ~/.agents
EOF

# 2. Применить
cd ~/dotfiles
make dotfiles     # Создаст симлинк ~/.agents → ~/dotfiles/agents
```

### Этап 3: Тестирование

```bash
# 1. Проверить симлинк
readlink ~/.agents
# Ожидаемый результат: /Users/danil/dotfiles/agents

# 2. Проверить команды
cd ~/.agents
make list         # Показать установленные skills
make update       # Обновить skills

# 3. Проверить idempotent
cd ~/dotfiles
make dotfiles     # Не должно создавать дубликаты/ошибок
```

### Этап 4: Документация

```bash
# Обновить CLAUDE.md с описанием agents integration
# Добавить в секцию "Добавление Нового Конфига"
```

## ✅ Критерии Успеха

- [ ] `~/.agents` является симлинком на `~/dotfiles/agents`
- [ ] `cd ~/.agents && make` обновляет все skills
- [ ] `make install` устанавливает skills из .skill-lock.json
- [ ] `make sync` готовит изменения для git commit
- [ ] Повторный `make dotfiles` не создаёт ошибок (idempotent)
- [ ] README.md содержит актуальные инструкции
- [ ] CLAUDE.md обновлён с описанием agents

## 🚨 Потенциальные Проблемы

### Проблема 1: Существующий ~/.agents не пустой

**Решение:** Создать бекап через linker.mk (автоматически)

```bash
# linker.mk создаст:
~/.agents-2026-02-14-17:30:00  # Бекап
~/.agents → ~/dotfiles/agents   # Новый симлинк
```

### Проблема 2: npx @claude/skills не установлен

**Решение:** Добавить проверку в Makefile

```makefile
check-npx:
	@which npx > /dev/null || (echo "❌ npx not found. Install Node.js first" && exit 1)

update: check-npx
	@npx @claude/skills update
```

### Проблема 3: jq не установлен (для make install)

**Решение:** Добавить jq в PACKAGES

```makefile
# makefiles/agents.mk
PACKAGES:=${PACKAGES} jq
DOTFILES:=${DOTFILES} ~/.agents
```

## 🎨 Альтернативные Варианты (Отклонены)

### ❌ Git Submodules для skills/
**Причина отклонения:** Избыточная сложность, npx уже управляет репозиториями

### ❌ Отдельные симлинки на файлы
**Причина отклонения:** Усложняет конфигурацию, нужно отслеживать каждый файл отдельно

### ❌ Версионировать только .skill-lock.json
**Причина отклонения:** Придётся устанавливать skills каждый раз, медленнее

## 📊 Сравнение: До и После

### До
```
~/.agents/
├── .skill-lock.json      # Не версионируется
└── skills/               # Не версионируется
    ├── playwriter/
    ├── find-skills/
    └── adr-writing/

# Проблемы:
- ❌ Нет синхронизации между машинами
- ❌ Нет автоматизации установки
- ❌ Ручное управление skills
```

### После
```
~/dotfiles/agents/        # Всё версионируется в git
├── Makefile              # Автоматизация
├── README.md             # Документация
├── .skill-lock.json      # Lock файл
└── skills/               # Установленные skills

~/.agents → ~/dotfiles/agents  # Симлинк

# Преимущества:
- ✅ Автоматическая синхронизация через git
- ✅ make install на новой машине
- ✅ make update для обновления
- ✅ Версионирование всех изменений
```

## 📝 TODO После Реализации

- [ ] Протестировать на второй машине (клонирование + make install)
- [ ] Добавить в CLAUDE.md описание agents
- [ ] Проверить работу с разными типами skills
- [ ] Создать пример в README для кастомных skills
- [ ] Рассмотреть автоматизацию через git hooks (pre-commit sync)

## 🔗 Связанные Документы

- `CLAUDE.md` - основная документация dotfiles
- `makefiles/linker.mk` - логика создания симлинков
- `configuration.mk` - список DOTFILES
