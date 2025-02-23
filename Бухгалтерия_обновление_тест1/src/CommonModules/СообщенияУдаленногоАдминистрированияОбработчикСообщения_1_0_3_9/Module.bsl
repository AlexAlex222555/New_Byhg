////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИК КАНАЛОВ СООБЩЕНИЙ ДЛЯ ВЕРСИИ 1.0.3.8 ИНТЕРФЕЙСА СООБЩЕНИЙ
//  УДАЛЕННОГО АДМИНИСТРИРОВАНИЯ
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает пространство имен версии интерфейса сообщений.
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/1cFresh/RemoteAdministration/App/" + Версия();
	
КонецФункции

// Возвращает версию интерфейса сообщений, обслуживаемую обработчиком.
Функция Версия() Экспорт
	
	Возврат "1.0.3.9";
	
КонецФункции

// Возвращает базовый тип для сообщений версии.
Функция БазовыйТип() Экспорт
	
	Возврат СообщенияВМоделиСервисаПовтИсп.ТипТело();
	
КонецФункции

// Выполняет обработку входящих сообщений модели сервиса.
//
// Параметры:
//  Сообщение - ОбъектXDTO - входящее сообщение
//  Отправитель - ПланОбменаСсылка.ОбменСообщениями - узел плана обмена, соответствующий отправителю сообщения.
//  СообщениеОбработано - Булево - флаг успешной обработки сообщения. Значение данного параметра необходимо
//    установить равным Истина в том случае, если сообщение было успешно прочитано в данном обработчике.
//
Процедура ОбработатьСообщениеМоделиСервиса(Знач Сообщение, Знач Отправитель, СообщениеОбработано) Экспорт
	
	СообщениеОбработано = Истина;
	
	Словарь = СообщенияУдаленногоАдминистрированияИнтерфейс;
	ТипСообщения = Сообщение.Body.Тип();
	
	Если ТипСообщения = Словарь.СообщениеОбновитьПользователя(Пакет()) Тогда
		ОбновитьПользователя(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеПодготовитьОбластьДанных(Пакет()) Тогда
		ПодготовитьОбластьДанных(Сообщение, Отправитель, Ложь);
	ИначеЕсли ТипСообщения = Словарь.СообщениеПодготовитьОбластьДанныхИзВыгрузки(Пакет()) Тогда
		ПодготовитьОбластьИзВыгрузки(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУдалитьОбластьДанных(Пакет()) Тогда
		УдалитьОбластьДанных(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУстановитьДоступКОбластиДанных(Пакет()) Тогда
		УстановитьДоступКОбластиДанных(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУстановитьКонечнуюТочкуМенеджераСервиса(Пакет()) Тогда
		УстановитьКонечнуюТочкуМенеджераСервиса(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУстановитьПараметрыИБ(Пакет()) Тогда
		УстановитьПараметрыИБ(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУстановитьПараметрыОбластиДанных(Пакет()) Тогда
		УстановитьПараметрыОбластиДанных(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУстановитьПолныеПраваОбластиДанных(Пакет()) Тогда
		УстановитьПолныеПраваОбластиДанных(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУстановитьПраваПользователяПоУмолчанию(Пакет()) Тогда
		УстановитьПраваПользователяПоУмолчанию(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУстановитьДоступКAPIОбластиДанных(Пакет()) Тогда
		УстановитьДоступКAPIОбластиДанных(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеУстановитьРейтингОбластейДанных(Пакет()) Тогда
		УстановитьРейтингОбластейДанных(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеПрикрепитьОбластьДанных(Пакет()) Тогда
		ПрикрепитьОбластьДанных(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеПодготовитьИПрикрепитьОбластьДанных(Пакет()) Тогда
		ПодготовитьИПрикрепитьОбластьДанных(Сообщение, Отправитель);
	ИначеЕсли ТипСообщения = Словарь.СообщениеПодготовитьОбластьДанныхДляМиграции(Пакет()) Тогда
		ПодготовитьОбластьДанныхДляМиграции(Сообщение, Отправитель);
	Иначе
		СообщениеОбработано = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбновитьПользователя(Знач Сообщение, Знач Отправитель)
	
	СообщенияУдаленногоАдминистрированияРеализация.ОбновитьПользователя(Сообщение.Body);
	
КонецПроцедуры

Процедура ПодготовитьОбластьДанных(Знач Сообщение, Знач Отправитель, Знач ИзВыгрузки)
	
	ТелоСообщения = Сообщение.Body;
	СообщенияУдаленногоАдминистрированияРеализация.ПодготовитьОбластьДанных(
		ТелоСообщения.Zone,
		ИзВыгрузки,
		?(ИзВыгрузки, Неопределено, ТелоСообщения.Kind),
		ТелоСообщения.DataFileId);
	
КонецПроцедуры
	
Процедура ПодготовитьОбластьИзВыгрузки(Знач Сообщение, Знач Отправитель)
	
	СопоставлениеПользователей = Новый ТаблицаЗначений;
	СопоставлениеПользователей.Колонки.Добавить("Пользователь", Новый ОписаниеТипов("СправочникСсылка.Пользователи"));
	СопоставлениеПользователей.Колонки.Добавить("ИдентификаторПользователяСервиса", Новый ОписаниеТипов("УникальныйИдентификатор"));
	СопоставлениеПользователей.Колонки.Добавить("СтароеИмяПользователяИБ", Новый ОписаниеТипов("Строка"));
	СопоставлениеПользователей.Колонки.Добавить("НовоеИмяПользователяИБ", Новый ОписаниеТипов("Строка"));
	Для Каждого СопоставлениеПользователя Из Сообщение.Body.UsersMap Цикл
		Пользователь = СопоставлениеПользователей.Добавить();
		Пользователь.Пользователь = Справочники.Пользователи.ПолучитьСсылку(СопоставлениеПользователя.User);
		Пользователь.ИдентификаторПользователяСервиса = СопоставлениеПользователя.UserServiceID;
		Пользователь.СтароеИмяПользователяИБ = СопоставлениеПользователя.OldInfoBaseUser;
		Пользователь.НовоеИмяПользователяИБ = СопоставлениеПользователя.NewInfoBaseUser;
	КонецЦикла;
	
	СообщенияУдаленногоАдминистрированияРеализация.ПодготовитьОбластьИзВыгрузки(Сообщение.Body.Zone, Сообщение.Body.DataFileId, СопоставлениеПользователей);
	
КонецПроцедуры

Процедура УдалитьОбластьДанных(Сообщение, Отправитель)
	
	СообщенияУдаленногоАдминистрированияРеализация.УдалитьОбластьДанных(Сообщение.Body.Zone);
	
КонецПроцедуры

Процедура УстановитьДоступКОбластиДанных(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	СообщенияУдаленногоАдминистрированияРеализация.УстановитьДоступКОбластиДанных(
		ТелоСообщения.Name,
		ТелоСообщения.StoredPasswordValue,
		ТелоСообщения.UserServiceID,
		ТелоСообщения.Value,
		ТелоСообщения.Language);
	
КонецПроцедуры

Процедура УстановитьКонечнуюТочкуМенеджераСервиса(Знач Сообщение, Знач Отправитель)
	
	СообщенияУдаленногоАдминистрированияРеализация.УстановитьКонечнуюТочкуМенеджераСервиса(Отправитель);
	
КонецПроцедуры

Процедура УстановитьПараметрыИБ(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	Параметры = СериализаторXDTO.ПрочитатьXDTO(ТелоСообщения.Params);
	СообщенияУдаленногоАдминистрированияРеализация.УстановитьПараметрыИБ(Параметры);
	
КонецПроцедуры

Процедура УстановитьПараметрыОбластиДанных(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	СообщенияУдаленногоАдминистрированияРеализация.УстановитьПараметрыОбластиДанных(
		ТелоСообщения.Zone,
		ТелоСообщения.Presentation,
		ТелоСообщения.TimeZone);
	
КонецПроцедуры

Процедура УстановитьПолныеПраваОбластиДанных(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	СообщенияУдаленногоАдминистрированияРеализация.УстановитьПолныеПраваОбластиДанных(
		ТелоСообщения.UserServiceID,
		ТелоСообщения.Value);
	
КонецПроцедуры

Процедура УстановитьПраваПользователяПоУмолчанию(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	СообщенияУдаленногоАдминистрированияРеализация.УстановитьПраваПользователяПоУмолчанию(
		ТелоСообщения.UserServiceID, 
        ТелоСообщения.Value);
	
КонецПроцедуры

Процедура УстановитьДоступКAPIОбластиДанных(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	СообщенияУдаленногоАдминистрированияРеализация.УстановитьДоступКAPIОбластиДанных(
		ТелоСообщения.UserServiceID, 
        ТелоСообщения.Value);
	
КонецПроцедуры

Процедура УстановитьРейтингОбластейДанных(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	ТаблицаРейтинга = Новый ТаблицаЗначений();
	ТаблицаРейтинга.Колонки.Добавить("ОбластьДанныхВспомогательныеДанные", Новый ОписаниеТипов("Число", , Новый КвалификаторыЧисла(7,0)));
	ТаблицаРейтинга.Колонки.Добавить("Рейтинг", Новый ОписаниеТипов("Число", , Новый КвалификаторыЧисла(7,0)));
	Для Каждого СтрокаСообщения Из ТелоСообщения.Item Цикл
		СтрокаРейтинга = ТаблицаРейтинга.Добавить();
		СтрокаРейтинга.ОбластьДанныхВспомогательныеДанные = СтрокаСообщения.Zone;
		СтрокаРейтинга.Рейтинг = СтрокаСообщения.Rating;
	КонецЦикла;
	СообщенияУдаленногоАдминистрированияРеализация.УстановитьРейтингОбластейДанных(
		ТаблицаРейтинга, ТелоСообщения.SetAllZones);
	
КонецПроцедуры

Процедура ПрикрепитьОбластьДанных(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	СообщенияУдаленногоАдминистрированияРеализация.ПрикрепитьОбластьДанных(ТелоСообщения); 
	
КонецПроцедуры

Процедура ПодготовитьИПрикрепитьОбластьДанных(Знач Сообщение, Знач Отправитель)
	
	ТелоСообщения = Сообщение.Body;
	СообщенияУдаленногоАдминистрированияРеализация.ПодготовитьИПрикрепитьОбластьДанных(ТелоСообщения);
	
КонецПроцедуры

Процедура ПодготовитьОбластьДанныхДляМиграции(Сообщение, Отправитель)
	
	КодОбластиДанных = Сообщение.Body.Zone;
	Параметры = СериализаторXDTO.ПрочитатьXDTO(Сообщение.Body.Params);
	СообщенияУдаленногоАдминистрированияРеализация.ПодготовитьОбластьДанныхДляМиграции(КодОбластиДанных, Параметры);
	
КонецПроцедуры

#КонецОбласти
