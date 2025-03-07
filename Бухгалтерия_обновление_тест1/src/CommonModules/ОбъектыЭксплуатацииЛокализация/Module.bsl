////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации справочника "Объекты эксплуатации".
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область Печать

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область ПодключаемыеКоманды

Процедура ДобавитьКомандыСозданияНаОсновании(КомандыСозданияНаОсновании, Параметры) Экспорт

	//++ Локализация
	
	Команда = Документы.ПринятиеКУчетуОС.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.ВидимостьВФормах = "ФормаЭлемента, ФормаСпискаСоСведениями";
		Команда.РежимЗаписи = "";
	КонецЕсли;
	
	Команда = Документы.ИзменениеСостоянияОС.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.ВидимостьВФормах = "ФормаЭлемента, ФормаСпискаСоСведениями";
		Команда.РежимЗаписи = "";
	КонецЕсли;
	
	Команда = Документы.ИзменениеПараметровОС.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.ВидимостьВФормах = "ФормаЭлемента, ФормаСпискаСоСведениями";
		Команда.РежимЗаписи = "";
	КонецЕсли;
	
	Команда = Документы.СписаниеОС.ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании);
	Если Команда <> Неопределено Тогда
		Команда.ВидимостьВФормах = "ФормаЭлемента, ФормаСпискаСоСведениями";
		Команда.РежимЗаписи = "";
	КонецЕсли;
	
	//-- Локализация
	
КонецПроцедуры

Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ДобавитьКомандыОтчетов(КомандыОтчетов, Параметры) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

#КонецОбласти

#Область ФормаЭлемента

Процедура ПриИзмененииРеквизита(ИмяЭлемента, Форма, ДополнительныеПараметры) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура УстановитьВидимостьКомандВводаНаОсновании(Форма, ТаблицаКоманд) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ЗаполнитьСведенияОбУчете(Форма, ПредставлениеСведений) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ЗаполнитьСтоимостьИАмортизацию(Форма, СведенияОбУчете, СтоимостьИАмортизация) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ПриЧтенииСозданииНаСервере(Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура УстановитьУсловноеОформление(Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#Область ФормаСписка

Процедура ДополнитьСведения2_4(ВнеоборотныйАктив, СведенияОбУчете, СтоимостьИАмортизация, МассивСумм, Сведения2_4) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Функция ПолучитьСведения2_2(Знач ВнеоборотныйАктив, Знач ОтборОрганизация) Экспорт
	
	Сведения2_2 = Неопределено;
	
	//++ Локализация   
	
	УстановитьПривилегированныйРежим(Истина);
	
	ЗначенияПоУмолчанию = Новый Структура;
	ЗначенияПоУмолчанию.Вставить("СтоимостьБУ", 0);
	ЗначенияПоУмолчанию.Вставить("СтоимостьНУ", 0);
	ЗначенияПоУмолчанию.Вставить("АмортизацияБУ", 0);
	ЗначенияПоУмолчанию.Вставить("АмортизацияНУ", 0);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВидСубконтоОС", ПланыВидовХарактеристик.ВидыСубконтоХозрасчетные.ОсновныеСредства);
	Запрос.УстановитьПараметр("ОтборПоОрганизации", ЗначениеЗаполнено(ОтборОрганизация));
	Запрос.УстановитьПараметр("ОтборОрганизация", ОтборОрганизация);
	Запрос.УстановитьПараметр("ВнеоборотныйАктив", ВнеоборотныйАктив);
	
	Запрос.Текст=
	"ВЫБРАТЬ
	|	ПервоначальныеСведения.ОсновноеСредство КАК ОбъектУчета,
	|	СчетаОтражения.СчетУчета КАК СчетУчета,
	|	СчетаОтражения.СчетНачисленияАмортизации КАК СчетАмортизации
	|ПОМЕСТИТЬ втАктивыИСчетаУчета
	|ИЗ
	|	РегистрСведений.ПервоначальныеСведенияОС.СрезПоследних(, ОсновноеСредство = &ВнеоборотныйАктив) КАК ПервоначальныеСведения
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПорядокУчетаОС.СрезПоследних(
	|				,
	|				ОсновноеСредство = &ВнеоборотныйАктив) КАК СчетаОтражения
	|		ПО ПервоначальныеСведения.ОсновноеСредство = СчетаОтражения.ОсновноеСредство
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	АктивыИСчетаУчета.СчетУчета КАК Счет
	|ПОМЕСТИТЬ втСчетаОстатков
	|ИЗ
	|	втАктивыИСчетаУчета КАК АктивыИСчетаУчета
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	АктивыИСчетаУчета.СчетАмортизации
	|ИЗ
	|	втАктивыИСчетаУчета КАК АктивыИСчетаУчета
	|
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ХозрасчетныйОстатки.Субконто1 КАК ОбъектУчета,
	|	ХозрасчетныйОстатки.Счет КАК Счет,
	|	ХозрасчетныйОстатки.СуммаОстаток КАК СуммаБУ,
	|	ХозрасчетныйОстатки.СуммаНУОстаток КАК СуммаНУ
	|ПОМЕСТИТЬ втОстатки
	|ИЗ
	|	РегистрБухгалтерии.Хозрасчетный.Остатки(
	|			,
	|			Счет В
	|				(ВЫБРАТЬ
	|					Т.Счет
	|				ИЗ
	|					втСчетаОстатков КАК Т),
	|			&ВидСубконтоОС,
	|			Субконто1 В (&ВнеоборотныйАктив)
	|				И (НЕ &ОтборПООрганизации
	|					ИЛИ Организация = &ОтборОрганизация)) КАК ХозрасчетныйОстатки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ЕСТЬNULL(Стоимость.СуммаБУ, 0) КАК СтоимостьБУ,
	|	ЕСТЬNULL(Стоимость.СуммаНУ, 0) КАК СтоимостьНУ,
	|	ЕСТЬNULL(-Амортизация.СуммаБУ, 0) КАК АмортизацияБУ,
	|	ЕСТЬNULL(-Амортизация.СуммаНУ, 0) КАК АмортизацияНУ
	|ИЗ
	|	втАктивыИСчетаУчета КАК втАктивыИСчетаУчета
	|		ЛЕВОЕ СОЕДИНЕНИЕ втОстатки КАК Стоимость
	|		ПО втАктивыИСчетаУчета.ОбъектУчета = Стоимость.ОбъектУчета
	|			И втАктивыИСчетаУчета.СчетУчета = Стоимость.Счет
	|		ЛЕВОЕ СОЕДИНЕНИЕ втОстатки КАК Амортизация
	|		ПО втАктивыИСчетаУчета.ОбъектУчета = Амортизация.ОбъектУчета
	|			И втАктивыИСчетаУчета.СчетАмортизации = Амортизация.Счет
	|			";
	
	Результат = Запрос.Выполнить();
	Если Не Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		ЗаполнитьЗначенияСвойств(ЗначенияПоУмолчанию, Выборка);
	КонецЕсли;
	
	Поля = "Представление, СуммаБУ, СуммаНУ";
	
	Сведения2_2 = Новый Массив;
	
	Строка = Новый Структура(Поля);
	Строка.Представление = НСтр("ru='Первоначальная стоимость:';uk='Первісна вартість:'");
	Строка.СуммаБУ = ЗначенияПоУмолчанию.СтоимостьБУ;
	Строка.СуммаНУ = ЗначенияПоУмолчанию.СтоимостьНУ;
	Сведения2_2.Добавить(Строка);
	
	ЗаголовокАмортизации = НСтр("ru='Накопленная амортизация:';uk='Накопичена амортизація:'");
	МножительАмортизации = 1;
	
	Строка = Новый Структура(Поля);
	Строка.Представление = ЗаголовокАмортизации;
	Строка.СуммаБУ = ЗначенияПоУмолчанию.АмортизацияБУ * МножительАмортизации;
	Строка.СуммаНУ = ЗначенияПоУмолчанию.АмортизацияНУ * МножительАмортизации;
	Сведения2_2.Добавить(Строка);

	Если Истина Тогда
		
		Строка = Новый Структура(Поля);
		Строка.Представление = НСтр("ru='Остаточная стоимость:';uk='Залишкова вартість:'");
		Строка.СуммаБУ = ЗначенияПоУмолчанию.СтоимостьБУ-ЗначенияПоУмолчанию.АмортизацияБУ;
		Строка.СуммаНУ = ЗначенияПоУмолчанию.СтоимостьНУ-ЗначенияПоУмолчанию.АмортизацияНУ;
		Сведения2_2.Добавить(Строка);
		
	КонецЕсли;
	
	//-- Локализация
	
	Возврат Сведения2_2;
	
КонецФункции

Функция ТекстЗапросаФормыСписка() Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	СправочникОбъектыЭксплуатации.Ссылка,
	|	СправочникОбъектыЭксплуатации.ПометкаУдаления,
	|	СправочникОбъектыЭксплуатации.Родитель,
	|	СправочникОбъектыЭксплуатации.ЭтоГруппа,
	|	СправочникОбъектыЭксплуатации.Код,
	|	СправочникОбъектыЭксплуатации.Наименование,
	|	СправочникОбъектыЭксплуатации.НаименованиеПолное,
	|	СправочникОбъектыЭксплуатации.Изготовитель,
	|	СправочникОбъектыЭксплуатации.ЗаводскойНомер,
	|	СправочникОбъектыЭксплуатации.НомерПаспорта,
	|	СправочникОбъектыЭксплуатации.ДатаВыпуска,
	|	ЕСТЬNULL(ПорядокУчетаОСБУ.НалоговаяГруппаОС, ЗНАЧЕНИЕ(Справочник.НалоговыеГруппыОсновныхСредств.ПустаяСсылка)) КАК ГруппаОС,
	|	СправочникОбъектыЭксплуатации.Комментарий,
	|	СправочникОбъектыЭксплуатации.Расположение,
	|	СправочникОбъектыЭксплуатации.Модель,
	|	СправочникОбъектыЭксплуатации.СерийныйНомер,
	|	СправочникОбъектыЭксплуатации.ИнвентарныйНомер,
	|	МестонахождениеОС.АдресМестонахождения,
	|
	|	ВЫБОР
	|		КОГДА &ОтборПоОрганизации И МестонахождениеОС.Арендатор = &ОтборОрганизация
	|			ТОГДА МестонахождениеОС.МОЛАрендатора
	|		ИНАЧЕ ЕСТЬNULL(МестонахождениеОС.МОЛ, ЗНАЧЕНИЕ(Справочник.ФизическиеЛица.ПустаяСсылка))
	|	КОНЕЦ КАК МОЛ,
	|
	|	ВЫБОР
	|		КОГДА &ОтборПоОрганизации И МестонахождениеОС.Арендатор = &ОтборОрганизация
	|			ТОГДА МестонахождениеОС.ПодразделениеАрендатора
	|		ИНАЧЕ ЕСТЬNULL(МестонахождениеОС.Местонахождение, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка))
	|	КОНЕЦ КАК Подразделение,		
	|
	|	ВЫБОР
	|		КОГДА &ОтборПоОрганизации И МестонахождениеОС.Арендатор = &ОтборОрганизация
	|			ТОГДА МестонахождениеОС.Арендатор
	|		ИНАЧЕ ЕСТЬNULL(МестонахождениеОС.Организация, ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)) 
	|	КОНЕЦ КАК Организация,
	|
	|	ВЫБОР 
	|		КОГДА СправочникОбъектыЭксплуатации.ЭтоГруппа
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
	|		КОГДА &ОтборПоОрганизации 
	|				И МестонахождениеОС.Арендатор = &ОтборОрганизация
	|				И НЕ ПорядокУчетаОСБУ.Состояние ЕСТЬ NULL
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПринятоКЗабалансовомуУчету)
	|		ИНАЧЕ ЕСТЬNULL(ПорядокУчетаОСБУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету))
	|	КОНЕЦ КАК СостояниеРегл,
	|
	|	ВЫБОР 
	|		КОГДА СправочникОбъектыЭксплуатации.ЭтоГруппа
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
	|		КОГДА &ОтборПоОрганизации 
	|				И МестонахождениеОС.Арендатор = &ОтборОрганизация
	|				И НЕ ПорядокУчетаОСУУ.Состояние ЕСТЬ NULL
	|			ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПринятоКЗабалансовомуУчету)
	|		ИНАЧЕ ЕСТЬNULL(ПорядокУчетаОСУУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) 
	|	КОНЕЦ КАК СостояниеУпр,
	|
	|	ЕСТЬNULL(ПервоначальныеСведенияОС.ДатаВводаВЭксплуатациюБУ, ДАТАВРЕМЯ(1, 1, 1)) КАК ДатаПринятияКУчетуРегл,
	|	ЕСТЬNULL(ПервоначальныеСведенияОС.ДатаВводаВЭксплуатациюУУ, ДАТАВРЕМЯ(1, 1, 1)) КАК ДатаПринятияКУчетуУпр,
	|
	|	ВЫБОР
	|		КОГДА НаличиеФайлов.ЕстьФайлы ЕСТЬ NULL ТОГДА 0
	|		КОГДА НаличиеФайлов.ЕстьФайлы ТОГДА 1
	|		ИНАЧЕ 0
	|	КОНЕЦ КАК ЕстьФайлы
	|ИЗ
	|	Справочник.ОбъектыЭксплуатации КАК СправочникОбъектыЭксплуатации
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.НаличиеФайлов КАК НаличиеФайлов
	|		ПО СправочникОбъектыЭксплуатации.Ссылка = НаличиеФайлов.ОбъектСФайлами
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МестонахождениеОС.СрезПоследних КАК МестонахождениеОС
	|		ПО (МестонахождениеОС.ОсновноеСредство = СправочникОбъектыЭксплуатации.Ссылка)
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПервоначальныеСведенияОС.СрезПоследних КАК ПервоначальныеСведенияОС
	|		ПО ПервоначальныеСведенияОС.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство
	|			И ПервоначальныеСведенияОС.Организация = МестонахождениеОС.Организация
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПорядокУчетаОСБУ.СрезПоследних КАК ПорядокУчетаОСБУ
	|		ПО (ПорядокУчетаОСБУ.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство)
	|			И (ПорядокУчетаОСБУ.Организация = МестонахождениеОС.Организация)
	|
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПорядокУчетаОСУУ.СрезПоследних КАК ПорядокУчетаОСУУ
	|		ПО (ПорядокУчетаОСУУ.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство)
	|			И (ПорядокУчетаОСУУ.Организация = МестонахождениеОС.Организация)      
	|ГДЕ
	|	(НЕ &ОтборПоОрганизации
	|		ИЛИ ВЫБОР
	|				КОГДА &ОтборПоОрганизации И МестонахождениеОС.Арендатор = &ОтборОрганизация
	|					ТОГДА МестонахождениеОС.Арендатор
	|				ИНАЧЕ ЕСТЬNULL(МестонахождениеОС.Организация, ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)) 
	|			КОНЕЦ = &ОтборОрганизация)
	|
	|	И (&Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
	|		ИЛИ ВЫБОР 
	|				КОГДА СправочникОбъектыЭксплуатации.ЭтоГруппа
	|					ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
	|				КОГДА &ОтборПоОрганизации И МестонахождениеОС.Арендатор = &ОтборОрганизация
	|					ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПринятоКЗабалансовомуУчету)
	|				ИНАЧЕ ЕСТЬNULL(ПорядокУчетаОСБУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету))
	|			КОНЕЦ = &Состояние
	|		ИЛИ ВЫБОР 
	|				КОГДА СправочникОбъектыЭксплуатации.ЭтоГруппа
	|					ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
	|				КОГДА &ОтборПоОрганизации И МестонахождениеОС.Арендатор = &ОтборОрганизация
	|					ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПринятоКЗабалансовомуУчету)
	|				ИНАЧЕ ЕСТЬNULL(ПорядокУчетаОСУУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету))
	|			КОНЕЦ = &Состояние)";
	
	//-- Локализация

	Возврат ТекстЗапроса;
	
КонецФункции
 
#КонецОбласти

#Область Прочее

Функция ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка) Экспорт
	
	Результат = Ложь;
	
	//++ Локализация
	Если ВидФормы = "ФормаВыбора" 
		И ВнеоборотныеАктивыСлужебный.ДоступенВыборОбъектовЭксплуатации2_4(Параметры) Тогда
		
		// В концепции 2.4 своя форма выбора
		ВыбраннаяФорма = "ФормаВыбора2_4";
		СтандартнаяОбработка = Ложь;
	
	ИначеЕсли ВидФормы = "ФормаВыбора" Тогда
		
		ВыбраннаяФорма = "ФормаВыбора";
		
		Если Не Параметры.Свойство("Отбор") Тогда
			Параметры.Вставить("Отбор", Новый Структура);
		КонецЕсли;
		
		
	КонецЕсли;

	Результат = Истина;
		
	//-- Локализация
	
	Возврат Результат;
	
КонецФункции

Функция ОписаниеЗапросаДляВыбора(Параметры, УстановитьВсеОтборы, МассивОбъектов) Экспорт

	ОписаниеЗапросаДляВыбора = Неопределено;
	
	//++ Локализация

	Если Параметры.Свойство("Контекст") Тогда
		ДоступныеКонтексты = Новый Структура(Параметры.Контекст);
	Иначе
		ДоступныеКонтексты = Новый Структура("БУ,УУ"); // По умолчанию доступны все контексты.
	КонецЕсли;

	ОтборСписка = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(Параметры, "Отбор", Новый Структура);

	Если ОтборСписка.Свойство("ОтражатьВРеглУчете")
		И НЕ ОтборСписка.ОтражатьВРеглУчете
		И ДоступныеКонтексты.Свойство("БУ") Тогда
		ДоступныеКонтексты.Удалить("БУ"); // Доступен выбор отражения в учете и в регл. учете нет отражения.
	КонецЕсли; 

	Если ОтборСписка.Свойство("ОтражатьВУпрУчете")
		И НЕ ОтборСписка.ОтражатьВУпрУчете
		И ДоступныеКонтексты.Свойство("УУ") Тогда
		ДоступныеКонтексты.Удалить("УУ"); // Доступен выбор отражения в учете и в упр. учете нет отражения.
	КонецЕсли; 
	

	Если Параметры.Свойство("ВариантПримененияЦелевогоФинансирования")
		И (Параметры.ВариантПримененияЦелевогоФинансирования = Перечисления.ВариантыПримененияЦелевогоФинансирования.НеИспользуется
			ИЛИ НЕ ЗначениеЗаполнено(Параметры.ВариантПримененияЦелевогоФинансирования)) Тогда
		ОтборСписка.Удалить("НаправлениеДеятельности");
	КонецЕсли;

	Если ОтборСписка.Свойство("НаправлениеДеятельности")
		И НЕ ЗначениеЗаполнено(ОтборСписка.НаправлениеДеятельности) Тогда
		ОтборСписка.Удалить("НаправлениеДеятельности");
	КонецЕсли; 

	Если НЕ ПравоДоступа("Чтение", Метаданные.РегистрыСведений.МестонахождениеОС) Тогда
		ОтборСписка.Удалить("Подразделение");
		ОтборСписка.Удалить("Организация");
		ОтборСписка.Удалить("МОЛ");
	КонецЕсли;

	Если ОтборСписка.Свойство("Организация")
		И НЕ ЗначениеЗаполнено(ОтборСписка.Организация) Тогда
		ОтборСписка.Удалить("Организация");
	КонецЕсли; 

	Если ОтборСписка.Свойство("Подразделение")
		И НЕ ЗначениеЗаполнено(ОтборСписка.Подразделение) Тогда
		ОтборСписка.Удалить("Подразделение");
	КонецЕсли; 

	Если ОтборСписка.Свойство("МОЛ")
		И НЕ ЗначениеЗаполнено(ОтборСписка.МОЛ) Тогда
		ОтборСписка.Удалить("МОЛ");
	КонецЕсли; 

	Если ОтборСписка.Свойство("СрокИспользованияУУ")
		И НЕ ЗначениеЗаполнено(ОтборСписка.СрокИспользованияУУ) Тогда
		ОтборСписка.Удалить("СрокИспользованияУУ");
	КонецЕсли; 

	Если ОтборСписка.Свойство("СрокИспользованияБУ")
		И НЕ ЗначениеЗаполнено(ОтборСписка.СрокИспользованияБУ) Тогда
		ОтборСписка.Удалить("СрокИспользованияБУ");
	КонецЕсли; 

	Если ОтборСписка.Свойство("СрокИспользованияНУ")
		И НЕ ЗначениеЗаполнено(ОтборСписка.СрокИспользованияНУ) Тогда
		ОтборСписка.Удалить("СрокИспользованияНУ");
	КонецЕсли; 

	
	ДополнительныеПоля = "";
	ТекстОтборы = "";
	ПараметрыЗапроса = Новый Структура;
	ДоступныеПоля = Новый Массив;
	НеобходимыеТаблицы = Новый Структура;

	Если (ДоступныеКонтексты.Свойство("БУ") ИЛИ ДоступныеКонтексты.Свойство("УУ"))
		И ПравоДоступа("Чтение", Метаданные.РегистрыСведений.МестонахождениеОС) Тогда
		
		ПолеОрганизация = "ЕСТЬNULL(МестонахождениеОС.Организация, ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка))";
		ПолеМОЛ = "ЕСТЬNULL(МестонахождениеОС.МОЛ, ЗНАЧЕНИЕ(Справочник.ФизическиеЛица.ПустаяСсылка))";
		ПолеПодразделение = "ЕСТЬNULL(МестонахождениеОС.Местонахождение, ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка))";
		ПолеАдресМестонахождения = "ЕСТЬNULL(МестонахождениеОС.АдресМестонахождения, """""""")";
		ПолеАрендатор = "ЕСТЬNULL(МестонахождениеОС.Арендатор, НЕОПРЕДЕЛЕНО)";
		
	Иначе
		
		ПолеОрганизация = "ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)";
		ПолеМОЛ = "ЗНАЧЕНИЕ(Справочник.ФизическиеЛица.ПустаяСсылка)";
		ПолеПодразделение = "ЗНАЧЕНИЕ(Справочник.СтруктураПредприятия.ПустаяСсылка)";
		ПолеАдресМестонахождения = """""";
		ПолеАрендатор = "НЕОПРЕДЕЛЕНО";
		
	КонецЕсли;

	Если (ДоступныеКонтексты.Свойство("БУ") ИЛИ ДоступныеКонтексты.Свойство("УУ"))
		И ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПервоначальныеСведенияОС) Тогда
		
		ПолеАрендодатель = "ЕСТЬNULL(ПервоначальныеСведенияОС.Контрагент, ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка))";
		
		НеобходимыеТаблицы.Вставить("ПервоначальныеСведенияОС");
		
	Иначе
		
		ПолеАрендодатель = "ЗНАЧЕНИЕ(Справочник.ГруппыФинансовогоУчетаВнеоборотныхАктивов.ПустаяСсылка)";
		
	КонецЕсли;

	Если (ДоступныеКонтексты.Свойство("БУ") ИЛИ ДоступныеКонтексты.Свойство("УУ"))
		И ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПорядокУчетаОС) Тогда
		
		ПолеГФУ = "ЕСТЬNULL(ПорядокУчетаОС.ГруппаФинансовогоУчета, ЗНАЧЕНИЕ(Справочник.ГруппыФинансовогоУчетаВнеоборотныхАктивов.ПустаяСсылка))";
		
	Иначе
		
		ПолеГФУ = "ЗНАЧЕНИЕ(Справочник.ГруппыФинансовогоУчетаВнеоборотныхАктивов.ПустаяСсылка)";
		
	КонецЕсли;

	Если (ДоступныеКонтексты.Свойство("БУ") ИЛИ ДоступныеКонтексты.Свойство("УУ"))
		И ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПервоначальныеСведенияОС)
		И ПравоДоступа("Чтение", Метаданные.РегистрыСведений.МестонахождениеОС) Тогда
		
		ПолеДатаПринятияКУчетуРегл = "ЕСТЬNULL(ПервоначальныеСведенияОС.ДатаВводаВЭксплуатациюБУ, ДАТАВРЕМЯ(1, 1, 1))";
		ПолеДатаПринятияКУчетуУпр = "ЕСТЬNULL(ПервоначальныеСведенияОС.ДатаВводаВЭксплуатациюУУ, ДАТАВРЕМЯ(1, 1, 1))";
		
		НеобходимыеТаблицы.Вставить("ПервоначальныеСведенияОС");
		
	Иначе
		ПолеДатаПринятияКУчетуРегл = "ДАТАВРЕМЯ(1, 1, 1)";
		ПолеДатаПринятияКУчетуУпр = "ДАТАВРЕМЯ(1, 1, 1)";
	КонецЕсли;
	
	Если Параметры.Свойство("РеквизитыКоторыеДолжныСовпадать")
			И СтрНайти(Параметры.РеквизитыКоторыеДолжныСовпадать, "СрокИспользованияУУ") <> 0 
		ИЛИ ОтборСписка.Свойство("СрокИспользованияУУ") Тогда
		
		ПолеСрокИспользованияУУ = "ЕСТЬNULL(ПараметрыАмортизацииОСУУ.СрокИспользования, 0)";
		
		НеобходимыеТаблицы.Вставить("ПараметрыАмортизацииОСУУ");
		
	Иначе
		
		ПолеСрокИспользованияУУ = "0";
		
	КонецЕсли;

	Если Параметры.Свойство("РеквизитыКоторыеДолжныСовпадать")
			И СтрНайти(Параметры.РеквизитыКоторыеДолжныСовпадать, "СрокИспользованияБУ") <> 0 
		ИЛИ ОтборСписка.Свойство("СрокИспользованияБУ") Тогда
		
		ПолеСрокИспользованияБУ = "ЕСТЬNULL(ПараметрыАмортизацииОСБУ.СрокПолезногоИспользованияБУ, 0)";
		ПолеСрокИспользованияНУ = "ЕСТЬNULL(ПараметрыАмортизацииОСБУ.СрокПолезногоИспользованияНУ, 0)";
		
		НеобходимыеТаблицы.Вставить("ПараметрыАмортизацииОСБУ");
		
	Иначе
		
		ПолеСрокИспользованияБУ = "0";
		ПолеСрокИспользованияНУ = "0";
		
	КонецЕсли;

	ДополнительныеПоля = ДополнительныеПоля + "
		|, " + ПолеОрганизация + " КАК Организация
		|, " + ПолеМОЛ + " КАК МОЛ
		|, " + ПолеПодразделение + " КАК Подразделение
		|, " + ПолеАдресМестонахождения + " КАК АдресМестонахождения
		|, " + ПолеГФУ + " КАК ГруппаФинансовогоУчета
		|, " + ПолеДатаПринятияКУчетуРегл + " КАК ДатаПринятияКУчетуРегл
		|, " + ПолеДатаПринятияКУчетуУпр + " КАК ДатаПринятияКУчетуУпр
		|, " + ПолеСрокИспользованияУУ + " КАК СрокИспользованияУУ
		|, " + ПолеСрокИспользованияБУ + " КАК СрокИспользованияБУ
		|, " + ПолеСрокИспользованияНУ + " КАК СрокИспользованияНУ
		|, " + ПолеАрендатор + " КАК Арендатор
		|, " + ПолеАрендодатель + " КАК Арендодатель";

	Если ДоступныеКонтексты.Свойство("БУ") 
		И ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПорядокУчетаОСБУ) Тогда
		
		ДоступныеПоля.Добавить("СостояниеБУ");
		ДополнительныеПоля = ДополнительныеПоля + "
			|,ВЫБОР 
			|	КОГДА НЕ СправочникОбъектыЭксплуатации.ЭтоГруппа 
			|		ТОГДА ЕСТЬNULL(ПорядокУчетаОСБУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету))
			|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
			|	КОНЕЦ КАК СостояниеБУ
			|";
		
	Иначе
		
		ДополнительныеПоля = ДополнительныеПоля + "
			|,ВЫБОР 
			|	КОГДА НЕ СправочникОбъектыЭксплуатации.ЭтоГруппа 
			|		ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)
			|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
			|	КОНЕЦ КАК СостояниеБУ
			|";
		
	КонецЕсли; 

	Если ДоступныеКонтексты.Свойство("УУ")
		И ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПорядокУчетаОСУУ) Тогда
		
		ДополнительныеПоля = ДополнительныеПоля + "
			|,ВЫБОР 
			|	КОГДА НЕ СправочникОбъектыЭксплуатации.ЭтоГруппа 
			|		ТОГДА ЕСТЬNULL(ПорядокУчетаОСУУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету))
			|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
			|	КОНЕЦ КАК СостояниеУУ";
		
		НеобходимыеТаблицы.Вставить("ПорядокУчетаОСУУ");
		
	Иначе
		
		ДополнительныеПоля = ДополнительныеПоля + ",ВЫБОР 
			|	КОГДА НЕ СправочникОбъектыЭксплуатации.ЭтоГруппа 
			|		ТОГДА ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)
			|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка)
			|	КОНЕЦ КАК СостояниеУУ";
		
	КонецЕсли;

	ДоступенВыборУчета = 
		(ОтборСписка.Свойство("ОтражатьВРеглУчете") ИЛИ ОтборСписка.Свойство("ОтражатьВУпрУчете"))
		И ВнеоборотныеАктивыСлужебный.ВедетсяРегламентированныйУчетВНА();

	Если ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПорядокУчетаОСУУ) 
		И ПравоДоступа("Чтение", Метаданные.РегистрыСведений.ПорядокУчетаОСБУ) Тогда
		
		Если ОтборСписка.Свойство("Состояние") Тогда
				
			Если ДоступныеКонтексты.Свойство("БУ") И ДоступныеКонтексты.Свойство("УУ") Тогда
				Если ДоступенВыборУчета Тогда
					ТекстОтборы = "
					|	ЕСТЬNULL(ПорядокУчетаОСБУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) В(&Состояние)
					|	И ЕСТЬNULL(ПорядокУчетаОСУУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) В(&Состояние)";
				Иначе
					ТекстОтборы = "
					|	(ЕСТЬNULL(ПорядокУчетаОСБУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) В(&Состояние)
					|		ИЛИ ЕСТЬNULL(ПорядокУчетаОСУУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) В(&Состояние))";
				КонецЕсли; 
			ИначеЕсли ДоступныеКонтексты.Свойство("БУ") Тогда
				ТекстОтборы = "
				|	ЕСТЬNULL(ПорядокУчетаОСБУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) В(&Состояние)";
			ИначеЕсли ДоступныеКонтексты.Свойство("УУ") Тогда
				ТекстОтборы = "
				|	ЕСТЬNULL(ПорядокУчетаОСУУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) В(&Состояние)";
			КонецЕсли;
			Если ТипЗнч(ОтборСписка.Состояние) = Тип("ФиксированныйМассив") Тогда
				ПараметрыЗапроса.Вставить("Состояние", Новый Массив(ОтборСписка.Состояние));
			Иначе
				ПараметрыЗапроса.Вставить("Состояние", ОтборСписка.Состояние);
			КонецЕсли;
			Параметры.Отбор.Удалить("Состояние");
			
		Иначе
			
			Если ДоступныеКонтексты.Свойство("БУ") И ДоступныеКонтексты.Свойство("УУ") Тогда
				ТекстОтборы = "
				|	(ЕСТЬNULL(ПорядокУчетаОСБУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) = &Состояние
				|		ИЛИ ЕСТЬNULL(ПорядокУчетаОСУУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) = &Состояние
				|		ИЛИ &Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка))";
			ИначеЕсли ДоступныеКонтексты.Свойство("БУ") Тогда
				ТекстОтборы = "
				|	(ЕСТЬNULL(ПорядокУчетаОСБУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) = &Состояние
				|		ИЛИ &Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка))";
			ИначеЕсли ДоступныеКонтексты.Свойство("УУ") Тогда
				ТекстОтборы = "
				|	(ЕСТЬNULL(ПорядокУчетаОСУУ.Состояние, ЗНАЧЕНИЕ(Перечисление.СостоянияОС.НеПринятоКУчету)) = &Состояние
				|		ИЛИ &Состояние = ЗНАЧЕНИЕ(Перечисление.СостоянияОС.ПустаяСсылка))";
			КонецЕсли;
			Если ТекстОтборы <> "" Тогда
				ПараметрыЗапроса.Вставить("Состояние", Перечисления.СостоянияОС.ПустаяСсылка());
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли; 
		

	Если УстановитьВсеОтборы Тогда
		
		Для каждого КлючИЗначение Из ОтборСписка Цикл
			
			Если НЕ ЗначениеЗаполнено(КлючИЗначение.Значение) Тогда
				Продолжить;
			КонецЕсли;
			
			Если КлючИЗначение.Ключ = "Организация" Тогда
				ПутьКПолю = ПолеОрганизация;
			ИначеЕсли КлючИЗначение.Ключ = "Подразделение" Тогда
				ПутьКПолю = ПолеПодразделение;
			ИначеЕсли КлючИЗначение.Ключ = "МОЛ" Тогда
				ПутьКПолю = ПолеМОЛ;
			ИначеЕсли КлючИЗначение.Ключ = "СрокИспользованияБУ" Тогда
				ПутьКПолю = ПолеСрокИспользованияБУ;
			ИначеЕсли КлючИЗначение.Ключ = "СрокИспользованияНУ" Тогда
				ПутьКПолю = ПолеСрокИспользованияНУ;
			ИначеЕсли КлючИЗначение.Ключ = "СрокИспользованияУУ" Тогда
				ПутьКПолю = ПолеСрокИспользованияУУ;
			ИначеЕсли КлючИЗначение.Ключ = "Арендатор" Тогда
				ПутьКПолю = ПолеАрендатор;
			ИначеЕсли КлючИЗначение.Ключ = "Арендодатель" Тогда
				ПутьКПолю = ПолеАрендодатель;
			ИначеЕсли КлючИЗначение.Ключ = "НаправлениеДеятельности" Тогда
				ПутьКПолю = "ЕСТЬNULL(ПорядокУчетаОС.НаправлениеДеятельности, ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка))";
			Иначе
				Продолжить;
			КонецЕсли;
			
			ЭтоМассив = ТипЗнч(КлючИЗначение.Значение) = Тип("ФиксированныйМассив") 
						ИЛИ ТипЗнч(КлючИЗначение.Значение) = Тип("Массив");
						
			ТекстОтборы = ТекстОтборы 
							+ Символы.ПС 
							+ ?(ТекстОтборы <> "", "И ","")
							+ ПутьКПолю 
							+ ?(ЭтоМассив, " В (&" + КлючИЗначение.Ключ + ")", " = &" + КлючИЗначение.Ключ);
							
			ПараметрыЗапроса.Вставить(КлючИЗначение.Ключ, КлючИЗначение.Значение);
		КонецЦикла; 
		
	КонецЕсли; 

	ТекстСоединения = "";

	Если НеобходимыеТаблицы.Свойство("ПервоначальныеСведенияОС") Тогда
		ТекстСоединения = ТекстСоединения + "
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПервоначальныеСведенияОС.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ//) КАК ПервоначальныеСведенияОС
		|		ПО ПервоначальныеСведенияОС.Организация = МестонахождениеОС.Организация
		|			И ПервоначальныеСведенияОС.ОсновноеСредство = МестонахождениеОС.ОсновноеСредство";
	КонецЕсли;

	Если НеобходимыеТаблицы.Свойство("ПорядокУчетаОСУУ") Тогда
		ТекстСоединения = ТекстСоединения + "
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПорядокУчетаОСУУ.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ//) КАК ПорядокУчетаОСУУ
		|		ПО СправочникОбъектыЭксплуатации.Ссылка = ПорядокУчетаОСУУ.ОсновноеСредство
		|			И ПорядокУчетаОСУУ.Организация = МестонахождениеОС.Организация";
	КонецЕсли;

	Если НеобходимыеТаблицы.Свойство("ПараметрыАмортизацииОСУУ") Тогда
		ТекстСоединения = ТекстСоединения + "
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПараметрыАмортизацииОСУУ.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ//) КАК ПараметрыАмортизацииОСУУ
		|		ПО СправочникОбъектыЭксплуатации.Ссылка = ПараметрыАмортизацииОСУУ.ОсновноеСредство
		|			И ПараметрыАмортизацииОСУУ.Организация = МестонахождениеОС.Организация";
	КонецЕсли;

	Если НеобходимыеТаблицы.Свойство("ПараметрыАмортизацииОСБУ") Тогда
		ТекстСоединения = ТекстСоединения + "
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПараметрыАмортизацииОСБУ.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ//) КАК ПараметрыАмортизацииОСБУ
		|		ПО СправочникОбъектыЭксплуатации.Ссылка = ПараметрыАмортизацииОСБУ.ОсновноеСредство
		|			И ПараметрыАмортизацииОСБУ.Организация = МестонахождениеОС.Организация";
	КонецЕсли;

	ТекстПервые = "";
	Если Параметры.Свойство("СтрокаПоиска") Тогда
		ТекстОтборы = ТекстОтборы + "
		|" + ?(ТекстОтборы <> "", "И ","")
		+ "(СправочникОбъектыЭксплуатации.Наименование ПОДОБНО &СтрокаПоиска
			|			ИЛИ СправочникОбъектыЭксплуатации.ИнвентарныйНомер ПОДОБНО &СтрокаПоиска)
			|	И НЕ СправочникОбъектыЭксплуатации.ЭтоГруппа
			|	И НЕ СправочникОбъектыЭксплуатации.ПометкаУдаления";
		ТекстПервые = "РАЗРЕШЕННЫЕ ПЕРВЫЕ 10";
		ПараметрыЗапроса.Вставить("СтрокаПоиска", "%" + Параметры.СтрокаПоиска + "%");
	КонецЕсли;

	Если МассивОбъектов <> Неопределено Тогда
		ТекстОтборы = ТекстОтборы + "
		|" + ?(ТекстОтборы <> "", "И ","")
		+ "СправочникОбъектыЭксплуатации.Ссылка В(&МассивОбъектов)
			|	И НЕ СправочникОбъектыЭксплуатации.ЭтоГруппа
			|	И НЕ СправочникОбъектыЭксплуатации.ПометкаУдаления";
		ПараметрыЗапроса.Вставить("МассивОбъектов", МассивОбъектов);
	КонецЕсли; 

	ТекстРегистрация = "";
	Если Параметры.Свойство("ЕстьРегистрацияТранспортныхСредств") Тогда
		ТекстРегистрация = ТекстРегистрация + "
		|" + ?(ТекстРегистрация <> "", "И ","")
		+ "СправочникОбъектыЭксплуатации.Ссылка В (
		|	ВЫБРАТЬ 
		|		ДанныеРегистра.ОсновноеСредство 
		|	ИЗ 
		|		РегистрСведений.РегистрацияТранспортныхСредств.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Регистрация//) КАК ДанныеРегистра
		|	ГДЕ
		|		ДанныеРегистра.ВидЗаписи = ЗНАЧЕНИЕ(Перечисление.ВидЗаписиОРегистрации.Регистрация))";
	КонецЕсли; 

	Если Параметры.Свойство("ЕстьРегистрацияЗемельныхУчастков") Тогда
		ТекстРегистрация = ТекстРегистрация + "
		|" + ?(ТекстРегистрация <> "", "И ","")
		+ "СправочникОбъектыЭксплуатации.Ссылка В (
		|	ВЫБРАТЬ 
		|		ДанныеРегистра.ОсновноеСредство 
		|	ИЗ 
		|		РегистрСведений.РегистрацияЗемельныхУчастков.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Регистрация//) КАК ДанныеРегистра
		|	ГДЕ
		|		ДанныеРегистра.ВидЗаписи = ЗНАЧЕНИЕ(Перечисление.ВидЗаписиОРегистрации.Регистрация))";
	КонецЕсли; 

	Если ТекстРегистрация <> "" Тогда
		
		ТекстОтборы = ТекстОтборы + "
		|" + ?(ТекстОтборы <> "", "И ","") + ТекстРегистрация;
		
	КонецЕсли;

	Если ТекстОтборы <> "" Тогда
		ТекстОтборы = "
		|ГДЕ
		|" + ТекстОтборы;
	КонецЕсли;

	ТекстЗапроса =
	"ВЫБРАТЬ //ПЕРВЫЕ//
	|	СправочникОбъектыЭксплуатации.Ссылка,
	|	СправочникОбъектыЭксплуатации.ПометкаУдаления,
	|	СправочникОбъектыЭксплуатации.Родитель,
	|	СправочникОбъектыЭксплуатации.ЭтоГруппа,
	|	СправочникОбъектыЭксплуатации.Код,
	|	СправочникОбъектыЭксплуатации.Наименование,
	|	СправочникОбъектыЭксплуатации.ИнвентарныйНомер,
	|	СправочникОбъектыЭксплуатации.ГруппаОСМеждународныйУчет,
	|	СправочникОбъектыЭксплуатации.ДатаВыпуска,
	|	СправочникОбъектыЭксплуатации.ЗаводскойНомер,
	|	СправочникОбъектыЭксплуатации.Изготовитель,
	|	СправочникОбъектыЭксплуатации.Класс,
	|	СправочникОбъектыЭксплуатации.Модель,
	|	СправочникОбъектыЭксплуатации.НаименованиеПолное,
	|	СправочникОбъектыЭксплуатации.НомерПаспорта,
	|	СправочникОбъектыЭксплуатации.Подкласс,
	|	СправочникОбъектыЭксплуатации.Расположение,
	|	СправочникОбъектыЭксплуатации.РемонтирующееПодразделение,
	|	СправочникОбъектыЭксплуатации.СерийныйНомер,
	|	СправочникОбъектыЭксплуатации.Статус,
	|	ЕСТЬNULL(ПорядокУчетаОС.НаправлениеДеятельности, ЗНАЧЕНИЕ(Справочник.НаправленияДеятельности.ПустаяСсылка)) КАК НаправлениеДеятельности,
	|	СправочникОбъектыЭксплуатации.Комментарий
	|	//ДОПОЛНИТЕЛЬНЫЕ_ПОЛЯ//
	|ИЗ
	|	Справочник.ОбъектыЭксплуатации КАК СправочникОбъектыЭксплуатации
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.МестонахождениеОС.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ//) КАК МестонахождениеОС
	|		ПО СправочникОбъектыЭксплуатации.Ссылка = МестонахождениеОС.ОсновноеСредство
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПорядокУчетаОСБУ.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ//) КАК ПорядокУчетаОСБУ
	|		ПО СправочникОбъектыЭксплуатации.Ссылка = ПорядокУчетаОСБУ.ОсновноеСредство
	|			И ПорядокУчетаОСБУ.Организация = МестонахождениеОС.Организация
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПорядокУчетаОС.СрезПоследних(//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//,//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ//) КАК ПорядокУчетаОС
	|		ПО СправочникОбъектыЭксплуатации.Ссылка = ПорядокУчетаОС.ОсновноеСредство
	|	//СОЕДИНЕНИЯ//
	|	//ОТБОРЫ//";

	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//ДОПОЛНИТЕЛЬНЫЕ_ПОЛЯ//", ДополнительныеПоля);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//СОЕДИНЕНИЯ//", ТекстСоединения);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//ОТБОРЫ//", ТекстОтборы);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//ПЕРВЫЕ//", ТекстПервые);
	
	ПараметрыСрезаПоследнихДата = "";
	ПараметрыСрезаПоследних = "";
	Если Параметры.Свойство("ДатаСведений") Тогда
		ПараметрыСрезаПоследнихДата = "&ДатаСведений";
		ПараметрыЗапроса.Вставить("ДатаСведений", КонецДня(Параметры.ДатаСведений));
	КонецЕсли; 
	Если Параметры.Свойство("ТекущийРегистратор") Тогда
		ПараметрыСрезаПоследних = "Регистратор <> &ТекущийРегистратор";
		ПараметрыЗапроса.Вставить("ТекущийРегистратор", Параметры.ТекущийРегистратор);
	КонецЕсли; 

	Если ТекстРегистрация <> "" Тогда
		
		ПараметрыСрезаПоследних_Регистрация = ПараметрыСрезаПоследних;
		Если Параметры.Свойство("Организация") И ЗначениеЗаполнено(Параметры.Организация) Тогда
			ПараметрыСрезаПоследних_Регистрация = 
				ПараметрыСрезаПоследних_Регистрация 
				+ ?(ПараметрыСрезаПоследних_Регистрация <> "", " И ", "")
				+ "Организация = &Организация";
			ПараметрыЗапроса.Вставить("Организация", Параметры.Организация);
		КонецЕсли; 
		
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_Регистрация//", ПараметрыСрезаПоследних_Регистрация);
		
	КонецЕсли;

	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ_ДАТА//", ПараметрыСрезаПоследнихДата);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "//ПАРАМЕТРЫ_СРЕЗАПОСЛЕДНИХ//", ПараметрыСрезаПоследних);

	ОписаниеЗапросаДляВыбора = Новый Структура("ТекстЗапроса,ПараметрыЗапроса,ДоступныеПоля", ТекстЗапроса, ПараметрыЗапроса, ДоступныеПоля);

	//-- Локализация
	
	Возврат ОписаниеЗапросаДляВыбора;
	
КонецФункции

Функция ЕстьПраваНаЧтениеСведений() Экспорт

	//++ Локализация
	//-- Локализация
	
	Возврат Истина;
	
КонецФункции

Функция ТекстЗапросаПоказательНаработки() Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция ПервоначальныеСведения(ОсновноеСредствоИлиСписок, Период) Экспорт

	Результат = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат Результат;
	
КонецФункции

Функция СведенияОбУчете(ОсновноеСредство, ОтборОрганизация) Экспорт

	СведенияОбУчете = Неопределено;
	
	//++ Локализация
	//-- Локализация
	
	Возврат СведенияОбУчете;

КонецФункции

Функция ТекстЗапросаДоступныхДляВыбораОбъектов() Экспорт

	ТекстЗапроса = Неопределено;
	
	//++ Локализация

	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СрезСведенияОС.ОсновноеСредство КАК Ссылка
	|ИЗ
	|	РегистрСведений.ПараметрыАмортизацииОСУУ.СрезПоследних(, &РегистрацияНаработки) КАК СрезСведенияОС
	|ГДЕ
	|	СрезСведенияОС.МетодНачисленияАмортизации = ЗНАЧЕНИЕ(Перечисление.СпособыНачисленияАмортизацииОС.ПропорциональноОбъемуПродукции)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ПервоначальныеСведенияОС.ОсновноеСредство
	|ИЗ
	|	РегистрСведений.ПервоначальныеСведенияОС.СрезПоследних(, &РегистрацияНаработки) КАК ПервоначальныеСведенияОС
	|ГДЕ
	|	МетодНачисленияАмортизацииБУ = ЗНАЧЕНИЕ(Перечисление.СпособыНачисленияАмортизацииОС.ПропорциональноОбъемуПродукции)";

	//-- Локализация
	
	Возврат ТекстЗапроса;
	
КонецФункции

Функция МожноПринятьКУчету(СведенияОбУчете) Экспорт

	МожноПринятьКУчету = СведенияОбУчете.СостояниеБУ <> Перечисления.СостоянияОС.СнятоСУчета;
	
	//++ Локализация
	//-- Локализация
	
	Возврат МожноПринятьКУчету;
	
КонецФункции
 
#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Печать

//++ Локализация
//-- Локализация

#КонецОбласти

#Область ФормаЭлемента

Процедура ПрочитатьПериодическиеРеквизиты(Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
//++ Локализация
//-- Локализация

#КонецОбласти

#Область ФормаИсторияИзменений

Процедура ПриСозданииНаСервере_ИсторияИзменений(Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры
 
#КонецОбласти

#Область ФормаВыбора2_4

Процедура ПриСозданииНаСервере_ФормаВыбора2_4(Форма) Экспорт

	//++ Локализация
	//-- Локализация

КонецПроцедуры

#КонецОбласти

//++ Локализация
//-- Локализация

#Область ОбновлениеИнформационнойБазы

Процедура ДополнитьТекстЗапросаРегистрацииДанныхКОбработке(СписокЗапросов) Экспорт

	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(ДанныеОбъекта, ДопПараметры) Экспорт
	
	//++ Локализация
	//-- Локализация

КонецПроцедуры

#КонецОбласти

#КонецОбласти
