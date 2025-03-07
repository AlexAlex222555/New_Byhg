
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.РежимВыбора Тогда
		Элементы.Список.РежимВыбора = Истина;
		Если Параметры.Свойство("ПоказыватьНеиспользуемыеПоказатели") Тогда
			ПоказыватьНеиспользуемыеПоказатели = Параметры.ПоказыватьНеиспользуемыеПоказатели;
		КонецЕсли;
		Если ЗначениеЗаполнено(Параметры.ТекущаяСтрока) Тогда
			ПоказыватьНеиспользуемыеПоказатели = Параметры.ТекущаяСтрока.НеИспользуется;
		КонецЕсли;
	Иначе
		Если Параметры.Свойство("ПоказыватьНеиспользуемыеПоказатели") Тогда
			ПоказыватьНеиспользуемыеПоказатели = Параметры.ПоказыватьНеиспользуемыеПоказатели;
		КонецЕсли;
	КонецЕсли;
	
	УстановитьОтборСписка(Список.Отбор, ПоказыватьНеиспользуемыеПоказатели);
	
	
	
	ЗарплатаКадры.ПриСозданииНаСервереФормыСДинамическимСписком(ЭтотОбъект, "Список",,,, "НеИспользуется, ИмяПредопределенныхДанных");
//++ ЕРП ЗИК
	//~Элементы.ФормаПереместитьЭлементВверх.Видимость = Ложь;
	//~Элементы.ФормаПереместитьЭлементВниз.Видимость = Ложь;
//-- ЕРП ЗИК	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПоказыватьНеиспользуемыеПоказателиПриИзменении(Элемент)
	
	УстановитьОтборСписка(Список.Отбор, ПоказыватьНеиспользуемыеПоказатели);
	
КонецПроцедуры

&НаСервере
Процедура СписокПередЗагрузкойПользовательскихНастроекНаСервере(Элемент, Настройки)
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект, Истина);
КонецПроцедуры

&НаСервере
Процедура СписокПриОбновленииСоставаПользовательскихНастроекНаСервере(СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадры.ПроверитьПользовательскиеНастройкиДинамическогоСписка(ЭтотОбъект);
	
КонецПроцедуры

#Область ПроцедурыПодсистемыНастройкиПорядкаЭлементов

&НаКлиенте
Процедура ПереместитьЭлементВверх(Команда)
//++ ЕРП ЗИК

	
//-- ЕРП ЗИК	
КонецПроцедуры	

&НаКлиенте
Процедура ПереместитьЭлементВниз(Команда)
//++ ЕРП ЗИК


//-- ЕРП ЗИК	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиКомандФормы


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьОтборСписка(ГруппаОтбора, ПоказыватьНеиспользуемыеПоказатели)
	
	ОбщегоНазначенияКлиентСервер.УдалитьЭлементыГруппыОтбора(ГруппаОтбора, "НеИспользуется");
	
	Если Не ПоказыватьНеиспользуемыеПоказатели Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбора(ГруппаОтбора, "НеИспользуется", Ложь);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
