///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Заголовок = Параметры.ЗаголовокФормы;
	
	ШиринаЗаголовка = СтрДлина(Заголовок);
	Если ШиринаЗаголовка > 80 Тогда
		ШиринаЗаголовка = 80;
	КонецЕсли;
	Если ШиринаЗаголовка > 35 Тогда
		Ширина = ШиринаЗаголовка;
	КонецЕсли;
	
	ЭтоПолноправныйПользователь = Пользователи.ЭтоПолноправныйПользователь(,, Ложь);
	
	ОшибкаНаКлиенте = Параметры.ОшибкаНаКлиенте;
	ОшибкаНаСервере = Параметры.ОшибкаНаСервере;
	
	ДобавитьОшибки(ОшибкаНаКлиенте);
	ДобавитьОшибки(ОшибкаНаСервере, Истина);
	
	Элементы.Ошибки.ВысотаВСтрокахТаблицы = Мин(Ошибки.Количество(), 3);
	
	Если ЗначениеЗаполнено(ОшибкаНаКлиенте)
		И ЗначениеЗаполнено(ОшибкаНаСервере) Тогда
		
		ОписаниеОшибки = НСтр("ru='НА СЕРВЕРЕ:';uk='НА СЕРВЕРІ:'")
			+ Символы.ПС + Символы.ПС + ОшибкаНаСервере.ОписаниеОшибки
			+ Символы.ПС + Символы.ПС
			+ НСтр("ru='НА КОМПЬЮТЕРЕ:';uk='НА КОМП''ЮТЕРІ:'")
			+ Символы.ПС + Символы.ПС + ОшибкаНаКлиенте.ОписаниеОшибки;
	Иначе
		ОписаниеОшибки = СокрЛП(ОшибкаНаКлиенте.ОписаниеОшибки);
	КонецЕсли;
	
	ПоказатьИнструкцию                = Параметры.ПоказатьИнструкцию;
	ПоказатьПереходКНастройкеПрограмм = Параметры.ПоказатьПереходКНастройкеПрограмм;
	ПоказатьУстановкуРасширения       = Параметры.ПоказатьУстановкуРасширения;
	
	ОпределитьВозможности(ПоказатьИнструкцию, ПоказатьПереходКНастройкеПрограмм, ПоказатьУстановкуРасширения,
		ОшибкаНаКлиенте, ЭтоПолноправныйПользователь);
	
	ОпределитьВозможности(ПоказатьИнструкцию, ПоказатьПереходКНастройкеПрограмм, ПоказатьУстановкуРасширения,
		ОшибкаНаСервере, ЭтоПолноправныйПользователь);
	
	Если Не ПоказатьИнструкцию Тогда
		Элементы.Инструкция.Видимость = Ложь;
	КонецЕсли;
	
	ПоказатьУстановкуРасширения = ПоказатьУстановкуРасширения И Не Параметры.РасширениеПодключено;
	
	Если Не ПоказатьУстановкуРасширения Тогда
		Элементы.ФормаУстановитьРасширение.Видимость = Ложь;
	КонецЕсли;
	
	Если Не ПоказатьПереходКНастройкеПрограмм Тогда
		Элементы.ФормаПерейтиКНастройкеПрограмм.Видимость = Ложь;
	КонецЕсли;
	
	СброситьРазмерыИПоложениеОкна();
	
	Если ТипЗнч(Параметры.НеподписанныеДанные) = Тип("Структура") Тогда
		ЭлектроннаяПодписьСлужебный.ЗарегистрироватьПодписаниеДанныхВЖурнале(
			Параметры.НеподписанныеДанные, ОписаниеОшибки);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТипичныеПроблемыОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЭлектроннаяПодписьКлиент.ОткрытьИнструкциюПоТипичнымПроблемамПриРаботеСПрограммами();
	
КонецПроцедуры

&НаКлиенте
Процедура ИнформацияДляПоддержкиОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЭлектроннаяПодписьСлужебныйКлиент.СформироватьТехническуюИнформацию(ОписаниеОшибки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОшибки

&НаКлиенте
Процедура ОшибкиВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если Поле = Элементы.ОшибкиПодробнее Тогда
		
		ТекущиеДанные = Элементы.Ошибки.ТекущиеДанные;
		
		ПараметрыОшибки = Новый Структура;
		ПараметрыОшибки.Вставить("ЗаголовокПредупреждения", Заголовок);
		ПараметрыОшибки.Вставить(?(ТекущиеДанные.ОшибкаНаСервере,
			"ТекстОшибкиСервер", "ТекстОшибкиКлиент"), ТекущиеДанные.Причина);
		
		ОткрытьФорму("ОбщаяФорма.РасширенноеПредставлениеОшибки", ПараметрыОшибки, ЭтотОбъект);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПерейтиКНастройкеПрограмм(Команда)
	
	Закрыть();
	ЭлектроннаяПодписьКлиент.ОткрытьНастройкиЭлектроннойПодписиИШифрования("Программы");
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьРасширение(Команда)
	
	ЭлектроннаяПодписьКлиент.УстановитьРасширение(Истина);
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СброситьРазмерыИПоложениеОкна()
	
	ИмяПользователя = ПользователиИнформационнойБазы.ТекущийПользователь().Имя;
	
	Если ПравоДоступа("СохранениеДанныхПользователя", Метаданные) Тогда
		ХранилищеСистемныхНастроек.Удалить("ОбщаяФорма.Вопрос", "", ИмяПользователя);
	КонецЕсли;
	
	КлючСохраненияПоложенияОкна = Строка(Новый УникальныйИдентификатор);
	
КонецПроцедуры

&НаСервере
Процедура ОпределитьВозможности(Инструкция, НастройкаПрограмм, Расширение, Ошибка, ЭтоПолноправныйПользователь)
	
	ОпределитьВозможностиПоСвойствам(Инструкция, НастройкаПрограмм, Расширение, Ошибка, ЭтоПолноправныйПользователь);
	
	Если Не Ошибка.Свойство("Ошибки")
		Или ТипЗнч(Ошибка.Ошибки) <> Тип("Массив") Тогда
		
		Возврат;
	КонецЕсли;
	
	Для каждого ТекущаяОшибка Из Ошибка.Ошибки Цикл
		ОпределитьВозможностиПоСвойствам(Инструкция, НастройкаПрограмм,
			Расширение, ТекущаяОшибка, ЭтоПолноправныйПользователь);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОпределитьВозможностиПоСвойствам(Инструкция, НастройкаПрограмм, Расширение, Ошибка, ЭтоПолноправныйПользователь)
	
	Если Ошибка.Свойство("НастройкаПрограмм")
		И Ошибка.НастройкаПрограмм = Истина Тогда
		
		НастройкаПрограмм = ЭтоПолноправныйПользователь
			Или Не Ошибка.Свойство("КАдминистратору")
			Или Ошибка.КАдминистратору <> Истина;
		
	КонецЕсли;
	
	Если Ошибка.Свойство("Инструкция")
		И Ошибка.Инструкция = Истина Тогда
		
		Инструкция = Истина;
	КонецЕсли;
	
	Если Ошибка.Свойство("Расширение")
		И Ошибка.Расширение = Истина Тогда
		
		Расширение = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьОшибки(ОписаниеОшибки, ОшибкиНаСервере = Ложь)
	
	Если ЗначениеЗаполнено(ОписаниеОшибки) Тогда
		
		Если ОписаниеОшибки.Свойство("Ошибки")
			И ТипЗнч(ОписаниеОшибки.Ошибки) = Тип("Массив")
			И ОписаниеОшибки.Ошибки.Количество() > 0 Тогда
			
			Для Каждого Ошибка Из ОписаниеОшибки.Ошибки Цикл
				
				СтрокаОшибки = Ошибки.Добавить();
				СтрокаОшибки.Причина = Ошибка.Описание;
				СтрокаОшибки.Подробнее = НСтр("ru='Подробнее';uk='Докладніше'") + "...";
				СтрокаОшибки.ОшибкаНаСервере = ОшибкиНаСервере;
				
			КонецЦикла;
			
		Иначе
			
			СтрокаОшибки = Ошибки.Добавить();
			СтрокаОшибки.Причина = ОписаниеОшибки.ОписаниеОшибки;
			СтрокаОшибки.Подробнее = НСтр("ru='Подробнее';uk='Докладніше'") + "...";
			СтрокаОшибки.ОшибкаНаСервере = ОшибкиНаСервере;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
