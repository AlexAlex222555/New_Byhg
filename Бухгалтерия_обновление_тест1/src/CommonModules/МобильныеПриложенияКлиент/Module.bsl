
#Область ПрограммныйИнтерфейс

// Выполняет подключение внешней компоненты MAppDataExch для обмена данными с мобильными приложениями.
//
Процедура ПодключитьВнешнююКомпонентуДляОбменаДаннымиСМобильнымиПриложениями() Экспорт

	Оповещение = Новый ОписаниеОповещения("ПодключитьКомпонентуЗавершение", ЭтотОбъект);
	
	ПараметрыПодключения = ОбщегоНазначенияКлиент.ПараметрыПодключенияКомпоненты();
	
	ОбщегоНазначенияКлиент.ПодключитьКомпонентуИзМакета(Оповещение, 
		"MAppDataExchange",
	    "ОбщийМакет.КомпонентаОбменДаннымиСМобильнымиПриложениями",
	    ПараметрыПодключения);

КонецПроцедуры

Процедура ПодключитьКомпонентуЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат.Подключено Тогда
		
		Сообщение = НСтр("ru='Компонента подключена.';uk='Компонента підключена.'");
		Картинка = БиблиотекаКартинок.Информация32;
	
		Попытка
			глКомпонентаОбменаСМобильнымиПриложениями = Результат.ПодключаемыйМодуль;
			УстановитьНастройкиПользователяПриРаботеСКомпонентойОбменаДанными();
		Исключение
			глКомпонентаОбменаСМобильнымиПриложениями = Неопределено;
			Сообщение = НСтр("ru='при подключении возникли ошибки.';uk='при підключенні виникли помилки.'");
			Картинка = БиблиотекаКартинок.Ошибка32;
		КонецПопытки;
	Иначе
		глКомпонентаОбменаСМобильнымиПриложениями = Неопределено;
		Сообщение = НСтр("ru='при подключении возникли ошибки.';uk='при підключенні виникли помилки.'");
		Картинка = БиблиотекаКартинок.Ошибка32;
	КонецЕсли;
	
	ЗаголовокСообщения = НСтр("ru='Подключение компоненты:';uk='Підключення компоненти:'");
	ПоказатьОповещениеПользователя(ЗаголовокСообщения,,Сообщение, Картинка);
	
	Оповестить("ПодключениеКомпонентыОбменаДаннымиСМобильнымиПриложениями");

КонецПроцедуры

// Выполняет обработку внешнего события, полученного от мобильного приложения
//
// Параметры:
//  Источник - Строка - строка, описывающая источник
//  Событие - Строка - строка,  идентифицирующая конкретное событие
//	Данные - Строка - данные, полученные в рамках события.
//
Процедура ОбработатьВнешнееСобытиеОтМобильногоПриложения(Источник, Событие, Данные) Экспорт
	
	СтруктураИсточникаСобытия = ОписаниеИсточникаСобытия(Источник);
	
	КодМобильногоКомпьютера = СтруктураИсточникаСобытия.КодМобильногоКомпьютера;
	ИдентификаторМобильнойБазы = СтруктураИсточникаСобытия.ИдентификаторМобильнойБазы;
	ИмяПользователя = СтруктураИсточникаСобытия.ИмяПользователя;
	ПарольПользователя = СтруктураИсточникаСобытия.ПарольПользователя;
	
	ПараметрыОбменаДанными = Данные;
	
	// Сначала проверяется, определены ли настройки для указанного устройства и пользователя.
	Если НЕ МобильныеПриложенияВызовСервера.АутентификацияВыполнена(ИмяПользователя, КодМобильногоКомпьютера, ПарольПользователя) Тогда
		ТекстСообщения = НСтр("ru='Для пользователя не определены настройки в системе';uk='Для користувача не визначені настройки в системі'");
		Попытка
			глКомпонентаОбменаСМобильнымиПриложениями.СообщитьКлиентуОбОшибке(КодМобильногоКомпьютера, ТекстСообщения);
			Возврат;
		Исключение
			ИмяСобытия = НСтр("ru='Ошибка при вызове метода компоненты обмена данными';uk='Помилка при виклику методу компоненти обміну даними'");
			ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытия,"Ошибка",ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()),,Истина);
			Возврат;
		КонецПопытки;
	КонецЕсли;
	
	Если Событие = "ПолучитьПриложение" Тогда
		
		ПриложениеСтрокой = МобильныеПриложенияВызовСервера.ПолучитьПриложение(ИмяПользователя, КодМобильногоКомпьютера, ПараметрыОбменаДанными);
		Попытка
			глКомпонентаОбменаСМобильнымиПриложениями.УстановитьПриложение(КодМобильногоКомпьютера, ПриложениеСтрокой);
		Исключение
			ИмяСобытия = НСтр("ru='Ошибка при вызове метода компоненты обмена данными';uk='Помилка при виклику методу компоненти обміну даними'");
			ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытия,"Ошибка",ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()),,Истина);
			Возврат;
		КонецПопытки;
			
	ИначеЕсли Событие = "ПолучитьДанные" Тогда
		
		Попытка
			НачальнаяИнициализацияИБ = глКомпонентаОбменаСМобильнымиПриложениями.ПолучитьРежимНачальнойИнициализации(КодМобильногоКомпьютера);
		Исключение
			ИмяСобытия = НСтр("ru='Ошибка при вызове метода компоненты обмена данными';uk='Помилка при виклику методу компоненти обміну даними'");
			ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытия,"Ошибка",ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()),,Истина);
			Возврат;
		КонецПопытки;
		
		ДанныеДляОбмена = МобильныеПриложенияВызовСервера.ПолучитьДанные(ИмяПользователя, КодМобильногоКомпьютера, НачальнаяИнициализацияИБ, ПараметрыОбменаДанными);
		
		Попытка
			глКомпонентаОбменаСМобильнымиПриложениями.ПередатьДанныеКлиенту(КодМобильногоКомпьютера, ДанныеДляОбмена);
		Исключение
			ИмяСобытия = НСтр("ru='Ошибка при вызове метода компоненты обмена данными';uk='Помилка при виклику методу компоненти обміну даними'");
			ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытия,"Ошибка",ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()),,Истина);
			Возврат;
		КонецПопытки;
		
	ИначеЕсли Событие = "ЗаписатьДанные" Тогда
		
		Попытка
			ДанныеМобильногоПриложения = глКомпонентаОбменаСМобильнымиПриложениями.ПолучитьДанныеКлиента(КодМобильногоКомпьютера);
		Исключение
			ИмяСобытия = НСтр("ru='Ошибка при вызове метода компоненты обмена данными';uk='Помилка при виклику методу компоненти обміну даними'");
			ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытия,"Ошибка",ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()),,Истина);
			Возврат;
		КонецПопытки;
		
		Попытка
			МобильныеПриложенияВызовСервера.ЗаписатьДанные(ИмяПользователя, КодМобильногоКомпьютера, ДанныеМобильногоПриложения, ПараметрыОбменаДанными);
		Исключение
			ТекстСообщения = ИнформацияОбОшибке().Описание;
			Попытка
				глКомпонентаОбменаСМобильнымиПриложениями.СообщитьКлиентуОбОшибке(КодМобильногоКомпьютера, ТекстСообщения);
				Возврат;
			Исключение
				ИмяСобытия = НСтр("ru='Ошибка при вызове метода компоненты обмена данными';uk='Помилка при виклику методу компоненти обміну даними'");
				ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытия,"Ошибка",ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()),,Истина);			
				Возврат;
			КонецПопытки;
			ИмяСобытия = НСтр("ru='Ошибка при записи данных, полученных от мобильного приложения';uk='Помилка при записі даних, отриманих від мобільного додатка'");
			ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытия,"Ошибка",ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()),,Истина);
		КонецПопытки;
		
	ИначеЕсли Событие = "ПодтвердитьЗавершениеСеанса" Тогда
		
		Попытка
			МобильныеПриложенияВызовСервера.ЗарегистрироватьПолучениеДанных(ИмяПользователя, КодМобильногоКомпьютера, ПараметрыОбменаДанными);
		Исключение
			ИмяСобытия = НСтр("ru='Ошибка при регистрации получения данных от мобильного приложения';uk='Помилка при реєстрації отримання даних від мобільного додатка'");
			ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(ИмяСобытия,"Ошибка",ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()),,Истина);
			Возврат;
		КонецПопытки;
		
	КонецЕсли;
	
КонецПроцедуры

// Выполняет необходимые действия, связанные с мобильными приложениями, при старте системы.
//
Процедура ПриНачалеРаботыСистемы() Экспорт
	
	Если СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске().ПодключатьКомпонентуОбменаДаннымиПриСтартеСистемы Тогда
		ПодключитьВнешнююКомпонентуДляОбменаДаннымиСМобильнымиПриложениями();
	КонецЕсли;
	
КонецПроцедуры

// Устанавливает компоненте обмена данными настройки, определенные для текущего пользователя.
//
Процедура УстановитьНастройкиПользователяПриРаботеСКомпонентойОбменаДанными() Экспорт
	
	СписокНастроек = МобильныеПриложенияВызовСервера.ПолучитьНастройкиРаботыПользователяСКомпонентойОбменаДанными();
	
	ИспользоватьTCPIP = Ложь;
	ИспользоватьIRDA = Ложь;
	ИспользоватьCOMПорт = Ложь;
	
	ПортTCPIP = 2002;
	ИмяСервисаIRDA = "S1C8";
	COMПорт = 1;
	
	ВестиЖурналСобытий = Ложь;
	КаталогЖурналаСобытий = "";
	
	Для Каждого Настройка Из СписокНастроек Цикл
		Если Настройка.Представление = "ИспользоватьTCPIP" Тогда
			ИспользоватьTCPIP = Настройка.Значение;
		ИначеЕсли Настройка.Представление = "ИспользоватьIRDA" Тогда
			ИспользоватьIRDA = Настройка.Значение;
		ИначеЕсли Настройка.Представление = "ИспользоватьCOMПорт" Тогда
			ИспользоватьCOMПорт = Настройка.Значение;
		ИначеЕсли Настройка.Представление = "ПортTCPIP" Тогда
			ПортTCPIP = Настройка.Значение;
		ИначеЕсли Настройка.Представление = "ИмяСервисаIRDA" Тогда
			ИмяСервисаIRDA = Настройка.Значение;
		ИначеЕсли Настройка.Представление = "COMПорт" Тогда
			COMПорт = Настройка.Значение;
		ИначеЕсли Настройка.Представление = "ВестиЖурналСобытий" Тогда
			ВестиЖурналСобытий = Настройка.Значение;
		ИначеЕсли Настройка.Представление = "КаталогЖурналаСобытий" Тогда
			КаталогЖурналаСобытий = Настройка.Значение;
		КонецЕсли;
	КонецЦикла;
	
	Если ИспользоватьTCPIP Тогда
		глКомпонентаОбменаСМобильнымиПриложениями.ПодключитьTCPIP(ПортTCPIP);
	КонецЕсли;
	
	Если ИспользоватьIRDA Тогда
		глКомпонентаОбменаСМобильнымиПриложениями.ПодключитьIRDA(ИмяСервисаIRDA);
	КонецЕсли;
	
	Если ИспользоватьCOMПорт Тогда
		глКомпонентаОбменаСМобильнымиПриложениями.ПодключитьCOMПорт(COMПорт);
	КонецЕсли;
	
	Если ВестиЖурналСобытий Тогда
		глКомпонентаОбменаСМобильнымиПриложениями.КаталогЖурналаСобытий = КаталогЖурналаСобытий;
		глКомпонентаОбменаСМобильнымиПриложениями.ВестиЖурналСобытий = ВестиЖурналСобытий;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Формирует и возвращает структуру, содержащую информацию об инициаторе обмена
//
// Параметры:
//  Источник - строка с разделителями, содержащая информацию об источнике.
//
// Возвращаемое значение:
//  Структура, содержащая информацию об инициаторе обмена.
//
Функция ОписаниеИсточникаСобытия(Источник)
	
	СтруктураИсточника = Новый Структура();
	СтруктураИсточника.Вставить("КодМобильногоКомпьютера", СтрЗаменить(СтрПолучитьСтроку(Источник,2), Символы.ПС, ""));
	СтруктураИсточника.Вставить("ИдентификаторМобильнойБазы", СтрЗаменить(СтрПолучитьСтроку(Источник,3), Символы.ПС, ""));
	СтруктураИсточника.Вставить("ИмяПользователя", СтрЗаменить(СтрПолучитьСтроку(Источник,4), Символы.ПС, ""));
	СтруктураИсточника.Вставить("ПарольПользователя", СтрЗаменить(СтрПолучитьСтроку(Источник,5), Символы.ПС, ""));
		
	Возврат СтруктураИсточника;
	
КонецФункции

#КонецОбласти
