#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(ВидЗапасов.Организация)
	|	И ЗначениеРазрешено(ВидЗапасов.ВладелецТовара)";

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
	Обработчик.Процедура = "РегистрыНакопления.ТоварыКОформлениюОтчетовКомитенту.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("265d921b-0dfc-42aa-a661-436ca87b3055");
	Обработчик.ПроцедураЗаполненияДанныхОбновления = "РегистрыНакопления.ТоварыКОформлениюОтчетовКомитенту.ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию";
	Обработчик.ПроцедураПроверки = "ОбновлениеИнформационнойБазы.ДанныеОбновленыНаНовуюВерсиюПрограммы";
	Обработчик.ЧитаемыеОбъекты = "Справочник.ВидыЗапасов,"
		+ "РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту";
	Обработчик.ИзменяемыеОбъекты = "РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту";
	Обработчик.БлокируемыеОбъекты = "";
	Обработчик.Комментарий = НСтр("ru='Перезаписываются записи регистра накопления ""Товары к оформлению отчетов комитенту"" документов:
                                   |- ""Внутреннее потребление товаров"";
                                   |- ""Возврат товаров между организациями"";
                                   |- ""Отчет комиссионера"";
                                   |- ""Отчет комиссионера о списании"";
                                   |- ""Отчет комитенту"";
                                   |- ""Отчет комитенту о списании"";
                                   |- ""Отчет о розничных продажах"";
                                   |- ""Отчет по комиссии между организациями"";
                                   |- ""Отчет по комиссии между организациями о списании"";
                                   |- ""Передача материалов в производство"";
                                   |- ""Передача товаров между организациями"";
                                   |- ""Пересортица товаров"";
                                   |- ""Порча товаров"";
                                   |- ""Прочее оприходование товаров"";
                                   |- ""Реализация товаров и услуг"";
                                   |- ""Сборка товаров"";
                                   |- ""Списание недостач товаров"";
                                   |- ""Возврат материалов в производство"";
                                   |- ""Передача сырья переработчику"";
                                   |- ""Распределение производственных затрат"";
                                   |- ""Возврат сырья от переработчика"".'
                                   |;uk='Перезаписуються записи регістру накопичення ""Товари до оформлення звітів комітенту"" документів:
                                   |- ""Внутрішнє споживання товарів"";
                                   |- ""Повернення товарів між організаціями"";
                                   |- ""Звіт комісіонера"";
                                   |- ""Звіт комісіонера про списання"";
                                   |- ""Звіт комітенту"";
                                   |- ""Звіт комітенту про списання"";
                                   |- ""Звіт про роздрібні продажі"";
                                   |- ""Звіт по комісії між організаціями"";
                                   |- ""Звіт по комісії між організаціями про списання"";
                                   |- ""Передача матеріалів у виробництво"";
                                   |- ""Передача товарів між організаціями"";
                                   |- ""Пересортиця товарів"";
                                   |- ""Псування товарів"";
                                   |- ""Інше оприбуткування товарів"";
                                   |- ""Реалізація товарів та послуг"";
                                   |- ""Складання товарів"";
                                   |- ""Списання нестач товарів"";
                                   |- ""Повернення матеріалів у виробництво"";
                                   |- ""Передача сировини переробнику"";
                                   |- ""Розподіл виробничих витрат"";
                                   |- ""Повернення сировини від переробника"".'");
	
	Обработчик.ПриоритетыВыполнения = ОбновлениеИнформационнойБазы.ПриоритетыВыполненияОбработчика();

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "РегистрыНакопления.ПрочиеАктивыПассивы.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "До";

	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ВнутреннееПотреблениеТоваров.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.СборкаТоваров.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";

	//++ НЕ УТ
	НоваяСтрока = Обработчик.ПриоритетыВыполнения.Добавить();
	НоваяСтрока.Процедура = "Документы.ПередачаМатериаловВПроизводство.ОбработатьДанныеДляПереходаНаНовуюВерсию";
	НоваяСтрока.Порядок = "После";
	//-- НЕ УТ
	
КонецПроцедуры

// Обработчик обновления УТ 3.5.4
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ПолноеИмяРегистра = "РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту";
	ДополнительныеПараметры = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	ДополнительныеПараметры.ЭтоДвижения = Истина;
	ДополнительныеПараметры.ПолноеИмяРегистра = ПолноеИмяРегистра;
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДанныеРегистра.Регистратор КАК Ссылка
	|ПОМЕСТИТЬ ВтДанныеРегистра
	|ИЗ
	|	РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СборкаТоваров)
	|;
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Движения.Ссылка КАК Ссылка
	|ИЗ
	|	(ВЫБРАТЬ
	|		ВтДанныеРегистра.Ссылка
	|	ИЗ
	|		ВтДанныеРегистра КАК ВтДанныеРегистра
	|			ЛЕВОЕ СОЕДИНЕНИЕ Документ.СборкаТоваров КАК СборкаТоваров
	|			ПО ВтДанныеРегистра.Ссылка = СборкаТоваров.Ссылка
	|				И (ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.СборкаТоваров) <> СборкаТоваров.ХозяйственнаяОперация)
	|	ГДЕ
	|		НЕ СборкаТоваров.Ссылка ЕСТЬ NULL
	|
	//++ НЕ УТ
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		Движения.Регистратор КАК Ссылка
	|	ИЗ
	|		РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК Движения
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.ПередачаМатериаловВПроизводство КАК ПередачаМатериаловВПроизводство
	|			ПО ПередачаМатериаловВПроизводство.Ссылка = Движения.Регистратор
	|	ГДЕ
	|		Движения.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ПередачаМатериаловВПроизводство)
	//-- НЕ УТ
	|
	|	) КАК Движения
	|");
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(
		Параметры, 
		Регистраторы, 
		ДополнительныеПараметры
	);
	
	РегистрыНакопления.ПрочиеАктивыПассивы.ЗарегистироватьКОбновлениюУправленческогоБаланса(Параметры, Регистраторы, ДополнительныеПараметры.ПолноеИмяРегистра);
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ДД.Регистратор,
	|	ДД.ВидДвижения,
	|	ДД.ВидЗапасов,
	|	АналитикаВладельца.Ссылка КАК АналитикаУчетаНоменклатуры,
	|	ДД.Валюта,
	|	ДД.НомерГТД,
	|	СпрВидыЗапасов.ВидЗапасовВладельца КАК ВидЗапасовВладельца
	|ПОМЕСТИТЬ ДвиженияИнтеркампани
	|ИЗ
	|	РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК ДД
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.КлючиАналитикиУчетаНоменклатуры КАК Ключи
	|	ПО ДД.АналитикаУчетаНоменклатуры = Ключи.Ссылка
	|	
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.ВидыЗапасов КАК СпрВидыЗапасов
	|	ПО ДД.ВидЗапасов = СпрВидыЗапасов.Ссылка
	|
	|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.КлючиАналитикиУчетаНоменклатуры КАК АналитикаВладельца
	|	ПО АналитикаВладельца.Номенклатура = Ключи.Номенклатура
	|		И АналитикаВладельца.Характеристика = Ключи.Характеристика
	|		И АналитикаВладельца.Серия = Ключи.Серия
	|		И АналитикаВладельца.МестоХранения = СпрВидыЗапасов.ВидЗапасовВладельца.ВладелецТовара
	|		И АналитикаВладельца.СтатьяКалькуляции = Ключи.СтатьяКалькуляции
	|ГДЕ 
	|	ДД.ВидЗапасов.РеализацияЗапасовДругойОрганизации
	|	И ДД.ВидЗапасов.ВидЗапасовВладельца.ТипЗапасов = ЗНАЧЕНИЕ(Перечисление.ТипыЗапасов.КомиссионныйТовар)
	|;
	|//////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	КОбработке.Регистратор КАК Ссылка
	|ИЗ
	|	(ВЫБРАТЬ
	|		ТоварыКОформлению.Регистратор КАК Регистратор
	|	ИЗ
	|		РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК ТоварыКОформлению
	|	ГДЕ
	|		ТоварыКОформлению.ВидЗапасов.ТипЗапасов = ЗНАЧЕНИЕ(Перечисление.ТипыЗапасов.КомиссионныйТовар)
	|		И ТоварыКОформлению.КорВидЗапасов.ТипЗапасов = ЗНАЧЕНИЕ(Перечисление.ТипыЗапасов.Товар)
	|		И ТИПЗНАЧЕНИЯ(ТоварыКОформлению.Регистратор) <> ЗНАЧЕНИЕ(Документ.КорректировкаРегистров)
	|	СГРУППИРОВАТЬ ПО
	|		ТоварыКОформлению.Регистратор
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ
	|		ТоварыКОформлению.Регистратор
	|	ИЗ
	|		РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК ТоварыКОформлению
	|	ГДЕ
	|		ТИПЗНАЧЕНИЯ(ТоварыКОформлению.Регистратор) <> ЗНАЧЕНИЕ(Документ.КорректировкаРегистров)
	|	СГРУППИРОВАТЬ ПО
	|		ТоварыКОформлению.Регистратор
	|	ИМЕЮЩИЕ
	|		(СУММА(ТоварыКОформлению.КоличествоКОформлению) <> СУММА(ТоварыКОформлению.Количество)
	|			ИЛИ СУММА(ТоварыКОформлению.СуммаВыручкиКОформлению) <> СУММА(ТоварыКОформлению.СуммаВыручки)
	|			ИЛИ СУММА(ТоварыКОформлению.КоличествоСписаноКОформлению) <> СУММА(ТоварыКОформлению.КоличествоСписано))
	|
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		ДД.Регистратор
	|	ИЗ
	|		ДвиженияИнтеркампани КАК ДД
	|	
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК ДвиженияПоКомитенту
	|		ПО ДвиженияПоКомитенту.Регистратор = ДД.Регистратор
	|			И ДвиженияПоКомитенту.ВидДвижения = ДД.ВидДвижения
	|			И ДвиженияПоКомитенту.ВидЗапасов = ДД.ВидЗапасовВладельца
	|			И ДвиженияПоКомитенту.АналитикаУчетаНоменклатуры = ДД.АналитикаУчетаНоменклатуры
	|			И ДвиженияПоКомитенту.Валюта = ДД.Валюта
	|			И ДвиженияПоКомитенту.НомерГТД = ДД.НомерГТД
	|	ГДЕ
	|		ТИПЗНАЧЕНИЯ(ДД.Регистратор) <> ЗНАЧЕНИЕ(Документ.ОтчетПоКомиссииМеждуОрганизациями)
	|		И ТИПЗНАЧЕНИЯ(ДД.Регистратор) <> ЗНАЧЕНИЕ(Документ.ОтчетПоКомиссииМеждуОрганизациямиОСписании)
	|		И ТИПЗНАЧЕНИЯ(ДД.Регистратор) <> ЗНАЧЕНИЕ(Документ.КорректировкаРегистров)
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|
	|	ВЫБРАТЬ РАЗЛИЧНЫЕ
	|		ДД.Регистратор
	|	ИЗ
	|		ДвиженияИнтеркампани КАК ДД
	|	
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту КАК ДвиженияПоКомитенту
	|		ПО ДвиженияПоКомитенту.Регистратор = ДД.Регистратор
	|			И ДвиженияПоКомитенту.ВидДвижения = ЗНАЧЕНИЕ(ВидДвиженияНакопления.Приход)
	|			И ДвиженияПоКомитенту.ВидЗапасов = ДД.ВидЗапасовВладельца
	|			И ДвиженияПоКомитенту.АналитикаУчетаНоменклатуры = ДД.АналитикаУчетаНоменклатуры
	|			И ДвиженияПоКомитенту.Валюта = ДД.Валюта
	|			И ДвиженияПоКомитенту.НомерГТД = ДД.НомерГТД
	|	ГДЕ
	|		(ТИПЗНАЧЕНИЯ(ДД.Регистратор) = ЗНАЧЕНИЕ(Документ.ОтчетПоКомиссииМеждуОрганизациями)
	|			ИЛИ ТИПЗНАЧЕНИЯ(ДД.Регистратор) = ЗНАЧЕНИЕ(Документ.ОтчетПоКомиссииМеждуОрганизациямиОСписании))
	|		И ДвиженияПоКомитенту.Регистратор ЕСТЬ NULL
	|
	|	) КАК КОбработке
	|");
	
	Регистраторы = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	ОбновлениеИнформационнойБазы.ОтметитьКОбработке(
		Параметры, 
		Регистраторы, 
		ДополнительныеПараметры
	);
	
	РегистрыНакопления.ПрочиеАктивыПассивы.ЗарегистироватьКОбновлениюУправленческогоБаланса(Параметры, Регистраторы, ПолноеИмяРегистра);
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	Регистраторы = Новый Массив;
	Регистраторы.Добавить("Документ.ВнутреннееПотреблениеТоваров");
	Регистраторы.Добавить("Документ.ВозвратТоваровМеждуОрганизациями");
	Регистраторы.Добавить("Документ.ВозвратТоваровОтКлиента");
	Регистраторы.Добавить("Документ.ОтчетКомиссионера");
	Регистраторы.Добавить("Документ.ОтчетКомиссионераОСписании");
	Регистраторы.Добавить("Документ.ОтчетКомитенту");
	Регистраторы.Добавить("Документ.ОтчетКомитентуОСписании");
	Регистраторы.Добавить("Документ.ОтчетОРозничныхПродажах");
	Регистраторы.Добавить("Документ.ОтчетПоКомиссииМеждуОрганизациями");
	Регистраторы.Добавить("Документ.ОтчетПоКомиссииМеждуОрганизациямиОСписании");
	Регистраторы.Добавить("Документ.ПередачаТоваровМеждуОрганизациями");
	Регистраторы.Добавить("Документ.ПересортицаТоваров");
	Регистраторы.Добавить("Документ.ПорчаТоваров");
	Регистраторы.Добавить("Документ.ПрочееОприходованиеТоваров");
	Регистраторы.Добавить("Документ.РеализацияТоваровУслуг");
	Регистраторы.Добавить("Документ.СборкаТоваров");
	Регистраторы.Добавить("Документ.СписаниеНедостачТоваров");
	
	//++ НЕ УТ
	Регистраторы.Добавить("Документ.ПередачаСырьяПереработчику");
	Регистраторы.Добавить("Документ.ПередачаМатериаловВПроизводство");
	Регистраторы.Добавить("Документ.РаспределениеПроизводственныхЗатрат");
	//-- НЕ УТ
	
	
	ОбработкаЗавершена = ОбновлениеИнформационнойБазыУТ.ПерезаписатьДвиженияИзОчереди(
		Регистраторы, 
		"РегистрНакопления.ТоварыКОформлениюОтчетовКомитенту", 
		Параметры.Очередь
	);
	
	
	
	Параметры.ОбработкаЗавершена = ОбработкаЗавершена;
	
КонецПроцедуры


#КонецОбласти

#КонецОбласти

#КонецЕсли