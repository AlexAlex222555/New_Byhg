
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоГруппа Тогда 
		Возврат;
	КонецЕсли;			
	
	РабочихДнейВНеделе = 0;
	Если СпособЗаполнения = Перечисления.СпособыЗаполненияГрафикаРаботы.ПоНеделям Тогда
		Для Каждого СтрокаТаблицы Из ШаблонЗаполнения Цикл
			Если СтрокаТаблицы.ДеньВключенВГрафик Тогда
				РабочихДнейВНеделе = РабочихДнейВНеделе + 1;
			КонецЕсли;
		КонецЦикла;	
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьПараметрыГрафикаПоУмолчанию() Экспорт
	ПроизводственныйКалендарь = КалендарныеГрафики.ПроизводственныйКалендарьУкраины();
	ДлительностьРабочейНедели = 40;
	УчитыватьПраздники = Истина;
	УчитыватьПредпраздничныеДни = Истина;
	СпособЗаполнения = Перечисления.СпособыЗаполненияГрафикаРаботы.ПоНеделям;
	
	ВидВремениЯвка = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыИспользованияРабочегоВремени.Явка");
	
	СтрокаВидВремени = ВидыВремени.Добавить();
	СтрокаВидВремени.ВидВремени = ВидВремениЯвка;
	
	Для НомерДня = 1 По 7 Цикл
		СтрокаШаблона = ШаблонЗаполнения.Добавить();
		СтрокаШаблона.ДеньВключенВГрафик = НомерДня < 6;
		
		СтрокаРасписания = ДанныеОРабочихЧасах.Добавить();
		СтрокаРасписания.ВидВремени = ВидВремениЯвка;
		СтрокаРасписания.НомерДняЦикла = НомерДня;
		СтрокаРасписания.Часов = ?(НомерДня < 6, 8, 0);
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьДанныеГрафика(ДанныеГрафика, НомерТекущегоГода) Экспорт
	
	КоличествоДнейВЦикле = ШаблонЗаполнения.Количество();

	Если КоличествоДнейВЦикле = 0 Тогда
		Возврат;
	КонецЕсли;	
	
	ИспользуемыеВидыВремени = Новый Массив;
	Для Каждого СтрокаВидаВремени Из ВидыВремени Цикл
		ИспользуемыеВидыВремени.Добавить(СтрокаВидаВремени.ВидВремени);
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Ночные", ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыИспользованияРабочегоВремени.РаботаНочныеЧасы"));
	Запрос.УстановитьПараметр("Вечерние", ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыИспользованияРабочегоВремени.РаботаВечерниеЧасы"));
	Запрос.УстановитьПараметр("Явка", ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыИспользованияРабочегоВремени.Явка"));
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ВидыИспользованияРабочегоВремени.Ссылка,
	|	ВЫБОР
	|		КОГДА ВидыИспользованияРабочегоВремени.ОсновноеВремя = &Ночные
	|				И ВидыИспользованияРабочегоВремени.Ссылка <> &Ночные
	|			ТОГДА 1
	|		КОГДА ВидыИспользованияРабочегоВремени.ОсновноеВремя = &Ночные
	|			ТОГДА 2
	|		КОГДА ВидыИспользованияРабочегоВремени.ОсновноеВремя = &Вечерние
	|				И ВидыИспользованияРабочегоВремени.Ссылка <> &Вечерние
	|			ТОГДА 3
	|		КОГДА ВидыИспользованияРабочегоВремени.ОсновноеВремя = &Вечерние
	|			ТОГДА 4
	|		КОГДА ВидыИспользованияРабочегоВремени.ОсновноеВремя = &Явка
	|				И ВидыИспользованияРабочегоВремени.Ссылка <> &Явка
	|			ТОГДА 5
	|		КОГДА ВидыИспользованияРабочегоВремени.ОсновноеВремя = &Явка
	|			ТОГДА 6
	|		ИНАЧЕ 7
	|	КОНЕЦ КАК Приоритет
	|ИЗ
	|	Справочник.ВидыИспользованияРабочегоВремени КАК ВидыИспользованияРабочегоВремени
	|
	|УПОРЯДОЧИТЬ ПО
	|	Приоритет";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ПриоритетВидовВремениДляПредпраздничных = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		ПриоритетВидовВремениДляПредпраздничных.Добавить(Выборка.Ссылка);		
	КонецЦикла;	
		
	ДлинаСуток = 86400;
	
	Если СпособЗаполнения = Перечисления.СпособыЗаполненияГрафикаРаботы.ПоЦикламПроизвольнойДлины Тогда
		ДатаНачалаИнтервалаЗаполнения = Макс(Дата(НомерТекущегоГода, 1, 1), ДатаОтсчета);
	Иначе
		ДатаНачалаИнтервалаЗаполнения = Дата(НомерТекущегоГода, 1, 1);	
	КонецЕсли;	
	ДатаОкончанияИнтервалаЗаполнения = КонецГода(ДатаНачалаИнтервалаЗаполнения);
		
	Если СпособЗаполнения = Перечисления.СпособыЗаполненияГрафикаРаботы.ПоНеделям Тогда
		НомерДняЦикла = ДеньНедели(ДатаНачалаИнтервалаЗаполнения);
	Иначе
		НомерДняЦикла = ((ДатаНачалаИнтервалаЗаполнения - ДатаОтсчета)/ДлинаСуток) % КоличествоДнейВЦикле + 1;
	КонецЕсли;	
	
	ЧасыПоДнямЦикла = УчетРабочегоВремениКлиентСервер.ДанныеГрафикаЧасыПоДнямЦикла(ШаблонЗаполнения, ДанныеОРабочихЧасах);
	
	ДанныеПроизводственногоКалендаря = Справочники.ПроизводственныеКалендари.ДанныеПроизводственногоКалендаря(ПроизводственныйКалендарь, НомерТекущегоГода);
	
	ОбрабатываемаяДата = ДатаНачалаИнтервалаЗаполнения;
	ПредыдущаяДата = '00010101';
	
	ПеренесенныеДни = Новый Массив;
	Пока ОбрабатываемаяДата <= ДатаОкончанияИнтервалаЗаполнения  Цикл
		
		ДанныеПроизводственногоКалендаряЗаДень = ДанныеПроизводственногоКалендаря.Найти(ОбрабатываемаяДата, "Дата");
		
		Если ДанныеПроизводственногоКалендаряЗаДень = Неопределено Тогда
			ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Рабочий;
			ДатаПереноса = '00010101';
		Иначе
			ВидДня = ДанныеПроизводственногоКалендаряЗаДень.ВидДня;
			ДатаПереноса = ДанныеПроизводственногоКалендаряЗаДень.ДатаПереноса;
		КонецЕсли;	
		
		НомерДняМесяца = День(ОбрабатываемаяДата);
		
		Если Месяц(ОбрабатываемаяДата) <> Месяц(ПредыдущаяДата) Или ПредыдущаяДата = '00010101' Тогда
			СтрокиГрафикаПоВидамВремени = СтрокиТаблицыГрафикаЗаМесяц(ДанныеГрафика, Месяц(ОбрабатываемаяДата));			
		КонецЕсли;	
		
		Если СпособЗаполнения = Перечисления.СпособыЗаполненияГрафикаРаботы.ПоНеделям Тогда
	        Если ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Суббота Тогда
				ЧасовЗаДень = ЧасыПоДнямЦикла[6];
			ИначеЕсли ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Воскресенье Тогда
				ЧасовЗаДень = ЧасыПоДнямЦикла[7];
			ИначеЕсли ДатаПереноса <> '00010101' Тогда
				ЧасовЗаДень = ЧасыПоДнямЦикла[ДеньНедели(ДатаПереноса)];	
			Иначе
				ЧасовЗаДень = ЧасыПоДнямЦикла[НомерДняЦикла];
			КонецЕсли;
		Иначе
			ЧасовЗаДень = ЧасыПоДнямЦикла[НомерДняЦикла];	
		КонецЕсли;	
			
		Если Не (УчитыватьПраздники И ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Праздник)
			И ПеренесенныеДни.Найти(ОбрабатываемаяДата) = Неопределено Тогда
			
			ЗаполнитьВремяЗаДень(ОбрабатываемаяДата, ВидДня, ЧасовЗаДень, СтрокиГрафикаПоВидамВремени, ПриоритетВидовВремениДляПредпраздничных);
		КонецЕсли;
				
		ОбрабатываемаяДата = ОбрабатываемаяДата + ДлинаСуток;
		
		НомерДняЦикла = НомерДняЦикла + 1;
		Если НомерДняЦикла > КоличествоДнейВЦикле Тогда
			НомерДняЦикла = 1;
		КонецЕсли;	
	КонецЦикла;	
	
	Для Каждого СтрокаГрафика Из ДанныеГрафика Цикл
		УчетРабочегоВремениКлиентСервер.ДанныеГрафикаРассчитатьИтогоПоСтроке(СтрокаГрафика);
	КонецЦикла;	
	
КонецПроцедуры	

Функция НовыйДанныеГрафика() Экспорт
	
	ДанныеГрафика = Новый ТаблицаЗначений;
	ДанныеГрафика.Колонки.Добавить("ВидВремени", Новый ОписаниеТипов("СправочникСсылка.ВидыИспользованияРабочегоВремени"));	
	ДанныеГрафика.Колонки.Добавить("НомерМесяца", Новый ОписаниеТипов("Число"));
	ДанныеГрафика.Колонки.Добавить("ИтогДни", Новый ОписаниеТипов("Число"));
	ДанныеГрафика.Колонки.Добавить("ИтогЧасы", Новый ОписаниеТипов("Число"));
	
	Для НомерДня = 1 По 31 Цикл
		ДанныеГрафика.Колонки.Добавить("День" + Формат(НомерДня, "ЧГ="), Новый ОписаниеТипов("Число"));		
	КонецЦикла;	
	
	Для НомерМесяца = 1 По 12 Цикл
		
		Для Каждого СтрокаВидВремени Из ВидыВремени Цикл
			ДанныеГрафикаЗаМесяц = ДанныеГрафика.Добавить();
			ДанныеГрафикаЗаМесяц.НомерМесяца = НомерМесяца;
			ДанныеГрафикаЗаМесяц.ВидВремени = СтрокаВидВремени.ВидВремени;
		КонецЦикла;	
		
	КонецЦикла;
	
	Возврат ДанныеГрафика;
	
КонецФункции
	
Функция СтрокиТаблицыГрафикаЗаМесяц(ДанныеГрафика, НомерМесяца)
	
	СтрокиПоВидамВремени = Новый Соответствие;
	
	СтрокиЗаМесяц = ДанныеГрафика.НайтиСтроки(Новый Структура("НомерМесяца", НомерМесяца));
	
	Для Каждого СтрокаТаблицы Из СтрокиЗаМесяц Цикл
		СтрокиПоВидамВремени.Вставить(СтрокаТаблицы.ВидВремени, СтрокаТаблицы);
	КонецЦикла;
	
	Возврат СтрокиПоВидамВремени;
	
КонецФункции

Процедура ЗаполнитьВремяЗаДень(ОбрабатываемаяДата, ВидДня, ЧасовЗаДень, СтрокиГрафикаПоВидамВремени, ПриоритетВидовВремениДляПредпраздничных)
	
	НомерДняМесяца = День(ОбрабатываемаяДата);
	
	Для Каждого ЧасыПоВидуВремени Из ЧасовЗаДень Цикл
		СтрокаТаблицыГрафика = СтрокиГрафикаПоВидамВремени.Получить(ЧасыПоВидуВремени.Ключ);	
		
		Если СтрокаТаблицыГрафика <> Неопределено Тогда
			СтрокаТаблицыГрафика["День" + НомерДняМесяца] = ЧасыПоВидуВремени.Значение;
		КонецЕсли;	
	КонецЦикла;	
	
	Если УчитыватьПредпраздничныеДни 
		И ВидДня = Перечисления.ВидыДнейПроизводственногоКалендаря.Предпраздничный Тогда
		
		ОсталосьВычестьЧасов = 1;
		Для Каждого ВидВремени Из ПриоритетВидовВремениДляПредпраздничных Цикл
			ЧасовПоВидуВремени = ЧасовЗаДень.Получить(ВидВремени);
			
			Если ЧасовПоВидуВремени <> Неопределено И ЧасовПоВидуВремени > 0 Тогда 
				СтрокаТаблицыГрафика = СтрокиГрафикаПоВидамВремени.Получить(ВидВремени);
				
				Если СтрокаТаблицыГрафика <> Неопределено Тогда
					КоличествоВычитаемыхЧасов = Мин(СтрокаТаблицыГрафика["День" + НомерДняМесяца], 1);
					СтрокаТаблицыГрафика["День" + НомерДняМесяца] = СтрокаТаблицыГрафика["День" + НомерДняМесяца] - КоличествоВычитаемыхЧасов;
					
					ОсталосьВычестьЧасов = ОсталосьВычестьЧасов - КоличествоВычитаемыхЧасов;
				КонецЕсли;	
				
				Если ОсталосьВычестьЧасов <= 0 Тогда
					Возврат;
				КонецЕсли;
			КонецЕсли;	
		КонецЦикла;	
	КонецЕсли;
	
КонецПроцедуры

Функция ДанныеГрафикаПоНастройкам(НомерГода) Экспорт
	
	ДанныеГрафика = НовыйДанныеГрафика();
	ЗаполнитьДанныеГрафика(ДанныеГрафика, НомерГода);
	
	Возврат ДанныеГрафика;
	
КонецФункции	

Процедура ЗаписатьДанныеГрафика(ДанныеГрафика, НомерГода) Экспорт
	
	Записать();
	УчетРабочегоВремени.ЗаписатьДанныеГрафика(Ссылка, ДанныеГрафика, НомерГода);
	
КонецПроцедуры	

#КонецОбласти

#КонецЕсли
