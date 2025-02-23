
#Область ПрограммныйИнтерфейс

// Параметры:
// 	Форма - ФормаКлиентскогоПриложения
// 	ИмяТабличнойЧасти - Строка
// 	
Функция ТекущаяСтрока(Форма, ИмяТабличнойЧасти = "Товары") Экспорт
	
	ТекущаяСтрока = Форма.Элементы[ИмяТабличнойЧасти].ТекущиеДанные;
	
	Если ТекущаяСтрока = Неопределено Тогда
		ТекстСообщения = НСтр("ru='Необходимо выбрать строку, для которой необходимо получить вес.';uk='Необхідно вибрати рядок, для якого необхідно отримати вагу.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
	Возврат ТекущаяСтрока;
	
КонецФункции

// В процедуре нужно реализовать алгоритм преобразования данных из подсистемы подключаемого оборудования.
//
// Параметры:
//  Параметр - Массив - входящие данные.
//
// Возвращаемое значение:
//  Массив - Массив структур со свойствами:
//   * Штрихкод
//   * Количество
Функция ПреобразоватьДанныеСоСканераВМассив(Параметр) Экспорт
	
	МенеджерОборудованияУТКлиент.ОбработатьСобытие();
	
	Данные = Новый Массив;
	Данные.Добавить(ПреобразоватьДанныеСоСканераВСтруктуру(Параметр));
	
	Возврат Данные;
	
КонецФункции

// В процедуре нужно реализовать алгоритм преобразования данных из подсистемы подключаемого оборудования.
//
// Параметры:
//  Параметр - Массив - входящие данные.
//
// Возвращаемое значение:
//  Структура - структура со свойствами:
//   * Штрихкод
//   * Количество
Функция ПреобразоватьДанныеСоСканераВСтруктуру(Параметр) Экспорт
	
	МенеджерОборудованияУТКлиент.ОбработатьСобытие();
	
	Если Параметр[1] = Неопределено Тогда
		Данные = Новый Структура("Штрихкод, Количество", Параметр[0], 1);    // Достаем штрихкод из основных данных
	Иначе
		Данные = Новый Структура("Штрихкод, Количество", Параметр[1][1], 1); // Достаем штрихкод из дополнительных данных
	КонецЕсли;
	
	Возврат Данные;
	
КонецФункции

Функция ОборудованиеПодключено(ИдентификаторУстройства) Экспорт
	
	ПодключенноеУстройство = МенеджерОборудованияКлиент.ПолучитьПодключенноеУстройство(глПодключаемоеОборудование.ПараметрыПодключенияПО, ИдентификаторУстройства);

	Если ПодключенноеУстройство = Неопределено Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

Функция ЕстьНеобработанноеСобытие() Экспорт
	
	Возврат (глПодключаемоеОборудованиеСобытиеОбработано = Ложь);
	
КонецФункции

Процедура ОбработатьСобытие() Экспорт
	
	глПодключаемоеОборудованиеСобытиеОбработано = Истина;
	
КонецПроцедуры

Процедура СообщитьОбОшибке(РезультатВыполнения) Экспорт
	
	ТекстСообщения = НСтр("ru='При выполнении операции произошла ошибка:""%ОписаниеОшибки%"".';uk='При виконанні операції виникла помилка:""%ОписаниеОшибки%"".'");
	ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОписаниеОшибки%", РезультатВыполнения.ОписаниеОшибки);
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	
КонецПроцедуры

#КонецОбласти