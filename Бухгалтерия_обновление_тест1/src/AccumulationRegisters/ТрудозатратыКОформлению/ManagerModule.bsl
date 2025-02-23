#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

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
	Обработчик.Версия = "2.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "РегистрыНакопления.ТрудозатратыКОформлению.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("d2a1ad50-f155-41be-9fb4-db60e08f4ca7");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ТрудозатратыКОформлению.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = ""
		+ "Документ.ВыработкаСотрудников";
	Обработчик.ИзменяемыеОбъекты = "РегистрНакопления.ТрудозатратыКОформлению";
	Обработчик.БлокируемыеОбъекты = "";
	Обработчик.Комментарий = НСтр("ru='Заполняет новое поле ""Подразделение"" в регистре ""Трудозатраты к оформлению"".';uk='Заповнює нове поле ""Підрозділ"" у регістрі ""Трудовитрати до оформлення"".'");
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВыработкаСотрудников.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	
	
КонецПроцедуры 

// Заполняет новое поле "Подразделение" в регистре накопления "Трудозатраты к оформлению".
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ИмяРегистра = "ТрудозатратыКОформлению";
	ПолноеИмяРегистра = "РегистрНакопления.ТрудозатратыКОформлению";
	
	СписокДокументов = Новый Массив;
	СписокДокументов.Добавить("Документ.ВыработкаСотрудников");
	
	Для Каждого ПолноеИмяДокумента Из СписокДокументов Цикл
		
		ИмяДокумента = СтрРазделить(ПолноеИмяДокумента, ".")[1];
		ТекстЗапросаМеханизмаПроведения = Документы[ИмяДокумента].АдаптированныйТекстЗапросаДвиженийПоРегистру(ИмяРегистра);
		Регистраторы = ОбновлениеИнформационнойБазыУТ.РегистраторыДляПерепроведения(
			ТекстЗапросаМеханизмаПроведения, 
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

// Заполняет новое поле "Подразделение" в регистре накопления "Трудозатраты к оформлению".
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Регистраторы = Новый Массив;
	Регистраторы.Добавить("Документ.ВыработкаСотрудников");
	
	ОбработкаЗавершена = ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
		Регистраторы, 
		"РегистрНакопления.ТрудозатратыКОформлению", 
		Параметры.Очередь
	);
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры


#КонецОбласти

#КонецОбласти

#КонецЕсли