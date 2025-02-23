///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "Работа в модели сервиса.Базовая функциональность БИП".
// ОбщийМодуль.ИнтернетПоддержкаПользователейВМоделиСервиса.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает тикет аутентификации пользователя на портале поддержки
// при работе в модели сервиса в неразделенном сеансе.
// Возвращенный тикет может быть проверен вызовом операции checkTicket()
// сервиса https://login.bas-soft.eu/api/public/ticket?wsdl
//
// Параметры:
//	ВладелецТикета - Строка - произвольное имя сервиса, для которого
//		выполняется аутентификация пользователя. Это же имя должно
//		использоваться при вызове операции checkTicket();
//		Не допускается незаполненное значение параметра;
//	ОбластьДанных - Число - номер области данных (абонент), для которой
//		выполняется получение тикета.
//
// Возвращаемое значение:
//	Структура - результат получения тикета. Поля структуры:
//		* Тикет - Строка - полученный тикет аутентификации. Если при получении
//			тикета произошла ошибка, значение поля - пустая строка.
//		* КодОшибки - Строка - строковый код возникшей ошибки, который
//			может быть обработан вызывающим функционалом:
//				- <Пустая строка> - получение тикета выполнено успешно;
//				- "ОшибкаПодключения" - ошибка при подключении к сервису;
//				- "ОшибкаСервиса" - внутренняя ошибка сервиса;
//				- "НеизвестнаяОшибка" - при получении тикета возникла
//					неизвестная (необрабатываемая) ошибка;
//		* СообщениеОбОшибке - Строка - краткое описание ошибки, которое
//			может быть отображено пользователю;
//		* ИнформацияОбОшибке - Строка - подробное описание ошибки, которое
//			может быть записано в журнал регистрации.
//
Функция ТикетАутентификацииНаПорталеПоддержкиВНеразделенномСеансе(ВладелецТикета, ОбластьДанных) Экспорт
	
	Если ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		ВызватьИсключение НСтр("ru='Получение тикета недоступно в разделенном сеансе.';uk='Отримання тікета недоступне в розділеному сеансі.'");
	КонецЕсли;
	
	Результат = ТикетАутентификацииНаПорталеПоддержки(ВладелецТикета, ОбластьДанных);
	
	Если Результат.КодОшибки = "ОперацияНеПоддерживается" Тогда
		// Для внешней функциональности ошибка
		// интерпретируется как "Ошибка подключения к сервису".
		Результат.КодОшибки = "ОшибкаПодключения";
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ТикетАутентификацииНаПорталеПоддержки(ВладелецТикета, ОбластьДанных = Неопределено) Экспорт
	
	Если Не ОбщегоНазначения.РазделениеВключено() Тогда
		ВызватьИсключение НСтр("ru='Недоступно при работе в локальном режиме.';uk='Недоступно при роботі в локальному режимі.'");
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ВладелецТикета) Тогда
		ВызватьИсключение НСтр("ru='Не заполнено значение параметра ""ВладелецТикета""';uk='Не заповнено значення параметра ""ВладелецТикета""'");
	КонецЕсли;
	
	Если ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		ЗначениеРазделителя = РаботаВМоделиСервисаБИП.ЗначениеРазделителяСеанса();
	ИначеЕсли ОбластьДанных = Неопределено Тогда
		ВызватьИсключение НСтр("ru='Не заполнено значение параметра ""ОбластьДанных""';uk='Не заповнено значення параметра ""ОбластьДанных""'");
	Иначе
		// В неразделенном сеансе используется переданное
		// значение параметра ОбластьДанных.
		ЗначениеРазделителя = ОбластьДанных;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("КодОшибки"         , "");
	Результат.Вставить("СообщениеОбОшибке" , "");
	Результат.Вставить("ИнформацияОбОшибке", "");
	Результат.Вставить("Тикет"             , "");
	Результат.Вставить("СлужебныеПараметры", "");
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		ИдентификаторПользователя = Неопределено;
	Иначе
		ТекущийПользователь = Пользователи.АвторизованныйПользователь();
		ИдентификаторПользователя =
			ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
				ТекущийПользователь,
				"ИдентификаторПользователяСервиса");
	КонецЕсли;
	
	ЗаписьТела = Новый ЗаписьJSON;
	ЗаписьТела.УстановитьСтроку();
	ЗаписьТела.ЗаписатьНачалоОбъекта();

	ЗаписьТела.ЗаписатьИмяСвойства("zone");
	ЗаписьТела.ЗаписатьЗначение(ЗначениеРазделителя);
	
	КлючОбласти = КлючОбластиДанных(ЗначениеРазделителя);
	Если ЗначениеЗаполнено(КлючОбласти) Тогда
		ЗаписьТела.ЗаписатьИмяСвойства("zoneKey");
		ЗаписьТела.ЗаписатьЗначение(КлючОбласти);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИдентификаторПользователя) Тогда
		ЗаписьТела.ЗаписатьИмяСвойства("userGUID");
		ЗаписьТела.ЗаписатьЗначение(Строка(ИдентификаторПользователя));
	КонецЕсли;
	
	ЗаписьТела.ЗаписатьИмяСвойства("openUrl");
	ЗаписьТела.ЗаписатьЗначение(Строка(ВладелецТикета));
	
	ЗаписьТела.ЗаписатьКонецОбъекта();
	ТелоЗапроса = ЗаписьТела.Закрыть();
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Content-Type", "application/json");
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Метод"                   , "POST");
	ДополнительныеПараметры.Вставить("Заголовки"               , Заголовки);
	ДополнительныеПараметры.Вставить("ДанныеДляОбработки"      , ТелоЗапроса);
	ДополнительныеПараметры.Вставить("ФорматДанныхДляОбработки", 1);
	ДополнительныеПараметры.Вставить("ФорматОтвета"            , 1);
	ДополнительныеПараметры.Вставить("Таймаут"                 , 30);
	
	НастройкиПодключения = НастройкиПодключенияКМенеджеруСервиса();
	URLСервиса = НастройкиПодключения.URL + "/hs/tickets/";
	
	РезультатОперации = ИнтернетПоддержкаПользователей.ЗагрузитьСодержимоеИзИнтернет(
		URLСервиса,
		НастройкиПодключения.ИмяСлужебногоПользователя,
		НастройкиПодключения.ПарольСлужебногоПользователя,
		ДополнительныеПараметры);
	Если РезультатОперации.КодСостояния = 404 Тогда
		
		// В Менеджере сервиса отсутствует сервис получения тикетов.
		Результат.КодОшибки = "ОперацияНеПоддерживается";
		Результат.ИнформацияОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Не удалось получить тикет аутентификации.
                |Аутентификация не поддерживается Менеджером сервиса.
                |В Менеджере сервиса отсутствует сервис тикетов аутентификации.
                |Получен код состояния 404 при обращении к ресурсу %1.'
                |;uk='Не вдалося отримати тікет аутентифікації.
                |Аутентифікація не підтримується Менеджером сервісу.
                |В Менеджері сервісу відсутній сервіс тікетів аутентифікації.
                |Отриманий код стану 404 при зверненні до ресурсу, %1.'"),
			URLСервиса);
		
		ИнтернетПоддержкаПользователей.ЗаписатьИнформациюВЖурналРегистрации(
			Результат.ИнформацияОбОшибке);
		
		Если Пользователи.ЭтоПолноправныйПользователь(, Истина, Ложь) Тогда
			Результат.СообщениеОбОшибке = НСтр("ru='Аутентификация на Портале ИТС не поддерживается (404).';uk='Аутентифікація на Порталі ІТС не підтримується (404).'");
		Иначе
			Результат.СообщениеОбОшибке = НСтр("ru='Ошибка аутентификации.';uk='Помилка аутентифікації.'");
		КонецЕсли;
		
	ИначеЕсли РезультатОперации.КодСостояния = 201
		Или РезультатОперации.КодСостояния = 400
		Или РезультатОперации.КодСостояния = 403
		Или РезультатОперации.КодСостояния = 500 Тогда
		
		// Обрабатываемое тело ответа.
		Попытка
			
			ЧтениеJSON = Новый ЧтениеJSON;
			ЧтениеJSON.УстановитьСтроку(РезультатОперации.Содержимое);
			ОтветОбъект = ПрочитатьJSON(ЧтениеJSON);
			ЧтениеJSON.Закрыть();
			
			Если РезультатОперации.КодСостояния = 201 Тогда
				Результат.Тикет = ОтветОбъект.ticket;
			Иначе
				
				Если ТипЗнч(ОтветОбъект) = Тип("Структура") И ОтветОбъект.Свойство("parameters") Тогда
					Результат.ИнформацияОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru='Не удалось получить тикет аутентификации в Менеджере сервиса (%1).
                            |Код состояния: %2;
                            |Сообщение: %3
                            |Область данных: %4;
                            |Владелец тикета: %5;
                            |Код абонента: %6;
                            |Идентификатор абонента: %7;
                            |Логин пользователя: %8;
                            |Идентификатор пользователя: %9.'
                            |;uk='Не вдалося отримати тікет аутентифікації в Менеджері сервісу (%1).
                            |Код стану: %2;
                            |Повідомлення: %3
                            |Область даних: %4;
                            |Власник тікета: %5;
                            |Код абонента: %6;
                            |Ідентифікатор абонента: %7;
                            |Логін користувача: %8;
                            |Ідентифікатор користувача: %9.'"),
						URLСервиса,
						РезультатОперации.КодСостояния,
						ОтветОбъект.text,
						ЗначениеРазделителя,
						Строка(ВладелецТикета),
						ОтветОбъект.parameters.subscriberCode,
						ОтветОбъект.parameters.subscriberGuid,
						ОтветОбъект.parameters.userName,
						Строка(ИдентификаторПользователя));
				Иначе
					Результат.ИнформацияОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru='Не удалось получить тикет аутентификации в Менеджере сервиса (%1).
                            |Код состояния: %2;
                            |Сообщение: %3
                            |Область данных: %4;
                            |Владелец тикета: %5;
                            |Идентификатор пользователя: %6.'
                            |;uk='Не вдалося отримати тікет аутентифікації в Менеджері сервісу (%1).
                            |Код стану: %2;
                            |Повідомлення: %3
                            |Область даних: %4;
                            |Власник тікета: %5;
                            |Ідентифікатор користувача: %6.'"),
						URLСервиса,
						РезультатОперации.КодСостояния,
						ОтветОбъект.text,
						ЗначениеРазделителя,
						Строка(ВладелецТикета),
						Строка(ИдентификаторПользователя));
				КонецЕсли;
				
				ИнтернетПоддержкаПользователей.ЗаписатьОшибкуВЖурналРегистрации(
					Результат.ИнформацияОбОшибке);
				
				Результат.КодОшибки = ?(
					РезультатОперации.КодСостояния = 500,
					"ОшибкаСервиса",
					"ОшибкаПодключения");
				
				Если Пользователи.ЭтоПолноправныйПользователь(, Истина, Ложь) Тогда
					Результат.СообщениеОбОшибке =
						СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							НСтр("ru='Ошибка аутентификации (%1).';uk='Помилка аутентифікації (%1).'"),
							РезультатОперации.КодСостояния);
				Иначе
					Результат.СообщениеОбОшибке = НСтр("ru='Ошибка аутентификации.';uk='Помилка аутентифікації.'");
				КонецЕсли;
				
			КонецЕсли;
			
		Исключение
			
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			
			Результат.КодОшибки = "ОшибкаСервиса";
			
			Результат.ИнформацияОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Не удалось получить тикет аутентификации в Менеджере сервиса (%1).
                    |Некорректный ответ Менеджера сервиса.
                    |Ошибка при обработке ответа Менеджера сервиса:
                    |%2
                    |Код состояния: %3;
                    |Тело ответа: %4
                    |Область данных: %5;
                    |Владелец тикета: %6;
                    |Идентификатор пользователя: %7.'
                    |;uk='Не вдалося отримати тікет аутентифікації в Менеджері сервісу (%1).
                    |Некоректна відповідь Менеджера сервісу.
                    |Помилка при обробці відповіді Менеджера сервісу:
                    |%2
                    |Код стану: %3;
                    |Тіло відповіді: %4
                    |Область даних: %5;
                    |Власник тікета: %6;
                    |Ідентифікатор користувача: %7.'"),
				URLСервиса,
				ПодробноеПредставлениеОшибки(ИнформацияОбОшибке),
				РезультатОперации.КодСостояния,
				Лев(РезультатОперации.Содержимое, 5120),
				ЗначениеРазделителя,
				Строка(ВладелецТикета),
				Строка(ИдентификаторПользователя));
			ИнтернетПоддержкаПользователей.ЗаписатьОшибкуВЖурналРегистрации(
				Результат.ИнформацияОбОшибке);
			
			Если Пользователи.ЭтоПолноправныйПользователь(, Истина, Ложь) Тогда
				Результат.СообщениеОбОшибке =
					НСтр("ru='Ошибка аутентификации. Некорректный ответ сервиса.';uk='Помилка аутентифікації. Некоректна відповідь сервісу.'");
			Иначе
				Результат.СообщениеОбОшибке = НСтр("ru='Ошибка аутентификации.';uk='Помилка аутентифікації.'");
			КонецЕсли;
			
		КонецПопытки;
		
	ИначеЕсли РезультатОперации.КодСостояния = 0 Тогда
		
		// Ошибка соединения.
		Результат.КодОшибки = "ОшибкаПодключения";
		Результат.ИнформацияОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Не удалось получить тикет аутентификации в Менеджере сервиса (%1).
                |Не удалось подключиться к Менеджеру сервиса.
                |%2'
                |;uk='Не вдалося отримати тікет аутентифікації в Менеджері сервісу (%1).
                |Не вдалося підключитися до Менеджера сервісу.
                |%2'"),
			URLСервиса,
			РезультатОперации.ИнформацияОбОшибке);
		ИнтернетПоддержкаПользователей.ЗаписатьОшибкуВЖурналРегистрации(
			Результат.ИнформацияОбОшибке);
		
		Если Пользователи.ЭтоПолноправныйПользователь(, Истина, Ложь) Тогда
			Результат.СообщениеОбОшибке =
				НСтр("ru='Не удалось подключиться к сервису.';uk='Не вдалося підключитися до сервісу.'")
					+ Символы.ПС + РезультатОперации.СообщениеОбОшибке;
		Иначе
			Результат.СообщениеОбОшибке = НСтр("ru='Ошибка аутентификации.';uk='Помилка аутентифікації.'");
		КонецЕсли;
		
	Иначе
		
		// Неизвестная ошибка сервиса.
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		
		Результат.ИнформацияОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Не удалось получить тикет аутентификации в Менеджере сервиса (%1).
                |Некорректный ответ Менеджера сервиса.
                |Ошибка при обработке ответа Менеджера сервиса:
                |%2
                |Код состояния: %3;
                |Тело ответа: %4
                |Область данных: %5;
                |Владелец тикета: %6;
                |Идентификатор пользователя: %7.'
                |;uk='Не вдалося отримати тікет аутентифікації в Менеджері сервісу (%1).
                |Некоректна відповідь Менеджера сервісу.
                |Помилка при обробці відповіді Менеджера сервісу:
                |%2
                |Код стану: %3;
                |Тіло відповіді: %4
                |Область даних: %5;
                |Власник тікета: %6;
                |Ідентифікатор користувача: %7.'"),
			URLСервиса,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке),
			РезультатОперации.КодСостояния,
			Лев(РезультатОперации.Содержимое, 5120),
			ЗначениеРазделителя,
			Строка(ВладелецТикета),
			Строка(ИдентификаторПользователя));
		ИнтернетПоддержкаПользователей.ЗаписатьОшибкуВЖурналРегистрации(
			Результат.ИнформацияОбОшибке);
		
		Результат.КодОшибки = "НеизвестнаяОшибка";
		Если Пользователи.ЭтоПолноправныйПользователь(, Истина, Ложь) Тогда
			Результат.СообщениеОбОшибке =
				СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru='Неизвестная ошибка сервиса аутентификации (%1).';uk='Невідома помилка сервісу аутентифікації (%1).'"),
					РезультатОперации.КодСостояния);
		Иначе
			Результат.СообщениеОбОшибке = НСтр("ru='Ошибка аутентификации.';uk='Помилка аутентифікації.'");
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НастройкиПодключенияКМенеджеруСервиса()
	
	УстановитьПривилегированныйРежим(Истина);
	Результат = Новый Структура;
	Результат.Вставить("URL", РаботаВМоделиСервисаБИП.ВнутреннийАдресМенеджераСервиса());
	Результат.Вставить("ИмяСлужебногоПользователя",
		РаботаВМоделиСервисаБИП.ИмяСлужебногоПользователяМенеджераСервиса());
	Результат.Вставить("ПарольСлужебногоПользователя",
		РаботаВМоделиСервисаБИП.ПарольСлужебногоПользователяМенеджераСервиса());
	
	Возврат Результат;
	
КонецФункции

Функция КлючОбластиДанных(ЗначениеРазделителя)
	
	Если ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		
		// В разделенном режиме не кэшируется, т.к.
		// нет необходимости входить в область данных.
		УстановитьПривилегированныйРежим(Истина);
		
		// Получение константы по имени выполняется для обхода проверки синтаксиса
		// в конфигурация не рассчитанных на работу в модели сервиса.
		Возврат Константы["КлючОбластиДанных"].Получить();
		
	Иначе
		// Результат кэшируется, т.к. необходимо выполнить вход в область данных.
		Возврат ИнтернетПоддержкаПользователейВМоделиСервисаПовтИсп.КлючОбластиДанных(ЗначениеРазделителя);
	КонецЕсли;
	
КонецФункции

#КонецОбласти
