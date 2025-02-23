
#Область ПрограммныйИнтерфейс

#Область Проведение

// Описывает учетные механизмы используемые в документе для регистрации в механизме проведения.
//
// Параметры:
//  МеханизмыДокумента - Массив - список имен учетных механизмов, для которых будет выполнена
//              регистрация в механизме проведения.
//
Процедура ЗарегистрироватьУчетныеМеханизмы(МеханизмыДокумента) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытий

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый документ.
//  Отказ - Булево - Признак проведения документа.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то проведение документа выполнено не будет.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ОбработкаПроведения(Объект, Отказ, РежимПроведения) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то будет выполнен отказ от продолжения работы после выполнения проверки заполнения.
//  ПроверяемыеРеквизиты - Массив - Массив путей к реквизитам, для которых будет выполнена проверка заполнения.
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения.
//  СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
	//++ Локализация
	ТипОснования = ТипЗнч(ДанныеЗаполнения);
	
//	Если Истина Тогда
	
	//++ НЕ УТ
	Если ТипОснования = Тип("ДокументСсылка.ДоговорЗаймаСотруднику") Тогда
		ДенежныеСредстваСерверЛокализация.ЗаполнитьПоДоговоруЗаймаСотруднику(ДанныеЗаполнения, ДанныеЗаполнения, Объект.РасшифровкаПлатежа, Ложь);
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Структура")
		И ДанныеЗаполнения.Свойство("ДокументОснование")
		И ТипЗнч(ДанныеЗаполнения.ДокументОснование) = Тип("ДокументСсылка.НачислениеДивидендов") Тогда
		
		НоваяСтрока = Объект.РасшифровкаПлатежа.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ДанныеЗаполнения);
	
	ИначеЕсли ТипОснования = Тип("ДокументСсылка.ПоступлениеДенежныхДокументов") Тогда
		Документы.ПоступлениеДенежныхДокументов.ЗаполнитьПоОснованию(Объект, ДанныеЗаполнения);
		Объект.ЗаполнитьРеквизитыЗначениямиПоУмолчанию();
		Возврат;
	
	ИначеЕсли ТипОснования = Тип("Структура") И ДанныеЗаполнения.Свойство("МассивВедомостей") Тогда
		ЗаполнитьПоВедомостям(Объект, ДанныеЗаполнения);
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Структура") И ДанныеЗаполнения.Свойство("ПлатежиПоНалогам") Тогда
		ПлатежиПоНалогам = ПолучитьИзВременногоХранилища(ДанныеЗаполнения.ПлатежиПоНалогам);
		ЗаполнитьЗначенияСвойств(Объект,ПлатежиПоНалогам);
		Для Каждого СтрокаПлатежа Из ПлатежиПоНалогам.ТаблицаРасшифровкаПлатежа Цикл
			НоваяСтрока = Объект.РасшифровкаПлатежа.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаПлатежа);
			НоваяСтрока.СтатьяРасходов = ПланыВидовХарактеристик.СтатьиАктивовПассивов.Налоги;
		КонецЦикла;	
		
		
	КонецЕсли;
//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//
Процедура ОбработкаУдаленияПроведения(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то запись выполнена не будет и будет вызвано исключение.
//  РежимЗаписи - РежимЗаписиДокумента - В параметр передается текущий режим записи документа. Позволяет определить в теле процедуры режим записи.
//  РежимПроведения - РежимПроведенияДокумента - В данный параметр передается текущий режим проведения.
//
Процедура ПередЗаписью(Объект, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  ОбъектКопирования - ДокументОбъект.ЗаявкаНаРасходованиеДенежныхСредств - Исходный документ, который является источником копирования.
//
Процедура ПриКопировании(Объект, ОбъектКопирования) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

// Определяет список команд создания на основании.
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//  Параметры - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.Параметры
//
Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Добавляет команду создания документа "Авансовый отчет".
//
// Параметры:
//  КомандыСозданияНаОсновании - см. СозданиеНаОснованииПереопределяемый.ПередДобавлениемКомандСозданияНаОсновании.КомандыСозданияНаОсновании
//
Процедура ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт


КонецПроцедуры

// Определяет список команд отчетов.
//
// Параметры:
//   КомандыОтчетов - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.КомандыОтчетов
//   Параметры - См. ВариантыОтчетовПереопределяемый.ПередДобавлениемКомандОтчетов.Параметры
//
Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область Печать

// Формирует печатные формы.
//
// Параметры:
//  МассивОбъектов  - Массив    - ссылки на объекты, которые нужно распечатать;
//  ПараметрыПечати - Структура - дополнительные настройки печати;
//  КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы (выходной параметр)
//  ОбъектыПечати         - СписокЗначений  - значение - ссылка на объект;
//                                            представление - имя области в которой был выведен объект (выходной параметр);
//  ПараметрыВывода       - Структура       - дополнительные параметры сформированных табличных документов (выходной параметр).
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Проведение

// Процедура дополняет тексты запросов проведения документа.
//
// Параметры:
//  Запрос - Запрос - Общий запрос проведения документа.
//  ТекстыЗапроса - СписокЗначений - Список текстов запроса проведения.
//  Регистры - Строка, Структура - Список регистров проведения документа через запятую или в ключах структуры.
//
Процедура ДополнитьТекстыЗапросовПроведения(Запрос, ТекстыЗапроса, Регистры) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область Прочее
//++ Локализация

//++ НЕ УТ
Процедура ЗаполнитьПоВедомостям(Объект, ДанныеЗаполнения)
	
	ДанныеЗаполнения.Вставить("Валюта", Константы.ВалютаРегламентированногоУчета.Получить());
	
	ХозяйственнаяОперация = Неопределено;
	ДанныеЗаполнения.Свойство("ХозяйственнаяОперация", ХозяйственнаяОперация);
	Если Не ЗначениеЗаполнено(ХозяйственнаяОперация) Тогда
		ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВыплатаЗарплаты;
	КонецЕсли;
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("МассивВедомостей", ДанныеЗаполнения.МассивВедомостей);
	СтруктураПараметров.Вставить("ХозяйственнаяОперация", ХозяйственнаяОперация);
	
	Если ДанныеЗаполнения.Свойство("Организация") И ЗначениеЗаполнено(ДанныеЗаполнения.Организация) Тогда
		СтруктураПараметров.Вставить("Организация", ДанныеЗаполнения.Организация);
	КонецЕсли;
	
	ИнтеграцияБЗК.ПодготовитьДанныеОСостоянииВедомостей(МенеджерВременныхТаблиц, СтруктураПараметров);
	
	ДанныеВедомостей = ИнтеграцияБЗК.ДанныеВедомостей(СтруктураПараметров, МенеджерВременныхТаблиц);
	РеквизитыШапки = ДанныеВедомостей.РеквизитыШапки;
	
	Если РеквизитыШапки = Неопределено Тогда
		Текст = НСтр("ru='Команда не может быть выполнена для указанного объекта';uk='Команда не може бути виконана для зазначеного об''єкта'");
		ВызватьИсключение Текст;
	КонецЕсли;
	
	Если ДанныеВедомостей.МассивОшибок.Количество() > 0 Тогда
		Текст = ДанныеВедомостей.МассивОшибок[0].Текст;
		ВызватьИсключение Текст;
	КонецЕсли;
	
		ДанныеЗаполнения.Вставить("ХозяйственнаяОперация", Перечисления.ХозяйственныеОперации.ВыплатаЗарплаты);
		ДанныеЗаполнения.Вставить("ХозяйственнаяОперацияПоЗарплате", РеквизитыШапки.ХозяйственнаяОперация);
		Если РеквизитыШапки.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВыплатаЗарплатыРаздатчиком Тогда
			ДанныеЗаполнения.ХозяйственнаяОперацияПоЗарплате = Перечисления.ХозяйственныеОперации.ВыплатаЗарплатыЧерезКассу;
		КонецЕсли;
	
	Если Не (ДанныеЗаполнения.Свойство("Организация") И ЗначениеЗаполнено(ДанныеЗаполнения.Организация)) Тогда
		ДанныеЗаполнения.Вставить("Организация", РеквизитыШапки.Организация);
	КонецЕсли;
	
	ДанныеЗаполнения.Вставить("ФормаОплатыЗаявки",      РеквизитыШапки.ФормаОплаты);
	ДанныеЗаполнения.Вставить("ФормаОплатыБезналичная", РеквизитыШапки.ФормаОплаты = Перечисления.ФормыОплаты.Безналичная);
	ДанныеЗаполнения.Вставить("ФормаОплатыНаличная",    РеквизитыШапки.ФормаОплаты = Перечисления.ФормыОплаты.Наличная);
	
	Если ДанныеЗаполнения.ФормаОплатыБезналичная Тогда
		
		Если Не (ДанныеЗаполнения.Свойство("БанковскийСчет") И ЗначениеЗаполнено(ДанныеЗаполнения.БанковскийСчет)) Тогда
			
			БанковскийСчет = Справочники.БанковскиеСчетаОрганизаций.ПолучитьБанковскийСчетОрганизацииПоУмолчанию(
				ДанныеЗаполнения.Организация, ДанныеЗаполнения.Валюта);
			
			ДанныеЗаполнения.Вставить("БанковскийСчет", БанковскийСчет);
			
		КонецЕсли;
		
	ИначеЕсли ДанныеЗаполнения.ФормаОплатыНаличная Тогда
		
		Если Не (ДанныеЗаполнения.Свойство("Касса") И ЗначениеЗаполнено(ДанныеЗаполнения.Касса)) Тогда
			
			Касса = Справочники.Кассы.ПолучитьКассуПоУмолчанию(
				ДанныеЗаполнения.Организация, ДанныеЗаполнения.Валюта);
			
			ДанныеЗаполнения.Вставить("Касса", Касса);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	СтатьяДДС = Справочники.СтатьиДвиженияДенежныхСредств.СтатьяДвиженияДенежныхСредствПоХозяйственнойОперации(
		РеквизитыШапки.ХозяйственнаяОперация);
	Запрос.УстановитьПараметр("СтатьяДДС", СтатьяДДС);
	
	Если Не ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПеречислениеВБюджет Тогда
		
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ДанныеВедомостей.Ведомость КАК Ведомость,
		|	&СтатьяДДС КАК СтатьяДвиженияДенежныхСредств,
		|	СУММА(ДанныеВедомостей.СуммаОплаты) КАК СуммаОплаты,
		|	СУММА(ДанныеВедомостей.Сумма) КАК Сумма,
		|	МАКСИМУМ(Заявки.Ссылка) КАК Заявка
		|ИЗ
		|	ВТСостояниеВыплатыПоВедомостям КАК ДанныеВедомостей
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТЗаявкиВедомостей КАК Заявки
		|		ПО Заявки.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВыплатаЗарплаты)
		|			И ДанныеВедомостей.Ведомость = Заявки.Ведомость
		|
		|СГРУППИРОВАТЬ ПО
		|	ДанныеВедомостей.Ведомость";
		
	ИначеЕсли ДанныеЗаполнения.Свойство("РегистрацияВНалоговомОргане") Тогда
		
		Запрос.УстановитьПараметр("РегистрацияВНалоговомОргане", ДанныеЗаполнения.РегистрацияВНалоговомОргане);
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ДанныеВедомостей.Ведомость КАК Ведомость,
		|	&СтатьяДДС КАК СтатьяДвиженияДенежныхСредств,
		|	СУММА(ВЫБОР
		|		КОГДА ДанныеВедомостей.РегистрацияВНалоговомОргане = &РегистрацияВНалоговомОргане
		|			ТОГДА ДанныеВедомостей.СуммаОплаты
		|		ИНАЧЕ 0
		|	КОНЕЦ) КАК СуммаОплаты,
		|	СУММА(ВЫБОР
		|		КОГДА ДанныеВедомостей.РегистрацияВНалоговомОргане = &РегистрацияВНалоговомОргане
		|			ТОГДА ДанныеВедомостей.Сумма
		|		ИНАЧЕ 0
		|	КОНЕЦ) КАК Сумма,
		|	МАКСИМУМ(Заявки.Ссылка) КАК Заявка
		|ИЗ
		|	ВТСостояниеНалоговПоВедомостям КАК ДанныеВедомостей
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТЗаявкиВедомостей КАК Заявки
		|		ПО Заявки.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПеречислениеВБюджет)
		|			И ДанныеВедомостей.РегистрацияВНалоговомОргане = Заявки.РегистрацияВНалоговомОргане
		|			И ДанныеВедомостей.РегистрацияВНалоговомОргане = &РегистрацияВНалоговомОргане
		|			И ДанныеВедомостей.Ведомость = Заявки.Ведомость
		|
		|СГРУППИРОВАТЬ ПО
		|	ДанныеВедомостей.Ведомость";
		
	Иначе
		
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ДанныеВедомостей.Ведомость КАК Ведомость,
		|	&СтатьяДДС КАК СтатьяДвиженияДенежныхСредств,
		|	СУММА(ДанныеВедомостей.СуммаОплаты) КАК СуммаОплаты,
		|	СУММА(ДанныеВедомостей.Сумма) КАК Сумма,
		|	МАКСИМУМ(Заявки.Ссылка) КАК Заявка
		|ИЗ
		|	ВТСостояниеНалоговПоВедомостям КАК ДанныеВедомостей
		|	ЛЕВОЕ СОЕДИНЕНИЕ ВТЗаявкиВедомостей КАК Заявки
		|		ПО Заявки.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПеречислениеВБюджет)
		|			И ДанныеВедомостей.Ведомость = Заявки.Ведомость
		|
		|СГРУППИРОВАТЬ ПО
		|	ДанныеВедомостей.Ведомость";
		
	КонецЕсли;
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		Если ЗначениеЗаполнено(Выборка.Заявка) И Выборка.Заявка <> Объект.Ссылка Тогда
			Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='%1 уже включена в заявку %2 и будет пропущена.';uk='%1 вже включена в заявку %2 і буде пропущена.'"), Выборка.Ведомость, Выборка.Заявка);
			ОбщегоНазначения.СообщитьПользователю(Текст);
			Продолжить;
		КонецЕсли;
		
		Если Выборка.СуммаОплаты <> 0 Тогда
			Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Выплаты по ведомости %1 уже выполнялись.';uk='Виплати за відомістю %1 вже виконувалися.'"), Выборка.Ведомость);
			ОбщегоНазначения.СообщитьПользователю(Текст);
		КонецЕсли;
		
		НоваяСтрока = Объект.РасшифровкаПлатежа.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
		
	КонецЦикла;
	
	ДанныеЗаполнения.Вставить("СуммаДокумента", Объект.РасшифровкаПлатежа.Итог("Сумма"));
	
КонецПроцедуры


//-- НЕ УТ

//-- Локализация
#КонецОбласти

#КонецОбласти
