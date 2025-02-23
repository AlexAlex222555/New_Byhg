#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.ВидыЗапасов") Тогда
		
		Если РеквизитыВидаЗапасов(ДанныеЗаполнения).РеализацияЗапасовДругойОрганизации Тогда
			Текст = НСтр("ru='Выбранный вид запасов уже является реализацией запасов другой организации';uk='Вибраний вид запасів вже є реалізацією запасів іншої організації'");
			ВызватьИсключение Текст;	
		КонецЕсли;
		
		РеализацияЗапасовДругойОрганизации = Истина;
		ВидЗапасовВладельца = ДанныеЗаполнения;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	ПроверятьКомитента = ТипЗапасов = Перечисления.ТипыЗапасов.КомиссионныйТовар;
	//++ НЕ УТ
	Если ТипЗапасов = Перечисления.ТипыЗапасов.ПродукцияДавальца Тогда
		ПроверятьКомитента = Истина;
	КонецЕсли;
	//-- НЕ УТ
	Если Не ПроверятьКомитента Тогда 
		МассивНепроверяемыхРеквизитов.Добавить("Комитент");
	КонецЕсли;
	
	Если ТипЗапасов <> Перечисления.ТипыЗапасов.КомиссионныйТовар Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Валюта");
	КонецЕсли;
	
	ПроверятьПоставщика = Ложь;
	//++ НЕ УТ
	Если ТипЗапасов = Перечисления.ТипыЗапасов.МатериалДавальца Тогда
		ПроверятьПоставщика = Истина;
	КонецЕсли;
	//-- НЕ УТ
	Если Не ПроверятьПоставщика Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Поставщик");
	КонецЕсли;
	
	Если Не РеализацияЗапасовДругойОрганизации Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ВидЗапасовВладельца");
		МассивНепроверяемыхРеквизитов.Добавить("СпособПередачиТоваров");
	КонецЕсли;
	
	Если РеализацияЗапасовДругойОрганизации Тогда
		
		Реквизиты = РеквизитыВидаЗапасов(ВидЗапасовВладельца);
		Если Реквизиты.РеализацияЗапасовДругойОрганизации Тогда
			Текст = НСтр("ru='Указан вид запасов являющийся реализацией запасов другой организации';uk='Вказаний вид запасів є реалізацією запасів іншої організації'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				Текст,
				Ссылка,
				"ВидЗапасовВладельца",
				,
				Отказ);
		КонецЕсли;
		
		Если Реквизиты.Организация = Организация Тогда
			Текст = НСтр("ru='Организация равна организации - владельцу товара';uk='Організація дорівнює організації - власника товару'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				Текст,
				ЭтотОбъект,
				"Организация",
				,
				Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(
		ПроверяемыеРеквизиты,
		МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если РеализацияЗапасовДругойОрганизации Тогда
		Если СпособПередачиТоваров = Перечисления.СпособыПередачиТоваров.ПередачаНаКомиссию Тогда
			ТекущийТипЗапасов = Перечисления.ТипыЗапасов.КомиссионныйТовар;
		Иначе
			ТекущийТипЗапасов = Перечисления.ТипыЗапасов.Товар;
		КонецЕсли;
		Если ТипЗапасов <> ТекущийТипЗапасов Тогда
			ТипЗапасов = ТекущийТипЗапасов;
		КонецЕсли;
	КонецЕсли;
	
	Если ТипЗапасов = Перечисления.ТипыЗапасов.КомиссионныйТовар
		//++ НЕ УТ
		ИЛИ ТипЗапасов = Перечисления.ТипыЗапасов.ПродукцияДавальца 
		ИЛИ ТипЗапасов = Перечисления.ТипыЗапасов.МатериалДавальца
		ИЛИ ТипЗапасов = Перечисления.ТипыЗапасов.ТоварТребующийПодтвержденияВыпуска
		//-- НЕ УТ
		ИЛИ ТипЗапасов = Перечисления.ТипыЗапасов.ТоварНаХраненииСПравомПродажи Тогда
		ОчищатьВладельца = Ложь;
	Иначе
		ОчищатьВладельца = Истина;
	КонецЕсли;
	
	Если ОчищатьВладельца 
		 И (ЗначениеЗаполнено(ВладелецТовара) ИЛИ ВладелецТовара <> Неопределено) Тогда
		ВладелецТовара = Неопределено;
	ИначеЕсли Не ОчищатьВладельца И Не ЗначениеЗаполнено(ВладелецТовара) Тогда
		ТекстИсключения = НСтр("ru='Для вида запасов не заполнен владелец!';uk='Для виду запасів не заповнений власник!'");
		ВызватьИсключение ТекстИсключения;
	КонецЕсли;
	
	Если ТипЗапасов <> Перечисления.ТипыЗапасов.КомиссионныйТовар
		И ТипЗапасов <> Перечисления.ТипыЗапасов.ТоварНаХраненииСПравомПродажи Тогда
		Если ЗначениеЗаполнено(Соглашение) Тогда
			Соглашение = Неопределено;
		КонецЕсли;
		Если ЗначениеЗаполнено(Валюта) Тогда
			Валюта = Неопределено;
		КонецЕсли;
	КонецЕсли;
	
	Если ТипЗапасов <> Перечисления.ТипыЗапасов.ТоварНаХраненииСПравомПродажи 
		И ТипЗапасов <> Перечисления.ТипыЗапасов.СобственныйТоварВПути 
		И ТипЗапасов <> Перечисления.ТипыЗапасов.СобственныйТоварПоНеотфактурованнойПоставке Тогда
		ВидЦены = Неопределено;
	КонецЕсли;
	
	Наименование = НаименованиеВидаЗапасов(ЭтотОбъект);
	
	Если Не РеализацияЗапасовДругойОрганизации
	   И ЗначениеЗаполнено(ВидЗапасовВладельца) Тогда
		ВидЗапасовВладельца = Неопределено;
	КонецЕсли;
		
	Если Не РеализацияЗапасовДругойОрганизации 
		И ПометкаУдаления Тогда
			ПометитьНаУдалениеВидыЗапасовИнтеркомпани();
	КонецЕсли;
	
	Справочники.ВидыЗапасов.ОбработатьРеквизитыОбъекта(ЭтотОбъект);
	
	Если ЭтоНовый() Тогда
		Попытка
			Справочники.ВидыЗапасов.СтруктураВидаЗапасов(Организация,, ЭтотОбъект);
		Исключение
			ПредставлениеОшибки = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ПредставлениеОшибки,,,, Отказ);
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	ПроверитьДубли(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

Процедура ПометитьНаУдалениеВидыЗапасовИнтеркомпани()
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ДанныеСправочника.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ВидыЗапасов КАК ДанныеСправочника
	|ГДЕ
	|	ДанныеСправочника.ВидЗапасовВладельца = &ВидЗапасов
	|	И НЕ ДанныеСправочника.ПометкаУдаления
	|");
	Запрос.УстановитьПараметр("ВидЗапасов", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		
		СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
		СправочникОбъект.УстановитьПометкуУдаления(Истина, Ложь);
		
	КонецЦикла;
	
КонецПроцедуры

Функция РеквизитыВидаЗапасов(ВидЗапасов)
	
	СтруктураРеквизитов = Новый Структура("РеализацияЗапасовДругойОрганизации, Организация, Валюта, ТипЗапасов");
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	ВидыЗапасов.РеализацияЗапасовДругойОрганизации КАК РеализацияЗапасовДругойОрганизации,
	|	ВидыЗапасов.Организация КАК Организация,
	|	ВидыЗапасов.Валюта КАК Валюта,
	|	ВидыЗапасов.ТипЗапасов КАК ТипЗапасов
	|ИЗ
	|	Справочник.ВидыЗапасов КАК ВидыЗапасов
	|ГДЕ
	|	ВидыЗапасов.Ссылка = &ВидЗапасов
	|");
	
	Запрос.УстановитьПараметр("ВидЗапасов", ВидЗапасов);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(СтруктураРеквизитов, Выборка);
	Иначе
		СтруктураРеквизитов.РеализацияЗапасовДругойОрганизации = Ложь;
		СтруктураРеквизитов.Организация = Справочники.Организации.ПустаяСсылка();
		СтруктураРеквизитов.Валюта = Справочники.Валюты.ПустаяСсылка();
		СтруктураРеквизитов.ТипЗапасов = Перечисления.ТипыЗапасов.ПустаяСсылка();
	КонецЕсли;
	
	Возврат СтруктураРеквизитов;
КонецФункции

Функция НаименованиеВидаЗапасов(СправочникОбъект) Экспорт
    
	КодЯзыкаИБ = МультиязычностьУкрПовтИсп.КодЯзыкаИнформационнойБазы();
	
	Если ЗначениеЗаполнено(СправочникОбъект.НалоговоеНазначение) Тогда
		СтрокаНалогообложение = Строка(СправочникОбъект.НалоговоеНазначение);
	Иначе	
	    СтрокаНалогообложение = "";
	КонецЕсли; 
	
	НаименованиеМассив = Новый Массив;
	НаименованиеМассив.Добавить(Строка(СправочникОбъект.ТипЗапасов));
	
	Если СправочникОбъект.ТипЗапасов = Перечисления.ТипыЗапасов.КомиссионныйТовар Тогда
		
        НаименованиеМассив.Добавить(НСтр("ru='Комитент:';uk='Комітент:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.ВладелецТовара));
		Если ЗначениеЗаполнено(СправочникОбъект.Соглашение) Тогда
            НаименованиеМассив.Добавить(НСтр("ru='Соглашение:';uk='Оферта:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.Соглашение));
		КонецЕсли;
		Если ЗначениеЗаполнено(СправочникОбъект.Договор) Тогда
            НаименованиеМассив.Добавить(НСтр("ru='Договор:';uk='Договір:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.Договор));
        КонецЕсли;
        НаименованиеМассив.Добавить(НСтр("ru='Валюта:';uk='Валюта:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.Валюта));
		
	//++ НЕ УТ
	ИначеЕсли СправочникОбъект.ТипЗапасов = Перечисления.ТипыЗапасов.ПродукцияДавальца 
		Или СправочникОбъект.ТипЗапасов = Перечисления.ТипыЗапасов.МатериалДавальца Тогда
			 
        НаименованиеМассив.Добавить(НСтр("ru='Давалец:';uk='Давалець:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.ВладелецТовара));
		Если ЗначениеЗаполнено(СправочникОбъект.Договор) Тогда
            НаименованиеМассив.Добавить(НСтр("ru='Договор:';uk='Договір:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.Договор));
		КонецЕсли;

	//-- НЕ УТ
	ИначеЕсли СправочникОбъект.ТипЗапасов = Перечисления.ТипыЗапасов.ТоварНаХраненииСПравомПродажи Тогда
		
        НаименованиеМассив.Добавить(НСтр("ru='Поклажедатель:';uk='Поклажодавець:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.ВладелецТовара));
        НаименованиеМассив.Добавить(НСтр("ru='Договор:';uk='Договір:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.Договор));
        НаименованиеМассив.Добавить(НСтр("ru='Вид цены:';uk='Вид ціни:'",КодЯзыкаИБ)+ Символы.НПП + Строка(СправочникОбъект.ВидЦены));
		
    КонецЕсли;
    
	НаименованиеМассив.Добавить(СтрокаНалогообложение);
	
	Если ЗначениеЗаполнено(СправочникОбъект.ГруппаФинансовогоУчета) Тогда
        НаименованиеМассив.Добавить(НСтр("ru='Группа:';uk='Група:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.ГруппаФинансовогоУчета));
	КонецЕсли;
	
    НаименованиеМассив.Добавить(НСтр("ru='Организация:';uk='Організація:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.Организация));
		
	Если ЗначениеЗаполнено(СправочникОбъект.ГруппаПродукции) Тогда
        НаименованиеМассив.Добавить(НСтр("ru='Группа продукции:';uk='Група продукції:'",КодЯзыкаИБ) + Символы.НПП + Строка(СправочникОбъект.ГруппаПродукции));
	КонецЕсли;	
	
	Если СправочникОбъект.РеализацияЗапасовДругойОрганизации Тогда
        НаименованиеМассив.Добавить(НСтр("ru='Запасы другой организации';uk='Запаси іншої організації'",КодЯзыкаИБ));
    КонецЕсли;
		
	Возврат СтрСоединить(НаименованиеМассив, "; ");

КонецФункции

Процедура ПроверитьДубли(СправочникОбъект)
	
	Если СправочникОбъект.ДополнительныеСвойства.Свойство("НеПроверятьДубли")
		ИЛИ СправочникОбъект.ЭтоДубль Тогда // с этим свойством пишем изменяемые элементы в РИБ
		Возврат;
	КонецЕсли;
	
	НачатьТранзакцию();
	Попытка
		Блокировка = Новый БлокировкаДанных;
			
		ЭлементБлокировки = Блокировка.Добавить("Справочник.ВидыЗапасов");
		ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
		ЭлементБлокировки.УстановитьЗначение("Организация",СправочникОбъект.Организация);
		ЭлементБлокировки.УстановитьЗначение("ТипЗапасов",СправочникОбъект.ТипЗапасов);
        ЭлементБлокировки.УстановитьЗначение("НалоговоеНазначение",СправочникОбъект.НалоговоеНазначение);
		ЭлементБлокировки.УстановитьЗначение("ВладелецТовара",СправочникОбъект.ВладелецТовара);
		ЭлементБлокировки.УстановитьЗначение("Соглашение",СправочникОбъект.Соглашение);
		ЭлементБлокировки.УстановитьЗначение("Валюта",СправочникОбъект.Валюта);
		ЭлементБлокировки.УстановитьЗначение("РеализацияЗапасовДругойОрганизации",СправочникОбъект.РеализацияЗапасовДругойОрганизации);
		ЭлементБлокировки.УстановитьЗначение("ВидЗапасовВладельца",СправочникОбъект.ВидЗапасовВладельца);
		ЭлементБлокировки.УстановитьЗначение("СпособПередачиТоваров",СправочникОбъект.СпособПередачиТоваров);
		ЭлементБлокировки.УстановитьЗначение("УстарелоПоставщик",СправочникОбъект.УстарелоПоставщик);
		ЭлементБлокировки.УстановитьЗначение("УстарелоПредназначение",СправочникОбъект.УстарелоПредназначение);
		ЭлементБлокировки.УстановитьЗначение("УстарелоПодразделение",СправочникОбъект.УстарелоПодразделение);
		ЭлементБлокировки.УстановитьЗначение("УстарелоМенеджер",СправочникОбъект.УстарелоМенеджер);
		ЭлементБлокировки.УстановитьЗначение("УстарелоСделка",СправочникОбъект.УстарелоСделка);
		ЭлементБлокировки.УстановитьЗначение("ГруппаФинансовогоУчета",СправочникОбъект.ГруппаФинансовогоУчета);
		ЭлементБлокировки.УстановитьЗначение("Контрагент",СправочникОбъект.Контрагент);
		ЭлементБлокировки.УстановитьЗначение("Договор",СправочникОбъект.Договор);
		ЭлементБлокировки.УстановитьЗначение("УстарелоНазначение",СправочникОбъект.УстарелоНазначение);
		ЭлементБлокировки.УстановитьЗначение("ГруппаПродукции",СправочникОбъект.ГруппаПродукции);
		ЭлементБлокировки.УстановитьЗначение("ВидЦены",СправочникОбъект.ВидЦены);
		
		Блокировка.Заблокировать();
		
		Запрос = Новый Запрос("
		|ВЫБРАТЬ
		|	ВидыЗапасов.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ВидыЗапасов КАК ВидыЗапасов
		|ГДЕ
		|	ВидыЗапасов.Организация = &Организация
		|	И ВидыЗапасов.ТипЗапасов = &ТипЗапасов
        |	И ВидыЗапасов.НалоговоеНазначение = &НалоговоеНазначение
		|	И ВидыЗапасов.ВладелецТовара = &ВладелецТовара
		|	И ВидыЗапасов.Соглашение = &Соглашение
		|	И ВидыЗапасов.Валюта = &Валюта
		|	И ВидыЗапасов.РеализацияЗапасовДругойОрганизации = &РеализацияЗапасовДругойОрганизации
		|	И ВидыЗапасов.ВидЗапасовВладельца = &ВидЗапасовВладельца
		|	И ВидыЗапасов.СпособПередачиТоваров = &СпособПередачиТоваров
		|	И ВидыЗапасов.УстарелоПоставщик = &УстарелоПоставщик
		|	И ВидыЗапасов.УстарелоПредназначение = &УстарелоПредназначение
		|	И ВидыЗапасов.УстарелоПодразделение = &УстарелоПодразделение
		|	И ВидыЗапасов.УстарелоМенеджер = &УстарелоМенеджер
		|	И ВидыЗапасов.УстарелоСделка = &УстарелоСделка
		|	И ВидыЗапасов.ГруппаФинансовогоУчета = &ГруппаФинансовогоУчета
		|	И ВидыЗапасов.Контрагент = &Контрагент
		|	И ВидыЗапасов.Договор = &Договор
		|	И ВидыЗапасов.УстарелоНазначение = &УстарелоНазначение
		|	И ВидыЗапасов.ГруппаПродукции = &ГруппаПродукции
		|	И ВидыЗапасов.ВидЦены = &ВидЦены
		|	И ВидыЗапасов.Устаревший = &Устаревший
		|	И НЕ ВидыЗапасов.ЭтоДубль
		|	И ВидыЗапасов.Ссылка <> &Ссылка
		|");
		
		Запрос.УстановитьПараметр("Организация", СправочникОбъект.Организация);
		Запрос.УстановитьПараметр("ТипЗапасов", СправочникОбъект.ТипЗапасов);
        Запрос.УстановитьПараметр("НалоговоеНазначение", СправочникОбъект.НалоговоеНазначение);
		Запрос.УстановитьПараметр("ВладелецТовара", СправочникОбъект.ВладелецТовара);
		Запрос.УстановитьПараметр("Соглашение", СправочникОбъект.Соглашение);
		Запрос.УстановитьПараметр("Валюта", СправочникОбъект.Валюта);
		Запрос.УстановитьПараметр("РеализацияЗапасовДругойОрганизации", СправочникОбъект.РеализацияЗапасовДругойОрганизации);
		Запрос.УстановитьПараметр("ВидЗапасовВладельца", СправочникОбъект.ВидЗапасовВладельца);
		Запрос.УстановитьПараметр("СпособПередачиТоваров", СправочникОбъект.СпособПередачиТоваров);
		Запрос.УстановитьПараметр("УстарелоПоставщик", СправочникОбъект.УстарелоПоставщик);
		Запрос.УстановитьПараметр("УстарелоПредназначение", СправочникОбъект.УстарелоПредназначение);
		Запрос.УстановитьПараметр("УстарелоПодразделение", СправочникОбъект.УстарелоПодразделение);
		Запрос.УстановитьПараметр("УстарелоМенеджер", СправочникОбъект.УстарелоМенеджер);
		Запрос.УстановитьПараметр("УстарелоСделка", СправочникОбъект.УстарелоСделка);
		Запрос.УстановитьПараметр("ГруппаФинансовогоУчета", СправочникОбъект.ГруппаФинансовогоУчета);
		Запрос.УстановитьПараметр("Контрагент", СправочникОбъект.Контрагент);
		Запрос.УстановитьПараметр("Договор", СправочникОбъект.Договор);
		Запрос.УстановитьПараметр("УстарелоНазначение", СправочникОбъект.УстарелоНазначение);
		Запрос.УстановитьПараметр("ГруппаПродукции", СправочникОбъект.ГруппаПродукции);
		Запрос.УстановитьПараметр("ВидЦены", СправочникОбъект.ВидЦены);
		Запрос.УстановитьПараметр("Устаревший", СправочникОбъект.Устаревший);
		Запрос.УстановитьПараметр("Ссылка", СправочникОбъект.Ссылка);
		
		Результат = Запрос.Выполнить();
		
		Если Результат.Пустой() Тогда // нет дублей
			ЗафиксироватьТранзакцию();
			Возврат;
		КонецЕсли;
		
		ЭтоГлавныйУзел = ПланыОбмена.ГлавныйУзел() = Неопределено;
		
		// Дубли могут образовываться только при РИБ, остальные ситуации ошибочны.
		// Виды запасов которые создаются или загружаются из главного узла - считаем корректными,
		// остальные помечаем всегда как дубль.
		Если ОбменДанными.Загрузка Тогда
			Если ЭтоГлавныйУзел Тогда // загружаемые из подчиненного узла считаем дублями.
				СправочникОбъект.ЭтоДубль = Истина;
				СправочникОбъект.ДополнительныеСвойства.Вставить("НеПроверятьДубли", Истина);
				СправочникОбъект.Записать();
			Иначе // выполняется запись в подчиненном узле.
				  // Данные приехавшие из главного узла считаем корректными,
				  // существующие - помечаем как дубли.
				Выборка = Результат.Выбрать();
				Пока Выборка.Следующий() Цикл
					ДубльВидаЗапасов = Выборка.Ссылка.ПолучитьОбъект();
					ДубльВидаЗапасов.ЭтоДубль = Истина;
					ДубльВидаЗапасов.ОбменДанными.Загрузка = Истина;
					ДубльВидаЗапасов.ДополнительныеСвойства.Вставить("НеПроверятьДубли", Истина);
					ДубльВидаЗапасов.Записать();
				КонецЦикла;
			КонецЕсли;
		Иначе
			ТекстСообщения = НСтр("ru='При записи нового элемента справочника ""Виды запасов"" образуются дубли!';uk='При запису нового елемента довідника ""Види запасів"" утворюються дублі!'");
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ТекстСообщения = НСтр("ru='Не удалось записать справочник Виды запасов по причине: %Причина%';uk='Не вдалося записати довідник Види запасів через: %Причина%'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%Причина%", ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ЗаписьЖурналаРегистрации(НСтр("ru='Запись Видов запасов';uk='Запис Видів запасів'",ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка()),
			УровеньЖурналаРегистрации.Ошибка,
			Метаданные.Справочники.ВидыЗапасов,
			,
			ТекстСообщения);
		ВызватьИсключение;
	КонецПопытки;
		
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
