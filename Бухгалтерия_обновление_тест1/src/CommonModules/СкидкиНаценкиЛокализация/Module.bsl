
#Область ПрограммныйИнтерфейс

// Параметры:
// 	Объект 	- ДанныеФормыСтруктура - должна содержать:
// 				* Ссылка - ДокументСсылка.КоммерческоеПредложениеКлиенту
//			- ДокументОбъект - ДокументОбъект.КоммерческоеПредложениеКлиенту
Процедура ПриРасчетеСкидокНаценок(Объект, ВходныеПараметры, РезультатРасчета) Экспорт
	
	Если ТипЗнч(Объект.Ссылка) = Тип("ДокументСсылка.КоммерческоеПредложениеКлиенту") Тогда
		
		РезультатРасчета = РассчитатьПоКоммерческомуПредложениюКлиенту(Объект, ВходныеПараметры);
		
	КонецЕсли;
	
КонецПроцедуры

// Параметры:
// 	Объект 	- ДанныеФормыСтруктура - должна содержать:
// 				* Ссылка - ДокументСсылка.КоммерческоеПредложениеКлиенту
//			- ДокументОбъект - ДокументОбъект.КоммерческоеПредложениеКлиенту
Процедура ПриПримененииРезультатовРасчета(Объект, ПримененныеСкидки, РеализацияСверхЗаказа) Экспорт
	
	Если ТипЗнч(Объект.Ссылка) = Тип("ДокументСсылка.КоммерческоеПредложениеКлиенту") Тогда
		
		ПрименитьРезультатРасчетаККоммерческомуПредложениюКлиенту(Объект, ПримененныеСкидки);
		
	КонецЕсли;
	
КонецПроцедуры


// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - должна содержать:
// 		* Объект - ДанныеФормыСтруктура - должна содержать:
// 			** Ссылка - ДокументСсылка.КоммерческоеПредложениеКлиенту
// 	ИмяКоличества - Строка - изменяемый параметр
//
Процедура ПриПодготовкеПомещенияРезультатаРасчетаРучныхСкидокВоВременноеХранилище(Форма, ИмяКоличества) Экспорт
	
	Если ТипЗнч(Форма) = Тип("ФормаКлиентскогоПриложения")
		И ТипЗнч(Форма.Объект) = Тип("ДанныеФормыСтруктура")
		И Форма.Объект.Свойство("Ссылка") Тогда
			
		Если ТипЗнч(Форма.Объект.Ссылка) = Тип("ДокументСсылка.КоммерческоеПредложениеКлиенту") Тогда
		
			ИмяКоличества = "Количество";
			
		КонецЕсли;

	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Выполняет расчет скидок по коммерческому предложению клиенту.
//
// Параметры:
//  Объект - ДокументОбъект, ДанныеФормыСтруктура - Объект, в котором требуется рассчитать скидки (наценки).
//  ВходныеПараметры - Структура - Структура со свойствами:
//   * ТолькоПредварительныйРасчет - Булево - Только предварительный расчет.
//   * ПрименятьКОбъекту - Булево - Применять к объекту.
//   * ВосстанавливатьУправляемыеСкидки - Булево - Восстанавливать управляемые скидки (наценки).
//   * УправляемыеСкидки - Массив - Управляемые скидки (наценки).
//
// Возвращаемое значение:
//  Структура - Структура со свойствами:
//   * ДеревоСкидок - ДеревоЗначений - Дерево скидок (наценок).
//   * ТаблицаСкидкиНаценки - ТаблицаЗначений - Таблица с рассчитанными скидками.
//   * ПараметрыРасчета - Структура - Структура параметров расчета.
//
Функция РассчитатьПоКоммерческомуПредложениюКлиенту(Объект, ВходныеПараметры) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	СкидкиНаценкиСервер.ЗаполнитьКлючиСвязиВТабличнойЧастиТовары(Объект, "Товары");
	
	ИспользоватьНаборы = Ложь;
	
	ИмяКолонкиУпаковка           = "ЕдиницаИзмерения";
	ИмяКолонкиКоличествоУпаковок = "Количество";
	
	Если ВходныеПараметры.Свойство("ИмяКолонкиУпаковка") Тогда
		ИмяКолонкиУпаковка = "Товары." + ВходныеПараметры.ИмяКолонкиУпаковка;
	КонецЕсли;
	
	Если ВходныеПараметры.Свойство("ИмяКолонкиКоличествоУпаковок") Тогда
		 ИмяКолонкиКоличествоУпаковок = "Товары." + ИмяКолонкиКоличествоУпаковок;
	КонецЕсли;
	
	// Обработка табличной части "Товары".
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Товары.КлючСвязи                                    КАК КлючСвязи,
	|	Товары.Номенклатура                                 КАК Номенклатура,
	|	Товары.Характеристика                               КАК Характеристика,
	|	&ТоварыУпаковка                                     КАК Упаковка,
	|	ЗНАЧЕНИЕ(Справочник.СерииНоменклатуры.ПустаяСсылка) КАК Серия,
	|	ЗНАЧЕНИЕ(Справочник.Склады.ПустаяСсылка)            КАК Склад,
	|	Товары.ВидЦены                                      КАК ВидЦены,
	|	Товары.Количество                                   КАК Количество,
	|	&ТоварыКоличествоУпаковок                           КАК КоличествоУпаковок,
	|	Товары.Цена                                         КАК Цена,
	|	Товары.Цена * &ТоварыКоличествоУпаковок             КАК Сумма
	|ПОМЕСТИТЬ ВТТовары
	|ИЗ
	|	&Товары КАК Товары
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Таблица.КлючСвязи,
	|	%Поля%
	|	Таблица.Номенклатура,
	|	Таблица.Характеристика,
	|	Таблица.Упаковка,
	|	Таблица.Серия,
	|	Таблица.Склад,
	|	Таблица.ВидЦены,
	|	СправочникНоменклатура.ЦеноваяГруппа КАК ЦеноваяГруппа,
	|	Таблица.Количество,
	|	Таблица.КоличествоУпаковок,
	|	Таблица.Цена,
	|	Таблица.Сумма
	|%ИмяВременнойТаблицы%
	|ИЗ
	|	ВТТовары КАК Таблица
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
	|		ПО СправочникНоменклатура.Ссылка = Таблица.Номенклатура
	|		%Соединение%
	|";
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТоварыУпаковка",           ИмяКолонкиУпаковка);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТоварыКоличествоУпаковок", ИмяКолонкиКоличествоУпаковок);
	
	ТаблицаТовары = Объект.Товары.Выгрузить();

	ПараметрыЗапроса = Новый Структура;
	ПараметрыЗапроса.Вставить("Товары", ТаблицаТовары);
	ДанныеПоТоварамИНаборам = СкидкиНаценкиСервер.ДанныеПоТоварамИНаборам(ТекстЗапроса, ПараметрыЗапроса, ИспользоватьНаборы);
	
	ПараметрыСкидокДляОптовойТорговли = Новый Структура;
	ПараметрыСкидокДляОптовойТорговли.Вставить("НеИспользоватьСоглашенияСКлиентами", Истина);
	
	СкидкиНаценки = СкидкиНаценкиСервер.СкидкиНаценкиДляОптовойТорговли(
		Объект.Дата,
		Справочники.Склады.ПустаяСсылка(),
		Справочники.СоглашенияСКлиентами.ПустаяСсылка(),
		Объект.КартаЛояльности);
	
	ПараметрыРасчета = СкидкиНаценкиСервер.ПараметрыРасчета();
	ПараметрыРасчета.СкидкиНаценки = СкидкиНаценки;
	ПараметрыРасчета.Партнер       = Объект.Клиент;
	ПараметрыРасчета.Регистратор   = Объект.Ссылка;
	
	// Для скидки "За время продажи".
	ПараметрыРасчета.ДеньНедели   = Перечисления.ДниНедели.Получить(ДеньНедели(Объект.Дата) - 1);
	ПараметрыРасчета.ТекущееВремя = СкидкиНаценкиСервер.ПолучитьТекущееВремяОбъекта(Объект);
	ПараметрыРасчета.ТекущаяДата  = СкидкиНаценкиСервер.ПолучитьТекущуюДатуОбъекта(Объект);
	
	// Карты лояльности
	ПараметрыРасчета.КартаЛояльности = Объект.КартаЛояльности;
	
	ПараметрыРасчета.Товары                     = ДанныеПоТоварамИНаборам.Товары;
	ПараметрыРасчета.ВалютаДокумента            = Объект.Валюта;
	ПараметрыРасчета.ВалютаУправленческогоУчета = Константы.ВалютаУправленческогоУчета.Получить();
	ПараметрыРасчета.Пользователь               = Объект.Менеджер;
	ПараметрыРасчета.Объект                     = Объект;
	
	СкидкиНаценкиСервер.ПодготовитьДанныеОВыбранныхУправляемыхСкидках(Объект, ПараметрыРасчета, ВходныеПараметры);
	ПримененныеСкидкиНаценки = СкидкиНаценкиСервер.РассчитатьДеревоСкидокНаценок(ПараметрыРасчета, ВходныеПараметры);
	
	Если ВходныеПараметры.ПрименятьКОбъекту Тогда
		
		ПрименитьРезультатРасчетаККоммерческомуПредложениюКлиенту(Объект, ПримененныеСкидкиНаценки);
		
	КонецЕсли;
	
	Возврат ПримененныеСкидкиНаценки;
	
КонецФункции

Процедура ПрименитьРезультатРасчетаККоммерческомуПредложениюКлиенту(Объект, ПримененныеСкидкиНаценки)
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяКолонкиКоличество",             "Количество");
	СкидкиНаценкиСервер.ПрименитьРезультатРасчетаКОбъекту(Объект, "Товары", ПримененныеСкидкиНаценки, Истина,,,ДополнительныеПараметры);
	
КонецПроцедуры

#КонецОбласти
