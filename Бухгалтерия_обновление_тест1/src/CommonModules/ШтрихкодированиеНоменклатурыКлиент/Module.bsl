
#Область ПрограммныйИнтерфейс

// Процедура выполняет обработку неизвестных штрихкодов. В зависимости от наличия прав пользователя, выдает сообщение
// о неизвестных штрихкодах или открывает форму регистрации новых штрихкодов номенклатуры.
//
// Параметры:
//  СтруктураПараметровДействия - Структура
//  КэшированныеЗначения        - Структура
//  ФормаВладелец               - Форма.
//
Процедура ОбработатьНеизвестныеШтрихкоды(СтруктураПараметровДействия, КэшированныеЗначения, ФормаВладелец) Экспорт
	
	Если СтруктураПараметровДействия.НеизвестныеШтрихкоды.Количество() > 0 Тогда
		
		Если КэшированныеЗначения <> Неопределено
			И Не (КэшированныеЗначения.ПравоРегистрацииШтрихкодовНоменклатурыДоступно = Истина
			И СтруктураПараметровДействия.ДействияСНеизвестнымиШтрихкодами <> "НетДействий"
			И СтруктураПараметровДействия.ИзменятьКоличество)Тогда
			
			Если СтруктураПараметровДействия.УчитыватьУпаковочныеЛисты Тогда
				ШаблонСообщения = НСтр("ru='Номенклатура или упаковочный лист со штрихкодом %1% не найдены';uk='Номенклатура або пакувальний лист зі штрихкодом %1% не знайдені'");
			Иначе
				ШаблонСообщения = НСтр("ru='Номенклатура со штрихкодом %1% не найдена';uk='Номенклатура зі штрихкодом %1% не знайдена'");
			КонецЕсли;
			Для Каждого ТекНеизвестныйШтрихкод Из СтруктураПараметровДействия.НеизвестныеШтрихкоды Цикл
				
				СтрокаСообщения = СтрЗаменить(ШаблонСообщения, "%1%", СокрЛП(ТекНеизвестныйШтрихкод.Штрихкод));
				
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрокаСообщения);
				
			КонецЦикла;
		Иначе
			ОценкаПроизводительностиКлиент.ЗамерВремени(
				"ОбщаяФорма.ПоискНоменклатурыПоШтрихкоду");
		
			ОткрытьФорму("ОбщаяФорма.ПоискНоменклатурыПоШтрихкоду", 
				СтруктураПараметровДействия,
				ФормаВладелец,
				Новый УникальныйИдентификатор);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Процедура показывает ввод штрихкода и оповещает в случае успешного ввода
//
// Параметры:
//  ОповещениеУспешногоВвода - ОписаниеОповещения - описание оповещения успешного ввода штрихкода
//  Заголовок                - Строка             - переопределяемый заголовок.
Процедура ПоказатьВводШтрихкода(ОповещениеУспешногоВвода, Количество = Неопределено, Заголовок = "") Экспорт 
	
	Если НЕ ЗначениеЗаполнено(Заголовок) Тогда
		Заголовок = НСтр("ru='Введите штрихкод';uk='Введіть штрихкод'");
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура(
		"ОповещениеУспешногоВвода, Количество",
		ОповещениеУспешногоВвода,
		Количество);
	Оповещение = Новый ОписаниеОповещения(
		"ПоказатьВводШтрихкодаЗавершение",
		ЭтотОбъект,
		ДополнительныеПараметры);
	ПоказатьВводЗначения(Оповещение, "", Заголовок);
	
КонецПроцедуры

// Возвращает структуру параметров обработки штрихкодов.
//
// Возвращаемое значение:
//  Структура - Параметры обработки штрихкодов.
//
Функция ПараметрыОбработкиШтрихкодов() Экспорт
	
	Возврат ШтрихкодированиеНоменклатурыКлиентСервер.ПараметрыОбработкиШтрихкодов();
	
КонецФункции

// Определяет необходимость открытия формы указания серий после обработки штрихкодов.
// Форму нужно открывать, если был отсканирован один штрихкод товара, по которому ведется учет серий.
//
// Параметры:
//  ПараметрыОбработкиШтрихкодов - Структура - см. ШтрихкодированиеНоменклатурыКлиент.ПараметрыОбработкиШтрихкодов().
//
// Возвращаемое значение:
//  Булево - Истина, если нужно открыть форму.
//
Функция НужноОткрытьФормуУказанияСерийПослеОбработкиШтрихкодов(ПараметрыОбработкиШтрихкодов) Экспорт
	
	ОдинШтрихкод = Ложь;
	
	Если ТипЗнч(ПараметрыОбработкиШтрихкодов.Штрихкоды) = Тип("Массив") Тогда
		ОдинШтрихкод = ПараметрыОбработкиШтрихкодов.Штрихкоды.Количество() = 1;
	Иначе
		ОдинШтрихкод = Истина;
	КонецЕсли;
	
	Если ОдинШтрихкод 
		И ПараметрыОбработкиШтрихкодов.МассивСтрокССериями.Количество() = 1
		И НоменклатураКлиентСервер.НеобходимоРегистрироватьСерии(
			ПараметрыОбработкиШтрихкодов.ПараметрыУказанияСерий) Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

// Возвращает структуру, которая затем обрабатывается процедурами заполнения ТЧ.
//
// Параметры:
//  Штрихкод - штрихкод, который необходимо обработать.
//  Количество - количество товаров с указанным штрихкодом.
//
// Возвращаемое значение:
//  Структура - Структура со свойствами:
//   * Штрихкод - Строка - Штрихкод.
//   * Количество - Число - Количество.
//
Функция СтруктураДанныхШтрихкода(Штрихкод, Количество) Экспорт

	Возврат Новый Структура("Штрихкод, Количество", Штрихкод, Количество);

КонецФункции

#Область RFID

// Функция - Для обработки RFIDНужен серверный вызов
//
// Параметры:
//  ДанныеМеток	 - Массив - данные меток
//  Форма		 - ФормаКлиентскогоПриложения - форма, из которой вызывается функция.
// 
// Возвращаемое значение:
// Булево - Истина, если нужен серверный вызов.
//
Функция ДляОбработкиRFIDНуженСерверныйВызов(ДанныеМеток, Форма) Экспорт
	
	ЕстьЗаполненныйTID = Ложь;
	Для Каждого Метка Из ДанныеМеток Цикл
		
		// Если TID не считался, то нельзя считать чтение метки успешным
		Если ЗначениеЗаполнено(Метка.TID) Тогда
			ЕстьЗаполненныйTID = Истина;
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Если ЕстьЗаполненныйTID Тогда
		
		ПараметрыОперацииСчитывателяRFID = ПараметрыОперацииСчитывателяRFID();
		ПараметрыОперацииСчитывателяRFID.ВыполненноеДействие = "ОбработкаСчитывания";
		ПараметрыОперацииСчитывателяRFID.Форма = Форма;
		ЗакрытьСессиюСчитывателяRFID(Неопределено, ПараметрыОперацииСчитывателяRFID);
			
		Возврат Истина;
		
	Иначе
		
		// Если нет корректно считанных меток, то ничего не делаем - ждем еще события от оборудования.
		// В следующем событии могут уже приехать корректные данные.
		Возврат Ложь;
		
	КонецЕсли;
	
КонецФункции

// Процедура - Открыть сессию считывателя RFID
//
// Параметры:
//  Форма				 - ФормаКлиентскогоПриложения - форма, из которой вызывается процедура
//  СледующееДействие	 - ОписаниеОповещения - описание следующего действия.
//
Процедура ОткрытьСессиюСчитывателяRFID(Форма, СледующееДействие = Неопределено) Экспорт
	
	ОткрытаСессияСчитывателяRFID      = Форма.ОткрытаСессияСчитывателяRFID;
	УникальныйИдентификатор           = Форма.УникальныйИдентификатор;
	СчитывательRFID                   = Форма.СчитывательRFID;
	
	Если Не ОткрытаСессияСчитывателяRFID Тогда
		ПараметрыОперацииСчитывателяRFID = ПараметрыОперацииСчитывателяRFID();
		
		ПараметрыОперацииСчитывателяRFID.ВыполненноеДействие = "ОткрытиеСессии";
		ПараметрыОперацииСчитывателяRFID.СледующееДействие = СледующееДействие;
		ПараметрыОперацииСчитывателяRFID.Форма = Форма;
		
		ОписаниеОповещениеПриЗавершении = Новый ОписаниеОповещения("ЗавершениеОперацииСчитывателяRFID", ЭтотОбъект, ПараметрыОперацииСчитывателяRFID);
		МенеджерОборудованияКлиент.НачатьОткрытиеСессииСчитывателяRFID(ОписаниеОповещениеПриЗавершении, УникальныйИдентификатор, СчитывательRFID);
	КонецЕсли;
	
КонецПроцедуры

// Процедура - Отработать таймаут ожидания считывания метки
//
// Параметры:
//  Форма	 - ФормаКлиентскогоПриложения - форма, из которой вызывается процедура.
//
Процедура ОтработатьТаймаутОжиданияСчитыванияМетки(Форма) Экспорт
	
	ТекстСообщения = НСтр("ru='Истекло время ожидания чтения RFID-метки. Возможные проблемы: метка находится вне зоны считывания, метка повреждена или чтение заводской метки в настройках оборудования не включено.';uk='Закінчився час очікування читання RFID-мітки. Можливі проблеми: мітка знаходиться поза зоною зчитування, мітка пошкоджена або читання заводської мітки в настройках обладнання не включено.'");
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	ПараметрыОперацииСчитывателяRFID = ПараметрыОперацииСчитывателяRFID();
	ПараметрыОперацииСчитывателяRFID.ВыполненноеДействие = "ТаймаутОжиданияСчитывания";
	ПараметрыОперацииСчитывателяRFID.Форма = Форма;
	ЗакрытьСессиюСчитывателяRFID(Неопределено, ПараметрыОперацииСчитывателяRFID);
	
КонецПроцедуры

// Процедура - Записать данные ВRFID
//
// Параметры:
//  Результат	 - Неопределено - служебный параметр описания оповещения (не используется)
//  Параметры	 - Структура - параметры с данными серий для записи.
//
Процедура ЗаписатьДанныеВRFID(Результат, Параметры) Экспорт
	
	Форма = Параметры.Форма;
	ДанныеСерии = Параметры.ДанныеСерии;
	
	УникальныйИдентификатор      = Форма.УникальныйИдентификатор;
	СчитывательRFID              = Форма.СчитывательRFID;
	НастройкиИспользованияСерий  = Форма.НастройкиИспользованияСерий;
	ОткрытаСессияСчитывателяRFID = Форма.ОткрытаСессияСчитывателяRFID;
	GTIN                         = Форма.GTIN;
	
	НужноЗаписатьМетку = Истина;
	
	Если ДанныеСерии = Неопределено Тогда
		ТекстСообщения = НСтр("ru='Выберите строку, по которой нужно записать метку и положите соответствующую метку на устройство.';uk='Виберіть рядок, за яким потрібно записати мітку і покладіть відповідну мітку на пристрій.'");
		ПоказатьПредупреждение(,ТекстСообщения);
		НужноЗаписатьМетку = Ложь;
	ИначеЕсли Не ДанныеСерии.НужноЗаписатьМетку Тогда
		ТекстСообщения = НСтр("ru='По текущей строке не нужно записывать метку.';uk='По поточному рядку не потрібно записувати мітку.'");
		ПоказатьПредупреждение(,ТекстСообщения);
		НужноЗаписатьМетку = Ложь;
	ИначеЕсли НастройкиИспользованияСерий.ИспользоватьНомерСерии
		И Не ЗначениеЗаполнено(ДанныеСерии.Номер) Тогда
		ТекстСообщения = НСтр("ru='Перед записью метки, укажите номер серии.';uk='Перед записом мітки, зазначте номер серії.'");
		ПоказатьПредупреждение(,ТекстСообщения);
		НужноЗаписатьМетку = Ложь;
	ИначеЕсли НастройкиИспользованияСерий.ИспользоватьСрокГодностиСерии
		И Не ЗначениеЗаполнено(ДанныеСерии.ГоденДо) Тогда
		ТекстСообщения = НСтр("ru='Перед записью метки, укажите срок годности.';uk='Перед записом мітки, вкажіть строк придатності.'");
		ПоказатьПредупреждение(,ТекстСообщения);
		НужноЗаписатьМетку = Ложь;
	КонецЕсли;	
	
	ПараметрыОперацииСчитывателяRFID = ПараметрыОперацииСчитывателяRFID();
	ПараметрыОперацииСчитывателяRFID.Форма = Форма;
	Если Не НужноЗаписатьМетку Тогда
		Если ОткрытаСессияСчитывателяRFID Тогда
			ЗакрытьСессиюСчитывателяRFID(Неопределено, ПараметрыОперацииСчитывателяRFID);
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	Если Не ОткрытаСессияСчитывателяRFID Тогда
		
		ТекущееДействие = Новый ОписаниеОповещения("ЗаписатьДанныеВRFID", ЭтотОбъект,
			Новый Структура("Форма,ДанныеСерии",Форма,ДанныеСерии));
		ОткрытьСессиюСчитывателяRFID(Форма, ТекущееДействие);
		Возврат;
		
	КонецЕсли;
	
	ПараметрыЗаписи = МенеджерОборудованияКлиент.ПараметрыЗаписиМеткиRFID();
	ПараметрыЗаписи.TID = ДанныеСерии.RFIDTID;
	ПараметрыЗаписи.EPC = ДанныеСерии.RFIDEPC;
	ПараметрыЗаписи.БанкПамяти = "EPC";
	ПараметрыЗаписи.Данные = МенеджерОборудованияКлиентСервер.СформироватьДанныеSGTIN96(GTIN, ДанныеСерии.Номер, 1);
	
	ПараметрыОперацииСчитывателяRFID.ВыполненноеДействие = "ЗаписьRFID";
	ПараметрыОперацииСчитывателяRFID.СледующееДействие = Новый ОписаниеОповещения("ЗаписатьДанныеВRFIDЗавершение",
		ЭтотОбъект,Новый Структура("Форма,ДанныеСерии",Форма,ДанныеСерии));
	
	ОписаниеОповещениеПриЗавершении = Новый ОписаниеОповещения("ЗавершениеОперацииСчитывателяRFID", ЭтотОбъект, ПараметрыОперацииСчитывателяRFID);
	МенеджерОборудованияКлиент.НачатьЗаписьДанныхВМеткуRFID(ОписаниеОповещениеПриЗавершении, УникальныйИдентификатор, СчитывательRFID, ПараметрыЗаписи);
КонецПроцедуры


// Процедура - Записать данные ВRFIDЗавершение
//
// Параметры:
//  Результат	 - Структура - со свойствами:
//  	*Результат - Булево - признак успешного выполнения предыдущей операции
//  Параметры	 - Структура - со свойствами:
//  	*ДанныеСерии - Структура - с данными серии в свойствах.
//
Процедура ЗаписатьДанныеВRFIDЗавершение(Результат, Параметры) Экспорт
	
	ДанныеСерии = Параметры.ДанныеСерии;
	
	ПараметрыОперацииСчитывателяRFID = ПараметрыОперацииСчитывателяRFID();
	ПараметрыОперацииСчитывателяRFID.Форма = Параметры.Форма;
	ЗакрытьСессиюСчитывателяRFID(Неопределено, ПараметрыОперацииСчитывателяRFID);
	
	Если Результат.Результат Тогда
		ДанныеСерии.RFIDEPC = МенеджерОборудованияКлиентСервер.СформироватьДанныеSGTIN96(Параметры.Форма.GTIN, ДанныеСерии.Номер, 1);
		Оповестить("ЗаписьRFID_Серии", ДанныеСерии);
	КонецЕсли;
	
КонецПроцедуры

// Процедура - Отключить оборудование
//
// Параметры:
//  Результат	 - Неопределено - не используется (служебный параметр)
//  Параметры	 - Структура - содержит свойства:
//		*Форма - ФормаКлиентскогоПриложения - форма, откуда было инициировано отключение оборудования.
//
Процедура ОтключитьОборудование(Результат, Параметры) Экспорт
	
	Форма = Параметры.Форма;
	
	Если Не Форма.ОткрытаСессияСчитывателяRFID Тогда
		МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПриЗакрытииФормы(Неопределено, Форма);
	Иначе
		ПараметрыОперацииСчитывателяRFID = ПараметрыОперацииСчитывателяRFID();
		ПараметрыОперацииСчитывателяRFID.Форма = Форма;
		ПараметрыОперацииСчитывателяRFID.СледующееДействие = Новый ОписаниеОповещения("ОтключитьОборудование", ЭтотОбъект, Новый Структура("Форма",Форма));
		
		ЗакрытьСессиюСчитывателяRFID(Неопределено, ПараметрыОперацииСчитывателяRFID);
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПоказатьВводШтрихкодаЗавершение(Штрихкод, ДополнительныеПараметры) Экспорт
	
	ОповещениеУспешногоВвода = ДополнительныеПараметры.ОповещениеУспешногоВвода;
	Количество = ДополнительныеПараметры.Количество;
	
	Если (Штрихкод <> Неопределено) Тогда
		Если Не ПустаяСтрока(Штрихкод) Тогда
			Если Количество = Неопределено Тогда
				Количество = 1;
			КонецЕсли;
			
			Если СтрДлина(Штрихкод) > 200 Тогда
				ТекстСообщения = НСтр("ru='Длина штрихкода не должна быть больше 200 символов.';uk='Довжина штрихкоду не повинна бути більше 200 символів.'");
				ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
				
				Возврат;
			КонецЕсли;
			
			ВыполнитьОбработкуОповещения(
				ОповещениеУспешногоВвода,
				СтруктураДанныхШтрихкода(Штрихкод, Количество));
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗакрытьСессиюСчитывателяRFID(Результат, ПараметрыОперацииСчитывателяRFID)
	
	СчитывательRFID = ПараметрыОперацииСчитывателяRFID.Форма.СчитывательRFID;
	УникальныйИдентификатор = ПараметрыОперацииСчитывателяRFID.Форма.УникальныйИдентификатор;
	
	НовыеПараметрыОперацииСчитывателяRFID = ПараметрыОперацииСчитывателяRFID();
	НовыеПараметрыОперацииСчитывателяRFID.ВыполненноеДействие = "ЗакрытиеСессии";
	
	НовыеПараметрыОперацииСчитывателяRFID.Форма = ПараметрыОперацииСчитывателяRFID.Форма;
	Если ПараметрыОперацииСчитывателяRFID.СледующееДействие <> Неопределено Тогда
		НовыеПараметрыОперацииСчитывателяRFID.ВыполненноеДействие = "ЗакрытиеСессии";
		НовыеПараметрыОперацииСчитывателяRFID.СледующееДействие   = ПараметрыОперацииСчитывателяRFID.СледующееДействие;
	КонецЕсли;
	
	ОписаниеОповещениеПриЗавершении = Новый ОписаниеОповещения("ЗавершениеОперацииСчитывателяRFID", ЭтотОбъект, НовыеПараметрыОперацииСчитывателяRFID);
    МенеджерОборудованияКлиент.НачатьЗакрытиеСессииСчитывателяRFID(ОписаниеОповещениеПриЗавершении, УникальныйИдентификатор, СчитывательRFID);

КонецПроцедуры

Процедура ЗавершениеОперацииСчитывателяRFID(РезультатВыполнения, ПараметрыОперацииСчитывателяRFID) Экспорт

	Если Не РезультатВыполнения.Результат Тогда
		ТекстСообщения = НСтр("ru='Операция считывателя RFID завершилась с ошибкой:""%ОписаниеОшибки%""';uk='Операція зчитувача RFID завершилася з помилкою: ""%ОписаниеОшибки%""'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОписаниеОшибки%" , РезультатВыполнения.ОписаниеОшибки);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		ПараметрыОперацииСчитывателяRFID.Форма.ИдетЗаписьМетки = Ложь;
	ИначеЕсли ПараметрыОперацииСчитывателяRFID.ВыполненноеДействие = "ОткрытиеСессии" Тогда
		ПараметрыОперацииСчитывателяRFID.Форма.ОткрытаСессияСчитывателяRFID = Истина;
	ИначеЕсли ПараметрыОперацииСчитывателяRFID.ВыполненноеДействие = "ЗакрытиеСессии" Тогда
		ПараметрыОперацииСчитывателяRFID.Форма.ОткрытаСессияСчитывателяRFID = Ложь;
		ПараметрыОперацииСчитывателяRFID.Форма.ИдетЗаписьМетки = Ложь;
	КонецЕсли;

	Если ПараметрыОперацииСчитывателяRFID.СледующееДействие <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(ПараметрыОперацииСчитывателяRFID.СледующееДействие, РезультатВыполнения);
	КонецЕсли;
	
КонецПроцедуры

Функция ПараметрыОперацииСчитывателяRFID()
	
	Результат = Новый Структура;
	Результат.Вставить("ВыполненноеДействие", "");
	Результат.Вставить("СледующееДействие");
	Результат.Вставить("Форма");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
