#Область СлужебныйПрограммныйИнтерфейс

// АПК:299-выкл Используемость методов служебного API не контролируется

// Возвращает структуру параметров макета конфигурации 
// (или указанной области макета).
//
// Параметры:
//  ПутьКМакету - Строка - полный путь к макету в формате:
//                         "Документ.<ИмяДокумента>.<ИмяМакета>"
//                         "Обработка.<ИмяОбработки>.<ИмяМакета>"
//                         "ОбщийМакет.<ИмяМакета>".
//  ИмяОбласти - Строка - Имя области в макете. 
//                        Необязательный. Если не указан, возвращаются все параметры в макете.
//
// Возвращаемое значение:
//  Структура - параметры макета, ключ соответствует имени параметра, значение - Неопределено.
//
Функция ПараметрыСтандартногоМакета(ПутьКМакету, Знач ИмяОбласти = Неопределено) Экспорт
	
	Макет = МакетПоПолномуПути(ПутьКМакету);
	
	Если ЗначениеЗаполнено(ИмяОбласти) Тогда
		ТабличныйДокумент = Макет.ПолучитьОбласть(ИмяОбласти)
	Иначе	
		ТабличныйДокумент = Макет;
	КонецЕсли;	
	
	Параметры = ОбщегоНазначенияБЗК.ПараметрыТабличногоДокумента(ТабличныйДокумент);
	
	Возврат Параметры;
	
КонецФункции

// Возвращает параметры указанных областей макета конфигурации.
//
// Параметры:
//  ПутьКМакету   - Строка - полный путь к макету в формате:
//                           "Документ.<ИмяДокумента>.<ИмяМакета>"
//                           "Обработка.<ИмяОбработки>.<ИмяМакета>"
//                           "ОбщийМакет.<ИмяМакета>".
//  Области - Строка, Массив - области в макете, параметры которых необходимо получить.
//                             Необязательный. Если не указан, возвращаются все области макета.
//
// Возвращаемое значение:
//  Структура - ключ соответствует имени области, значение - Структура -  содержит параметры области.
//
Функция ПараметрыОбластейСтандартногоМакета(ПутьКМакету, Знач Области = Неопределено) Экспорт
	
	Макет = МакетПоПолномуПути(ПутьКМакету);
	
	ИменаОбластей = Новый Массив;
	Если ЗначениеЗаполнено(Области) Тогда
		Если ТипЗнч(Области) = Тип("Строка") Тогда 
			ИменаОбластей = СтроковыеФункцииБЗККлиентСервер.РазделитьИменаСвойств(Области)
		ИначеЕсли ТипЗнч(Области) = Тип("Массив") Тогда
			ИменаОбластей = Области
		Иначе
			ВызватьИсключение НСтр("ru='Недопустимый параметр ""ИменаОбластей"".';uk='Неприпустимий параметр ""ИменаОбластей"".'")
		КонецЕсли;	
	Иначе	
		Для Каждого Область Из Макет.Области Цикл
			ИменаОбластей.Добавить(Область.Имя)
		КонецЦикла	
	КонецЕсли;	
	
	Параметры = Новый Структура;
	Для Каждого ИмяОбласти Из ИменаОбластей Цикл
		Область = Макет.ПолучитьОбласть(ИмяОбласти);
		Параметры.Вставить(
			ИмяОбласти,
			ОбщегоНазначенияБЗК.ПараметрыТабличногоДокумента(Область));
	КонецЦикла;		
	
	Возврат Параметры;
	
КонецФункции

// АПК:299-вкл

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция МакетПоПолномуПути(ПутьКМакету)
	
	ЧастиПути = СтрРазделить(ПутьКМакету, ".");
	ИмяМакета = ЧастиПути[ЧастиПути.ВГраница()];
	
	Если ЧастиПути.Количество() = 2 Тогда
		Макет = ПолучитьОбщийМакет(ИмяМакета);
	Иначе
		МенеджерОбъекта = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(СтрШаблон("%1.%2", ЧастиПути[0], ЧастиПути[1]));
		Макет = МенеджерОбъекта.ПолучитьМакет(ИмяМакета);
	КонецЕсли;	
	
	Возврат Макет
	
КонецФункции

#КонецОбласти
