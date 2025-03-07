////////////////////////////////////////////////////////////////////////////////
// Варианты отчетов - Форма отчета УП (клиент, переопределяемый)
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработчик расшифровки табличного документа формы отчета.
//
// Параметры:
//  ЭтаФорма - ФормаКлиентскогоПриложения - форма отчета.
//  Элемент     - ПолеФормы        - табличный документ.
//  Расшифровка - Произвольный     - значение расшифровки точки, серии или значения диаграммы.
//  СтандартнаяОбработка - Булево  - признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаРасшифровки(ЭтаФорма, Элемент, Расшифровка, СтандартнаяОбработка) Экспорт
	ПолноеИмяОтчета = ЭтаФорма.НастройкиОтчета.ПолноеИмя;
	КлючТекущегоВарианта = ЭтаФорма.КлючТекущегоВарианта;
	
	Если ПолноеИмяОтчета = "Отчет.РасшифровкаФормулыБюджетногоОтчета" Тогда

		СтандартнаяОбработка = Ложь;
		
		ПараметрыОткрытия = БюджетнаяОтчетностьВызовСервера.ПараметрыФормыРасшифровкиОтчетаРасшифровки(
																		Расшифровка, ЭтаФорма.ОтчетДанныеРасшифровки);
		
		Если ПараметрыОткрытия = Неопределено Тогда
			ПоказатьПредупреждение(, НСтр("ru='Нет данных для расшифровки';uk='Немає даних для розшифровки'"));
		Иначе
			БюджетнаяОтчетностьКлиент.ОткрытьФормуОтчета(ПараметрыОткрытия, ЭтаФорма);
		КонецЕсли;
		
	ИначеЕсли ПолноеИмяОтчета = "Отчет.ПроверкаСвязейПоказателейБюджетов" Тогда
		
		ДанныеРасшифровкиОтчета = БюджетированиеВызовСервера.ДанныеРасшифровкиОтчета(Расшифровка, ЭтаФорма.ОтчетДанныеРасшифровки);
		
		Если ДанныеРасшифровкиОтчета.ОсновноеДействие = ДействиеОбработкиРасшифровкиКомпоновкиДанных.Расшифровать Тогда
			СтандартнаяОбработка = Ложь;
			
			ДоступныеПоляРасшифровки  = Новый Структура;
			ДоступныеПоляРасшифровки.Вставить("ПоказательБюджетов");
			ДоступныеПоляРасшифровки.Вставить("Аналитика1");
			ДоступныеПоляРасшифровки.Вставить("Аналитика2");
			ДоступныеПоляРасшифровки.Вставить("Аналитика3");
			ДоступныеПоляРасшифровки.Вставить("Аналитика4");
			ДоступныеПоляРасшифровки.Вставить("Аналитика5");
			ДоступныеПоляРасшифровки.Вставить("Аналитика6");
			ДоступныеПоляРасшифровки.Вставить("Валюта");
			
			ПоляРасшифровки = Новый Структура;
			Для каждого Поле Из ДанныеРасшифровкиОтчета.ПоляРасшифровки Цикл
				Если ДоступныеПоляРасшифровки.Свойство(Поле.Ключ) Тогда
					ПоляРасшифровки.Вставить(Поле.Ключ, Поле.Значение);
				КонецЕсли;
			КонецЦикла;
			Для каждого Поле Из ДанныеРасшифровкиОтчета.ПоляРасшифровкиРодители Цикл
				Если ДоступныеПоляРасшифровки.Свойство(Поле.Ключ) Тогда
					ПоляРасшифровки.Вставить(Поле.Ключ, Поле.Значение);
				КонецЕсли;
			КонецЦикла;
			
			Параметры = Новый Структура;
			Параметры.Вставить("ИмяОтчета"			, "СправкаРасчетПоказателяБюджетов");
			Параметры.Вставить("КлючВарианта"		, "СправкаРасчетПоказателяБюджетов");
			Параметры.Вставить("КомпоновщикНастроек", ЭтаФорма.Отчет.КомпоновщикНастроек);
			Параметры.Вставить("ПоляРасшифровки"	, ПоляРасшифровки);
			НастройкаРасчетПоказателяБюджетов = ОтчетыУТВызовСервераПереопределяемый.НастроитьОтчетРасшифровки(Параметры);
			
			ПараметрыДанныхОсновногоОтчета = ЭтаФорма.Отчет.КомпоновщикНастроек.Настройки.ПараметрыДанных;
			
			ФиксированныеПараметры = Новый Структура("Период, Показатель", ДанныеРасшифровкиОтчета.ПараметрыДанных.Период);
			Для Каждого КлючИЗначение Из ФиксированныеПараметры Цикл
				
				ЗначениеПараметра = ?(КлючИЗначение.Ключ = "Период", КлючИЗначение.Значение,
					ПараметрыДанныхОсновногоОтчета.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных(КлючИЗначение.Ключ)).Значение);
				
				Параметр = КомпоновкаДанныхКлиентСервер.ПолучитьПараметр(НастройкаРасчетПоказателяБюджетов.ФиксированныеНастройки, КлючИЗначение.Ключ);
				Если Параметр = Неопределено Тогда
					Параметр = НастройкаРасчетПоказателяБюджетов.ФиксированныеНастройки.ПараметрыДанных.Элементы.Добавить();
					Параметр.Параметр = Новый ПараметрКомпоновкиДанных(КлючИЗначение.Ключ);
				КонецЕсли;
				КомпоновкаДанныхКлиентСервер.УстановитьПараметр(НастройкаРасчетПоказателяБюджетов.ФиксированныеНастройки,
																					КлючИЗначение.Ключ, ЗначениеПараметра, Истина);
				
			КонецЦикла;
			
			КлючНастроек = "РасшифровкаПоказателяБюджетов";
			ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("КлючВарианта",                  "СправкаРасчетПоказателяБюджетов");
			ПараметрыФормы.Вставить("КлючНазначенияИспользования",    КлючНастроек);
			ПараметрыФормы.Вставить("КлючПользовательскихНастроек",   КлючНастроек);
			ПараметрыФормы.Вставить("ПользовательскиеНастройки",      НастройкаРасчетПоказателяБюджетов.ПользовательскиеНастройки);
			ПараметрыФормы.Вставить("ФиксированныеНастройки",         НастройкаРасчетПоказателяБюджетов.ФиксированныеНастройки);
			ПараметрыФормы.Вставить("СформироватьПриОткрытии",        Истина);
			ПараметрыФормы.Вставить("ВидимостьКомандВариантовОтчетов",Ложь);
			ПараметрыФормы.Вставить("РежимРасшифровки",               Истина);
			ОткрытьФорму("Отчет.СправкаРасчетПоказателяБюджетов.Форма", ПараметрыФормы, ЭтаФорма, Истина);
		КонецЕсли;
		
	КонецЕсли;
	
	
КонецПроцедуры

// Обработчик дополнительной расшифровки (меню табличного документа формы отчета).
//
// Параметры:
//   см. ОтчетыКлиентПереопределяемый.ОбработкаДополнительнойРасшифровки().
//
Процедура ОбработкаДополнительнойРасшифровки(ЭтаФорма, Элемент, Расшифровка, СтандартнаяОбработка) Экспорт
	
	ПолноеИмяОтчета = ЭтаФорма.НастройкиОтчета.ПолноеИмя;
	КлючТекущегоВарианта = ЭтаФорма.КлючТекущегоВарианта;
	
	//++ Устарело_Производство21
	Если ПолноеИмяОтчета = "Отчет.ПроизводственныеЗатраты" И КлючТекущегоВарианта = "ДвижениеТМЦиПроизводственныеЗатраты" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ДоступныеДействия = Новый Массив;
		ДоступныеДействия.Добавить(ДействиеОбработкиРасшифровкиКомпоновкиДанных.ОткрытьЗначение);
		ДоступныеДействия.Добавить(ДействиеОбработкиРасшифровкиКомпоновкиДанных.Отфильтровать);
		ДоступныеДействия.Добавить(ДействиеОбработкиРасшифровкиКомпоновкиДанных.Оформить);
		ДоступныеДействия.Добавить(ДействиеОбработкиРасшифровкиКомпоновкиДанных.Сгруппировать);
		ДоступныеДействия.Добавить(ДействиеОбработкиРасшифровкиКомпоновкиДанных.Упорядочить);
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Расшифровка", Расшифровка);
		ДополнительныеПараметры.Вставить("ДанныеРасшифровки", ЭтаФорма.ОтчетДанныеРасшифровки);
		ДополнительныеПараметры.Вставить("АдресСхемы", ЭтаФорма.Отчет);
		ДополнительныеПараметры.Вставить("КлючОбъекта", ЭтаФорма.НастройкиОтчета.ПолноеИмя);
		ДополнительныеПараметры.Вставить("ПараметрыОбработчика", Неопределено);
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаРасшифровкиСДополнительнымМенюЗавершение", КомпоновкаДанныхКлиент, ДополнительныеПараметры);
		
		ОбработкаРасшифровки = Новый ОбработкаРасшифровкиКомпоновкиДанных(
			ЭтаФорма.ОтчетДанныеРасшифровки, 
			Новый ИсточникДоступныхНастроекКомпоновкиДанных(ЭтаФорма.Отчет));
		
		ОбработкаРасшифровки.ПоказатьВыборДействия(
			ОписаниеОповещения, 
			Расшифровка,
			ДоступныеДействия);
		
	КонецЕсли;
	//-- Устарело_Производство21
	
КонецПроцедуры

// Обработчик команд, добавленных динамически.
//
// Параметры:
//   см. ОтчетыКлиентПереопределяемый.ОбработчикКоманды().
//
Процедура ОбработчикКоманды(ЭтаФорма, Команда, Результат) Экспорт
	
	ПолноеИмяОтчета = ЭтаФорма.НастройкиОтчета.ПолноеИмя;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Отчет", ПолноеИмяОтчета);
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда, ДополнительныеПараметры); 
	
	
КонецПроцедуры

// Обработчик результата выбора подчиненной формы.
//
// Параметры:
//   см. ОтчетыКлиентПереопределяемый.ОбработкаВыбора().
//
Процедура ОбработкаВыбора(ЭтаФорма, ВыбранноеЗначение, ИсточникВыбора, Результат) Экспорт
	
КонецПроцедуры

// Обработчик оповещения формы отчета.
//
// Параметры:
//   см. ОтчетыКлиентПереопределяемый.ОбработкаОповещения().
//
Процедура ОбработкаОповещения(ЭтаФорма, ИмяСобытия, Параметр, Источник) Экспорт
	
КонецПроцедуры
 
// Обработчик специальных действий при расшифровке отчетов.
// Например, открытие специализированных форм с параметризацией.
//
//	Параметры:
//		ПараметрыДействия - Структура
//			Имя - Строка - Имя выполняемого действия
//			Заголовок - Строка - Пользовательское представление выполняемого действия
//		ПараметрыРасшифровки - Структура - Параметры, передаваемые в форму.
//
Процедура ВыполнитьДействиеРасшифровки(ПараметрыДействия, ПараметрыРасшифровки) Экспорт
	
		
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
										НСтр("ru='Не определен обработчик действия %1.';uk='Не визначено обробник дії %1.'"),
										ПараметрыДействия.Заголовок);

КонецПроцедуры

// Метод вызывается из формы отчета после его формирования.
//
//	Параметры:
//		ФормаОтчета - ФормаКлиентскогоПриложения - форма отчета.
//
Процедура ПослеФормированияНаКлиенте(ФормаОтчета) Экспорт
	
	ДопСвойства = ФормаОтчета.Отчет.КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства;
	ТребуетсяОбработчикОжидания = Ложь;
	Если ТипЗнч(ПараметрыПроверкиФоновыхЗаданий) <> Тип("Структура") Тогда
		ПараметрыПроверкиФоновыхЗаданий = Новый Структура;
		ПараметрыПроверкиФоновыхЗаданий.Вставить("Задания", Новый Структура());
		ПараметрыПроверкиФоновыхЗаданий.Вставить("Интервал", 7);
	КонецЕсли;
	Если ДопСвойства.Свойство("КоличествоДокументовКОтражениюВБюджетировании") Тогда
		ТребуетсяОбработчикОжидания = Истина;
		Если НЕ ПараметрыПроверкиФоновыхЗаданий.Задания.Свойство("ОтражениеДокументовВБюджетировании") Тогда
			ПараметрыТекущегоВызова = Новый Структура("НачалоПериода, КонецПериода", ДопСвойства.НачалоПериода, ДопСвойства.КонецПериода);
			ПараметрыЗадания = Новый Структура("Параметры, Формы", ПараметрыТекущегоВызова, Новый Соответствие());
			ПараметрыПроверкиФоновыхЗаданий.Задания.Вставить("ОтражениеДокументовВБюджетировании", ПараметрыЗадания);
		КонецЕсли;
		ПараметрыЗадания = ПараметрыПроверкиФоновыхЗаданий.Задания.ОтражениеДокументовВБюджетировании.Формы;
		ПараметрыФормы = Новый Структура("НачалоПериода, КонецПериода", ДопСвойства.НачалоПериода, ДопСвойства.КонецПериода);
		ПараметрыЗадания.Вставить(ФормаОтчета, ПараметрыФормы);
	КонецЕсли;
	Если ТребуетсяОбработчикОжидания Тогда
		ФормаОтчета.ПодключитьОбработчикОжидания("ПроверитьФоновыеЗадания", ПараметрыПроверкиФоновыхЗаданий.Интервал, Истина);
	КонецЕсли;
	
КонецПроцедуры

// Метод вызывается из формы отчета после его формирования.
//
//	Параметры:
//		Ответ - КодВозвратаДиалога - При варианте "Да" будут выполнено переформирование форм
//		ПараметрыВыполнения - Структура - Содержит в себе перечень форм, которые необходимо переформировать.
//
Процедура ФормаОтчетаПослеПодтвержденияПереформирования(Ответ, ПараметрыВыполнения) Экспорт
	Перем НеобработанныеФормы;
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	Для Каждого ФормаОтчета Из ПараметрыВыполнения.Формы Цикл
		ФормаОтчета.ПодключитьОбработчикОжидания("Сформировать", 1, Истина);
	КонецЦикла;
	Если ПараметрыВыполнения.Свойство("НеобработанныеФормы", НеобработанныеФормы) Тогда
		Периоды = Новый Массив;
		Для Каждого КлючИЗначение Из НеобработанныеФормы Цикл
			Периоды.Добавить(КлючИЗначение.Значение.НачалоПериода);
			Периоды.Добавить(КлючИЗначение.Значение.КонецПериода);
		КонецЦикла;
		БюджетнаяОтчетностьВызовСервера.ОтразитьДокументыФоновымЗаданиемПоФормеСМаксимальнымПериодом(Периоды);
		Для Каждого КлючИЗначение Из НеобработанныеФормы Цикл
			ПослеФормированияНаКлиенте(КлючИЗначение.Ключ);
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

// Возникает после окончания формирования отчета.
//
// Параметры:
//   ФормаОтчета - ФормаКлиентскогоПриложения - Форма отчета.
//   ОтчетСформирован - Булево - Истина если отчет был успешно сформирован.
//
Процедура ПослеФормирования(ФормаОтчета, ОтчетСформирован) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти 