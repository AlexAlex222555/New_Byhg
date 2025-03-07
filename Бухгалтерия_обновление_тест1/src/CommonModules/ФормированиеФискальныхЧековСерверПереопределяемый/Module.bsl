#Область ПрограммныйИнтерфейс

// Определяет структуру параметров для печати чеков, заполняет параметры значениями по-умолчанию
//
// Возвращаемое значение:
// 	Структура - Структура параметров
//
Функция СтруктураОсновныхПараметровОперации() Экспорт
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("ДокументСсылка");
	СтруктураПараметров.Вставить("Организация");
	СтруктураПараметров.Вставить("Контрагент");
	СтруктураПараметров.Вставить("Партнер");
	СтруктураПараметров.Вставить("ТорговыйОбъект");
	СтруктураПараметров.Вставить("Валюта");
	СтруктураПараметров.Вставить("ВалютаВзаиморасчетов");
	СтруктураПараметров.Вставить("СуммаДокумента");
	СтруктураПараметров.Вставить("ИмяКомандыПробитияЧека");
	СтруктураПараметров.Вставить("ИмяРеквизитаГиперссылкиНаФорме");
	СтруктураПараметров.Вставить("ОплатаВыполнена");
	СтруктураПараметров.Вставить("ПараметрыЭквайринговойОперации");
	
	Возврат СтруктураПараметров;
	
КонецФункции

// Возвращает параметры по документу для формирования формы предпросмотра чека
// 
// Параметры:
// 	ПараметрыОперации - Структура - Основные параметры документа
// Возвращаемое значение:
// 	Структура - параметры по документу для формирования формы предпросмотра чека
Функция ПараметрыПредпросмотраЧека(ПараметрыОперации) Экспорт
	
	ПараметрыПредпросмотраЧека = Новый Структура;
	
	// ПраваДоступа
	ПараметрыПредпросмотраЧека.Вставить("ПраваДоступа", ПраваДоступа());
	
	Возврат ПараметрыПредпросмотраЧека;
	
КонецФункции

// Возвращает статус работы документа с эквайринговым оборудованием
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ, проверяемый на возможность работы с эквайринговым оборудованием
// Возвращаемое значение:
// 	Булево - Статус работы документа с эквайринговым оборудованием
Функция ПредполагаетсяПодключениеЭквайринговогоТерминалаПоДокументу(ДокументСсылка) Экспорт
	
	ПредполагаетсяПодключениеЭквайринговогоТерминалаПоДокументу = Ложь;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ПредполагаетсяПодключениеЭквайринговогоТерминалаПоДокументу;
	
КонецФункции

// Определяет дату операции чека коррекции по документу
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Корректируемый документ
// Возвращаемое значение:
// 	Дата - Дата операции чека коррекции по документу
Функция ДатаСовершенияКорректируемогоРасчета(ДокументСсылка) Экспорт
	
	ДатаКоррекции = ТекущаяДатаСеанса();
	
	//++ Локализация
	//-- Локализация
	
	Возврат ДатаКоррекции;
	
КонецФункции

// Определяет типы видов фискальных чеков по документы
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ пробития фискального чека
// 	ИмяКомандыПробитияЧека - Строка - Имя команды пробития чека
// Возвращаемое значение:
// 	Массив Из ПеречислениеСсылка.ТипыФискальныхДокументовККТ - Типы фискальных чеков
Функция ТипыФискальногоДокумента(ДокументСсылка, ИмяКомандыПробитияЧека) Экспорт
	
	ТипыФискальногоДокумента = Новый Массив;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТипыФискальногоДокумента;
	
КонецФункции

// Определяет типы расчета денежными средствами по документу
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ пробития фискального чека
// 	ИмяКомандыПробитияЧека - Строка - Имя команды пробития чека
// 	ТипФискальногоДокумента - ПеречислениеСсылка.ТипыФискальныхДокументовККТ - Тип фискального документа
// Возвращаемое значение:
// 	Массив Из ПеречислениеСсылка.ТипыРасчетаДенежнымиСредствами - Типы расчета денежными средствами
Функция ТипыРасчетаДенежнымиСредствами(ДокументСсылка, ИмяКомандыПробитияЧека, ТипФискальногоДокумента) Экспорт
	
	ТипыРасчетаДенежнымиСредствами = Новый Массив;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТипыРасчетаДенежнымиСредствами;
	
КонецФункции

// Определяет виды чека коррекции по документу
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ пробития фискального чека
// 	ИмяКомандыПробитияЧека - Строка - Имя команды пробития чека
// Возвращаемое значение:
// 	Массив Из ПеречислениеСсылка.ВидыЧековКоррекции - Виды чека коррекции
Функция ВидыЧекаКоррекции(ДокументСсылка, ИмяКомандыПробитияЧека) Экспорт
	
	ВидыЧекаКоррекции = Новый Массив;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ВидыЧекаКоррекции;
	
КонецФункции

// Формирует таблицу объектов расчетов с признаками способа расчетов по каждому объекту для формирования позиции чека
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ пробития фискального чека
// 	ВозможныеПризнакиСпособаРасчетаПоДокументу - ТаблицаЗначений - Возможные признаки способа расчета по документу
// 	ПризнакиСпособаРасчетаАвто - ТаблицаЗначений - Признаки способа расчета по взаиморасчетам с контрагентом
// 	ПризнакСпособаРасчета - ПеречислениеСсылка.ПризнакиСпособаРасчета - Выбранный признак способа расчета
// 	ОбъектыРасчетов - ТаблицаЗначений - Объекты расчетов по документу
// 	СуммаДокумента - Число - Сумма документа
// Возвращаемое значение:
// 	ТаблицаЗначений - Таблица объектов расчетов с признаками способа расчетов по каждому объекту
Функция ОбъектыРасчетовСПризнакамиСпособаРасчетов(ДокументСсылка, ВозможныеПризнакиСпособаРасчетаПоДокументу, ПризнакиСпособаРасчетаАвто, ПризнакСпособаРасчета, ОбъектыРасчетов, СуммаДокумента) Экспорт
	
	ОбъектыРасчетовСПризнакамиСпособаРасчетов = Новый ТаблицаЗначений;
	ОбъектыРасчетовСПризнакамиСпособаРасчетов.Колонки.Добавить("ОбъектРасчетов");
	ОбъектыРасчетовСПризнакамиСпособаРасчетов.Колонки.Добавить("ПризнакСпособаРасчета");
	ОбъектыРасчетовСПризнакамиСпособаРасчетов.Колонки.Добавить("Сумма");
	
	//++ Локализация
	//-- Локализация
	
	Возврат ОбъектыРасчетовСПризнакамиСпособаРасчетов;
	
КонецФункции

// Определяет, является ли документ документом оплаты с возможностью пробития чека
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Проверяемый документ
// Возвращаемое значение:
// 	Булево - флаг, является ли документ документом оплаты с возможностью пробития чека, да = истина, нет = ложь
Функция ДокументОплатыСВозможностьюПробитияЧеков(ДокументСсылка) Экспорт
	
	ДокументОплатыСВозможностьюПробитияЧеков = Ложь;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ДокументОплатыСВозможностьюПробитияЧеков;
	
КонецФункции

// Определяет, является ли объект расчетов авансовым
// 
// Параметры:
// 	ОбъектРасчетов - СправочникСсылка, ДокументСсылка - объект расчета документа оплаты
// Возвращаемое значение:
// 	Булево - флаг, является ли объект расчета авансовым, да = истина, нет = ложь
Функция ОбъектРасчетовАвансовый(ОбъектРасчетов) Экспорт
	
	ОбъектРасчетовАвансовый = Ложь;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ОбъектРасчетовАвансовый;
	
КонецФункции

// Определяет платежный документ по документу поставки товаров/услуг. Если платежных документов больше одного или
// не было платежей по документу, возвращается Неопределено (для единого чека возможен только один платежный документ
// по документу поставки).
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ поставки
// Возвращаемое значение:
// 	Неопределено - Описание
Функция ДокументОплатыПоДокументуПоставкиВРамкахЕдиногоЧека(ДокументСсылка) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ДокументОплатыПоДокументуПоставки = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ДокументОплатыПоДокументуПоставки;
	
КонецФункции

// Обновляет параметры операции фискализации чека
// 
// Параметры:
// 	ПараметрыОперацииЧека - Структура - Данные для формирования параметров операции фискализации чека
// Возвращаемое значение:
// 	Структура - Обновленные параметры операции фискализации чека
Функция ОбновитьПараметрыФискальногоЧека(ПараметрыОперацииЧека) Экспорт
	
	ПараметрыОперацииФискализацииЧека = ФормированиеПараметровФискальногоЧекаСервер.ПараметрыОперацииФискализацииЧека(ПараметрыОперацииЧека.ДокументСсылка, ПараметрыОперацииЧека.Организация);
	
	//++ Локализация
	//-- Локализация
	
	Возврат ПараметрыОперацииФискализацииЧека;
	
КонецФункции

// Формирует текст нефискального чека по шаблону.
// 
// Параметры:
// 	ПараметрыОперацииФискализацииЧека - Структура - Параметры операции фискализации чека
// 	ВерсияФФД - Строка - Версия ФФД, по которой формируется текст чека
// Возвращаемое значение:
// 	Строка - Текст нефискального чека по шаблону
Функция ОбновитьМакетЧека(ПараметрыОперацииФискализацииЧека, ВерсияФФД) Экспорт
	
	ТекстНефискальногоЧека = "";
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстНефискальногоЧека;
	
КонецФункции

// Возвращает массив возможных признаков способа расчета документа
// 
// Параметры:
//  ПризнакиСпособаРасчета - Массив Из ПеречислениеСсылка.ПризнакиСпособаРасчета - Признак способа расчета для документа, возвращаемое значение
// 	ДокументСсылка - ДокументСсылка - Документ
// 	ОбъектыРасчетов - СправочникСсылка, ДокументСсылка - Объекты расчетов документа 
// 	ТипРасчетаДенежнымиСредствами - ПеречислениеСсылка.ТипыРасчетаДенежнымиСредствами - тип расчета денежными средствами
// 	СуммаДокумента - Число - Сумма документа
Процедура ВидыВозможныхПризнаковСпособаРасчетаПоДокументу(ПризнакиСпособаРасчета, ДокументСсылка, ОбъектыРасчетов, ТипРасчетаДенежнымиСредствами, СуммаДокумента) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Возвращает поддерживаемую максимальную версию ФФД
// 
// Возвращаемое значение:
// 	Строка - Описание - Версия ФФД
Функция МаксимальнаяВерсияФФД() Экспорт

	МаксимальнаяВерсияФФД = "";
	
	//++ Локализация
	//-- Локализация
	
	Возврат МаксимальнаяВерсияФФД;

КонецФункции

// Возвращает версию ФФД, поддерживаемую оборудованием
// 
// Параметры:
// 	ПодключаемоеОборудование - СправочникСсылка.ПодключаемоеОборудование - ККТ
// Возвращаемое значение:
// 	Строка - Версия ФФД, поддерживаемую оборудованием
Функция ВерсияФФДОборудования(ПодключаемоеОборудование) Экспорт

	ЗначениеВерсияФФД = "";
	
	//++ Локализация
	//-- Локализация
	
	Возврат ЗначениеВерсияФФД;

КонецФункции

// Проверяет, соответствует ли введенный ИНН требованиям законодательства
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ печати чека
// 	ИНН - Строка - Введенный ИНН
// 	ТекстСообщения - Строка - Сообщение об ошибке
// Возвращаемое значение:
// 	Булево - Статус корректности ввода ИНН
Функция ИННСоответствуетТребованиямНаСервере(ДокументСсылка, ИНН, ТекстСообщения) Экспорт
	
	ИННЗаполненКорректно = Истина;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ИННЗаполненКорректно;
	
КонецФункции

// Возвращает подключенное оборудовани по организации и торговому объекту
// 
// Параметры:
// 	ПараметрыОперации - Структура - Структура параметров операции
// Возвращаемое значение:
// 	Массив из Структура - список подключенного оборудования:
// 	* Оборудование - СправочникСсылка.ПодключаемоеОборудование - Оборудование
// 	* Подключено - Булево - Статус подключение, где Истина = подключено
// 	* ВерсияФФД - Строка - Версия ФФД, поддерживаемая оборудованием
Функция ПодключенноеОборудованиеПечатиЧеков(ПараметрыОперации) Экспорт
	
	ПодключенноеОборудованиеПечатиЧеков = Новый Массив;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ПодключенноеОборудованиеПечатиЧеков;
	
КонецФункции

// Возвращает объекты расчетов документа оплаты
// 
// Параметры:
// 	ДокументОплаты - ДокументСсылка - Документы оплаты
// 	ИмяКомандыПробитияЧека - Строка - Имя команды пробития чека
// Возвращаемое значение:
// 	ТаблицаЗначений, Неопределено - Описание
Функция ОбъектыРасчетовДокументаОплаты(ДокументОплаты, ИмяКомандыПробитияЧека) Экспорт
	
	ОбъектыРасчетовДокументаОплаты = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ОбъектыРасчетовДокументаОплаты;
	
КонецФункции

// Обновляет представление гиперссылки данными фискального чека в переданном параметре "РеквизитГиперссылкиНаФорме"
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Ссылка на документ, из формы документа которого ожидается возможность
// 	 ввода/отображения фискального чека.
// 	Форма - ФормаКлиентскогоПриложения - Форма документа, на которой необходимо обновить гиперссылку ввода/отображения
// 	 фискального чека.
// 	РеквизитГиперссылкиНаФорме - РеквизитФормы - Реквизит формы, отображающий гиперссылку ввода/отображения фискального
// 	 чека.
Процедура ОбновитьГиперссылкуПробитияФискальногоЧека(ДокументСсылка, Форма, РеквизитГиперссылкиНаФорме) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Формирование кэш данных механизмов основными параметрами операции при создании формы на сервере
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма документа - состоит из:
// 	* Объект - ДокументОбъект - Основной реквизит формы.
Процедура ФормаПриСозданииНаСервере(Форма) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Формирование кэш данных механизмов основными параметрами операции при чтении формы на сервере
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма документа - состоит из:
// 	* Объект - ДокументОбъект - Основной реквизит формы.
Процедура ФормаПриЧтенииНаСервере(Форма) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Формирование кэш данных механизмов основными параметрами операции при изменении реквизита формы
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма документа - состоит из:
// 	* Объект - ДокументОбъект - Основной реквизит формы - состоит из
Процедура ФормаПриИзмененииРеквизитов(Форма) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

//++ Локализация
//-- Локализация

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область МетодыЗаполненияПараметровПредпросмотраЧека

Процедура ОбновитьВзаиморасчеты(ПараметрыОперации)
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Функция ПараметрыЕдиногоЧека(ПараметрыОперации)
	
	ДокументыЕдиногоЧека = Новый ТаблицаЗначений();
	ДокументыЕдиногоЧека.Колонки.Добавить("Документ");
	ДокументыЕдиногоЧека.Колонки.Добавить("Сумма");
	
	//++ Локализация
	//-- Локализация
	
	Возврат ДокументыЕдиногоЧека;
	
КонецФункции

Функция ОбъектыРасчетовПоДокументу(ПараметрыОперации)
	
	ОбъектыРасчетовПоДокументу = Новый ТаблицаЗначений();
	ОбъектыРасчетовПоДокументу.Колонки.Добавить("ОбъектРасчетов");
	ОбъектыРасчетовПоДокументу.Колонки.Добавить("Заказ");
	ОбъектыРасчетовПоДокументу.Колонки.Добавить("Сумма");
	
	//++ Локализация
	//-- Локализация
	
	Возврат ОбъектыРасчетовПоДокументу;
	
КонецФункции

Функция ПризнакиСпособаРасчетаАвто(ПараметрыОперации, ОбъектыРасчетовПоДокументу)
	
	ПризнакиСпособаРасчетаАвто = Новый Массив;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ПризнакиСпособаРасчетаАвто;
	
КонецФункции

Функция ДанныеФискальнойОперации()
	
	Возврат Новый Структура;
	
КонецФункции

Функция РазрешенВводПерсональныхДанных(ПараметрыОперацииЧека)
	
	РазрешенВводПерсональныхДанных = Ложь;
	
	//++ Локализация
	//-- Локализация
	
	Возврат РазрешенВводПерсональныхДанных;
	
КонецФункции

Функция ПараметрыОперацииФискализацииЧека(ПараметрыОперации)
	
	Возврат ФормированиеПараметровФискальногоЧекаСервер.ПараметрыОперацииФискализацииЧека(
		ПараметрыОперации.ДокументСсылка,
		ПараметрыОперации.Организация);
	
КонецФункции

Функция ПраваДоступа()
	
	Возврат НастройкиПродажДляПользователейСервер.ПраваДоступаРМК(Пользователи.ТекущийПользователь());
	
КонецФункции

Функция ШтрихкодыУпаковокЗаполнены(Объект) Экспорт
	
	Результат = Ложь;
	
	//++ Локализация
	//-- Локализация
	
	Возврат НЕ Результат;
	
КонецФункции

#КонецОбласти

//++ Локализация
//-- Локализация

#КонецОбласти

