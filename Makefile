# Устанавливаем переменную для команды flutter
FLUTTER = flutter

# Команда для генерации кода с build_runner
gen: install-dependencies
	$(FLUTTER) pub run build_runner build --delete-conflicting-outputs

# Устанавливаем зависимости (если их нет)
install-dependencies:
	$(FLUTTER) pub get

# Очистка проекта (по желанию)
clean:
	$(FLUTTER) clean

# Для генерации кода с очисткой
clean-generate: clean generate

# Отображение доступных команд
help:
	@echo "Доступные команды:"
	@echo "  generate         - Запуск генерации кода с build_runner"
	@echo "  install-dependencies  - Установить зависимости"
	@echo "  clean            - Очистить проект"
	@echo "  clean-generate   - Очистка и генерация кода"
	@echo "  help             - Показать эту справку"
