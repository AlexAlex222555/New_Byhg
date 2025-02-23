#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ОбработчикиСобытийФормыЭлемента

// Обработчик события ПриОткрытии формы элемента справочника Договоры
//
// Параметры:
//  Отказ - Булево - признак отказа.
//  Форма - ФормаКлиентскогоПриложения - форма, для которой выполняется обработчик.
//
Процедура ПриОткрытии(Отказ, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

// Обработчик события ОбработкаОповещения формы элемента справочника Договоры
//
// Параметры:
//  см. описание платформенного метода ОбработкаОповещения
//
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Параметры:
//	Элемент - ГруппаФормы, ТаблицаФормы, ПолеФормы, КнопкаФормы - ЭлементФормы
Процедура ОбработкаНавигационнойСсылкиФормы(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

// Параметры:
//	Элемент - ГруппаФормы, ТаблицаФормы, ПолеФормы, КнопкаФормы - ЭлементФормы
Процедура ПриИзмененииРеквизита(Элемент, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормыЭлемента

Процедура ВыполнитьКомандуЛокализации(Команда, Форма) Экспорт
	//++ Локализация
	//-- Локализация
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиКомандФормы_Контрагенты_Служебные

//++ Локализация
//-- Локализация
#КонецОбласти

//++ Локализация
//-- Локализация

#КонецОбласти


