#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)";

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
    Обработчик.Версия = "3.5.4.400";
	Обработчик.РежимВыполнения = "Отложенно";
	Обработчик.Процедура = "РегистрыНакопления.ДенежныеСредстваКВыплате.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ДенежныеСредстваКВыплате.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("ffe2b44a-3979-4174-b811-9f5e40369b58");
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "Документ.РасходныйКассовыйОрдер,"
		+ "Документ.ПриходныйКассовыйОрдер,"
		+ "Документ.ЗаявкаНаРасходованиеДенежныхСредств,"
		+ "Документ.ПоступлениеБезналичныхДенежныхСредств,"
		+ "Документ.ОперацияПоПлатежнойКарте,"
		+ "Документ.СписаниеБезналичныхДенежныхСредств";
	Обработчик.ИзменяемыеОбъекты = "РегистрНакопления.ДенежныеСредстваКВыплате";
	Обработчик.БлокируемыеОбъекты = "";
	Обработчик.Комментарий = НСтр("ru='Перезаполняет регистр ""Денежные средства к выплате""';uk='Перезаповнює регістр ""Грошові кошти до виплати""'");
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ОперацияПоПлатежнойКарте.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.РасходныйКассовыйОрдер.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПоступлениеБезналичныхДенежныхСредств.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ЗаявкаНаРасходованиеДенежныхСредств.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПриходныйКассовыйОрдер.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыСведений.ГрафикПлатежей.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.СписаниеБезналичныхДенежныхСредств.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
    
КонецПроцедуры

Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ИмяРегистра       = "ДенежныеСредстваКВыплате";
	ПолноеИмяРегистра = "РегистрНакопления." + ИмяРегистра;
	
	Регистраторы = Новый Массив;
	Регистраторы.Добавить("Документ.ЗаявкаНаРасходованиеДенежныхСредств");
	Регистраторы.Добавить("Документ.РаспоряжениеНаПеремещениеДенежныхСредств");
	Регистраторы.Добавить("Документ.СписаниеБезналичныхДенежныхСредств");
	Регистраторы.Добавить("Документ.РасходныйКассовыйОрдер");
	Регистраторы.Добавить("Документ.ОперацияПоПлатежнойКарте");
	Регистраторы.Добавить("Документ.ПриходныйКассовыйОрдер");
	Регистраторы.Добавить("Документ.ПоступлениеБезналичныхДенежныхСредств");
	
	Для каждого Регистратор из Регистраторы Цикл
		Менеджер = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(Регистратор);
		ТекстЗапроса = Менеджер.АдаптированныйТекстЗапросаДвиженийПоРегистру(ИмяРегистра);
		ДокументыКПерепроведению = ОбновлениеИнформационнойБазыУТ.РегистраторыДляПерепроведения(ТекстЗапроса, ПолноеИмяРегистра, Регистратор);
		ОбновлениеИнформационнойБазы.ОтметитьРегистраторыКОбработке(Параметры, ДокументыКПерепроведению, ПолноеИмяРегистра);
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ОбработкаЗавершена = Ложь;
	
	Регистраторы = Новый Массив;
	Регистраторы.Добавить("Документ.ЗаявкаНаРасходованиеДенежныхСредств");
	Регистраторы.Добавить("Документ.РаспоряжениеНаПеремещениеДенежныхСредств");
	
	ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
		Регистраторы,
		"РегистрНакопления.ДенежныеСредстваКВыплате",
		Параметры.Очередь);
		
	ВыборкаЗаявок = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(
		Параметры.Очередь,
		"Документ.ЗаявкаНаРасходованиеДенежныхСредств",
		"РегистрНакопления.ДенежныеСредстваКВыплате"
    );
		
	ВыборкаРаспоряжений = ОбновлениеИнформационнойБазы.ВыбратьРегистраторыРегистраДляОбработки(
		Параметры.Очередь,
		"Документ.ЗаявкаНаРасходованиеДенежныхСредств",
		"РегистрНакопления.ДенежныеСредстваКВыплате"
    );
		
	Если Не ВыборкаЗаявок.Следующий() И Не ВыборкаРаспоряжений.Следующий() Тогда
		
		Регистраторы = Новый Массив;
		Регистраторы.Добавить("Документ.СписаниеБезналичныхДенежныхСредств");
		Регистраторы.Добавить("Документ.РасходныйКассовыйОрдер");
		Регистраторы.Добавить("Документ.ОперацияПоПлатежнойКарте");
		Регистраторы.Добавить("Документ.ПриходныйКассовыйОрдер");
		Регистраторы.Добавить("Документ.ПоступлениеБезналичныхДенежныхСредств");
		
		ОбработкаЗавершена = ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
			Регистраторы,
			"РегистрНакопления.ДенежныеСредстваКВыплате",
			Параметры.Очередь
        );   
        
	КонецЕсли;
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти


#КонецЕсли