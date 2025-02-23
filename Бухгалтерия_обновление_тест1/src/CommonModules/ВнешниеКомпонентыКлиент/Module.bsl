///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Параметры для вызова процедуры ВнешниеКомпонентыКлиент.ПодключитьКомпоненту.
//
// Возвращаемое значение:
//  Структура - коллекция параметров:
//      * Кэшировать - Булево - (по умолчанию Истина) использовать механизм кэширования компонент на клиенте.
//      * ПредложитьУстановить - Булево - (по умолчанию Истина) предлагать устанавливать и обновлять компоненту.
//      * ТекстПояснения - Строка - для чего нужна компонента и что не будет работать, если ее не устанавливать.
//      * ИдентификаторыСозданияОбъектов - Массив - массив строк идентификаторов создания экземпляров модуля объекта,
//                используется только для компонент, у которых есть несколько идентификаторов создания объектов,
//                при задании параметр Идентификатор будет использоваться только для определения компоненты.
//
// Пример:
//
//  ПараметрыПодключения = ВнешниеКомпонентыКлиент.ПараметрыПодключения();
//  ПараметрыПодключения.ТекстПояснения = 
//      НСтр("ru='Для использования сканера штрихкодов требуется
//                 |внешняя компонента «Сканеры штрихкода (NativeApi)».'");
//
Функция ПараметрыПодключения() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Кэшировать", Истина);
	Параметры.Вставить("ПредложитьУстановить", Истина);
	Параметры.Вставить("ТекстПояснения", "");
	Параметры.Вставить("ИдентификаторыСозданияОбъектов", Новый Массив);
	
	Возврат Параметры;
	
КонецФункции

// Подключает компоненту, выполненную по технологии Native API или COM на клиентском компьютере.
// Для веб-клиента предлагается диалог, подсказывающий пользователю действия по установке.
// Выполняет проверку возможности исполнения компоненты на текущем клиенте пользователя.
//
// Параметры:
//  Оповещение - ОписаниеОповещения - описание оповещения о подключении со следующими параметрами:
//      * Результат - Структура - результат подключения компоненты:
//          ** Подключено - Булево - признак подключения;
//          ** ПодключаемыйМодуль - AddIn - экземпляр объекта внешней компоненты;
//                                - ФиксированноеСоответствие - экземпляры объектов внешней компоненты,
//                                      указанные в ПараметрыПодключения.ИдентификаторыСозданияОбъектов;
//                                      Ключ - Идентификатор, Значение - экземпляр объекта.
//          ** ОписаниеОшибки - Строка - краткое описание ошибки. При отмене пользователем пустая строка.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//  Идентификатор - Строка - идентификатор объекта внешней компоненты.
//  Версия        - Строка - версия компоненты.
//  ПараметрыПодключения - см. функцию ВнешниеКомпонентыКлиент.ПараметрыПодключения.
//
// Пример:
//
//  Оповещение = Новый ОписаниеОповещения("ПодключитьКомпонентуЗавершение", ЭтотОбъект);
//
//  ПараметрыПодключения = ВнешниеКомпонентыКлиент.ПараметрыПодключения();
//  ПараметрыПодключения.ТекстПояснения = 
//      НСтр("ru='Для использования сканера штрихкодов требуется
//                 |внешняя компонента «Сканеры штрихкода (NativeApi)».'");
//
//  ВнешниеКомпонентыКлиент.ПодключитьКомпоненту(Оповещение, "InputDevice",, ПараметрыПодключения);
//
//  &НаКлиенте
//  Процедура ПодключитьКомпонентуЗавершение(Результат, ДополнительныеПараметры) Экспорт
//
//      ПодключаемыйМодуль = Неопределено;
//
//      Если Результат.Подключено Тогда 
//          ПодключаемыйМодуль = Результат.ПодключаемыйМодуль;
//      Иначе
//          Если Не ПустаяСтрока(Результат.ОписаниеОшибки) Тогда
//              ПоказатьПредупреждение(, Результат.ОписаниеОшибки);
//          КонецЕсли;
//      КонецЕсли;
//
//      Если ПодключаемыйМодуль <> Неопределено Тогда 
//          // ПодключаемыйМодуль содержит созданный экземпляр подключенной компоненты.
//      КонецЕсли;
//
//      ПодключаемыйМодуль = Неопределено;
//
//  КонецПроцедуры
//
Процедура ПодключитьКомпоненту(Оповещение, Идентификатор, Версия = Неопределено,
	ПараметрыПодключения = Неопределено) Экспорт
	
	Если ПараметрыПодключения = Неопределено Тогда
		ПараметрыПодключения = ПараметрыПодключения();
	КонецЕсли;
	
	Контекст = КонтекстПодключенияКомпоненты(Оповещение, Идентификатор, Версия, ПараметрыПодключения);
	
	ВнешниеКомпонентыСлужебныйКлиент.ПодключитьКомпоненту(Контекст);
	
КонецПроцедуры

// Подключает компоненту, выполненную по технологии COM, из реестра Windows в асинхронном режиме.
// (не рекомендуется, для обратной совместимости с компонентами 7.7). 
//
// Параметры:
//  Оповещение - ОписаниеОповещения - описание оповещения о подключении со следующими параметрами:
//      * Результат - Структура - результат подключения компоненты:
//          ** Подключено - Булево - признак подключения.
//          ** ПодключаемыйМодуль - AddIn  - экземпляр объекта внешней компоненты.
//          ** ОписаниеОшибки - Строка - краткое описание ошибки.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//  Идентификатор - Строка - идентификатор объекта внешней компоненты.
//  ИдентификаторСозданияОбъекта - Строка - (необязательный) идентификатор создания экземпляра модуля объекта
//          (только для компонент, у которых идентификатор создания объекта отличается от ProgID).
//
// Пример:
//
//  Оповещение = Новый ОписаниеОповещения("ПодключитьКомпонентуЗавершение", ЭтотОбъект);
//
//  ВнешниеКомпонентыКлиент.ПодключитьКомпонентуИзРеестраWindows(Оповещение, "SBRFCOMObject", "SBRFCOMExtension");
//
//  &НаКлиенте
//  Процедура ПодключитьКомпонентуЗавершение(Результат, ДополнительныеПараметры) Экспорт
//
//      ПодключаемыйМодуль = Неопределено;
//
//      Если Результат.Подключено Тогда 
//          ПодключаемыйМодуль = Результат.ПодключаемыйМодуль;
//      Иначе 
//          ПоказатьПредупреждение(, Результат.ОписаниеОшибки);
//      КонецЕсли;
//
//      Если ПодключаемыйМодуль <> Неопределено Тогда 
//          // ПодключаемыйМодуль содержит созданный экземпляр подключенной компоненты.
//      КонецЕсли;
//
//      ПодключаемыйМодуль = Неопределено;
//
//  КонецПроцедуры
//
Процедура ПодключитьКомпонентуИзРеестраWindows(Оповещение, Идентификатор,
	ИдентификаторСозданияОбъекта = Неопределено) Экспорт 
	
	Контекст = Новый Структура;
	Контекст.Вставить("Оповещение"                  , Оповещение);
	Контекст.Вставить("Идентификатор"               , Идентификатор);
	Контекст.Вставить("ИдентификаторСозданияОбъекта", ИдентификаторСозданияОбъекта);
	
	ВнешниеКомпонентыСлужебныйКлиент.ПодключитьКомпонентуИзРеестраWindows(Контекст);
	
КонецПроцедуры

// Структура параметров для см. процедуру УстановитьКомпоненту.
//
// Возвращаемое значение:
//  Структура - коллекция параметров:
//      * ТекстПояснения - Строка - для чего нужна компонента и что не будет работать, если ее не устанавливать.
//
// Пример:
//
//  ПараметрыУстановки = ВнешниеКомпонентыКлиент.ПараметрыУстановки();
//  ПараметрыУстановки.ТекстПояснения = 
//      НСтр("ru='Для использования сканера штрихкодов требуется
//                 |внешняя компонента «Сканеры штрихкода (NativeApi)».'");
//
Функция ПараметрыУстановки() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("ТекстПояснения", "");
	
	Возврат Параметры;
	
КонецФункции

// Устанавливает компоненту, выполненную по технологии Native API и COM асинхронном режиме.
// Выполняет проверку возможности исполнения компоненты на текущем клиенте пользователя.
//
// Параметры:
//  Оповещение - ОписаниеОповещения - описание оповещения об установке внешней компоненты:
//      * Результат - Структура - результат установки компоненты:
//          ** Установлено - Булево - признак установки.
//          ** ОписаниеОшибки - Строка - краткое описание ошибки. При отмене пользователем пустая строка.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//  Идентификатор - Строка - идентификатор объекта внешней компоненты.
//  Версия - Строка - (необязательный) версия компоненты.
//  ПараметрыУстановки - Структура - (необязательный) см. функцию ПараметрыУстановки.
//
// Пример:
//
//  Оповещение = Новый ОписаниеОповещения("УстановитьКомпонентуЗавершение", ЭтотОбъект);
//
//  ПараметрыУстановки = ВнешниеКомпонентыКлиент.ПараметрыУстановки();
//  ПараметрыУстановки.ТекстПояснения = 
//      НСтр("ru='Для использования сканера штрихкодов требуется
//                 |внешняя компонента «Сканеры штрихкода (NativeApi)».'");
//
//  ВнешниеКомпонентыКлиент.УстановитьКомпоненту(Оповещение, "InputDevice",, ПараметрыУстановки);
//
//  &НаКлиенте
//  Процедура УстановитьКомпонентуЗавершение(Результат, ДополнительныеПараметры) Экспорт
//
//      Если Не Результат.Установлено И Не ПустаяСтрока(Результат.ОписаниеОшибки) Тогда 
//          ПоказатьПредупреждение(, Результат.ОписаниеОшибки);
//      КонецЕсли;
//
//  КонецПроцедуры
//
Процедура УстановитьКомпоненту(Оповещение, Идентификатор, Версия = Неопределено, 
	ПараметрыУстановки = Неопределено) Экспорт
	
	Если ПараметрыУстановки = Неопределено Тогда
		ПараметрыУстановки = ПараметрыУстановки();
	КонецЕсли;
	
	Контекст = Новый Структура;
	Контекст.Вставить("Оповещение", Оповещение);
	Контекст.Вставить("Идентификатор", Идентификатор);
	Контекст.Вставить("Версия", Версия);
	Контекст.Вставить("ПредложитьЗагрузить", Истина);
	Контекст.Вставить("ТекстПояснения", ПараметрыУстановки.ТекстПояснения);
	
	ВнешниеКомпонентыСлужебныйКлиент.УстановитьКомпоненту(Контекст);
	
КонецПроцедуры

// Возвращает структуру параметров для описания правил поиска дополнительной информации в составе внешней компоненты,
// см. процедуру ЗагрузитьКомпонентуИзФайла.
//
// Возвращаемое значение:
//  Структура - коллекция параметров:
//      * ИмяФайлаXML - Строка - (необязательный) имя файла в составе компоненты, из которого будет извлечена информация.
//      * ВыражениеXPath - Строка - (необязательный) XPath путь до информации в файле.
//
// Пример:
//
//  ПараметрыЗагрузки = ВнешниеКомпонентыКлиент.ПараметрыПоискаДополнительнойИнформации();
//  ПараметрыЗагрузки.ИмяФайлаXML = "INFO.XML";
//  ПараметрыЗагрузки.ВыражениеXPath = "//drivers/component/@type";
//
Функция ПараметрыПоискаДополнительнойИнформации() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("ИмяФайлаXML", "");
	Параметры.Вставить("ВыражениеXPath", "");
	
	Возврат Параметры;
	
КонецФункции

// Структура параметров для см. процедуру ЗагрузитьКомпонентуИзФайла.
//
// Возвращаемое значение:
//  Структура - коллекция параметров:
//      * Идентификатор - Строка -(необязательный)  идентификатор объекта внешней компоненты.
//      * Версия - Строка - (необязательный) версия компоненты.
//      * ПараметрыПоискаДополнительнойИнформации - Соответствие - (необязательный) параметры.
//          ** Ключ - Строка - идентификатор дополнительной запрошенной информации.
//          ** Значение - Строка - см. функцию ПараметрыПоискаДополнительнойИнформации.
// Пример:
//
//  ПараметрыЗагрузки = ВнешниеКомпонентыКлиент.ПараметрыЗагрузки();
//  ПараметрыЗагрузки.Идентификатор = "InputDevice";
//  ПараметрыЗагрузки.Версия = "8.1.7.10";
//
Функция ПараметрыЗагрузки() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Идентификатор", Неопределено);
	Параметры.Вставить("Версия", Неопределено);
	Параметры.Вставить("ПараметрыПоискаДополнительнойИнформации", Новый Соответствие);
	
	Возврат Параметры;
	
КонецФункции

// Загружает файл компоненты в справочник внешних компонент в асинхронном режиме. 
//
// Параметры:
//  Оповещение - ОписаниеОповещения - описание оповещения об установке внешней компоненты:
//      * Результат - Структура - результат загрузки компоненты:
//          ** Загружена - Булево - признак загрузки.
//          ** Идентификатор  - Строка - идентификатор объекта внешней компоненты.
//          ** Версия - Строка - версия загруженной компоненты.
//          ** Наименование - Строка - наименование загруженной компоненты.
//          ** ДополнительнаяИнформация - Соответствие - дополнительная информация о компоненте,
//                     если не запрашивалась - пустое соответствие.
//               *** Ключ - Строка - см. функцию ПараметрыПоискаДополнительнойИнформации.
//               *** Значение - Строка - см. функцию ПараметрыПоискаДополнительнойИнформации.
//      * ДополнительныеПараметры - Структура - значение, которое было указано при создании объекта ОписаниеОповещения.
//  ПараметрыЗагрузки - Структура - (необязательный) см. функцию ПараметрыЗагрузки.
//
// Пример:
//
//  ПараметрыЗагрузки = ВнешниеКомпонентыКлиент.ПараметрыЗагрузки();
//  ПараметрыЗагрузки.Идентификатор = "InputDevice";
//  ПараметрыЗагрузки.Версия = "8.1.7.10";
//
//  Оповещение = Новый ОписаниеОповещения("ЗагрузитьКомпонентуИзФайлаПослеЗагрузкиКомпоненты", ЭтотОбъект);
//
//  ВнешниеКомпонентыКлиент.ЗагрузитьКомпонентуИзФайла(Оповещение, ПараметрыЗагрузки);
//
//  &НаКлиенте
//  Процедура ЗагрузитьКомпонентуИзФайлаПослеЗагрузкиКомпоненты(Результат, ДополнительныеПараметры) Экспорт
//
//      Если Результат.Загружено Тогда 
//          Идентификатор = Результат.Идентификатор;
//          Версия = Результат.Версия;
//      КонецЕсли;
//
//  КонецПроцедуры
//
Процедура ЗагрузитьКомпонентуИзФайла(Оповещение, ПараметрыЗагрузки = Неопределено) Экспорт
	
	Если ПараметрыЗагрузки = Неопределено Тогда 
		ПараметрыЗагрузки = ПараметрыЗагрузки();
	КонецЕсли;
	
	Контекст = Новый Структура;
	Контекст.Вставить("Оповещение", Оповещение);
	Контекст.Вставить("Идентификатор", ПараметрыЗагрузки.Идентификатор);
	Контекст.Вставить("Версия", ПараметрыЗагрузки.Версия);
	Контекст.Вставить("ПараметрыПоискаДополнительнойИнформации", 
		ПараметрыЗагрузки.ПараметрыПоискаДополнительнойИнформации);
	
	ВнешниеКомпонентыСлужебныйКлиент.ЗагрузитьКомпонентуИзФайла(Контекст);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//  Оповещение - ОписаниеОповещения - 
//  Идентификатор - Строка - 
//  Версия - Строка - 
//  ПараметрыПодключения - см. ПараметрыПодключения
//
// Возвращаемое значение:
//  Структура - где:
//    * Оповещение - ОписаниеОповещения - 
//    * Идентификатор - Строка - 
//    * Версия - Строка - 
//    * Кэшировать - Булево - 
//    * ПредложитьУстановить - Булево - 
//    * ПредложитьЗагрузить - Булево - 
//    * ТекстПояснения - Строка - 
//    * ИдентификаторыСозданияОбъектов - Массив - 
//
Функция КонтекстПодключенияКомпоненты(Оповещение, Идентификатор, Версия, ПараметрыПодключения) Экспорт
	
	Контекст = Новый Структура;
	Контекст.Вставить("Оповещение", Оповещение);
	Контекст.Вставить("Идентификатор", Идентификатор);
	Контекст.Вставить("Версия", Версия);
	Контекст.Вставить("Кэшировать", ПараметрыПодключения.Кэшировать);
	Контекст.Вставить("ПредложитьУстановить", ПараметрыПодключения.ПредложитьУстановить);
	Контекст.Вставить("ПредложитьЗагрузить", ПараметрыПодключения.ПредложитьУстановить);
	Контекст.Вставить("ТекстПояснения", ПараметрыПодключения.ТекстПояснения);
	Контекст.Вставить("ИдентификаторыСозданияОбъектов", ПараметрыПодключения.ИдентификаторыСозданияОбъектов);
	Возврат Контекст;
	
КонецФункции

#КонецОбласти
