///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьПараметрыФормыНастроек(Знач ОбластьДанных) Экспорт
	
	ИнформацияОбОшибке = Неопределено;
	Параметры = Прокси().GetSettingsFormParameters(
		ОбластьДанных,
		КлючОбласти(),
		ИнформацияОбОшибке);
	// Имя операции не локализуется.
	ОбработатьИнформациюОбОшибкеWebСервиса(ИнформацияОбОшибке, "GetSettingsFormParameters");
	
	Возврат СериализаторXDTO.ПрочитатьXDTO(Параметры);
	
КонецФункции

Функция ПолучитьНастройкиОбласти(Знач ОбластьДанных) Экспорт
	
	ИнформацияОбОшибке = Неопределено;
	Параметры = Прокси().GetZoneSettings(
		ОбластьДанных,
		КлючОбласти(),
		ИнформацияОбОшибке);
	ОбработатьИнформациюОбОшибкеWebСервиса(ИнформацияОбОшибке, "GetZoneSettings"); // Имя операции не локализуется.
	
	Возврат СериализаторXDTO.ПрочитатьXDTO(Параметры);
	
КонецФункции

Процедура УстановитьНастройкиОбласти(Знач ОбластьДанных, Знач НовыеНастройки, Знач ИсходныеНастройки) Экспорт
	
	ИнформацияОбОшибке = Неопределено;
	Прокси().SetZoneSettings(
		ОбластьДанных,
		КлючОбласти(),
		СериализаторXDTO.ЗаписатьXDTO(НовыеНастройки),
		СериализаторXDTO.ЗаписатьXDTO(ИсходныеНастройки),
		ИнформацияОбОшибке);
	ОбработатьИнформациюОбОшибкеWebСервиса(ИнформацияОбОшибке, "SetZoneSettings"); // Имя операции не локализуется.
	
КонецПроцедуры

Функция ПолучитьСтандартныеНастройки() Экспорт
	
	ИнформацияОбОшибке = Неопределено;
	Параметры = Прокси().GetDefaultSettings(
		ИнформацияОбОшибке);
	ОбработатьИнформациюОбОшибкеWebСервиса(ИнформацияОбОшибке, "GetDefaultSettings"); // Имя операции не локализуется.
	
	Возврат СериализаторXDTO.ПрочитатьXDTO(Параметры);
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// ВСПОМОГАТЕЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

Функция КлючОбласти()
	
	УстановитьПривилегированныйРежим(Истина);
	Возврат Константы.КлючОбластиДанных.Получить();
	
КонецФункции

Функция Прокси()
	
	УстановитьПривилегированныйРежим(Истина);
	АдресМенеджераСервиса = РаботаВМоделиСервиса.ВнутреннийАдресМенеджераСервиса();
	Если Не ЗначениеЗаполнено(АдресМенеджераСервиса) Тогда
		ВызватьИсключение(НСтр("ru='Не установлены параметры связи с менеджером сервиса.';uk='Не встановлені параметри зв''язку з менеджером сервісу.'"));
	КонецЕсли;
	
	АдресСервиса = АдресМенеджераСервиса + "/ws/ZoneBackupControl_1_0_2_1?wsdl";
	ИмяПользователя = РаботаВМоделиСервиса.ИмяСлужебногоПользователяМенеджераСервиса();
	ПарольПользователя = РаботаВМоделиСервиса.ПарольСлужебногоПользователяМенеджераСервиса();
	
	ПараметрыПодключения = ОбщегоНазначения.ПараметрыПодключенияWSПрокси();
	ПараметрыПодключения.АдресWSDL = АдресСервиса;
	ПараметрыПодключения.URIПространстваИмен = "http://www.1c.ru/1cFresh/ZoneBackupControl/1.0.2.1";
	ПараметрыПодключения.ИмяСервиса = "ZoneBackupControl_1_0_2_1";
	ПараметрыПодключения.ИмяПользователя = ИмяПользователя; 
	ПараметрыПодключения.Пароль = ПарольПользователя;
	ПараметрыПодключения.Таймаут = 10;
	
	Прокси = ОбщегоНазначения.СоздатьWSПрокси(ПараметрыПодключения);
	
	Возврат Прокси;
	
КонецФункции

// Обрабатывает информация об ошибке полученную из web-сервиса.
// В случае если передана не пустая информация об ошибке, записывает
// подробное представление ошибки в журнал регистрации и вызывает
// исключение с текстом краткого представления об ошибке.
//
Процедура ОбработатьИнформациюОбОшибкеWebСервиса(Знач ИнформацияОбОшибке, Знач ИмяОперации)
	
	РаботаВМоделиСервиса.ОбработатьИнформациюОбОшибкеWebСервиса(
		ИнформацияОбОшибке,
		РезервноеКопированиеОбластейДанных.ИмяПодсистемыДляСобытийЖурналаРегистрации(),
		"ZoneBackupControl", // Не локализуется
		ИмяОперации);
	
КонецПроцедуры

#КонецОбласти
