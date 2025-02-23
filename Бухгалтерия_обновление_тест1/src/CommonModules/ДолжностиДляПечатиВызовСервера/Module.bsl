////////////////////////////////////////////////////////////////////////////////
// Модуль "ДолжностиДляПечатиВызовСервера", содержит процедуры и функции для 
// серверной обработки действий связанных с выбором должностей ответственных лиц
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

Функция СписокДолжностейФизическогоЛица(ФизическоеЛицо, Организация, Дата = Неопределено) Экспорт 
	
	СписокЗначений = Новый СписокЗначений;
	
	Если ФизическоеЛицо.Пустая() Или Организация.Пустая() Тогда
		Возврат СписокЗначений;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Дата) Тогда
		Дата = ТекущаяДата();	
	КонецЕсли; 
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
	|	ОтветственныеЛицаОрганизаций.Должность
	|ИЗ
	|	Справочник.ОтветственныеЛицаОрганизаций КАК ОтветственныеЛицаОрганизаций
	|ГДЕ
	|	ОтветственныеЛицаОрганизаций.Владелец = &Организация
	|	И ОтветственныеЛицаОрганизаций.ФизическоеЛицо = &ФизическоеЛицо
	|	И ОтветственныеЛицаОрганизаций.Должность <> """"
	|	И ОтветственныеЛицаОрганизаций.ПометкаУдаления = ЛОЖЬ
	|	И ОтветственныеЛицаОрганизаций.ДатаНачала <= НАЧАЛОПЕРИОДА(&Дата, ДЕНЬ)
	|	И (ОтветственныеЛицаОрганизаций.ДатаОкончания >= НАЧАЛОПЕРИОДА(&Дата, ДЕНЬ)
	|			ИЛИ ОтветственныеЛицаОрганизаций.ДатаОкончания = ДАТАВРЕМЯ(1, 1, 1))";
	
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ФизическоеЛицо", ФизическоеЛицо);
	Запрос.УстановитьПараметр("Дата", Дата);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		СписокЗначений.Добавить(Выборка.Должность);
	КонецЦикла;
	
	Возврат СписокЗначений;
	
КонецФункции

#КонецОбласти