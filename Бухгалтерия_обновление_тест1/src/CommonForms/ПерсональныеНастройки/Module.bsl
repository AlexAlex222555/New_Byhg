
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ЭтоВебКлиент = ОбщегоНазначенияКлиентСервер.ЭтоВебКлиент();
	
	// БазоваяФункциональность
	ЗапрашиватьПодтверждениеПриЗавершенииПрограммы = СтандартныеПодсистемыСервер.ЗапрашиватьПодтверждениеПриЗавершенииПрограммы();
	// Конец БазоваяФункциональность
	
	// работа с пользователями
	ТекущийПользователь = Пользователи.АвторизованныйПользователь();	
	
	// работа с файлами
	СпрашиватьРежимРедактированияПриОткрытииФайла = 
		ХранилищеОбщихНастроек.Загрузить("НастройкиОткрытияФайлов", "СпрашиватьРежимРедактированияПриОткрытииФайла");
	Если СпрашиватьРежимРедактированияПриОткрытииФайла = Неопределено Тогда
		СпрашиватьРежимРедактированияПриОткрытииФайла = Истина;
		ХранилищеОбщихНастроек.Сохранить("НастройкиОткрытияФайлов", "СпрашиватьРежимРедактированияПриОткрытииФайла", СпрашиватьРежимРедактированияПриОткрытииФайла);
	КонецЕсли;
	
	ДействиеПоДвойномуЩелчкуМыши = ХранилищеОбщихНастроек.Загрузить("НастройкиОткрытияФайлов", "ДействиеПоДвойномуЩелчкуМыши");
	Если ДействиеПоДвойномуЩелчкуМыши = Неопределено Тогда
		ДействиеПоДвойномуЩелчкуМыши = Перечисления.ДействияСФайламиПоДвойномуЩелчку.ОткрыватьФайл;
		ХранилищеОбщихНастроек.Сохранить("НастройкиОткрытияФайлов", "ДействиеПоДвойномуЩелчкуМыши", ДействиеПоДвойномуЩелчкуМыши);
	КонецЕсли;
	
	СпособСравненияВерсийФайлов = ХранилищеОбщихНастроек.Загрузить("НастройкиСравненияФайлов", "СпособСравненияВерсийФайлов");
	ПоказыватьПодсказкиПриРедактированииФайлов = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("НастройкиПрограммы", "ПоказыватьПодсказкиПриРедактированииФайлов");
	ПоказыватьИнформациюЧтоФайлНеБылИзменен = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("НастройкиПрограммы", "ПоказыватьИнформациюЧтоФайлНеБылИзменен");
	
	ПоказыватьЗанятыеФайлыПриЗавершенииРаботы =  ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("НастройкиПрограммы", "ПоказыватьЗанятыеФайлыПриЗавершенииРаботы");
	Если ПоказыватьЗанятыеФайлыПриЗавершенииРаботы = Неопределено Тогда 
		ПоказыватьЗанятыеФайлыПриЗавершенииРаботы = Истина;
		ХранилищеОбщихНастроек.Сохранить("НастройкиПрограммы", "ПоказыватьЗанятыеФайлыПриЗавершенииРаботы", ПоказыватьЗанятыеФайлыПриЗавершенииРаботы);
	КонецЕсли;
	
	ПоказыватьКолонкуРазмер = ХранилищеОбщихНастроек.Загрузить("НастройкиПрограммы", "ПоказыватьКолонкуРазмер");
	Если ПоказыватьКолонкуРазмер = Неопределено Тогда
		ПоказыватьКолонкуРазмер = Ложь;
		ХранилищеОбщихНастроек.Сохранить("НастройкиПрограммы", "ПоказыватьКолонкуРазмер", ПоказыватьКолонкуРазмер);
	КонецЕсли;
	
	// работа с документами
	ВидВнутреннегоДокумента = ХранилищеОбщихНастроек.Загрузить("НастройкиРаботыСДокументами", "ВидВнутреннегоДокумента");
	ВидВходящегоДокумента	= ХранилищеОбщихНастроек.Загрузить("НастройкиРаботыСДокументами", "ВидВходящегоДокумента");
	ВидИсходящегоДокумента 	= ХранилищеОбщихНастроек.Загрузить("НастройкиРаботыСДокументами", "ВидИсходящегоДокумента");
	
	СпособОтправки  = ХранилищеОбщихНастроек.Загрузить("НастройкиРаботыСДокументами", "СпособОтправки");
	СпособПолучения = ХранилищеОбщихНастроек.Загрузить("НастройкиРаботыСДокументами", "СпособПолучения");
	
	ПоказыватьПредупреждениеПриРегистрации = ХранилищеОбщихНастроек.Загрузить("НастройкиРаботыСДокументами", "ПоказыватьПредупреждениеПриРегистрации");
	Если ПоказыватьПредупреждениеПриРегистрации = Неопределено Тогда 
		ПоказыватьПредупреждениеПриРегистрации = Истина;
		ХранилищеОбщихНастроек.Сохранить("НастройкиРаботыСДокументами", "ПоказыватьПредупреждениеПриРегистрации", ПоказыватьПредупреждениеПриРегистрации);
	КонецЕсли;
	
	Элементы.Группа8.Видимость = Пользователи.ЭтоПолноправныйПользователь(, Истина)
									И (Не ОбщегоНазначения.РазделениеВключено()
									Или Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных());
	
	// Печать
	ЗапрашиватьПодтверждение = ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("ОбщиеНастройкиПользователя", "ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов");
	Если ЗапрашиватьПодтверждение <> Неопределено Тогда
		ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов = ЗапрашиватьПодтверждение;
	Иначе
		ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов = Истина;
		ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("ОбщиеНастройкиПользователя", "ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов", Истина);
	КонецЕсли;
	
	//++ НЕ БЗК
	ДоступноВыключениеКонтроляОстатков = ПраваПользователяПовтИсп.РазрешитьОтключениеКонтроляТоваровОрганизацийНаВремяСеанса();
	
	Если ДоступноВыключениеКонтроляОстатков Тогда
		ОбновитьНадписьКнопкиВыключитьКонтрольОстатковТоваровОрганизаций(ПараметрыСеанса.ПроводитьБезКонтроляОстатковТоваровОрганизаций);
	КонецЕсли;
	
	Элементы.ВыключитьКонтрольОстатковТоваров.Видимость = ДоступноВыключениеКонтроляОстатков;
	//-- НЕ БЗК
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаИУправлениеПерсоналом") Тогда
		Элементы.УчетТоваров.Видимость = Ложь;
		Элементы.ИнтеграцияС1СДокументооборот.Видимость = Ложь;
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Оповещение = Новый ОписаниеОповещения("ЗаписатьИЗакрытьОповещение", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	МассивСтруктур = Новый Массив;
	
	// работа с файлами
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиОткрытияФайлов");
	Элемент.Вставить("Настройка", "ДействиеПоДвойномуЩелчкуМыши");
	Элемент.Вставить("Значение", ДействиеПоДвойномуЩелчкуМыши);
	МассивСтруктур.Добавить(Элемент);
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиОткрытияФайлов");
	Элемент.Вставить("Настройка", "СпрашиватьРежимРедактированияПриОткрытииФайла");
	Элемент.Вставить("Значение", СпрашиватьРежимРедактированияПриОткрытииФайла);
	МассивСтруктур.Добавить(Элемент);
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиПрограммы");
	Элемент.Вставить("Настройка", "ПоказыватьПодсказкиПриРедактированииФайлов");
	Элемент.Вставить("Значение", ПоказыватьПодсказкиПриРедактированииФайлов);
	МассивСтруктур.Добавить(Элемент);
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиПрограммы");
	Элемент.Вставить("Настройка", "ПоказыватьЗанятыеФайлыПриЗавершенииРаботы");
	Элемент.Вставить("Значение", ПоказыватьЗанятыеФайлыПриЗавершенииРаботы);
	МассивСтруктур.Добавить(Элемент);
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиСравненияФайлов");
	Элемент.Вставить("Настройка", "СпособСравненияВерсийФайлов");
	Элемент.Вставить("Значение", СпособСравненияВерсийФайлов);
	МассивСтруктур.Добавить(Элемент);
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", "НастройкиПрограммы");
	Элемент.Вставить("Настройка", "ПоказыватьКолонкуРазмер");
	Элемент.Вставить("Значение", ПоказыватьКолонкуРазмер);
	МассивСтруктур.Добавить(Элемент);
	
	// БазоваяФункциональность
	МассивСтруктур.Добавить(ОписаниеНастройки(
	    "ОбщиеНастройкиПользователя",
	    "ЗапрашиватьПодтверждениеПриЗавершенииПрограммы",
	    ЗапрашиватьПодтверждениеПриЗавершенииПрограммы));
	// Конец БазоваяФункциональность
	
	МассивСтруктур.Добавить(ОписаниеНастройки(
	    "НастройкиПрограммы",
	    "ПоказыватьИнформациюЧтоФайлНеБылИзменен",
	    ПоказыватьИнформациюЧтоФайлНеБылИзменен));
	
	// Печать
	МассивСтруктур.Добавить(ОписаниеНастройки(
		"ОбщиеНастройкиПользователя",
		"ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов",
		ЗапрашиватьПодтверждениеПриПечатиКомплектаДокументов));
	// Конец Печать
	
	ОбщегоНазначенияВызовСервера.ХранилищеОбщихНастроекСохранитьМассив(МассивСтруктур);
	Модифицированность = Ложь;
	Закрыть();
	
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаРабочегоКаталога(Команда)
	ОткрытьФорму("ОбщаяФорма.НастройкаРабочегоКаталога",,,,,, Неопределено, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
КонецПроцедуры

&НаКлиенте
Процедура УстановитьРасширениеРаботыСФайламиНаКлиенте(Команда)
	НачатьУстановкуРасширенияРаботыСФайлами(Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура НастройкаСканирования(Команда)
	
	РаботаСФайламиКлиент.ОткрытьФормуНастройкиСканирования();
	
КонецПроцедуры

&НаКлиенте
Процедура СведенияОПользователе(Команда)
	
	ПоказатьЗначение(Неопределено, ТекущийПользователь);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьПараметрыСистемы(Команда)
	
	ОбновитьПовторноИспользуемыеЗначения();
	ОбновитьИнтерфейс();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗадатьДействиеПриВыбореМакетаПечатнойФормы(Команда)
	ОткрытьФорму("РегистрСведений.ПользовательскиеМакетыПечати.Форма.ВыбораРежимаОткрытияМакета");
КонецПроцедуры

&НаКлиенте
Процедура ПерсональнаяНастройкаПроксиСервера(Команда)
	
	ОткрытьФорму("ОбщаяФорма.ПараметрыПроксиСервера",
	                  Новый Структура("НастройкаПроксиНаКлиенте", Истина));
					  
КонецПроцедуры

&НаКлиенте
Процедура НастройкаЭЦП(Команда)
	
	ЭлектроннаяПодписьКлиент.ОткрытьНастройкиЭлектроннойПодписиИШифрования();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьРасширениеРаботыСКриптографиейНаКлиенте(Команда)
	НачатьУстановкуРасширенияРаботыСКриптографией(Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура НастроитьПараметрыАвторизацииВ1СДокументооборот(Команда)
	//++ НЕ БЗК
	// ИнтеграцияС1СДокументооборотом
	ОткрытьФорму("Обработка.ИнтеграцияС1СДокументооборот.Форма.АвторизацияВ1СДокументооборот",,,,,, Неопределено, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	// Конец ИнтеграцияС1СДокументооборотом
	//-- НЕ БЗК
КонецПроцедуры

&НаКлиенте
Процедура НастройкаРабочегоКаталогаИнтеграции(Команда)
	//++ НЕ БЗК
	// ИнтеграцияС1СДокументооборотом
	ОткрытьФорму("Обработка.ИнтеграцияС1СДокументооборот.Форма.НастройкаКаталогаФайлов");
	// Конец ИнтеграцияС1СДокументооборотом
	//-- НЕ БЗК
КонецПроцедуры

&НаКлиенте
Процедура ВыключитьКонтрольОстатковТоваров(Команда)
	ВыключитьКонтрольОстатковТоваровСервер();
КонецПроцедуры

&НаСервере
Процедура ВыключитьКонтрольОстатковТоваровСервер()
	//++ НЕ БЗК
	ПараметрыСеанса.ПроводитьБезКонтроляОстатковТоваровОрганизаций = Не ПараметрыСеанса.ПроводитьБезКонтроляОстатковТоваровОрганизаций;
	
	ОбновитьНадписьКнопкиВыключитьКонтрольОстатковТоваровОрганизаций(ПараметрыСеанса.ПроводитьБезКонтроляОстатковТоваровОрганизаций);
	
	Если ПараметрыСеанса.ПроводитьБезКонтроляОстатковТоваровОрганизаций Тогда
		ТекстСообщения = НСтр("ru='Пользователем %ИмяПользователя% в рамках своего сеанса выключен контроль остатков товаров организаций.';uk='Користувачем %ИмяПользователя% в рамках свого сеансу вимкнений контроль залишків товарів організацій.'",Метаданные.ОсновнойЯзык.КодЯзыка);
	Иначе
		ТекстСообщения = НСтр("ru='Пользователем %ИмяПользователя% возобновлен контроль остатков товаров организаций.';uk='Користувачем %ИмяПользователя% відновлений контроль залишків товарів організацій.'",Метаданные.ОсновнойЯзык.КодЯзыка);
	КонецЕсли;
	ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ИмяПользователя%", ПользователиКлиентСервер.ТекущийПользователь());
	
	ЗаписьЖурналаРегистрации(ЗапасыСервер.ИмяСобытияВыключенКонтрольОстатков(),
		УровеньЖурналаРегистрации.Предупреждение, , ,ТекстСообщения);
	//-- НЕ БЗК	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗаписатьИЗакрытьОповещение(Результат, Неопределен) Экспорт
	ЗаписатьИЗакрыть(Неопределено);
КонецПроцедуры

&НаКлиенте
Функция ОписаниеНастройки(Объект, Настройка, Значение)
	
	Элемент = Новый Структура;
	Элемент.Вставить("Объект", Объект);
	Элемент.Вставить("Настройка", Настройка);
	Элемент.Вставить("Значение", Значение);
	
	Возврат Элемент;
	
КонецФункции

&НаСервере
Процедура ОбновитьНадписьКнопкиВыключитьКонтрольОстатковТоваровОрганизаций(КонтрольВыключен)
	Если КонтрольВыключен Тогда
		Элементы.ВыключитьКонтрольОстатковТоваров.Заголовок = НСтр("ru='Возобновить контроль остатков';uk='Відновити контроль залишків'");
		Элементы.ВыключитьКонтрольОстатковТоваров.РасширеннаяПодсказка.Заголовок = НСтр("ru='Восстановление контроля остатков товаров организаций для текущего пользователя, ранее выключенных на время сеанса.';uk='Відновлення контролю залишків товарів організацій для поточного користувача, раніше виключених на час сеансу.'");
	Иначе
		Элементы.ВыключитьКонтрольОстатковТоваров.Заголовок = НСтр("ru='Отключить контроль остатков (на время сеанса)';uk='Відключити контроль залишків (на час сеансу)'");
		Элементы.ВыключитьКонтрольОстатковТоваров.РасширеннаяПодсказка.Заголовок = НСтр("ru='Выключение контроля остатков товаров организаций для текущего пользователя на время сеанса работы.';uk='Вимкнення контролю залишків товарів організацій для поточного користувача на час сеансу роботи.'");
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
