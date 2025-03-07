#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Добавляет команду создания объекта.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	Команда = Неопределено;
	Если ПравоДоступа("Добавление", Метаданные.Справочники.ДоговорыМеждуОрганизациями) Тогда
		Команда = КомандыСозданияНаОсновании.Добавить();
		Команда.Менеджер = Метаданные.Справочники.ДоговорыМеждуОрганизациями.ПолноеИмя();
		Команда.Представление = ОбщегоНазначенияУТ.ПредставлениеОбъекта(Метаданные.Справочники.ДоговорыМеждуОрганизациями);
		Команда.РежимЗаписи = "Проводить";
		Команда.ФункциональныеОпции = "ИспользоватьДоговорыМеждуОрганизациями";
	КонецЕсли;
	Возврат Команда;
КонецФункции

// Устанавливает статус договоров.
//
// Параметры:
//	Договоры - Массив - Массив ссылок на договоры (СправочникСсылка.ДоговорыМеждуОрганизациями);
//	Статус - ПеречислениеСсылка.СтатусыДоговоровКонтрагентов - Статус, который будет установлен у договоров.
//
// Возвращаемое значение:
//	Число - Количество обработанных объектов.
//
Функция УстановитьСтатус(Договоры, Статус) Экспорт
	
	МассивСсылок = Новый Массив();
	КоличествоОбработанных = 0;
	
	Для Каждого Договор Из Договоры Цикл
		
		Если ТипЗнч(Договор) = Тип("СтрокаГруппировкиДинамическогоСписка") Тогда
			Продолжить;
		КонецЕсли;
		
		МассивСсылок.Добавить(Договор);
		
	КонецЦикла;
	
	Если МассивСсылок = 0 Тогда
		Возврат КоличествоОбработанных;
	КонецЕсли;
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ДоговорыМеждуОрганизациями.Ссылка КАК Ссылка,
	|	ДоговорыМеждуОрганизациями.ПометкаУдаления КАК ПометкаУдаления,
	|	ВЫБОР
	|		КОГДА ДоговорыМеждуОрганизациями.Статус = &Статус
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК СтатусСовпадает
	|ИЗ
	|	Справочник.ДоговорыМеждуОрганизациями КАК ДоговорыМеждуОрганизациями
	|ГДЕ
	|	ДоговорыМеждуОрганизациями.Ссылка В(&МассивСсылок)
	|");
	
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	Запрос.УстановитьПараметр("Статус", Статус);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.ПометкаУдаления Тогда
			
			ТекстОшибки = НСтр("ru='Договор %Договор% помечен на удаление. Невозможно изменить статус';uk='Договір %Договор% позначений на вилучення. Неможливо змінити статус'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Договор%", Выборка.Ссылка);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, Выборка.Ссылка);
			Продолжить;
			
		КонецЕсли;
		
		Если Выборка.СтатусСовпадает Тогда
			
			ТекстОшибки = НСтр("ru='Договору %Договор% уже присвоен статус ""%Статус%""';uk='Договору %Договор% вже присвоєно статус ""%Статус%""'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Договор%", Выборка.Ссылка);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Статус%", Статус);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, Выборка.Ссылка);
			Продолжить;
			
		КонецЕсли;
		
		Попытка
			ЗаблокироватьДанныеДляРедактирования(Выборка.Ссылка);
		Исключение
			
			ТекстОшибки = НСтр("ru='Не удалось заблокировать %Договор%. %ОписаниеОшибки%';uk='Не вдалося заблокувати %Договор%. %ОписаниеОшибки%'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Договор%", Выборка.Ссылка);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ОписаниеОшибки%", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, Выборка.Ссылка);
			
		КонецПопытки;
		
		Объект = Выборка.Ссылка.ПолучитьОбъект();
		Объект.Статус = Статус;
		
		Если Статус = Перечисления.СтатусыДоговоровКонтрагентов.НеСогласован Тогда
			Если Объект.Согласован Тогда
				Объект.Согласован = Ложь;
			КонецЕсли;
		КонецЕсли;
		
		Если Не Объект.ПроверитьЗаполнение() Тогда
			Продолжить;
		КонецЕсли;
			
		Попытка
			
			Объект.Записать();
			КоличествоОбработанных = КоличествоОбработанных + 1;
			
		Исключение
			
			ТекстОшибки = НСтр("ru='Не удалось записать %Договор%. %ОписаниеОшибки%';uk='Не вдалося записати %Договор%. %ОписаниеОшибки%'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Договор%", Выборка.Ссылка);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ОписаниеОшибки%", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, Выборка.Ссылка);
			
		КонецПопытки
		
	КонецЦикла;
	
	Возврат КоличествоОбработанных;
	
КонецФункции

// Процедура заполняет банковские счета документа по договору.
//
// Параметры:
//	Договор - СправочникСсылка.ДоговорыКонтрагентов - Договор, указанный в документе;
//	БанковскийСчетОрганизации - СправочникСсылка.БанковскиеСчетаОрганизаций - Реквизит документа "Банковский счет организации";
//	БанковскийСчетКонтрагента - СправочникСсылка.БанковскиеСчетаКонтрагентов - Реквизит документа "Банковский счет контрагента".
//
Процедура ЗаполнитьБанковскиеСчетаПоДоговору(Договор, БанковскийСчетОрганизации, БанковскийСчетОрганизацииПолучателя) Экспорт
	
	ДанныеДоговора = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Договор, "БанковскийСчет, БанковскийСчетПолучателя"); 
		
	БанковскийСчетОрганизации = ДанныеДоговора.БанковскийСчет;
	БанковскийСчетОрганизацииПолучателя = ДанныеДоговора.БанковскийСчетПолучателя;
	
КонецПроцедуры 

// Процедура заполняет статью движения денежных средств по договору
//
// Параметры:
//	Договор - СправочникСсылка.ДоговорыМеждуОрганизациями - Договор, указанный в документе;
//	СтатьяДвиженияДенежныхСредств - СправочникСсылка.СтатьиДвиженияДенежныхСредств - Реквизит документа "Статья движения денежных средств";
//
Процедура ЗаполнитьСтатьюДвиженияДенежныхСредствПоДоговору(Договор, СтатьяДвиженияДенежныхСредств) Экспорт
	
	Если ЗначениеЗаполнено(Договор) Тогда
		СтатьяДвиженияДенежныхСредств = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Договор, "СтатьяДвиженияДенежныхСредств"); 
	КонецЕсли;
	
КонецПроцедуры

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП.
//
// Возвращаемое значение:
//	Массив - имена блокируемых реквизитов.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	Результат = Новый Массив;
	Результат.Добавить("ТипДоговора");
	Результат.Добавить("Организация");
	Результат.Добавить("ОрганизацияПолучатель");
	Результат.Добавить("Подразделение");
	Результат.Добавить("ОплатаВВалюте");
	Результат.Добавить("ВалютаВзаиморасчетов");
	Результат.Добавить("ПорядокРасчетов");
	Результат.Добавить("ГруппаФинансовогоУчета");
	Результат.Добавить("ГруппаФинансовогоУчетаПолучателя");
	Результат.Добавить("НаправлениеДеятельности");
	Результат.Добавить("МоментОпределенияБазыНДС");
	Результат.Добавить("МоментОпределенияБазыНДСПолучатель");
	
	Возврат Результат;
КонецФункции

Функция ЭтоВнешнеэкономическийДоговор(Объект) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
		
	Возврат Объект.ВалютаВзаиморасчетов <> Константы.ВалютаРегламентированногоУчета.Получить();
						   
КонецФункции // ЭтоВнешнеэкономическийДоговор
		 
// Определяет, необходимо ли указание номенклатуры на аванс для данного договора
Функция ИспользоватьНоменклатуруЗаполненияНалоговыхНаАванс(Объект) Экспорт
	
	// Доступно только тогда, когда есть настраиваемые моменты определения базы НДС
	Возврат Объект.МоментОпределенияБазыНДС <> Перечисления.МоментыОпределенияНалоговойБазы.ПоОтгрузке;
						   
КонецФункции // ИспользоватьНоменклатуруЗаполненияНалоговыхНаАванс

// Функция возвращает значение по умолчанию для реквизита МоментОпределенияБазыНДСПоТипуДоговора на основании данных
// организации. Если для данного договора МоментОпределенияБазыНДС не настраивается, то возвращается Неопределено
//
Функция ПолучитьМоментОпределенияБазыНДСПоУмолчанию(Объект) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Внешнеэкономический = ЭтоВнешнеэкономическийДоговор(Объект);
	
	Если ЗначениеЗаполнено(Объект.ТипДоговора) Тогда
		
		Если Объект.ТипДоговора = Перечисления.ТипыДоговоровМеждуОрганизациями.КупляПродажа Тогда
			Если Не Внешнеэкономический Тогда
				Возврат Объект.Организация.МоментОпределенияБазыНДСПоПродажам;
			Иначе
				Возврат Объект.Организация.МоментОпределенияБазыНДСПоЭкспорту;
			КонецЕсли;
		ИначеЕсли Объект.ТипДоговора = Перечисления.ТипыДоговоровМеждуОрганизациями.Комиссионный Тогда
			Если Не Внешнеэкономический Тогда
				Возврат Объект.Организация.МоментОпределенияБазыНДСПоЗакупкам;
			Иначе
				Возврат Неопределено;				
			КонецЕсли;
		КонецЕсли;
			
	КонецЕсли;
	
	Возврат Неопределено;
		
КонецФункции // ПолучитьМоментОпределенияБазыНДСПоУмолчанию

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	ИЛИ ЗначениеРазрешено(ОрганизацияПолучатель)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

// Возвращает параметры для заполнения налогообложения НДС.
//
// Параметры:
//	Справочник - ДанныеФормыСтруктура, СправочникСсылка.ДоговорыМеждуОрганизациями,
//				СправочникОбъект.ДоговорыМеждуОрганизациями - справочник договор между организациями.
//
// Возвращаемое значение:
//	Структура - состав полей задается в функции УчетНДСУПКлиентСервер.ПараметрыЗаполненияНалогообложенияНДСПродажи().
//
Функция ПараметрыЗаполненияНалогообложенияНДС(Справочник) Экспорт
	
    РеквизитыСправочника = Новый Структура("Организация, ОрганизацияПолучатель, ТипДоговора"); 
	
	Если ТипЗнч(Справочник) = Тип("СправочникСсылка.ДоговорыМеждуОрганизациями") Тогда
		РеквизитыСправочника = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Справочник, РеквизитыСправочника);
	Иначе
		ЗаполнитьЗначенияСвойств(РеквизитыСправочника, Справочник);
	КонецЕсли;
	
	ПараметрыЗаполнения = УчетНДСУПКлиентСервер.ПараметрыЗаполненияНалогообложенияНДСПродажи();
	ЗаполнитьЗначенияСвойств(ПараметрыЗаполнения, РеквизитыСправочника);
	
	РеализацияТоваров = РеквизитыСправочника.ТипДоговора = Перечисления.ТипыДоговоровМеждуОрганизациями.КупляПродажа;
	
    ПараметрыЗаполнения.РеализацияТоваров    = РеализацияТоваров;
    ПараметрыЗаполнения.РеализацияРаботУслуг = РеализацияТоваров;
    ПараметрыЗаполнения.ПередачаНаКомиссию   = Не РеализацияТоваров;
    ПараметрыЗаполнения.ОтчетКомиссионера    = Не РеализацияТоваров;
	
	ПараметрыЗаполнения.ЭтоОперацияМеждуОрганизациями = Истина;
	
	Возврат ПараметрыЗаполнения;
	
КонецФункции


// Возвращает параметры механизма взаиморасчетов.
// 
// Параметры:
// 	ТипДоговора - ПеречислениеСсылка.ТипыДоговоровМеждуОрганизациями - Тип договора.
// 	Сумма - Число - Сумма договор.
// 	
// Возвращаемое значение:
// 	Массив - Массив из см. ВзаиморасчетыСервер.ПараметрыМеханизма - параметров функций механизма взаиморасчетов.
//
Функция ПараметрыВзаиморасчеты(ТипДоговора = Неопределено, Сумма = 0) Экспорт
	
	МассивПараметров = Новый Массив();
	
	#Область ОрганизацияОтправитель
		
	#Область Отправитель
	
	СтруктураПараметров = ВзаиморасчетыСервер.ПараметрыМеханизма();
	
	СтруктураПараметров.ЭтоДоговор                       = Истина;
	
	СтруктураПараметров.ТипРасчетов                      = Перечисления.ТипыРасчетовСПартнерами.РасчетыСКлиентом;
	
	// Для отображения гиперссылки и зачета оплат.
	СтруктураПараметров.ИзменяетПланОплаты = ТипДоговора = Перечисления.ТипыДоговоровМеждуОрганизациями.КупляПродажа
												И Сумма <> 0;
	
	СтруктураПараметров.Дата                             = "Объект.Дата"; 
	
	// Валюта и сумма операции. Обязательно путь к реквизитам объекта.
	СтруктураПараметров.ВалютаДокумента                  = "Объект.ВалютаВзаиморасчетов";
	СтруктураПараметров.СуммаДокумента                   = "Объект.Сумма";
	СтруктураПараметров.Партнер                          = Справочники.Партнеры.НашеПредприятие;
	СтруктураПараметров.Контрагент                       = "Объект.ОрганизацияПолучатель";
	СтруктураПараметров.Договор                          = "Объект.Ссылка";
	СтруктураПараметров.ПорядокРасчетов                  = "Объект.ПорядокРасчетов";
	СтруктураПараметров.Соглашение                       = "";
	
	// Используются для определения значения ОплатаВВалюте и в форме редактирования правил оплаты.
	СтруктураПараметров.БанковскийСчетОрганизации        = "Объект.БанковскийСчет";
	СтруктураПараметров.БанковскийСчетКонтрагента        = "Объект.БанковскийСчетПолучателя";
	СтруктураПараметров.Касса                            = "";
	СтруктураПараметров.ФормаОплаты                      = "";
	
	СтруктураПараметров.Менеджер                         = "Объект.Менеджер";
	СтруктураПараметров.НомерВходящегоДокумента          = "Объект.Номер";
	СтруктураПараметров.ДатаВходящегоДокумента           = "Объект.Дата";
	
	МассивПараметров.Добавить(СтруктураПараметров);
	
	#КонецОбласти
	
	#Область ОтправительВознаграждение
	
	Если ТипДоговора = Перечисления.ТипыДоговоровМеждуОрганизациями.Комиссионный Тогда
	
		СтруктураПараметров = ВзаиморасчетыСервер.ПараметрыМеханизма();
		
		СтруктураПараметров.ЭтоДоговор                       = Истина;
		
		СтруктураПараметров.ТипРасчетов                      = Перечисления.ТипыРасчетовСПартнерами.РасчетыСПоставщиком;
		
		СтруктураПараметров.ИзменяетПланОплаты               = Ложь;
		СтруктураПараметров.ИзменяетПланОтгрузкиПоставки     = Ложь;
		
		СтруктураПараметров.Дата                             = "Объект.Дата"; 
		
		// Валюта и сумма операции. Обязательно путь к реквизитам объекта.
		СтруктураПараметров.ВалютаДокумента                  = "Объект.ВалютаВзаиморасчетов";
		СтруктураПараметров.СуммаДокумента                   = "Объект.Сумма";
		СтруктураПараметров.Партнер                          = Справочники.Партнеры.НашеПредприятие;
		СтруктураПараметров.Контрагент                       = "Объект.ОрганизацияПолучатель";
		СтруктураПараметров.Договор                          = "Объект.Ссылка";
		СтруктураПараметров.ПорядокРасчетов                  = "Объект.ПорядокРасчетов";
		СтруктураПараметров.Соглашение                       = "";
		
		// Используются для определения значения ОплатаВВалюте и в форме редактирования правил оплаты.
		СтруктураПараметров.БанковскийСчетОрганизации        = "Объект.БанковскийСчет";
		СтруктураПараметров.БанковскийСчетКонтрагента        = "Объект.БанковскийСчетПолучателя";
		СтруктураПараметров.Касса                            = "";
		СтруктураПараметров.ФормаОплаты                      = "";
		
		СтруктураПараметров.Менеджер                         = "Объект.Менеджер";
		СтруктураПараметров.НомерВходящегоДокумента          = "Объект.Номер";
		СтруктураПараметров.ДатаВходящегоДокумента           = "Объект.Дата";
		
		МассивПараметров.Добавить(СтруктураПараметров);
	
	КонецЕсли;
	
	#КонецОбласти
	
	#КонецОбласти
	
	#Область ОрганизацияПолучатель
	
	#Область Получатель
	
	СтруктураПараметров = ВзаиморасчетыСервер.ПараметрыМеханизма();
	
	СтруктураПараметров.ЭтоДоговор                       = Истина;
	
	СтруктураПараметров.ТипРасчетов                      = Перечисления.ТипыРасчетовСПартнерами.РасчетыСПоставщиком;
	
	// Для отображения гиперссылки
	СтруктураПараметров.ИзменяетПланОплаты = ТипДоговора = Перечисления.ТипыДоговоровМеждуОрганизациями.КупляПродажа
											И Сумма <> 0;
	
	СтруктураПараметров.Дата                             = "Объект.Дата"; 
	
	// Валюта и сумма операции. Обязательно путь к реквизитам объекта.
	СтруктураПараметров.ВалютаДокумента                  = "Объект.ВалютаВзаиморасчетов";
	СтруктураПараметров.СуммаДокумента                   = "Объект.Сумма";
	СтруктураПараметров.Организация                      = "Объект.ОрганизацияПолучатель";
	СтруктураПараметров.Контрагент                       = "Объект.Организация";
	СтруктураПараметров.Партнер                          = Справочники.Партнеры.НашеПредприятие;
	СтруктураПараметров.Договор                          = "Объект.Ссылка";
	СтруктураПараметров.ПорядокРасчетов                  = "Объект.ПорядокРасчетов";
	СтруктураПараметров.Соглашение                       = "";
	
	// Используются для определения значения ОплатаВВалюте и в форме редактирования правил оплаты.
	СтруктураПараметров.БанковскийСчетОрганизации        = "Объект.БанковскийСчетПолучателя";
	СтруктураПараметров.БанковскийСчетКонтрагента        = "Объект.БанковскийСчет";
	СтруктураПараметров.Касса                            = "";
	СтруктураПараметров.ФормаОплаты                      = "";
	
	СтруктураПараметров.ГруппаФинансовогоУчета           = "Объект.ГруппаФинансовогоУчетаПолучателя";
	СтруктураПараметров.Менеджер                         = "Объект.Менеджер";
	СтруктураПараметров.НомерВходящегоДокумента          = "Объект.Номер";
	СтруктураПараметров.ДатаВходящегоДокумента           = "Объект.Дата";
	
	МассивПараметров.Добавить(СтруктураПараметров);
	
	#КонецОбласти
	
	#Область ПолучательВознаграждение
	
	Если ТипДоговора = Перечисления.ТипыДоговоровМеждуОрганизациями.Комиссионный Тогда
	
		СтруктураПараметров = ВзаиморасчетыСервер.ПараметрыМеханизма();
		
		СтруктураПараметров.ЭтоДоговор                       = Истина;
		СтруктураПараметров.ТипРасчетов                      = Перечисления.ТипыРасчетовСПартнерами.РасчетыСКлиентом;
		
		СтруктураПараметров.ИзменяетПланОплаты = Ложь;
		СтруктураПараметров.ИзменяетПланОтгрузкиПоставки = Ложь;
		
		СтруктураПараметров.Дата                             = "Объект.Дата"; 
		
		// Валюта и сумма операции. Обязательно путь к реквизитам объекта.
		СтруктураПараметров.ВалютаДокумента                  = "Объект.ВалютаВзаиморасчетов";
		СтруктураПараметров.СуммаДокумента                   = "Объект.Сумма";
		СтруктураПараметров.Организация                      = "Объект.ОрганизацияПолучатель";
		СтруктураПараметров.Контрагент                       = "Объект.Организация";
		СтруктураПараметров.Партнер                          = Справочники.Партнеры.НашеПредприятие;
		СтруктураПараметров.Договор                          = "Объект.Ссылка";
		СтруктураПараметров.ПорядокРасчетов                  = "Объект.ПорядокРасчетов";
		СтруктураПараметров.Соглашение                       = "";
		
		// Используются для определения значения ОплатаВВалюте и в форме редактирования правил оплаты.
		СтруктураПараметров.БанковскийСчетОрганизации        = "Объект.БанковскийСчетПолучателя";
		СтруктураПараметров.БанковскийСчетКонтрагента        = "Объект.БанковскийСчет";
		СтруктураПараметров.Касса                            = "";
		СтруктураПараметров.ФормаОплаты                      = "";
		
		СтруктураПараметров.Менеджер                         = "Объект.Менеджер";
		СтруктураПараметров.НомерВходящегоДокумента          = "Объект.Номер";
		СтруктураПараметров.ДатаВходящегоДокумента           = "Объект.Дата";
		
		МассивПараметров.Добавить(СтруктураПараметров);
		
	КонецЕсли;
	
	#КонецОбласти
	
	#КонецОбласти
	
	Возврат МассивПараметров;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	ДоговорыМеждуОрганизациямиЛокализация.ДобавитьКомандыПечати(КомандыПечати);
КонецПроцедуры

#КонецОбласти

#Область Отчеты

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.КомандыОтчетов
//   Параметры - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.Параметры
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	ВариантыОтчетовУТПереопределяемый.ДобавитьКомандуСтруктураПодчиненности(КомандыОтчетов);

	ДоговорыМеждуОрганизациямиЛокализация.ДобавитьКомандыСозданияНаОсновании(КомандыОтчетов, Параметры);
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
//  Обработчики - ТаблицаЗначений - описание полей, см. в процедуре
//                ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.Версия              = "1.1.0.0";
//  Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_1_0_0";
//  Обработчик.МонопольныйРежим    = Ложь;
//
// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ОписаниеОбработчиковОбновления(Обработчики) Экспорт
	
#Область ОбработатьДанныеДляПереходаНаНовуюВерсию

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "Справочники.ДоговорыМеждуОрганизациями.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("e92d33a8-6245-4f82-a9dc-1f7caa44cd55");
	Обработчик.Многопоточный = Истина;
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "Справочники.ДоговорыМеждуОрганизациями.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Комментарий = НСтр("ru='Заполняет реквизит ГруппаФинансовогоУчетаПолучателя на основании реквизита ГруппаФинансовогоУчета.
                                   |Заполняет признак Оплата в иностранной валюте. 
                                   |Генерирует элементы справочника Объекты расчетов для договоров с порядком расчета По договорам.'
                                   |;uk='Заповнює реквізит ГруппаФинансовогоУчетаПолучателя на підставі реквізиту ГруппаФинансовогоУчета.
                                   |Заповнює ознаку Оплата в іноземній валюті.
                                   |Генерує елементи довідника Об''єкти розрахунків для договорів із порядком розрахунку За договорами.'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Справочники.ДоговорыМеждуОрганизациями.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Справочники.ОбъектыРасчетов.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Справочники.ГруппыФинансовогоУчетаРасчетов.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.Справочники.ДоговорыМеждуОрганизациями.ПолноеИмя());
	Изменяемые.Добавить(Метаданные.Справочники.ОбъектыРасчетов.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
	Блокируемые = Новый Массив;
	Блокируемые.Добавить(Метаданные.Справочники.ДоговорыМеждуОрганизациями.ПолноеИмя());
	Блокируемые.Добавить(Метаданные.Справочники.ОбъектыРасчетов.ПолноеИмя());
	Обработчик.БлокируемыеОбъекты = СтрСоединить(Блокируемые, ",");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.ГруппыФинансовогоУчетаРасчетов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.ДоговорыКонтрагентов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";

	
	Исключения = ОбновлениеИнформационнойБазыПереопределяемый.ИсключенияПриДобавленииПриоритетов();
	НоваяСтрока = Исключения.Добавить();
	НоваяСтрока.ИмяОбъекта = "Документы.ПервичныйДокумент";
	НоваяСтрока.Порядок    = "После"; 
	ОбновлениеИнформационнойБазыПереопределяемый.ДобавитьПриоритетыСгенерироватьОбъектыРасчетов(
		Обработчик.ПриоритетыВыполнения,
		"Любой",
		Исключения
	);
	
#КонецОбласти	

КонецПроцедуры

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.ПолныеИменаОбъектов = "Справочник.ДоговорыМеждуОрганизациями";
	ПараметрыВыборки.ПоляУпорядочиванияПриРаботеПользователей.Добавить("Дата");
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиСсылки();
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Договоры.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ДоговорыМеждуОрганизациями КАК Договоры
	|ГДЕ
	|	Договоры.УдалитьПорядокОплаты <> ЗНАЧЕНИЕ(Перечисление.УдалитьПорядокОплатыПоСоглашениям.ПустаяСсылка)
	|	ИЛИ (Договоры.ГруппаФинансовогоУчетаПолучателя = ЗНАЧЕНИЕ(Справочник.ГруппыФинансовогоУчетаРасчетов.ПустаяСсылка)
	|		И Договоры.ГруппаФинансовогоУчетаПолучателя <> Договоры.ГруппаФинансовогоУчета)
	|	ИЛИ (Договоры.ПорядокРасчетов = ЗНАЧЕНИЕ(Перечисление.ПорядокРасчетов.ПоДоговорамКонтрагентов)
	|		И НЕ ИСТИНА В
	|		(ВЫБРАТЬ ПЕРВЫЕ 1
	|			ИСТИНА
	|		ИЗ
	|			Справочник.ОбъектыРасчетов КАК ОбъектыРасчетов
	|		ГДЕ
	|			ОбъектыРасчетов.Объект = Договоры.Ссылка))";
	
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяОбъекта = ПустаяСсылка().Метаданные().ПолноеИмя();
	
	ОбновляемыеДанные = ОбновлениеИнформационнойБазы.ДанныеДляОбновленияВМногопоточномОбработчике(Параметры);
	
	Запрос = Новый Запрос;
	ТекстЗапроса = "ВЫБРАТЬ
	|	ДоговорыМеждуОрганизациями.Ссылка,
	|	ВЫБОР
	|		КОГДА ОбъектыРасчетов.Ссылка ЕСТЬ NULL
	|		И ДоговорыМеждуОрганизациями.ПорядокРасчетов = ЗНАЧЕНИЕ(Перечисление.ПорядокРасчетов.ПоДоговорамКонтрагентов)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК ТребуетсяСоздатьОбъектРасчетов
	|ИЗ
	|	Справочник.ДоговорыМеждуОрганизациями КАК ДоговорыМеждуОрганизациями
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ОбъектыРасчетов КАК ОбъектыРасчетов
	|		ПО ОбъектыРасчетов.Объект = ДоговорыМеждуОрганизациями.Ссылка
	|ГДЕ
	|	ДоговорыМеждуОрганизациями.Ссылка В (&ОбновляемыеДанные)";
	
	ТекстЗапроса = ТекстЗапроса + ОбъектыРасчетовСервер.ТекстПроверкаИспользованияВРасчетныхРегистрах();
	
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("ОбновляемыеДанные", ОбновляемыеДанные);
	РезультатЗапроса = Запрос.ВыполнитьПакет(); 
	ЭлементСправочника = РезультатЗапроса[0].Выбрать();
	
	ИспользованиеВРасчетныхРегистрах = РезультатЗапроса[1].Выгрузить();
	ИспользованиеВРасчетныхРегистрах.Индексы.Добавить("ОбъектРасчетов, Организация, ТипРасчетов");
	
	Пока ЭлементСправочника.Следующий() Цикл
	
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировки.УстановитьЗначение("Ссылка", ЭлементСправочника.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			
			Блокировка.Заблокировать();
			
			СправочникОбъект = ЭлементСправочника.Ссылка.ПолучитьОбъект();
			
			Если СправочникОбъект = Неопределено Тогда
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(ЭлементСправочника.Ссылка);
				ЗафиксироватьТранзакцию();
				Продолжить;
			КонецЕсли;
			
			
			Если ЗначениеЗаполнено(СправочникОбъект.УдалитьПорядокОплаты) Тогда
					СправочникОбъект.ОплатаВВалюте = (СправочникОбъект.УдалитьПорядокОплаты = Перечисления.УдалитьПорядокОплатыПоСоглашениям.РасчетыВВалютеОплатаВВалюте);
				КонецЕсли;
				
			Если Не ЗначениеЗаполнено(СправочникОбъект.ГруппаФинансовогоУчетаПолучателя) Тогда
				СправочникОбъект.ГруппаФинансовогоУчетаПолучателя = СправочникОбъект.ГруппаФинансовогоУчета;
			КонецЕсли;
			
			Если ЭлементСправочника.ТребуетсяСоздатьОбъектРасчетов Тогда
				
				ПараметрыГенерации = ПараметрыВзаиморасчеты(СправочникОбъект.ТипДоговора, СправочникОбъект.Сумма);
				
				Если Не ТипЗнч(ПараметрыГенерации) = Тип("Массив") Тогда
					ПараметрыГенерации = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ПараметрыГенерации);
				КонецЕсли;
				
				ДополненныеПараметрыМеханизма = ВзаиморасчетыСервер.ДополненныеПараметрыМеханизма(СправочникОбъект, ПараметрыГенерации);
				ОбъектыРасчетовСервер.ДополнитьПараметрыГенерацииИсключениями(ДополненныеПараметрыМеханизма.МассивПараметров, ИспользованиеВРасчетныхРегистрах, СправочникОбъект);
				
				Для Каждого ПараметрГенерации Из ДополненныеПараметрыМеханизма.МассивПараметров Цикл
					НовыйОбъектРасчетов = ОбъектыРасчетовСервер.ПроверитьЗаполнитьОбъектРасчетовПоСтруктуре(СправочникОбъект, ПараметрГенерации);
					Если Не ЗначениеЗаполнено(НовыйОбъектРасчетов) Тогда
						ВызватьИсключение(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
							НСтр("ru='Не удалось создать объект расчетов для договора: %1.';uk='Не вдалося створити об''єкт розрахунків для договору: %1.'"),
							ЭлементСправочника.Ссылка));
					КонецЕсли;
				КонецЦикла;
				
			КонецЕсли;
			
			Если СправочникОбъект.Модифицированность() Тогда
				ОбновлениеИнформационнойБазы.ЗаписатьОбъект(СправочникОбъект);
			Иначе
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(ЭлементСправочника.Ссылка);
			КонецЕсли;
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ОбновлениеИнформационнойБазыУТ.СообщитьОНеудачнойОбработке(ИнформацияОбОшибке(), ЭлементСправочника.Ссылка);
			
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
