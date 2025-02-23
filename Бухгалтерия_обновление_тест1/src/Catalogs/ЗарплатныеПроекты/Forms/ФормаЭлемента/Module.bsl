&НаКлиенте
Перем БылаСтруктураНаименования;

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.Ключ.Пустая() Тогда
		ЗначенияДляЗаполнения = Новый Структура;
		ЗначенияДляЗаполнения.Вставить("Организация", "Объект.Организация");
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтаФорма, ЗначенияДляЗаполнения);
	КонецЕсли;
	
	УстановитьПараметрыФункциональныхОпцийФормы(Новый Структура("Организация", Объект.Организация));
	
	УстановитьДоступностьЭлементовФормы(ЭтаФорма, Объект.ИспользоватьЭлектронныйДокументооборотСБанком);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры    

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	БылаСтруктураНаименования = СтруктураНаименования();
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("ИзмененЗарплатныйПроект", Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// Подсистема "Свойства"
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы


&НаКлиенте
Процедура БанкПриИзменении(Элемент)
	
	СформироватьАвтоНаименование();
	
КонецПроцедуры


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства
//++ ЕРП ЗИК	
&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
//-- ЕРП ЗИК	
// Конец СтандартныеПодсистемы.Свойства

 &НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементовФормы(Форма, ИспользоватьЭлектронныйДокументооборотСБанком)
	
		
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПредставлениеНаименованияЗарплатногоПроекта(СтруктураНаименования)
	
	Представление = "";
	Если ЗначениеЗаполнено(СтруктураНаименования.Банк) Тогда
		Представление = Строка(СтруктураНаименования.Банк);
	КонецЕсли;
	
	Возврат Представление;
	
КонецФункции

&НаКлиенте
Функция СтруктураНаименования()
	
	Возврат Новый Структура("Банк", Объект.Банк);
	
КонецФункции

&НаКлиенте
Процедура СформироватьАвтоНаименование()
	
	ПрежнееНаименование = ПредставлениеНаименованияЗарплатногоПроекта(БылаСтруктураНаименования);
	
	Если Не ЗначениеЗаполнено(Объект.Наименование) 
		Или ПрежнееНаименование = Объект.Наименование Тогда
		Объект.Наименование = ПредставлениеНаименованияЗарплатногоПроекта(СтруктураНаименования());
	КонецЕсли;
	
	БылаСтруктураНаименования = СтруктураНаименования();
	
КонецПроцедуры

#Область ПроцедурыПодсистемыСвойств

//++ ЕРП ЗИК	
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтаФорма, РеквизитФормыВЗначение("Объект"));
	
КонецПроцедуры
//-- ЕРП ЗИК	
#КонецОбласти

#КонецОбласти

//++ ЕРП ЗИК	
//~// СтандартныеПодсистемы.Свойства
//~&НаКлиенте
//~Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
//~	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
//~КонецПроцедуры

//~&НаСервере
//~Процедура ОбновитьЭлементыДополнительныхРеквизитов()
//~	
//~	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);

//~КонецПроцедуры

//~&НаКлиенте
//~Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
//~	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
//~КонецПроцедуры

//~&НаКлиенте
//~Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
//~	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
//~КонецПроцедуры
//~// Конец СтандартныеПодсистемы.Свойств
//-- ЕРП ЗИК

