#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает имена блокируемых реквизитов для механизма блокирования реквизитов БСП
//
// Возвращаемое значение:
//	Массив - имена блокируемых реквизитов.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	Результат = Новый Массив;
	Результат.Добавить("НазначениеПравила");
	Результат.Добавить("НаправлениеРаспределения");
	//++ НЕ УТ
	Результат.Добавить("БазаРаспределения");
	//-- НЕ УТ
	Возврат Результат;
КонецФункции

//++ НЕ УТ

// Возвращает параметры настройки счетов учета в документе.
//  
// Возвращаемое значение:
//  ПараметрыНастройки -  Параметры настройки счетов учета (См. НастройкаСчетовУчета.ПараметрыНастройки()).
//
Функция ПараметрыНастройкиСчетовУчета() Экспорт
	
	ПараметрыНастройки = НастройкаСчетовУчета.ПараметрыНастройки();
	
	ПараметрыНастройки.ДоступностьПоОперации 	= Истина;
	ПараметрыНастройки.ПутьКДанным   			= "Объект.Списание";
	ПараметрыНастройки.ТипСтатьи     			= "ТипСтатьи";
	ПараметрыНастройки.Организация 				= "";
	ПараметрыНастройки.АналитикаАктивовПассивов = "Объект.Списание.АналитикаАктивовПассивов";
	
	ПараметрыНастройки.ЭлементыФормы.Добавить("СписаниеПредставлениеОтраженияОперации");
	
	Возврат ПараметрыНастройки;
	
КонецФункции
//-- НЕ УТ

// Возвращает параметры выбора статей и аналитик.
// 
// Возвращаемое значение:
//  ПараметрыВыбора - Параметры выбора статей и аналитик (См. ДоходыИРасходыСервер.ПараметрыВыбораСтатьиИАналитики).
//
Функция ПараметрыВыбораСтатейИАналитик(НазначениеПравила) Экспорт 
	
	//++ НЕ УТ
	Если НазначениеПравила = Перечисления.НазначениеПравилРаспределенияРасходов.РаспределениеСтатейРасходовПоЭтапамПроизводства Тогда
		
		// Для правила На партии.
		ПараметрыВыбора = ДоходыИРасходыСервер.ПараметрыВыбораСтатьиИАналитики();
		ПараметрыВыбора.ПутьКДанным = "Объект.Списание";
		ПараметрыВыбора.Статья      = "СтатьяРасходов";
		ПараметрыВыбора.ТипСтатьи   = "ТипСтатьи";
		
		ПараметрыВыбора.АналитикаРасходов 		 = "АналитикаРасходов";
		ПараметрыВыбора.АналитикаАктивовПассивов = "АналитикаАктивовПассивов";
		
		ПараметрыВыбора.ВыборСтатьиРасходов = Истина;
		
		МассивВариантов = Новый Массив;
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НаНаправленияДеятельности);
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НаРасходыБудущихПериодов);
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НаВнеоборотныеАктивы);
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НеРаспределять);
		
		ПараметрыВыбора.ОтборСтатейРасходов.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.СписаниеТоваровПоТребованию;
		ПараметрыВыбора.ОтборСтатейРасходов.ВариантРаспределенияРасходов = МассивВариантов;
		
		ПараметрыВыбора.ВыборСтатьиАктивовПассивов = Истина;
		
		ПараметрыВыбора.ЭлементыФормы.Статья.Добавить("СписаниеСтатьяРасходов");
		ПараметрыВыбора.ЭлементыФормы.АналитикаРасходов.Добавить("СписаниеАналитикаРасходов");
		ПараметрыВыбора.ЭлементыФормы.АналитикаАктивовПассивов.Добавить("СписаниеАналитикаАктивовПассивов");
	
	КонецЕсли;
	//-- НЕ УТ
	
	Если НазначениеПравила = Перечисления.НазначениеПравилРаспределенияРасходов.РаспределениеРасходовНаРБП Тогда
		// Для правила РБП.
		ПараметрыВыбора = ДоходыИРасходыСервер.ПараметрыВыбораСтатьиИАналитики();
		ПараметрыВыбора.ПутьКДанным = "Объект";
		ПараметрыВыбора.Статья      = "СтатьяСписанияРБП";
		
		ПараметрыВыбора.АналитикаРасходов 	= "АналитикаРасходовРБП";	
		ПараметрыВыбора.ВыборСтатьиРасходов = Истина;
		
		МассивВариантов = Новый Массив;
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НаНаправленияДеятельности);
		//++ НЕ УТ
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НаПроизводственныеЗатраты);
		//-- НЕ УТ
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НаПрочиеАктивы);
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НеРаспределять);
		МассивВариантов.Добавить(Перечисления.ВариантыРаспределенияРасходов.НаСебестоимостьТоваров);
		
		ПараметрыВыбора.ОтборСтатейРасходов.ВариантРаспределенияРасходов = МассивВариантов;
		
		ПараметрыВыбора.ЭлементыФормы.Статья.Добавить("СтатьяСписанияРБП");
		ПараметрыВыбора.ЭлементыФормы.АналитикаРасходов.Добавить("АналитикаРасходовРБП");
	
	КонецЕсли;
	
	Возврат ПараметрыВыбора;
	
КонецФункции

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	Если Не ВидФормы = "ФормаОбъекта" Тогда
		Возврат;
	КонецЕсли;
	
	Если Параметры.Свойство("Ключ") Тогда
		
		РеквизитыКПолучению = Новый Массив;
		РеквизитыКПолучению.Добавить("НазначениеПравила");
		//++ НЕ УТ
		РеквизитыКПолучению.Добавить("Устаревшее");
		//-- НЕ УТ
		ЗначенияРеквизитов = ОбщегоНазначенияУТВызовСервера.ЗначенияРеквизитовОбъекта(Параметры.Ключ, РеквизитыКПолучению);
		
		//++ НЕ УТ
		Если ЗначенияРеквизитов.Устаревшее Тогда
			ВыбраннаяФорма = "УстаревшаяФормаПравила";
			Возврат;
		КонецЕсли;
		//-- НЕ УТ
		
	ИначеЕсли Параметры.Свойство("ЗначениеКопирования") Тогда
		ЗначенияРеквизитов = Параметры.ЗначениеКопирования;
	ИначеЕсли Параметры.Свойство("ЗначенияЗаполнения")
		И Параметры.ЗначенияЗаполнения.Свойство("НазначениеПравила") Тогда
		ЗначенияРеквизитов = Параметры.ЗначенияЗаполнения;
	Иначе
		Возврат;
	КонецЕсли;
	
	НаФР = ПредопределенноеЗначение("Перечисление.НазначениеПравилРаспределенияРасходов.РаспределениеРасходовНаФинансовыйРезультат");
	НаРБП = ПредопределенноеЗначение("Перечисление.НазначениеПравилРаспределенияРасходов.РаспределениеРасходовНаРБП");
	//++ НЕ УТ
	Материалы = ПредопределенноеЗначение("Перечисление.НазначениеПравилРаспределенияРасходов.РаспределениеМатериаловИРабот");
	НаПартии = ПредопределенноеЗначение("Перечисление.НазначениеПравилРаспределенияРасходов.РаспределениеСтатейРасходовПоЭтапамПроизводства");
	ПоПодразделениям = ПредопределенноеЗначение("Перечисление.НазначениеПравилРаспределенияРасходов.РаспределениеСтатейРасходовПоПодразделениям");
	//-- НЕ УТ
	
	ФормыПоНазначению = Новый Соответствие;
	ФормыПоНазначению.Вставить(НаФР, "ФормаНастроекФР");
	ФормыПоНазначению.Вставить(НаРБП, "ФормаНастроекРБП");
	//++ НЕ УТ
	ФормыПоНазначению.Вставить(НаПартии, "ФормаНастроекНаПартии");
	ФормыПоНазначению.Вставить(ПоПодразделениям, "ФормаПоказателя");
	ФормыПоНазначению.Вставить(Материалы, "УстаревшаяФормаПравила");
	//-- НЕ УТ
		
	ВыбраннаяФорма = ФормыПоНазначению.Получить(ЗначенияРеквизитов.НазначениеПравила);
	
	Если ЗначениеЗаполнено(ВыбраннаяФорма) Тогда
		
		СтандартнаяОбработка = Ложь;
		Возврат;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область Прочее

Функция ПредставлениеОтобранныхПозиций(ОтобранныеПозиции, ПараметрыПредметаИсчисления = Неопределено) Экспорт

	Если ОтобранныеПозиции.Количество() = 0 Тогда
		Возврат "";
	КонецЕсли;
	
	Если ОтобранныеПозиции.Количество() = 1 Тогда
		Возврат СокрЛП(ОтобранныеПозиции[0]);
	КонецЕсли;
	
	Если ПараметрыПредметаИсчисления = Неопределено Тогда
		ПредметИсчисления = "позиция, позиции, позиций";
	Иначе
		ПредметИсчисления = ПараметрыПредметаИсчисления;
	КонецЕсли;
	
	КоличествоПозиций = ОтобранныеПозиции.Количество() - 1;
	ДляСклонения = ЧислоПрописью(КоличествоПозиций, "Л = ru_RU;", ПредметИсчисления);
	
	НачалоПредмета = СтрНайти(ДляСклонения, Лев(ПредметИсчисления, 3));
	СклоненныйПредмет = Сред(ДляСклонения, НачалоПредмета, СтрНайти(ДляСклонения, " ",, НачалоПредмета) - НачалоПредмета);
	
	Представление = НСтр("ru='%1 и еще %2 %3';uk=' %1 і ще %2 %3'");
	
	Представление = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Представление, 
		СокрЛП(ОтобранныеПозиции[0]), КоличествоПозиций, 
		СклоненныйПредмет);
		
	Возврат Представление;
	
КонецФункции

//++ НЕ УТ

Функция ПолучитьПредставлениеПравила(Материалы, ВидыРабот, Продукция, БазаРаспределения) Экспорт
	
	Если ТипЗнч(Материалы) = Тип("Массив") Тогда
		
		ПредставлениеОтобранныхПозиций = ПредставлениеОтобранныхПозиций(Материалы);
		ПредставлениеОтобранныхПозиций = ПредставлениеОтобранныхПозиций 
			+ ПредставлениеОтобранныхПозиций(ВидыРабот);
		ПредставлениеОтобранныхПозиций = ПредставлениеОтобранныхПозиций 
			+ ПредставлениеОтобранныхПозиций(Продукция);
		
	Иначе	
			
		ПредставлениеОтобранныхПозиций = ПредставлениеОтобранныхПозиций(Материалы.ВыгрузитьКолонку("Материал"));
		ПредставлениеОтобранныхПозиций = ПредставлениеОтобранныхПозиций 
			+ ПредставлениеОтобранныхПозиций(ВидыРабот.ВыгрузитьКолонку("ВидРабот"));
		ПредставлениеОтобранныхПозиций = ПредставлениеОтобранныхПозиций 
			+ ПредставлениеОтобранныхПозиций(Продукция.ВыгрузитьКолонку("Продукция"));
			
	КонецЕсли;
		
	ПредставлениеПравила = "";
	Если БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.КоличествоРаботУказанныхВидов Тогда
		ПредставлениеПравила = НСтр("ru='Количество работ:';uk='Кількість робіт:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.НормативыОплатыТруда Тогда
		ПредставлениеПравила = НСтр("ru='Нормативная стоимость работ:';uk='Нормативна вартість робіт:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.СуммаРасходовНаОплатуТруда Тогда
		ПредставлениеПравила = НСтр("ru='Стоимость работ:';uk='Вартість робіт:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.КоличествоУказанныхМатериалов Тогда
		ПредставлениеПравила = НСтр("ru='Количество материалов:';uk='Кількість матеріалів:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.ОбъемУказанныхМатериалов Тогда
		ПредставлениеПравила = НСтр("ru='Объем материалов:';uk='Об''єм матеріалів:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.СуммаМатериальныхЗатрат Тогда
		ПредставлениеПравила = НСтр("ru='Стоимость материалов:';uk='Вартість матеріалів:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.ВесУказанныхМатериалов Тогда
		ПредставлениеПравила = НСтр("ru='Вес материалов:';uk='Вага матеріалів:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.ВесПродукции Тогда
		ПредставлениеПравила = НСтр("ru='Вес продукции:';uk='Вага продукції:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.КоличествоПродукции Тогда
		ПредставлениеПравила = НСтр("ru='Количество продукции:';uk='Кількість продукції:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.ОбъемПродукции Тогда
		ПредставлениеПравила = НСтр("ru='Объем продукции:';uk='Об''єм продукції:'");
	ИначеЕсли БазаРаспределения = Перечисления.ТипыБазыРаспределенияРасходов.ПлановаяСтоимостьПродукции Тогда
		ПредставлениеПравила = НСтр("ru='Плановая стоимость продукции:';uk='Планова вартість продукції:'");
	КонецЕсли;
	
	Возврат СокрЛП(ПредставлениеПравила + " " + ПредставлениеОтобранныхПозиций);
	
КонецФункции

//-- НЕ УТ

#КонецОбласти

#Область ОбновлениеИнформационнойБазы

// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
//  Обработчики - ТаблицаЗначений - описание полей, см. в процедуре
//                ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления.
//
// Пример добавления процедуры-обработчика в список:
//  Обработчик = Обработчики.Добавить();
//  Обработчик.Версия              = "1.1.0.0";
//  Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_1_0_0";
//  Обработчик.МонопольныйРежим    = Ложь;
//
// Параметры:
// 	Обработчики - см. ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления
//
Процедура ОписаниеОбработчиковОбновления(Обработчики) Экспорт
	
	//++ НЕ УТ
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "Справочники.ПравилаРаспределенияРасходов.ОбработатьДанныеДляПереходаНаНовуюВерсию24";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("efc02391-ec1f-44d3-9b3d-07302ac19daa");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "Справочники.ПравилаРаспределенияРасходов.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию24";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "Справочник.ПравилаРаспределенияРасходов";
	Обработчик.ИзменяемыеОбъекты = "Справочник.ПравилаРаспределенияРасходов";
	Обработчик.БлокируемыеОбъекты = "Справочник.ПравилаРаспределенияРасходов";
	Обработчик.Комментарий = НСтр("ru='Заполняет представление правила распределения для которых установлено правила по указанным позициям, а также признак ""Устаревшее"".';uk='Заповнює представлення правила розподілу, для яких встановлено правила за вказаними позиціями, а також ознаку ""Застаріле"".'");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.ПравилаРаспределенияРасходов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";   
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "ПланыВидовХарактеристик.СтатьиРасходов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";   
	
	//-- НЕ УТ
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "Справочники.ПравилаРаспределенияРасходов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("d924c134-bcd6-4cf2-b0a4-8013e967c039");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "Справочники.ПравилаРаспределенияРасходов.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЗапускатьТолькоВГлавномУзле = Истина;
	Обработчик.Комментарий = НСтр("ru='Создание новых правил распределения расходов на основании элементов 
|справочника ""Способы распределения расходов по направлениям деятельности""
|и на основании элементов справочника ""Статьи расходов"", у которых вариант распределения на расходы будущих 
|периодов и заполнена статья расходов получатель.'
|;uk='Створення нових правил розподілу витрат на підставі елементів 
|довідника ""Способи розподілу витрат за напрямами діяльності"" 
|та на підставі елементів довідника ""Статті витрат"", у яких варіант розподілу на витрати майбутніх періодів і
| заповнена стаття витрат одержувач.'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.ПланыВидовХарактеристик.СтатьиРасходов.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Справочники.ПравилаРаспределенияРасходов.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Справочники.СпособыРаспределенияПоНаправлениямДеятельности.ПолноеИмя());
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.Справочники.ПравилаРаспределенияРасходов.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
	Блокируемые = Новый Массив;
	Блокируемые.Добавить(Метаданные.Справочники.ПравилаРаспределенияРасходов.ПолноеИмя());
	Обработчик.БлокируемыеОбъекты = СтрСоединить(Блокируемые, ",");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "ОбновлениеИнформационнойБазыУТ.ОбновитьПредставленияПредопределенныхЭлементов";
	НоваяСтрока.Порядок = "Любой";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "ПланыВидовХарактеристик.СтатьиРасходов.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";   
	
	//++ НЕ УТ
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Справочники.ПравилаРаспределенияРасходов.ОбработатьДанныеДляПереходаНаНовуюВерсию24";
	НоваяСтрока.Порядок = "Любой";   
	//-- НЕ УТ

КонецПроцедуры

//++ НЕ УТ

// Регистрирует данные для обработчика обновления.
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию24(Параметры) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВложенныйЗапрос.Ссылка КАК Ссылка
	|ИЗ
	|	(ВЫБРАТЬ
	|		ПравилаРаспределенияРасходовОтборПоМатериалам.Ссылка КАК Ссылка
	|	ИЗ
	|		Справочник.ПравилаРаспределенияРасходов.ОтборПоМатериалам КАК ПравилаРаспределенияРасходовОтборПоМатериалам
	|			ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПравилаРаспределенияРасходов КАК ПравилаРаспределенияРасходов
	|			ПО ПравилаРаспределенияРасходовОтборПоМатериалам.Ссылка = ПравилаРаспределенияРасходов.Ссылка
	|	ГДЕ
	|		ПравилаРаспределенияРасходов.ПредставлениеПравила ПОДОБНО """"
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ПравилаРаспределенияРасходовОтборПоВидамРабот.Ссылка
	|	ИЗ
	|		Справочник.ПравилаРаспределенияРасходов.ОтборПоВидамРабот КАК ПравилаРаспределенияРасходовОтборПоВидамРабот
	|			ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПравилаРаспределенияРасходов КАК ПравилаРаспределенияРасходов
	|			ПО ПравилаРаспределенияРасходовОтборПоВидамРабот.Ссылка = ПравилаРаспределенияРасходов.Ссылка
	|	ГДЕ
	|		ПравилаРаспределенияРасходов.ПредставлениеПравила ПОДОБНО """"
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ПравилаРаспределенияРасходовОтборПоПродукции.Ссылка
	|	ИЗ
	|		Справочник.ПравилаРаспределенияРасходов.ОтборПоПродукции КАК ПравилаРаспределенияРасходовОтборПоПродукции
	|			ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПравилаРаспределенияРасходов КАК ПравилаРаспределенияРасходов
	|			ПО ПравилаРаспределенияРасходовОтборПоПродукции.Ссылка = ПравилаРаспределенияРасходов.Ссылка
	|	ГДЕ
	|		ПравилаРаспределенияРасходов.ПредставлениеПравила ПОДОБНО """"
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ПравилаРаспределенияРасходов.Ссылка
	|	ИЗ
	|		Справочник.ПравилаРаспределенияРасходов КАК ПравилаРаспределенияРасходов
	|	ГДЕ
	|		НЕ ПравилаРаспределенияРасходов.РаспределятьНаСтатьи
	|		И НЕ ПравилаРаспределенияРасходов.РаспределятьПоПартиям
	|		И НЕ ПравилаРаспределенияРасходов.Устаревшее
	|		И ПравилаРаспределенияРасходов.НазначениеПравила В (ЗНАЧЕНИЕ(Перечисление.НазначениеПравилРаспределенияРасходов.РаспределениеСтатейРасходовПоЭтапамПроизводства), ЗНАЧЕНИЕ(Перечисление.НазначениеПравилРаспределенияРасходов.РаспределениеСтатейРасходовПоПодразделениям))
	|		И НЕ ПравилаРаспределенияРасходов.БазаРаспределения В (ЗНАЧЕНИЕ(Перечисление.ТипыБазыРаспределенияРасходов.ВводитсяПриИзменении), ЗНАЧЕНИЕ(Перечисление.ТипыБазыРаспределенияРасходов.ВводитсяЕжемесячно))
	|	) КАК ВложенныйЗапрос
	|";
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
	
КонецПроцедуры

// Обработка данных для перехода на новую версию.
//
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию24(Параметры) Экспорт
	
	МетаданныеСправочника = Метаданные.Справочники.ПравилаРаспределенияРасходов;
	ПолноеИмяОбъекта = "Справочник.ПравилаРаспределенияРасходов";
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Результат = ОбновлениеИнформационнойБазы.СоздатьВременнуюТаблицуСсылокДляОбработки(
		Параметры.Очередь, 
		ПолноеИмяОбъекта, 
		МенеджерВременныхТаблиц
	);
		
	Параметры.ОбработкаЗавершена = НЕ Результат.ЕстьДанныеДляОбработки;
	Если Параметры.ОбработкаЗавершена Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Результат.ЕстьЗаписиВоВременнойТаблице Тогда
		Параметры.ОбработкаЗавершена = Ложь;
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	ТекстЗапроса =
		"ВЫБРАТЬ
		|	ОбъектыДляОбработки.Ссылка КАК Ссылка,
		|	ОбъектыДляОбработки.Ссылка.ВерсияДанных КАК ВерсияДанных
		|ИЗ
		|	ВТОбъектыДляОбработки КАК ОбъектыДляОбработки";
	
	Запрос.Текст = СтрЗаменить(ТекстЗапроса, "ВТОбъектыДляОбработки", Результат.ИмяВременнойТаблицы);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			Блокировка.Заблокировать();
			
			СправочникОбъект = ОбновлениеИнформационнойБазыУТ.ПроверитьПолучитьОбъект(
				Выборка.Ссылка, Выборка.ВерсияДанных, Параметры.Очередь);
			Если СправочникОбъект = Неопределено Тогда
				
				ЗафиксироватьТранзакцию();
				Продолжить;
				
			КонецЕсли;
			
			Если СправочникОбъект.ОтборПоМатериалам.Количество()
				Или СправочникОбъект.ОтборПоВидамРабот.Количество()
				Или СправочникОбъект.ОтборПоПродукции.Количество() Тогда
				СправочникОбъект.ПредставлениеПравила = ПолучитьПредставлениеПравила(
					СправочникОбъект.ОтборПоМатериалам, СправочникОбъект.ОтборПоВидамРабот, 
					СправочникОбъект.ОтборПоПродукции, СправочникОбъект.БазаРаспределения);
			КонецЕсли;
			
			СправочникОбъект.Устаревшее = Истина;
			ОбновлениеИнформационнойБазы.ЗаписатьОбъект(СправочникОбъект);
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ОбновлениеИнформационнойБазыУТ.СообщитьОНеудачнойОбработке(ИнформацияОбОшибке(), Выборка.Ссылка);
			
			ВызватьИсключение;
			
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

//-- НЕ УТ 

// Регистрирует данные для обработчика обновления.
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	Статьи.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.СпособыРаспределенияПоНаправлениямДеятельности КАК СпособыРаспределения
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ПланВидовХарактеристик.СтатьиРасходов КАК Статьи
	|		ПО СпособыРаспределения.Ссылка = Статьи.УдалитьСпособРаспределенияПоНаправлениямДеятельности
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПравилаРаспределенияРасходов КАК ПравилаРаспределенияРасходов
	|		ПО (ПравилаРаспределенияРасходов.УдалитьСпособРаспределения = СпособыРаспределения.Ссылка)
	|ГДЕ
	|	ПравилаРаспределенияРасходов.Ссылка ЕСТЬ NULL
	|	И (Статьи.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаНаправленияДеятельности)
	|		ИЛИ Статьи.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаНаправленияДеятельности))
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	СтатьиРасходов.Ссылка
	|ИЗ
	|	ПланВидовХарактеристик.СтатьиРасходов КАК СтатьиРасходов
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ПравилаРаспределенияРасходов КАК ПравилаРаспределенияРасходов
	|		ПО СтатьиРасходов.УдалитьСтатьяРасходов = ПравилаРаспределенияРасходов.СтатьяСписанияРБП
	|ГДЕ
	|	НЕ СтатьиРасходов.УдалитьСтатьяРасходов = ЗНАЧЕНИЕ(ПланВидовХарактеристик.СтатьиРасходов.ПустаяСсылка)
	|	И ПравилаРаспределенияРасходов.Ссылка ЕСТЬ NULL
	|	И (СтатьиРасходов.ВариантРаспределенияРасходовРегл = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаРасходыБудущихПериодов)
	|		ИЛИ СтатьиРасходов.ВариантРаспределенияРасходовУпр = ЗНАЧЕНИЕ(Перечисление.ВариантыРаспределенияРасходов.НаРасходыБудущихПериодов))
	|";
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка"));
	
КонецПроцедуры

// Обработка данных для перехода на новую версию.
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяОбъекта = "ПланВидовХарактеристик.СтатьиРасходов";
	
	НовыеПравила = Новый Соответствие;
	
	ДопПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыВыборкиДанныхДляОбработки();
	ОбновлениеИнформационнойБазы.УстановитьИсточникДанных(ДопПараметры, "УдалитьСпособРаспределенияПоНаправлениямДеятельности");
	ОбновлениеИнформационнойБазы.УстановитьИсточникДанных(ДопПараметры, "УдалитьСтатьяРасходов");
	
	Выборка = ОбновлениеИнформационнойБазы.ВыбратьСсылкиДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта, ДопПараметры);
		
	Пока Выборка.Следующий() Цикл
		
		НачатьТранзакцию();
		
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировки.УстановитьЗначение("Ссылка", Выборка.Ссылка);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			Блокировка.Заблокировать();
			
			ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Выборка.Ссылка, 
				"УдалитьСпособРаспределенияПоНаправлениямДеятельности, УдалитьСтатьяРасходов, УдалитьСтатьяРасходов.Наименование, 
				|ВариантРаспределенияРасходовРегл, ВариантРаспределенияРасходовУпр");
			
			Если Не НовыеПравила.Получить(ЗначенияРеквизитов.УдалитьСпособРаспределенияПоНаправлениямДеятельности) = Неопределено
				Или Не НовыеПравила.Получить(ЗначенияРеквизитов.УдалитьСтатьяРасходов) = Неопределено Тогда
				
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Выборка.Ссылка);
				ЗафиксироватьТранзакцию();
				Продолжить;
				
			КонецЕсли;
			
			Если ЗначениеЗаполнено(ЗначенияРеквизитов.УдалитьСпособРаспределенияПоНаправлениямДеятельности)
				И (ЗначенияРеквизитов.ВариантРаспределенияРасходовРегл = Перечисления.ВариантыРаспределенияРасходов.НаНаправленияДеятельности
					Или ЗначенияРеквизитов.ВариантРаспределенияРасходовУпр = Перечисления.ВариантыРаспределенияРасходов.НаНаправленияДеятельности) Тогда
				
				Запрос = Новый Запрос;
				Запрос.Текст = 
					"ВЫБРАТЬ
					|	ПравилаРаспределенияРасходов.Ссылка КАК Ссылка
					|ИЗ
					|	Справочник.ПравилаРаспределенияРасходов КАК ПравилаРаспределенияРасходов
					|ГДЕ
					|	ПравилаРаспределенияРасходов.УдалитьСпособРаспределения = &УдалитьСпособРаспределения";
				
				Запрос.УстановитьПараметр("УдалитьСпособРаспределения", 
					ЗначенияРеквизитов.УдалитьСпособРаспределенияПоНаправлениямДеятельности);
				
				Если Запрос.Выполнить().Пустой() Тогда
				
					Запрос = Новый Запрос;
					Запрос.Текст = 
						"ВЫБРАТЬ
						|	СпособыРаспределенияПоНаправлениямДеятельности.НаправленияДеятельности.(
						|		НаправлениеДеятельности КАК НаправлениеДеятельности,
						|		Коэффициент КАК Коэффициент
						|	) КАК НаправленияДеятельности,
						|	СпособыРаспределенияПоНаправлениямДеятельности.ПравилоРаспределения КАК ПравилоРаспределения,
						|	СпособыРаспределенияПоНаправлениямДеятельности.Наименование КАК Наименование
						|ИЗ
						|	Справочник.СпособыРаспределенияПоНаправлениямДеятельности КАК СпособыРаспределенияПоНаправлениямДеятельности
						|ГДЕ
						|	СпособыРаспределенияПоНаправлениямДеятельности.Ссылка = &Ссылка";
					
					Запрос.УстановитьПараметр("Ссылка", ЗначенияРеквизитов.УдалитьСпособРаспределенияПоНаправлениямДеятельности);
					
					Результат = Запрос.Выполнить();
					РеквизитыСпособаРаспределения = Результат.Выбрать();
					РеквизитыСпособаРаспределения.Следующий();
					
					НовоеПравило = Справочники.ПравилаРаспределенияРасходов.СоздатьЭлемент();
					НовоеПравило.Наименование = РеквизитыСпособаРаспределения.Наименование;
					НовоеПравило.НазначениеПравила = Перечисления.НазначениеПравилРаспределенияРасходов.РаспределениеРасходовНаФинансовыйРезультат;
					НовоеПравило.УдалитьСпособРаспределения = ЗначенияРеквизитов.УдалитьСпособРаспределенияПоНаправлениямДеятельности;
					
					Если РеквизитыСпособаРаспределения.ПравилоРаспределения = Перечисления.ПравилаРаспределенияПоНаправлениямДеятельности.ПропорциональноВаловойПрибыли Тогда
						НовоеПравило.БазаРаспределенияПоПартиям = Перечисления.ТипыБазыРаспределенияРасходов.ВаловаяПрибыль;
					ИначеЕсли РеквизитыСпособаРаспределения.ПравилоРаспределения = Перечисления.ПравилаРаспределенияПоНаправлениямДеятельности.ПропорциональноДоходам Тогда
						НовоеПравило.БазаРаспределенияПоПартиям = Перечисления.ТипыБазыРаспределенияРасходов.ВыручкаОтПродаж;
					ИначеЕсли РеквизитыСпособаРаспределения.ПравилоРаспределения = Перечисления.ПравилаРаспределенияПоНаправлениямДеятельности.ПропорциональноРасходам Тогда
						НовоеПравило.БазаРаспределенияПоПартиям = Перечисления.ТипыБазыРаспределенияРасходов.СебестоимостьПродаж;
					ИначеЕсли РеквизитыСпособаРаспределения.ПравилоРаспределения = Перечисления.ПравилаРаспределенияПоНаправлениямДеятельности.ПропорциональноКоэффициентам Тогда
						
						НовоеПравило.БазаРаспределенияПоПартиям = Неопределено;
						НовоеПравило.НаправлениеРаспределения = Перечисления.НаправлениеРаспределенияПоПодразделениям.ПоКоэффициентам;
						НаправленияДеятельности = РеквизитыСпособаРаспределения.НаправленияДеятельности.Выгрузить();
						Для Каждого ДанныеНД Из НаправленияДеятельности Цикл
							
							НоваяСтрока = НовоеПравило.НаправленияДеятельности.Добавить();
							НоваяСтрока.НаправлениеДеятельности = ДанныеНД.НаправлениеДеятельности;
							НоваяСтрока.ДоляСтоимости = ДанныеНД.Коэффициент;
							
						КонецЦикла;
						
					КонецЕсли;
				
					ОбновлениеИнформационнойБазы.ЗаписатьОбъект(НовоеПравило);
					
				КонецЕсли;
				
			КонецЕсли;
			
			Если ЗначениеЗаполнено(ЗначенияРеквизитов.УдалитьСтатьяРасходов)
				И (ЗначенияРеквизитов.ВариантРаспределенияРасходовРегл = Перечисления.ВариантыРаспределенияРасходов.НаРасходыБудущихПериодов
					Или ЗначенияРеквизитов.ВариантРаспределенияРасходовУпр = Перечисления.ВариантыРаспределенияРасходов.НаРасходыБудущихПериодов) Тогда
				Запрос = Новый Запрос;
				Запрос.Текст = 
					"ВЫБРАТЬ
					|	ПравилаРаспределенияРасходов.Ссылка КАК Ссылка
					|ИЗ
					|	Справочник.ПравилаРаспределенияРасходов КАК ПравилаРаспределенияРасходов
					|ГДЕ
					|	ПравилаРаспределенияРасходов.СтатьяСписанияРБП = &СтатьяСписанияРБП";
				
				Запрос.УстановитьПараметр("СтатьяСписанияРБП", 
					ЗначенияРеквизитов.УдалитьСтатьяРасходов);
				
				Если Запрос.Выполнить().Пустой() Тогда
				
					НовоеПравило = Справочники.ПравилаРаспределенияРасходов.СоздатьЭлемент();
					НовоеПравило.Наименование = ЗначенияРеквизитов.УдалитьСтатьяРасходовНаименование;
					НовоеПравило.НазначениеПравила = Перечисления.НазначениеПравилРаспределенияРасходов.РаспределениеРасходовНаРБП;
					НовоеПравило.КоличествоМесяцев = 3;
					НовоеПравило.БазаРаспределенияРБП = Перечисления.ПравилаРаспределенияРБП.ПоМесяцам;
					НовоеПравило.НачалоПериода = "СДатыВозникновения";
					НовоеПравило.СтатьяСписанияРБП = ЗначенияРеквизитов.УдалитьСтатьяРасходов;
					
					ОбновлениеИнформационнойБазы.ЗаписатьОбъект(НовоеПравило);
					
				КонецЕсли;
				
			КонецЕсли;
			
			ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(Выборка.Ссылка);
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			
			ОбновлениеИнформационнойБазыУТ.СообщитьОНеудачнойОбработке(ИнформацияОбОшибке(), Выборка.Ссылка);
			
			ВызватьИсключение;
			
		КонецПопытки;
		
	КонецЦикла;
	
	Параметры.ОбработкаЗавершена = Не ОбновлениеИнформационнойБазы.ЕстьДанныеДляОбработки(Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
