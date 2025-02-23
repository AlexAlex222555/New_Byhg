
#Область СлужебныйПрограммныйИнтерфейс

// Заполнение сведений о показателях, используемых при расчете результата предопределенным способом.
//
// Параметры:
//	- ТаблицаПоказателей - таблица значений с колонками
//		СпособРасчета.
//		Показатель
//
Процедура ЗаполнитьПоказателиРасчетаПростоевСотрудников(ТаблицаПоказателей) Экспорт
	
	// Простои сотрудников
	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.Оклад");
	
	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ОкладПоДолжности");
	
	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ВремяВДняхЧасах");
	
	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.НормаВремениВДнях");

	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.НормаДней");

	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ТарифнаяСтавкаДневная");
	
	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ДневнойТарифПоДолжности");
	
	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.НормаВремениВЧасах");
	
	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.СтоимостьДняЧаса");
	
	НоваяСтрока = ТаблицаПоказателей.Добавить();
	НоваяСтрока.СпособРасчета = Перечисления.СпособыРасчетаНачислений.ОплатаПростоя;
	НоваяСтрока.Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.ДоляНеполногоРабочегоВремени");
	
КонецПроцедуры

// Метод выполняет расчет записей с предопределенным способом расчета ОплатаПростоя.
//
Процедура РассчитатьОплатуПростоя(СпособРасчета, СтрокиТаблицыРасчета, НаборыЗаписей, ДокументСсылка) Экспорт
	
	Если СпособРасчета <> Перечисления.СпособыРасчетаНачислений.ОплатаПростоя Тогда
		Возврат;
	КонецЕсли;	
		
	РассчитатьОплатуПростояПоНезависящимПричинам(СтрокиТаблицыРасчета);
			
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Метод выполняет расчет записей с предопределенным способом расчета ОплатаПростоя.
//
Процедура РассчитатьОплатуПростояПоНезависящимПричинам(СтрокиТаблицыРасчета)
	
	СтрокиРасчетаПоСотрудникамПериодам = СтрокиРасчетаПоСотрудникамПериодам(СтрокиТаблицыРасчета);
	
	ЗапросТарифныеСтавкиСотрудников = ЗапросТарифныеСтавкиСотрудников(СтрокиРасчетаПоСотрудникамПериодам);
	
	ТарифныеСтавкиСотрудников = ЗапросТарифныеСтавкиСотрудников.Выполнить();
	
	ОписанияПоказателейТарифнойСтавки = ОписанияПоказателейТарифнойСтавки(ТарифныеСтавкиСотрудников);
	
	Выборка = ТарифныеСтавкиСотрудников.Выбрать();

	Пока Выборка.Следующий() Цикл
		
		СтруктураПоиска = Новый Структура("Сотрудник, Период", Выборка.Сотрудник, Выборка.Период);
		СтрокиТаблицыПоСотрудникуЗаПериод = СтрокиРасчетаПоСотрудникамПериодам.НайтиСтроки(СтруктураПоиска);			
		
		Для Каждого ДанныеПоСотрудникуЗаПериод Из СтрокиТаблицыПоСотрудникуЗаПериод Цикл 
			
			ИсходныеДанные 	= ДанныеПоСотрудникуЗаПериод.СтрокаТаблицыРасчета.ИсходныеДанные;
			ЗаписьРасчета 	= ДанныеПоСотрудникуЗаПериод.СтрокаТаблицыРасчета.ЗаписьРасчета;
			
			Если ЗаписьРасчета.ФиксРасчет
				Или ЗаписьРасчета.ФиксСторно Тогда
				ИсходныеДанные.Результат = ЗаписьРасчета.Результат;
				Продолжить;
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(Выборка.ПоказательТарифнойСтавки) Тогда 
				Продолжить;
			КонецЕсли;
			
			ОписаниеПоказателяТарифнойСтавкиСотрудника = ОписанияПоказателейТарифнойСтавки.Получить(Выборка.ПоказательТарифнойСтавки);
			
			Если ОписаниеПоказателяТарифнойСтавкиСотрудника.ВидТарифнойСтавки = Перечисления.ВидыТарифныхСтавок.ЧасоваяТарифнаяСтавка Тогда
				
				ИсходныеДанные.Результат = Выборка.ТарифнаяСтавка * (2/3) * ИсходныеДанные.ВремяВДняхЧасах;	
												
			ИначеЕсли ОписаниеПоказателяТарифнойСтавкиСотрудника.ВидТарифнойСтавки = Перечисления.ВидыТарифныхСтавок.МесячнаяТарифнаяСтавка Тогда
				
				ДоляНеполногоВремени 	= ДоляНеполногоВремени(Выборка, ЗаписьРасчета, ИсходныеДанные); 
				НормаВремени 			= НормаВремени(Выборка, ЗаписьРасчета, ИсходныеДанные);	
				
				ИсходныеДанные.Результат = Выборка.ТарифнаяСтавка * (2/3) * ДоляНеполногоВремени * ИсходныеДанные.ВремяВДняхЧасах /  НормаВремени;
				
			Иначе
				
				ИсходныеДанные.Результат = ИсходныеДанные.СтоимостьДняЧаса * (2/3) * ИсходныеДанные.ВремяВДняхЧасах;
				
			КонецЕсли;	
			
		КонецЦикла;	
		
	КонецЦикла;		
	
КонецПроцедуры

Функция СтрокиРасчетаПоСотрудникамПериодам(СтрокиТаблицыРасчета)
	
	СтрокиРасчетаПоСотрудникамПериодам = Новый ТаблицаЗначений;
	СтрокиРасчетаПоСотрудникамПериодам.Колонки.Добавить("Сотрудник", Новый ОписаниеТипов("СправочникСсылка.Сотрудники"));
	СтрокиРасчетаПоСотрудникамПериодам.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	СтрокиРасчетаПоСотрудникамПериодам.Колонки.Добавить("СтрокаТаблицыРасчета");
	
	Для Каждого СтрокаТаблицы Из СтрокиТаблицыРасчета Цикл		
		СтрокаТаблицыСотрудниковПериодов = СтрокиРасчетаПоСотрудникамПериодам.Добавить();
		СтрокаТаблицыСотрудниковПериодов.Сотрудник = СтрокаТаблицы.ЗаписьРасчета.Сотрудник;
		СтрокаТаблицыСотрудниковПериодов.Период = СтрокаТаблицы.ЗаписьРасчета.ДатаНачала;
		СтрокаТаблицыСотрудниковПериодов.СтрокаТаблицыРасчета = СтрокаТаблицы;
	КонецЦикла;	
	
	Возврат СтрокиРасчетаПоСотрудникамПериодам;
	
КонецФункции 

Процедура СоздатьВТКадровыхДанныхДляРасчетаПростоя(Запрос, ТаблицаСотрудников)
	
	Запрос.УстановитьПараметр("ТаблицаСотрудников", ТаблицаСотрудников);
	
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ТаблицаСотрудников.Сотрудник,
	|	ТаблицаСотрудников.Период
	|ПОМЕСТИТЬ ВТСотрудники
	|ИЗ
	|	&ТаблицаСотрудников КАК ТаблицаСотрудников";
	
	Запрос.Выполнить();
	
	ОписательВТКадровыеДанные = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеСотрудников(
	Запрос.МенеджерВременныхТаблиц,
	"ВТСотрудники");
	
	КадровыйУчет.СоздатьВТКадровыеДанныеСотрудников(ОписательВТКадровыеДанные, Истина, "ОсновноеНачисление,ПоказательТарифнойСтавки,ТарифнаяСтавка");
	
КонецПроцедуры

Функция ЗапросТарифныеСтавкиСотрудников(СтрокиРасчетаПоСотрудникамПериодам)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	СоздатьВТКадровыхДанныхДляРасчетаПростоя(Запрос, СтрокиРасчетаПоСотрудникамПериодам);

	Запрос.Текст = 
	"ВЫБРАТЬ
	|	КадровыеДанныеСотрудников.Период,
	|	КадровыеДанныеСотрудников.ПоказательТарифнойСтавки,
	|	КадровыеДанныеСотрудников.ТарифнаяСтавка,
	|	КадровыеДанныеСотрудников.Сотрудник,
	|	ОписаниеНачислений.УчетВремениВЧасах,
	|	МАКСИМУМ(ПоказателиДоляНеполногоРабочегоВремени.Показатель) КАК ПоказательДоляНеполногоРабочегоВремени
	|ИЗ
	|	ВТКадровыеДанныеСотрудников КАК КадровыеДанныеСотрудников
	|		ЛЕВОЕ СОЕДИНЕНИЕ ПланВидовРасчета.Начисления КАК ОписаниеНачислений
	|		ПО КадровыеДанныеСотрудников.ОсновноеНачисление = ОписаниеНачислений.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ ПланВидовРасчета.Начисления.Показатели КАК ПоказателиДоляНеполногоРабочегоВремени
	|		ПО КадровыеДанныеСотрудников.ОсновноеНачисление = ПоказателиДоляНеполногоРабочегоВремени.Ссылка
	|			И (ПоказателиДоляНеполногоРабочегоВремени.Показатель = ЗНАЧЕНИЕ(Справочник.ПоказателиРасчетаЗарплаты.ДоляНеполногоРабочегоВремени))
	|
	|СГРУППИРОВАТЬ ПО
	|	КадровыеДанныеСотрудников.Период,
	|	КадровыеДанныеСотрудников.ПоказательТарифнойСтавки,
	|	КадровыеДанныеСотрудников.ТарифнаяСтавка,
	|	КадровыеДанныеСотрудников.Сотрудник,
	|	ОписаниеНачислений.УчетВремениВЧасах";
	
	Возврат Запрос;

КонецФункции

Функция ОписанияПоказателейТарифнойСтавки(ТарифныеСтавкиСотрудников)
	
	ПоказателиТарифнойСтавки = Новый Массив;
	
	Выборка = ТарифныеСтавкиСотрудников.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		ПоказателиТарифнойСтавки.Добавить(Выборка.ПоказательТарифнойСтавки);	
	КонецЦикла;
	
	Возврат ЗарплатаКадрыРасширенный.СведенияОПоказателяхРасчетаЗарплаты(ПоказателиТарифнойСтавки);

КонецФункции

Функция НормаВремени(Выборка, ЗаписьРасчета, ИсходныеДанные)
	
	Если ЭтоОплатаПростояПоЧасам(ЗаписьРасчета) Тогда
		
		Норма = ИсходныеДанные.НормаЧасов;	
		
	Иначе
		
		Если ЗначениеЗаполнено(Выборка.ПоказательДоляНеполногоРабочегоВремени) Тогда
			Норма = ИсходныеДанные.НормаДней;	
		Иначе
			Норма = ИсходныеДанные.НормаДнейПоГрафикуПолногоРабочегоВремени;	
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Норма;	

КонецФункции 

Функция ДоляНеполногоВремени(Выборка, ЗаписьРасчета, ИсходныеДанные)
	
	ДоляНеполногоВремени = 1;
	
	Если НЕ ЭтоОплатаПростояПоЧасам(ЗаписьРасчета) 
		И ЗначениеЗаполнено(Выборка.ПоказательДоляНеполногоРабочегоВремени) Тогда
		ДоляНеполногоВремени = ИсходныеДанные.ДоляНеполногоРабочегоВремени;
	КонецЕсли;
	
	Возврат ДоляНеполногоВремени;	
	
КонецФункции 

Функция ЭтоОплатаПростояПоЧасам(ЗаписьРасчета)
	
	Возврат ЗаписьРасчета.ВремяВЧасах;
	
КонецФункции

#КонецОбласти
