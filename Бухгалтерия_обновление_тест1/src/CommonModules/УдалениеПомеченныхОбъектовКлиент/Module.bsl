///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик события ОбработкаОповещения для формы, на которой требуется отобразить флажок удаления по расписанию.
//
// Параметры:
//   ИмяСобытия - Строка - имя события, которое было получено обработчиком события на форме.
//   АвтоматическиУдалятьПомеченныеОбъекты - Число - Реквизит, в которое будет помещено значение.
// 
// Пример:
//	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.УдалениеПомеченныхОбъектов") Тогда
//		МодульУдалениеПомеченныхОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УдалениеПомеченныхОбъектовКлиент");
//		МодульУдалениеПомеченныхОбъектовКлиент.ОбработкаОповещенияИзмененияФлажкаУдалятьПоРасписанию(
//			ИмяСобытия, 
//			АвтоматическиУдалятьПомеченныеОбъекты);
//	КонецЕсли;
//
Процедура ОбработкаОповещенияИзмененияФлажкаУдалятьПоРасписанию(Знач ИмяСобытия, АвтоматическиУдалятьПомеченныеОбъекты) Экспорт
	
	Если ИмяСобытия = "ИзменилсяРежимАвтоматическиУдалятьПомеченныеОбъекты" Тогда
		АвтоматическиУдалятьПомеченныеОбъекты = 
			УдалениеПомеченныхОбъектовСлужебныйВызовСервера.ЗначениеФлажкаУдалятьПоРасписанию();
	КонецЕсли;
	
КонецПроцедуры

// Обработчик события ПриИзменении для флажка, выполняющего переключение режима автоматического удаления объектов.
// Флажок должен быть связан с реквизитом типа Булево.
// 
// Параметры:
//   ЗначениеФлажкаАвтоматическиУдалятьПомеченныеОбъекты - Булево - новое значение флажка, которое требуется обработать.
// 
// Пример:
//	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.УдалениеПомеченныхОбъектов") Тогда
//		МодульУдалениеПомеченныхОбъектовКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("УдалениеПомеченныхОбъектовКлиент");
//		МодульУдалениеПомеченныхОбъектовКлиент.ПриИзмененииФлажкаУдалятьПоРасписанию(АвтоматическиУдалятьПомеченныеОбъекты);
//	КонецЕсли;
//
Процедура ПриИзмененииФлажкаУдалятьПоРасписанию(ЗначениеФлажкаАвтоматическиУдалятьПомеченныеОбъекты) Экспорт
	
	УдалениеПомеченныхОбъектовСлужебныйВызовСервера.УстановитьРежимУдалятьПоРасписанию(
		ЗначениеФлажкаАвтоматическиУдалятьПомеченныеОбъекты);
	
	Оповестить("ИзменилсяРежимАвтоматическиУдалятьПомеченныеОбъекты");
	
КонецПроцедуры

// Открывает форму удаления помеченных объектов.
//
Процедура НачатьУдалениеПомеченных() Экспорт
	
	ОткрытьФорму("Обработка.УдалениеПомеченныхОбъектов.Форма");
	
КонецПроцедуры

#КонецОбласти