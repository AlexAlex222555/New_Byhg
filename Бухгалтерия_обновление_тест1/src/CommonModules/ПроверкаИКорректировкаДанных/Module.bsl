
#Область ПрограммныйИнтерфейс

// Возвращает таблицу модулей проверки.
//
// Параметры:
//   ВосстанавливатьНастройки - Булево - требуется или нет восстанавливать сохраненные настройки обработок.
//   ПолучатьПрошлыйРезультат - Булево - требуется или нет получать сохраненный результат.
//
// Возвращаемое значение:
//   ТаблицаЗначений - таблица с колонками:
//     * Пометка - Булево - для выбора проверки значение этого поля должно быть Истина.
//     * Имя - Строка - имя модуля.
//     * Наименование - Строка - краткое наименование проверки для пользователя.
//     * Описание - Строка - описание проверки для пользователя.
//     * ФормаНастроек - Строка - имя формы настроек, 
//          описание см. ПроверкаИКорректировкаДанныхПереопределяемый.ПриЗаполненииПроверок().
//     * Настройки - Структура - структура, содержащая любой сериализуемый тип, 
//          описание см. ПроверкаИКорректировкаДанныхПереопределяемый.ПриЗаполненииПроверок().
//     * ВременныеДанные - Структура - структура, содержащая любой сериализуемый тип, 
//          описание см. ПроверкаИКорректировкаДанныхПереопределяемый.ПриЗаполненииПроверок().
//     * ТребуетсяЗаполнитьНастройки - Булево - в строках, где требуется заполнить настройки, 
//          значение этого поля будет Истина.
//     * Дата - Дата - дата последней проверки.
//     * Исправлять - Булево - флаг последней проверки.
//     * ОбнаруженыПроблемы - Булево - результат последней проверки.
//     * ПредставлениеРезультата - Строка - результат последней проверки.
//     * ТабличныйДокумент - Произвольный - файл с 
//          результатом последней проверки.
//
Функция Проверки(ВосстанавливатьНастройки = Ложь, Знач ПолучатьПрошлыйРезультат = Ложь) Экспорт
	
	ДоступныРазделенныеДанные = Истина;
	РазделениеВключено = Ложь;
	ИспользованиеРазделителяСеанса = Ложь;
	ПрисоединенныеФайлыДоступны = Ложь;
	Если ВнедренаБСП() Тогда
		ДоступныРазделенныеДанные = Модуль("ОбщегоНазначенияПовтИсп").ДоступноИспользованиеРазделенныхДанных();
		РазделениеВключено = Модуль("ОбщегоНазначенияПовтИсп").РазделениеВключено();
		ИспользованиеРазделителяСеанса = Модуль("ОбщегоНазначения").ИспользованиеРазделителяСеанса();
		ПрисоединенныеФайлыДоступны = Модуль("ОбщегоНазначения").ПодсистемаСуществует("СтандартныеПодсистемы.ПрисоединенныеФайлы");
	КонецЕсли;
	
	ПолучатьПрошлыйРезультат = ПолучатьПрошлыйРезультат И ДоступныРазделенныеДанные И ПрисоединенныеФайлыДоступны;
	
	Если ВосстанавливатьНастройки Тогда
		
		СохраненныеНастройки = ХранилищеСистемныхНастроек.Загрузить("Обработка.ПроверкаИКорректировкаДанных.Форма.Форма/ТекущиеДанные");
		
		Если ТипЗнч(СохраненныеНастройки) = Тип("Соответствие") Тогда
			ВыбранныеПроверки = СохраненныеНастройки["ВыбранныеПроверки"];
			НастройкиПроверок = СохраненныеНастройки["НастройкиПроверок"];
		КонецЕсли;
		
		Если ТипЗнч(ВыбранныеПроверки) <> Тип("Массив") Тогда
			ВыбранныеПроверки = Новый Массив;
		КонецЕсли;
		
		Если ТипЗнч(НастройкиПроверок) <> Тип("Соответствие") Тогда
			НастройкиПроверок = Новый Соответствие;
		КонецЕсли;
		
	КонецЕсли;
	
	Если ПолучатьПрошлыйРезультат Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ИсторияПроверкиИКорректировкиДанных.Ссылка,
		|	ИсторияПроверкиИКорректировкиДанных.Дата,
		|	ИсторияПроверкиИКорректировкиДанных.Исправление,
		|	ИсторияПроверкиИКорректировкиДанных.ОбнаруженыПроблемы,
		|	ИсторияПроверкиИКорректировкиДанных.ПредставлениеРезультата,
		|	ИсторияПроверкиИКорректировкиДанных.ТабличныйДокумент
		|ИЗ
		|	Справочник.ИсторияПроверкиИКорректировкиДанных КАК ИсторияПроверкиИКорректировкиДанных";
		
		ПрошлыеРезультаты = Запрос.Выполнить().Выгрузить();
		ПрошлыеРезультаты.Индексы.Добавить("Ссылка");
		
	КонецЕсли;
	
	Проверки = ТаблицаПроверки();
	
	Для Каждого СтрокаПроверка Из Обработчики() Цикл
		
		Сведения = Новый Структура;
		Сведения.Вставить("Наименование", "");
		Сведения.Вставить("Описание", "");
		Сведения.Вставить("ФормаНастроек", "");
		Сведения.Вставить("Настройки", Новый Структура);
		Сведения.Вставить("РазделенныеДанные", Истина);
		
		Обработчик = Модуль(СтрокаПроверка.Значение);
		Обработчик.ПроверкаИКорректировкаДанных_ЗаполнитьСведения(Сведения);
		
		Если РазделениеВключено И ИспользованиеРазделителяСеанса <> Сведения.РазделенныеДанные Тогда
			Продолжить;
		КонецЕсли;
		
		Проверка = Проверки.Добавить();
		Проверка.Идентификатор = СтрокаПроверка.Ключ;
		Проверка.Наименование = Сведения.Наименование;
		Проверка.Описание = Сведения.Описание;
		Проверка.ФормаНастроек = Сведения.ФормаНастроек;
		Проверка.Настройки = Сведения.Настройки;
		
		Если ВосстанавливатьНастройки Тогда
			Проверка.Пометка = ВыбранныеПроверки.Найти(Проверка.Идентификатор) <> Неопределено;
			Если Не ПустаяСтрока(Проверка.ФормаНастроек) И НастройкиПроверок[Проверка.Идентификатор] <> Неопределено Тогда
				ЗаполнитьЗначенияСвойств(Проверка.Настройки, НастройкиПроверок[Проверка.Идентификатор]);
			КонецЕсли;
		КонецЕсли;
		
		Если ПолучатьПрошлыйРезультат Тогда
			
			ИсторияСсылка = Справочники["ИсторияПроверкиИКорректировкиДанных"].ПолучитьСсылку(СтрокаПроверка.Ключ);
			ПрошлыйРезультат = ПрошлыеРезультаты.Найти(ИсторияСсылка, "Ссылка");
			Если ПрошлыйРезультат <> Неопределено Тогда
				Проверка.Дата = ПрошлыйРезультат.Дата;
				Проверка.Исправление = ПрошлыйРезультат.Исправление;
				Проверка.ОбнаруженыПроблемы = ПрошлыйРезультат.ОбнаруженыПроблемы;
				Проверка.ПредставлениеРезультата = ПрошлыйРезультат.ПредставлениеРезультата;
				Проверка.ТабличныйДокумент = ПрошлыйРезультат.ТабличныйДокумент;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Проверки.Сортировать("Наименование");
	
	Возврат Проверки;
	
КонецФункции

// Выполняет поиск проблем для выбранных строк и заполняет колонку Результат.
//
// Параметры:
//   Проверки - ТаблицаЗначений - таблица полученная с помощью функции Проверки().
//   Исправлять - Булево - Истина, если требуется исправление.
//   СохранятьРезультат - Булево - если Истина, тогда результат будет сохранен в присоединенный файл.
//
// Возвращаемое значение:
//   Булево - Истина - проверка выполнена, Ложь - требуется заполнить настройки.
//
Функция ПроверитьДанные(Проверки, Исправлять = Ложь, СохранятьРезультат = Ложь) Экспорт
	
	Возврат ПроверитьДанныеОбщая(Проверки, Исправлять, СохранятьРезультат);
	
КонецФункции

// Выполняет извлечение табличного документа из zip-архива присоединенного файла.
//
// Параметры:
//   ПрисоединенныйФайл - СправочникСсылка.ИсторияПроверкиИКорректировкиДанныхПрисоединенныеФайлы - файл из которого
//      требуется извлечь табличный документ.
//
// Возвращаемое значение:
//   ТабличныйДокумент - табличный документ извлеченный из архива. Если табличный документ не
//      найден, то будет вызвано исключение.
//
Функция ТабличныйДокументИзПрисоединенногоФайла(ПрисоединенныйФайл) Экспорт
	
	Если Не ВнедренаБСП() Тогда
		ВызватьИсключение НСтр("ru='Метод поддерживается только в конфигурациях, в которых внедрена БСП.';uk='Метод підтримується тільки в конфігураціях, в яких впроваджена БСП.'");
	КонецЕсли;
	
	ВременныйКаталог = ПолучитьИмяВременногоФайла();
	СоздатьКаталог(ВременныйКаталог);
	
	ИмяФайлаАрхива = ВременныйКаталог + ПолучитьРазделительПути() + "1.zip";
	
	Если Не ОбщегоНазначения.СсылкаСуществует(ПрисоединенныйФайл) Тогда
		ВызватьИсключение НСтр("ru='Присоединенный файл не существует.';uk='Приєднаний файл не існує.'");
	КонецЕсли;
	
	ДвоичныеДанные = Модуль("РаботаСФайлами").ДвоичныеДанныеФайла(ПрисоединенныйФайл);
	ДвоичныеДанные.Записать(ИмяФайлаАрхива);
	
	ЧтениеZipФайла = Новый ЧтениеZipФайла(ИмяФайлаАрхива);
	
	ТабличныйДокумент = Неопределено;
	Для Каждого ЭлементАрхива Из ЧтениеZipФайла.Элементы Цикл
		Если ЭлементАрхива.Расширение = "mxl" Тогда
			ЧтениеZipФайла.Извлечь(ЭлементАрхива, ВременныйКаталог, РежимВосстановленияПутейФайловZIP.НеВосстанавливать); 
			ТабличныйДокумент = Новый ТабличныйДокумент;
			ТабличныйДокумент.Прочитать(ВременныйКаталог + ПолучитьРазделительПути() + ЭлементАрхива.Имя);
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если ТабличныйДокумент = Неопределено Тогда
		ВызватьИсключение НСтр("ru='Присоединенный файл не содержит табличный документ.';uk='Приєднаний файл не містить табличний документ.'");
	КонецЕсли;
	
	УдалитьФайлы(ВременныйКаталог);
	
	Возврат ТабличныйДокумент;
	
КонецФункции

// Возвращает признак внедрения БСП.
//
// Возвращаемое значение:
//   Булево - Истина - внедрена, Ложь - нет.
//
Функция ВнедренаБСП() Экспорт
	
	Возврат Метаданные.Подсистемы.Найти("СтандартныеПодсистемы") <> Неопределено;
	
КонецФункции

// Возвращает модуль по имени.
//
// Параметры:
//   Имя - Строка - имя общего модуля.
//
// Возвращаемое значение:
//   ОбщийМодуль - ОбщийМодуль.
//
Функция Модуль(Имя) Экспорт
	
	Части = СтрРазделить(Имя, ".");
	Если Части.Количество() = 1 Тогда
		Если Метаданные.ОбщиеМодули.Найти(Имя) = Неопределено Тогда
			ВызватьИсключение СтрШаблон(НСтр("ru='Общий модуль ""%1"" не существует';uk='Загальний модуль ""%1"" не існує'"), Имя);
		КонецЕсли;
	ИначеЕсли Части.Количество() = 2 Тогда
		Попытка
			Проверка = Новый Структура(Части[0]);
			Проверка = Новый Структура(Части[1]);
		Исключение
			ВызватьИсключение НСтр("ru='Неправильный модуль';uk='Неправильний модуль'");
		КонецПопытки;
	Иначе
		ВызватьИсключение НСтр("ru='Неправильный модуль';uk='Неправильний модуль'");
	КонецЕсли;
	
	УстановитьБезопасныйРежим(Истина);
	Возврат Вычислить(Имя);
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Проверка данных для запуска в фоновом задании.
//
// Параметры:
//   Проверки - ТаблицаЗначений - таблица с проверками.
//   Исправлять - Булево - требуется или нет исправление.
//   Адрес - Строка - Адрес во временном хранилище, куда требуется сохранить результат.
//
Процедура ПроверитьДанныеВФоне(Проверки, Исправлять, Адрес) Экспорт
	
	ПроверитьДанныеОбщая(Проверки, Исправлять, Истина, Адрес);
	
КонецПроцедуры

// Заполняет массив типов, исключаемых из выгрузки и загрузки данных.
//
// Параметры:
//  Типы - Массив - заполняется метаданными.
//
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	Типы.Добавить(Метаданные.Справочники["ИсторияПроверкиИКорректировкиДанных"]);
	Типы.Добавить(Метаданные.Справочники["ИсторияПроверкиИКорректировкиДанныхПрисоединенныеФайлы"]);
	
КонецПроцедуры

// Возвращает строку сообщения, с которой начинается сообщение-прогресс.
//
// Возвращаемое значение:
//   Строка - Идентификатор.
//
Функция ИдентификаторПрогресса() Экспорт
	
	Возврат "{ПроверкаИКорректировкаДанных.Прогресс}" + Символы.ПС;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает идентификаторы проверок и их обработчики.
//
// Возвращаемое значение:
//   Соответствие - соответствие, где:
//     * Ключ - УникальныйИдентификатор - идентификатор проверки.
//     * Значение - Строка - имя модуля проверки, описание см. ПроверкаИКорректировкаДанныхПереопределяемый.ПриЗаполненииПроверок().
//
Функция Обработчики()
	
	Обработчики = Новый Соответствие;
	
	Если Метаданные.РегистрыБухгалтерии.Количество() Тогда
		Обработчики.Вставить(Новый УникальныйИдентификатор("2b1043e2-9e00-4518-ac0d-1a2befdcce1c"), "Обработки.ПроверкаИзмеренийВРегистрахБухгалтерии");
	КонецЕсли;
	
	ПроверкаИКорректировкаДанныхПереопределяемый.ПриЗаполненииПроверок(Обработчики);
	
	Возврат Обработчики;
	
КонецФункции

// Конструктор таблицы проверок.
//
// Возвращаемое значение:
//   ТаблицаЗначений - таблица с колонками:
//     * Идентификатор - УникальныйИдентификатор - идентификатор проверки.
//     * Пометка - Булево - флаг использования проверки.
//     * Наименование - Строка - наименование проверки.
//     * Описание - Строка - описание проверки.
//     * ФормаНастроек - Строка - полное имя формы.
//     * Настройки - Структура - настройки проверки, сохраняются при редактировании в форме.
//     * ВременныеДанные - Структура - временные данные проверки, не сохраняются при редактировании в форме.
//     * ТребуетсяЗаполнитьНастройки - Булево - если в результате проверки оказалось, что настройки не заполнены, то
//                                              будет Истина.
//     * Дата - Дата - универсальная дата последней проверки.
//     * Исправление - Булево - Истина, если в последней проверке требовалось исправление.
//     * ОбнаруженыПроблемы - Булево - Истина, если в последней проверке были обнаружены проблемы.
//     * ПредставлениеРезультата - Строка - краткое представление последнего результата.
//     * ТабличныйДокумент - ТабличныйДокумент - подробный отчет последнего результата.
//
Функция ТаблицаПроверки()
	
	Проверки = Новый ТаблицаЗначений;
	Проверки.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("УникальныйИдентификатор"));
	Проверки.Колонки.Добавить("Пометка", Новый ОписаниеТипов("Булево"));
	Проверки.Колонки.Добавить("Наименование", Новый ОписаниеТипов("Строка"));
	Проверки.Колонки.Добавить("Описание", Новый ОписаниеТипов("Строка"));
	Проверки.Колонки.Добавить("ФормаНастроек", Новый ОписаниеТипов("Строка"));
	Проверки.Колонки.Добавить("Настройки", Новый ОписаниеТипов("Структура"));
	Проверки.Колонки.Добавить("ВременныеДанные", Новый ОписаниеТипов("Структура"));
	Проверки.Колонки.Добавить("ТребуетсяЗаполнитьНастройки", Новый ОписаниеТипов("Булево"));
	Проверки.Колонки.Добавить("Дата", Новый ОписаниеТипов("Дата"));
	Проверки.Колонки.Добавить("Исправление", Новый ОписаниеТипов("Булево"));
	Проверки.Колонки.Добавить("ОбнаруженыПроблемы", Новый ОписаниеТипов("Булево"));
	Проверки.Колонки.Добавить("ПредставлениеРезультата", Новый ОписаниеТипов("Строка"));
	Если Метаданные.Справочники.Найти("ИсторияПроверкиИКорректировкиДанныхПрисоединенныеФайлы") <> Неопределено Тогда
		Проверки.Колонки.Добавить("ТабличныйДокумент", Новый ОписаниеТипов("СправочникСсылка.ИсторияПроверкиИКорректировкиДанныхПрисоединенныеФайлы"));
	КонецЕсли;
	
	Возврат Проверки;
	
КонецФункции

// Проверяет настройки в таблице проверок.
// 
// Параметры:
//   Проверки - ТаблицаЗначений - таблица полученная с помощью функции Проверки().
//   Исправлять - Булево - Истина, если требуется исправление.
//   Обработчики - Соответствие - обработчики полученные с помощью функции Обработчики().
//
// Возвращаемое значение:
//   Булево - Истина, если требуется заполнить настройки.
//
Функция ТребуетсяЗаполнитьНастройки(Проверки, Исправлять, Обработчики) 
	
	ТребуетсяЗаполнитьНастройки = Ложь;
	Для Каждого Проверка Из Проверки Цикл
		
		Если Не Проверка.Пометка Тогда
			Продолжить;
		КонецЕсли;
		
		Если ПустаяСтрока(Проверка.ФормаНастроек) Тогда
			Продолжить;
		КонецЕсли;
		
		Модуль = Обработчики.Получить(Проверка.Идентификатор);
		Если Модуль = Неопределено Тогда
			ВызватьИсключение НСтр("ru='Не найден обработчик подсистемы проверки и корректировки данных.';uk='Не знайдений обробник підсистеми перевірки і коригування даних.'");
		КонецЕсли;
		
		Обработчик = Модуль(Модуль);
		Обработчик.ПроверкаИКорректировкаДанных_ПроверитьНастройки(Проверка.Настройки, Проверка.ВременныеДанные, Исправлять, Проверка.ТребуетсяЗаполнитьНастройки);
		
		ТребуетсяЗаполнитьНастройки = ТребуетсяЗаполнитьНастройки Или Проверка.ТребуетсяЗаполнитьНастройки;
		
	КонецЦикла;
	
	Возврат ТребуетсяЗаполнитьНастройки;
	
КонецФункции

// Выполняет проверку данных.
// 
// Параметры:
//   Проверки - см. Проверки - проверки.
//   Исправлять - Булево - требуется или нет исправление.
//   СохранятьРезультат - Булево - если Истина, тогда результат будет сохранен в присоединенный файл.
//   Адрес - Строка - Адрес во временном хранилище, куда требуется сохранить результат, 
//        результат представляет собой структуру с ключами:
//          * Выполнено - Булево - Истина - проверка выполнена, Ложь - требуется заполнить настройки.
//          * Проверки - ТаблицаЗначений - таблица из параметра Проверки.
//
// Возвращаемое значение:
//   Булево - Истина - проверка выполнена, Ложь - требуется заполнить настройки.
//
Функция ПроверитьДанныеОбщая(Проверки, Исправлять, СохранятьРезультат, Адрес = Неопределено)
	
	КоличествоПроверок = Проверки.НайтиСтроки(Новый Структура("Пометка", Истина)).Количество();
	Комментарий = СтрШаблон(НСтр("ru='Количество проверок: %1.';uk='Кількість перевірок: %1.'",ОбщегоНазначения.КодОсновногоЯзыка()), КоличествоПроверок);
	ЗаписьЖурналаРегистрации(СобытиеЗапускЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация, , , Комментарий);
			
	ЭтоФоновоеЗадание = Адрес <> Неопределено;
	
	Обработчики = Обработчики();
	
	ЗаписыватьИсторию = СохранятьРезультат И ВнедренаБСП() И Модуль("ОбщегоНазначенияПовтИсп").ДоступноИспользованиеРазделенныхДанных() И Модуль("ОбщегоНазначения").ПодсистемаСуществует("СтандартныеПодсистемы.ПрисоединенныеФайлы");
	
	Результат = Новый Структура("Выполнено, Проверки", Ложь, Проверки);
	
	Если ЭтоФоновоеЗадание Тогда
		Шаблон = НСтр("ru='Выполняется: %1';uk='Виконується: %1'");
		СообщитьПрогресс(СтрШаблон(Шаблон, НСтр("ru='Проверка настроек';uk='Перевірка настройок'")));
	КонецЕсли;
	
	Если Не ТребуетсяЗаполнитьНастройки(Проверки, Исправлять, Обработчики) Тогда
	
		Для Каждого Проверка Из Проверки Цикл
			
			Если Не Проверка.Пометка Тогда
				Продолжить;
			КонецЕсли;
			
			ИмяСобытия = СобытиеПроверкиЖурналаРегистрации(Проверка.Наименование);
			Комментарий = НСтр("ru='Начало выполнения проверки.';uk='Початок виконання перевірки.'",ОбщегоНазначения.КодОсновногоЯзыка());
			ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Информация, , , Комментарий);
			
			Если ЭтоФоновоеЗадание Тогда
				СообщитьПрогресс(СтрШаблон(Шаблон, Проверка.Наименование));
			КонецЕсли;
			
			РезультатПроверки = Новый Структура;
			РезультатПроверки.Вставить("ОбнаруженыПроблемы", Ложь);
			РезультатПроверки.Вставить("ПредставлениеРезультата", НСтр("ru='Проблемы не обнаружены';uk='Проблеми не виявлені'"));
			РезультатПроверки.Вставить("ТабличныйДокумент", Неопределено);
			
			Модуль = Обработчики.Получить(Проверка.Идентификатор);
			Если Модуль = Неопределено Тогда
				ВызватьИсключение НСтр("ru='Не найден обработчик подсистемы проверки и корректировки данных.';uk='Не знайдений обробник підсистеми перевірки і коригування даних.'");
			КонецЕсли;
			Обработчик = Модуль(Модуль);
			
			Попытка
				
				Обработчик.ПроверкаИКорректировкаДанных_ПроверитьДанные(Проверка.Настройки, Проверка.ВременныеДанные, Исправлять, РезультатПроверки);
			
			Исключение
				
				ИнформацияОбОшибке = ИнформацияОбОшибке();
				КраткоеПредставлениеОшибки = КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
				ПодробноеПредставлениеОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке);
				
				Комментарий = СтрШаблон(ШаблонОшибкиВыполненияПроверки(), Символы.ПС + ПодробноеПредставлениеОшибки);
				ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , Комментарий);
				
				Комментарий = СтрШаблон(ШаблонОшибкиВыполненияПроверки(), Символы.ПС + КраткоеПредставлениеОшибки);
				РезультатПроверки.ОбнаруженыПроблемы = Истина;
				РезультатПроверки.ПредставлениеРезультата = Комментарий;
				РезультатПроверки.ТабличныйДокумент = Неопределено;
				
			КонецПопытки;
			
			Комментарий = СтрШаблон(НСтр("ru='Результат проверки: %1.';uk='Результат перевірки: %1.'",ОбщегоНазначения.КодОсновногоЯзыка()), РезультатПроверки.ПредставлениеРезультата);
			ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Информация, , , Комментарий);
			
			Проверка.Дата = ТекущаяУниверсальнаяДата();
			Проверка.Исправление = Исправлять;
			Проверка.ОбнаруженыПроблемы = РезультатПроверки.ОбнаруженыПроблемы;
			Проверка.ПредставлениеРезультата = РезультатПроверки.ПредставлениеРезультата;
			
			ПрисоединенныйФайл = Неопределено;
			Если ЗаписыватьИсторию Тогда
				ПрисоединенныйФайл = ЗаписатьИсторию(Проверка, РезультатПроверки);
			КонецЕсли;
			
			Если ЭтоФоновоеЗадание Тогда
			
				Если РезультатПроверки.ТабличныйДокумент = Неопределено Тогда
					Проверка.ТабличныйДокумент = Неопределено;
				ИначеЕсли ЗаписыватьИсторию Тогда
					Проверка.ТабличныйДокумент = ПрисоединенныйФайл;
				ИначеЕсли ЭтоАдресВременногоХранилища(Проверка.ТабличныйДокумент) Тогда
					ИмяВременногоФайла = ПолучитьИмяВременногоФайла("mxl");
					РезультатПроверки.ТабличныйДокумент.Записать(ИмяВременногоФайла);
					ПоместитьВоВременноеХранилище(Новый ДвоичныеДанные(ИмяВременногоФайла), Проверка.ТабличныйДокумент);
					УдалитьФайлы(ИмяВременногоФайла);
				КонецЕсли;
			
				Проверка.Настройки = Неопределено;
				Проверка.ВременныеДанные = Неопределено;
				
			Иначе
				
				Проверка.ТабличныйДокумент = РезультатПроверки.ТабличныйДокумент;
				
			КонецЕсли;
			
		КонецЦикла;
		
		Результат.Выполнено = Истина;
		
	КонецЕсли;
	
	Если ЭтоФоновоеЗадание Тогда
		ПоместитьВоВременноеХранилище(Результат, Адрес);
	КонецЕсли;
	
	Если Результат.Выполнено Тогда
		Комментарий = НСтр("ru='Проверки выполнены.';uk='Перевірки виконані.'",ОбщегоНазначения.КодОсновногоЯзыка());
	Иначе
		Комментарий = НСтр("ru='Требуется заполнение настроек';uk='Потрібно заповнення настройок'",ОбщегоНазначения.КодОсновногоЯзыка());
	КонецЕсли;
	ЗаписьЖурналаРегистрации(СобытиеЗавершениеЖурналаРегистрации(), УровеньЖурналаРегистрации.Информация, , , Комментарий);
	
	Возврат Результат.Выполнено;
	
КонецФункции

// Сохраняет результат проверки.
//
// Параметры:
//   Проверка - СтрокаТаблицыЗначений - строка таблицы Проверки.
//   РезультатПроверки - Структура- структура с ключами:
//     * ОбнаруженыПроблемы - Булево - обнаружены или нет проблемы.
//     * ПредставлениеРезультата - Строка - краткое представление результата.
//     * ТабличныйДокумент - ТабличныйДокумент - отчет о проверке.
//
// Возвращаемое значение:
//   СправочникСсылка.ИсторияПроверкиИКорректировкиДанныхПрисоединенныеФайлы - присоединенный файл, куда сохранен
//                                                                             табличный документ.
//
Функция ЗаписатьИсторию(Проверка, РезультатПроверки)
	
	ИсторияСсылка = Справочники["ИсторияПроверкиИКорректировкиДанных"].ПолучитьСсылку(Проверка.Идентификатор);
	
	НачатьТранзакцию();
	Попытка
	
		История = ИсторияСсылка.ПолучитьОбъект();
		Если История = Неопределено Тогда
			История = Справочники["ИсторияПроверкиИКорректировкиДанных"].СоздатьЭлемент();
			История.УстановитьСсылкуНового(ИсторияСсылка);
		КонецЕсли;
		
		Если ЗначениеЗаполнено(История.ТабличныйДокумент) Тогда
			История.ТабличныйДокумент.ПолучитьОбъект().Удалить();
		КонецЕсли;
		
		ПрисоединенныйФайл = Неопределено;
		
		Если РезультатПроверки.ТабличныйДокумент <> Неопределено Тогда
			
			ВременныйКаталог = ПолучитьИмяВременногоФайла();
			СоздатьКаталог(ВременныйКаталог);
			
			ИмяФайла = Проверка.Наименование;
			
			ИмяФайлаРезультата = ВременныйКаталог + ПолучитьРазделительПути() + ИмяФайла + ".mxl";
			РезультатПроверки.ТабличныйДокумент.Записать(ИмяФайлаРезультата);
			
			ИмяФайлаАрхива = ВременныйКаталог + ПолучитьРазделительПути() + ИмяФайла + ".zip";
			ЗаписьАрхива = Новый ЗаписьZipФайла(ИмяФайлаАрхива, , , , УровеньСжатияZIP.Максимальный);
			ЗаписьАрхива.Добавить(ИмяФайлаРезультата);
			ЗаписьАрхива.Записать();
			
			АдресФайла = ПоместитьВоВременноеХранилище(Новый ДвоичныеДанные(ИмяФайлаАрхива));
			
			УдалитьФайлы(ВременныйКаталог);
			
			ПараметрыФайла = Новый Структура;
			ПараметрыФайла.Вставить("ВладелецФайлов",              ИсторияСсылка);
			ПараметрыФайла.Вставить("Автор",                       Неопределено);
			ПараметрыФайла.Вставить("ИмяБезРасширения",            ИмяФайла);
			ПараметрыФайла.Вставить("РасширениеБезТочки",          "zip");
			ПараметрыФайла.Вставить("ВремяИзменения",              Неопределено);
			ПараметрыФайла.Вставить("ВремяИзмененияУниверсальное", Неопределено);
			
			ПрисоединенныйФайл = Модуль("РаботаСФайлами").ДобавитьФайл(ПараметрыФайла, АдресФайла);
			
		КонецЕсли;
		
		История.Наименование = Проверка.Наименование;
		История.Дата = Проверка.Дата;
		История.Пользователь = Модуль("Пользователи").ТекущийПользователь();
		История.Исправление = Проверка.Исправление;
		История.ОбнаруженыПроблемы = РезультатПроверки.ОбнаруженыПроблемы;
		История.ПредставлениеРезультата = РезультатПроверки.ПредставлениеРезультата;
		История.ТабличныйДокумент = ПрисоединенныйФайл;
		
		История.Записать();
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ЗаписьЖурналаРегистрации(СобытиеЗаписьИсторииЖурналаРегистрации(), 
			УровеньЖурналаРегистрации.Ошибка,
			,
			, 
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ВызватьИсключение;
	КонецПопытки;
	
	Возврат ПрисоединенныйФайл;
	
КонецФункции

// Шаблон текста ошибки выполнения проверки.
//
// Возвращаемое значение:
//   Строка - текст ошибки.
//
Функция ШаблонОшибкиВыполненияПроверки()
	
	Возврат НСтр("ru='Не удалось выполнить проверку по причине: %1';uk='Не вдалося виконати перевірку через: %1'",ОбщегоНазначения.КодОсновногоЯзыка());
	
КонецФункции

// Возвращает имя события запуска проверки для журнала регистрации.
//
// Возвращаемое значение:
//   Строка - имя события.
//
Функция СобытиеЗапускЖурналаРегистрации()
	
	Возврат НСтр("ru='Проверка и корректировка данных.Запуск';uk='Перевірка і коригування данних.Запуск'",ОбщегоНазначения.КодОсновногоЯзыка());
	
КонецФункции

// Возвращает имя события завершения проверки для журнала регистрации.
//
// Возвращаемое значение:
//   Строка - имя события.
//
Функция СобытиеЗавершениеЖурналаРегистрации()
	
	Возврат НСтр("ru='Проверка и корректировка данных.Завершение';uk='Перевірка і коригування данних.Завершення'",ОбщегоНазначения.КодОсновногоЯзыка());
	
КонецФункции

// Возвращает имя события запись истории для журнала регистрации.
//
// Возвращаемое значение:
//   Строка - имя события.
//
Функция СобытиеЗаписьИсторииЖурналаРегистрации()
	
	Возврат НСтр("ru='Проверка и корректировка данных.Запись истории';uk='Перевірка і коригування данних.Запіис історії'",ОбщегоНазначения.КодОсновногоЯзыка());
	
КонецФункции

// Возвращает имя события выполняемой проверки для журнала регистрации.
//
// Параметры:
//   Проверка - Строка - наименование проверки.
//
// Возвращаемое значение:
//   Строка - имя события.
//
Функция СобытиеПроверкиЖурналаРегистрации(Проверка)
	
	Возврат СтрШаблон(НСтр("ru='Проверка и корректировка данных.%1';uk='Перевірка і коригування даних.%1'",ОбщегоНазначения.КодОсновногоЯзыка()), Проверка);
	
КонецФункции

// В фоновом задании сообщает прогресс используя объект СообщениеПользователю.
//
// Параметры:
//   Текст - Строка - текст, который должен отобразиться на форме ожидания.
//
Процедура СообщитьПрогресс(Текст)
	
	СообщениеПользователю = Новый СообщениеПользователю;
	СообщениеПользователю.Текст = ИдентификаторПрогресса() + Текст;
	СообщениеПользователю.Сообщить();
	
КонецПроцедуры

#КонецОбласти
