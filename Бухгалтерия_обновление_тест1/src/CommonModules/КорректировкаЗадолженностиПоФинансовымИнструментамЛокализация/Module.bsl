
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
	//++ НЕ УТ
	МеханизмыДокумента.Добавить("РегламентированныйУчет");
	//-- НЕ УТ
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
Процедура ОбработкаЗаполнения(Объект, ДанныеЗаполнения, СтандартнаяОбработка) Экспорт
	
	
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

// Заполняет список команд печати.
//
// Параметры:
//   КомандыПечати - см. УправлениеПечатью.СоздатьКоллекциюКомандПечати
//
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
	
	//++ Локализация
	Возврат ТекстОтраженияВРеглУчетеУКР(); 
	//-- Локализация
	Возврат "";
	
КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц,
// необходимых для отражения в регламентированном учете
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчете() Экспорт
	
	//++ Локализация
	Возврат ТекстЗапросаВТОтраженияВРеглУчетеУКР();
	//-- Локализация
	Возврат "";
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

//++ НЕ УТ
#Область ПроводкиРегУчетаУКР

// Функция возвращает текст запроса для отражения документа в регламентированном учете.
//
// Возвращаемое значение:
//	Строка - Текст запроса
//
Функция ТекстОтраженияВРеглУчетеУКР() Экспорт
	
	//++ Локализация
	
	ЯзыкСодержания = МультиязычностьУкр.КодЯзыкаИнформационнойБазы();
	

#Область ТекстДебиторскаяЗадолженность
	ТекстДебиторскаяЗадолженность = "
	|ВЫБРАТЬ //// Списание задолженности на расходы (Дт счет расходов :: Кт <>)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	Расчеты.СуммаРегл КАК Сумма,
	|	Расчеты.СуммаУпр КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаДт,
	|	Операция.СтатьяРасходов КАК АналитикаУчетаДт,
	|	Операция.Подразделение КАК МестоУчетаДт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|
	|	Операция.СтатьяРасходов КАК СубконтоДт1,
	|	Операция.АналитикаРасходов КАК СубконтоДт2,
	|	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	Расчеты.СуммаРегл КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ВЫБОР Операция.ХарактерДоговора
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.КредитИлиЗайм) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.Депозит) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.ЗаймВыданный) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.Лизинг) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ЛизинговыйПлатеж) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ЛизинговыеУслуги)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ОбеспечительныйПлатеж) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ОбеспечительныйПлатежПоЛизингу)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ВыкупПредметаЛизинга) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ВыкупПредметаЛизинга)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.АрендныеОбязательства) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.АрендныеОбязательстваПоЛизингу)
	|			КОНЕЦ
	|	КОНЕЦ КАК ВидСчетаКт,
	|	ЕСТЬNULL(Расчеты.Договор.ГруппаФинансовогоУчета, ЗНАЧЕНИЕ(Справочник.ГруппыФинансовогоУчетаРасчетов.ПустаяСсылка)) КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Расчеты.ВалютаВзаиморасчетов КАК ВалютаКт,
	|	ЕСТЬNULL(Расчеты.Договор.Подразделение, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)) КАК ПодразделениеКт,
	|	ЕСТЬNULL(Расчеты.Договор.НаправлениеДеятельности, ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка)) КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|
	|	Операция.Контрагент КАК СубконтоКт1,
	|	Операция.Договор КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	Расчеты.Сумма КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.КорректировкаЗадолженностиПоФинансовымИнструментам КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиНаВнеоборотныеАктивы
	|	ПО
	|		Операция.СтатьяРасходов = СтатьиНаВнеоборотныеАктивы.Ссылка
	|		И СтатьиНаВнеоборотныеАктивы.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РасчетыПоФинансовымИнструментамКредит КАК Расчеты
	|	ПО
	|		Операция.Ссылка = Расчеты.Ссылка
	|	
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		Справочник.ОбъектыСтроительства КАК ОбъектыСтроительства
	|	ПО
	|		ОбъектыСтроительства.Ссылка = Операция.АналитикаРасходов
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СписаниеДебиторскойЗадолженности)
	|	И Операция.СтатьяРасходов ССЫЛКА ПланВидовХарактеристик.СтатьиРасходов
	|";

	ТекстДебиторскаяЗадолженность = СтрШаблон(ТекстДебиторскаяЗадолженность, 
		НСтр("ru='Списание задолженности';uk='Списання заборгованості'",ЯзыкСодержания));
 
#КонецОбласти

#Область ТекстДебиторскаяЗадолженностьНаСтатьиАктивовПассивов
	// Поддержка статей расходов с устаревшим направлением распределения "НаПрочиеАктивы".
	ТекстДебиторскаяЗадолженностьНаСтатьиАктивовПассивов = "
	|ВЫБРАТЬ //// Списание задолженности на прочие активы (Дт <Прочие счета> :: Кт <>)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	"""" КАК ИдентификаторСтроки,
	|
	|	Расчеты.СуммаРегл КАК Сумма,
	|	Расчеты.СуммаУпр КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеАктивыПассивы) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	Операция.СчетУчета КАК СчетДт,
	|
	|	Операция.Субконто1 КАК СубконтоДт1,
	|	Операция.Субконто2 КАК СубконтоДт2,
	|	Операция.Субконто3 КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	Расчеты.СуммаРегл КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ВЫБОР Операция.ХарактерДоговора
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.КредитИлиЗайм) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.Депозит) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.ЗаймВыданный) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.Лизинг) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ЛизинговыйПлатеж) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ЛизинговыеУслуги)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ОбеспечительныйПлатеж) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ОбеспечительныйПлатежПоЛизингу)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ВыкупПредметаЛизинга) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ВыкупПредметаЛизинга)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.АрендныеОбязательства) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.АрендныеОбязательстваПоЛизингу)
	|			КОНЕЦ
	|	КОНЕЦ КАК ВидСчетаКт,
	|	ЕСТЬNULL(Расчеты.Договор.ГруппаФинансовогоУчета, ЗНАЧЕНИЕ(Справочник.ГруппыФинансовогоУчетаРасчетов.ПустаяСсылка)) КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Расчеты.ВалютаВзаиморасчетов КАК ВалютаКт,
	|	ЕСТЬNULL(Расчеты.Договор.Подразделение, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)) КАК ПодразделениеКт,
	|	ЕСТЬNULL(Расчеты.Договор.НаправлениеДеятельности, ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка)) КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетКт,
	|
	|	Операция.Контрагент КАК СубконтоКт1,
	|	Операция.Договор КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|	
	|	Расчеты.Сумма КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|
	|ИЗ 
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.КорректировкаЗадолженностиПоФинансовымИнструментам КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РасчетыПоФинансовымИнструментамКредит КАК Расчеты
	|	ПО
	|		Операция.Ссылка = Расчеты.Ссылка
	|	
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СписаниеДебиторскойЗадолженности)
	|	И Операция.СтатьяРасходов ССЫЛКА ПланВидовХарактеристик.СтатьиАктивовПассивов
	|";

	ТекстДебиторскаяЗадолженностьНаСтатьиАктивовПассивов = СтрШаблон(ТекстДебиторскаяЗадолженностьНаСтатьиАктивовПассивов, 
		НСтр("ru='Списание задолженности на активы/пассивы';uk='Списання заборгованості на активи/пасиви'",ЯзыкСодержания));
 	
#КонецОбласти

#Область ТекстКредиторскаяЗадолженность
	ТекстКредиторскаяЗадолженность = "
	|ВЫБРАТЬ //// Списание задолженности в доходы (Дт <> :: Кт <Счет доходов>)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	Расчеты.СуммаРегл КАК Сумма,
	|	Расчеты.СуммаУпр КАК СуммаУУ,
	|
	|	ВЫБОР Операция.ХарактерДоговора
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.КредитИлиЗайм) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.Депозит) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.ЗаймВыданный) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.Лизинг) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ЛизинговыйПлатеж) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ЛизинговыеУслуги)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ОбеспечительныйПлатеж) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ОбеспечительныйПлатежПоЛизингу)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ВыкупПредметаЛизинга) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ВыкупПредметаЛизинга)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.АрендныеОбязательства) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.АрендныеОбязательстваПоЛизингу)
	|			КОНЕЦ
	|	КОНЕЦ КАК ВидСчетаДт,
	|	ЕСТЬNULL(Расчеты.Договор.ГруппаФинансовогоУчета, ЗНАЧЕНИЕ(Справочник.ГруппыФинансовогоУчетаРасчетов.ПустаяСсылка)) КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Расчеты.ВалютаВзаиморасчетов КАК ВалютаДт,
	|	ЕСТЬNULL(Расчеты.Договор.Подразделение, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)) КАК ПодразделениеДт,
	|	ЕСТЬNULL(Расчеты.Договор.НаправлениеДеятельности, ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка)) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|
	|	Операция.Контрагент КАК СубконтоДт1,
	|	Операция.Договор КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	Расчеты.Сумма КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Доходы) КАК ВидСчетаКт,
	|	Операция.СтатьяДоходов КАК АналитикаУчетаКт,
	|	Операция.Подразделение КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Операция.Подразделение КАК ПодразделениеКт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|
	|	Операция.СтатьяДоходов КАК СубконтоКт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.КорректировкаЗадолженностиПоФинансовымИнструментам КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РасчетыПоФинансовымИнструментамДебет КАК Расчеты
	|	ПО
	|		Операция.Ссылка = Расчеты.Ссылка
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СписаниеКредиторскойЗадолженности)
	|	И Операция.СтатьяДоходов ССЫЛКА ПланВидовХарактеристик.СтатьиДоходов
	|";

	ТекстКредиторскаяЗадолженность = СтрШаблон(ТекстКредиторскаяЗадолженность, 
		НСтр("ru='Списание задолженности';uk='Списання заборгованості'",ЯзыкСодержания));
 	
#КонецОбласти

#Область ТекстКредиторскаяЗадолженностьНаСтатьиАктивовПассивов
	ТекстКредиторскаяЗадолженностьНаСтатьиАктивовПассивов = "
	|ВЫБРАТЬ //// Списание задолженности в прочие активы пассивы (Дт <> :: )
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	"""" КАК ИдентификаторСтроки,
	|
	|	Расчеты.СуммаРегл КАК Сумма,
	|	Расчеты.СуммаУпр КАК СуммаУУ,
	|
	|	ВЫБОР Операция.ХарактерДоговора
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.КредитИлиЗайм) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСКредиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.Депозит) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.ЗаймВыданный) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.ОсновнойДолг) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиОсновнойДолг)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Проценты) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиПроценты)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыСуммГрафикаКредитовИДепозитов.Комиссия) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСДебиторамиКомиссия)
	|			КОНЕЦ
	|		КОГДА ЗНАЧЕНИЕ(Перечисление.ХарактерыДоговоровФинансовыхИнструментов.Лизинг) ТОГДА
	|			ВЫБОР Расчеты.ТипСуммы
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ЛизинговыйПлатеж) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ЛизинговыеУслуги)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ОбеспечительныйПлатеж) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ОбеспечительныйПлатежПоЛизингу)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.ВыкупПредметаЛизинга) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ВыкупПредметаЛизинга)
	|				КОГДА ЗНАЧЕНИЕ(Перечисление.ТипыПлатежейПоЛизингу.АрендныеОбязательства) ТОГДА
	|					ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.АрендныеОбязательстваПоЛизингу)
	|			КОНЕЦ
	|	КОНЕЦ КАК ВидСчетаДт,
	|	ЕСТЬNULL(Расчеты.Договор.ГруппаФинансовогоУчета, ЗНАЧЕНИЕ(Справочник.ГруппыФинансовогоУчетаРасчетов.ПустаяСсылка)) КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	Расчеты.ВалютаВзаиморасчетов КАК ВалютаДт,
	|	ЕСТЬNULL(Расчеты.Договор.Подразделение, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)) КАК ПодразделениеДт,
	|	ЕСТЬNULL(Расчеты.Договор.НаправлениеДеятельности, ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка)) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|
	|	Операция.Контрагент КАК СубконтоДт1,
	|	Операция.Договор КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|	
	|	Расчеты.Сумма КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеАктивыПассивы) КАК ВидСчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|	
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Операция.Подразделение КАК ПодразделениеКт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,
	|
	|	Операция.СчетУчета КАК СчетКт,
	|
	|	Операция.Субконто1 КАК СубконтоКт1,
	|	Операция.Субконто2 КАК СубконтоКт2,
	|	Операция.Субконто3 КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	0 КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|
	|ИЗ 
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.КорректировкаЗадолженностиПоФинансовымИнструментам КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		РасчетыПоФинансовымИнструментамДебет КАК Расчеты
	|	ПО
	|		Операция.Ссылка = Расчеты.Ссылка
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СписаниеКредиторскойЗадолженности)
	|	И Операция.СтатьяДоходов ССЫЛКА ПланВидовХарактеристик.СтатьиАктивовПассивов
	|";

	ТекстКредиторскаяЗадолженностьНаСтатьиАктивовПассивов = СтрШаблон(ТекстКредиторскаяЗадолженностьНаСтатьиАктивовПассивов, 
		НСтр("ru='Списание задолженности на активы/пассивы';uk='Списання заборгованості на активи/пасиви'",ЯзыкСодержания));
 	
#КонецОбласти


	ТекстыОтражения = Новый Массив;
	ТекстыОтражения.Добавить(ТекстДебиторскаяЗадолженность);
	ТекстыОтражения.Добавить(ТекстДебиторскаяЗадолженностьНаСтатьиАктивовПассивов);
	ТекстыОтражения.Добавить(ТекстКредиторскаяЗадолженность);
	ТекстыОтражения.Добавить(ТекстКредиторскаяЗадолженностьНаСтатьиАктивовПассивов);
	
	Возврат СтрСоединить(ТекстыОтражения, ОбщегоНазначенияУТ.РазделительЗапросовВОбъединении());
	
	//-- Локализация
	Возврат "";
	
КонецФункции

// Функция возвращает текст запроса дополнительных временных таблиц,
// необходимых для отражения в регламентированном учете
//
// Возвращаемое значение:
//   Строка - сформированный текст запроса.
//
Функция ТекстЗапросаВТОтраженияВРеглУчетеУКР() Экспорт
	
	//++ Локализация

	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	Расчеты.Регистратор КАК Ссылка,
	|	Расчеты.Договор КАК Договор,
	|	Расчеты.ТипСуммы КАК ТипСуммы,
	|	Расчеты.Валюта КАК ВалютаВзаиморасчетов,
	|	МАКСИМУМ(Аналитика.НаправлениеДеятельности) КАК НаправлениеДеятельности,
	|	СУММА(ВЫБОР
	|			КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|				ТОГДА Расчеты.Сумма
	|		КОНЕЦ) КАК Сумма,
	|	СУММА(ВЫБОР
	|			КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|				ТОГДА Расчеты.СуммаУпр
	|		КОНЕЦ) КАК СуммаУпр,
	|	СУММА(ВЫБОР
	|			КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Расход)
	|				ТОГДА Расчеты.СуммаРегл
	|		КОНЕЦ) КАК СуммаРегл
	|ПОМЕСТИТЬ РасчетыПоФинансовымИнструментамКредит
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.РасчетыПоФинансовымИнструментам КАК Расчеты
	|		ПО ДокументыКОтражению.Ссылка = Расчеты.Регистратор
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК Аналитика
	|		ПО Расчеты.АналитикаУчетаПоПартнерам = Аналитика.КлючАналитики
	|
	|СГРУППИРОВАТЬ ПО
	|	Расчеты.Регистратор,
	|	Расчеты.Договор,
	|	Расчеты.ТипСуммы,
	|	Расчеты.Валюта
	|
	|ИМЕЮЩИЕ
	|	СУММА(Расчеты.СуммаРегл) <> 0
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Расчеты.Регистратор КАК Ссылка,
	|	Расчеты.Договор КАК Договор,
	|	Расчеты.ТипСуммы КАК ТипСуммы,
	|	Расчеты.Валюта КАК ВалютаВзаиморасчетов,
	|	МАКСИМУМ(Аналитика.НаправлениеДеятельности) КАК НаправлениеДеятельности,
	|	СУММА(ВЫБОР
	|			КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|				ТОГДА Расчеты.Сумма
	|		КОНЕЦ) КАК Сумма,
	|	СУММА(ВЫБОР
	|			КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|				ТОГДА Расчеты.СуммаУпр
	|		КОНЕЦ) КАК СуммаУпр,
	|	СУММА(ВЫБОР
	|			КОГДА Расчеты.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|				ТОГДА Расчеты.СуммаРегл
	|		КОНЕЦ) КАК СуммаРегл
	|ПОМЕСТИТЬ РасчетыПоФинансовымИнструментамДебет
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.РасчетыПоФинансовымИнструментам КАК Расчеты
	|		ПО ДокументыКОтражению.Ссылка = Расчеты.Регистратор
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.АналитикаУчетаПоПартнерам КАК Аналитика
	|		ПО Расчеты.АналитикаУчетаПоПартнерам = Аналитика.КлючАналитики
	|
	|СГРУППИРОВАТЬ ПО
	|	Расчеты.Регистратор,
	|	Расчеты.Договор,
	|	Расчеты.ТипСуммы,
	|	Расчеты.Валюта
	|
	|ИМЕЮЩИЕ
	|	СУММА(Расчеты.СуммаРегл) <> 0
	|";


	Возврат ТекстЗапроса + ОбщегоНазначенияУТ.РазделительЗапросовВПакете();

	//-- Локализация
	Возврат "";
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

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
	//++ НЕ УТ
	ТекстЗапросаТаблицаПорядокОтраженияПрочихОпераций(Запрос, ТекстыЗапроса, Регистры);
	ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры);
	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры

//++ Локализация
//++ НЕ УТ

Функция ТекстЗапросаТаблицаПорядокОтраженияПрочихОпераций(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ПорядокОтраженияПрочихОпераций";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	&Ссылка              КАК Документ,
	|	""""                 КАК ИдентификаторСтроки,
	|	&Период              КАК Дата,
	|	&Организация         КАК Организация,
	|	""""                 КАК СчетУчета,
	|	""""                 КАК Субконто1,
	|	""""                 КАК Субконто2,
	|	""""                 КАК Субконто3
	|ГДЕ
	|	&ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СписаниеДебиторскойЗадолженности)
	|	И &ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПрочиеАктивы)
	|	И &ВидЦенностиРасходов = ЗНАЧЕНИЕ(Перечисление.ВидыЦенностей.ПрочиеРаботыИУслуги)";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции


Функция ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ОтражениеДокументовВРеглУчете";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли; 
	
	Если Не ПроведениеДокументов.ЕстьТаблицаЗапроса("ВтПрочиеРасходы", ТекстыЗапроса) Тогда
		Документы.КорректировкаЗадолженностиПоФинансовымИнструментам.ТекстЗапросаТаблицаВтПрочиеРасходы(Запрос, ТекстыЗапроса);
	КонецЕсли;
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	&Период                      КАК Период,
	|	&Организация                 КАК Организация,
	|	НАЧАЛОПЕРИОДА(&Период, ДЕНЬ) КАК ДатаОтражения
	|";
	ТекстЗапроса = ТекстЗапроса + "ОБЪЕДИНИТЬ ВСЕ"
		+ ДоходыИРасходыСервер.ДополнитьТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Ложь);
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	
КонецФункции
//-- НЕ УТ
//-- Локализация

#КонецОбласти

#КонецОбласти
