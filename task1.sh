# Масив із вебсайтами для перевірки
websites=(
  "https://google.com"
  "https://facebook.com"
  "https://twitter.com"
)

# Назва файлу логів
log_file="website_status.log"

# Очищаємо старий лог перед новим запуском
> "$log_file"

echo "Перевірка доступності вебсайтів..."

# Проходимо по кожному сайту у списку
for site in "${websites[@]}"; do
  # Отримуємо HTTP статус-код (переадресації -L)
  status_code=$(curl -s -o /dev/null -w "%{http_code}" -L "$site")

  # Перевіряємо, чи статус-код 200 (успішна відповідь)
  if [ "$status_code" -eq 200 ]; then
    echo "$site is UP" | tee -a "$log_file"
  else
    echo "$site is DOWN (status code: $status_code)" | tee -a "$log_file"
  fi
done

echo "------------------------------------"
echo "Результати записано у файл: $log_file"
