#Область ПрограммныйИнтерфейс

// Возвращает параметры по документу для формирвания формы предпросмотра чека
// 
// Параметры:
// 	ПараметрыОперации - Структура - Основные параметры документа
// Возвращаемое значение:
// 	Структура - параметры по документу для формирвания формы предпросмотра чека
Функция ПараметрыПредпросмотраЧека(ПараметрыОперации) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ПараметрыПредпросмотраЧека(ПараметрыОперации);
	
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
	
	ФормированиеФискальныхЧековСерверПереопределяемый.ОбновитьГиперссылкуПробитияФискальногоЧека(ДокументСсылка, Форма, РеквизитГиперссылкиНаФорме);
	
КонецПроцедуры

// Проверяет, есть ли у текущего пользователя право на проведение документа
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Ссылка на документ, из формы документа которого ожидается возможность
// 	 ввода/отображения фискального чека.
// Возвращаемое значение:
// 	Булево - Возвращает Истина, если пользователь имеет право на проведение документа
Функция ЕстьПравоНаПробитиеФискальногоЧекаПоДокументу(ДокументСсылка) Экспорт
	
	Возврат (ПользовательИмеетПравоНаИнтерактивноеПроведениеДокумента(ДокументСсылка)
		ИЛИ ДокументПроведен(ДокументСсылка));

КонецФункции

// Добавляет представление гиперссылки команды открытия пробитого чека
// 
// Параметры:
// 	МассивПредставлений - Массив Из ФорматированнаяСтрока - Массив представлений гиперссылки
// 	НомерЧекаККМ - Строка - Номер чека ККМ, пробитого по документу
// 	ТекстСсылки - Строка - Текст гиперссылки для обработки нажатия
// 	ТекстПредставления - Строка - Текст представления гиперссылки, который видит пользователь на форме
Процедура ДобавитьВПредставлениеГиперссылкиКомандуЧекПробит(МассивПредставлений, НомерЧекаККМ, ТекстСсылки, ТекстПредставления = Неопределено) Экспорт
	
	ПредставлениеЧекПробит = СтрШаблон(НСтр("ru='Пробит чек №%1';uk='Пробитий чек №%1'"), НомерЧекаККМ);
	Если ТекстПредставления <> Неопределено Тогда
		ПредставлениеЧекПробит = ТекстПредставления;
	КонецЕсли;
	
	МассивПредставлений.Добавить(Новый ФорматированнаяСтрока(ПредставлениеЧекПробит, , ЦветаСтиля.ЦветГиперссылки, , ТекстСсылки));

КонецПроцедуры

// Добавляет представление гиперссылки команды пробития чека
// 
// Параметры:
// 	МассивПредставлений - Массив Из ФорматированнаяСтрока - Массив представлений гиперссылки
// 	ТекстСсылки - Строка - Текст гиперссылки для обработки нажатия
// 	ТекстПредставления - Строка, Неопределено - Текст представления гиперссылки из вызова
Процедура ДобавитьВПредставлениеГиперссылкиКомандуПробитьЧек(МассивПредставлений, ТекстСсылки, ТекстПредставления = Неопределено) Экспорт
	
	ПредставлениеПредпросмотрЧека = НСтр("ru='Пробить чек';uk='Пробити чек'");
	Если ТекстПредставления <> Неопределено Тогда
		ПредставлениеПредпросмотрЧека = ТекстПредставления;
	КонецЕсли;
	
	МассивПредставлений.Добавить(Новый ФорматированнаяСтрока(ПредставлениеПредпросмотрЧека, , ЦветаСтиля.ЦветГиперссылки, , ТекстСсылки));

КонецПроцедуры

// Добавляет представление гиперссылки непробитого чек
// 
// Параметры:
// 	МассивПредставлений - Массив Из ФорматированнаяСтрока - Массив представлений гиперссылки
Процедура ДобавитьВПредставлениеГиперссылкиСтатусЧекНеПробит(МассивПредставлений) Экспорт

	ПредставлениеЧекНеПробит = НСтр("ru='Чек не пробит';uk='Чек не пробитий '");
	МассивПредставлений.Добавить(Новый ФорматированнаяСтрока(ПредставлениеЧекНеПробит, , ЦветаСтиля.ЦветГиперссылки));

КонецПроцедуры

// Возвращает поддерживаемую максимальную версию ФФД
// 
// Возвращаемое значение:
// 	Строка - Описание - Версия ФФД
Функция МаксимальнаяВерсияФФД() Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.МаксимальнаяВерсияФФД();

КонецФункции

// Возвращает параметры пробитого фискального чека по документу, иначе, если не пробит, неопределено
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ, по которому возможно пробит чек
// Возвращаемое значение:
// 	Структура, Неопределено - Описание: Параметры пробитого фискального чека по документу, иначе, если не пробит, неопределено
Функция ДанныеПробитогоФискальногоЧекаПоДокументу(ДокументСсылка) Экспорт
	

КонецФункции

// Флаг пробития чека - пробит = Истина, не пробит = Ложь
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ, по которому возможно пробит чек
// Возвращаемое значение:
// 	Булево - Флаг пробития чека - пробит = Истина, не пробит = Ложь
Функция ПробитФискальныйЧекПоДокументу(ДокументСсылка) Экспорт
	
	ПробитЧек = Ложь;
	
	ФискальнаяОперацияДанныеЖурнала = ДанныеПробитогоФискальногоЧекаПоДокументу(ДокументСсылка);
	
	Если ФискальнаяОперацияДанныеЖурнала <> Неопределено Тогда
		ПробитЧек = Истина;
	КонецЕсли;
	
	Возврат ПробитЧек;
	
КонецФункции

// Возвращает массив возможных признаков способа расчета документа
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ
// 	ОбъектыРасчетов - СправочникСсылка, ДокументСсылка - Объекты расчетов документа 
// 	ТипРасчетаДенежнымиСредствами - ПеречислениеСсылка.ТипыРасчетаДенежнымиСредствами - тип расчета денежными средствами
// 	СуммаДокумента - Число - Сумма документа
// Возвращаемое значение:
// 	Массив - Массив возможных признаков способа расчета документа
Функция ВидыВозможныхПризнаковСпособаРасчетаПоДокументу(ДокументСсылка, ОбъектыРасчетов, ТипРасчетаДенежнымиСредствами, СуммаДокумента) Экспорт
	
	ПризнакиСпособаРасчета = Новый Массив();
	
	ФормированиеФискальныхЧековСерверПереопределяемый.ВидыВозможныхПризнаковСпособаРасчетаПоДокументу(
		ПризнакиСпособаРасчета,
		ДокументСсылка,
		ОбъектыРасчетов,
		ТипРасчетаДенежнымиСредствами,
		СуммаДокумента);
	
	Возврат ПризнакиСпособаРасчета;
	
КонецФункции

// Возвращает флаг корректности ввода объектов расчетов в документе: 
//  - если в документе содержатся объекты расчетов авансовые и предоплатные, флаг = Ложь - иначе, флаг = Истина.
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ оплаты
// 	ТекстСообщения - Строка - Информационное сообщение пользователю об ошибке, иначе пустая строка
// 	ИмяКомандыПробитияЧека - Строка - Имя команды пробития чека
// Возвращаемое значение:
// 	Булево - возвращает статус корректности заполнения объектов расчетов
Функция ОбъектыРасчетовВДокументеОплатыВведеныКорректно(ДокументСсылка, ТекстСообщения, ИмяКомандыПробитияЧека) Экспорт
	
	Если НЕ ФормированиеФискальныхЧековСерверПереопределяемый.ДокументОплатыСВозможностьюПробитияЧеков(ДокументСсылка) Тогда
		Возврат Истина;
	КонецЕсли;	
		
	ЕстьОбъектРасчетовАвансовый = Ложь;
	ЕстьОбъектРасчетовПрочие = Ложь;
	
	ОбъектыРасчетов = ОбъектыРасчетовДокументаОплаты(ДокументСсылка, ИмяКомандыПробитияЧека);
	Для Каждого ОбъектРасчетов Из ОбъектыРасчетов Цикл
		Если ФормированиеФискальныхЧековСерверПереопределяемый.ОбъектРасчетовАвансовый(ОбъектРасчетов.Заказ) Тогда
			ЕстьОбъектРасчетовАвансовый = Истина;
		Иначе
			ЕстьОбъектРасчетовПрочие = Истина;
		КонецЕсли;
	КонецЦикла;
	
	Если ЕстьОбъектРасчетовАвансовый И ЕстьОбъектРасчетовПрочие Тогда
		ТекстСообщения = НСтр("ru='Нельзя в одном объекте расчетов оплачивать аванс и предоплату. Необходимо разделить на отдельные документы оплаты.';uk='Неможна в одному об''єкті розрахунків сплачувати аванс і передоплату. Необхідно розділити на окремі документи оплати.'");
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

// Возвращает массив доступных касс ККМ по текущей настройке РМК
// 
// Параметры:
// 	ДоступныеКассыККМ - Массив - Перезаполняемый параметр доступными кассами ККМ
// 	КассаККМ - СправочникСсылка.КассыККМ - Касса ККМ для получения текущей настройки РМК
Процедура ЗаполнитьДоступныеКассыККМ(ДоступныеКассыККМ, КассаККМ) Экспорт
	
	ДоступныеКассыККМ.Очистить();
	
	РабочееМесто = МенеджерОборудованияВызовСервера.ПолучитьРабочееМестоКлиента();
	
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	НастройкиРМК.КассыККМ.(
	|		КассаККМ КАК КассаККМ,
	|		КассаККМ.ТипКассы КАК ТипКассы
	|	) КАК ДоступныеКассыККМ
	|ИЗ
	|	Справочник.НастройкиРМК КАК НастройкиРМК
	|ГДЕ
	|	НастройкиРМК.РабочееМесто = &РабочееМесто
	|	И НастройкиРМК.Ссылка В (ВЫБРАТЬ РАЗЛИЧНЫЕ Т.Ссылка ИЗ Справочник.НастройкиРМК.КассыККМ КАК Т ГДЕ Т.КассаККМ = &КассаККМ)
	|");
	
	Запрос.УстановитьПараметр("РабочееМесто", РабочееМесто);
	Запрос.УстановитьПараметр("КассаККМ", КассаККМ);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		
		ДоступныеКассыККМВыборка = Выборка.ДоступныеКассыККМ; // ВыборкаИзРезультатаЗапроса - выборка по Кассам ККМ из Настроки РМК 
		ВыборкаДоступныеКассыККМ = ДоступныеКассыККМВыборка.Выбрать();
		Пока ВыборкаДоступныеКассыККМ.Следующий() Цикл
			Если ВыборкаДоступныеКассыККМ.ТипКассы = Перечисления.ТипыКассККМ.ФискальныйРегистратор Тогда
				ДоступныеКассыККМ.Добавить(ВыборкаДоступныеКассыККМ.КассаККМ);
			КонецЕсли;
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

// Формирование кэш данных механизмов основными параметрами операции при создании формы на сервере
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма документа - состоит из:
// 	* Объект - ДокументОбъект - Основной реквизит формы.
Процедура ФормаПриСозданииНаСервере(Форма) Экспорт
	
	ФормированиеФискальныхЧековСерверПереопределяемый.ФормаПриСозданииНаСервере(Форма);
	
КонецПроцедуры

// Формирование кэш данных механизмов основными параметрами операции при чтении формы на сервере
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма документа - состоит из:
// 	* Объект - ДокументОбъект - Основной реквизит формы.
Процедура ФормаПриЧтенииНаСервере(Форма) Экспорт
	
	ФормированиеФискальныхЧековСерверПереопределяемый.ФормаПриЧтенииНаСервере(Форма);
	
КонецПроцедуры

// Формирование кэш данных механизмов основными параметрами операции при изменении реквизита формы
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - Форма документа - состоит из:
// 	* Объект - ДокументОбъект - Основной реквизит формы - состоит из
Процедура ФормаПриИзмененииРеквизитов(Форма) Экспорт
	
	ФормированиеФискальныхЧековСерверПереопределяемый.ФормаПриИзмененииРеквизитов(Форма);
	
КонецПроцедуры

// Возвращает статус работы документа с эквайринговым оборудованием
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ, проверяемый на возможность работы с эквайринговым оборудованием
// Возвращаемое значение:
// 	Булево - Статус работы документа с эквайринговым оборудованием
Функция ПредполагаетсяПодключениеЭквайринговогоТерминалаПоДокументу(ДокументСсылка) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ПредполагаетсяПодключениеЭквайринговогоТерминалаПоДокументу(ДокументСсылка);
	
КонецФункции

// Определяет дату операции чека коррекции по документу
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Корректируемый документ
// Возвращаемое значение:
// 	Дата - Дата операции чека коррекции по документу
Функция ДатаСовершенияКорректируемогоРасчета(ДокументСсылка) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ДатаСовершенияКорректируемогоРасчета(ДокументСсылка);
	
КонецФункции

// Определяет типы фискальных чеков по документы
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ пробития фискального чека
// 	ИмяКомандыПробитияЧека - Строка - Имя команды пробития чека
// Возвращаемое значение:
// 	Массив Из ПеречислениеСсылка.ТипыФискальныхДокументовККТ - Типы фискальных чеков
Функция ТипыФискальногоДокумента(ДокументСсылка, ИмяКомандыПробитияЧека) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ТипыФискальногоДокумента(ДокументСсылка, ИмяКомандыПробитияЧека);
	
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
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ТипыРасчетаДенежнымиСредствами(
		ДокументСсылка,
		ИмяКомандыПробитияЧека,
		ТипФискальногоДокумента);
	
КонецФункции

// Определяет виды чека коррекции по документу
// 
// Параметры:
// 	ДокументСсылка - ДокументСсылка - Документ пробития фискального чека
// 	ИмяКомандыПробитияЧека - Строка - Имя команды пробития чека
// Возвращаемое значение:
// 	Массив Из ПеречислениеСсылка.ВидыЧековКоррекции - Виды чека коррекции
Функция ВидыЧекаКоррекции(ДокументСсылка, ИмяКомандыПробитияЧека) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ВидыЧекаКоррекции(ДокументСсылка, ИмяКомандыПробитияЧека);
	
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
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ОбъектыРасчетовСПризнакамиСпособаРасчетов(
		ДокументСсылка,
		ВозможныеПризнакиСпособаРасчетаПоДокументу,
		ПризнакиСпособаРасчетаАвто,
		ПризнакСпособаРасчета,
		ОбъектыРасчетов,
		СуммаДокумента);
	
КонецФункции

// Обновляет параметры операции фискализации чека
// 
// Параметры:
// 	ПараметрыОперацииЧека - Структура - Данные для формирования параметров операции фискализации чека
// Возвращаемое значение:
// 	Структура - Обновленные параметры операции фискализации чека
Функция ОбновитьПараметрыФискальногоЧека(ПараметрыОперацииЧека) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ОбновитьПараметрыФискальногоЧека(ПараметрыОперацииЧека);
	
КонецФункции

// Формирует текст нефискального чека по шаблону.
// 
// Параметры:
// 	ПараметрыОперацииФискализацииЧека - Структура - Параметры операции фискализации чека
// 	ВерсияФФД - Строка - Версия ФФД, по которой формируется текст чека
// Возвращаемое значение:
// 	Строка - Текст нефискального чека по шаблону
Функция ОбновитьМакетЧека(ПараметрыОперацииФискализацииЧека, ВерсияФФД) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ОбновитьМакетЧека(ПараметрыОперацииФискализацииЧека, ВерсияФФД);
	
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
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ИННСоответствуетТребованиямНаСервере(ДокументСсылка, ИНН, ТекстСообщения);
	
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
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ПодключенноеОборудованиеПечатиЧеков(ПараметрыОперации);
	
КонецФункции

Функция ШтрихкодыУпаковокЗаполнены(Объект) Экспорт
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ШтрихкодыУпаковокЗаполнены(Объект);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область УправлениеПравами

Функция ПользовательИмеетПравоНаИнтерактивноеПроведениеДокумента(Документ)
	
	Возврат ПравоДоступа("ИнтерактивноеПроведение", Документ.Метаданные());
	
КонецФункции

Функция ДокументПроведен(Документ)
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Документ, "Проведен");
	
КонецФункции

#КонецОбласти

Функция ОбъектыРасчетовДокументаОплаты(ДокументОплаты, ИмяКомандыПробитияЧека)
	
	Возврат ФормированиеФискальныхЧековСерверПереопределяемый.ОбъектыРасчетовДокументаОплаты(ДокументОплаты, ИмяКомандыПробитияЧека);
	
КонецФункции

#КонецОбласти

