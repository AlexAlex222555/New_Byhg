#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает структуру с именем и праметрами открытия формы
//
// Параметры:
//  ЗадачаСсылка - ЗадачаСсылка.ЗадачаИсполнителя - ссылка на задачу, для которой необходимо получить форму
//  ТочкаМаршрутаСсылка - ТочкаМаршрутаБизнесПроцессаСсылка.СогласованиеЗаявкиНаВозвратТоваровОтКлиента - ссылка
//                                                   на точку маршрута бизнес-процесса, для которой необходимо получить форму.
//
// Возвращаемое значение:
//  Структура - со свойствами:
//  * ПараметрыФормы - Структура - со свойствами:
//    ** Ключ - ЗадачаСсылка - Ссылка на задачу
//  * ИмяФормы - Строка - Имя формы.
//
Функция ФормаВыполненияЗадачи(Знач ЗадачаСсылка, Знач ТочкаМаршрутаСсылка) Экспорт
	
	Если ТочкаМаршрутаСсылка = БизнесПроцессы.СогласованиеЦенНоменклатуры.ТочкиМаршрута.ОзнакомитьсяСРезультатами Тогда
		ИмяФормы = "БизнесПроцесс.СогласованиеЦенНоменклатуры.Форма.ФормаЗадачиОзнакомиться";
	ИначеЕсли ТочкаМаршрутаСсылка = БизнесПроцессы.СогласованиеЦенНоменклатуры.ТочкиМаршрута.СогласоватьУстановкуЦенНоменклатуры Тогда
		ИмяФормы = "БизнесПроцесс.СогласованиеЦенНоменклатуры.Форма.ФормаЗадачиРецензента";
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("ПараметрыФормы", Новый Структура("Ключ", ЗадачаСсылка));
	Результат.Вставить("ИмяФормы", ИмяФормы);
	
	Возврат Результат;
	
КонецФункции

// Вызывается при выполнении задачи из формы списка
//
// Параметры:
//	ЗадачаСсылка                - ЗадачаСсылка.ЗадачаИсполнителя - задача
//	БизнесПроцессСсылка         - БизнесПроцессСсылка.СогласованиеЦенНоменклатуры - 
//	ТочкаМаршрутаБизнесПроцесса - ТочкаМаршрутаБизнесПроцессаСсылка.СогласованиеЦенНоменклатуры - 
//
Процедура ОбработкаВыполненияПоУмолчанию(Знач ЗадачаСсылка, БизнесПроцессСсылка, Знач ТочкаМаршрутаБизнесПроцесса) Экспорт
	
	// устанавливаем значения по умолчанию для пакетного выполнения задач
	Если ТочкаМаршрутаБизнесПроцесса = БизнесПроцессы.СогласованиеЦенНоменклатуры.ТочкиМаршрута.СогласоватьУстановкуЦенНоменклатуры Тогда
		
		Попытка
			ЗаблокироватьДанныеДляРедактирования(БизнесПроцессСсылка);
		Исключение
				
			ТекстОшибки = НСтр("ru='При выполнении задачи не удалось заблокировать %Ссылка%. %ОписаниеОшибки%';uk='При виконанні задачі не вдалося заблокувати %Ссылка%. %ОписаниеОшибки%'");
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%Ссылка%",         БизнесПроцессСсылка);
			ТекстОшибки = СтрЗаменить(ТекстОшибки, "%ОписаниеОшибки%", КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
				
			ВызватьИсключение ТекстОшибки;
			
		КонецПопытки;
		
		УстановитьПривилегированныйРежим(Истина);
	
		СогласованиеОбъект = БизнесПроцессСсылка.ПолучитьОбъект();
		
		СогласованиеОбъект.ДобавитьРезультатСогласования(
			ТочкаМаршрутаБизнесПроцесса,
			Пользователи.ТекущийПользователь(),
			Перечисления.РезультатыСогласования.Согласовано,
			,
			ТекущаяДатаСеанса());
		
		СогласованиеОбъект.РезультатСогласования = Перечисления.РезультатыСогласования.Согласовано;
		
		СогласованиеОбъект.Записать();
		УстановитьПривилегированныйРежим(Ложь);
		
		РазблокироватьДанныеДляРедактирования(БизнесПроцессСсылка);

	КонецЕсли;
	
КонецПроцедуры

// Возвращает результат согласования рецензентом по точке маршрута
//
// Параметры:
//	БизнесПроцесс - БизнесПроцессСсылка.СогласованиеЦенНоменклатуры - 
//	ТочкаМаршрута - ТочкаМаршрутаБизнесПроцессаСсылка.СогласованиеЦенНоменклатуры - 
//
// Возвращаемое значение:
//	ПеречислениеСсылка.РезультатыСогласования - Результат согласования в точке маршрута.
//
Функция РезультатСогласованияПоТочкеМаршрута(Знач БизнесПроцесс, Знач ТочкаМаршрута) Экспорт
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	СогласованиеЦенНоменклатурыРезультатыСогласования.РезультатСогласования КАК РезультатСогласования
		|
		|ИЗ
		|	БизнесПроцесс.СогласованиеЦенНоменклатуры.РезультатыСогласования КАК СогласованиеЦенНоменклатурыРезультатыСогласования
		|ГДЕ
		|	СогласованиеЦенНоменклатурыРезультатыСогласования.Ссылка = &Ссылка
		|	И СогласованиеЦенНоменклатурыРезультатыСогласования.ТочкаМаршрута = &ТочкаМаршрута
		|");
		
	Запрос.УстановитьПараметр("Ссылка",        БизнесПроцесс);
	Запрос.УстановитьПараметр("ТочкаМаршрута", ТочкаМаршрута);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.РезультатСогласования;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
		
КонецФункции

// Возвращает номер последней версии предмета
//
// Параметры:
//    БизнесПроцесс - БизнесПроцессСсылка.СогласованиеЦенНоменклатуры - 
//
// Возвращаемое значение:
//    Число - Номер последней версии документа.
//
Функция НомерПоследнейВерсииПредмета(Знач БизнесПроцесс) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	ВерсииОбъектов.НомерВерсии КАК НомерВерсии
		|ИЗ
		|	РегистрСведений.ВерсииОбъектов КАК ВерсииОбъектов
		|ГДЕ
		|	ВерсииОбъектов.Объект = ВЫРАЗИТЬ (&БизнесПроцесс КАК БизнесПроцесс.СогласованиеЦенНоменклатуры).Предмет
		|
		|УПОРЯДОЧИТЬ ПО
		|	НомерВерсии УБЫВ
		|
		|");
		
	Запрос.УстановитьПараметр("БизнесПроцесс", БизнесПроцесс);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		НомерВерсии = Выборка.НомерВерсии;
	Иначе
		НомерВерсии = 0;
	КонецЕсли;
	
	Возврат НомерВерсии;

КонецФункции

// Осуществляет проверку на отличия последней версии предмета от согласованных
//
// Параметры:
//	БизнесПроцесс - БизнесПроцессСсылка.СогласованиеЦенНоменклатуры - 
//
// Возвращаемое значение:
//	Булево - Истина, если отличия есть, иначе ложь.
//
Функция ПоследняяВерсияПредметаОтличаетсяОтСогласованных(Знач БизнесПроцесс) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	МАКСИМУМ(РезультатыСогласования.НомерВерсии)     КАК НомерСогласованнойВерсии,
		|	ЕСТЬNULL(МАКСИМУМ(ВерсииОбъектов.НомерВерсии),0) КАК НомерПоследнейВерсии
		|ИЗ
		|	БизнесПроцесс.СогласованиеЦенНоменклатуры.РезультатыСогласования КАК РезультатыСогласования
		|ЛЕВОЕ СОЕДИНЕНИЕ
		|	РегистрСведений.ВерсииОбъектов КАК ВерсииОбъектов
		|ПО
		|	ВерсииОбъектов.Объект = РезультатыСогласования.Ссылка.Предмет
		|ГДЕ
		|	РезультатыСогласования.Ссылка = &БизнесПроцесс
		|");
		
	Запрос.УстановитьПараметр("БизнесПроцесс", БизнесПроцесс);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Если Выборка.НомерСогласованнойВерсии <> Выборка.НомерПоследнейВерсии Тогда
			ЕстьОтличия = Истина;
		Иначе
			ЕстьОтличия = Ложь;
		КонецЕсли;
	Иначе
		ЕстьОтличия = Ложь;
	КонецЕсли;
	
	Возврат ЕстьОтличия;
	
КонецФункции

// Осуществляет проверку использования версионирования предмета согласования
//
// Параметры:
//	ТипПредмета - Строка - полное имя объекта, например "Документ.ЗаказКлиента".
//
// Возвращаемое значение:
//	Булево - Истина, если версионирование используется, иначе ложь.
//
Функция ИспользуетсяВерсионированиеПредмета(Знач ТипПредмета) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ИспользоватьВерсионированиеОбъектов = ПолучитьФункциональнуюОпцию("ИспользоватьВерсионированиеОбъектов");
	
	Если Не ИспользоватьВерсионированиеОбъектов Тогда
		Возврат Ложь;
	КонецЕсли;
		
	ПараметрыОпции = Новый Структура();
	ПараметрыОпции.Вставить("ТипОбъекта", ТипПредмета);
		
	ИспользоватьВерсионированиеОбъекта = ПолучитьФункциональнуюОпцию("ИспользоватьВерсионированиеОбъекта", ПараметрыОпции);
	
	Возврат ИспользоватьВерсионированиеОбъекта;
	
КонецФункции

// Вызывается при перенаправлении задачи
//
// Параметры:
//	ЗадачаСсылка  - ЗадачаСсылка.ЗадачаИсполнителя - перенаправляемая задача.
//	НоваяЗадачаСсылка  - ЗадачаСсылка.ЗадачаИсполнителя - задача для нового исполнителя.
//
Процедура ПриПеренаправленииЗадачи(ЗадачаСсылка, НоваяЗадачаСсылка) Экспорт
	
	Возврат;
	
КонецПроцедуры

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтение
	|ГДЕ ИСТИНА
	|;
	|РазрешитьИзменениеЕслиРазрешеноЧтение
	|ГДЕ
	|	ЗначениеРазрешено(Автор)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ОбновлениеИнформационнойБазы

// Установка значений реквизитов предопределенных элементов справочника РолиИсполнителей,
// относящихся к согласованию установки цен номенклатуры.
//
Процедура ИнициализироватьРолиИсполнителей() Экспорт
	
	РольОбъект = Справочники.РолиИсполнителей.СогласующийУстановкиЦенНоменклатуры.ПолучитьОбъект();
	РольОбъект.ИспользуетсяБезОбъектовАдресации = Истина;
	РольОбъект.Записать();
	
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
	
	КомандаОтчет = Отчеты.РезультатыСогласованияЦенНоменклатуры.ДобавитьКомандуОтчета(КомандыОтчетов);
	Если КомандаОтчет <> Неопределено Тогда
		КомандаОтчет.ВидимостьВФормах = "ФормаБизнесПроцесса,ФормаСписка";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли


