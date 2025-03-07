
#Область ПрограммныйИнтерфейс

// Читает таблицу совместимости поставляемого расширения с конфигурациями и их версиями.
//
//	Параметры:
//		ТаблицаСовместимости - ОбъектXDTO - {http://www.1c.ru/1cFresh/ConfigurationExtensions/Compatibility/1.0.0.1} CompatibilityList.
// 
//	Возвращаемое значение:
//		ТаблицаЗначений - таблица совместимости:
//			* ConfigarationName - Строка - имя конфигурации
//			* MinimumVersionNumber - Строка - минимальная версия конфигурации
//			* MaximumVersionNumber - Строка - максимальная версия конфигурации
//
Функция ПрочитатьТаблицуСовместимости(Знач ТаблицаСовместимости) Экспорт
	
	Результат = Новый ТаблицаЗначений();
	Результат.Колонки.Добавить("ConfigarationName", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("MinimumVersionNumber", Новый ОписаниеТипов("Строка"));
	Результат.Колонки.Добавить("MaximumVersionNumber", Новый ОписаниеТипов("Строка"));
	
	Если ТипЗнч(ТаблицаСовместимости) = Тип("Массив") Тогда
		ДанныеСовместимости = ТаблицаСовместимости;
	Иначе
		ДанныеСовместимости = ТаблицаСовместимости.CompatibilityObjects;
	КонецЕсли;
	
	Для Каждого СтрокаСовместимости Из ДанныеСовместимости Цикл
		
		Строка = Результат.Добавить();
		ЗаполнитьЗначенияСвойств(Строка, СтрокаСовместимости);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Разделяет строковое представление версии на составляющие "Редакция, Подредакция, Версия, Сборка"
//
//	Параметры:
//		ВерсияСтрокой - Строка - версия строкой
//		Разделитель - Строка - символы разделяющие значения в строке версий
//		ЛюбаяВерсия - Строка - символы обозначающие любую версию
//
//	Возвращаемое значение:
//		Структура - данные версии:
//			* Редакция - Строка - редакция
//			* Подредакция - Строка - подредакция
//			* Версия - Строка - версия
//			* Сборка - Строка - сборка
//
Функция РазделитьВерсию(Знач ВерсияСтрокой, Разделитель = ".", ЛюбаяВерсия = "*") Экспорт
	
	ВерсияСтрокой = ?(ПустаяСтрока(ВерсияСтрокой), ЛюбаяВерсия + Разделитель + ЛюбаяВерсия + Разделитель + ЛюбаяВерсия + Разделитель + ЛюбаяВерсия, ВерсияСтрокой);
	
	Состав = СтрРазделить(СтрЗаменить(ВерсияСтрокой, " ", ""), Разделитель, Ложь);
	ФорматСоблюден = Состав.Количество() = 4;
	
	Если ФорматСоблюден Тогда
		
		Попытка
			
			Редакция = ?(СтрНайти(Состав[0], ЛюбаяВерсия), Неопределено, Число(Состав[0]));
			Подредакция = ?(СтрНайти(Состав[1], ЛюбаяВерсия), Неопределено, Число(Состав[1]));
			Версия = ?(СтрНайти(Состав[2], ЛюбаяВерсия), Неопределено, Число(Состав[2]));
			Сборка = ?(СтрНайти(Состав[3], ЛюбаяВерсия), Неопределено, Число(Состав[3]));
			
			ФорматСоблюден = (Редакция = Неопределено ИЛИ Редакция >= 0)
							И (Подредакция = Неопределено ИЛИ Подредакция >= 0)
							И (Версия = Неопределено ИЛИ Версия >= 0)
							И (Сборка = Неопределено ИЛИ Сборка >= 0);
			
		Исключение
			
			ФорматСоблюден = Ложь;
			
		КонецПопытки;
		
	КонецЕсли;
	
	Если НЕ ФорматСоблюден Тогда
		
		Описание = НСтр("ru='Версия """"%1"""" не соответствует формату Редакция.Подредакция.Версия.Сборка.';uk='Версія """"%1"""" не відповідає формату Редакція.Підредакція.Версія.Збірка.'");
		Описание = СтрЗаменить(Описание, "%1", ВерсияСтрокой);
		
		ВызватьИсключение Описание;
		
	КонецЕсли;
	
	ДанныеВерсии = Новый Структура;
	ДанныеВерсии.Вставить("Редакция", Редакция);
	ДанныеВерсии.Вставить("Подредакция", Подредакция);
	ДанныеВерсии.Вставить("Версия", Версия);
	ДанныеВерсии.Вставить("Сборка", Сборка);
	
	Возврат ДанныеВерсии;
	
КонецФункции

// Соединяет данные версии в строковое представление
//
//	Параметры:
//		Версия - Структура - данные версии:
//			* Редакция - Строка - редакция
//			* Подредакция - Строка - подредакция
//			* Версия - Строка - версия
//			* Сборка - Строка - сборка 
//
//	Возвращаемое значение:
//		Строка - версия строкой
//
Функция СоединитьВерсию(Версия) Экспорт
	
	РедакцияСтрокой = ?(Версия.Редакция = Неопределено, "*", Формат(Версия.Редакция, "ЧН=; ЧГ=0"));
	ПодредакцияСтрокой = ?(Версия.Подредакция = Неопределено, "*", Формат(Версия.Подредакция, "ЧН=; ЧГ=0"));
	ВерсияСтрокой = ?(Версия.Версия = Неопределено, "*", Формат(Версия.Версия, "ЧН=; ЧГ=0"));
	СборкаСтрокой = ?(Версия.Сборка = Неопределено, "*", Формат(Версия.Сборка, "ЧН=; ЧГ=0"));
	
	Возврат СтрШаблон("%1.%2.%3.%4", РедакцияСтрокой, ПодредакцияСтрокой, ВерсияСтрокой, СборкаСтрокой);
	
КонецФункции

// Сравнивает две версии.
//
// Параметры:
//  ПервоеЗначение  - Структура - Первое значение сравнения.
//  ВтороеЗначений - Структура - Второе значение сравнения.
// 
// Возвращаемое значение:
//  Число - Результат сравнения.
//    Результат < 0 - первое значение меньше второго. 
//    Результат > 0 - первое значение больше второго. 
//    Результат = 0 - первое значение равно второму.
//
Функция СравнитьВерсии(ПервоеЗначение, ВтороеЗначений) Экспорт
	
	Результат = 0;
	Результат = ?(Результат = 0 И ПервоеЗначение.Редакция <> Неопределено И ВтороеЗначений.Редакция <> Неопределено, ПервоеЗначение.Редакция - ВтороеЗначений.Редакция, Результат);
	Результат = ?(Результат = 0 И ПервоеЗначение.Подредакция <> Неопределено И ВтороеЗначений.Подредакция <> Неопределено, ПервоеЗначение.Подредакция - ВтороеЗначений.Подредакция, Результат);
	Результат = ?(Результат = 0 И ПервоеЗначение.Версия <> Неопределено И ВтороеЗначений.Версия <> Неопределено, ПервоеЗначение.Версия - ВтороеЗначений.Версия, Результат);
	Результат = ?(Результат = 0 И ПервоеЗначение.Сборка <> Неопределено И ВтороеЗначений.Сборка <> Неопределено, ПервоеЗначение.Сборка - ВтороеЗначений.Сборка, Результат);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти