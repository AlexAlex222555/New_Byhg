////////////////////////////////////////////////////////////////////////////////
// Модуль содержит процедуры и функции для обработки действий пользователя
// в процессе выбора ответственных лиц в документах
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область ЗаполнениеСпискаДолжностейФизическихЛицВФормах 

// Заполняет списки выбора должностей членов комиссии
//
// Параметры:
//  Элементы - элементы формы, в которой нужно заполнить списки выбора 
//  Объект	 - ДокументОбъект - объект, по данным членов комиссии которого заполнить списки выбора элементов 
Процедура ЗаполнитьСпискиВыбораДолжностейЧленовКомиссии(Элементы, Объект) Экспорт

	Если Элементы.Найти("ДолжностьПредседателяКомиссии") <> Неопределено Тогда
	 	ДолжностиДляПечатиКлиентСервер.ЗаполнитьСписокВыбораДолжностей(
			Элементы.ДолжностьПредседателяКомиссии, Объект.ПредседательКомиссии, Объект.Организация, Объект.Дата, Неопределено);
	КонецЕсли; 
	
	ДолжностиДляПечатиКлиентСервер.ЗаполнитьСписокВыбораДолжностей(
		Элементы.ДолжностьЧленаКомиссии1, Объект.ЧленКомиссии1, Объект.Организация, Объект.Дата, Неопределено);
	ДолжностиДляПечатиКлиентСервер.ЗаполнитьСписокВыбораДолжностей(
		Элементы.ДолжностьЧленаКомиссии2, Объект.ЧленКомиссии2, Объект.Организация, Объект.Дата, Неопределено);
	ДолжностиДляПечатиКлиентСервер.ЗаполнитьСписокВыбораДолжностей(
		Элементы.ДолжностьЧленаКомиссии3, Объект.ЧленКомиссии3, Объект.Организация, Объект.Дата, Неопределено);

КонецПроцедуры

// Заполняет список выбора должностей для элемента формы
//
// Параметры:
//  ДолжностьЭлемент	 - ЭлементФормы	- элемент, для которого необходимо заполнить список выбора
//  ФизическоеЛицоСсылка - СправочникСсылка.ФизицескиеЛица - ссылка на физическое лицо, по которому заполнить список должностей
//  Организация			 - СправочникСсылка.Организация - ссылка на организацию
//  Дата			 	 - Дата - дата, на которую выполняется поиск должности физ. лица
//  Должность			 - реквизит содержащий должность
Процедура ЗаполнитьСписокВыбораДолжностей(ДолжностьЭлемент, ФизическоеЛицоСсылка, Организация, Дата, Должность) Экспорт
	
	ДанныеДляВыбора = ДолжностиДляПечатиВызовСервера.СписокДолжностейФизическогоЛица(ФизическоеЛицоСсылка, Организация, Дата);
	
	ДолжностьЭлемент.СписокВыбора.Очистить();
	Для каждого ЭлементСпискаЗначений Из ДанныеДляВыбора Цикл
		ДолжностьЭлемент.СписокВыбора.Добавить(ЭлементСпискаЗначений.Значение);
	КонецЦикла;
	
	Если Должность <> Неопределено И ДанныеДляВыбора.Количество() = 1 Тогда
		Должность = ДанныеДляВыбора[0];
	КонецЕсли;

КонецПроцедуры
	
#КонецОбласти

// Возвращает должность физ. лица на указанную дату и для указанной организации
//
// Параметры:
//  ФизическоеЛицоСсылка - СправочникСсылка.ФизицескиеЛица - ссылка на физическое лицо, для которого получаем должность
//  Организация			 - СправочникСсылка.Организация - ссылка на организацию
//  Дата			 	 - Дата - дата, на которую выполняется поиск должности физ. лица
Функция ДолжностьФизическогоЛица(ФизическоеЛицоСсылка, Организация, Дата) Экспорт
	
	ДолжностьФизЛица = "";
	
	СписокДолжностейФизЛица = ДолжностиДляПечатиВызовСервера.СписокДолжностейФизическогоЛица(
		ФизическоеЛицоСсылка, Организация, Дата); 
	Если СписокДолжностейФизЛица.Количество() = 1 Тогда
		ДолжностьФизЛица = СписокДолжностейФизЛица[0].Значение;	
	КонецЕсли;
	
	Возврат ДолжностьФизЛица;
	
КонецФункции
 
#КонецОбласти