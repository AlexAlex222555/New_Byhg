
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииСозданииНаСервере();
	КонецЕсли;
	
	Элементы.ГруппаОтражениеВМеждународномУчете.Видимость = Ложь;
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	//++ НЕ УТ
	НастройкаСчетовУчетаКлиент.ЗаконченаНастройкаСчетовУчета(ЭтотОбъект, ИмяСобытия, Параметр);
	//-- НЕ УТ
	Возврат; // В УТ обработчик пустой
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)

	МодификацияКонфигурацииКлиентПереопределяемый.ПослеЗаписи(ЭтаФорма, ПараметрыЗаписи);

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)

	МодификацияКонфигурацииПереопределяемый.ПередЗаписьюНаСервере(ЭтаФорма, Отказ, ТекущийОбъект, ПараметрыЗаписи);

КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриЧтенииСозданииНаСервере();
	
	МодификацияКонфигурацииПереопределяемый.ПриЧтенииНаСервере(ЭтаФорма, ТекущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	МодификацияКонфигурацииПереопределяемый.ПослеЗаписиНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);

КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	//++ НЕ УТ
	НастройкаСчетовУчета.ПриЗаписиОбъектаНастройкиСчетовУчета(ЭтотОбъект, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	//-- НЕ УТ
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	//++ НЕ УТ
	НастройкаСчетовУчета.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	//-- НЕ УТ
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура СсылкаНастроитьСчетаРеглУчетаОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	//++ НЕ УТ
	НастройкаСчетовУчетаКлиент.ОбработкаНавигационнойСсылкиНастройкаСчетовУчета(
		ЭтотОбъект, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
	//-- НЕ УТ
	Возврат; // В УТ обработчик пустой
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	МассивПрименимость = Новый Массив;
	
	ИспользоватьКомиссиюПриЗакупках               = ПолучитьФункциональнуюОпцию("ИспользоватьКомиссиюПриЗакупках");
	ИспользоватьКомиссиюПриПродажах               = ПолучитьФункциональнуюОпцию("ИспользоватьКомиссиюПриПродажах");
	ИспользоватьПередачиТоваровМеждуОрганизациями = ПолучитьФункциональнуюОпцию("ИспользоватьПередачиТоваровМеждуОрганизациями");
	ИспользоватьДоговорыКредитовИДепозитов        = ПолучитьФункциональнуюОпцию("ИспользоватьДоговорыКредитовИДепозитов");
	ИспользоватьДоговорыЛизинга                   = Ложь;
	ИспользоватьОказаниеАгентскихУслугПриЗакупке  = ПолучитьФункциональнуюОпцию("ИспользоватьОказаниеАгентскихУслугПриЗакупке");
	//++ НЕ УТ
	ИспользоватьДоговорыЛизинга                   = ПолучитьФункциональнуюОпцию("ИспользоватьЛизинг");
	//-- НЕ УТ
	
	СписокВыбора = Элементы.Применимость.СписокВыбора;
	СписокВыбора.Очистить();
	
	СписокВыбора.Добавить(1, НСтр("ru='клиентами';uk='клієнтами'"));
	СписокВыбора.Добавить(2, НСтр("ru='поставщиками';uk='постачальниками'"));
	Если ИспользоватьКомиссиюПриПродажах 
		 ИЛИ ИспользоватьПередачиТоваровМеждуОрганизациями
		 ИЛИ Объект.РасчетыСКомиссионерами Тогда
		СписокВыбора.Добавить(3, НСтр("ru='комиссионерами';uk='комісіонерами'"));
	КонецЕсли;
	Если ИспользоватьКомиссиюПриЗакупках 
		ИЛИ ИспользоватьПередачиТоваровМеждуОрганизациями
		ИЛИ Объект.РасчетыСКомитентами Тогда
		СписокВыбора.Добавить(4, НСтр("ru='комитентами по продаже';uk='комітентами з продажу'"));
	КонецЕсли;
	Если ИспользоватьОказаниеАгентскихУслугПриЗакупке
		ИЛИ Объект.РасчетыСКомитентамиПоЗакупке Тогда
		СписокВыбора.Добавить(8, НСтр("ru='комитентами по закупке';uk='комітентами з купівлі'"));
	КонецЕсли;
	Если ИспользоватьДоговорыКредитовИДепозитов
		ИЛИ Объект.РасчетыСДебиторами Тогда
		СписокВыбора.Добавить(6, НСтр("ru='дебиторами по депозитам, займам';uk='дебіторами по депозитах, позикам'"));
	КонецЕсли;
	Если ИспользоватьДоговорыКредитовИДепозитов 
		ИЛИ Объект.РасчетыСКредиторами Тогда
		СписокВыбора.Добавить(5, НСтр("ru='кредиторами по кредитам, займам';uk='кредиторами за кредитами, позиками'"));
	КонецЕсли;
	Если ИспользоватьДоговорыЛизинга 
		ИЛИ Объект.РасчетыСЛизингодателями Тогда
		СписокВыбора.Добавить(7, НСтр("ru='лизингодателями';uk='лизингодателями'"));
	КонецЕсли;
	
	Если Объект.РасчетыСКлиентами Тогда
		МассивПрименимость.Добавить(1);
	КонецЕсли;
	Если Объект.РасчетыСПоставщиками Тогда
		МассивПрименимость.Добавить(2);
	КонецЕсли;
	Если Объект.РасчетыСКомиссионерами Тогда
		МассивПрименимость.Добавить(3);
	КонецЕсли;
	Если Объект.РасчетыСКомитентами Тогда
		МассивПрименимость.Добавить(4);
	КонецЕсли;
	Если Объект.РасчетыСКомитентамиПоЗакупке Тогда
		МассивПрименимость.Добавить(8);
	КонецЕсли;
	Если Объект.РасчетыСКредиторами Тогда
		МассивПрименимость.Добавить(5);
	КонецЕсли;
	Если Объект.РасчетыСДебиторами Тогда
		МассивПрименимость.Добавить(6);
	КонецЕсли;
	Если Объект.РасчетыСЛизингодателями Тогда
		МассивПрименимость.Добавить(7);
	КонецЕсли;
	
	Если МассивПрименимость.Количество() = 1 Тогда
		Применимость = МассивПрименимость[0];
	Иначе
		Применимость = 0;
		МассивПодстрок = Новый Массив;
		Для каждого Элемент Из МассивПрименимость Цикл
			ЭлементСписка = СписокВыбора.НайтиПоЗначению(Элемент);
			Если ЭлементСписка <> Неопределено Тогда
				МассивПодстрок.Добавить(ЭлементСписка.Представление);
			КонецЕсли;
		КонецЦикла;
		СписокВыбора.Добавить(0, СтрСоединить(МассивПодстрок, ", "));
	КонецЕсли;
	
	//++ НЕ УТ
	НастройкаСчетовУчета.ПриЧтенииСозданииОбъектаНастройкиСчетовУчета(ЭтотОбъект);
	//-- НЕ УТ
	
КонецПроцедуры


&НаКлиенте
Процедура ПрименимостьПриИзменении(Элемент)
	
	Объект.РасчетыСКлиентами = Ложь;
	Объект.РасчетыСПоставщиками = Ложь;
	Объект.РасчетыСКомиссионерами = Ложь;
	Объект.РасчетыСКомитентами = Ложь;
	Объект.РасчетыСКомитентамиПоЗакупке = Ложь;
	Объект.РасчетыСКредиторами = Ложь;
	Объект.РасчетыСДебиторами = Ложь;
	Объект.РасчетыСЛизингодателями = Ложь;
	
	Если Применимость = 1 Тогда
		Объект.РасчетыСКлиентами = Истина;
	ИначеЕсли Применимость = 2 Тогда
		Объект.РасчетыСПоставщиками = Истина;
	ИначеЕсли Применимость = 3 Тогда
		Объект.РасчетыСКомиссионерами = Истина;
	ИначеЕсли Применимость = 4 Тогда
		Объект.РасчетыСКомитентами = Истина;
	ИначеЕсли Применимость = 8 Тогда
		Объект.РасчетыСКомитентамиПоЗакупке = Истина;
	ИначеЕсли Применимость = 5 Тогда
		Объект.РасчетыСКредиторами = Истина;
	ИначеЕсли Применимость = 6 Тогда
		Объект.РасчетыСДебиторами = Истина;
	ИначеЕсли Применимость = 7 Тогда
		Объект.РасчетыСЛизингодателями = Истина;
	КонецЕсли;
	
	//++ НЕ УТ
	НастройкаСчетовУчетаКлиентСервер.ПриИзмененииРеквизита(ЭтотОбъект);
	//-- НЕ УТ
	
КонецПроцедуры

#КонецОбласти
