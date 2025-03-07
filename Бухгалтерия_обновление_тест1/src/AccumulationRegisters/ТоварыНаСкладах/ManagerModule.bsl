#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Склад)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

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

	Обработчик = Обработчики.Добавить();
	Обработчик.Процедура = "РегистрыНакопления.ТоварыНаСкладах.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("1f719698-998f-4fef-9577-58d12a2f55a0");
	Обработчик.Многопоточный = Истина;
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ТоварыНаСкладах.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.Комментарий = НСтр("ru='Обновляет движения документов информационной базы по регистру накопления ""Товары на складах"".
|До завершения обработчика работа с документами не рекомендуется, т.к. информация в регистре некорректна.'
|;uk='Оновлює рухи документів інформаційної бази за регістром накопичення ""Товари на складах"". 
|До завершення обробника робота з документами не рекомендується, тому що інформація в регістрі некоректна.'");
	
	Читаемые = Новый Массив;
	Читаемые.Добавить(Метаданные.Документы.АктОРасхожденияхПослеОтгрузки.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.АктОРасхожденияхПослеПеремещения.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.АктОРасхожденияхПослеПриемки.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ВнутреннееПотреблениеТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ВозвратТоваровОтКлиента.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ВозвратТоваровПоставщику.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ОприходованиеИзлишковТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ОрдерНаОтражениеИзлишковТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ОрдерНаОтражениеНедостачТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ОрдерНаОтражениеПересортицыТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ОрдерНаОтражениеПорчиТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ОрдерНаПеремещениеТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ОтчетОРозничныхПродажах.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПеремещениеТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПересортицаТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПорчаТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПриобретениеТоваровУслуг.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПриходныйОрдерНаТовары.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПрочееОприходованиеТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.РасходныйОрдерНаТовары.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.РеализацияТоваровУслуг.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.СборкаТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.СписаниеНедостачТоваров.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЧекККМ.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ЧекККМВозврат.ПолноеИмя());
	Читаемые.Добавить(Метаданные.РегистрыНакопления.ТоварыНаСкладах.ПолноеИмя());
	//++ НЕ УТ
	Читаемые.Добавить(Метаданные.Документы.ВозвратМатериаловИзПроизводства.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ВозвратСырьяОтПереработчика.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ВыпускПродукции.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПередачаМатериаловВПроизводство.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПередачаСырьяПереработчику.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.ПоступлениеОтПереработчика.ПолноеИмя());
	Читаемые.Добавить(Метаданные.Документы.РаспределениеПроизводственныхЗатрат.ПолноеИмя());
	//-- НЕ УТ
	Обработчик.ЧитаемыеОбъекты = СтрСоединить(Читаемые, ",");
	
	Изменяемые = Новый Массив;
	Изменяемые.Добавить(Метаданные.РегистрыНакопления.ТоварыНаСкладах.ПолноеИмя());
	Обработчик.ИзменяемыеОбъекты = СтрСоединить(Изменяемые, ",");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.АктОРасхожденияхПослеОтгрузки.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.АктОРасхожденияхПослеПриемки.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВозвратТоваровОтКлиента.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВозвратТоваровПоставщику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";



	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ОтчетОРозничныхПродажах.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";


	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПеремещениеТоваров.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПриобретениеТоваровУслуг.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.РеализацияТоваровУслуг.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.СборкаТоваров.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЧекККМ.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЧекККМВозврат.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ТоварыОрганизаций.СгенерироватьДокументыДляПереброскиОстатковСПустогоНазначенияПоДавальческойСхеме";
	НоваяСтрока.Порядок = "До";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ТоварыОрганизаций.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";
	
	//++ НЕ УТ
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПередачаМатериаловВПроизводство.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	//-- НЕ УТ
	

КонецПроцедуры

// Параметры:
// 	Параметры - см. ОбновлениеИнформационнойБазы.ОсновныеПараметрыОтметкиКОбработке
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра	= "РегистрНакопления.ТоварыНаСкладах";
	ИмяРегистра			= "ТоварыНаСкладах";
	
	СписокДокументов = ДокументыКОбновлению();
	
	ДопПараметры = ПроведениеДокументов.ДопПараметрыИнициализироватьДанныеДокументаДляПроведения();
	ДопПараметры.ПолучитьТекстыЗапроса = Истина;
	
	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.ПолныеИменаОбъектов = СтрСоединить(СписокДокументов, ",");
	ПараметрыВыборки.ПолныеИменаРегистров = ПолноеИмяРегистра;
	ПараметрыВыборки.ПоляУпорядочиванияПриРаботеПользователей.Добавить("Регистратор.Дата УБЫВ");
	ПараметрыВыборки.ПоляУпорядочиванияПриОбработкеДанных.Добавить("Регистратор");
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиРегистраторыРегистра();
	
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПеремещениеТоваровТовары.Ссылка
	|ИЗ
	|	Документ.ПеремещениеТоваров.Товары КАК ПеремещениеТоваровТовары
	|ГДЕ
	|	ПеремещениеТоваровТовары.СтатусУказанияСерий = 6
	|	И ПеремещениеТоваровТовары.СтатусУказанияСерийОтправитель = 5
	//++ НЕ УТ
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ПередачаМатериаловВПроизводствоТовары.Ссылка
	|ИЗ
	|	Документ.ПередачаМатериаловВПроизводство.Товары КАК ПередачаМатериаловВПроизводствоТовары
	|ГДЕ
	|	ПередачаМатериаловВПроизводствоТовары.СтатусУказанияСерий = 6
	|	И ПередачаМатериаловВПроизводствоТовары.СтатусУказанияСерийОтправитель = 5
	//-- НЕ УТ
	|";
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
		Параметры, 
		Регистраторы, 
		ПолноеИмяРегистра
	);
	
	
	Для Каждого ПолноеИмяДокумента Из СписокДокументов Цикл
		ИмяДокумента	= СтрРазделить(ПолноеИмяДокумента, ".")[1];
		ТекстыЗапроса	= Документы[ИмяДокумента].ДанныеДокументаДляПроведения(Неопределено, ИмяРегистра, ДопПараметры);
		Регистраторы	= ПроведениеДокументов.РегистраторыДляПерепроведения(
			ТекстыЗапроса,
			ПолноеИмяРегистра,
			ПолноеИмяДокумента
		);
		
		ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
			Параметры, 
			Регистраторы, 
			ПолноеИмяРегистра
		);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ТоварыНаСкладах";
	
	ДополнительныеПараметры = ОбновлениеИнформационнойБазыУТ.ДополнительныеПараметрыПерезаписиДвиженийИзОчереди();
	ДополнительныеПараметры.ОбновляемыеДанные = Параметры.ОбновляемыеДанные;
	
	СписокДокументов = ДокументыКОбновлению();
	
	ОбработкаЗавершена = ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
		СписокДокументов,
		ПолноеИмяРегистра,
		Параметры.Очередь,
		ДополнительныеПараметры
	);
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры

Функция ДокументыКОбновлению()
	СписокДокументов = Новый Массив;
	СписокДокументов.Добавить("Документ.АктОРасхожденияхПослеОтгрузки");
	СписокДокументов.Добавить("Документ.АктОРасхожденияхПослеПеремещения");
	СписокДокументов.Добавить("Документ.АктОРасхожденияхПослеПриемки");
	СписокДокументов.Добавить("Документ.ВнутреннееПотреблениеТоваров");
	СписокДокументов.Добавить("Документ.ВозвратТоваровОтКлиента");
	СписокДокументов.Добавить("Документ.ВозвратТоваровПоставщику");
	СписокДокументов.Добавить("Документ.ОприходованиеИзлишковТоваров");
	СписокДокументов.Добавить("Документ.ОрдерНаОтражениеИзлишковТоваров");
	СписокДокументов.Добавить("Документ.ОрдерНаОтражениеНедостачТоваров");
	СписокДокументов.Добавить("Документ.ОрдерНаОтражениеПересортицыТоваров");
	СписокДокументов.Добавить("Документ.ОрдерНаОтражениеПорчиТоваров");
	СписокДокументов.Добавить("Документ.ОрдерНаПеремещениеТоваров");
	СписокДокументов.Добавить("Документ.ОтчетОРозничныхПродажах");
	СписокДокументов.Добавить("Документ.ПеремещениеТоваров");
	СписокДокументов.Добавить("Документ.ПересортицаТоваров");
	СписокДокументов.Добавить("Документ.ПорчаТоваров");
	СписокДокументов.Добавить("Документ.ПриходныйОрдерНаТовары");
	СписокДокументов.Добавить("Документ.ПриобретениеТоваровУслуг");
	СписокДокументов.Добавить("Документ.ПрочееОприходованиеТоваров");
	СписокДокументов.Добавить("Документ.РасходныйОрдерНаТовары");
	СписокДокументов.Добавить("Документ.РеализацияТоваровУслуг");
	СписокДокументов.Добавить("Документ.СборкаТоваров");
	СписокДокументов.Добавить("Документ.СписаниеНедостачТоваров");
	СписокДокументов.Добавить("Документ.ЧекККМ");
	СписокДокументов.Добавить("Документ.ЧекККМВозврат");
	
	//++ НЕ УТ
	//++ Устарело_Производство21
	СписокДокументов.Добавить("Документ.ВозвратМатериаловИзПроизводства");
	СписокДокументов.Добавить("Документ.ВыпускПродукции");
	СписокДокументов.Добавить("Документ.ПередачаМатериаловВПроизводство");
	//-- Устарело_Производство21
	СписокДокументов.Добавить("Документ.ВозвратСырьяОтПереработчика");
	СписокДокументов.Добавить("Документ.ПередачаСырьяПереработчику");
	СписокДокументов.Добавить("Документ.ПоступлениеОтПереработчика");
	СписокДокументов.Добавить("Документ.РаспределениеПроизводственныхЗатрат");
	//-- НЕ УТ
	
	Возврат СписокДокументов
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли
