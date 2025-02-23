
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОтборВедомостей = Новый Структура;
	Параметры.Свойство("ОтборВедомостей", ОтборВедомостей);
	
	Если ОтборВедомостей.Свойство("ХозяйственнаяОперация") Тогда
		
		Элементы.ЗарплатныйПроект.Видимость =
			ОтборВедомостей.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ВыплатаЗарплатыПоЗарплатномуПроекту;
		
		ВедомостиДляПеречисленияНалога =
			ОтборВедомостей.ХозяйственнаяОперация = Перечисления.ХозяйственныеОперации.ПеречислениеВБюджет;
		
	КонецЕсли;
	
	Если Параметры.Свойство("ЗаявкаНаОплату") Тогда
		ОтборВедомостей.Вставить("МассивВедомостей", ПолучитьВедомостейПоЗаявкеНаОплату(Параметры.ЗаявкаНаОплату));
	КонецЕсли;
	
	ИсключатьОплаченные = Параметры.Свойство("ИсключатьОплаченные") И Параметры.ИсключатьОплаченные;
	
	ИсточникВыбора = Неопределено;
	Параметры.Свойство("Источник", ИсточникВыбора);
	
	УстановитьОтборВедомостей(ОтборВедомостей, ИсключатьОплаченные, ИсточникВыбора);
	
	
	Если ВедомостиДляПеречисленияНалога Тогда
		
		Заголовок = НСтр("ru='Перечисление налога по ведомостям';uk='Перерахування податку по відомостях'");
		
		
	КонецЕсли;
	
	Элементы.СписокСумма.Видимость = Не ВедомостиДляПеречисленияНалога;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РегистрацияВНалоговомОрганеПриИзменении(Элемент)
	УстановитьОтборНалоговогоОргана();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ТекущиеДанные = Элементы.Список.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		Если ВедомостиДляПеречисленияНалога Тогда
			ЗначениеВыбора = Новый Структура("Ведомость, Сумма, Получатель",
				ТекущиеДанные.Ссылка, ТекущиеДанные.СуммаНДФЛ, ТекущиеДанные.Получатель);
		Иначе	
			ЗначениеВыбора = Новый Структура("Ведомость, Сумма, Получатель",
				ТекущиеДанные.Ссылка, ТекущиеДанные.Сумма, ТекущиеДанные.Получатель);
		КонецЕсли; 
		ОповеститьОВыборе(ЗначениеВыбора);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьОтборВедомостей(ПараметрыОтбора, ИсключатьОплаченные, Источник)
	
	УстановитьПривилегированныйРежим(Истина);
	
	МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	ИнтеграцияБЗК.ПодготовитьДанныеОСостоянииВедомостей(МенеджерВременныхТаблиц, ПараметрыОтбора);
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("ВключаяОплаченные", НЕ ИсключатьОплаченные);
	Запрос.УстановитьПараметр("ВключаяДепонированные", ТипЗнч(Источник) = Тип("ДокументСсылка.РасходныйКассовыйОрдер"));
	Запрос.УстановитьПараметр("ИсключатьВключенныеВЗаявки", ТипЗнч(Источник) = Тип("ДокументСсылка.ЗаявкаНаРасходованиеДенежныхСредств"));
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	СостояниеВедомостей.Ведомость КАК Ведомость
	|ИЗ
	|	ВТСостояниеВыплатыПоВедомостям КАК СостояниеВедомостей
	|	ЛЕВОЕ СОЕДИНЕНИЕ ВТЗаявкиВедомостей КАК ЗаявкиВедомостей
	|	ПО СостояниеВедомостей.Ведомость = ЗаявкиВедомостей.Ведомость
	|		И ЗаявкиВедомостей.ХозяйственнаяОперация = ЗНАЧЕНИЕ(Перечисление.ХозяйственныеОперации.ВыплатаЗарплаты)
	|ГДЕ
	|	(&ВключаяОплаченные
	|		ИЛИ СостояниеВедомостей.СуммаОплаты = 0
	|		ИЛИ (&ВключаяДепонированные И СостояниеВедомостей.Депонирована))
	|	И (НЕ &ИсключатьВключенныеВЗаявки
	|		ИЛИ ЗаявкиВедомостей.Ссылка ЕСТЬ NULL)
	|";
	
	Результат = Запрос.Выполнить().Выгрузить();
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		"Ссылка",
		Результат.ВыгрузитьКолонку("Ведомость"),
		ВидСравненияКомпоновкиДанных.ВСписке,,
		Истина);
	
КонецПроцедуры

&НаСервере
Функция ПолучитьВедомостейПоЗаявкеНаОплату(Заявка)

	Запрос = Новый Запрос(
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РасшифровкаЗаявки.Ведомость КАК Ведомость
	|ИЗ
	|	Документ.ЗаявкаНаРасходованиеДенежныхСредств.РасшифровкаПлатежа КАК РасшифровкаЗаявки
	|ГДЕ
	|	РасшифровкаЗаявки.Ссылка = &Заявка");
	
	Запрос.УстановитьПараметр("Заявка", Заявка);
	
	Результат = Запрос.Выполнить().Выгрузить();
	Возврат Результат.ВыгрузитьКолонку("Ведомость");

КонецФункции

&НаСервере
Процедура УстановитьОтборНалоговогоОргана()
	
	
КонецПроцедуры

#КонецОбласти