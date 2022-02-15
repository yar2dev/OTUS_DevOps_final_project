# Search Engine UI


Веб-интерфейс поиска слов и фраз на проиндексированных [ботом](https://github.com/express42/search_engine_crawler) сайтах.

Веб-интерфейс минимален, предоставляет пользователю строку для запроса и результаты. Поиск происходит только по индексированным сайтам. Результат содержит только те страницы, на которых были найдены все слова из запроса. Рядом с каждой записью результата отображается оценка полезности ссылки (чем больше, тем лучше).

## Необходимые компоненты
Для запуска веб-интерфейса нужно установить дополнительные компоненты python командой
```
pip install -r requirements.txt
```

Для работы веб-интерфейса нужен запущенный сервис `mongodb`

## Запуск веб-интерфейса
### Переменные окружения
* `MONGO` - адрес `mongodb`-хоста
* `MONGO_PORT` - порт для подключения к `mongodb`-хосту

### Пример для запуска
В общем случае веб-интерфейс можно запустить с помощью команд
```
cd ui
FLASK_APP=ui.py gunicorn ui:app -b 0.0.0.0
```

Для проверки работы веб-интефейса надо зайти по адресу `http://HOST_IP:8000/`, где `HOST_IP` - адрес хоста на котором запущен веб-интерфейс.

## Тестирование
### Необходимые компоненты
Для тестирования необходимо установить дополнительные компоненты с помщью команды
```
pip install -r requirements.txt -r requirements-test.txt
```

### Тестирование
Базовая команда для запуска unit-тестов
```
python -m unittest discover -s tests/
```

Команды для генерации отчета о покрытии кода тестами
```
coverage run -m unittest discover -s tests/
coverage report --include ui/ui.py
```

## Мониторинг
Метрики для снятия `prometheus` доступны по адресу `http://HOST_IP:8000/metrics`, где `HOST_IP` - адрес хоста на котором запущен бот.

### Метрики
* `web_pages_served` - количество обработанных запросов
* `web_page_gen_time` - время генерации веб-страниц, учитывая время обработки запроса

## Логирование
Бот отправляет логи в `json`-формате в `stdout`