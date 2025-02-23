//Список доступных для конфигурации регистров с нормативной информацией
//
Функция СписокДоступныхРегистров() Экспорт
	
    Список = Новый СписокЗначений();
	Список.Добавить("МинимальнаяОплатаТруда", "ru = 'Минимальная оплата труда';uk= 'Мінімальна оплата праці'", Истина);
//++ НЕ БЗК
	Список.Добавить("НастройкиЗаконодательныхИзменений", "ru = 'Настройки законодательных изменений';uk= 'Настройки законодавчих змін'", Истина);
//-- НЕ БЗК
	
//++ НЕ УТ	
	Список.Добавить("ИндексИнфляции", "ru = 'Индекс инфляции';uk= 'Індекс інфляції'", Истина);
    Список.Добавить("ПределыДоходовНДФЛ", "ru = 'Пределы доходов НДФЛ';uk= 'Межі доходів ПДФО'", Истина);
	Список.Добавить("ПределыСтраховыхВзносов", "ru = 'Пределы страховых взносов';uk= 'Межі страхових внесків'", Истина);
	Список.Добавить("ПрожиточныеМинимумы", "ru = 'Прожиточные минимумы';uk= 'Прожиткові мінімуми'", Истина);
	Список.Добавить("РазмерыЛьготНДФЛ", "ru = 'Размеры льгот НДФЛ';uk= 'Розміри пільг ПДФО'", Истина);
	Список.Добавить("СтавкиНДФЛ", "ru = 'Ставки НДФЛ';uk= 'Ставки ПДФО'", Истина);
	Список.Добавить("ШкалаСтавокНалогов", "ru = 'Шкала ставок налогов';uk= 'Шкала ставок податків'", Истина);
//-- НЕ УТ

	Возврат Список;
	
КонецФункции

//Список доступных для конфигурации классификаторов
//
Функция СписокДоступныхКлассификаторов() Экспорт
	
	Список = Новый СписокЗначений();
	
	Список.Добавить("КлассификаторБанков", "ru = 'Классификатор банков';uk= 'Класифікатор банків'", Истина);
//++ НЕ УТ	
	Список.Добавить("КлассификаторПрофессий", "ru = 'Классификатор профессий';uk= 'Класифікатор професій'", Истина);
//-- НЕ УТ	
//++ НЕ БЗК
	Список.Добавить("КлассификаторКОАТУУ", "ru = 'Классификатор КОАТУУ';uk= 'Класифікатор КОАТУУ'", Истина);
	Список.Добавить("КлассификаторУКТВЭД", "ru = 'Классификатор УКТВЭД';uk= 'Класифікатор УКТЗЕД'", Истина);
	Список.Добавить("КлассификаторДКПП", "ru = 'Классификатор ДКПП';uk= 'Класифікатор ДКПП'", Истина);
//-- НЕ БЗК	
//++ НЕ УТ	
	Список.Добавить("ОснованияУвольненияПоКЗОТ", "ru = 'Основания увольнения по КЗОТ';uk= 'Підстави звільнення за КЗПП'", Истина);
    Список.Добавить("ОснованияСпециальногоСтажа", "ru = 'Основания специального стажа';uk= 'Підстави спеціального стажу'", Истина);
//-- НЕ УТ	
	Возврат Список;
	
КонецФункции

//Список доступных для конфигурации разделов новостей
//
Функция СписокДоступныхНовостей() Экспорт
	
	Список = Новый СписокЗначений();
	
	Список.Добавить("НовостиСервиса", "ru = 'Новости сервиса';uk= 'Новини сервісу'", Истина);
	Список.Добавить("ИТССправочники", "ru = 'Новости ИТС: обновления справочников';uk= 'Новини ІТС: оновлення довідників'", Истина);
	Список.Добавить("ИТССервисы", "ru = 'Новости ИТС: информация о сервисах';uk= 'Новини ІТС: інформація про сервіси'", Истина);
	Список.Добавить("ИТСРелизы", "ru = 'Новости ИТС: информация о выходе новых релизов';uk= 'Новини ІТС: інформація про вихід нових релізів'", Истина);

	Возврат Список;
	
КонецФункции

//Соответствие доступных для конфигурации классификаторов и макетов конфигурации.
//Используется для актуализации
//
Функция СоответствиеКлассификаторовИМакетов() Экспорт
	
	Результат = Новый Соответствие();
	
	Результат.Вставить("КлассификаторБанков", Справочники.КлассификаторБанков.ПолучитьМакет("КлассификаторБанков"));
//++ НЕ УТ	
	Результат.Вставить("КлассификаторПрофессий", Справочники.Должности.ПолучитьМакет("КлассификаторПрофессий"));
//-- НЕ УТ	
//++ НЕ БЗК
	Результат.Вставить("КлассификаторКОАТУУ", Справочники.КлассификаторКОАТУУ.ПолучитьМакет("КлассификаторКОАТУУ"));
	Результат.Вставить("КлассификаторУКТВЭД", Справочники.КлассификаторУКТВЭД.ПолучитьМакет("КлассификаторУКТВЭД"));
	Результат.Вставить("КлассификаторДКПП", Справочники.КлассификаторУКТВЭД.ПолучитьМакет("КлассификаторДКПП"));
//-- НЕ БЗК	
//++ НЕ УТ	
	Результат.Вставить("ОснованияУвольненияПоКЗОТ", Справочники.ОснованияУвольнения.ПолучитьМакет("ОснованияУвольненияПоКЗОТ"));
	Результат.Вставить("ОснованияУвольненияПоКЗОТ", Справочники.ОснованияСпециальногоСтажа.ПолучитьМакет("Классификатор"));
//-- НЕ УТ	
	Возврат Результат;
	
КонецФункции

//Полуает параметры конфигурации - имя и редакцию
//
Функция ПолучитьПараметрыКонфигурации() Экспорт
	
	Результат = Новый Структура("ИмяКонфигурации, Редакция", "", "");
	
	Результат.ИмяКонфигурации = ОбщегоНазначения.ИдентификаторИнтернетПоддержкиКонфигурации();
	Результат.Редакция = ОбщегоНазначения.РедакцияКонфигурации();
	
	Возврат Результат;
	
КонецФункции

//Получает параметры авторизации
//
Функция ПолучитьПараметрыАвторизации() Экспорт

	УстановитьПривилегированныйРежим(Истина);
	
	Если ОбщегоНазначения.РазделениеВключено() И ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Результат = Новый Структура("АвторизацияЧерезТикет, Авторизация, ИмяПользователя, Пароль", Ложь, Неопределено, "", "");
		Настройки = НСИССервер.ПолучитьНастройкиЗагрузок();
		Если Настройки.УчетныеДанные <> Неопределено Тогда
			УчетныеДанные = Настройки.УчетныеДанные.Получить();
			Если УчетныеДанные <> Неопределено Тогда
	        	Результат = Новый Структура("АвторизацияЧерезТикет, Авторизация, ИмяПользователя, Пароль", Ложь, Неопределено, УчетныеДанные.Логин, УчетныеДанные.Пароль);
			КонецЕсли;
		КонецЕсли;	
	Иначе
		Результат = Новый Структура("АвторизацияЧерезТикет, Авторизация, ИмяПользователя, Пароль", Истина, Неопределено, "", "");
		Результат.Авторизация = ИнтернетПоддержкаПользователей.ТикетАутентификацииНаПорталеПоддержки(НСИССервер.ИмяСервиса());
	КонецЕсли;	
		
	Возврат Результат;
	
КонецФункции

Функция ПроверкаПередПодключением(ВФоне) Экспорт
	
	Если ОбщегоНазначения.РазделениеВключено() И ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		ПараметрыАвторизации = ПолучитьПараметрыАвторизации();
		Если ЗначениеЗаполнено(ПараметрыАвторизации.ИмяПользователя) Тогда
			Возврат Истина;
		Иначе
			НСИССервер.ВыводСообщения(НСтр("ru='Не подключена интернет-поддержка, обратитесь к администратору';uk= 'Не підключена інтернет-підтримка, зверніться до адміністратора'"), ВФоне, УровеньЖурналарегистрации.Ошибка);
			Возврат Неопределено;
		КонецЕсли;	
	Иначе	
		ИнтернетПоддержкаПодключена =
			ИнтернетПоддержкаПользователей.ЗаполненыДанныеАутентификацииПользователяИнтернетПоддержки();
		Если ИнтернетПоддержкаПодключена Тогда
			Возврат Истина;
		Иначе
			// Если Интернет-поддержка не подключена.
			Если ИнтернетПоддержкаПользователей.ДоступноПодключениеИнтернетПоддержки() Тогда
				// Есть право подключения Интернет-поддержки
				НСИССервер.ВыводСообщения(НСтр("ru='Не подключена интернет-поддержка';uk= 'Не підключена інтернет-підтримка'"), ВФоне, УровеньЖурналарегистрации.Ошибка);
				Возврат Неопределено;
			Иначе
				// Нет права подключения Интернет-поддержки
				НСИССервер.ВыводСообщения(НСтр("ru='Не подключена интернет-поддержка, обратитесь к администратору';uk= 'Не підключена інтернет-підтримка, зверніться до адміністратора'"), ВФоне, УровеньЖурналарегистрации.Ошибка);
				Возврат Неопределено;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;	
	
КонецФункции

//Из справочника валют получаем список обновляемых через интернет 
//
Функция ПолучитьНастройкиВалют() Экспорт
	
	СписокВалют = Новый Массив(); 
	
	Запрос = Новый Запрос();
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	Валюты.Код КАК Код
	               |ИЗ
	               |	Справочник.Валюты КАК Валюты
	               |ГДЕ
	               |	Валюты.СпособУстановкиКурса = ЗНАЧЕНИЕ(Перечисление.СпособыУстановкиКурсаВалюты.ЗагрузкаИзИнтернета)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СписокВалют.Добавить(Число(Выборка.Код));
	КонецЦикла;	
	
	Возврат СписокВалют;

КонецФункции

//Набор настроек по умолчанию
Функция ПолучитьНастройкиПоУмолчанию() Экспорт
	
	Результат = Новый Структура("ЗагружатьНормативныеВеличины, ЗагружатьКурсыВалют, ЗагружатьКлассификаторы, ЗагружатьНовости, ЗагружатьКалендарь, ОткрыватьИнформациюПриСтарте, ЗагружатьДанныеПриСтарте, КоличествоНовостей, УчетныеДанные", Истина, Истина, Истина, Истина, Истина, Ложь, Ложь, 20, Неопределено);
	
	Возврат Результат;
	
КонецФункции	
