////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Принятие к учету НМА".
// 
////////////////////////////////////////////////////////////////////////////////

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

#Область Прочее

// Добавляет в текст запроса реквизиты шапки документа.
//  Реквизиты добавляются вместо параметра "&ПринятиеКУчетуНМА_РеквизитыДокумента".
//
// Параметры:
//  ТекстЗапроса - Строка				 - Исходный текст запроса.
//  ИмяТаблицы	 - Строка, Неопределено	 - Синоним таблицы документа в запросе.
//  	Для получения пустых значений нужно передать "Неопределено".
//
Процедура ДобавитьВТекстЗапросаРеквизитыДокумента(ТекстЗапроса, ИмяТаблицы = Неопределено) Экспорт
	
	ПоляЛокализации = "NULL";
	
	ПолеСтатьяРасходовУУ =
	"ДанныеДокумента.СтатьяРасходовУУ";
	
	ПолеАналитикаРасходовУУ =
	"ДанныеДокумента.АналитикаРасходовУУ";
	
	//++ Локализация
	//-- Локализация
	
	ПолеСтатьяРасходовУУ = СтрЗаменить(ПолеСтатьяРасходовУУ, "ДанныеДокумента", ИмяТаблицы);
	ПолеАналитикаРасходовУУ = СтрЗаменить(ПолеАналитикаРасходовУУ, "ДанныеДокумента", ИмяТаблицы);

	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПринятиеКУчетуНМА_РеквизитыДокумента", ПоляЛокализации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПринятиеКУчетуНМА_СтатьяРасходовУУ", ПолеСтатьяРасходовУУ);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ПринятиеКУчетуНМА_АналитикаРасходовУУ", ПолеАналитикаРасходовУУ);
	
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
Процедура ОбработкаПроверкиЗаполнения(Объект, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	
КонецПроцедуры

// Вызывается из соответствующего обработчика документа
//
// Параметры:
//  Объект - ДокументОбъект - Обрабатываемый объект.
//  ДанныеЗаполнения - Произвольный - Значение, которое используется как основание для заполнения.
//  СтандартнаяОбработка - Булево - В данный параметр передается признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка) Экспорт
	
	//++ Локализация
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

#КонецОбласти

//++ НЕ УТ
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
	
	ТекстЗапроса = "";
	
	//++ Локализация
	//-- Локализация
	Возврат ТекстЗапроса;
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

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

Функция ТекстЗапросаТаблицаВтИсходныеПрочиеРасходы(ТекстыЗапроса, Запрос) Экспорт

	ТекстЗапроса = Неопределено;

	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Процедура ДополнитьТекстЗапросаТаблицаДвиженияДоходыРасходыПрочиеАктивыПассивы(СписокЗапросовОбъединение) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ДополнитьСписокРегистровРасчетаСтоимости(СписокРегистров) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
  
Функция ТекстЗапросаТаблицаПервоначальныеСведенияНМА(ТекстыЗапроса, Запрос) Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация

	Возврат ТекстЗапроса;
	
КонецФункции

Функция ТекстЗапросаТаблицаСтоимостьНМА(ТекстыЗапроса, Запрос) Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции
 
Процедура ЗаполнитьПараметрыИнициализации(Запрос, Реквизиты) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#Область ФормаДокумента

Процедура ПослеЗаписиНаСервере(Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
Процедура ПриИзмененииРеквизита(ИмяЭлемента, Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// 
// Параметры:
// 	ИмяКоманды - Строка
// 	Форма - ФормаКлиентскогоПриложения - 
Процедура ПриВыполненииКоманды(ИмяКоманды, Форма) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ПриЧтенииСозданииНаСервере(Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура НастроитьЗависимыеЭлементыФормы(Форма, СтруктураИзмененныхРеквизитов) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#Область Прочее

Процедура ЗаполнитьДокументПоОтбору(Объект, Основание) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ДополнитьВспомогательныеРеквизиты(Объект, ВспомогательныеРеквизиты) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ДополнитьСписокРеквизитовСЗаданнымПредставлением(СписокРеквизитов) Экспорт

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

#Область Проведение

//++ Локализация
//-- Локализация

#КонецОбласти

#Область Заполнение

//++ Локализация
//-- Локализация

#КонецОбласти

#Область ФормаДокумента

//++ Локализация
//-- Локализация

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(ДанныеОбъекта) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#КонецОбласти
