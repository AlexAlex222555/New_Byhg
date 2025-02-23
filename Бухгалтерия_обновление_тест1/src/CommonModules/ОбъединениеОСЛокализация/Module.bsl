////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Объединение ОС".
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Добавляет в текст запроса реквизиты шапки документа.
//  Реквизиты добавляются вместо параметра "&ОбъединениеОС_РеквизитыДокумента".
//
// Параметры:
//  ТекстЗапроса - Строка				 - Исходный текст запроса.
//  ИмяТаблицы	 - Строка, Неопределено	 - Синоним таблицы документа в запросе.
//  	Для получения пустых значений нужно передать "Неопределено".
//
Процедура ДобавитьВТекстЗапросаРеквизитыДокумента(ТекстЗапроса, ИмяТаблицы = Неопределено) Экспорт
	
	ПоляЛокализации = "НЕОПРЕДЕЛЕНО КАК НалогообложениеНДС";
	
	ПолеСтатьяРасходовУУ =
	"ДанныеДокумента.СтатьяРасходовУУ";
	
	ПолеАналитикаРасходовУУ =
	"ДанныеДокумента.АналитикаРасходовУУ";
	
	ПолеНачислятьИзнос =
	"ЛОЖЬ";
	
	//++ Локализация
	//-- Локализация
	
	ПолеСтатьяРасходовУУ = СтрЗаменить(ПолеСтатьяРасходовУУ, "ДанныеДокумента", ИмяТаблицы);
	ПолеАналитикаРасходовУУ = СтрЗаменить(ПолеАналитикаРасходовУУ, "ДанныеДокумента", ИмяТаблицы);
	ПолеНачислятьИзнос = СтрЗаменить(ПолеНачислятьИзнос, "ДанныеДокумента", ИмяТаблицы);

	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ОбъединениеОС_РеквизитыДокумента", ПоляЛокализации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ОбъединениеОС_СтатьяРасходовУУ", ПолеСтатьяРасходовУУ);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ОбъединениеОС_АналитикаРасходовУУ", ПолеАналитикаРасходовУУ);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ОбъединениеОС_НачислятьИзнос", ПолеНачислятьИзнос);
	
КонецПроцедуры

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

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

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
		
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Если в теле процедуры-обработчика установить данному параметру значение Истина,
//                   то будет выполнен отказ от продолжения работы после выполнения проверки заполнения.
//  ПроверяемыеРеквизиты - Массив - Массив путей к реквизитам, для которых будет выполнена проверка заполнения.
//
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты, ПараметрыВыбораОсновныхСредств) Экспорт
	
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
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка) Экспорт
	
	
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
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  Отказ - Булево - Признак отказа от записи.
//                   Если в теле процедуры-обработчика установить данному параметру значение Истина, то запись выполнена не будет и будет вызвано исключение.
//
Процедура ПриЗаписи(Объект, Отказ) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект
//  ОбъектКопирования - ДокументОбъект.<Имя документа> - Исходный документ, который является источником копирования.
//
Процедура ПриКопировании(Объект, ОбъектКопирования) Экспорт
	
	
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
	
	
КонецПроцедуры

// Добавляет команды печати.
// 
// Параметры:
// 	КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
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
	
	
КонецПроцедуры

Функция ПолучитьДанныеДляПечатнойФормыОС1(МассивОбъектов) Экспорт
	
	ДанныеДляПечатнойФормы = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ДанныеДляПечатнойФормы;
	
КонецФункции

Функция ПолучитьДанныеДляПечатнойФормыОС4(МассивОбъектов) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецФункции

#КонецОбласти

#Область ФормаДокумента

// Вызывается при изменении реквизита.
// 
// Параметры:
// 	ИмяЭлемента - Строка -
// 	Форма - ФормаКлиентскогоПриложения - 
// 	ДополнительныеПараметры - Структура - 
Процедура ПриИзмененииРеквизита(ИмяЭлемента, Форма, ДополнительныеПараметры) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Настраивает элементы формы, в зависимости от измененных реквизитов.
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - 
// 	СтруктураИзмененныхРеквизитов - Структура - 
Процедура НастроитьЗависимыеЭлементыФормы(Форма, СтруктураИзмененныхРеквизитов) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ДополнитьСлужебныеПараметрыФормы(СлужебныеПараметрыФормы) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Функция ТекстЗапросаДляПроверкиОС() Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Процедура ДополнитьПараметрыВыбораОсновныхСредств(ВыборкаПараметры, ПараметрыВыбораОсновныхСредств) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Функция ЭтоНеОднотипноеОСПоРезультатамПроверки(РезультатПроверки) Экспорт

	Результат = Ложь;
	
	//++ Локализация
	//-- Локализация

	Возврат Результат;
	
КонецФункции

Функция МожноОбъединитьПоРезультатамПроверки(РезультатПроверки) Экспорт
	
	Результат = Истина;
	//++ Локализация
	//-- Локализация

	Возврат Результат;

КонецФункции

// Дополняет описание проблем.
// 
// Параметры:
// 	РезультатПроверки - см. Документы.ОбъединениеОС.ПараметрыВыбораОсновныхСредств 
// 	ОписаниеПроблем - Массив -
Процедура ДополнитьОписаниеПроблемПриЗаполненииНаОснованииОбъектаЭксплуатации(РезультатПроверки, ОписаниеПроблем) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ДополнитьТекстЗапросаДляЗаполненияТекущихЗначенийПараметров(ТекстЗапроса) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ЗаполнитьПараметрыВыбораОС(ПараметрыВыбораОсновныхСредств, СлужебныеПараметрыФормы) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#Область Проведение

Процедура ТаблицыОтложенногоФормированияДвижений(Запрос, ТекстыЗапроса) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

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

Функция ТекстЗапросаТаблицаПервоначальныеСведенияОС(Запрос, ТекстыЗапроса) Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Процедура СообщитьОРезультатеПроверкиСтроки(Объект, Поле, РезультатПроверки, Отказ) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#Область ПроводкиРегУчета

// Функция возвращает текст запроса для отражения документа в регламентированном учете.
//
// Возвращаемое значение:
//	Строка - Текст запроса
//
Функция ТекстОтраженияВРеглУчете() Экспорт

	ТекстЗапроса = "";
		
	//++ Локализация
	//-- Локализация
	Возврат ТекстЗапроса;
	
КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц,
// необходимых для отражения в регламентированном учете
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчете() Экспорт
	
	Возврат "";
	
КонецФункции

#КонецОбласти

#Область Прочее

Процедура ДополнитьВспомогательныеРеквизиты(Объект, ПараметрыВыбораОсновныхСредств, ВспомогательныеРеквизиты) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Дополняет параметры выбора статей и аналитик.
// 
// Параметры:
// 	ПараметрыВыбораСтатьиИАналитики - Массив из см. ДоходыИРасходыСервер.ПараметрыВыбораСтатьиИАналитики -
Процедура ДополнитьПараметрыВыбораСтатейИАналитик(ПараметрыВыбораСтатьиИАналитики) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ФормаДокумента

//++ Локализация
//-- Локализация

#КонецОбласти

//++ Локализация
//-- Локализация

#Область ОбновлениеИнформационнойБазы

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ОбработатьОбъектДляПереходаНаНовуюВерсию(ДанныеОбъекта, ДопПараметры) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Функция ДопПараметрыДляПереходаНаНовуюВерсию(МенеджерВременныхТаблиц) Экспорт

	ДопПараметры = Неопределено;
	
	//++ Локализация
	//-- Локализация

	Возврат ДопПараметры;
	
КонецФункции
 
#КонецОбласти

#КонецОбласти
