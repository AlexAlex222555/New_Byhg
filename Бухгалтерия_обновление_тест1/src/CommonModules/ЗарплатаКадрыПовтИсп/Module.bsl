
#Область СлужебныеПроцедурыИФункции

// Получает информацию о виде расчета.
Функция ПолучитьИнформациюОВидеРасчета(ВидРасчета) Экспорт
		
	Возврат ЗарплатаКадрыВнутренний.ПолучитьИнформациюОВидеРасчета(ВидРасчета);
	
КонецФункции

// Возвращает ссылку на головную организацию.
Функция ГоловнаяОрганизация(Организация) Экспорт
	Возврат РегламентированнаяОтчетность.ГоловнаяОрганизация(Организация);
КонецФункции

// Функция определяет является ли организация юридическим лицом.
// 
Функция ЭтоЮридическоеЛицо(Организация) Экспорт
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Организация, "ЮридическоеФизическоеЛицо") <> Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо;
КонецФункции

// Возвращает ссылку на "Регистрацию в налоговом органе" по состоянию на некоторую ДатаАктуальности.
Функция РегистрацияВНалоговомОргане(СтруктурнаяЕдиница, Знач ДатаАктуальности = Неопределено) Экспорт
	

	Возврат Неопределено;
	
КонецФункции

// Возвращает ссылку на валюту в которой происходит расчет заработной платы (гривна).
// Номинирование тарифов, надбавок, выплата зарплаты допускается в любой валюте, 
// но расчеты выполняются в валюте учета зарплаты.
Функция ВалютаУчетаЗаработнойПлаты() Экспорт

    Возврат Константы.ВалютаРегламентированногоУчета.Получить();
	
КонецФункции


// Возвращает таблицу значений в строках которой содержится информация о периодах
// изменения (регистрации) фамилии, имени и отчества физических лиц.
//
// Параметры:
//		СписокОтветственных - Массив, ссылок справочника ФизическиеЛица.
//
// Возвращаемое значение:
//		ТаблицаЗначений - содержит колонки:
//			* Период			- Дата
//			* ФизическоеЛицо	- СправочникСсылка.ФизическиеЛица
//			* Фамилия			- Строка
//			* Имя				- Строка
//			* Отчество			- Строка
//
Функция ПериодыИзмененияФИООтветственныхЛиц(СписокОтветственных) Экспорт
	
	Возврат КадровыйУчет.ПериодыИзмененияФИОФизическихЛиц(СписокОтветственных);
	
КонецФункции

// Возвращает настройки формирования печатных форм.
//
// Возвращаемое значение:
//		Структура - соответствует структуре ресурсов регистра сведений ДополнительныеНастройкиЗарплатаКадры.
//
Функция НастройкиПечатныхФорм() Экспорт
	
	Возврат РегистрыСведений.ДополнительныеНастройкиЗарплатаКадры.НастройкиПечатныхФорм();
	
КонецФункции

// Возвращает коллекцию элементов справочника ВидыКонтактнойИнформации с типом Адрес.
//
Функция ВидыРоссийскихАдресов() Экспорт
	
	РоссийскиеАдреса = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ВидыКонтактнойИнформации.Ссылка
		|ИЗ
		|	Справочник.ВидыКонтактнойИнформации КАК ВидыКонтактнойИнформации
		|ГДЕ
		|	ВидыКонтактнойИнформации.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыКонтактнойИнформации.Адрес)
		|	И ВидыКонтактнойИнформации.ТолькоНациональныйАдрес";
		
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		РоссийскиеАдреса.Вставить(Выборка.Ссылка, Истина);
	КонецЦикла; 
	
	Возврат РоссийскиеАдреса;
	
КонецФункции

// Получает размер минимальной оплаты труда.
//
// Параметры:
//	ДатаАктуальности - дата, на которую нужно получить МРОТ.
//
// Возвращаемое значение:
//	число, размер МРОТ на дату, или Неопределено, если МРОТ на дату не определен
//
Функция МинимальныйРазмерОплатыТруда(ДатаАктуальности) Экспорт

	Возврат РегистрыСведений.МинимальнаяОплатаТруда.ДанныеМинимальногоРазмераОплатыТруда(ДатаАктуальности)["Размер"];
	
КонецФункции	

Функция ПрожиточныйМинимумТрудоспособные(ДатаАктуальности) Экспорт
	
	Возврат РегистрыСведений.ПрожиточныеМинимумы.ДанныеПрожиточногоМинимумаТрудоспособные(ДатаАктуальности)["Размер"];
	
КонецФункции

Функция МинимальнаяЧасоваТарифнаяСтавка(ДатаАктуальности) Экспорт

	Возврат РегистрыСведений.МинимальнаяОплатаТруда.ДанныеМинимальногоРазмераОплатыТруда(ДатаАктуальности)["Часовая"];
	
КонецФункции	

Функция МаксимальныйПриоритетСостоянийСотрудника() Экспорт
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Увольнение", Перечисления.СостоянияСотрудника.Увольнение);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СостоянияСотрудника.Порядок
	|ИЗ
	|	Перечисление.СостоянияСотрудника КАК СостоянияСотрудника
	|ГДЕ
	|	СостоянияСотрудника.Ссылка = &Увольнение";	
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Выборка.Следующий();
	
	Возврат Выборка.Порядок;
КонецФункции	

// Проверяет принадлежность объекта метаданных к подсистемам. Проверка производится на вхождение
// в состав указанных подсистем и на вхождение в состав подсистем подчиненных указанным.
//
// Параметры:
//			ПолноеИмяОбъектаМетаданных 	- Строка, полное имя объекта метаданных (см. функцию НайтиПоПолномуИмени).
//			ИменаПодсистем				- Строка, имена подсистем, перечисленные через запятую.
//
// Возвращаемое значение:
//		Булево
//
Функция ОбъектМетаданныхВключенВПодсистемы(ПолноеИмяОбъектаМетаданных, ИменаПодсистем) Экспорт
	
	ЭтоОбъектПодсистемы = Ложь;
	
	МетаданныеОбъекта = Метаданные.НайтиПоПолномуИмени(ПолноеИмяОбъектаМетаданных);
	Если МетаданныеОбъекта <> Неопределено Тогда
		
		МассивИменПодсистем = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИменаПодсистем);
		Для каждого ИмяПодсистемы Из МассивИменПодсистем Цикл
			
			МетаданныеПодсистемы = Метаданные.Подсистемы.Найти(ИмяПодсистемы);
			Если МетаданныеПодсистемы <> Неопределено Тогда
				ЭтоОбъектПодсистемы = ОбъектМетаданныхВключенВПодсистему(МетаданныеПодсистемы, МетаданныеОбъекта);
			КонецЕсли; 
			
			Если ЭтоОбъектПодсистемы Тогда
				Прервать;
			КонецЕсли; 
			
		КонецЦикла;
		
	КонецЕсли; 
	
	Возврат ЭтоОбъектПодсистемы;
	
КонецФункции

// Проверяет вхождение объекта метаданных в подсистему. Рекурсивно проверяется вхождение
// объекта метаданных в подсистемы подчиненные указанной.
//
// Параметры:
//		МетаданныеПодсистемы	- Метаданные подсистемы.
//		МетаданныеОбъекта		- Метаданные объекта.
//
// Возвращаемое значение:
//		Булево
//
Функция ОбъектМетаданныхВключенВПодсистему(МетаданныеПодсистемы, МетаданныеОбъекта)
	
	ВходитВСостав = МетаданныеПодсистемы.Состав.Содержит(МетаданныеОбъекта);
	Если НЕ ВходитВСостав Тогда
		
		Для каждого МетаданныеПодчиненнойПодсистемы Из МетаданныеПодсистемы.Подсистемы Цикл
			
			ВходитВСостав = ОбъектМетаданныхВключенВПодсистему(МетаданныеПодчиненнойПодсистемы, МетаданныеОбъекта);
			Если ВходитВСостав Тогда
				Прервать;
			КонецЕсли; 
			
		КонецЦикла;
		
	КонецЕсли; 
	
	Возврат ВходитВСостав;
	
КонецФункции

#КонецОбласти


Функция ОбъектыЗарплатноКадровойБиблиотекиСДополнительнымиСвойствами() Экспорт
	
	ОбъектыСоСвойствами = Новый Соответствие;
	ИменаПредопределенных = Метаданные.Справочники.НаборыДополнительныхРеквизитовИСведений.ПолучитьИменаПредопределенных();
	
	КоллекцииОбъектов = Новый Структура;
	КоллекцииОбъектов.Вставить("Справочник", Метаданные.Справочники);
	КоллекцииОбъектов.Вставить("Документ", Метаданные.Документы);
	КоллекцииОбъектов.Вставить("ПланВидовРасчета", Метаданные.ПланыВидовРасчета);
	
	Для Каждого ОписаниеКоллекции Из КоллекцииОбъектов Цикл
		
		Для Каждого МетаданныеОбъекта Из ОписаниеКоллекции.Значение Цикл
			
			ПолноеИмяОбъектаМетаданных = МетаданныеОбъекта.ПолноеИмя();
			Если Не ЗарплатаКадры.ЭтоОбъектЗарплатноКадровойБиблиотеки(ПолноеИмяОбъектаМетаданных) Тогда
				Продолжить;
			КонецЕсли; 
			
			ИмяНабораСвойств = ОписаниеКоллекции.Ключ + "_" + МетаданныеОбъекта.Имя;
			Если ИменаПредопределенных.Найти(ИмяНабораСвойств) = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			ОбъектыСоСвойствами.Вставить(ПолноеИмяОбъектаМетаданных, ИмяНабораСвойств);
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ОбъектыСоСвойствами;
	
КонецФункции

// Возвращает соответствие у которого Ключ содержит полное имя объекта метаданных,
// управляющего функциональными опциями, а значение- Массив полных имен метаданных
// функциональных опций которыми он управляет.
//
Функция ОбъектыУправляющиеФункциональнымиОпциями() Экспорт
	
	ОбъектыУправляющиеОпциями = Новый Соответствие;
	
	Для Каждого ФункциональнаяОпция Из Метаданные.ФункциональныеОпции Цикл
		
		Если Не ЗарплатаКадры.ЭтоОбъектЗарплатноКадровойБиблиотеки(ФункциональнаяОпция.ПолноеИмя()) Тогда
			Продолжить;
		КонецЕсли;
		
		ИмяХранения = ФункциональнаяОпция.Хранение.ПолноеИмя();
		Если СтрЧислоВхождений(ИмяХранения, ".") > 1 Тогда
			ИмяХранения = Лев(ИмяХранения, СтрНайти(ИмяХранения, ".", , , 2) - 1);
		КонецЕсли;
		
		КоллекцияОпций = ОбъектыУправляющиеОпциями.Получить(ИмяХранения);
		Если КоллекцияОпций = Неопределено Тогда
			КоллекцияОпций = Новый Массив;
		КонецЕсли;
		
		КоллекцияОпций.Добавить(ФункциональнаяОпция.ПолноеИмя());
		ОбъектыУправляющиеОпциями.Вставить(ИмяХранения, КоллекцияОпций);
		
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(ОбъектыУправляющиеОпциями);
	
КонецФункции

// Возвращает соответствие с описанием объекта метаданных с дополнительными
// реквизитами (свойствами), управляемых значениями функциональных опций.
//
// Параметры:
//	ПолноеИмяФункциональнойОпции	- Строка, полное имя объектов метаданных
//										функциональная опция
//
// Возвращаемое значение:
//	Соответствие	-	*Ключ		- полное имя объекта метаданных
//						*Значение	- Имя предопределенной группы справочника
//										НаборыДополнительныхРеквизитовИСведений
//
Функция ОбъектыСДополнительнымиСвойствамиУправляемыеФункциональнымиОпциями(ПолноеИмяФункциональнойОпции) Экспорт
	
	ОбъектыЗарплатноКадровойБиблиотеки = ЗарплатаКадрыПовтИсп.ОбъектыЗарплатноКадровойБиблиотекиСДополнительнымиСвойствами();
	ОбъектыОпции = Новый Соответствие;
	
	ФункциональнаяОпция = Метаданные.НайтиПоПолномуИмени(ПолноеИмяФункциональнойОпции);
	Для Каждого Элемент Из ФункциональнаяОпция.Состав Цикл
		
		Если Элемент.Объект <> Неопределено Тогда
			
			ПолноеИмяОбъекта = Элемент.Объект.ПолноеИмя();
			
			ОписаниеОбъекта = ОбъектыЗарплатноКадровойБиблиотеки.Получить(ПолноеИмяОбъекта);
			Если ОписаниеОбъекта <> Неопределено Тогда
				ОбъектыОпции.Вставить(ПолноеИмяОбъекта, ОписаниеОбъекта);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ОбъектыОпции;
	
КонецФункции

// Возвращает соответствие с описанием объекта метаданных с дополнительными
// реквизитами (свойствами) не управляемыми значениями функциональных опций.
//
// Возвращаемое значение:
//	Соответствие	-	*Ключ - полное имя объекта метаданных
//						*Значение - Имя предопределенной группы справочника
//									НаборыДополнительныхРеквизитовИСведений
//
Функция ОбъектыСДополнительнымиСвойствамиНеУправляемыеФункциональнымиОпциями() Экспорт
	
	ОбъектыЗарплатноКадровойБиблиотеки = ЗарплатаКадрыПовтИсп.ОбъектыЗарплатноКадровойБиблиотекиСДополнительнымиСвойствами();
	
	ОбъектыОпций = ОбщегоНазначенияКлиентСервер.СкопироватьСоответствие(ОбъектыЗарплатноКадровойБиблиотеки);
	Для Каждого ФункциональнаяОпция Из Метаданные.ФункциональныеОпции Цикл
		
		Для Каждого Элемент Из ФункциональнаяОпция.Состав Цикл
			
			Если Элемент.Объект <> Неопределено Тогда
				ОбъектыОпций.Удалить(Элемент.Объект.ПолноеИмя());
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ОбъектыОпций;
	
КонецФункции

Функция ОбъектыУправляемыеНесколькимиФункциональнымиОпциями() Экспорт
	
	ФункциональныеОпцииОбъектов = Новый Соответствие;
	ОбъектыКУдалению = Новый Соответствие;
	Для Каждого ФункциональнаяОпция Из Метаданные.ФункциональныеОпции Цикл
		
		Если Не ЗарплатаКадры.ЭтоОбъектЗарплатноКадровойБиблиотеки(ФункциональнаяОпция.ПолноеИмя()) Тогда
			Продолжить;
		КонецЕсли;
		
		Для Каждого ОбъектСостава Из ФункциональнаяОпция.Состав Цикл
			
			Если ОбъектСостава.Объект = Неопределено Тогда
				Продолжить;
			КонецЕсли;
			
			ИмяОбъекта = ОбъектСостава.Объект.ПолноеИмя();
			Если СтрЧислоВхождений(ИмяОбъекта, ".") > 1 Тогда
				Продолжить;
			КонецЕсли;
			
			Если Не СтрНачинаетсяС(ИмяОбъекта, "Справочник.")
				И Не СтрНачинаетсяС(ИмяОбъекта, "Документ.") Тогда
				
				Продолжить;
				
			КонецЕсли;
			
			ФункциональныеОпцииОбъекта = ФункциональныеОпцииОбъектов.Получить(ИмяОбъекта);
			Если ФункциональныеОпцииОбъекта = Неопределено Тогда
				ФункциональныеОпцииОбъекта = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ФункциональнаяОпция.ПолноеИмя());
				ОбъектыКУдалению.Вставить(ИмяОбъекта);
			Иначе
				ФункциональныеОпцииОбъекта.Добавить(ФункциональнаяОпция.ПолноеИмя());
				ОбъектыКУдалению.Удалить(ИмяОбъекта);
			КонецЕсли;
			
			ФункциональныеОпцииОбъектов.Вставить(ИмяОбъекта, ФункциональныеОпцииОбъекта);
			
		КонецЦикла;
		
	КонецЦикла;
	
	Для Каждого ОписаниеОбъекта Из ОбъектыКУдалению Цикл
		ФункциональныеОпцииОбъектов.Удалить(ОписаниеОбъекта.Ключ);
	КонецЦикла;
	
	Возврат ФункциональныеОпцииОбъектов;
	
КонецФункции

Функция ОсновнойСотрудникФизическогоЛица(ФизическоеЛицо, Организация, Период) Экспорт
	
	СотрудникиФизическихЛиц = КадровыйУчет.ОсновныеСотрудникиФизическихЛиц(
		ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ФизическоеЛицо), Истина, Организация, Период);
	
	Если СотрудникиФизическихЛиц.Количество() > 0 Тогда
		
		СтрокаСотрудника = СотрудникиФизическихЛиц.Найти(ФизическоеЛицо, "ФизическоеЛицо");
		Если СтрокаСотрудника <> Неопределено Тогда
			Возврат СтрокаСотрудника.Сотрудник;
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

Функция ДоступныеОрганизации() Экспорт
	
	ДоступныеОбъекты = Новый Структура("Организации,Филиалы");
	ДоступныеОбъекты.Филиалы = УправлениеДоступом.РазрешенныеЗначенияДляДинамическогоСписка(
		"Справочник.Организации", Тип("СправочникСсылка.Организации"));
	
	ДоступныеОбъекты.Организации = ОрганизацииФилиалов(ДоступныеОбъекты.Филиалы);
	
	Возврат ДоступныеОбъекты;
	
КонецФункции

Функция ОрганизацииФилиалов(Филиалы)
	
	Если ЗначениеЗаполнено(Филиалы) Тогда
		
		ЗапросПоОрганизациям = Новый Запрос;
		ЗапросПоОрганизациям.УстановитьПараметр("РазрешенныеФилиалы", Филиалы);
		
		ЗапросПоОрганизациям.Текст =
			"ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	Организации.ГоловнаяОрганизация КАК ГоловнаяОрганизация
			|ИЗ
			|	Справочник.Организации КАК Организации
			|ГДЕ
			|	Организации.Ссылка В(&РазрешенныеФилиалы)";
		
		УстановитьПривилегированныйРежим(Истина);
		Организации = ЗапросПоОрганизациям.Выполнить().Выгрузить().ВыгрузитьКолонку("ГоловнаяОрганизация");
		УстановитьПривилегированныйРежим(Ложь);
		
	Иначе
		Организации = Новый Массив;
	КонецЕсли;
	
	Возврат Организации;
	
КонецФункции
