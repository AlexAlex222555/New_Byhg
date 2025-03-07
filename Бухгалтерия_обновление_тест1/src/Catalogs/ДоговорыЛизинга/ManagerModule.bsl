#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов
// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
// Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт
КонецПроцедуры
// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

// Выполняет поиск действующего договора лизинга для документа.
// Если найден один действующий договор, возвращает ссылку на него, в противном случае - пустую ссылку.
//
// Параметры:
//		Объект - ДокументОбъект.ПриобретениеУслугПоЛизингу - Документ, в котором необходимо заполнить договор по умолчанию.
//
// Возвращаемое значение:
// 		СправочникСсылка.ДоговорыЛизинга - Договор по умолчанию.
//
Функция ДоговорПоУмолчанию(Объект) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	ДоговорыЛизинга.Ссылка КАК Ссылка
	|
	|ИЗ
	|	Справочник.ДоговорыЛизинга КАК ДоговорыЛизинга
	|ГДЕ
	|	(НЕ ДоговорыЛизинга.ПометкаУдаления)
	|	И ДоговорыЛизинга.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыДоговоровКонтрагентов.Действует)
	|	И ДоговорыЛизинга.Партнер = &Партнер
	|	И ДоговорыЛизинга.Контрагент = &Контрагент
	|	И ДоговорыЛизинга.Организация = &Организация
	|	И ДоговорыЛизинга.Ссылка = &ТекущийДоговор
	|;
	|
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 2
	|	ДоговорыЛизинга.Ссылка КАК Ссылка
	|
	|ИЗ
	|	Справочник.ДоговорыЛизинга КАК ДоговорыЛизинга
	|ГДЕ
	|	(НЕ ДоговорыЛизинга.ПометкаУдаления)
	|	И ДоговорыЛизинга.Статус = ЗНАЧЕНИЕ(Перечисление.СтатусыДоговоровКонтрагентов.Действует)
	|	И ДоговорыЛизинга.Партнер = &Партнер
	|	И ДоговорыЛизинга.Контрагент = &Контрагент
	|	И ДоговорыЛизинга.Организация = &Организация
	|";
	Запрос.УстановитьПараметр("ТекущийДоговор", Объект.Договор);
	Запрос.УстановитьПараметр("Партнер",        Объект.Партнер);
	Запрос.УстановитьПараметр("Контрагент",     Объект.Контрагент);
	Запрос.УстановитьПараметр("Организация",    Объект.Организация);
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	Если Не МассивРезультатов[0].Пустой() Тогда
		
		Выборка = МассивРезультатов[0].Выбрать();
		Выборка.Следующий();
		
		ДоговорПоУмолчанию = Выборка.Ссылка;
		
	Иначе
		Выборка = МассивРезультатов[1].Выбрать();
	
		Если Не Выборка.Следующий() Тогда
			ДоговорПоУмолчанию = Справочники.ДоговорыЛизинга.ПустаяСсылка();
		ИначеЕсли Выборка.Количество() = 1 Тогда
			ДоговорПоУмолчанию = Выборка.Ссылка;
		Иначе
			ДоговорПоУмолчанию = Справочники.ДоговорыЛизинга.ПустаяСсылка();
		КонецЕсли;
	КонецЕсли;
	
	Возврат ДоговорПоУмолчанию;
	
КонецФункции

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП.
//
// Возвращаемое значение:
//  Массив - список имен реквизитов объекта.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("Партнер");
	Результат.Добавить("Контрагент");
	Результат.Добавить("Организация");
	Результат.Добавить("Подразделение");
	Результат.Добавить("НаправлениеДеятельности");
	Результат.Добавить("ОплатаВВалюте");
	Результат.Добавить("ВалютаВзаиморасчетов");
	
	Результат.Добавить("ВариантУчетаИмущества");
	Результат.Добавить("ЕстьОбеспечительныйПлатеж");
	Результат.Добавить("ЕстьВыкупПредметаЛизинга");
	
	Результат.Добавить("ГруппаФинансовогоУчета");
	
	Возврат Результат;
	
КонецФункции

// Возвращает доступные типы платежей по договору лизинга
//
// Параметры:
//    Договор - СправочникСсылка.ДоговорыЛизинга - Договор лизинга.
//
// Возвращаемое значение:
//    Результат - Массив - Типы начислений, доступные по договору лизинга.
//
Функция ТипыПлатежейПоДоговору(Договор) Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить(Перечисления.ТипыПлатежейПоЛизингу.ЛизинговыйПлатеж);
	
	Если Не ЗначениеЗаполнено(Договор) Тогда
		Возврат Результат;
	КонецЕсли;
	
	Реквизиты = "ЕстьОбеспечительныйПлатеж, ЕстьВыкупПредметаЛизинга";
	ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Договор, Реквизиты);
	
	Если ЗначенияРеквизитов.ЕстьОбеспечительныйПлатеж Тогда
		Результат.Добавить(Перечисления.ТипыПлатежейПоЛизингу.ОбеспечительныйПлатеж);
	КонецЕсли;
	
	Если ЗначенияРеквизитов.ЕстьВыкупПредметаЛизинга Тогда
		Результат.Добавить(Перечисления.ТипыПлатежейПоЛизингу.ВыкупПредметаЛизинга);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Добавляет команду создания справочника "Договоры лизинга".
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	МетаданныеСправочника = Метаданные.Справочники.ДоговорыЛизинга;
	
	Если ПравоДоступа("Добавление", МетаданныеСправочника) Тогда
		КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
		КомандаСоздатьНаОсновании.Менеджер = МетаданныеСправочника.ПолноеИмя();
		КомандаСоздатьНаОсновании.Представление = ОбщегоНазначенияУТ.ПредставлениеОбъекта(МетаданныеСправочника);
		
		Возврат КомандаСоздатьНаОсновании;
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	БизнесПроцессы.Задание.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	
КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"ПрисоединитьДополнительныеТаблицы
	|ЭтотСписок КАК Т
	|ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ИерархияПартнеров КАК Т2 
	|	ПО Т2.Родитель = Т.Партнер
	|;
	|РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Т2.Партнер)
	|	И ЗначениеРазрешено(Т.Организация)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ОсновноеСредство") И ЗначениеЗаполнено(Параметры.ОсновноеСредство) Тогда
		Параметры.Отбор.Вставить("НаправлениеДеятельности", ВнеоборотныеАктивыВызовСервера.НаправлениеДеятельности(Параметры.ОсновноеСредство));
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ОсновноеСредство") И ЗначениеЗаполнено(Параметры.ОсновноеСредство) Тогда
		Параметры.Отбор.Вставить("НаправлениеДеятельности", ВнеоборотныеАктивыВызовСервера.НаправлениеДеятельности(Параметры.ОсновноеСредство));
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.КомандыОтчетов
//   Параметры - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.Параметры
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	Отчеты.ВедомостьРасчетовПоФинансовымИнструментам.ДобавитьКомандуОтчета(КомандыОтчетов);
	Отчеты.ПланФактныйАнализФинансовыхИнструментов.ДобавитьКомандуОтчета(КомандыОтчетов, "ПланФактныйАнализЛизингКонтекст");
	
КонецПроцедуры

Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	
	
КонецПроцедуры

#Область ОбновлениеИнформационнойБазы


#КонецОбласти

#КонецОбласти

#КонецЕсли
