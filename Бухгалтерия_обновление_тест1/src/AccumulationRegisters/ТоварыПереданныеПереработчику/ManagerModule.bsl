#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

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
	Обработчик.Процедура = "РегистрыНакопления.ТоварыПереданныеПереработчику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("4ad4ee49-0370-4af4-b9bd-0edddf2c7622");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ТоварыПереданныеПереработчику.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "РегистрНакопления.ТоварыПереданныеПереработчику,"
		+ "Документ.ВводОстатков";
	Обработчик.ИзменяемыеОбъекты = "РегистрНакопления.ТоварыПереданныеПереработчику";
	Обработчик.БлокируемыеОбъекты = "";
	Обработчик.Комментарий = НСтр("ru='Обновление в регистре ""Товары переданные переработчику"" движений документа ""Ввод остатков"".';uk='Оновлення у регістрі ""Товари передані переробнику"" рухів документа ""Введення залишків"".'");
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВводОстатков.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПередачаСырьяПереработчику.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "Любой";
	
КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ТоварыПереданныеПереработчику";
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВводОстатков.Ссылка КАК Регистратор
	|ИЗ
	|	Документ.ВводОстатков КАК ВводОстатков
	|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ВводОстатков.Товары КАК ВводОстатковТовары
	|		ПО ВводОстатков.Ссылка = ВводОстатковТовары.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыПереданныеПереработчику КАК ТоварыПереданныеПереработчику
	|		ПО ВводОстатков.Ссылка = ТоварыПереданныеПереработчику.Регистратор
	|			И (ВводОстатковТовары.АналитикаУчетаНоменклатуры = ТоварыПереданныеПереработчику.АналитикаУчетаНоменклатуры)
	|ГДЕ
	|	ВводОстатков.УдалитьТипОперации = ЗНАЧЕНИЕ(Перечисление.УдалитьТипыОперацийВводаОстатков.ОстаткиМатериаловПереданныхПереработчикам)
	|	И ВводОстатков.ОтражатьВОперативномУчете
	|	И ВводОстатковТовары.Номенклатура.ТипНоменклатуры = ЗНАЧЕНИЕ(Перечисление.ТипыНоменклатуры.МногооборотнаяТара)
	|	И ТоварыПереданныеПереработчику.Регистратор ЕСТЬ NULL";
	
	ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(
		Параметры, 
		Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Регистратор"), 
		ПолноеИмяРегистра
	);
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ТоварыПереданныеПереработчику";
	
	Регистраторы = Новый Массив;
	Регистраторы.Добавить("Документ.ВводОстатков");
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
		Регистраторы, 
		ПолноеИмяРегистра, 
		Параметры.Очередь
	);
	
КонецПроцедуры


#КонецОбласти

#КонецЕсли