
#Область ПрограммныйИнтерфейс

// Устарела.
// Процедура возвращает надпись "Валюты" для формы документа.
//
// Параметры:
//	ПараметрыДокумента - Структура - Структура параметров вызывающей формы, конструктор ВзаиморасчетыКлиентСервер.ПараметрыНадписиВалюты.
// 
Функция СформироватьНадписьВалюты(ПараметрыДокумента) Экспорт

	Если ПараметрыДокумента.СуммаДокумента = 0 Тогда
		ТекстСуммаДокумента = "";
	Иначе
		ТекстСуммаДокумента = " " + Формат(ПараметрыДокумента.СуммаДокумента, "ЧДЦ=2");
	КонецЕсли;
	
	Если ПараметрыДокумента.ВалютаДокумента = ПараметрыДокумента.ВалютаВзаиморасчетов ИЛИ ПараметрыДокумента.НеПоказыватьРасчеты Тогда
		
		НадписьВалюты = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Документ и расчеты:%1 %2';uk='Документ і розрахунки: %1 %2'"),
				ТекстСуммаДокумента,
				ПараметрыДокумента.ВалютаДокумента);
		
	Иначе
		
		ТекстДокумент = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Документ%1 %2';uk='Документ %1 %2'"),
				ТекстСуммаДокумента,
				ПараметрыДокумента.ВалютаДокумента);
		
		Если ПараметрыДокумента.СуммаВзаиморасчетов = 0 Тогда
			ТекстСуммаВзаиморасчетов = "";
		Иначе
			ТекстСуммаВзаиморасчетов = " " + Формат(ПараметрыДокумента.СуммаВзаиморасчетов, "ЧДЦ=2");
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ПараметрыДокумента.ВалютаВзаиморасчетов) Тогда
			ТекстВалютаВзаиморасчетов = ПараметрыДокумента.ВалютаВзаиморасчетов;
		Иначе
			ТекстВалютаВзаиморасчетов = НСтр("ru='<Не выбрана>';uk='<Не вибрана>'")
		КонецЕсли;
		
		ТекстРасчеты = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru=', Расчеты%1 %2';uk=', Розрахунки %1 %2'"),
				ТекстСуммаВзаиморасчетов,
				ТекстВалютаВзаиморасчетов);
		
		Если НЕ ЗначениеЗаполнено(ПараметрыДокумента.ВалютаВзаиморасчетов) Тогда
			
			ТекстРасшифровка = "";
			
		ИначеЕсли ПараметрыДокумента.ВалютаДокумента = ПараметрыДокумента.ВалютаРеглУчета
			ИЛИ ПараметрыДокумента.ВалютаВзаиморасчетов = ПараметрыДокумента.ВалютаРеглУчета Тогда
			
			ВалютаНадписи = ?(ПараметрыДокумента.ВалютаРеглУчета = ПараметрыДокумента.ВалютаДокумента,
							ПараметрыДокумента.ВалютаВзаиморасчетов,
							ПараметрыДокумента.ВалютаДокумента);
			
			Если ПараметрыДокумента.Кратность = 1 Тогда
				
					ТекстРасшифровка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						"(%1=%2 %3)",
						ВалютаНадписи,
						ПараметрыДокумента.Курс,
						ПараметрыДокумента.ВалютаРеглУчета);
				
				Иначе
					
					ТекстРасшифровка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru='(%1 %2 за %3 %4)';uk='(%1 %2 за %3 %4)'"),
						ПараметрыДокумента.Курс,
						ПараметрыДокумента.ВалютаРеглУчета,
						ПараметрыДокумента.Кратность,
						ВалютаНадписи);
					
			КонецЕсли;
			
		Иначе
			
			Если ПараметрыДокумента.Кратность = 1 Тогда
				
				ТекстРасшифровка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					"(%1=%2 %3)",
					ПараметрыДокумента.ВалютаДокумента,
					ПараметрыДокумента.Курс,
					ПараметрыДокумента.ВалютаВзаиморасчетов);
			Иначе
				
				ТекстКурс = Строка(ПараметрыДокумента.Курс) + " " + ПараметрыДокумента.ВалютаВзаиморасчетов;
				
				ТекстКратность= Строка(ПараметрыДокумента.Кратность);
				
				ТекстРасшифровка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					"(%1=%2 %3)",
					ТекстКурс,
					ТекстКратность,
					ПараметрыДокумента.ВалютаДокумента);
					
			КонецЕсли;
			
		КонецЕсли;
		
		НадписьВалюты = ТекстДокумент + " " + ТекстРасчеты + " " + ТекстРасшифровка;
		
	КонецЕсли;
	
	Возврат НадписьВалюты;
	
КонецФункции

// Возвращает пустую структуру параметров формирования надписи Валюты и курсы документа.
//
// Возвращаемое значение:
//  Структура - параметры для заполнения в форме.
//
Функция ПараметрыНадписиВалюты() Экспорт
	
	Возврат Новый Структура("НеПоказыватьРасчеты,
							|ВалютаДокумента,
							|ВалютаВзаиморасчетов,
							|ВалютаРеглУчета,
							|СуммаДокумента,
							|СуммаВзаиморасчетов,
							|Курс,
							|Кратность", ЛОЖЬ);
	
КонецФункции

// Рассчитывает конечное сальдо в табличной части Группировка финансовых инструментов документа СверкаВзаиморасчетов.
//
// Параметры:
//  Группировка - ДанныеФормыКоллекция - Текущая строка табличной части группировки.
//  ДетальныеЗаписи - ДанныеФормыКоллекция - Табличная часть детальных записей финансовых инструментов.
//
Процедура РассчитатьКонечноеСальдоПоФинансовымИнструментам(Группировка, ДетальныеЗаписи) Экспорт
	
	Отбор = Новый Структура("Договор");
	ЗаполнитьЗначенияСвойств(Отбор, Группировка);
	
	ДеталиГруппировки = ДетальныеЗаписи.НайтиСтроки(Отбор);
	
	ОборотАктив = Новый Структура("Дт, Кт", 0, 0);
	ОборотПассив = Новый Структура("Дт, Кт", 0, 0);
	Для Каждого Запись Из ДеталиГруппировки Цикл
		Если Группировка.ТипРасчетов = ПредопределенноеЗначение("Перечисление.ТипыРасчетовСПартнерами.РасчетыСЛизингодателем") Тогда
			ДобавитьОборот(ОборотПассив, Запись, "АрендныеОбязательства");
			ДобавитьОборот(ОборотАктив, Запись, "ОбеспечительныйПлатеж");
			ДобавитьОборот(ОборотПассив, Запись, "ЛизинговыйПлатеж");
			ДобавитьОборот(ОборотПассив, Запись, "ВыкупПредметаЛизинга");
			
		ИначеЕсли Группировка.ТипРасчетов = ПредопределенноеЗначение("Перечисление.ТипыРасчетовСПартнерами.РасчетыСКредитором") Тогда
			ДобавитьОборот(ОборотПассив, Запись, "ОсновнойДолг");
			ДобавитьОборот(ОборотПассив, Запись, "Проценты");
			ДобавитьОборот(ОборотПассив, Запись, "Комиссия");
			
		Иначе
			ДобавитьОборот(ОборотАктив, Запись, "ОсновнойДолг");
			ДобавитьОборот(ОборотАктив, Запись, "Проценты");
			ДобавитьОборот(ОборотАктив, Запись, "Комиссия");
			
		КонецЕсли;
	КонецЦикла;
	
	Группировка.КонечноеСальдоДт = Группировка.НачальноеСальдоДт + ОборотАктив.Дт - ОборотАктив.Кт;
	Группировка.КонечноеСальдоКт = Группировка.НачальноеСальдоКт - ОборотПассив.Дт + ОборотПассив.Кт;
	Группировка.ОборотПриход = ОборотАктив.Дт + ОборотПассив.Дт;
	Группировка.ОборотРасход = ОборотАктив.Кт + ОборотПассив.Кт;
	
	// установим конечное сальдо, если не было начального
	Если Группировка.НачальноеСальдоДт = 0 Тогда
		Группировка.КонечноеСальдоДт = ОборотАктив.Дт - ОборотАктив.Кт;
	КонецЕсли;
		
	Если Группировка.НачальноеСальдоКт = 0 Тогда
		Группировка.КонечноеСальдоКт = -ОборотПассив.Дт + ОборотПассив.Кт;
	КонецЕсли;
	
	Если Группировка.ТипРасчетов <> ПредопределенноеЗначение("Перечисление.ТипыРасчетовСПартнерами.РасчетыСЛизингодателем") Тогда
		КонечноеСальдо = Группировка.КонечноеСальдоДт - Группировка.КонечноеСальдоКт;
		Если КонечноеСальдо > 0 Тогда
			Группировка.КонечноеСальдоДт = КонечноеСальдо;
			Группировка.КонечноеСальдоКт = 0;
		Иначе
			Группировка.КонечноеСальдоДт = 0;
			Группировка.КонечноеСальдоКт = -КонечноеСальдо;
		КонецЕсли;
	КонецЕсли;
	
	Если Группировка.КонечноеСальдоДт < 0 Тогда
		Группировка.КонечноеСальдоКт = Группировка.КонечноеСальдоКт - Группировка.КонечноеСальдоДт;
		Группировка.КонечноеСальдоДт = 0;
	КонецЕсли;
	Если Группировка.КонечноеСальдоКт < 0 Тогда
		Группировка.КонечноеСальдоДт = Группировка.КонечноеСальдоДт - Группировка.КонечноеСальдоКт;
		Группировка.КонечноеСальдоКт = 0;
	КонецЕсли;
	
КонецПроцедуры

// Рассчитывает конечное сальдо в табличной части Группировка взаиморасчетов документа СверкаВзаиморасчетов.
//
// Параметры:
//  Группировка - ДанныеФормыКоллекция - Текущая строка табличной части группировки.
//  ДетальныеЗаписи - ДанныеФормыКоллекция - Табличная часть детальных записей взаиморасчетов.
//
Процедура РассчитатьКонечноеСальдоПоВзаиморасчетам(Группировка, ДетальныеЗаписи) Экспорт
	
	Отбор = Новый Структура("ОбъектРасчетов");
	ЗаполнитьЗначенияСвойств(Отбор, Группировка);
	
	ДеталиГруппировки = ДетальныеЗаписи.НайтиСтроки(Отбор);
	Обороты = Новый Структура("Приход, Расход",0,0);
	Для Каждого Запись Из ДеталиГруппировки Цикл
			
		Если Запись.СуммаДолг > 0 Тогда
			Обороты.Приход = Обороты.Приход + Запись.СуммаДолг;
		Иначе
			Обороты.Расход = Обороты.Расход + (-Запись.СуммаДолг);
		КонецЕсли;
		
		Если Запись.СуммаАванс > 0 Тогда
			Обороты.Расход = Обороты.Расход + Запись.СуммаАванс;
		Иначе
			Обороты.Приход = Обороты.Приход + (-Запись.СуммаАванс);
		КонецЕсли;
		
	КонецЦикла;
	
	Группировка.ОборотПриход = Обороты.Приход;
	Группировка.ОборотРасход = Обороты.Расход;
	Группировка.КонечноеСальдо = Группировка.НачальноеСальдо + Группировка.ОборотПриход - Группировка.ОборотРасход;
	
КонецПроцедуры

// Рассчитывает конечное сальдо в валюте регл. в табличной части Группировка взаиморасчетов документа СверкаВзаиморасчетов.
//
// Параметры:
//  Группировка - ДанныеФормыКоллекция - Текущая строка табличной части группировки.
//  ДетальныеЗаписи - ДанныеФормыКоллекция - Табличная часть детальных записей взаиморасчетов.
//  КэшКурсов - Соотвествие - Курсы валют полученные процедурой Документы.СверкаВзаиморасчетов.ПолучитьКэшКурсовВалют()
//
Процедура РассчитатьКонечноеСальдоРегл(Группировка, ДетальныеЗаписи, КэшКурсов) Экспорт
	
	Отбор = Новый Структура("ОбъектРасчетов");
	ЗаполнитьЗначенияСвойств(Отбор, Группировка);
	
	ДеталиГруппировки = ДетальныеЗаписи.НайтиСтроки(Отбор);
	Обороты = Новый Структура("Приход, Расход", 0,0);
	Для Каждого Запись Из ДеталиГруппировки Цикл
		
		КурсВалюты = КэшКурсов[Группировка.Валюта];
		Если Запись.СуммаДолг > 0 Тогда
			Обороты.Приход = Обороты.Приход + Запись.СуммаДолг * КурсВалюты.Курс/КурсВалюты.Кратность;
		Иначе
			Обороты.Расход = Обороты.Расход + (-Запись.СуммаДолг * КурсВалюты.Курс/КурсВалюты.Кратность);
		КонецЕсли;
		
		Если Запись.СуммаАванс > 0 Тогда
			Обороты.Расход = Обороты.Расход + Запись.СуммаАвансРегл;
		Иначе
			Обороты.Приход = Обороты.Приход + (-Запись.СуммаАвансРегл);
		КонецЕсли;
		
	КонецЦикла;
	
	Группировка.КонечноеСальдоРегл = Группировка.НачальноеСальдоРегл + Обороты.Приход - Обороты.Расход;

КонецПроцедуры

#Область Модульность

// Служебная процедура, заполняет текст гиперссылки правил оплаты 
// 
// Параметры:
//	Форма       - ФормаКлиентскогоПриложения - Договор, указанный в документе:
//	 * Элементы - ЭлементыФормы - элементы вызывающей формы
//	СтруктураПараметров - см. ВзаиморасчетыСервер.ПараметрыМеханизма
//	СистемныеНастройки  - Структура - Системные настройки из дополненных параметров, если уже получены.
//
Процедура ОбновитьТекстГиперссылкиЭтапыОплаты(Форма, СтруктураПараметров = Неопределено, СистемныеНастройки = Неопределено) Экспорт
	
	Если СтруктураПараметров <> Неопределено И СистемныеНастройки <> Неопределено Тогда
		МассивПараметров = Новый Массив;
		МассивПараметров.Добавить(СтруктураПараметров);
	Иначе
		ДополненныеПараметрыМеханизма = ОбщегоНазначенияУТКлиентСервер.ПолучитьДанныеМеханизмаИзКэшаФормы(Форма, "Взаиморасчеты");
		МассивПараметров = ДополненныеПараметрыМеханизма.МассивПараметров;
		СистемныеНастройки = ДополненныеПараметрыМеханизма.СистемныеНастройки;
	КонецЕсли;
	
	Для Каждого СтруктураПараметров Из МассивПараметров Цикл
		
		Если Не ЗначениеЗаполнено(СтруктураПараметров.ЭлементыФормы.НадписьЭтапы) Тогда
			Продолжить;
		КонецЕсли;
		
		Если НЕ СтруктураПараметров.ИзменяетПланОплаты Тогда
			Форма.Элементы[СтруктураПараметров.ЭлементыФормы.НадписьЭтапы].Видимость = Ложь;
		Иначе
			Форма.Элементы[СтруктураПараметров.ЭлементыФормы.НадписьЭтапы].Видимость = Истина;
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(СтруктураПараметров.ПутьКДаннымТЧЭтапыОплаты) Тогда
			ПроверитьОбязательныеПараметры(СтруктураПараметров, "ДатаПлатежа");
		КонецЕсли;
		
		ФормаОплаты               = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ФормаОплаты);
		ГрафикОплаты              = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ГрафикОплаты);
		ПорядокРасчетов           = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ПорядокРасчетов);
		ЭтапыОплаты               = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ПутьКДаннымТЧЭтапыОплаты);
		ДатаПлатежа               = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ДатаПлатежа);
		Если ЗначениеЗаполнено(СтруктураПараметров.СуммаДокументаФорма) Тогда
			СуммаКОплате              = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.СуммаДокументаФорма);
		ИначеЕсли ЗначениеЗаполнено(СтруктураПараметров.ПутьКДаннымТЧ) Тогда
			ТЧ = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ПутьКДаннымТЧ);
			СуммаКОплате              = ТЧ.Итог(СтруктураПараметров.ИмяРеквизитаТЧСуммаСНДС);
		Иначе
			СуммаКОплате = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.СуммаДокумента);
		КонецЕсли;
		ЗаданГрафикИсполнения     = СтруктураПараметров.ЗаданГрафикИсполнения;
		ЭтоЗаказ                  = СтруктураПараметров.ЭтоЗаказ;
		ИспользоватьГрафикиОплаты = СистемныеНастройки.ИспользоватьГрафикиОплаты;
		
		ЕстьЭтапыОплаты = ЭтапыОплаты <> Неопределено;
		
		Если ЭтапыОплаты <> Неопределено Тогда
			КоличествоЭтаповОплаты    = ЭтапыОплаты.Количество();
		Иначе
			КоличествоЭтаповОплаты    = ?(ЗначениеЗаполнено(ДатаПлатежа), 1, 0);
		КонецЕсли;
		
		Оформление = ПараметрыОформленияНадписиЭтапыОплаты();
		МассивСтрок = Новый Массив;
		
		Если ЭтоЗаказ И ПорядокРасчетов = ПредопределенноеЗначение("Перечисление.ПорядокРасчетов.ПоНакладным") Тогда
			
			МассивСтрок.Добавить(НСтр("ru='По накладным';uk='За накладними'"));
			
		ИначеЕсли ЗаданГрафикИсполнения И (ЭтоЗаказ ИЛИ ЭтапыОплаты = Неопределено)
			И ПорядокРасчетов = ПредопределенноеЗначение("Перечисление.ПорядокРасчетов.ПоДоговорамКонтрагентов") Тогда
			
			МассивСтрок.Добавить(НСтр("ru='По графику договора';uk='За графіком договору'"));
			
		Иначе
			
			Если СуммаКОплате <= 0 И КоличествоЭтаповОплаты = 0 ИЛИ НЕ СтруктураПараметров.ИзменяетПланОплаты Тогда
				
				МассивСтрок.Добавить(НСтр("ru='Оплата не требуется';uk='Оплата не потрібна'"));
				
			Иначе
				
				МассивСтрок.Добавить(ПредставлениеФормыОплаты(ФормаОплаты));
					Если КоличествоЭтаповОплаты = 0 Тогда
					
					ТекстОшибки = ?(ЕстьЭтапыОплаты, НСтр("ru='этапы не указаны';uk='етапи не зазначені'"), НСтр("ru='не указана дата платежа';uk='не зазначена дата платежу'"));
					
					МассивСтрок.Добавить(", ");
					МассивСтрок.Добавить(Новый ФорматированнаяСтрока(ТекстОшибки, , Оформление.ЦветПредупреждение));
					
				ИначеЕсли Не ЕстьЭтапыОплаты Тогда
					
					МассивСтрок.Добавить(" ");
					МассивСтрок.Добавить(Формат(ДатаПлатежа, Оформление.ФорматДаты));
					
				ИначеЕсли КоличествоЭтаповОплаты <= 2 Тогда
					
					МассивСтрок.Добавить(" ");
					Для Сч=1 По КоличествоЭтаповОплаты Цикл
						СтрокаОплаты = ЭтапыОплаты[Сч-1];
						Если ЗначениеЗаполнено(СтрокаОплаты.ДатаПлатежа) И СтрокаОплаты.ПроцентПлатежа > 0 Тогда
							МассивСтрок.Добавить(Новый ФорматированнаяСтрока(
								Формат(СтрокаОплаты.ДатаПлатежа, Оформление.ФорматДаты), , Оформление.ЦветВыделение));
							МассивСтрок.Добавить(" (" + Формат(СтрокаОплаты.ПроцентПлатежа, Оформление.ФорматДоли) + "%)");
							МассивСтрок.Добавить(", ");
						КонецЕсли;
					КонецЦикла;
					МассивСтрок.Удалить(МассивСтрок.Количество()-1);
					
				ИначеЕсли ИспользоватьГрафикиОплаты И ЗначениеЗаполнено(ГрафикОплаты) Тогда
					
					МассивСтрок.Добавить(" ");
					МассивСтрок.Добавить(НСтр("ru='по графику';uk='за графіком'") + " """ + Строка(ГрафикОплаты) + """");
					
				Иначе
					
					ТекстЭтапа = ОбщегоНазначенияУТКлиентСервер.СклонениеСлова(
						КоличествоЭтаповОплаты,
						НСтр("ru='этапы';uk='етапи'"), НСтр("ru='этапа';uk='етапи'"), НСтр("ru='этапов';uk='етапів'"), НСтр("ru='м';uk='м'"));
						
					МассивСтрок.Добавить(" ");
					МассивСтрок.Добавить(НСтр("ru='в';uk='в'") +" " + Формат(КоличествоЭтаповОплаты, "ЧН=0") +" " + ТекстЭтапа);
					
				КонецЕсли;
			КонецЕсли;
			
		КонецЕсли;
		
		Элемент = Форма.Элементы[СтруктураПараметров.ЭлементыФормы.НадписьЭтапы]; // ПолеФормы
		Элемент.Заголовок = Новый ФорматированнаяСтрока(МассивСтрок);
		
	КонецЦикла;
	
КонецПроцедуры

// Формирует заголовок элемента НадписьВалюты
// 
// Параметры:
//	Форма       - ФормаКлиентскогоПриложения - Договор, указанный в документе:
//	 * Элементы - ЭлементыФормы - элементы вызывающей формы
//	СтруктураПараметров - см. ВзаиморасчетыСервер.ПараметрыМеханизма
//	СистемныеНастройки  - Структура - Системные настройки из дополненных параметров, если уже получены.
//
Процедура ОбновитьТекстГиперссылкиВалюты(Форма, СтруктураПараметров = Неопределено, СистемныеНастройки = Неопределено) Экспорт
	
	Если СтруктураПараметров <> Неопределено И СистемныеНастройки <> Неопределено Тогда
		МассивПараметров = Новый Массив;
		МассивПараметров.Добавить(СтруктураПараметров);
	Иначе
		ДополненныеПараметрыМеханизма = ОбщегоНазначенияУТКлиентСервер.ПолучитьДанныеМеханизмаИзКэшаФормы(Форма, "Взаиморасчеты");
		МассивПараметров = ДополненныеПараметрыМеханизма.МассивПараметров;
		СистемныеНастройки = ДополненныеПараметрыМеханизма.СистемныеНастройки;
	КонецЕсли;
	
	Для Каждого СтруктураПараметров Из МассивПараметров Цикл
	
		Если НЕ ЗначениеЗаполнено(СтруктураПараметров.Курс) Тогда
			Продолжить;
		КонецЕсли;
		
		ВалютаДокумента      = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ВалютаДокумента);
		ВалютаВзаиморасчетов = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ВалютаВзаиморасчетов);
		Курс                 = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.Курс);
		Кратность            = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.Кратность);
		НеПоказыватьРасчеты  = СтруктураПараметров.НеПоказыватьРасчеты;
		
		НадписьВалютыЭлемент = Форма.Элементы[СтруктураПараметров.ЭлементыФормы.НадписьВалюты]; // ПолеФормы
		
		Если ЗначениеЗаполнено(СтруктураПараметров.СуммаДокументаФорма) И ВалютаДокумента = ВалютаВзаиморасчетов Тогда
			СуммаДокумента = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(форма, СтруктураПараметров.СуммаДокументаФорма, , 0);
			СуммаВзаиморасчетов = СуммаДокумента;
		ИначеЕсли ЗначениеЗаполнено(СтруктураПараметров.ПутьКДаннымТЧ) И ЗначениеЗаполнено(СтруктураПараметров.ИмяРеквизитаТЧСуммаСНДС) Тогда
			ТЧ = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ПутьКДаннымТЧ);
			СуммаДокумента = ТЧ.Итог(СтруктураПараметров.ИмяРеквизитаТЧСуммаСНДС);
			Если ТЧ.Количество() > 0 И ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТЧ[0],"СуммаВзаиморасчетов") Тогда
				СуммаВзаиморасчетов = ТЧ.Итог("СуммаВзаиморасчетов");
			Иначе
				СуммаВзаиморасчетов = 0;
			КонецЕсли;
		Иначе
			СуммаВзаиморасчетов  = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.СуммаВзаиморасчетов);
			СуммаДокумента       = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.СуммаДокумента);
		КонецЕсли;
		
		Если СуммаДокумента = 0 Тогда
			ТекстСуммаДокумента = "";
		Иначе
			ТекстСуммаДокумента = " " + Формат(СуммаДокумента, "ЧДЦ=2");
		КонецЕсли;
		
		Если ВалютаДокумента = ВалютаВзаиморасчетов ИЛИ НеПоказыватьРасчеты Тогда
			
			НадписьВалюты = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru='Документ и расчеты:%1 %2';uk='Документ і розрахунки: %1 %2'"),
					ТекстСуммаДокумента,
					ВалютаДокумента);
			
		Иначе
			
			ТекстДокумент = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru='Документ%1 %2';uk='Документ %1 %2'"),
					ТекстСуммаДокумента,
					ВалютаДокумента);
			
			Если СуммаВзаиморасчетов = 0 Тогда
				ТекстСуммаВзаиморасчетов = "";
			Иначе
				ТекстСуммаВзаиморасчетов = " " + Формат(СуммаВзаиморасчетов, "ЧДЦ=2");
			КонецЕсли;
			
			Если ЗначениеЗаполнено(ВалютаВзаиморасчетов) Тогда
				ТекстВалютаВзаиморасчетов = ВалютаВзаиморасчетов;
			Иначе
				ТекстВалютаВзаиморасчетов = НСтр("ru='<Не выбрана>';uk='<Не вибрана>'")
			КонецЕсли;
			
			ТекстРасчеты = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru=', Расчеты%1 %2';uk=', Розрахунки %1 %2'"),
					ТекстСуммаВзаиморасчетов,
					ТекстВалютаВзаиморасчетов);
			
			Если НЕ ЗначениеЗаполнено(ВалютаВзаиморасчетов) Тогда
				
				ТекстРасшифровка = "";
				
			ИначеЕсли ВалютаДокумента = СистемныеНастройки.ВалютаРегламентированногоУчета
				ИЛИ ВалютаВзаиморасчетов = СистемныеНастройки.ВалютаРегламентированногоУчета Тогда
				
				ВалютаНадписи = ?(СистемныеНастройки.ВалютаРегламентированногоУчета = ВалютаДокумента,
								ВалютаВзаиморасчетов,
								ВалютаДокумента);
				
				Если Кратность = 1 Тогда
					
						ТекстРасшифровка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							"(%1=%2 %3)",
							ВалютаНадписи,
							Курс,
							СистемныеНастройки.ВалютаРегламентированногоУчета);
					
					Иначе
						
						ТекстРасшифровка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							НСтр("ru='(%1 %2 за %3 %4)';uk='(%1 %2 за %3 %4)'"),
							Курс,
							СистемныеНастройки.ВалютаРегламентированногоУчета,
							Кратность,
							ВалютаНадписи);
						
				КонецЕсли;
				
			Иначе
				
				Если Кратность = 1 Тогда
					
					ТекстРасшифровка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						"(%1=%2 %3)",
						ВалютаДокумента,
						Курс,
						ВалютаВзаиморасчетов);
				Иначе
					
					ТекстКурс = Строка(Курс) + " " + ВалютаВзаиморасчетов;
					
					ТекстКратность= Строка(Кратность);
					
					ТекстРасшифровка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						"(%1=%2 %3)",
						ТекстКурс,
						ТекстКратность,
						ВалютаДокумента);
						
				КонецЕсли;
				
			КонецЕсли;
			
			НадписьВалюты = ТекстДокумент + " " + ТекстРасчеты + " " + ТекстРасшифровка;
			
		КонецЕсли;
		
		НадписьВалютыЭлемент.Заголовок = НадписьВалюты;
	КонецЦикла;
	
КонецПроцедуры

// Устанавливает видимость кнопки зачета оплаты по порядку расчетов документа, если такая есть на форме.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - Форма, в которой находится команда зачета оплаты.
//	ЭтоЗаказ - Булево - Истина - Документ является заказом.
//	ПоЗаказу - Булево - Истина - Документ введен на основании заказа/заказов.
//	ЭтоДоговор - Булево - Истина - Документ является графиком исполнения договора.
//
Процедура УстановитьВидимостьЗачетаОплаты(Форма, СтруктураПараметров) Экспорт
	
	Если НЕ ЗначениеЗаполнено(СтруктураПараметров.ЭлементыФормы.ЗачетОплаты) Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьОбязательныеПараметры(СтруктураПараметров, "ПорядокРасчетов");
	
	ДоступенЗачетОплаты = СтруктураПараметров.ИзменяетРасчеты;
	ПорядокРасчетов = ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.ПорядокРасчетов);
	
	Если СтруктураПараметров.ЭтоЗаказ Тогда
		ВидимостьЭлемента = ПорядокРасчетов <> ПредопределенноеЗначение("Перечисление.ПорядокРасчетов.ПоНакладным") И ДоступенЗачетОплаты;
	ИначеЕсли ЗначениеЗаполнено(СтруктураПараметров.НакладнаяПоЗаказам) И ОбщегоНазначенияУТКлиентСервер.ДанныеПоПути(Форма, СтруктураПараметров.НакладнаяПоЗаказам) Тогда
		ВидимостьЭлемента = ПорядокРасчетов <> ПредопределенноеЗначение("Перечисление.ПорядокРасчетов.ПоЗаказамНакладным") И ДоступенЗачетОплаты;
	ИначеЕсли СтруктураПараметров.ЭтоДоговор Тогда
		ВидимостьЭлемента = ПорядокРасчетов = ПредопределенноеЗначение("Перечисление.ПорядокРасчетов.ПоДоговорамКонтрагентов") И ДоступенЗачетОплаты;
	Иначе
		ВидимостьЭлемента = ДоступенЗачетОплаты;
	КонецЕсли;
	
	ОбщегоНазначенияУТКлиентСервер.УстановитьСвойствоЭлементовФормы(
		Форма.Элементы, 
		СтруктураПараметров.ЭлементыФормы.ЗачетОплаты,
		"Видимость",
		ВидимостьЭлемента);
	
КонецПроцедуры

// Возвращет список типов договоро договоров с клиентами.
// 
// Возвращаемое значение:
// 	СписокЗначений - Список типов договоров с контрагентом, как с клиентом.
Функция ТипыДоговоровСКлиентом() Экспорт
	
	Типы = Новый СписокЗначений;
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.СПокупателем"));
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.СКомиссионером"));
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.СХранителем"));
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.СДавальцем"));
	
	Возврат Типы;
КонецФункции

// Возвращет список типов договоро договоров с поставщиками.
// 
// Возвращаемое значение:
// 	СписокЗначений - Список типов договоров с контрагентом, как с поставщиком.
Функция ТипыДоговоровСПоставщиком() Экспорт
	
	Типы = Новый СписокЗначений;
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.СПоставщиком"));
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.Импорт"));
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.СПереработчиком"));
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.СПоклажедателем"));
	Типы.Добавить(ПредопределенноеЗначение("Перечисление.ТипыДоговоров.СКомитентом"));
	
	Возврат Типы;
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьОборот(Обороты, Запись, ИмяРесурса)
	
	ЗначениеРесурса = Запись[ИмяРесурса];
	Если ЗначениеРесурса > 0 Тогда
		Обороты.Дт = Обороты.Дт + ЗначениеРесурса;
	Иначе
		Обороты.Кт = Обороты.Кт + (-ЗначениеРесурса);
	КонецЕсли;
	
КонецПроцедуры

//Проверяется заполненность переданных параметров в структуре, при незаполненности выдает исключение.
Процедура ПроверитьОбязательныеПараметры(СтруктураПараметров, ОбязательныеПараметры) Экспорт
	
	Реквизиты = СтрРазделить(ОбязательныеПараметры, ",");
	Для Каждого Реквизит Из Реквизиты Цикл
		Если НЕ СтруктураПараметров.Свойство(СокрЛП(Реквизит)) 
			ИЛИ НЕ ЗначениеЗаполнено(СтруктураПараметров[СокрЛП(Реквизит)]) Тогда
				ВызватьИсключение(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
										НСтр("ru='Не заполнен обязательный параметр механизма ""Взаиморасчеты"":%1';uk='Не заповнений обов''язковий параметр механізму ""Взаєморозрахунки"": %1'"),
										Реквизит));
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Функция МассивСтруктурПараметровПоЭлементам(МассивПараметров, ИменаЭлементов) Экспорт
	Если ТипЗнч(ИменаЭлементов) = Тип("Массив") Тогда
		Элементы = ИменаЭлементов;
	Иначе
		Элементы = Новый Массив;
		Элементы.Добавить(ИменаЭлементов);
	КонецЕсли;
	Результат = Новый Массив;
	Для Каждого СтруктураПараметров Из МассивПараметров Цикл
		МассивНайденныхЭлементов = Новый Массив;
		Для Каждого Элемент Из Элементы Цикл
			Если СтруктураПараметров.ИспользуемыеЭлементыФормы.Найти(Элемент) <> Неопределено Тогда
				МассивНайденныхЭлементов.Добавить(Элемент);
			КонецЕсли;
		КонецЦикла;
		Если МассивНайденныхЭлементов.Количество() > 0 Тогда
			СтруктураРезультата = Новый Структура;
			СтруктураРезультата.Вставить("СтруктураПараметров",       СтруктураПараметров);
			СтруктураРезультата.Вставить("ИспользуемыеЭлементыФормы", МассивНайденныхЭлементов);
			Результат.Добавить(СтруктураРезультата);
		КонецЕсли;
	КонецЦикла;
	Возврат Результат;
КонецФункции

Функция СтруктураПараметровПоИмениЭлемента(МассивПараметров, ИмяЭлемента) Экспорт
	
	МассивСтруктурПараметров = МассивСтруктурПараметровПоЭлементам(МассивПараметров, ИмяЭлемента);
	
	Если МассивСтруктурПараметров.Количество() > 1 Тогда
		ВызватьИсключение(НСтр("ru='Элемент привязан к нескольким параметрам механизма взаиморасчетов.';uk='Елемент прив''язаний до кількох параметрів механізму взаєморозрахунків.'"));
	ИначеЕсли МассивСтруктурПараметров.Количество() = 0 Тогда
		ВызватьИсключение(НСтр("ru='Элемент не привязан к параметрам механизма взаиморасчетов.';uk='Елемент не прив''язаний до параметрів механізму взаєморозрахунків.'"));
	Иначе
		Возврат МассивСтруктурПараметров[0].СтруктураПараметров;
	КонецЕсли;
	
КонецФункции

Функция ПараметрыОформленияНадписиЭтапыОплаты()
	
	СтруктураПараметров = Новый Структура();
	СтруктураПараметров.Вставить("ЦветПредупреждение", WebЦвета.Кирпичный);
	СтруктураПараметров.Вставить("ЦветВыделение", Новый Цвет(22, 39, 121));
	СтруктураПараметров.Вставить("ФорматДаты", "ДЛФ=D");
	СтруктураПараметров.Вставить("ФорматДоли", "ЧЦ=3; ЧДЦ=; ЧН=0");
	
	Возврат СтруктураПараметров;
	
КонецФункции

// Возвращает информативное представление формы оплаты для документов
//
// Параметры:
// 		ФормаОплаты - ПеречислениеСсылка.ФормыОплаты - форма оплаты. для которой нужно получить представление.
//
// Возвращаемое значение:
// 		Строка - представление формы оплаты.
//
Функция ПредставлениеФормыОплаты(ФормаОплаты)
	
	Представление = "";
	
	Если Не ЗначениеЗаполнено(ФормаОплаты) Тогда
		Представление = НСтр("ru='К оплате';uk='До оплати'");
	ИначеЕсли ФормаОплаты = ПредопределенноеЗначение("Перечисление.ФормыОплаты.Безналичная") Тогда
		Представление = НСтр("ru='К оплате безнал';uk='До оплати безгот'");
	ИначеЕсли ФормаОплаты = ПредопределенноеЗначение("Перечисление.ФормыОплаты.Наличная") Тогда
		Представление = НСтр("ru='К оплате нал';uk='До оплати гот'");
	ИначеЕсли ФормаОплаты = ПредопределенноеЗначение("Перечисление.ФормыОплаты.ПлатежнаяКарта") Тогда
		Представление = НСтр("ru='К оплате платежной картой';uk='До оплати платіжною картою'");
	ИначеЕсли ФормаОплаты = ПредопределенноеЗначение("Перечисление.ФормыОплаты.Взаимозачет") Тогда
		Представление = НСтр("ru='Взаимозачет';uk='Взаємозалік'");
	КонецЕсли;
	
	Возврат Представление;
	
КонецФункции

#КонецОбласти
