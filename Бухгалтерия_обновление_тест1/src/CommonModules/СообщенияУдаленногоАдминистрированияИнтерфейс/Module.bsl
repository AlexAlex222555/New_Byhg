////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИК ИНТЕРФЕЙСА СООБЩЕНИЙ УДАЛЕННОГО АДМИНИСТРИРОВАНИЯ
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/1cFresh/RemoteAdministration/App/" + Версия();
	
КонецФункции

// Возвращает текущую (используемую вызывающим кодом) версию интерфейса сообщений.
Функция Версия() Экспорт
	
	Возврат "1.0.3.11";
	
КонецФункции

// Возвращает название программного интерфейса сообщений.
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "RemoteAdministrationApp";
	
КонецФункции

// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт
	
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_1);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_2);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_3);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_4);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_5);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_6);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_7);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_8);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_9);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_10);
	МассивОбработчиков.Добавить(СообщенияУдаленногоАдминистрированияОбработчикСообщения_1_0_3_11);
	
КонецПроцедуры

// Выполняет регистрацию обработчиков трансляции сообщений.
//
// Параметры:
//  МассивОбработчиков - Массив - массив обработчиков.
//
//@skip-warning Пустой метод
Процедура ОбработчикиТрансляцииСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}UpdateUser.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеОбновитьПользователя(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "UpdateUser");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}SetFullControl.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУстановитьПолныеПраваОбластиДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SetFullControl");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}SetApplicationAccess.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУстановитьДоступКОбластиДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SetApplicationAccess");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}SetDefaultUserRights.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУстановитьПраваПользователяПоУмолчанию(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SetDefaultUserRights");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}SetAPIAccess.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУстановитьДоступКAPIОбластиДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SetAPIAccess");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}PrepareApplication.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеПодготовитьОбластьДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "PrepareApplication");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}BindApplication.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеПрикрепитьОбластьДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "BindApplication");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}BindApplication.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеПодготовитьИПрикрепитьОбластьДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "PrepareAndBindApplication");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}UsersList.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеСписокПользователей(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "UsersList");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}PrepareCustomApplication.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеПодготовитьОбластьДанныхИзВыгрузки(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "PrepareCustomApplication");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}DeleteApplication.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУдалитьОбластьДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "DeleteApplication");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}SetApplicationParams.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУстановитьПараметрыОбластиДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SetApplicationParams");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}SetIBParams.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУстановитьПараметрыИБ(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SetIBParams");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}SetServiceManagerEndPoint.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУстановитьКонечнуюТочкуМенеджераСервиса(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SetServiceManagerEndPoint");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}ApplicationsRating.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция ТипРейтингОбластиДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "ApplicationRating");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}SetApplicationsRating.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеУстановитьРейтингОбластейДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SetApplicationsRating");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/1cfresh/RemoteAdministration/App/a.b.c.d}PrepareApplicationForMigration.
//
// Параметры:
//  ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//    получается тип сообщения.
//
// Возвращаемое значение:
//  ТипЗначенияXDTO, ТипОбъектаXDTO - тип сообщения.
//
Функция СообщениеПодготовитьОбластьДанныхДляМиграции(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "PrepareApplicationForMigration");
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СоздатьТипСообщения(Знач ИспользуемыйПакет, Знач Тип)
	
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = Пакет();
	КонецЕсли;
	
	Возврат ФабрикаXDTO.Тип(ИспользуемыйПакет, Тип);
	
КонецФункции

#КонецОбласти
