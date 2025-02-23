///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Подсистема "Интернет-поддержка пользователей".
// ОбщийМодуль.ИнтеграцияПодсистемБИП.
//
// Серверные процедуры и функции интеграции с БСП, БТС и БИП:
//  - Подписка на события БСП;
//  - Подписка на события БТС;
//  - Обработка событий БСП и БТС в подсистемах БИП;
//  - Определение списка возможных подписок в БИП;
//  - Вызов методов БСП, на которые выполнена подписка.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ОбработчикиСобытийБСП

// Обработка программных событий, возникающих в подсистемах БСП.
// Только для вызовов из библиотеки БСП в БИП.

// Определяет события, на которые подписана эта библиотека.
//
// Параметры:
//  Подписки - Структура - См. ИнтеграцияПодсистемБСП.СобытияБСП.
//
Процедура ПриОпределенииПодписокНаСобытияБСП(Подписки) Экспорт
	
	// БазоваяФункциональность
	Подписки.ПриДобавленииПодсистем = Истина;
	Подписки.ПриДобавленииПараметровРаботыКлиентаПриЗапуске = Истина;
	Подписки.ПриДобавленииПараметровРаботыКлиента = Истина;
	Подписки.ПриДобавленииПереименованийОбъектовМетаданных = Истина;
	Подписки.ПриДобавленииОбработчиковУстановкиПараметровСеанса = Истина;
	
	// Профили безопасности
	Подписки.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам = Истина;
	
	// Пользователи
	Подписки.ПриОпределенииНазначенияРолей = Истина;
	
	// Текущие дела
	Подписки.ПриОпределенииОбработчиковТекущихДел = Истина;
	Подписки.ПриОпределенииПорядкаРазделовКомандногоИнтерфейса = Истина;
	
	// Варианты отчетов
	Подписки.ПриНастройкеВариантовОтчетов = Истина;
	
	// Центр мониторинга
	Подписки.ПриСбореПоказателейСтатистикиКонфигурации = Истина;
	
КонецПроцедуры

#Область БазоваяФункциональность

// См. ПодсистемыКонфигурацииПереопределяемый.ПриДобавленииПодсистем.
//
Процедура ПриДобавленииПодсистем(МодулиПодсистем) Экспорт
	
	МодулиПодсистем.Добавить("ОбновлениеИнформационнойБазыБИП");
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПриДобавленииПараметровРаботыКлиентаПриЗапуске.
//
Процедура ПриДобавленииПараметровРаботыКлиентаПриЗапуске(Параметры) Экспорт
	
	Если Параметры.Свойство("ИнтернетПоддержкаПользователей") Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыИПП = Новый Структура;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы") Тогда
		МодульПолучениеОбновленийПрограммы = ОбщегоНазначения.ОбщийМодуль("ПолучениеОбновленийПрограммы");
		МодульПолучениеОбновленийПрограммы.ПараметрыРаботыКлиентаПриЗапуске(ПараметрыИПП);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.МониторПортала1СИТС") Тогда
		МодульМониторПортала1СИТС = ОбщегоНазначения.ОбщийМодуль("МониторПортала1СИТС");
		МодульМониторПортала1СИТС.ПараметрыРаботыКлиентаПриЗапуске(ПараметрыИПП);
	КонецЕсли;
	
	Параметры.Вставить("ИнтернетПоддержкаПользователей", ПараметрыИПП);
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПриДобавленииПараметровРаботыКлиента.
//
Процедура ПриДобавленииПараметровРаботыКлиента(Параметры) Экспорт
	
	Если Параметры.Свойство("ИнтернетПоддержкаПользователей") Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыИПП = Новый Структура;

	ПараметрыИПП.Вставить("ИмяКонфигурации"          , Метаданные.Имя);
	ПараметрыИПП.Вставить("ИмяПрограммы"             , ИнтернетПоддержкаПользователей.СлужебнаяИмяПрограммы());
	ПараметрыИПП.Вставить("ВерсияКонфигурации"       , Метаданные.Версия);
	ПараметрыИПП.Вставить("КодЛокализации"           , ТекущийКодЛокализации());
	ПараметрыИПП.Вставить("ВерсияОбработкиОбновления", СтандартныеПодсистемыСервер.ВерсияБиблиотеки());

	НастройкиСоединения = ИнтернетПоддержкаПользователейСлужебныйПовтИсп.НастройкиСоединенияССерверамиИПП();
	ПараметрыИПП.Вставить("ДоменРасположенияСерверовИПП", НастройкиСоединения.ДоменРасположенияСерверовИПП);

	ПараметрыИПП.Вставить(
		"ДоступноПодключениеИнтернетПоддержки",
		ИнтернетПоддержкаПользователей.ДоступноПодключениеИнтернетПоддержки());
	
	// Добавление параметров подсистем.
	
	Параметры.Вставить("ИнтернетПоддержкаПользователей", ПараметрыИПП);
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПриДобавленииПереименованийОбъектовМетаданных.
//
Процедура ПриДобавленииПереименованийОбъектовМетаданных(Итог) Экспорт
	
	ОбщегоНазначения.ДобавитьПереименование(
		Итог,
		"2.2.5.1",
		"Роль.ПодключениеКСервисуИнтернетПоддержки",
		"Роль.ПодключениеИнтернетПоддержки",
		"ИнтернетПоддержкаПользователей");
	
	ОбщегоНазначения.ДобавитьПереименование(
		Итог,
		"2.1.2.1",
		"Роль.ИспользованиеИПП",
		"Роль.ПодключениеКСервисуИнтернетПоддержки",
		"ИнтернетПоддержкаПользователей");
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.МониторПортала1СИТС") Тогда
		МодульМониторПортала1СИТС = ОбщегоНазначения.ОбщийМодуль("МониторПортала1СИТС");
		МодульМониторПортала1СИТС.ПриДобавленииПереименованийОбъектовМетаданных(Итог);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.РаботаСКлассификаторами") Тогда
		МодульРаботаСКлассификаторами = ОбщегоНазначения.ОбщийМодуль("РаботаСКлассификаторами");
		МодульРаботаСКлассификаторами.ПриДобавленииПереименованийОбъектовМетаданных(Итог);
	КонецЕсли;
	
КонецПроцедуры

// См. ОбщегоНазначенияПереопределяемый.ПриДобавленииОбработчиковУстановкиПараметровСеанса.
//
Процедура ПриДобавленииОбработчиковУстановкиПараметровСеанса(Обработчики) Экспорт
	
	Обработчики.Вставить("ПараметрыКлиентаНаСервереБИП", "ИнтернетПоддержкаПользователей.УстановкаПараметровСеанса");
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.Новости") Тогда
		МодульОбработкаНовостей = ОбщегоНазначения.ОбщийМодуль("ОбработкаНовостей");
		МодульОбработкаНовостей.ПриДобавленииОбработчиковУстановкиПараметровСеанса(Обработчики);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ОблачныйАрхив") Тогда
		МодульОблачныйАрхив = ОбщегоНазначения.ОбщийМодуль("ОблачныйАрхив");
		МодульОблачныйАрхив.ПриДобавленииОбработчиковУстановкиПараметровСеанса(Обработчики);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область НастройкиПрограммы

// Вызывается из обработчика ПриСозданииНаСервере() панели администрирования
// БСП, выполняется настройку отображения элементов управления для подсистем
// библиотеки ИПП.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма панели управления.
//
Процедура ИнтернетПоддержкаИСервисы_ПриСозданииНаСервере(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	
	РежимРаботыЛокальный = Не ОбщегоНазначения.ЭтоАвтономноеРабочееМесто()
		И Не ОбщегоНазначения.РазделениеВключено();
	
	Элементы.БИПГруппаНастройки.Видимость = Истина;
	Элементы.ГруппаПодключениеИПП.Видимость = ИнтернетПоддержкаПользователей.ДоступноПодключениеИнтернетПоддержки();
	Элементы.БИПСообщениеВСлужбуТехническойПоддержки.Видимость = РежимРаботыЛокальный;
	
	Если Элементы.ГруппаПодключениеИПП.Видимость Тогда
		УстановитьПривилегированныйРежим(Истина);
		Форма.БИПДанныеАутентификации = ИнтернетПоддержкаПользователей.ДанныеАутентификацииПользователяИнтернетПоддержки();
		УстановитьПривилегированныйРежим(Ложь);
		Если Форма.БИПДанныеАутентификации <> Неопределено Тогда
			Форма.БИПДанныеАутентификации.Пароль = "";
		КонецЕсли;
		ИнтернетПоддержкаПользователейКлиентСервер.ОтобразитьСостояниеПодключенияИПП(Форма);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.МониторПортала1СИТС") Тогда
		МодульМониторПортала1СИТС = ОбщегоНазначения.ОбщийМодуль("МониторПортала1СИТС");
		МодульМониторПортала1СИТС.ИнтернетПоддержкаИСервисы_ПриСозданииНаСервере(Форма);
	Иначе
		Элементы.БИПМониторИнтернетПоддержки.Видимость = Ложь;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.Новости") Тогда
		МодульОбработкаНовостей = ОбщегоНазначения.ОбщийМодуль("ОбработкаНовостей");
		МодульОбработкаНовостей.ИнтернетПоддержкаИСервисы_ПриСозданииНаСервере(Форма);
	Иначе
		Элементы.БИПГруппаНовости.Видимость = Ложь;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы") Тогда
		МодульПолучениеОбновленийПрограммы = ОбщегоНазначения.ОбщийМодуль("ПолучениеОбновленийПрограммы");
		МодульПолучениеОбновленийПрограммы.ИнтернетПоддержкаИСервисы_ПриСозданииНаСервере(Форма);
	Иначе
		Элементы.БИПГруппаОбновлениеПрограммы.Видимость = Ложь;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.РаботаСКлассификаторами") Тогда
		МодульРаботаСКлассификаторами = ОбщегоНазначения.ОбщийМодуль("РаботаСКлассификаторами");
		МодульРаботаСКлассификаторами.ИнтернетПоддержкаИСервисы_ПриСозданииНаСервере(Форма);
	Иначе
		Элементы.БИПГруппаОбновлениеКлассификаторов.Видимость = Ложь;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ИнтеграцияСПлатежнымиСистемами") Тогда
		МодульИнтеграцияСПлатежнымиСистемами = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияСПлатежнымиСистемами");
		МодульИнтеграцияСПлатежнымиСистемами.ИнтернетПоддержкаИСервисы_ПриСозданииНаСервере(Форма);
	Иначе
		Элементы.БИПГруппаИнтеграцияСПлатежнымиСистемами.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПрофилиБезопасности

// См. РаботаВБезопасномРежимеПереопределяемый.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам.
//
Процедура ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений) Экспорт

	Если Не ОбщегоНазначения.РазделениеВключено() Тогда

		НовыеРазрешения = Новый Массив;

		Разрешение = РаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
			"HTTPS",
			"login.bas-soft.eu",
			443,
			НСтр("ru='Сервисы аутентификации';uk='Сервіси аутентифікації'"));
		НовыеРазрешения.Добавить(Разрешение);

		Разрешение = РаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(
			"HTTPS",
			"portal-support.bas-soft.eu",
			443,
			НСтр("ru='Сервисы службы технической поддержки';uk='Сервіси служби технічної підтримки'"));
		НовыеРазрешения.Добавить(Разрешение);

		ЗапросыРазрешений.Добавить(РаботаВБезопасномРежиме.ЗапросНаИспользованиеВнешнихРесурсов(НовыеРазрешения));
		
		Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы") Тогда
			МодульПолучениеОбновленийПрограммы = ОбщегоНазначения.ОбщийМодуль("ПолучениеОбновленийПрограммы");
			МодульПолучениеОбновленийПрограммы.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
		КонецЕсли;
		
		Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.МониторПортала1СИТС") Тогда
			МодульМониторПортала1СИТС = ОбщегоНазначения.ОбщийМодуль("МониторПортала1СИТС");
			МодульМониторПортала1СИТС.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
		КонецЕсли;
		
	КонецЕсли;
	
	ПодключениеСервисовСопровождения.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.Новости") Тогда
		МодульОбработкаНовостей = ОбщегоНазначения.ОбщийМодуль("ОбработкаНовостей");
		МодульОбработкаНовостей.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ОблачныйАрхив") Тогда
		МодульОблачныйАрхив = ОбщегоНазначения.ОбщийМодуль("ОблачныйАрхив");
		МодульОблачныйАрхив.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.РаботаСКлассификаторами") Тогда
		МодульРаботаСКлассификаторами = ОбщегоНазначения.ОбщийМодуль("РаботаСКлассификаторами");
		МодульРаботаСКлассификаторами.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеВнешнихКомпонент") Тогда
		МодульПолучениеВнешнихКомпонент = ОбщегоНазначения.ОбщийМодуль("ПолучениеВнешнихКомпонент");
		МодульПолучениеВнешнихКомпонент.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ОбменДаннымиСВнешнимиСистемами") Тогда
		МодульСервисОбменаСообщениями = ОбщегоНазначения.ОбщийМодуль("СервисОбменаСообщениями");
		МодульСервисОбменаСообщениями.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Пользователи

// См. ПользователиПереопределяемый.ПриОпределенииНазначенияРолей(
//
Процедура ПриОпределенииНазначенияРолей(НазначениеРолей) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.Новости") Тогда
		МодульОбработкаНовостей = ОбщегоНазначения.ОбщийМодуль("ОбработкаНовостей");
		МодульОбработкаНовостей.ПриОпределенииНазначенияРолей(НазначениеРолей);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ТекущиеДела

// См. ТекущиеДелаПереопределяемый.ПриОпределенииОбработчиковТекущихДел.
//
Процедура ПриОпределенииОбработчиковТекущихДел(Обработчики) Экспорт
	
	ПодключениеСервисовСопровождения.ПриОпределенииОбработчиковТекущихДел(Обработчики);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы") Тогда
		МодульПолучениеОбновленийПрограммы = ОбщегоНазначения.ОбщийМодуль("ПолучениеОбновленийПрограммы");
		Обработчики.Добавить(МодульПолучениеОбновленийПрограммы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ОблачныйАрхив") Тогда
		МодульОблачныйАрхив = ОбщегоНазначения.ОбщийМодуль("ОблачныйАрхив");
		Обработчики.Добавить(МодульОблачныйАрхив);
	КонецЕсли;
	
КонецПроцедуры

// См. ТекущиеДелаПереопределяемый.ПриОпределенииПорядкаРазделовКомандногоИнтерфейса.
//
Процедура ПриОпределенииПорядкаРазделовКомандногоИнтерфейса(Разделы) Экспорт
	
	Разделы.Добавить(Метаданные.Подсистемы.ИнтернетПоддержкаПользователей);
	
КонецПроцедуры

#КонецОбласти

#Область ВариантыОтчетов

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура ПриНастройкеВариантовОтчетов(Настройки) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область ЦентрМониторинга

// См. ЦентрМониторингаПереопределяемый.ПриСбореПоказателейСтатистикиКонфигурации.
//
Процедура ПриСбореПоказателейСтатистикиКонфигурации() Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытийБТС

// Обработка программных событий, возникающих в подсистемах БТС.
// Только для вызовов из библиотеки БТС в БИП.

// Определяет события, на которые подписана эта библиотека.
//
// Параметры:
//  Подписки - Структура - См. ИнтеграцияПодсистемБТС.СобытияБТС.
//
Процедура ПриОпределенииПодписокНаСобытияБТС(Подписки) Экспорт
	
	// Выгрузка загрузка данных
	Подписки.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке = Истина;
	Подписки.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки = Истина;
	Подписки.ПослеЗагрузкиДанных = Истина;
	
	// Очередь заданий
	Подписки.ПриПолученииСпискаШаблонов = Истина;
	Подписки.ПриОпределенииПсевдонимовОбработчиков = Истина;
	
	// Поставляемые данные
	Подписки.ПриОпределенииОбработчиковПоставляемыхДанных = Истина;
	
	// Тарификация
	Подписки.ПриФормированииСпискаУслуг = Истина;
	
КонецПроцедуры

#Область ВыгрузкаЗагрузкаДанных

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке.
//
Процедура ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы) Экспорт
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.Новости") Тогда
		МодульОбработкаНовостей = ОбщегоНазначения.ОбщийМодуль("ОбработкаНовостей");
		МодульОбработкаНовостей.ПриЗаполненииТиповОбщихДанныхПоддерживающихСопоставлениеСсылокПриЗагрузке(Типы);
	КонецЕсли;
	
КонецПроцедуры

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки.
//
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	ПодключениеСервисовСопровождения.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.Новости") Тогда
		МодульОбработкаНовостей = ОбщегоНазначения.ОбщийМодуль("ОбработкаНовостей");
		МодульОбработкаНовостей.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ОблачныйАрхив") Тогда
		МодульОблачныйАрхив = ОбщегоНазначения.ОбщийМодуль("ОблачныйАрхив");
		МодульОблачныйАрхив.ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы);
	КонецЕсли;
	
КонецПроцедуры

// См. ВыгрузкаЗагрузкаДанныхПереопределяемый.ПослеЗагрузкиДанных.
//
Процедура ПослеЗагрузкиДанных(Контейнер) Экспорт
	
	ПодключениеСервисовСопровождения.ПослеЗагрузкиДанных(Контейнер);
	
КонецПроцедуры

#КонецОбласти

#Область ОчередьЗаданий

// См. ОчередьЗаданийПереопределяемый.ПриПолученииСпискаШаблонов.
//
Процедура ПриПолученииСпискаШаблонов(Шаблоны) Экспорт
	
	
КонецПроцедуры

// См. ОчередьЗаданийПереопределяемый.ПриОпределенииПсевдонимовОбработчиков.
//
Процедура ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам) Экспорт
	
	ПодключениеСервисовСопровождения.ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.РаботаСКлассификаторами") Тогда
		МодульРаботаСКлассификаторами = ОбщегоНазначения.ОбщийМодуль("РаботаСКлассификаторами");
		МодульРаботаСКлассификаторами.ПриОпределенииПсевдонимовОбработчиков(СоответствиеИменПсевдонимам);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПоставляемыеДанные

// См. ПоставляемыеДанныеПереопределяемый.ПолучитьОбработчикиПоставляемыхДанных.
//
Процедура ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики) Экспорт
	
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.РаботаСКлассификаторами") Тогда
		МодульРаботаСКлассификаторами = ОбщегоНазначения.ОбщийМодуль("РаботаСКлассификаторами");
		МодульРаботаСКлассификаторами.ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеВнешнихКомпонент") Тогда
		МодульПолучениеВнешнихКомпонент = ОбщегоНазначения.ОбщийМодуль("ПолучениеВнешнихКомпонент");
		МодульПолучениеВнешнихКомпонент.ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ПолучениеОбновленийПрограммы") Тогда
		МодульПолучениеОбновленийПрограммы = ОбщегоНазначения.ОбщийМодуль("ПолучениеОбновленийПрограммы");
		МодульПолучениеОбновленийПрограммы.ПриОпределенииОбработчиковПоставляемыхДанных(Обработчики);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Тарификация

// См. ТарификацияПереопределяемый.ПриФормированииСпискаУслуг.
//
Процедура ПриФормированииСпискаУслуг(ПоставщикиУслуг) Экспорт
	
	Услуги = Новый Массив;
	
	Если Услуги.Количество() > 0 Тогда
		// Поставщик добавляет только при наличии услуг.
		ПоставщикПортал1СИТС = ПоставщикУслугПортал1СИТСПриФормированииСпискаУслуг(
			ПоставщикиУслуг);
		ОбщегоНазначенияКлиентСервер.ДополнитьМассив(ПоставщикПортал1СИТС.Услуги, Услуги);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область БазоваяФункциональность

// См. ИнтернетПоддержкаПользователейПереопределяемый.ПриОпределенииКодаЯзыкаИнтерфейсаКонфигурации.
//
Процедура ПриОпределенииКодаЯзыкаИнтерфейсаКонфигурации(КодЯзыка, КодЯзыкаВФорматеISO639_1) Экспорт
	
	Если ИнтеграцияПодсистемБИППовтИсп.ПодпискиБСП().ПриОпределенииКодаЯзыкаИнтерфейсаКонфигурации Тогда
		МодульИнтеграцияПодсистемБСП = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияПодсистемБСП");
		МодульИнтеграцияПодсистемБСП.ПриОпределенииКодаЯзыкаИнтерфейсаКонфигурации(КодЯзыка, КодЯзыкаВФорматеISO639_1);
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтернетПоддержкаПользователейПереопределяемый.ПриОпределенииСервисовСопровождения.
//
Процедура ПриОпределенииСервисовСопровождения(МодулиСервисов) Экспорт
	
	Если ИнтеграцияПодсистемБИППовтИсп.ПодпискиБСП().ПриОпределенииСервисовСопровождения Тогда
		МодульИнтеграцияПодсистемБСП = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияПодсистемБСП");
		МодульИнтеграцияПодсистемБСП.ПриОпределенииСервисовСопровождения(МодулиСервисов);
	КонецЕсли;
	
КонецПроцедуры

// См. ИнтернетПоддержкаПользователейПереопределяемый.ПриИзмененииДанныхАутентификацииИнтернетПоддержки.
//
Процедура ПриИзмененииДанныхАутентификацииИнтернетПоддержки(ДанныеПользователя) Экспорт
	
	Если ИнтеграцияПодсистемБИППовтИсп.ПодпискиБСП().ПриИзмененииДанныхАутентификацииИнтернетПоддержки Тогда
		МодульИнтеграцияПодсистемБСП = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияПодсистемБСП");
		МодульИнтеграцияПодсистемБСП.ПриИзмененииДанныхАутентификацииИнтернетПоддержки(ДанныеПользователя);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ПолучениеОбновленийПрограммы

// См. ПолучениеОбновленийПрограммы.ПриОпределенииПараметровПолученияОбновлений.
//
Процедура ПриОпределенииПараметровПолученияОбновлений(ПараметрыПолученияОбновлений) Экспорт
	
	Если ИнтеграцияПодсистемБИППовтИсп.ПодпискиБСП().ПриОпределенииПараметровПолученияОбновлений Тогда
		МодульИнтеграцияПодсистемБСП = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияПодсистемБСП");
		МодульИнтеграцияПодсистемБСП.ПриОпределенииПараметровПолученияОбновлений(ПараметрыПолученияОбновлений);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСКлассификаторами

// См. РаботаСКлассификаторамиПереопределяемый.ПриДобавленииКлассификаторов.
//
Процедура ПриДобавленииКлассификаторов(Классификаторы) Экспорт
	
	Если ИнтеграцияПодсистемБИППовтИсп.ПодпискиБСП().ПриДобавленииКлассификаторов Тогда
		МодульИнтеграцияПодсистемБСП = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияПодсистемБСП");
		МодульИнтеграцияПодсистемБСП.ПриДобавленииКлассификаторов(Классификаторы);
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаСКлассификаторамиПереопределяемый.ПриОпределенииНачальногоНомераВерсииКлассификатора.
//
Процедура ПриОпределенииНачальногоНомераВерсииКлассификатора(Идентификатор, НачальныйНомерВерсии) Экспорт
	
	Если ИнтеграцияПодсистемБИППовтИсп.ПодпискиБСП().ПриОпределенииНачальногоНомераВерсииКлассификатора Тогда
		МодульИнтеграцияПодсистемБСП = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияПодсистемБСП");
		МодульИнтеграцияПодсистемБСП.ПриОпределенииНачальногоНомераВерсииКлассификатора(
			Идентификатор,
			НачальныйНомерВерсии);
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаСКлассификаторамиПереопределяемый.ПриЗагрузкеКлассификатора.
//
Процедура ПриЗагрузкеКлассификатора(Идентификатор, Версия, Адрес, Обработан, ДополнительныеПараметры) Экспорт
	
	Если ИнтеграцияПодсистемБИППовтИсп.ПодпискиБСП().ПриЗагрузкеКлассификатора Тогда
		МодульИнтеграцияПодсистемБСП = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияПодсистемБСП");
		МодульИнтеграцияПодсистемБСП.ПриЗагрузкеКлассификатора(
			Идентификатор,
			Версия,
			Адрес,
			Обработан,
			ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаСКлассификаторамиВМоделиСервисаПереопределяемый.ПриОбработкеОбластиДанных.
//
Процедура ПриОбработкеОбластиДанных(Идентификатор, Версия, ДополнительныеПараметры) Экспорт
	
	Если ИнтеграцияПодсистемБИППовтИсп.ПодпискиБСП().ПриОбработкеОбластиДанных Тогда
		МодульИнтеграцияПодсистемБСП = ОбщегоНазначения.ОбщийМодуль("ИнтеграцияПодсистемБСП");
		МодульИнтеграцияПодсистемБСП.ПриОбработкеОбластиДанных(
			Идентификатор,
			Версия,
			ДополнительныеПараметры);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Определяет события, на которые могут подписаться другие библиотеки.
//
// Возвращаемое значение:
//   События - Структура - Ключами свойств структуры являются имена событий, на которые
//             могут быть подписаны библиотеки.
//
Функция СобытияБИП() Экспорт
	
	События = Новый Структура;
	
	// Базовая функциональность БИП
	События.Вставить("ПриОпределенииКодаЯзыкаИнтерфейсаКонфигурации", Ложь);
	События.Вставить("ПриОпределенииСервисовСопровождения", Ложь);
	События.Вставить("ПриИзмененииДанныхАутентификацииИнтернетПоддержки", Ложь);
	
	// Получение обновления программы
	События.Вставить("ПриОпределенииПараметровПолученияОбновлений", Ложь);
	
	// Работа с классификаторами
	События.Вставить("ПриДобавленииКлассификаторов", Ложь);
	События.Вставить("ПриОпределенииНачальногоНомераВерсииКлассификатора", Ложь);
	События.Вставить("ПриЗагрузкеКлассификатора", Ложь);
	События.Вставить("ПриОбработкеОбластиДанных", Ложь);
	
	Возврат События;
	
КонецФункции

// Возвращает описание поставщика "Портал ИТС" для заполнения списка услуг
// в методе ТарификацияПереопределяемый.ПриФормированииСпискаУслуг.
// Поставщик добавляется в список поставщиков.
//
// Параметры:
//	ПоставщикиУслуг - Массив - массив элементов типа Структура - описание поставщиков.
//		Подробное описание параметра см. в процедуре ПриФормированииСпискаУслуг.
//
// Возвращаемое значение:
//	Структура - см. процедуру ПриФормированииСпискаУслуг,
//		описание параметра ПоставщикиУслуг.
//
// Пример:
//	// Использование в методе ТарификацияПереопределяемый.ПриФормированииСпискаУслуг.
//	ПоставщикПортал1СИТС =
//		ПоставщикУслугПортал1СИТСПриФормированииСпискаУслуг(ПоставщикиУслуг);
//	НоваяУслуга = Новый Структура;
//	НоваяУслуга.Вставить("Идентификатор", <Идентификатор услуги>);
//	НоваяУслуга.Вставить("Наименование" , <Наименование услуги>);
//	НоваяУслуга.Вставить("ТипУслуги"    , <Тип услуги>);
//	ПоставщикПортал1СИТС.Услуги.Добавить(НоваяУслуга);
//
Функция ПоставщикУслугПортал1СИТСПриФормированииСпискаУслуг(ПоставщикиУслуг)
	
	ИдентификаторПоставщикаУслугПортал1СИТС =
		ИнтернетПоддержкаПользователейКлиентСервер.ИдентификаторПоставщикаУслугПортал1СИТС();
	Для Каждого ТекущийПоставщик Из ПоставщикиУслуг Цикл
		Если ТекущийПоставщик.Идентификатор = ИдентификаторПоставщикаУслугПортал1СИТС Тогда
			Возврат ТекущийПоставщик;
		КонецЕсли;
	КонецЦикла;
	
	// Поставщика еще нет в списке - добавить нового поставщика.
	ПоставщикПортал1СИТС = Новый Структура;
	ПоставщикПортал1СИТС.Вставить("Идентификатор", ИдентификаторПоставщикаУслугПортал1СИТС);
	ПоставщикПортал1СИТС.Вставить("Наименование" , НСтр("ru='Портал ИТС';uk='Портал ІТС'"));
	ПоставщикПортал1СИТС.Вставить("Услуги"       , Новый Массив);
	ПоставщикиУслуг.Добавить(ПоставщикПортал1СИТС);
	
	Возврат ПоставщикПортал1СИТС;
	
КонецФункции

#КонецОбласти
