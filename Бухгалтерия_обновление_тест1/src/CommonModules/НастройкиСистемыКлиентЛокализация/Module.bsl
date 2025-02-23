////////////////////////////////////////////////////////////////////////////////
// Клиентские процедуры и функции, управляющие настройками системы (локализация)
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++ НЕ БЗК

#Область ОбработчикиСобытий_ПанельСправочниковНСИ_КлассификаторыНоменклатуры

Процедура ОбработкаНавигационнойСсылкиФормы__КлассификаторыНоменклатуры(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	
	СтандартнаяОбработка = Ложь;
	//++ Локализация
	//-- Локализация
	Возврат;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияУТ_Закупки

Процедура ОбработкаНавигационнойСсылкиФормы_Закупки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	
	СтандартнаяОбработка = Ложь;
	//++ Локализация
	//-- Локализация
	Возврат;
КонецПроцедуры

Процедура ПриИзмененииРеквизита_Закупки(Элемент, Форма) Экспорт
	//++ Локализация
	//-- Локализация
	Возврат
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияУТ_Казначейство

Процедура ОбработкаНавигационнойСсылкиФормы_Казначейство(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	
	СтандартнаяОбработка = Ложь;
	//++ Локализация
	//-- Локализация
	Возврат;
КонецПроцедуры

Процедура ПриИзмененииРеквизита_Казначейство(Элемент, Форма) Экспорт
	//++ Локализация
	//-- Локализация
	Возврат
КонецПроцедуры

//++ Локализация
Процедура НачалоВыбораЭлементовФормы_Казначейство(Элемент, ДанныеВыбора, СтандартнаяОбработка, Форма) Экспорт
	
	Элементы = Форма.Элементы;

	
КонецПроцедуры
	
//-- Локализация
#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияУТ_НастройкиНоменклатуры

Процедура ОбработкаНавигационнойСсылкиФормы_НастройкиНоменклатуры(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	
	СтандартнаяОбработка = Ложь;
	//++ Локализация
	//-- Локализация
	Возврат;
КонецПроцедуры

Процедура ПриИзмененииРеквизита_НастройкиНоменклатуры(Элемент, Форма) Экспорт
	//++ Локализация
	//-- Локализация
	Возврат
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияУТ_НачальноеЗаполнение

Процедура ОбработкаНавигационнойСсылкиФормы_НачальноеЗаполнение(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	
	СтандартнаяОбработка = Ложь;
	//++ Локализация
	
	
	//++ НЕ УТ
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьДокументыПереносаДанныхПоЗарплате" Тогда
		ОткрытьФорму("Документ.ПереносДанных.ФормаСписка", , Форма);
	КонецЕсли;
	//-- НЕ УТ

	//-- Локализация
	Возврат;
КонецПроцедуры

Процедура ПриИзмененииРеквизита_НачальноеЗаполнение(Элемент, Форма) Экспорт
	//++ Локализация
	//-- Локализация
	Возврат
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияУТ_Продажи

Процедура ОбработкаНавигационнойСсылкиФормы_Продажи(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	
	СтандартнаяОбработка = Ложь;
	//++ Локализация
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьМобильныеПриложения" Тогда
		ОткрытьФорму("Справочник.ВерсииМобильныхПриложений.ФормаСписка", , Форма);
    КонецЕсли;
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьМобильныеКомпьютеры" Тогда
		ОткрытьФорму("Справочник.МобильныеКомпьютеры.ФормаСписка", , Форма);
    КонецЕсли;
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьНастройкиТорговыхПредставителей" Тогда
		ОткрытьФорму("ПланОбмена.МобильноеПриложениеТорговыйПредставитель.ФормаСписка",
			Новый Структура("НеОтображатьЭтотУзел", Истина),
			Форма);
	КонецЕсли;
	//-- Локализация
	Возврат;
КонецПроцедуры

Процедура ПриИзмененииРеквизита_Продажи(Элемент, Форма) Экспорт
	//++ Локализация
	//-- Локализация
	Возврат
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияУТ_Предприятие

Процедура ОбработкаНавигационнойСсылкиФормы_Предприятие(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	
	СтандартнаяОбработка = Ложь;
	//++ Локализация
	//-- Локализация
	Возврат;
КонецПроцедуры

Процедура ПриИзмененииРеквизита_Предприятие(Элемент, Форма) Экспорт
	//++ Локализация
	//-- Локализация
	Возврат
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияУТ_ФинансовыйРезультат

Процедура ОбработкаНавигационнойСсылкиФормы_ФинансовыйРезультат(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация
	СтандартнаяОбработка = Ложь;
	Если НавигационнаяСсылкаФорматированнойСтроки = "ЗаполнениеАктивовПассивов" Тогда
		ЗаполнитьАктивыПассивы(Элемент, Форма);
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "ДопНастройкиУчетаСебестоимости" Тогда
		ОткрытьФорму("Обработка.ПанельАдминистрированияУТ.Форма.ДопНастройкиУчетаСебестоимости", , Форма);
	КонецЕсли;
	//-- Локализация
	Возврат;
КонецПроцедуры

Процедура ПриИзмененииРеквизита_ФинансовыйРезультат(Элемент, Форма) Экспорт
	//++ Локализация
	НаборКонстант = Форма.НаборКонстант;
	Если Элемент.Имя = "ФормироватьУправленческийБаланс" И НаборКонстант.ФормироватьУправленческийБаланс Тогда
		ЗаполнитьАктивыПассивы(Элемент, Форма);
	КонецЕсли;	
	//-- Локализация
	Возврат
КонецПроцедуры

//++ Локализация
Процедура ЗаполнитьАктивыПассивы(Элемент, Форма)
	
	ДополнительныеПараметры = Новый Структура("Форма, Элемент", Форма, Элемент);
	ОбработчикЗакрытияФормы = Новый ОписаниеОповещения("ПослеФормированияДвиженийУпрБаланса", 
											ЭтотОбъект, ДополнительныеПараметры);
	ОткрытьФорму("Обработка.ДвиженияАктивовПассивов.Форма.ЗаполнениеРегистра",,Форма,,,,ОбработчикЗакрытияФормы);
	
КонецПроцедуры

Процедура ПослеФормированияДвиженийУпрБаланса(Результат, ДопПараметры) Экспорт
	
	Если ДопПараметры.Элемент.Имя = "ФормироватьУправленческийБаланс" Тогда
		Если Результат <> Истина Тогда
			ОбщегоНазначенияУТКлиентСервер.ВосстановитьЗначенияДоИзменения(ДопПараметры.Форма, "ФормироватьУправленческийБаланс");
			Возврат;
		КонецЕсли;
		ОбщегоНазначенияУТКлиентСервер.СохранитьЗначенияДоИзменения(ДопПараметры.Форма, "ФормироватьУправленческийБаланс");
		Оповестить("Запись_НаборКонстант", Новый Структура("Элемент", ДопПараметры.Элемент), ДопПараметры.Форма);
	КонецЕсли;
	
	Если ДопПараметры.Элемент.Имя = "ДекорацияЗаполнениеАктивовПассивов" И Результат = Истина Тогда
		Элемент = Новый Структура("Имя", "ФормироватьУправленческийБаланс");
		Оповестить("Запись_НаборКонстант", Новый Структура("Элемент", Элемент), ДопПараметры.Форма);
	КонецЕсли;
	
КонецПроцедуры
//-- Локализация

#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияУТ_Предприятие

Процедура ОбработкаНавигационнойСсылкиФормы_СинхронизацияДанных(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация
	СтандартнаяОбработка = Ложь;
	//-- Локализация
	Возврат;
КонецПроцедуры

#КонецОбласти

//++ НЕ УТ

#Область ОбработчикиСобытий_ПанельАдминистрированияКА_Производство

Процедура ПриИзмененииРеквизита_Производство(Элемент, Форма) Экспорт
	//++ Локализация
	//++ Устарело_Производство21
	Если Элемент.Имя = "ИспользоватьПроизводство21" Тогда
		ПараметрыОповещения = Новый Структура("Элемент, Форма", Элемент, Форма);
		ИспользоватьПроизводство21ПриИзмененииЗавершение(Истина, ПараметрыОповещения);
	КонецЕсли;
	//-- Устарело_Производство21
	//-- Локализация
	Возврат
КонецПроцедуры

Процедура ОбработкаНавигационнойСсылкиФормы_Производство(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка, Форма) Экспорт
	//++ Локализация
	//++ Устарело_Производство21
	СтандартнаяОбработка = Ложь;
	//-- Устарело_Производство21
	//-- Локализация
	Возврат;
КонецПроцедуры

//++ Локализация

//++ Устарело_Производство21
Процедура ИспользоватьПроизводство21ПриИзмененииЗавершение(Результат, ДопПараметры) Экспорт
	
	Если Результат <> Истина Тогда
		ОбщегоНазначенияУТКлиентСервер.ВосстановитьЗначенияДоИзменения(ДопПараметры.Форма, "ИспользоватьУправлениеПроизводством");
		Возврат;
	КонецЕсли;
	ОбщегоНазначенияУТКлиентСервер.СохранитьЗначенияДоИзменения(ДопПараметры.Форма, "ИспользоватьУправлениеПроизводством");
	Оповестить("Запись_НаборКонстант", Новый Структура("Элемент", ДопПараметры.Элемент), ДопПараметры.Форма);
КонецПроцедуры

//-- Устарело_Производство21
//-- Локализация
#КонецОбласти

#Область ОбработчикиСобытий_ПанельАдминистрированияКА_ВнеоборотныеАктивы

Процедура ОбработкаСобытияНажатия_ВнеоборотныеАктивы(Элемент, Форма) Экспорт
	
	//++ Локализация
	//-- Локализация
	
	Возврат;
	
КонецПроцедуры

Процедура ПриИзмененииРеквизитаНачалоВыбора_ВнеоборотныеАктивы(Форма, Элемент, ДанныеВыбора, СтандартнаяОбработка) Экспорт

	//++ Локализация
	
	Если Элемент.Имя = Форма.Элементы.ДатаНачалаУчетаВнеоборотныхАктивов2_4.Имя Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ПараметрыОповещения = Новый Структура;
		ПараметрыОповещения.Вставить("Форма", Форма);
		ОписаниеОповещения = Новый ОписаниеОповещения("ДатаНачалаУчетаВнеоборотныхАктивов2_4Завершение", ЭтотОбъект, ПараметрыОповещения);
		
		ПараметрыФормыВыбораПериода = Новый Структура("Значение, РежимВыбораПериода", Форма.НаборКонстант.ДатаНачалаУчетаВнеоборотныхАктивов2_4, "МЕСЯЦ");
		
		ОткрытьФорму("ОбщаяФорма.ВыборПериода",
			ПараметрыФормыВыбораПериода, 
			ЭтотОбъект, 
			Форма.УникальныйИдентификатор,,, 
			ОписаниеОповещения,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
			
	КонецЕсли; 
	
	//-- Локализация
	
	Возврат;
	
КонецПроцедуры

Процедура УчетВнеоборотныхАктивовПриИзменении(Форма, Отказ) Экспорт

	//++ Локализация
	
	Если Форма.УчетВнеоборотныхАктивов = "2_2" И НЕ Форма.ДоступностьУчета22.ДоступенУчет Тогда
		
		ПоказатьПредупреждение(, Форма.ДоступностьУчета22.КомментарийУчет2_2);
		
		Отказ = Истина;
		
	ИначеЕсли Форма.УчетВнеоборотныхАктивов = ""
		И Форма.НаличиеУчета.ИспользоватьРеглУчет Тогда
		
		ТекстСообщения = НСтр("ru='Для отключения учета необходимо выключить опцию ""Регламентированный учет"" (раздел ""Регламентированный учет"")';uk='Для відключення обліку необхідно вимкнути опцію ""Регламентований облік"" (розділ ""Регламентований облік"")'");
		
		ПоказатьПредупреждение(,ТекстСообщения); 
		
		Отказ = Истина;
		
	КонецЕсли;
	
	//-- Локализация
	
КонецПроцедуры

Процедура ПриПониженииВерсииУчетаВнеоборотныхАктивов(Форма, ТекстВопроса) Экспорт

	//++ Локализация
	
	Если Форма.УчетВнеоборотныхАктивов = ""
		И Форма.НаборКонстант.ИспользоватьВнеоборотныеАктивы2_2 Тогда
			
		Если НЕ Форма.НаличиеУчета.МожноОтключитьУчет Тогда
			ТекстВопроса = НСтр("ru='Отключать учет необоротных активов после начала работы с системой не рекомендуется.
|Продолжить редактирование?'
|;uk='Відключати облік необоротних активів після початку роботи з системою не рекомендується.
|Продовжити редагування?'");
		КонецЕсли;
		
	ИначеЕсли Форма.УчетВнеоборотныхАктивов = "2_2" И Форма.НаборКонстант.ИспользоватьВнеоборотныеАктивы2_4 Тогда
		
		Если Форма.НаличиеУчета.ЕстьУчет2_4 Тогда
			ТекстВопроса = НСтр("ru='Отключать учет необоротных активов версии 2.5 после начала работы с системой не рекомендуется.
|Продолжить редактирование?'
|;uk='Відключати облік необоротних активів версії 2.5 після початку роботи з системою не рекомендується.
|Продовжити редагування?'");
		КонецЕсли;
		
	КонецЕсли;	
	
	//-- Локализация
	
КонецПроцедуры
 
//++ Локализация

Процедура ДатаНачалаУчетаВнеоборотныхАктивов2_4Завершение(РезультатВыбора, ПараметрыОповещения) Экспорт
	
	Если РезультатВыбора = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Форма = ПараметрыОповещения.Форма;
	НаборКонстант = Форма.НаборКонстант;
	
	Если РезультатВыбора > Форма.ДоступностьУчета24.МаксимальнаяДатаНачалаУчета2_4 
		И Форма.ДоступностьУчета24.МаксимальнаяДатаНачалаУчета2_4 <> '000101010000' Тогда
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			Форма.ДоступностьУчета24.КомментарийМаксДатаНачалаУчета2_4, , "НаборКонстант.ДатаНачалаУчетаВнеоборотныхАктивов2_4");
			
		НаборКонстант.ДатаНачалаУчетаВнеоборотныхАктивов2_4 = Форма.ДоступностьУчета24.МаксимальнаяДатаНачалаУчета2_4;
			
	ИначеЕсли РезультатВыбора < Форма.ДоступностьУчета24.МинимальнаяДатаНачалаУчета2_4 
		И Форма.ДоступностьУчета24.МинимальнаяДатаНачалаУчета2_4 <> '000101010000' Тогда
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			Форма.ДоступностьУчета24.КомментарийМинДатаНачалаУчета2_4, , "НаборКонстант.ДатаНачалаУчетаВнеоборотныхАктивов2_4");
			
		НаборКонстант.ДатаНачалаУчетаВнеоборотныхАктивов2_4 = Форма.ДоступностьУчета24.МинимальнаяДатаНачалаУчета2_4;
		
	Иначе
		НаборКонстант.ДатаНачалаУчетаВнеоборотныхАктивов2_4 = РезультатВыбора;
	КонецЕсли;
	
	ДополнительныеПараметрыДействия = Новый Структура;
	ДополнительныеПараметрыДействия.Вставить("Элемент", Форма.Элементы.ДатаНачалаУчетаВнеоборотныхАктивов2_4);
	ДополнительныеПараметрыДействия.Вставить("ОбновлятьИнтерфейс", Истина);
	ОбщегоНазначенияУТКлиент.ПродолжитьИзменениеРеквизита(
		Форма,
		"ДатаНачалаУчетаВнеоборотныхАктивов2_4",,
		ДополнительныеПараметрыДействия);
		
	Оповестить("ДатаНачалаУчетаВнеоборотныхАктивов2_4_Изменение", НаборКонстант.ДатаНачалаУчетаВнеоборотныхАктивов2_4, Форма);
	
КонецПроцедуры

//-- Локализация

#КонецОбласти

//-- НЕ УТ

//-- НЕ БЗК

#КонецОбласти