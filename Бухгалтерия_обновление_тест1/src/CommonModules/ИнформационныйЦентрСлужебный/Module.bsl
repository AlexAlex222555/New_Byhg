////////////////////////////////////////////////////////////////////////////////
// Подсистема "Информационный центр".
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Заполняет переданный массив общими модулями, которые являются обработчиками интерфейсов
//  принимаемых сообщений.
//
// Параметры:
//  МассивОбработчиков - массив - 
//
Процедура РегистрацияИнтерфейсовПринимаемыхСообщений(МассивОбработчиков) Экспорт
	
	МассивОбработчиков.Добавить(СообщенияИнформационногоЦентраИнтерфейс);
	
КонецПроцедуры

// Заполняет структуру массивами поддерживаемых версий всех подлежащих версионированию подсистем,
// используя в качестве ключей названия подсистем.
// Обеспечивает функциональность Web-сервиса InterfaceVersion.
// При внедрении надо поменять тело процедуры так, чтобы она возвращала актуальные наборы версий (см. пример.ниже).
//
// Параметры:
// СтруктураПоддерживаемыхВерсий - Структура: 
//	- Ключи = Названия подсистем. 
//	- Значения = Массивы названий поддерживаемых версий.
//
// Пример реализации:
//
//	// СервисПередачиФайлов
//	МассивВерсий = Новый Массив;
//	МассивВерсий.Добавить("1.0.1.1");	
//	МассивВерсий.Добавить("1.0.2.1"); 
//	СтруктураПоддерживаемыхВерсий.Вставить("СервисПередачиФайлов", МассивВерсий);
//	// Конец СервисПередачиФайлов
//
Процедура ПриОпределенииПоддерживаемыхВерсийПрограммныхИнтерфейсов(Знач СтруктураПоддерживаемыхВерсий) Экспорт
	
	МассивВерсий = Новый Массив;
	МассивВерсий.Добавить("1.0.1.1");
	СтруктураПоддерживаемыхВерсий.Вставить("SupportServiceData", МассивВерсий);
	
	МассивВерсий = Новый Массив;
	МассивВерсий.Добавить("1.0.1.1");
	СтруктураПоддерживаемыхВерсий.Вставить("InformationReferences", МассивВерсий);
	
КонецПроцедуры

// Формирует список параметров ИБ.
//
// Параметры:
// ТаблицаПараметров - ТаблицаЗначений - таблица описания параметров.
// Описание состав колонок - см. РаботаВМоделиСервиса.ПолучитьТаблицуПараметровИБ().
//
Процедура ПриЗаполненииТаблицыПараметровИБ(Знач ТаблицаПараметров) Экспорт
	
    // Конференция
	РаботаВМоделиСервиса.ДобавитьКонстантуВТаблицуПараметровИБ(ТаблицаПараметров, "АдресУправленияКонференцией");

	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ИмяПользователяКонференцииИнформационногоЦентра";
	СтрокаПараметра.Описание = НСтр("ru='Имя пользователя конференции информационного центра';uk='Ім''я користувача конференції інформаційного центру'");
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
	
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ПарольПользователяКонференцииИнформационногоЦентра";
	СтрокаПараметра.Описание = НСтр("ru='Пароль пользователя конференции информационного центра';uk='Пароль користувача конференції інформаційного центру'");
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
	
	
	// Служба поддержки
	РаботаВМоделиСервиса.ДобавитьКонстантуВТаблицуПараметровИБ(ТаблицаПараметров, "АдресПрограммногоИнтерфейсаСлужбыПоддержки");
	
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ИмяПользователяПрограммногоИнтерфейсаСлужбыПоддержки";
	СтрокаПараметра.Описание = НСтр("ru='Имя пользователя программного интерфейса службы поддержки';uk='Ім''я користувача програмного інтерфейсу служби підтримки'");
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
	
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ПарольПользователяПрограммногоИнтерфейсаСлужбыПоддержки";
	СтрокаПараметра.Описание = НСтр("ru='Пароль пользователя программного интерфейса службы поддержки';uk='Пароль користувача програмного інтерфейсу служби підтримки'");
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
	
    // Центр идей
	РаботаВМоделиСервиса.ДобавитьКонстантуВТаблицуПараметровИБ(ТаблицаПараметров, "АдресСервисаЦентраИдей");
	
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ИмяПользователяСервисаЦентраИдей";
	СтрокаПараметра.Описание = НСтр("ru='Имя пользователя сервиса центра идей';uk='Ім''я користувача сервісу центру ідей'");
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
	
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ПарольПользователяСервисаЦентраИдей";
	СтрокаПараметра.Описание = НСтр("ru='Пароль пользователя сервиса центра идей';uk='Пароль користувача сервісу центру ідей'");
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
    
    // Сервис новостей
    РаботаВМоделиСервиса.ДобавитьКонстантуВТаблицуПараметровИБ(ТаблицаПараметров, "АдресСервисаНовостей");
	РаботаВМоделиСервиса.ДобавитьКонстантуВТаблицуПараметровИБ(ТаблицаПараметров, "ПрефиксСервисаДляНовостей");
    
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ИмяПользователяСервисаНовостей";
	СтрокаПараметра.Описание = НСтр("ru='Имя пользователя сервиса новостей';uk='Ім''я користувача сервісу новин'");
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
	
	СтрокаПараметра = ТаблицаПараметров.Добавить();
	СтрокаПараметра.Имя = "ПарольПользователяСервисаНовостей";
	СтрокаПараметра.Описание = НСтр("ru='Пароль пользователя сервиса новостей';uk='Пароль користувача сервісу новин'");
	СтрокаПараметра.Тип = Новый ОписаниеТипов("Строка");
    
КонецПроцедуры

// Вызывается перед попыткой записи значений параметров ИБ в одноименные
// константы.
//
// Параметры:
// ЗначенияПараметров - Структура - значения параметров которые требуется установить.
// В случае если значение параметра устанавливается в данной процедуре из структуры
// необходимо удалить соответствующую пару КлючИЗначение.
//
Процедура ПриУстановкеЗначенийПараметровИБ(Знач ЗначенияПараметров) Экспорт
	
	// Для интеграции с конференцией
	Конференция = ИнтеграцияПодсистемБТС.ИдентификаторОбъектаМетаданных("Константа.АдресУправленияКонференцией");
    ЗаписатьДанныеАутентификации(ЗначенияПараметров, Конференция, "ИмяПользователяКонференцииИнформационногоЦентра", "ПарольПользователяКонференцииИнформационногоЦентра");

    // Для интеграции со службой поддержки
	Поддержка = ИнтеграцияПодсистемБТС.ИдентификаторОбъектаМетаданных("Константа.АдресПрограммногоИнтерфейсаСлужбыПоддержки");
    ЗаписатьДанныеАутентификации(ЗначенияПараметров, Поддержка, "ИмяПользователяПрограммногоИнтерфейсаСлужбыПоддержки", "ПарольПользователяПрограммногоИнтерфейсаСлужбыПоддержки");
    
    // Для интеграции с центром идей УСП
	ЦентрИдей = ИнтеграцияПодсистемБТС.ИдентификаторОбъектаМетаданных("Константа.АдресСервисаЦентраИдей");
    ЗаписатьДанныеАутентификации(ЗначенияПараметров, ЦентрИдей, "ИмяПользователяСервисаЦентраИдей", "ПарольПользователяСервисаЦентраИдей");
    
    
    Новости = ИнтеграцияПодсистемБТС.ИдентификаторОбъектаМетаданных("Константа.АдресСервисаНовостей");
    ЗаписатьДанныеАутентификации(ЗначенияПараметров, Новости, "ИмяПользователяСервисаНовостей", "ПарольПользователяСервисаНовостей");
	
КонецПроцедуры

// Получает список обработчиков сообщений, которые обрабатывают подсистемы библиотеки.
// 
// Параметры:
//  Обработчики - ТаблицаЗначений - состав полей см. в ОбменСообщениями.НоваяТаблицаОбработчиковСообщений.
// 
Процедура ПриОпределенииОбработчиковКаналовСообщений(Обработчики) Экспорт
	
	СообщенияИнформационногоЦентраОбработчикСообщения.ПолучитьОбработчикиКаналовСообщений(Обработчики);
	
КонецПроцедуры

// Зарегистрировать обработчики поставляемых данных
//
// При получении уведомления о доступности новых общих данных, вызывается процедуры
// ДоступныНовыеДанные модулей, зарегистрированных через ПолучитьОбработчикиПоставляемыхДанных.
// В процедуру передается Дескриптор - ОбъектXDTO Descriptor.
// 
// В случае, если ДоступныНовыеДанные устанавливает аргумент Загружать в значение Истина, 
// данные загружаются, дескриптор и путь к файлу с данными передаются в процедуру 
// ОбработатьНовыеДанные. Файл будет автоматически удален после завершения процедуры.
// Если в менеджере сервиса не был указан файл - значение аргумента равно Неопределено.
//
// Параметры: 
//   Обработчики, ТаблицаЗначений - таблица для добавления обработчиков. 
//       Колонки:
//        ВидДанных, строка - код вида данных, обрабатываемый обработчиком
//        КодОбработчика, строка(20) - будет использоваться при восстановлении обработки данных после сбоя
//        Обработчик,  ОбщийМодуль - модуль, содержащий следующие процедуры:
//          ДоступныНовыеДанные(Дескриптор, Загружать) Экспорт  
//          ОбработатьНовыеДанные(Дескриптор, ПутьКФайлу) Экспорт
//          ОбработкаДанныхОтменена(Дескриптор) Экспорт
//
Процедура ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики) Экспорт
	
	ЗарегистрироватьОбработчикиПоставляемыхДанных(Обработчики);
	
КонецПроцедуры

// Заполняет массив типов, исключаемых из выгрузки и загрузки данных.
//
// Параметры:
//  Типы - Массив Из ТипЗначения 
//
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	Типы.Добавить(Метаданные.РегистрыСведений.ПросмотренныеДанныеИнформационногоЦентра);
	
КонецПроцедуры

// Добавляет в список Обработчики процедуры-обработчики обновления,
// необходимые данной подсистеме.
//
// Параметры:
//   Обработчики - ТаблицаЗначений - см. описание функции НоваяТаблицаОбработчиковОбновления
//                                   общего модуля ОбновлениеИнформационнойБазы.
// 
Процедура ЗарегистрироватьОбработчикиОбновления(Обработчики) Экспорт
	
	Если ИнтеграцияПодсистемБТС.РазделениеВключено() Тогда
		Обработчик                     = Обработчики.Добавить();
		Обработчик.Версия              = "*";
		Обработчик.МонопольныйРежим    = Ложь;
		Обработчик.ОбщиеДанные         = Истина;
		Обработчик.НачальноеЗаполнение = Истина;
		Обработчик.Процедура           = "ИнформационныйЦентрСлужебный.СформироватьСловарьПолныхПутейКФормам";
		Обработчик.Комментарий          = НСтр("ru='Сформировать словарь полных путей к формам в справочнике ""ПолныеПутиКФормам"".';uk='Сформувати словник повних шляхів до форм у довіднику ""ПолныеПутиКФормам"".'");
	Иначе
		Обработчик                     = Обработчики.Добавить();
		Обработчик.Версия              = "*";
		Обработчик.Идентификатор       = Новый УникальныйИдентификатор("f93cd97f-a84c-4a28-bda3-7c39d4fa55fd");
		Обработчик.НачальноеЗаполнение = Истина;
		Обработчик.РежимВыполнения     = "Отложенно";
		Обработчик.Процедура           = "ИнформационныйЦентрСлужебный.СформироватьСловарьПолныхПутейКФормам";
		Обработчик.Комментарий          = НСтр("ru='Сформировать словарь полных путей к формам в справочнике ""ПолныеПутиКФормам"".';uk='Сформувати словник повних шляхів до форм у довіднику ""ПолныеПутиКФормам"".'");
	КонецЕсли;
	
	Обработчик                     = Обработчики.Добавить();
	Обработчик.Версия              = "1.0.5.12";
	Обработчик.МонопольныйРежим    = Ложь;
	Обработчик.ОбщиеДанные         = Истина;
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Процедура           = "ИнформационныйЦентрСлужебный.ЗаполнитьХешПолногоПутиКФорме";
	
	Обработчик                     = Обработчики.Добавить();
	Обработчик.Версия              = "1.0.3.35";
	Обработчик.МонопольныйРежим    = Ложь;
	Обработчик.ОбщиеДанные         = Истина;
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Процедура           = "ИнформационныйЦентрСлужебный.ЗаполнитьДатуОкончанияАктуальностиИнформационныхСсылок";
	
	Обработчик                     = Обработчики.Добавить();
	Обработчик.Версия              = "1.0.7.2";
	Обработчик.МонопольныйРежим    = Ложь;
	Обработчик.ОбщиеДанные         = Истина;
	Обработчик.НачальноеЗаполнение = Истина;
	Обработчик.Процедура           = "ИнформационныйЦентрСлужебный.ЗаполнитьИнформационнуюСсылкуИзКонфигурации";
	
	Если ИнтеграцияПодсистемБТС.РазделениеВключено() Тогда
		Обработчик                  = Обработчики.Добавить();
		Обработчик.Версия           = "*";
		Обработчик.МонопольныйРежим = Ложь;
		Обработчик.ОбщиеДанные      = Истина;
		Обработчик.Процедура        = "ИнформационныйЦентрСлужебный.ОбновитьИнформационныеСсылкиДляФормВМоделиСервиса";
	Иначе
		Обработчик                  = Обработчики.Добавить();
		Обработчик.Версия           = "*";
		Обработчик.РежимВыполнения  = "Отложенно";
		Обработчик.Идентификатор    = Новый УникальныйИдентификатор("a6710034-fd9d-4f46-8ba5-e44ba86bf8fa");
		Обработчик.Процедура        = "ИнформационныйЦентрСлужебный.ОбновитьИнформационныеСсылкиДляФормВЛокальномРежиме";
		Обработчик.Комментарий      = НСтр("ru='Обновление информационных ссылок для форм.';uk='Оновлення інформаційних посилань для форм.'");
	КонецЕсли;
	
КонецПроцедуры

// Заполняет справочник "ПолныеПутиКФормам" полными путями к формам.
//
Процедура СформироватьСловарьПолныхПутейКФормам(Параметры = Неопределено) Экспорт
	
	МассивФорм = Новый Массив;
	МассивФорм.Добавить("Обработка.ИнформационныйЦентр.Форма.ИнформационныйЦентр");
	
	ИнформационныйЦентрСерверПереопределяемый.ФормыСИнформационнымиСсылками(МассивФорм);
	
	// Формирование таблицы со списком полных форм конфигурации
	ТаблицаФорм = Новый ТаблицаЗначений;
	ТаблицаФорм.Колонки.Добавить("ПолныйПутьКФорме", Новый ОписаниеТипов("Строка"));
	ТаблицаФорм.Колонки.Добавить("Хеш", Новый ОписаниеТипов("Строка"));
	
	Для Каждого ПолныйПутьКФорме Из МассивФорм Цикл
		
		НоваяСтрока = ТаблицаФорм.Добавить();
		НоваяСтрока.ПолныйПутьКФорме = ПолныйПутьКФорме;
		НоваяСтрока.Хеш = ИнформационныйЦентрСервер.ХешПолногоПутиКФорме(ПолныйПутьКФорме);
		
	КонецЦикла;
	
	// Заполнение справочника "ПолныеПутиКФормам"
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ТаблицаФорм", ТаблицаФорм);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ТаблицаФорм.ПолныйПутьКФорме КАК ПолныйПутьКФорме,
	|	ПОДСТРОКА(ТаблицаФорм.Хеш, 1, 32) КАК Хеш
	|ПОМЕСТИТЬ ТаблицаФорм
	|ИЗ
	|	&ТаблицаФорм КАК ТаблицаФорм
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Хеш
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПолныеПутиКФормам.Ссылка КАК Ссылка,
	|	ПолныеПутиКФормам.Хеш КАК Хеш
	|ПОМЕСТИТЬ СуществующиеПолныеПутиКФормам
	|ИЗ
	|	Справочник.ПолныеПутиКФормам КАК ПолныеПутиКФормам
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Хеш
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаФорм.ПолныйПутьКФорме КАК ПолныйПутьКФорме
	|ИЗ
	|	ТаблицаФорм КАК ТаблицаФорм
	|		ЛЕВОЕ СОЕДИНЕНИЕ СуществующиеПолныеПутиКФормам КАК СуществующиеПолныеПутиКФормам
	|		ПО ТаблицаФорм.Хеш = СуществующиеПолныеПутиКФормам.Хеш
	|ГДЕ
	|	СуществующиеПолныеПутиКФормам.Ссылка ЕСТЬ NULL ";
	ВыборкаФорм = Запрос.Выполнить().Выбрать();
	Пока ВыборкаФорм.Следующий() Цикл
		Если ЕстьФормаПоПолномуПути(ВыборкаФорм.ПолныйПутьКФорме) Тогда
			ДобавитьПолноеИмяВСправочник(ВыборкаФорм.ПолныйПутьКФорме);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// При обновлении конфигурации необходимо обновить список Информационных ссылок для форм.
// Это происходит через Менеджер сервиса.
//
Процедура ОбновитьИнформационныеСсылкиДляФормВМоделиСервиса() Экспорт
	
	Попытка
		
		ОбновитьИнформационныеСсылкиДляФормВЛокальномРежиме();
		
		УстановитьПривилегированныйРежим(Истина);
		ИмяКонфигурации = Метаданные.Имя;
		УстановитьПривилегированныйРежим(Ложь);
		ПроксиВебСервиса = ИнформационныйЦентрСервер.ПолучитьПроксиИнформационногоЦентра_1_0_1_1();
		Результат = ПроксиВебСервиса.UpdateInfoReference(ИмяКонфигурации);
		Если Результат Тогда 
			Возврат;
		КонецЕсли;
		
		ТекстОшибки = НСтр("ru='Не удалось обновить Информационные ссылки';uk='Не вдалося оновити Інформаційні посилання'");
		ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации();
		ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ТекстОшибки);
	Исключение
		ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации();
		ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
КонецПроцедуры

// При обновлении конфигурации необходимо обновить список Информационных ссылок для форм.
// Это происходит через Менеджер сервиса.
//
Процедура ОбновитьИнформационныеСсылкиДляФормВЛокальномРежиме(Параметры = Неопределено) Экспорт
	
	ОчиститьДублиПредопределенныхЭлементов();
	
	ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации();
	
	ОбщиеМакеты = ИнформационныйЦентрСервер.ПолучитьОбщиеМакетыИнформационныхСсылок();
	Для Каждого ОбщийМакет Из ОбщиеМакеты Цикл
		
		ПутьКФайлу = ПолучитьИмяВременногоФайла("xml");
		ТекстовыйДокумент = ОбщийМакет;
		ТекстовыйДокумент.Записать(ПутьКФайлу);
		
		Попытка
			ЗагрузитьИнформационныеСсылки(ПутьКФайлу);
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
		КонецПопытки;
		
		Попытка
			УдалитьФайлы(ПутьКФайлу);
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

// Заполняет элементы справочника "ИнформационныеСсылкиДляФорм", у которых 
// дата окончания актуальности пустая датой "31.12.3999".
//
Процедура ЗаполнитьДатуОкончанияАктуальностиИнформационныхСсылок() Экспорт 
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ДатаОкончанияАктуальности", '00010101000000');
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ИнформационныеСсылкиДляФорм.Ссылка КАК ИнформационнаяСсылка
	|ИЗ
	|	Справочник.ИнформационныеСсылкиДляФорм КАК ИнформационныеСсылкиДляФорм
	|ГДЕ
	|	ИнформационныеСсылкиДляФорм.ДатаОкончанияАктуальности = &ДатаОкончанияАктуальности
	|	И НЕ ИнформационныеСсылкиДляФорм.ПометкаУдаления";
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл 
		
		ИнформационнаяСсылка = Выборка.ИнформационнаяСсылка.ПолучитьОбъект();
		ИнформационнаяСсылка.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

// Заполняет хеш (по алгоритму MD5) полного пути к форме в справочнике "ПолныеПутиКФормам".
//
Процедура ЗаполнитьХешПолногоПутиКФорме() Экспорт
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	ПолныеПутиКФормам.Ссылка
		|ИЗ
		|	Справочник.ПолныеПутиКФормам КАК ПолныеПутиКФормам
		|ГДЕ
		|	ПолныеПутиКФормам.Хеш = &Хеш");
	Запрос.УстановитьПараметр("Хеш", "");
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл 
		ОбъектЗаписи = Выборка.Ссылка.ПолучитьОбъект();
		ОбъектЗаписи.Записать();
	КонецЦикла;
	
КонецПроцедуры

// Заполняет признак "ИзКонфигурации" для информационных ссылок.
//
Процедура ЗаполнитьИнформационнуюСсылкуИзКонфигурации() Экспорт
	
	ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации();
	ОбщиеМакеты = ИнформационныйЦентрСервер.ПолучитьОбщиеМакетыИнформационныхСсылок();
	
	Для Каждого ОбщийМакет Из ОбщиеМакеты Цикл
		
		ПутьКФайлу = ПолучитьИмяВременногоФайла("xml");
		ТекстовыйДокумент = ОбщийМакет;
		ТекстовыйДокумент.Записать(ПутьКФайлу);
		
		ПространствоИмен = ОпределитьПространствоИменПоФайлу(ПутьКФайлу);
		Если ПространствоИмен = Неопределено Тогда 
			Продолжить;
		КонецЕсли;
		
		ЧтениеИнформационныхСсылок = Новый ЧтениеXML; 
		ЧтениеИнформационныхСсылок.ОткрытьФайл(ПутьКФайлу); 
		ЧтениеИнформационныхСсылок.ПерейтиКСодержимому();
		ЧтениеИнформационныхСсылок.Прочитать();
		
		Пока ЧтениеИнформационныхСсылок.ТипУзла = ТипУзлаXML.НачалоЭлемента Цикл
			
			ТипИнформационнойСсылки = ФабрикаXDTO.Тип(ПространствоИмен, "reference");
			ИнформационнаяСсылка = ФабрикаXDTO.ПрочитатьXML(ЧтениеИнформационныхСсылок, ТипИнформационнойСсылки);
			URL = ИнформационнаяСсылка.address;
			Если ПустаяСтрока(URL) Тогда
				Продолжить;
			КонецЕсли;
			
			Запрос = Новый Запрос(
				"ВЫБРАТЬ
				|	ИнформационныеСсылкиДляФорм.Ссылка КАК ИнформационнаяСсылка
				|ИЗ
				|	Справочник.ИнформационныеСсылкиДляФорм КАК ИнформационныеСсылкиДляФорм
				|ГДЕ
				|	ИнформационныеСсылкиДляФорм.Адрес ПОДОБНО &URL");
			Запрос.УстановитьПараметр("URL", URL);
			Выборка = Запрос.Выполнить().Выбрать();
			Пока Выборка.Следующий() Цикл
				ОбъектСсылки = Выборка.ИнформационнаяСсылка.ПолучитьОбъект();
				ОбъектСсылки.ИзКонфигурации = Истина;
				ОбъектСсылки.ОбменДанными.Загрузка = Истина;
				ОбъектСсылки.Записать();
			КонецЦикла;
			
		КонецЦикла;
		
		ЧтениеИнформационныхСсылок.Закрыть();
		
		Попытка
			УдалитьФайлы(ПутьКФайлу);
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ДоступныНовыеДанные(Знач Дескриптор, Загружать, Знач ДескрипторJSON = Ложь) Экспорт
	
	Если Дескриптор.DataType = "ИнформационныеСсылки" Тогда
		
		ИмяКонфигурации = ПолучитьИмяКонфигурацииПоДескриптору(Дескриптор);
		Если ИмяКонфигурации = Неопределено Тогда 
			Загружать = Ложь;
			Возврат;
		КонецЕсли;
		
		Загружать = ?((ВРег(Метаданные.Имя)) = ВРег(ИмяКонфигурации), Истина, Ложь);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ДоступныНовыеДанныеJSON(Знач Дескриптор, Загружать) Экспорт
	
	ДоступныНовыеДанные(Дескриптор, Загружать, Истина);
	
КонецПроцедуры

Процедура ОбработатьНовыеДанные(Знач Дескриптор, Знач ПутьКФайлу, Знач ДескрипторJSON = Ложь) Экспорт
	
	Если Дескриптор.DataType = "ИнформационныеСсылки" Тогда
		ОбработатьИнформационныеСсылки(Дескриптор, ПутьКФайлу);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьНовыеДанныеJSON(Знач Дескриптор, Знач ПутьКФайлу) Экспорт
	
	ОбработатьНовыеДанные(Дескриптор, ПутьКФайлу, Истина);
	
КонецПроцедуры

// Вызывается при отмене обработки данных в случае сбоя
//
Процедура ОбработкаДанныхОтменена(Знач Дескриптор) Экспорт 
КонецПроцедуры

// См. РегламентныеЗаданияПереопределяемый.ПриОпределенииНастроекРегламентныхЗаданий.
Процедура ПриОпределенииНастроекРегламентныхЗаданий(Настройки) Экспорт
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание = Метаданные.РегламентныеЗадания.ЧтениеНовостейСлужбыПоддержки;
	Настройка.РаботаетСВнешнимиРесурсами = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Обрабатывает информационные ссылки пришедшие через механизм "Поставляемые данные".
//
// Параметры:
//  Дескриптор - Структура - дескриптор.
//  ПутьКФайлу - Строка - путь к файлу.
//
Процедура ОбработатьИнформационныеСсылки(Дескриптор, ПутьКФайлу)
	
	ЗагрузитьИнформационныеСсылки(ПутьКФайлу);
	
КонецПроцедуры

// Имя конфигурации по дескриптору.
//
// Параметры:
//  Дескриптор - Структура - дескриптор.
//
// Возвращаемое значение:
//  Строка - имя конфигурации.
//
Функция ПолучитьИмяКонфигурацииПоДескриптору(Дескриптор)
	
	Для Каждого Характеристика Из Дескриптор.Properties.Property Цикл
		Если Характеристика.Code = "ОбъектРазмещения" Тогда
			Попытка
				Возврат Характеристика.Value;
			Исключение
				ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации();
				ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
				Возврат Неопределено;
			КонецПопытки;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Загружает информационные ссылки в справочник.
//
// Параметры:
//  ПутьКФайлу - Строка - путь к файлу.
//  ЛокальныйРежим - Булево - Истина, если локальный режим, ложь - иначе.
//
Процедура ЗагрузитьИнформационныеСсылки(ПутьКФайлу, ЛокальныйРежим = Истина)
	
	// Формирование дерева тэгов
	ДеревоТэгов = ИерархияТэгов();
	
	ДатаОбновления = ТекущаяДатаСеанса();
	
	ПространствоИмен = ОпределитьПространствоИменПоФайлу(ПутьКФайлу);
	Если ПространствоИмен = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ТипИнформационнойСсылки = ФабрикаXDTO.Тип(ПространствоИмен, "reference"); 
	
	ЧтениеИнформационныхСсылок = Новый ЧтениеXML; 
	ЧтениеИнформационныхСсылок.ОткрытьФайл(ПутьКФайлу); 
	ЧтениеИнформационныхСсылок.ПерейтиКСодержимому();
	ЧтениеИнформационныхСсылок.Прочитать();
	
	Пока ЧтениеИнформационныхСсылок.ТипУзла = ТипУзлаXML.НачалоЭлемента Цикл
		
		ИнформационнаяСсылка = ФабрикаXDTO.ПрочитатьXML(ЧтениеИнформационныхСсылок, ТипИнформационнойСсылки);
		
		// Предопределенный элемент
		Если Не ПустаяСтрока(ИнформационнаяСсылка.namePredifined) Тогда 
			Попытка
				ЗаписатьПредопределеннуюИнформационнуюСсылку(ИнформационнаяСсылка, ЛокальныйРежим);
			Исключение
				ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации();
				ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			КонецПопытки;
			Продолжить;
		КонецЕсли;
		
		// Обыкновенный элемент
		Для Каждого Контекст Из ИнформационнаяСсылка.context Цикл 
			Попытка
				ЗаписатьСсылкуПоКонтекстам(ДеревоТэгов, ИнформационнаяСсылка, Контекст, ДатаОбновления, ЛокальныйРежим);
			Исключение
				ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации();
				ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			КонецПопытки;
		КонецЦикла;
		
	КонецЦикла;
	
	ЧтениеИнформационныхСсылок.Закрыть();
	
	ОчиститьНеОбновленныеСсылки(ДатаОбновления, ЛокальныйРежим);
	
КонецПроцедуры

Процедура ЗаписатьПредопределеннуюИнформационнуюСсылку(ОбъектСсылки, ЛокальныйРежим)
	
	Попытка
		ЭлементСправочника = Справочники.ИнформационныеСсылкиДляФорм[ОбъектСсылки.namePredifined].ПолучитьОбъект();
	Исключение
		ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации();
		ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка, , , ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		Возврат;
	КонецПопытки;
	ЭлементСправочника.Адрес                     = ОбъектСсылки.address;
	ЭлементСправочника.ДатаНачалаАктуальности    = ОбъектСсылки.dateFrom;
	ЭлементСправочника.ДатаОкончанияАктуальности = ОбъектСсылки.dateTo;
	ЭлементСправочника.Наименование              = ОбъектСсылки.name;
	ЭлементСправочника.Подсказка                 = ОбъектСсылки.helpText;
	ЭлементСправочника.ИзКонфигурации            = ЛокальныйРежим;
	ЭлементСправочника.Записать();
	
КонецПроцедуры

Процедура ОчиститьНеОбновленныеСсылки(ДатаОбновления, ОчиститьЛокальные)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	ИнформационныеСсылкиДляФорм.Ссылка КАК ИнформационнаяСсылка
		|ИЗ
		|	Справочник.ИнформационныеСсылкиДляФорм КАК ИнформационныеСсылкиДляФорм
		|ГДЕ
		|	ИнформационныеСсылкиДляФорм.ИзКонфигурации = &Локальная
		|	И ИнформационныеСсылкиДляФорм.ДатаОбновления <> &ДатаОбновления
		|	И НЕ ИнформационныеСсылкиДляФорм.Предопределенный");
	Запрос.УстановитьПараметр("Локальная", ОчиститьЛокальные);
	Запрос.УстановитьПараметр("ДатаОбновления", ДатаОбновления);
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл 
		
		Объект = Выборка.ИнформационнаяСсылка.ПолучитьОбъект();
		Объект.ОбменДанными.Загрузка = Истина;
		Объект.Удалить();
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаписатьСсылкуПоКонтекстам(ДеревоТэгов, ОбъектСсылки, Контекст, ДатаОбновления, ЛокальныйРежим)
	
	Результат = ПроверитьНаличиеИмениФормыПоТэгу(Контекст.tag);
	Если Результат.ЭтоПутьКФорме Тогда 
		ЗаписатьСсылкуПоКонтексту(ОбъектСсылки, Контекст, Результат.ПутьКФорме, ДатаОбновления, ЛокальныйРежим);
		Возврат;
	КонецЕсли;
	
	Тэг             = Контекст.tag;
	НайденнаяСтрока = ДеревоТэгов.Строки.Найти(Тэг, "Имя");
	Если НайденнаяСтрока = Неопределено Тогда 
		ЗаписатьСсылкуПоИдентификатору(ОбъектСсылки, Контекст, ДатаОбновления, ЛокальныйРежим);
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрокаДерева Из НайденнаяСтрока.Строки Цикл 
		
		ИмяФормы = СтрокаДерева.Имя;
		СсылкаНаПутьКФорме = СсылкаПутиКФормеВСправочнике(ИмяФормы);
		Если СсылкаНаПутьКФорме.Пустая() Тогда 
			Продолжить;
		КонецЕсли;
		
		ЗаписатьСсылкуПоКонтексту(ОбъектСсылки, Контекст, СсылкаНаПутьКФорме, ДатаОбновления, ЛокальныйРежим);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаписатьСсылкуПоИдентификатору(ОбъектСсылки, Контекст, ДатаОбновления, ЛокальныйРежим)
	
	ЭлементСправочника = Справочники.ИнформационныеСсылкиДляФорм.СоздатьЭлемент();
	ЭлементСправочника.Адрес                     = ОбъектСсылки.address;
	ЭлементСправочника.Идентификатор             = Контекст.tag;
	ЭлементСправочника.Вес                       = Контекст.weight;
	ЭлементСправочника.ДатаНачалаАктуальности    = ОбъектСсылки.dateFrom;
	ЭлементСправочника.ДатаОкончанияАктуальности = ОбъектСсылки.dateTo;
	ЭлементСправочника.Наименование              = ОбъектСсылки.name;
	ЭлементСправочника.Подсказка                 = ОбъектСсылки.helpText;
	ЭлементСправочника.ДатаОбновления            = ДатаОбновления;
	ЭлементСправочника.ИзКонфигурации            = ЛокальныйРежим;
	ЭлементСправочника.Записать();
	
КонецПроцедуры

Процедура ЗаписатьСсылкуПоКонтексту(ОбъектСсылки, Контекст, СсылкаНаПутьКФорме, ДатаОбновления, ЛокальныйРежим)
	
	Ссылка = ИмеетсяИнформационнаяСсылкаДляДаннойФормы(ОбъектСсылки.address, СсылкаНаПутьКФорме);
	
	Если Ссылка = Неопределено Тогда 
		ЭлементСправочника = Справочники.ИнформационныеСсылкиДляФорм.СоздатьЭлемент();
	Иначе
		ЭлементСправочника = Ссылка.ПолучитьОбъект();
	КонецЕсли;
	
	ЭлементСправочника.Адрес                     = ОбъектСсылки.address;
	ЭлементСправочника.Вес                       = Контекст.weight;
	ЭлементСправочника.ДатаНачалаАктуальности    = ОбъектСсылки.dateFrom;
	ЭлементСправочника.ДатаОкончанияАктуальности = ОбъектСсылки.dateTo;
	ЭлементСправочника.Наименование              = ОбъектСсылки.name;
	ЭлементСправочника.Подсказка                 = ОбъектСсылки.helpText;
	ЭлементСправочника.ПолныйПутьКФорме          = СсылкаНаПутьКФорме;
	ЭлементСправочника.ДатаОбновления            = ДатаОбновления;
	ЭлементСправочника.Записать();
	
КонецПроцедуры

Функция ИмеетсяИнформационнаяСсылкаДляДаннойФормы(Адрес, СсылкаНаПутьКФорме)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ПолныйПутьКФорме", СсылкаНаПутьКФорме);
	Запрос.УстановитьПараметр("Адрес",            Адрес);
	Запрос.Текст = "ВЫБРАТЬ
	               |	ИнформационныеСсылкиДляФорм.Ссылка КАК Ссылка
	               |ИЗ
	               |	Справочник.ИнформационныеСсылкиДляФорм КАК ИнформационныеСсылкиДляФорм
	               |ГДЕ
	               |	ИнформационныеСсылкиДляФорм.ПолныйПутьКФорме = &ПолныйПутьКФорме
	               |	И ИнформационныеСсылкиДляФорм.Адрес ПОДОБНО &Адрес";
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл 
		Возврат Выборка.Ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

Функция ПроверитьНаличиеИмениФормыПоТэгу(Тэг)
	
	Результат = Новый Структура("ЭтоПутьКФорме", Ложь);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ПолныйПутьКФорме", Тэг);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПолныеПутиКФормам.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ПолныеПутиКФормам КАК ПолныеПутиКФормам
	|ГДЕ
	|	ПолныеПутиКФормам.ПолныйПутьКФорме ПОДОБНО &ПолныйПутьКФорме";
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда 
		Возврат Результат;
	КонецЕсли;
	
	Результат.ЭтоПутьКФорме = Истина;
	ВыборкаЗапроса = РезультатЗапроса.Выбрать();
	Пока ВыборкаЗапроса.Следующий() Цикл 
		Результат.Вставить("ПутьКФорме", ВыборкаЗапроса.Ссылка);
		Возврат Результат;
	КонецЦикла;
	
КонецФункции

Процедура ДобавитьПолноеИмяВСправочник(ПолноеИмяФормы)
	
	УстановитьПривилегированныйРежим(Истина);
	ЭлементСправочника = Справочники.ПолныеПутиКФормам.СоздатьЭлемент();
	ЭлементСправочника.Наименование     = ПолноеИмяФормы;
	ЭлементСправочника.ПолныйПутьКФорме = ПолноеИмяФормы;
	ЭлементСправочника.Записать();
	
КонецПроцедуры

Функция СсылкаПутиКФормеВСправочнике(ПолноеИмяФормы)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ПолныйПутьКФорме", ПолноеИмяФормы);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПолныеПутиКФормам.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ПолныеПутиКФормам КАК ПолныеПутиКФормам
	|ГДЕ
	|	ПолныеПутиКФормам.ПолныйПутьКФорме ПОДОБНО &ПолныйПутьКФорме";
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Пока Выборка.Следующий() Цикл 
		Возврат Выборка.Ссылка;
	КонецЦикла;
	
	Возврат Справочники.ПолныеПутиКФормам.ПустаяСсылка();
	
КонецФункции

Функция ОпределитьПространствоИменПоФайлу(ПутьКФайлу)
	
	ЧтениеИнформационныхСсылок = Новый ЧтениеXML; 
	ЧтениеИнформационныхСсылок.ОткрытьФайл(ПутьКФайлу); 
	ЧтениеИнформационныхСсылок.ПерейтиКСодержимому();
	ЧтениеИнформационныхСсылок.Прочитать();
	
	Пока ЧтениеИнформационныхСсылок.ТипУзла = ТипУзлаXML.НачалоЭлемента Цикл
		
		ИнформационнаяСсылка = ФабрикаXDTO.ПрочитатьXML(ЧтениеИнформационныхСсылок);
		ЧтениеИнформационныхСсылок.Закрыть();
		
		Если ЗначениеЗаполнено(ИнформационнаяСсылка.Тип().URIПространстваИмен) Тогда
			Возврат ИнформационнаяСсылка.Тип().URIПространстваИмен;
		Иначе
			ИмяСобытия = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации() + 
			"." + НСтр("ru='Информационные ссылки';uk='Інформаційні посилання'",ОбщегоНазначения.КодОсновногоЯзыка());
			ЗаписьXML = Новый ЗаписьXML;
			ЗаписьXML.УстановитьСтроку();
			ФабрикаXDTO.ЗаписатьXML(ЗаписьXML, ИнформационнаяСсылка);
			ПредставлениеОбъекта = ЗаписьXML.Закрыть();
			ЗаписьЖурналаРегистрации(ИмяСобытия, 
				УровеньЖурналаРегистрации.Ошибка,
				,
				,
				НСтр("ru='Не удалось определить тип информационной ссылки:';uk='Не вдалося визначити тип інформаційної посилання:'") + Символы.ПС + Символы.ПС + ПредставлениеОбъекта);
			
			Возврат Неопределено;
			
		КонецЕсли;
		
	КонецЦикла;
	
	
	
КонецФункции

Процедура ЗаписатьДанныеАутентификации(ЗначенияПараметров, Владелец, ПараметрЛогин, ПараметрПароль)
	
	УстановитьПривилегированныйРежим(Истина);
    
    Если ЗначенияПараметров.Свойство(ПараметрЛогин) Тогда
		ИнтеграцияПодсистемБТС.ЗаписатьДанныеВБезопасноеХранилище(Владелец, ЗначенияПараметров[ПараметрЛогин], "Логин");
		ЗначенияПараметров.Удалить(ПараметрЛогин);
	КонецЕсли;
	
	Если ЗначенияПараметров.Свойство(ПараметрПароль) Тогда
		ИнтеграцияПодсистемБТС.ЗаписатьДанныеВБезопасноеХранилище(Владелец, ЗначенияПараметров[ПараметрПароль], "Пароль");
		ЗначенияПараметров.Удалить(ПараметрПароль);
	КонецЕсли;
    
    УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

// Возвращает: имеется ли в конфигурации форма с данным полным путем или нет.
//
// Параметры:
//  ПолныйПутьКФорме - Строка - полный путь к форме.
//  ЗаписыватьОшибкуВЖР - Булево - записывать ли в Журнал регистрации ошибку, если данного пути нет.
//
// Возвращаемое значение:
//  Булево - Истина, если форма имеется, Ложь - иначе.
//
Функция ЕстьФормаПоПолномуПути(ПолныйПутьКФорме, ЗаписыватьОшибкуВЖР = Истина)
	
	Если Метаданные.НайтиПоПолномуИмени(ПолныйПутьКФорме) <> Неопределено Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если ЗаписыватьОшибкуВЖР Тогда
		ИмяСобытияЖР = ИнформационныйЦентрСервер.ПолучитьИмяСобытияДляЖурналаРегистрации()
			+ "."
			+ НСтр("ru='Информационные ссылки';uk='Інформаційні посилання'",ИнтеграцияПодсистемБТС.КодОсновногоЯзыка());
		
		ЗаписьЖурналаРегистрации(ИмяСобытияЖР,
			УровеньЖурналаРегистрации.Ошибка,
			,
			,
			НСтр("ru='При обновлении списка форм, в конфигурации не найдена в форма с полным путем:';uk='При оновленні списку форм, в конфігурації не знайдена форма з повним шляхом:'",ИнтеграцияПодсистемБТС.КодОсновногоЯзыка())
				+ ПолныйПутьКФорме);
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

Процедура ОчиститьДублиПредопределенныхЭлементов()
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
		|	ИнформационныеСсылкиДляФорм.Ссылка КАК ИнформационнаяСсылка
		|ИЗ
		|	Справочник.ИнформационныеСсылкиДляФорм КАК ИнформационныеСсылкиДляФорм
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ИнформационныеСсылкиДляФорм КАК ИнформационныеСсылкиДляФорм1
		|		ПО ИнформационныеСсылкиДляФорм.ИмяПредопределенныхДанных = ИнформационныеСсылкиДляФорм1.ИмяПредопределенныхДанных
		|			И ИнформационныеСсылкиДляФорм.Ссылка < ИнформационныеСсылкиДляФорм1.Ссылка
		|ГДЕ
		|	НЕ ИнформационныеСсылкиДляФорм.ПометкаУдаления
		|	И НЕ ИнформационныеСсылкиДляФорм1.ПометкаУдаления
		|	И ИнформационныеСсылкиДляФорм.ИмяПредопределенныхДанных <> """"
		|	И ИнформационныеСсылкиДляФорм1.ИмяПредопределенныхДанных <> """"");
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		ИнформационнаяСсылка = Выборка.ИнформационнаяСсылка.ПолучитьОбъект();
		ИнформационнаяСсылка.ИмяПредопределенныхДанных = "";
		ИнформационнаяСсылка.ПометкаУдаления = Истина;
		ИнформационнаяСсылка.ОбменДанными.Загрузка = Истина;
		ИнформационнаяСсылка.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

// Регистрирует обработчики поставляемых данных за день и за все время
//
Процедура ЗарегистрироватьОбработчикиПоставляемыхДанных(Знач Обработчики)
	
	Обработчик                = Обработчики.Добавить();
	Обработчик.ВидДанных      = "ИнформационныеСсылки";
	Обработчик.КодОбработчика = "ИнформационныеСсылки";
	Обработчик.Обработчик     = ИнформационныйЦентрСлужебный;
	
КонецПроцедуры

Функция ИерархияТэгов()
	
	ДеревоТэгов = Новый ДеревоЗначений;
	ДеревоТэгов.Колонки.Добавить("Имя", Новый ОписаниеТипов("Строка"));
	
	// Чтение общего макета
	СодержимоеМакета = ПолучитьОбщийМакет("СоответствиеТэговОбщимФормам").ПолучитьТекст();
	
	ЗаписиСоответствияТэговИФорм = Новый ЧтениеXML;
	ЗаписиСоответствияТэговИФорм.УстановитьСтроку(СодержимоеМакета);
	
	ТекущийТэгВДереве = Неопределено;
	Пока ЗаписиСоответствияТэговИФорм.Прочитать() Цикл
		// Чтение текущего тэга
		ЭтоТэг = ЗаписиСоответствияТэговИФорм.ТипУзла = ТипУзлаXML.НачалоЭлемента И ВРег(СокрЛП(ЗаписиСоответствияТэговИФорм.Имя)) = ВРег("tag");
		Если ЭтоТэг Тогда 
			Пока ЗаписиСоответствияТэговИФорм.ПрочитатьАтрибут() Цикл 
				Если ВРег(ЗаписиСоответствияТэговИФорм.Имя) = ВРег("name") Тогда
					ТекущийТэгВДереве     = ДеревоТэгов.Строки.Добавить();
					ТекущийТэгВДереве.Имя = ЗаписиСоответствияТэговИФорм.Значение;
					Прервать;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		// Чтение формы
		ЭтоФорма = ЗаписиСоответствияТэговИФорм.ТипУзла = ТипУзлаXML.НачалоЭлемента И ВРег(СокрЛП(ЗаписиСоответствияТэговИФорм.Имя)) = ВРег("form");
		Если ЭтоФорма Тогда 
			Пока ЗаписиСоответствияТэговИФорм.ПрочитатьАтрибут() Цикл 
				Если ВРег(ЗаписиСоответствияТэговИФорм.Имя) = ВРег("path") Тогда
					Если ТекущийТэгВДереве = Неопределено Тогда 
						Прервать;
					КонецЕсли;
					ТекущийЭлементДерева     = ТекущийТэгВДереве.Строки.Добавить();
					ТекущийЭлементДерева.Имя = ЗаписиСоответствияТэговИФорм.Значение;
					Прервать;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	Возврат ДеревоТэгов;
	
КонецФункции

#КонецОбласти
