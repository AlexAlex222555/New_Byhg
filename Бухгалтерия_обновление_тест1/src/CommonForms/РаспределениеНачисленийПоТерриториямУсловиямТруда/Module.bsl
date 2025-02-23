&НаКлиенте
Перем ДействиеВыбрано;

#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ДействиеВыбрано = Ложь;
	
	Организация = Параметры.Организация;
	Сотрудник = Параметры.Сотрудник;
	Начисление = Параметры.Начисление;
	
	СтрокиРаспределения = ПолучитьИзВременногоХранилища(Параметры.Распределение);
	
	ДобавитьКолонкиПоказателей();
	ЗаполнитьДанныеФормы(СтрокиРаспределения);
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьКолонкиПоказателей()
	
	// Определяем пересечение показателей начисления и показателей, определяемых по территориям и условиям труда.
	ПоказателиПоТерриториямУсловиямТруда = Справочники.ПоказателиРасчетаЗарплаты.ПоказателиПоТерриториямУсловиямТруда();
	
	ТипЗначенияПоказателя = Справочники.ПоказателиРасчетаЗарплаты.ОписаниеТиповЗначенияПоказателяРасчетаЗарплаты();
	
	ПоказателиФормы = Новый Соответствие;
	ДобавляемыеРеквизиты = Новый Массив;
	
	ВидРасчетаИнфо = ЗарплатаКадрыРасширенныйПовтИсп.ПолучитьИнформациюОВидеРасчета(Начисление);
	Для Каждого ОписаниеПоказателя Из ВидРасчетаИнфо.Показатели Цикл
		Если ПоказателиПоТерриториямУсловиямТруда.Найти(ОписаниеПоказателя.Показатель) = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ИмяРеквизита = ОписаниеПоказателя.Идентификатор + ЗарплатаКадрыРасширенныйКлиентСервер.УникальноеИмяРеквизита();
		РеквизитФормы = Новый РеквизитФормы(ИмяРеквизита, ТипЗначенияПоказателя, "Распределение", ОписаниеПоказателя.КраткоеНаименование);
		ДобавляемыеРеквизиты.Добавить(РеквизитФормы); 
		ПоказателиФормы.Вставить(ОписаниеПоказателя.Показатель, ИмяРеквизита);
	КонецЦикла;
	
	МассивИменРеквизитовФормы = Новый Массив;
	ЗарплатаКадры.ЗаполнитьМассивИменРеквизитовФормы(ЭтаФорма, МассивИменРеквизитовФормы, "Распределение");
	ЗарплатаКадры.ИзменитьРеквизитыФормы(ЭтаФорма, ДобавляемыеРеквизиты, МассивИменРеквизитовФормы);
	
	Для Каждого КлючИЗначение Из ПоказателиФормы Цикл
		// Добавляем поле.
		ИмяПоля = КлючИЗначение.Значение;
		Если Элементы.Найти(ИмяПоля) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		ПолеРаспределения = Элементы.Вставить(ИмяПоля, Тип("ПолеФормы"), Элементы.Распределение, Элементы.РаспределениеРезультат);
		ПолеРаспределения.Вид = ВидПоляФормы.ПолеВвода;
		ПолеРаспределения.Ширина = 7;
		ПолеРаспределения.ПутьКДанным = "Распределение." + ИмяПоля;
	КонецЦикла;
	
	Показатели = Новый ФиксированноеСоответствие(ПоказателиФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	
	Если ДействиеВыбрано <> Истина Тогда
		ОповеститьОВыборе(Неопределено);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКоманд

&НаКлиенте
Процедура ОК(Команда)
	
	ДействиеВыбрано = Истина;
	
	Если Не Модифицированность Тогда
		ОповеститьОВыборе(Неопределено);
		Возврат;
	КонецЕсли;
	
	РезультатРедактирования = Новый Структура(
		"Распределение, 
		|Результат");
		
	РезультатРедактирования.Распределение = РезультатРедактированияРаспределения();	
	РезультатРедактирования.Результат = Результат;	
		
	ОповеститьОВыборе(РезультатРедактирования);
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	ДействиеВыбрано = Истина;
	ОповеститьОВыборе(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиЭлементов

&НаКлиенте
Процедура РаспределениеПослеУдаления(Элемент)
	Результат = Распределение.Итог("Результат");
КонецПроцедуры

&НаКлиенте
Процедура РаспределениеРезультатПриИзменении(Элемент)
	Результат = Распределение.Итог("Результат");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьДанныеФормы(ТаблицаРаспределения)
	
	Если ТаблицаРаспределения = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	КоличествоПоказателей = Справочники.ПоказателиРасчетаЗарплаты.ПоказателиПоТерриториямУсловиямТруда().Количество();
	
	Распределение.Очистить();
	Для Каждого СтрокаТаблицы Из ТаблицаРаспределения Цикл
		НоваяСтрока = Распределение.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаТаблицы);
		Для НомерПоказателя = 1 По КоличествоПоказателей Цикл
			ИмяРеквизита = Показатели.Получить(СтрокаТаблицы["Показатель" + НомерПоказателя]);
			Если ИмяРеквизита <> Неопределено Тогда
				НоваяСтрока[ИмяРеквизита] = СтрокаТаблицы["Значение" + НомерПоказателя];
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Результат = Распределение.Итог("Результат");
	
КонецПроцедуры

&НаСервере
Функция РезультатРедактированияРаспределения()
	
	РезультатРаспределения = Новый Массив;
	
	Для Каждого СтрокаРаспределения Из Распределение Цикл
		ОписаниеСтроки = РасчетЗарплатыРасширенныйФормы.ОписаниеСтрокиРаспределенияПоТерриториямУсловиямТруда();
		ЗаполнитьЗначенияСвойств(ОписаниеСтроки, СтрокаРаспределения);
		НомерПоказателя = 1;
		Для Каждого КлючИЗначение Из Показатели Цикл
			ОписаниеСтроки["Показатель" + НомерПоказателя] = КлючИЗначение.Ключ;
			ОписаниеСтроки["Значение" + НомерПоказателя] = СтрокаРаспределения[КлючИЗначение.Значение];
			НомерПоказателя = НомерПоказателя + 1;
		КонецЦикла;
		РезультатРаспределения.Добавить(Новый ФиксированнаяСтруктура(ОписаниеСтроки));
	КонецЦикла;
	
	Возврат ПоместитьВоВременноеХранилище(Новый ФиксированныйМассив(РезультатРаспределения));
	
КонецФункции

#КонецОбласти
