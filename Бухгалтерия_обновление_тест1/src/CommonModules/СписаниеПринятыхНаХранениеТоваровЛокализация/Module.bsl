
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

//++ Локализация
//-- Локализация
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

	ТекстыОтражения = Новый Массив;

#Область СписаниеТоваровПринятыхНаОтветХранение              // (Дт  :: Кт 023)
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Списание товаров, принятых на ответственное хранение (Дт  :: Кт 023)
	|
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Стоимости.Сумма, Строки.Сумма) КАК Сумма,
	|	ЕСТЬNULL(Стоимости.СуммаУУ, Строки.СуммаУУ) КАК СуммаУУ,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВалютаДт,
	|	НЕОПРЕДЕЛЕНО КАК ПодразделениеДт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетДт,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	0 КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ВЫБОР КОГДА Строки.РазделУчета = ЗНАЧЕНИЕ(Перечисление.РазделыУчетаСебестоимостиТоваров.ТоварыНаХраненииСПравомПродажиКОформлениюСписания)
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ТМЦКСписанию)
	|		КОГДА Строки.Склад.ЦеховаяКладовая
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ТМЦвпроизводстве)
	|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ТМЦнаскладах)
	|	КОНЕЦ КАК ВидСчетаКт,
	|	Строки.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	Строки.Склад КАК МестоУчетаКт,
	|
	|	НЕОПРЕДЕЛЕНО КАК ВалютаКт,
	|	Строки.Склад.Подразделение КАК ПодразделениеКт,
	|	ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка) КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,	
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|	Строки.Номенклатура КАК СубконтоКт1,
	|	Операция.Контрагент КАК СубконтоКт2,
	|	Строки.Склад КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	Строки.Количество КАК КоличествоКт,
	|	0 КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|
	|ИЗ 
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеПринятыхНаХранениеТоваров КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ВтСтроки КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВтСтоимости КАК Стоимости
	|	ПО
	|		Строки.Ссылка = Стоимости.Ссылка
	|		И Строки.Номенклатура = Стоимости.Номенклатура
	|		И Строки.Склад = Стоимости.Склад
	|		И Строки.ГруппаФинансовогоУчета = Стоимости.ГруппаФинансовогоУчета
	|		И Строки.НаправлениеДеятельности = Стоимости.НаправлениеДеятельности
	|		И Строки.РазделУчета = Стоимости.РазделУчета
	|";

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Списание товаров, принятых на ответственное хранение';uk='Списання товарів, які було прийнято на відповідальне зберігання'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);

#КонецОбласти
	
#Область ВозмещениеУбытковПоклажедателяНаРасходы // (Дт 23, 9X :: Кт 63)
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Возмещение убытков поклажедателя на расходы (Дт 23, 9X :: Кт 63)
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	НЕОПРЕДЕЛЕНО КАК ИдентификаторСтроки,
	|	
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК Сумма,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСУпр + Суммы.СуммаНДСУпр, Строки.Сумма / КурсВалютыУпрУчета.Курс) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.Расходы) КАК ВидСчетаДт,
	|	Операция.СтатьяРасходов КАК АналитикаУчетаДт,
	|	Операция.Подразделение КАК МестоУчетаДт,
	|	
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	Операция.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
    |	ЗНАЧЕНИЕ(Перечисление.ТипыЗатратРегл.Прочее) КАК СубконтоДт1,
	|	Операция.СтатьяРасходов КАК СубконтоДт2,
	|	ВЫБОР КОГДА СтатьиСтроительства.Ссылка ЕСТЬ НЕ NULL
	|		ТОГДА Операция.АналитикаРасходов
	|		ИНАЧЕ Строки.АналитикаУчетаНоменклатуры.Номенклатура
	|	КОНЕЦ КАК СубконтоДт3,
	|	
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|	
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСПоставщиками) КАК ВидСчетаКт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Расчеты.Валюта КАК ВалютаКт,
	|	Расчеты.Подразделение КАК ПодразделениеКт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,	
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|
	|	Расчеты.Контрагент КАК СубконтоКт1,
	|	Расчеты.Договор КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	Строки.Количество КАК КоличествоКт,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеПринятыхНаХранениеТоваров КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеПринятыхНаХранениеТоваров.ВидыЗапасов КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрСведений.СуммыДокументовВВалютахУчета КАК Суммы
	|	ПО
	|		Строки.Ссылка = Суммы.Регистратор
	|		И Строки.ИдентификаторСтроки = Суммы.ИдентификаторСтроки
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВТРасчетыСПоставщиками КАК Расчеты
	|	ПО 
	|		Операция.Ссылка = Расчеты.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		КурсыВалют КАК КурсВалютыУпрУчета
	|	ПО
	|		КурсВалютыУпрУчета.Валюта = &ВалютаУпрУчета
	|		И КурсВалютыУпрУчета.Дата = НАЧАЛОПЕРИОДА(Операция.Дата, День)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиСтроительства
	|	ПО
	|		Операция.СтатьяРасходов = СтатьиСтроительства.Ссылка
	|		И СтатьиСтроительства.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиНаПрочиеАктивы
	|	ПО
	|		Операция.СтатьяРасходов = СтатьиНаПрочиеАктивы.Ссылка
	|		И СтатьиНаПрочиеАктивы.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПрочиеАктивы)
	|	
	|	ЛЕВОЕ СОЕДИНЕНИЕ 
	|		Справочник.ОбъектыСтроительства КАК ОбъектыСтроительства
	|	ПО 
	|		ОбъектыСтроительства.Ссылка = Операция.АналитикаРасходов
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СписаниеПринятыхТоваровНаРасходы)
	|	И Операция.СтатьяРасходов ССЫЛКА ПланВидовХарактеристик.СтатьиРасходов
	|	И СтатьиНаПрочиеАктивы.Ссылка ЕСТЬ NULL
	|";    

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Возмещение убытков поклажедателя на расходы';uk='Відшкодування збитків поклажедавача на витрати'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти
	
#Область ВозмещениеУбытковПоклажедателяНаПрочиеАктивы // (Дт ХХ :: Кт 63)
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Возмещение убытков поклажедателя на прочие активы (Дт ХХ :: Кт 63)
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	"""" КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК Сумма,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСУпр + Суммы.СуммаНДСУпр, Строки.Сумма / КурсВалютыУпрУчета.Курс) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеОперации) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	Операция.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	ЗНАЧЕНИЕ(ПланСчетов.Хозрасчетный.ПустаяСсылка) КАК СчетДт,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт1,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСПоставщиками) КАК ВидСчетаКт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Расчеты.Валюта КАК ВалютаКт,
	|	Расчеты.Подразделение КАК ПодразделениеКт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,	
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|
	|	Расчеты.Контрагент КАК СубконтоКт1,
	|	Расчеты.Договор КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	Строки.Количество КАК КоличествоКт,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|	
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеПринятыхНаХранениеТоваров КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеПринятыхНаХранениеТоваров.ВидыЗапасов КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиНаПрочиеАктивы
	|	ПО
	|		Операция.СтатьяРасходов = СтатьиНаПрочиеАктивы.Ссылка
	|		И СтатьиНаПрочиеАктивы.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаПрочиеАктивы)
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрСведений.СуммыДокументовВВалютахУчета КАК Суммы
	|	ПО
	|		Строки.Ссылка = Суммы.Регистратор
	|		И Строки.ИдентификаторСтроки = Суммы.ИдентификаторСтроки
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВТРасчетыСПоставщиками КАК Расчеты
	|	ПО 
	|		Операция.Ссылка = Расчеты.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		КурсыВалют КАК КурсВалютыУпрУчета
	|	ПО
	|		КурсВалютыУпрУчета.Валюта = &ВалютаУпрУчета
	|		И КурсВалютыУпрУчета.Дата = НАЧАЛОПЕРИОДА(Операция.Дата, День)
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СписаниеПринятыхТоваровНаРасходы)
	|"; 

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Возмещение убытков поклажедателя на прочие активы';uk='Відшкодування збитків поклажедавача на інші активи'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти
	
#Область ВозмещениеУбытковПоклажедателяНаСтатьиАктивовПассивов // (Дт ХХ :: Кт 63)
	ТекстЗапроса = "
	|ВЫБРАТЬ //// Возмещение убытков поклажедателя на прочие активы (Дт ХХ :: Кт 63)
	|	Операция.Ссылка КАК Ссылка,
	|	Операция.Дата КАК Период,
	|	Операция.Организация КАК Организация,
	|	Строки.ИдентификаторСтроки КАК ИдентификаторСтроки,
	|
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК Сумма,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСУпр + Суммы.СуммаНДСУпр, Строки.Сумма / КурсВалютыУпрУчета.Курс) КАК СуммаУУ,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.ПрочиеАктивыПассивы) КАК ВидСчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК АналитикаУчетаДт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаДт,
	|
	|	ЗНАЧЕНИЕ(Справочник.Валюты.ПустаяСсылка) КАК ВалютаДт,
	|	Операция.Подразделение КАК ПодразделениеДт,
	|	Операция.НаправлениеДеятельности КАК НаправлениеДеятельностиДт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеДт,	
	|
	|	Операция.СчетУчета КАК СчетДт,
	|	Операция.Субконто1 КАК СубконтоДт1,
	|	Операция.Субконто2 КАК СубконтоДт2,
	|	Операция.Субконто3 КАК СубконтоДт3,
	|
	|	0 КАК ВалютнаяСуммаДт,
	|	0 КАК КоличествоДт,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК СуммаНУДт,
	|	0 КАК СуммаПРДт,
	|	0 КАК СуммаВРДт,
	|
	|	ЗНАЧЕНИЕ(Перечисление.ВидыСчетовРеглУчета.РасчетыСПоставщиками) КАК ВидСчетаКт,
	|	Расчеты.ГруппаФинансовогоУчета КАК АналитикаУчетаКт,
	|	НЕОПРЕДЕЛЕНО КАК МестоУчетаКт,
	|
	|	Расчеты.Валюта КАК ВалютаКт,
	|	Расчеты.Подразделение КАК ПодразделениеКт,
	|	Расчеты.НаправлениеДеятельности КАК НаправлениеДеятельностиКт,
	|	НЕОПРЕДЕЛЕНО КАК НалоговоеНазначениеКт,	
	|
	|	НЕОПРЕДЕЛЕНО КАК СчетКт,
	|
	|	Расчеты.Контрагент КАК СубконтоКт1,
	|	Расчеты.Договор КАК СубконтоКт2,
	|	НЕОПРЕДЕЛЕНО КАК СубконтоКт3,
	|
	|	0 КАК ВалютнаяСуммаКт,
	|	Строки.Количество КАК КоличествоКт,
	|	ЕСТЬNULL(Суммы.СуммаБезНДСРегл + Суммы.СуммаНДСРегл, Строки.Сумма) КАК СуммаНУКт,
	|	0 КАК СуммаПРКт,
	|	0 КАК СуммаВРКт,
	|	""%1"" КАК Содержание
	|	
	|ИЗ
	|	ДокументыКОтражению КАК ДокументыКОтражению
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеПринятыхНаХранениеТоваров КАК Операция
	|	ПО
	|		ДокументыКОтражению.Ссылка = Операция.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ
	|		Документ.СписаниеПринятыхНаХранениеТоваров.ВидыЗапасов КАК Строки
	|	ПО
	|		Операция.Ссылка = Строки.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		РегистрСведений.СуммыДокументовВВалютахУчета КАК Суммы
	|	ПО
	|		Строки.Ссылка = Суммы.Регистратор
	|		И Строки.ИдентификаторСтроки = Суммы.ИдентификаторСтроки
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		ВТРасчетыСПоставщиками КАК Расчеты
	|	ПО 
	|		Операция.Ссылка = Расчеты.Ссылка
	|
	|	ЛЕВОЕ СОЕДИНЕНИЕ
	|		КурсыВалют КАК КурсВалютыУпрУчета
	|	ПО
	|		КурсВалютыУпрУчета.Валюта = &ВалютаУпрУчета
	|		И КурсВалютыУпрУчета.Дата = НАЧАЛОПЕРИОДА(Операция.Дата, День)
	|
	|ГДЕ
	|	Операция.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СписаниеПринятыхТоваровНаРасходы)
	|	И Операция.СтатьяРасходов ССЫЛКА ПланВидовХарактеристик.СтатьиАктивовПассивов
	|";                   

	ТекстЗапроса = СтрШаблон(ТекстЗапроса, 
		НСтр("ru='Возмещение убытков поклажедателя на прочие активы';uk='Відшкодування збитків поклажедавача на інші активи'",ЯзыкСодержания));

	ТекстыОтражения.Добавить(ТекстЗапроса);
#КонецОбласти

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
	
	Возврат "";
	
КонецФункции

#КонецОбласти
//-- НЕ УТ

//++ Локализация
//-- Локализация

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
	ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры);
	//-- НЕ УТ
	//-- Локализация
	
КонецПроцедуры

//++ Локализация

//++ НЕ УТ
Функция ТекстЗапросаТаблицаОтражениеДокументовВРеглУчете(Запрос, ТекстыЗапроса, Регистры)
	
	ИмяРегистра = "ОтражениеДокументовВРеглУчете";
	
	Если Не ПроведениеДокументов.ТребуетсяТаблицаДляДвижений(ИмяРегистра, Регистры) Тогда
		Возврат "";
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	&Период      КАК Период,
	|	&Организация КАК Организация,
	|	НАЧАЛОПЕРИОДА(&Период, ДЕНЬ) КАК ДатаОтражения";
	
	ТекстыЗапроса.Добавить(ТекстЗапроса, ИмяРегистра);
	
	Возврат ТекстЗапроса;
	                            	
КонецФункции
//-- НЕ УТ
//-- Локализация

#КонецОбласти

#КонецОбласти
