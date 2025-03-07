
#Область ПрограммныйИнтерфейс

// Создает платежные документы, либо формирует данные заполнения для создания одного платежного документа.
//
// Параметры:
//    СтрокиГрафика - Массив - Ключи записей графика платежей
//    ТипДокумента - Строка - Тип создаваемых документов. Если не задан, будет определен автоматически.
//
// Возвращаемое значение:
//    Структура:
//        ОткрыватьФормуПомощника - Булево - Признак необходимости открытия формы помощника создания документов
//        ДокументКСозданию - Структура - Данные заполнения единственного документа
//        ДлительнаяОперация - Структура - Длительная операция создания нескольких документов
//        АдресСтрокГрафика - Строка - Адрес временного хранилища, в котором содержатся оплачиваемые строки графика.
//
Функция ОплатитьСтрокиГрафика(СтрокиГрафика, ТипДокумента) Экспорт
	
	//++ Локализация
	//-- Локализация
	Возврат Неопределено;
	
КонецФункции

// Формирует варианты наименования юридического лица в соответствии с его организационно-правовой формой.
//
// Параметры:
//    Наименование - Строка - Наименование юр. лица.
//
// Возвращаемое значение:
//    Структура - Наименование, РабочееНаименование, ПолноеНаименование.
//
Функция НаименованиеОрганизации(Знач Наименование) Экспорт
	
	Наименование = СокрЛП(Наименование);
	
	СтруктураНаименования = Новый Структура("Наименование, СокращенноеНаименование, ПолноеНаименование",
		Наименование, Наименование, Наименование);
	
	//++ Локализация
	//-- Локализация
	
	Возврат СтруктураНаименования;
	
КонецФункции

// Функция получает валюту, соответствующую номеру банковского счета.
// 6-8 разряды номера банковского счета соответствуют коду валюты.
// Для рублей используется код 810.
//
// Параметры:
//	НомерСчета - Число - Номер банковского счета.
//
// Возвращаемое значение:
//	СправочникСсылка.Валюты - Валюта банковского счета.
//
Функция ПолучитьВалютуПоНомеруСчета(НомерСчета) Экспорт
	
	Валюта = Справочники.Валюты.ПустаяСсылка();
	
	//++ Локализация
	//-- Локализация
	
	Возврат Валюта;
	
КонецФункции

// Установка префикса организации и иб
//
//Параметры:
//    Источник - ДокументОбъект - ПКО, РКО, Кассовая книга
//    СтандартнаяОбработка - Булево - флаг стандартной обработки подписки
//    Префикс - Строка - префикс объекта, который нужно изменить
//
Процедура УстановитьПрефиксИнформационнойБазыИКассовойКнигиНомеруДокументаПриУстановкеНовогоНомера(Источник, СтандартнаяОбработка, Префикс) Экспорт
	
	ПрефиксацияОбъектовСобытия.УстановитьПрефиксИнформационнойБазыИОрганизации(Источник, СтандартнаяОбработка, Префикс);
	
КонецПроцедуры

// Сброс номера документа при необходимости его изменения
//
// Параметры:
//    Источник - ДокументОбъект - ПКО, РКО, Кассовая книга
//    Отказ - Булево - флаг отказа
//    РежимЗаписи - РежимЗаписиДокумента
//    РежимПроведения - РежимПроведенияДокумента
// 
Процедура ПроверитьНомерДокументаПоДатеОрганизацииКассовойКнигеПередЗаписью(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	ПрефиксацияОбъектовСобытия.ПроверитьНомерДокументаПоДатеИОрганизации(Источник, Отказ, РежимЗаписи, РежимПроведения);
	
КонецПроцедуры

//++ Локализация

// Процедура устанавливает видимость выбора операции оплаты таможенного платежа в форме.
//
// Параметры:
//	Поле - ПолеФормы - Поле формы для выбора хозяйственной операции.
//
Процедура УстановитьВидимостьОперацииПеречислениеТаможне(Поле) Экспорт
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьИмпортныеЗакупки") Тогда
		ЭлементСписка = Поле.СписокВыбора.НайтиПоЗначению(Перечисления.ХозяйственныеОперации.ПеречислениеТаможне);
		Если ЭлементСписка <> Неопределено Тогда
			Поле.СписокВыбора.Удалить(ЭлементСписка);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#Область ЗаполнениеДокументов

//++ НЕ УТ

// Процедура заполняет таблицу на основании ведомостей различных типов оплаты в соответствии с отборами.
//
// Параметры:
//	ТаблицаВедомостей - ТаблицаЗначений, ТабличнаяЧасть - Заполняемая таблица
//	СтруктураПараметров - Структура - Структура отборов
//	ТаблицаРаботников - ТаблицаЗначений, ТабличнаяЧасть - Таблица, в которую помещаются работники первой ведомости.
//
Процедура ЗаполнитьПоВедомостямКОплате(ТаблицаВедомостей, СтруктураПараметров, ТаблицаРаботников = Неопределено) Экспорт
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	ИнтеграцияБЗК.ДанныеОбОплатеВедомостей(МенеджерВременныхТаблиц, СтруктураПараметров);
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВТВедомости.Ведомость КАК Ведомость,
	|	МАКСИМУМ(ВТВедомости.Сумма) КАК Сумма,
	|	МАКСИМУМ(ВТВедомости.СуммаПоДокументу) КАК СуммаПоДокументу
	|ИЗ
	|	ДанныеВедомостейНаОплату КАК ВТВедомости
	|
	|СГРУППИРОВАТЬ ПО
	|	ВТВедомости.Ведомость";
	
	Результат = Запрос.Выполнить();
	
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НоваяСтрока = ТаблицаВедомостей.Добавить();
		НоваяСтрока.Ведомость = Выборка.Ведомость;
		НоваяСтрока.СтатьяДвиженияДенежныхСредств =
			Справочники.СтатьиДвиженияДенежныхСредств.СтатьяДвиженияДенежныхСредствПоХозяйственнойОперации(СтруктураПараметров.ХозяйственнаяОперация);
		
		Если СтруктураПараметров.Свойство("ЗаполнятьСуммуПоДокументу") Тогда
			НоваяСтрока.Сумма = Выборка.СуммаПоДокументу;
		Иначе
			НоваяСтрока.Сумма = Выборка.Сумма;
		КонецЕсли;
		
	КонецЦикла;
	
	Если ТаблицаВедомостей.Количество() > 0 И ТаблицаРаботников <> Неопределено Тогда
		СтруктураПараметров.Вставить(ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ТаблицаВедомостей[0].Ведомость));
		СуммыКОплате = ДанныеРаботниковПоВедомостям(СтруктураПараметров);
		
		Если ТипЗнч(СуммыКОплате) = Тип("ТаблицаЗначений") Тогда
			ТаблицаРаботников.Загрузить(СуммыКОплате);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Процедура заполняет таблицу на основании ведомостей на основании заявок на расходование денежных средств.
//
// Параметры:
//	ТаблицаВедомостей - ТаблицаЗначений, ТабличнаяЧасть - Заполняемая таблица
//	СтруктураПараметров - Структура - Структура отборов.
//
Процедура ЗаполнитьПоВедомостямИЗаявкамКОплате(ТаблицаВедомостей, СтруктураПараметров) Экспорт
	
	Запрос = Новый Запрос;
	
	Если СтруктураПараметров.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВыплатаЗарплатыПоЗарплатномуПроекту Тогда
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаявкаВедомости.Ведомость,
		|	ЗаявкаВедомости.СтатьяДвиженияДенежныхСредств,
		|	ЗаявкаВедомости.Ссылка КАК ЗаявкаНаРасходованиеДенежныхСредств,
		|	ЗаявкаВедомости.Сумма
		|ИЗ
		|	Документ.ЗаявкаНаРасходованиеДенежныхСредств.РасшифровкаПлатежа КАК ЗаявкаВедомости
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СписаниеБезналичныхДенежныхСредств.РасшифровкаПлатежа КАК СписаниеВедомости
		|		ПО (ЗаявкаВедомости.Ведомость = СписаниеВедомости.Ведомость
		|		И СписаниеВедомости.Ссылка <> &Списание
		|		И СписаниеВедомости.Ссылка.Проведен)
		|ГДЕ
		|	ЗаявкаВедомости.Ссылка В(&Заявка)
		|	И ЗаявкаВедомости.Ссылка.ХозяйственнаяОперация = &ХозяйственнаяОперация
		|	И СписаниеВедомости.Ведомость ЕСТЬ NULL ";
		
		Запрос.УстановитьПараметр("ХозяйственнаяОперация", Перечисления.ХозяйственныеОперации.ВыплатаЗарплаты);
		Запрос.УстановитьПараметр("Заявка", СтруктураПараметров.Заявка);
		Запрос.УстановитьПараметр("Списание", СтруктураПараметров.Списание);
		
		
	ИначеЕсли СтруктураПараметров.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВыплатаЗарплатыНаЛицевыеСчета Тогда
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОстаткиКВыплате.ЗаявкаНаРасходованиеДенежныхСредств КАК Ведомость,
		|	РасшифровкаПлатежаСписаниеБДС.ЗаявкаНаРасходованиеДенежныхСредств КАК ЗаявкаНаРасходованиеДенежныхСредств,
		|	СУММА(ОстаткиКВыплате.СуммаОстаток) КАК Сумма
		|ИЗ
		|	РегистрНакопления.ДенежныеСредстваКВыплате.Остатки(, ЗаявкаНаРасходованиеДенежныхСредств ССЫЛКА Документ.ВедомостьНаВыплатуЗарплатыПеречислением) КАК ОстаткиКВыплате
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ВедомостьНаВыплатуЗарплатыПеречислением.Зарплата КАК Ведомости
		|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОплатаВедомостейНаВыплатуЗарплаты КАК Оплата
		|			ПО Ведомости.Сотрудник.ФизическоеЛицо = Оплата.ФизическоеЛицо
		|				И Ведомости.Ссылка = Оплата.Ведомость
		|		ПО ОстаткиКВыплате.ЗаявкаНаРасходованиеДенежныхСредств = Ведомости.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СписаниеБезналичныхДенежныхСредств.РасшифровкаПлатежа КАК РасшифровкаПлатежаСписаниеБДС
		|		ПО ОстаткиКВыплате.ЗаявкаНаРасходованиеДенежныхСредств = РасшифровкаПлатежаСписаниеБДС.Ведомость
		|ГДЕ
		|	Оплата.Ведомость ЕСТЬ NULL
		|	И Ведомости.БанковскийСчет = &ЛицевойСчет
		|	И Ведомости.Ссылка.Организация = &Организация
		|
		|СГРУППИРОВАТЬ ПО
		|	РасшифровкаПлатежаСписаниеБДС.ЗаявкаНаРасходованиеДенежныхСредств,
		|	ОстаткиКВыплате.ЗаявкаНаРасходованиеДенежныхСредств
		|
		|ОБЪЕДИНИТЬ ВСЕ
		|
		|ВЫБРАТЬ
		|	ДенежныеСредстваКВыплате.ЗаявкаНаРасходованиеДенежныхСредств,
		|	РасшифровкаПлатежаСписаниеБДС.ЗаявкаНаРасходованиеДенежныхСредств,
		|	СУММА(-ДенежныеСредстваКВыплате.Сумма)
		|ИЗ
		|	РегистрНакопления.ДенежныеСредстваКВыплате КАК ДенежныеСредстваКВыплате
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ВедомостьНаВыплатуЗарплатыПеречислением.Зарплата КАК Ведомости
		|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.СписаниеБезналичныхДенежныхСредств КАК СписаниеБезналичныхДенежныхСредств
		|			ПО Ведомости.Ссылка.Организация = СписаниеБезналичныхДенежныхСредств.Организация
		|				И Ведомости.БанковскийСчет = СписаниеБезналичныхДенежныхСредств.БанковскийСчетКонтрагента
		|		ПО ДенежныеСредстваКВыплате.ЗаявкаНаРасходованиеДенежныхСредств = Ведомости.Ссылка
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СписаниеБезналичныхДенежныхСредств.РасшифровкаПлатежа КАК РасшифровкаПлатежаСписаниеБДС
		|		ПО ДенежныеСредстваКВыплате.ЗаявкаНаРасходованиеДенежныхСредств = РасшифровкаПлатежаСписаниеБДС.Ведомость
		|ГДЕ
		|	ДенежныеСредстваКВыплате.Регистратор = &Списание
		|	И СписаниеБезналичныхДенежныхСредств.Ссылка = &Списание
		|
		|СГРУППИРОВАТЬ ПО
		|	РасшифровкаПлатежаСписаниеБДС.ЗаявкаНаРасходованиеДенежныхСредств,
		|	ДенежныеСредстваКВыплате.ЗаявкаНаРасходованиеДенежныхСредств";
		
		Запрос.УстановитьПараметр("Организация", СтруктураПараметров.Организация);
		Запрос.УстановитьПараметр("ЛицевойСчет", СтруктураПараметров.ЛицевойСчет);
		Запрос.УстановитьПараметр("Списание", СтруктураПараметров.Списание);
		
		
	ИначеЕсли СтруктураПараметров.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВыплатаЗарплатыЧерезКассу
		Или СтруктураПараметров.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВыплатаЗарплатыРаздатчиком Тогда
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ЗаявкаНаРасходованиеДенежныхСредствРасшифровкаПлатежа.Ведомость
		|ПОМЕСТИТЬ ВТ_Ведомости
		|ИЗ
		|	Документ.ЗаявкаНаРасходованиеДенежныхСредств.РасшифровкаПлатежа КАК ЗаявкаНаРасходованиеДенежныхСредствРасшифровкаПлатежа
		|ГДЕ
		|	ЗаявкаНаРасходованиеДенежныхСредствРасшифровкаПлатежа.Ссылка В(&Заявка)
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ЗаявкаВедомости.Ведомость,
		|	ЗаявкаВедомости.СтатьяДвиженияДенежныхСредств,
		|	ЗаявкаВедомости.Ссылка КАК ЗаявкаНаРасходованиеДенежныхСредств,
		|	-КВыплатеОстатки.СуммаОстаток КАК Сумма
		|ИЗ
		|	Документ.ЗаявкаНаРасходованиеДенежныхСредств.РасшифровкаПлатежа КАК ЗаявкаВедомости
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ДенежныеСредстваКВыплате.Остатки(
		|				,
		|				ЗаявкаНаРасходованиеДенежныхСредств В
		|					(ВЫБРАТЬ
		|						ВТ_Ведомости.Ведомость КАК Ведомость
		|					ИЗ
		|						ВТ_Ведомости КАК ВТ_Ведомости)) КАК КВыплатеОстатки
		|		ПО ЗаявкаВедомости.Ведомость = КВыплатеОстатки.ЗаявкаНаРасходованиеДенежныхСредств
		|ГДЕ
		|	ЗаявкаВедомости.Ссылка В(&Заявка)";
		
		Запрос.УстановитьПараметр("Заявка", СтруктураПараметров.Заявка);
		
	КонецЕсли;
	
	Результат = Запрос.Выполнить();
	
	Выборка = Результат.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		НоваяСтрока = ТаблицаВедомостей.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Выборка);
	КонецЦикла;
	
КонецПроцедуры

// Возвращает таблицу значений с данными о работниках и сумме выплаты по ведомости.
// Параметры:
//	СтруктураПараметров - Структура - Структура отборов;
//	МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - для передачи таблицы в другой запрос.
//
// Возвращаемое значение:
//	ТаблицаЗначений - данные о работниках и суммах их начисления по ведомостям.
//
Функция ДанныеРаботниковПоВедомостям(СтруктураПараметров, МенеджерВременныхТаблиц = Неопределено) Экспорт
	
	Если МенеджерВременныхТаблиц = Неопределено Тогда
		
		МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
		ИнтеграцияБЗК.ДанныеОбОплатеВедомостей(МенеджерВременныхТаблиц, СтруктураПараметров);
		
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ДанныеВедомостейНаОплату.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ДанныеВедомостейНаОплату.Ведомость КАК Ведомость,
	|	СУММА(ДанныеВедомостейНаОплату.Сумма) КАК Сумма
	|ИЗ
	|	ДанныеВедомостейНаОплату КАК ДанныеВедомостейНаОплату
	|ГДЕ
	|   ДанныеВедомостейНаОплату.Сумма <> 0
	|
	|СГРУППИРОВАТЬ ПО
	|	ДанныеВедомостейНаОплату.Ведомость,
	|	ДанныеВедомостейНаОплату.ФизическоеЛицо
	|";
	
	ТаблицаРаботников = Запрос.Выполнить().Выгрузить();
	
	Если СтруктураПараметров.Свойство("Работник") Тогда
		
		Если ТаблицаРаботников.Количество() > 0 Тогда
			Возврат ТаблицаРаботников[0].Сумма;
		Иначе
			Возврат 0;
		КонецЕсли;
		
	Иначе
		
		Возврат ТаблицаРаботников;
		
	КонецЕсли;
	
КонецФункции

// Процедура формирует данные для заполнения и расшифровку платежа платежного документа по договору займа сотруднику.
//
// Параметры:
//	Договор - ДокументСсылка.ДоговорЗаймаСотруднику - Договор займа, по которому формируется платежный документ.
//	ДанныеЗаполнения - Структура - Структура основания для заполнения документа.
//	РасшифровкаПлатежа - ТаблицаЗначений, ТабличнаяЧасть - Расшифровка платежа платежного документа.
//	ЭтоПоступление - Булево - Признак, определяющий направление движение денежных средств.
//	ТипДокумента - Строка - Тип формируемого документа. Применяется для поиска образца при заполнении расшифровки платежа.
//
Процедура ЗаполнитьПоДоговоруЗаймаСотруднику(Знач Договор, ДанныеЗаполнения, РасшифровкаПлатежа,
		ЭтоПоступление, ТипДокумента = "ПриходныйКассовыйОрдер") Экспорт
	
	ДанныеЗаполнения = ДанныеЗаполненияДокументаДДСПоДоговоруЗаймаСотруднику(Договор, ЭтоПоступление, ТипДокумента);
	РасшифровкаПлатежа.Загрузить(ДанныеЗаполнения.РасшифровкаПлатежа);
	ДанныеЗаполнения.Вставить("СуммаДокумента", РасшифровкаПлатежа.Итог("Сумма"));
	
	Если РасшифровкаПлатежа.Количество() = 0 Тогда
		НоваяСтрока = РасшифровкаПлатежа.Добавить();
		НоваяСтрока.ДоговорЗаймаСотруднику = Договор;
	КонецЕсли;
	
КонецПроцедуры

// Функция возвращает данные расшифровки платежа платежного документа по договору займа сотруднику.
//
// Параметры:
//	ДанныеЗаполнения - Структура - Структура основания для заполнения документа.
//	ЭтоПоступление - Булево - Признак, определяющий направление движение денежных средств.
//	ДокументИсключение - ДокументСсылка.РасходныйКассовыйОрдер,
//                       ДокументСсылка.СписаниеБезналичныхДенежныхСредств,
//                       ДокументСсылка.ПриходныйКассовыйОрдер,
//                       ДокументСсылка.ПоступлениеБезналичныхДенежныхСредств - Документ, движения которого следует исключить.
//	ТипДокумента - Строка - Тип формируемого документа. Применяется для поиска образца при заполнении расшифровки платежа.
//
// Возвращаемое значение:
//	ТаблицаЗначений - Данные заполнения расшифровки платежа.
Функция ДанныеРасшифровкиПлатежаДокументаДДСПоДоговоруЗаймаСотруднику(ДанныеЗаполнения, ЭтоПоступление = Ложь, 
		ДокументИсключение = Неопределено, ТипДокумента = "ПриходныйКассовыйОрдер") Экспорт
	
	ДатаАктуальности = ?(ДанныеЗаполнения.Свойство("Дата"), ДанныеЗаполнения.Дата, КонецДня(ТекущаяДатаСеанса()));
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ДанныеЗаполнения.Свойство("ДоговорЗаймаСотруднику") Тогда
		ДействующиеДоговора = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(
			ДанныеЗаполнения.ДоговорЗаймаСотруднику);
	Иначе
		ДействующиеДоговора = ЗаймыСотрудникам.ДействующиеДоговорыЗаймаПоФизическомуЛицу(
			ДанныеЗаполнения.Организация,
			ДанныеЗаполнения.ПодотчетноеЛицо,
			ДатаАктуальности,
			НЕ ЭтоПоступление);
	КонецЕсли;
	
	РасшифровкаПлатежа = Новый ТаблицаЗначений;
	РасшифровкаПлатежа.Колонки.Добавить("ЗаявкаНаРасходованиеДенежныхСредств", Новый ОписаниеТипов("ДокументСсылка.ЗаявкаНаРасходованиеДенежныхСредств"));
	РасшифровкаПлатежа.Колонки.Добавить("ДоговорЗаймаСотруднику", Новый ОписаниеТипов("ДокументСсылка.ДоговорЗаймаСотруднику"));
	РасшифровкаПлатежа.Колонки.Добавить("ТипСуммыКредитаДепозита", Новый ОписаниеТипов("ПеречислениеСсылка.ТипыСуммГрафикаКредитовИДепозитов"));
	РасшифровкаПлатежа.Колонки.Добавить("Сумма", Новый ОписаниеТипов("Число"));
	РасшифровкаПлатежа.Колонки.Добавить("ВалютаВзаиморасчетов", Новый ОписаниеТипов("СправочникСсылка.Валюты"));
	РасшифровкаПлатежа.Колонки.Добавить("СтатьяДвиженияДенежныхСредств", Новый ОписаниеТипов("СправочникСсылка.СтатьиДвиженияДенежныхСредств"));
	
	Если ДействующиеДоговора = Неопределено Тогда
		Возврат РасшифровкаПлатежа;
	КонецЕсли;
	
	Если ЭтоПоступление Тогда
		СтатьиДДС = СтатьиДДСЗаймовСотрудникуПоУмолчанию(ДатаАктуальности, ДокументИсключение, ТипДокумента);
		Для Каждого Договор Из ДействующиеДоговора Цикл
			
			Задолженность = ЗаймыСотрудникам.ОстатокЗадолженности(Договор, ДатаАктуальности, ДокументИсключение);
			
			Если Задолженность.СуммаЗайма > 0 Тогда
				НоваяСтрока = РасшифровкаПлатежа.Добавить();
				НоваяСтрока.ДоговорЗаймаСотруднику = Договор;
				НоваяСтрока.ТипСуммыКредитаДепозита = Перечисления.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг;
				НоваяСтрока.Сумма = Задолженность.СуммаЗайма;
				НоваяСтрока.ВалютаВзаиморасчетов = Константы.ВалютаРегламентированногоУчета.Получить();
				НоваяСтрока.СтатьяДвиженияДенежныхСредств = СтатьиДДС.СтатьяДвиженияОсновногоДолга;
			КонецЕсли;
			
			Если Задолженность.Проценты > 0 Тогда
				НоваяСтрока = РасшифровкаПлатежа.Добавить();
				НоваяСтрока.ДоговорЗаймаСотруднику = Договор;
				НоваяСтрока.ТипСуммыКредитаДепозита = Перечисления.ТипыСуммГрафикаКредитовИДепозитов.Проценты;
				НоваяСтрока.Сумма = Задолженность.Проценты;
				НоваяСтрока.ВалютаВзаиморасчетов = Константы.ВалютаРегламентированногоУчета.Получить();
				НоваяСтрока.СтатьяДвиженияДенежныхСредств = СтатьиДДС.СтатьяДвиженияПроцентов;
			КонецЕсли;
			
		КонецЦикла;
	Иначе
		
		ЗаявкиНаРасходованиеДС = Новый Соответствие;
		
		Если ДанныеЗаполнения.Свойство("ОплатаПоЗаявкам") И ДанныеЗаполнения.ОплатаПоЗаявкам Тогда
			
			Запрос = Новый Запрос;
			Запрос.Текст = 
			"ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	ДенежныеСредстваКВыплате.ЗаявкаНаРасходованиеДенежныхСредств,
			|	ДенежныеСредстваКВыплате.ДоговорЗаймаСотруднику
			|ИЗ
			|	РегистрНакопления.ДенежныеСредстваКВыплате КАК ДенежныеСредстваКВыплате
			|ГДЕ
			|	ДенежныеСредстваКВыплате.ДоговорЗаймаСотруднику В (&СписокДоговоров)";
			
			Запрос.УстановитьПараметр("СписокДоговоров", ДействующиеДоговора);
			
			Выборка = Запрос.Выполнить().Выбрать();
			
			Пока Выборка.Следующий() Цикл
				ЗаявкиНаРасходованиеДС.Вставить(Выборка.ДоговорЗаймаСотруднику, Выборка.ЗаявкаНаРасходованиеДенежныхСредств);
			КонецЦикла;
			
		КонецЕсли;
		
		Для Каждого Договор Из ДействующиеДоговора Цикл
			
			Остаток = ЗаймыСотрудникам.ОстатокНевыданныхСумм(Договор, ДатаАктуальности, ДокументИсключение);
			
			Если Остаток > 0 Тогда
				НоваяСтрока = РасшифровкаПлатежа.Добавить();
				НоваяСтрока.ЗаявкаНаРасходованиеДенежныхСредств = ЗаявкиНаРасходованиеДС[Договор];
				НоваяСтрока.ДоговорЗаймаСотруднику = Договор;
				НоваяСтрока.Сумма = Остаток;
				НоваяСтрока.ВалютаВзаиморасчетов = Константы.ВалютаРегламентированногоУчета.Получить();
				НоваяСтрока.СтатьяДвиженияДенежныхСредств = ЗначениеНастроекПовтИсп.ПолучитьСтатьюДвиженияДенежныхСредств(Перечисления.ХозяйственныеОперации.ВыдачаЗаймаСотруднику);
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат РасшифровкаПлатежа;
	
КонецФункции

// Функция возвращает структуру статей ДДС для заполнения платежного документа. Поиск статьи ДДС 
// выполняется по хозяйственной операции и типу документа.
//
// Параметры:
//    ДатаАктуальности - Дата - Дата, на которую требуется получить статьи ДДС.
//    ДокументИсключение - ДокументСсылка.РасходныйКассовыйОрдер,
//                       ДокументСсылка.СписаниеБезналичныхДенежныхСредств,
//                       ДокументСсылка.ПриходныйКассовыйОрдер,
//                       ДокументСсылка.ПоступлениеБезналичныхДенежныхСредств - Документ, движения которого следует исключить.
//    ТипДокумента - Строка - Тип формируемого документа. Применяется для поиска образца при заполнении расшифровки платежа.
//
// Возвращаемое значение:
//    Структура - Структура статей ДДС.
Функция СтатьиДДСЗаймовСотрудникуПоУмолчанию(ДатаАктуальности, ДокументИсключение = Неопределено, ТипДокумента = "ПриходныйКассовыйОрдер") Экспорт
	
	СтатьяДвиженияОсновногоДолга = Справочники.СтатьиДвиженияДенежныхСредств.ПустаяСсылка();
	СтатьяДвиженияПроцентов = Справочники.СтатьиДвиженияДенежныхСредств.ПустаяСсылка();
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ссылка", ДокументИсключение);
	Запрос.УстановитьПараметр("ДатаАктуальности", ДатаАктуальности);
	
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Расшифровка.СтатьяДвиженияДенежныхСредств КАК СтатьяДвижения,
	|	ЕСТЬNULL(Документ.Дата, ДАТАВРЕМЯ(1,1,1)) КАК Дата
	|ИЗ
	|	Документ.%ТипДокумента%.РасшифровкаПлатежа КАК Расшифровка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.%ТипДокумента% КАК Документ
	|		ПО Расшифровка.Ссылка = Документ.Ссылка
	|ГДЕ
	|	Документ.Ссылка <> &Ссылка
	|	И Документ.Проведен
	|	И Документ.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПогашениеЗаймаСотрудником)
	|	И Документ.Дата <= &ДатаАктуальности
	|	И Расшифровка.СтатьяДвиженияДенежныхСредств <> ЗНАЧЕНИЕ(Справочник.СтатьиДвиженияДенежныхСредств.ПустаяСсылка)
	|	И Расшифровка.ТипСуммыКредитаДепозита = ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Дата УБЫВ";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "%ТипДокумента%", ТипДокумента);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		СтатьяДвиженияОсновногоДолга = Выборка.СтатьяДвижения;
	КонецЕсли;
	
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Расшифровка.СтатьяДвиженияДенежныхСредств КАК СтатьяДвижения,
	|	ЕСТЬNULL(Документ.Дата, ДАТАВРЕМЯ(1,1,1)) КАК Дата
	|ИЗ
	|	Документ.%ТипДокумента%.РасшифровкаПлатежа КАК Расшифровка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.%ТипДокумента% КАК Документ
	|		ПО Расшифровка.Ссылка = Документ.Ссылка
	|ГДЕ
	|	Документ.Ссылка <> &Ссылка
	|	И Документ.Проведен
	|	И Документ.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПогашениеЗаймаСотрудником)
	|	И Документ.Дата <= &ДатаАктуальности
	|	И Расшифровка.СтатьяДвиженияДенежныхСредств <> ЗНАЧЕНИЕ(Справочник.СтатьиДвиженияДенежныхСредств.ПустаяСсылка)
	|	И Расшифровка.ТипСуммыКредитаДепозита = ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Дата УБЫВ";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "%ТипДокумента%", ТипДокумента);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		СтатьяДвиженияПроцентов = Выборка.СтатьяДвижения;
	КонецЕсли;
	
	Возврат Новый Структура("СтатьяДвиженияОсновногоДолга, СтатьяДвиженияПроцентов", СтатьяДвиженияОсновногоДолга, СтатьяДвиженияПроцентов);
	
КонецФункции

//-- НЕ УТ


#КонецОбласти



//++ НЕ УТ
#Область ДенежныеДокументы

// Процедура заполняет таблицу остатками денежных документов
//
// Параметры:
//	Отбор - Структура - Параметры отбора остатков ДД
//		* Организация		- СправочникСсылка.Организации 				- Организация, в которой хранятся ДД
//		* Подразделение		- СправочникСсылка.СтруктураПредприятия 	- Подразделение, в котором хранятся ДД
//		* МОЛ 				- СправочникСсылка.ФизическиеЛица 			- МОЛ, у которого хранятся ДД
//		* Ссылка			- ДокументСсылка.ВыбытиеДенежныхДокументов 	- Документ, движения которого должны быть исключены из расчета остатков
//		* ДенежныеДокументы	- Массив 									- отбор по денежным документам
//	Таблица - ТаблицаЗначений - таблица, в которую будет помещен результат получения остатков ДД.
//
Процедура ЗаполнитьПоОстаткамДД(Отбор, Таблица) Экспорт
	
	ПараметрыОтбора = Новый Структура("ДенежныеДокументы, Организация, Подразделение, МОЛ, Ссылка, Валюта");
	ЗаполнитьЗначенияСвойств(ПараметрыОтбора, Отбор);
	
	МассивДД = ?(ПараметрыОтбора.ДенежныеДокументы = Неопределено, Новый Массив, ПараметрыОтбора.ДенежныеДокументы);
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("ОтборПоДД",			МассивДД.Количество() > 0);
	Запрос.УстановитьПараметр("ДенежныеДокументы",	МассивДД);
	Запрос.УстановитьПараметр("Организация",		ПараметрыОтбора.Организация);
	Запрос.УстановитьПараметр("Подразделение",		ПараметрыОтбора.Подразделение);
	Запрос.УстановитьПараметр("МОЛОтправитель",		ПараметрыОтбора.МОЛ);
	Запрос.УстановитьПараметр("Ссылка",				ПараметрыОтбора.Ссылка);
	Запрос.УстановитьПараметр("ОтборПоВалюте",		ПараметрыОтбора.Валюта <> Неопределено);
	Запрос.УстановитьПараметр("Валюта",				ПараметрыОтбора.Валюта);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Остатки.ДенежныйДокумент	КАК ДенежныйДокумент,
	|	СУММА(Остатки.Количество)	КАК Количество,
	|	СУММА(Остатки.Сумма)		КАК Сумма
	|ПОМЕСТИТЬ ВтОстатки
	|ИЗ
	|	(ВЫБРАТЬ
	|		Остатки.ДенежныйДокумент	КАК ДенежныйДокумент,
	|		Остатки.КоличествоОстаток	КАК Количество,
	|		Остатки.СуммаОстаток		КАК Сумма
	|	ИЗ
	|		РегистрНакопления.ДенежныеДокументы.Остатки(
	|				,
	|				МОЛ = &МОЛОтправитель
	|					И Организация = &Организация
	|					И Подразделение = &Подразделение
	|					И (НЕ &ОтборПоВалюте ИЛИ ДенежныйДокумент.Валюта = &Валюта)
	|					И (НЕ &ОтборПоДД ИЛИ ДенежныйДокумент В (&ДенежныеДокументы))) КАК Остатки
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		Движения.ДенежныйДокумент КАК ДенежныйДокумент,
	|		ВЫБОР КОГДА Движения.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|			Движения.Количество
	|		ИНАЧЕ
	|			-Движения.Количество
	|		КОНЕЦ КАК Количество,
	|		ВЫБОР КОГДА Движения.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход) ТОГДА
	|			Движения.Сумма
	|		ИНАЧЕ
	|			-Движения.Сумма
	|		КОНЕЦ КАК Сумма
	|	ИЗ
	|		РегистрНакопления.ДенежныеДокументы КАК Движения
	|	ГДЕ
	|		Движения.Регистратор = &Ссылка
	|		И Движения.МОЛ = &МОЛОтправитель
	|		И Движения.Организация = &Организация
	|		И Движения.Подразделение = &Подразделение
	|		И (НЕ &ОтборПоВалюте ИЛИ Движения.ДенежныйДокумент.Валюта = &Валюта)
	|		И (НЕ &ОтборПоДД ИЛИ Движения.ДенежныйДокумент В (&ДенежныеДокументы))) КАК Остатки
	|	
	|СГРУППИРОВАТЬ ПО
	|	ДенежныйДокумент
	|	
	|ИНДЕКСИРОВАТЬ ПО
	|	ДенежныйДокумент
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Остатки.ДенежныйДокумент	КАК ДенежныйДокумент,
	|	Остатки.Количество			КАК Количество,
	|	Остатки.Сумма				КАК Сумма,
	|	Остатки.Сумма				КАК СуммаВозврата,
	|	СправочникДД.Цена			КАК Цена,
	|	СправочникДД.Цена			КАК ЦенаВозврата,
	|	СправочникДД.Валюта			КАК Валюта,
	|	СправочникДД.Наименование	КАК НаименованиеДенежногоДокумента,
	|	СправочникДД.Родитель		КАК ГруппаДокумента
	|ИЗ
	|	ВтОстатки КАК Остатки
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ДенежныеДокументы КАК СправочникДД
	|		ПО Остатки.ДенежныйДокумент = СправочникДД.Ссылка
	|";
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(Таблица.Добавить(), Выборка);
	КонецЦикла;
	
КонецПроцедуры

// Процедура формирования движений по регистру "Денежные документы".
//
// Параметры:
//	ДополнительныеСвойства - Структура - Дополнительные свойства проведения
//	Движения - КоллекцияДвижений - коллекция наборов записей движений документа
//	Отказ - Булево - Признак отказа от проведения документа.
//
Процедура ОтразитьДвижениеДенежныхДокументов(ДополнительныеСвойства, Движения, Отказ) Экспорт

	ТаблицаДенежныеДокументы = ДополнительныеСвойства.ТаблицыДляДвижений.ТаблицаДенежныеДокументы;
	
	Если Отказ ИЛИ ТаблицаДенежныеДокументы.Количество() = 0 Тогда
	
		Возврат;
		
	КонецЕсли;
	
	ДвиженияДенежныеДокументы = Движения.ДенежныеДокументы;
	ДвиженияДенежныеДокументы.Записывать = Истина;
	ДвиженияДенежныеДокументы.Загрузить(ТаблицаДенежныеДокументы);
	
КонецПроцедуры // ОтразитьДенежныеСредстваУПодотчетныхЛиц()

#КонецОбласти
//-- НЕ УТ

//-- Локализация

#КонецОбласти

//++ Локализация

//++ НЕ УТ

// Функция возвращает данные заполнения платежного документа по договору займа сотруднику.
//
// Параметры:
//	Договор - ДокументСсылка.ДоговорЗаймаСотруднику - Договор займа, по которому формируется платежный документ.
//	ЭтоПоступление - Булево - Признак, определяющий направление движение денежных средств.
//	ТипДокумента - Строка - Тип формируемого документа. Применяется для поиска образца при заполнении расшифровки платежа.
//
// Возвращаемое значение:
//	Структура - Данные заполнения платежного документа.
Функция ДанныеЗаполненияДокументаДДСПоДоговоруЗаймаСотруднику(Договор, ЭтоПоступление = Ложь, ТипДокумента = "ПриходныйКассовыйОрдер")
	
	ДанныеЗаполнения = ДанныеШапкиДокументаДДСПоДоговоруЗаймаСотруднику(Договор, ЭтоПоступление);
	РасшифровкаПлатежа = ДанныеРасшифровкиПлатежаДокументаДДСПоДоговоруЗаймаСотруднику(ДанныеЗаполнения, ЭтоПоступление,, ТипДокумента);
	ДанныеЗаполнения.Вставить("РасшифровкаПлатежа",РасшифровкаПлатежа);
	
	Возврат ДанныеЗаполнения;
	
КонецФункции

// Функция возвращает данные заполнения шапки платежного документа по договору займа сотруднику.
//
// Параметры:
//	Договор - ДокументСсылка.ДоговорЗаймаСотруднику - Договор займа, по которому формируется платежный документ.
//	ЭтоПоступление - Булево - Признак, определяющий направление движение денежных средств.
//
// Возвращаемое значение
//	Структура - Данные заполнения шапки платежного документа.
Функция ДанныеШапкиДокументаДДСПоДоговоруЗаймаСотруднику(Договор, ЭтоПоступление = Ложь)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	&Договор КАК ДоговорЗаймаСотруднику,
	|	&Договор КАК ДокументОснование,
	|	ДоговорЗаймаСотруднику.Организация КАК Организация,
	|	ДоговорЗаймаСотруднику.ФизическоеЛицо КАК ПодотчетноеЛицо,
	|	ДоговорЗаймаСотруднику.ФизическоеЛицо.Наименование КАК Выдать,
	|	ДоговорЗаймаСотруднику.ФизическоеЛицо.Наименование КАК ПринятоОт,
	|	ВЫБОР
	|		КОГДА &ЭтоПоступление
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПогашениеЗаймаСотрудником)
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВыдачаЗаймаСотруднику)
	|	КОНЕЦ КАК ХозяйственнаяОперация,
	|	НЕ ДоговорЗаймаСотруднику.Проведен КАК ЕстьОшибкиПроведен,
	|	&Валюта КАК Валюта,
	|	Неопределено КАК Касса,
	|	Неопределено КАК БанковскийСчет,
	|	Неопределено КАК БанковскийСчетКонтрагента
	|ИЗ
	|	Документ.ДоговорЗаймаСотруднику КАК ДоговорЗаймаСотруднику
	|ГДЕ
	|	ДоговорЗаймаСотруднику.Ссылка = &Договор";
	
	Запрос.УстановитьПараметр("Договор",        Договор);
	Запрос.УстановитьПараметр("ЭтоПоступление", ЭтоПоступление);
	Запрос.УстановитьПараметр("Валюта",         Константы.ВалютаРегламентированногоУчета.Получить());
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	Если Выборка.ЕстьОшибкиПроведен Тогда
		Текст = НСтр("ru='Договор займа сотруднику не проведен. Ввод на основании непроведенного документа запрещен';uk='Договір позики співробітнику не проведено. Введення на підставі непроведенного документа заборонене'");
		ВызватьИсключение Текст;
	КонецЕсли;
	
	ДанныеШапки = Новый Структура;
	Для Каждого Колонка Из РезультатЗапроса.Колонки Цикл
		ДанныеШапки.Вставить(Колонка.Имя);
	КонецЦикла;
	
	ЗаполнитьЗначенияСвойств(ДанныеШапки, Выборка);
	
	ДанныеШапки.Касса = Справочники.Кассы.ПолучитьКассуПоУмолчанию(ДанныеШапки.Организация, ДанныеШапки.Валюта);
	ДанныеШапки.БанковскийСчет = Справочники.БанковскиеСчетаОрганизаций.ПолучитьБанковскийСчетОрганизацииПоУмолчанию(ДанныеШапки.Организация, ДанныеШапки.Валюта);
	ДанныеШапки.БанковскийСчетКонтрагента = Справочники.БанковскиеСчетаКонтрагентов.ПолучитьБанковскийСчетПоУмолчанию(
			Выборка.ПодотчетноеЛицо,
			Выборка.Валюта);
	
	Возврат ДанныеШапки;
	
КонецФункции

//-- НЕ УТ

//-- Локализация