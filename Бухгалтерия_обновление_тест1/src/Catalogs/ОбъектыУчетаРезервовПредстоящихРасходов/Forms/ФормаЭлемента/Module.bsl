
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Объект", Объект);
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	ДополнительныеПараметры.Вставить("ОтложеннаяИнициализация", Истина);
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтаФорма, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
	// Обработчик подсистемы запрета редактирования реквизитов объектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииСозданииНаСервере();
	КонецЕсли;
	
	ПараметрыВыбораСтатейИАналитик = Справочники.ОбъектыУчетаРезервовПредстоящихРасходов.ПараметрыВыбораСтатейИАналитик();
	ДоходыИРасходыСервер.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыВыбораСтатейИАналитик);
	
	УстановитьУсловноеОформление();
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ПриЧтенииСозданииНаСервере();
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
	ПараметрыВыбораСтатейИАналитик = Справочники.ОбъектыУчетаРезервовПредстоящихРасходов.ПараметрыВыбораСтатейИАналитик();
	ДоходыИРасходыСервер.ПриЧтенииНаСервере(ЭтотОбъект, ПараметрыВыбораСтатейИАналитик);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	Для каждого Строка Из Объект.ИспользованиеРезерва Цикл
		ЗаполнитьРеквизитыИспользованияРезерва(Строка.ПолучитьИдентификатор());
	КонецЦикла;
	
	// Обработчик подсистемы запрета редактирования реквизитов объектов
	ЗапретРедактированияРеквизитовОбъектов.ЗаблокироватьРеквизиты(ЭтотОбъект);
	
	ДоходыИРасходыСервер.ПослеЗаписиНаСервере(ЭтотОбъект);

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	СсылкаНового = Неопределено;
	Для каждого Строка Из Объект.ИспользованиеРезерва Цикл
		
		ИндексСтроки = Объект.ИспользованиеРезерва.Индекс(Строка);
		СтрокаТекущегоОбъекта = ТекущийОбъект.ИспользованиеРезерва.Получить(ИндексСтроки);
		Если Строка.АналитикаОбъектУчетаРезервов И Не ЗначениеЗаполнено(Строка.АналитикаРасходов) Тогда
			Если ТекущийОбъект.ЭтоНовый() Тогда
				Если СсылкаНового = Неопределено Тогда
					НоваяСсылка = Справочники.ОбъектыУчетаРезервовПредстоящихРасходов.ПолучитьСсылку();
					ТекущийОбъект.УстановитьСсылкуНового(НоваяСсылка);
					СсылкаНового = ТекущийОбъект.ПолучитьСсылкуНового();
				КонецЕсли;
				СтрокаТекущегоОбъекта.АналитикаРасходов = СсылкаНового;		
			Иначе
				СтрокаТекущегоОбъекта.АналитикаРасходов = ТекущийОбъект.Ссылка;
			КонецЕсли;
		КонецЕсли;
		СтрокаТекущегоОбъекта.ЛюбаяАналитикаРасходов = Не Строка.АналитикаРасходовУказана И Не Строка.АналитикаОбъектУчетаРезервов;
		
	КонецЦикла;
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Ошибки = Неопределено;
	
	Если Объект.НачалоПериода > Объект.КонецПериода И ЗначениеЗаполнено(Объект.КонецПериода) Тогда
		ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(
			Ошибки,
			"Объект.КонецПериода",
			НСтр("ru='Дата окончания действия резерва меньше даты начала';uk='Дата закінчення дії резерву менше дати початку'"),
			Неопределено);
	КонецЕсли;
	
	Если Ошибки <> Неопределено Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства 
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СтатьяРасходовНачисленияПриИзменении(Элемент)
	
	ДоходыИРасходыКлиентСервер.СтатьяПриИзменении(ЭтотОбъект, Элемент);
	
КонецПроцедуры
	
&НаКлиенте
Процедура СтатьяДоходовСписанияПриИзменении(Элемент)
	
	ДоходыИРасходыКлиентСервер.СтатьяПриИзменении(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СтатьяРасходовНачисленияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.НачалоВыбораСтатьи(ЭтотОбъект, Элемент, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура СтатьяДоходовСписанияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.НачалоВыбораСтатьи(ЭтотОбъект, Элемент, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура АналитикаРасходовНачисленияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.НачалоВыбораАналитикиРасходов(ЭтотОбъект, Элемент, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура АналитикаРасходовНачисленияАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.АвтоПодборАналитикиРасходов(ЭтотОбъект, Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура АналитикаРасходовНачисленияОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.ОкончаниеВводаТекстаАналитикиРасходов(ЭтотОбъект, Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ГруппаСтраницыПриСменеСтраницы(Элемент, ТекущаяСтраница)
	
	// СтандартныеПодсистемы.Свойства	
	Если ЭтотОбъект.ПараметрыСвойств.Свойство(ТекущаяСтраница.Имя)
		И Не ЭтотОбъект.ПараметрыСвойств.ВыполненаОтложеннаяИнициализация Тогда
		
		СвойстваВыполнитьОтложеннуюИнициализацию();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормы

&НаКлиенте
Процедура ИспользованиеРезерваПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	ТекущиеДанные = Элементы.ИспользованиеРезерва.ТекущиеДанные;
	ДоходыИРасходыКлиентСервер.ПриДобавленииСтрокиВТаблицу(ЭтотОбъект, ТекущиеДанные, "Объект.ИспользованиеРезерва");
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеРезерваСтатьяРасходовПриИзменении(Элемент)
	
	ЗаполнитьРеквизитыИспользованияРезерва(Элементы.ИспользованиеРезерва.ТекущаяСтрока, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеРезерваСтатьяРасходовНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.НачалоВыбораСтатьи(ЭтотОбъект, Элемент, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеРезерваАналитикаРасходовНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.НачалоВыбораАналитикиРасходов(ЭтотОбъект, Элемент, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеРезерваАналитикаРасходовАвтоПодбор(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.АвтоПодборАналитикиРасходов(ЭтотОбъект, Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеРезерваАналитикаРасходовОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	ДоходыИРасходыКлиент.ОкончаниеВводаТекстаАналитикиРасходов(ЭтотОбъект, Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область СтандартныеПодсистемы

// СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РазрешитьРедактированиеРеквизитовОбъекта(Команда)
	
	ЗапретРедактированияРеквизитовОбъектовКлиент.РазрешитьРедактированиеРеквизитовОбъекта(ЭтотОбъект);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	Для каждого Строка Из Объект.ИспользованиеРезерва Цикл
		ЗаполнитьРеквизитыИспользованияРезерва(Строка.ПолучитьИдентификатор());
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьРеквизитыИспользованияРезерва(ИдентификаторСтроки, ПриИзмененииСтатьи = Ложь)
	
	Если ПриИзмененииСтатьи Тогда
		ДоходыИРасходыКлиентСервер.СтатьяПриИзменении(ЭтотОбъект, Элементы.ИспользованиеРезерваСтатьяРасходов);
	КонецЕсли;

	Строка = Объект.ИспользованиеРезерва.НайтиПоИдентификатору(ИдентификаторСтроки);
	
	АналитикаОбъектУчетаРезервов = Ложь;
	АналитикаРасходовУказана = ?(ПриИзмененииСтатьи, Строка.АналитикаРасходовУказана, Не Строка.ЛюбаяАналитикаРасходов);
	
	Если ЗначениеЗаполнено(Строка.СтатьяРасходов) Тогда
		РеквизитыСтатьиРасходов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Строка.СтатьяРасходов, "ТипЗначения");
		Если РеквизитыСтатьиРасходов.ТипЗначения.СодержитТип(Тип("СправочникСсылка.ОбъектыУчетаРезервовПредстоящихРасходов")) Тогда
			АналитикаОбъектУчетаРезервов = Истина;
			АналитикаРасходовУказана = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Строка.АналитикаОбъектУчетаРезервов = АналитикаОбъектУчетаРезервов;
	Строка.АналитикаРасходовУказана = АналитикаРасходовУказана;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()

	УсловноеОформление.Элементы.Очистить();

	//

	Элемент = УсловноеОформление.Элементы.Добавить();
	КомпоновкаДанныхКлиентСервер.ДобавитьОформляемоеПоле(Элемент.Поля, Элементы.ИспользованиеРезерваАналитикаРасходов.Имя);
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ИспользованиеРезерва.АналитикаОбъектУчетаРезервов", Ложь);
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ИспользованиеРезерва.АналитикаРасходовУказана", Истина);
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ИспользованиеРезерва.АналитикаРасходов", Неопределено, ВидСравненияКомпоновкиДанных.НеЗаполнено);
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Ложь);
	
	//
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	КомпоновкаДанныхКлиентСервер.ДобавитьОформляемоеПоле(Элемент.Поля, Элементы.ИспользованиеРезерваАналитикаРасходов.Имя);
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ИспользованиеРезерва.АналитикаРасходовУказана", Ложь);
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ИспользованиеРезерва.АналитикаОбъектУчетаРезервов", Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='<любая аналитика>';uk='<будь-яка аналітика>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);
	
	//
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	КомпоновкаДанныхКлиентСервер.ДобавитьОформляемоеПоле(Элемент.Поля, Элементы.ИспользованиеРезерваАналитикаРасходов.Имя);
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ИспользованиеРезерва.АналитикаРасходовУказана", Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Ложь);
	//
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	КомпоновкаДанныхКлиентСервер.ДобавитьОформляемоеПоле(Элемент.Поля, Элементы.ИспользованиеРезерваАналитикаРасходов.Имя);
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ИспользованиеРезерва.АналитикаОбъектУчетаРезервов", Истина);
	Элемент.Оформление.УстановитьЗначениеПараметра("ОтметкаНезаполненного", Ложь);
	Элемент.Оформление.УстановитьЗначениеПараметра("Текст", НСтр("ru='<этот объект учета резервов>';uk='<цей об''єкт обліку резервів>'"));
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);
	
	//
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	КомпоновкаДанныхКлиентСервер.ДобавитьОформляемоеПоле(Элемент.Поля, Элементы.ИспользованиеРезерваАналитикаРасходовУказана.Имя);
	КомпоновкаДанныхКлиентСервер.ДобавитьОтбор(Элемент.Отбор, "Объект.ИспользованиеРезерва.АналитикаОбъектУчетаРезервов", Истина);
	Элемент.Оформление.УстановитьЗначениеПараметра("ТолькоПросмотр", Истина);
	
КонецПроцедуры

#Область СтандартныеПодсистемыСвойства

// СтандартныеПодсистемы.Свойства 

&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()

	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);

КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаСервере
Процедура СвойстваВыполнитьОтложеннуюИнициализацию()
	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(ЭтотОбъект);
КонецПроцедуры

// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#КонецОбласти