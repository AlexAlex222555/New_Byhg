////////////////////////////////////////////////////////////////////////////////
// СотрудникиВызовСервера: методы, обслуживающие работу формы сотрудника.
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Функция СообщениеОКонфликтеВидаЗанятостиНовогоСотрудникаССуществующими(Сотрудник, ФизическоеЛицо, Организация, ВидЗанятости, ДатаПриема) Экспорт
	 Возврат СотрудникиФормы.СообщениеОКонфликтеВидаЗанятостиНовогоСотрудникаССуществующими(Сотрудник, ФизическоеЛицо, Организация, ВидЗанятости, ДатаПриема);
КонецФункции

Функция ПолучитьВидЗанятостиДляНовогоСотрудника(Знач Сотрудник, Знач Организация, Знач ФизическоеЛицо = Неопределено) Экспорт
	Возврат СотрудникиФормы.ПолучитьВидЗанятостиДляНовогоСотрудника(Сотрудник, Организация, ФизическоеЛицо);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПодобратьСписокФизЛиц(ФизическоеЛицоСсылка, Фамилия, Имя, Отчество) Экспорт
	Возврат СотрудникиФормы.ПодобратьСписокФизЛиц(ФизическоеЛицоСсылка, Фамилия, Имя, Отчество);
КонецФункции

Функция ЗаблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицоСсылка, ФизическоеЛицоВерсияДанных, ФормаУникальныйИдентификатор) Экспорт
	Возврат СотрудникиФормы.ЗаблокироватьФизическоеЛицоПриРедактированииНаСервере(ФизическоеЛицоСсылка, ФизическоеЛицоВерсияДанных, ФормаУникальныйИдентификатор);
КонецФункции

Функция КодПоДРФОУникален(КодПоДРФО) Экспорт	
	
	Запрос = Новый Запрос;
	
	Запрос.Текст =
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	ФизическиеЛица.Ссылка
		|ИЗ
		|	Справочник.ФизическиеЛица КАК ФизическиеЛица
		|ГДЕ
		|	ФизическиеЛица.КодПоДРФО = &КодПоДРФО
		|	И &КодПоДРФО <> """"
		|
		|";
		
	Запрос.УстановитьПараметр("КодПоДРФО", КодПоДРФО);
	
	УстановитьПривилегированныйРежим(Истина);
	
	РезультатПроверкиУникальности =  Запрос.Выполнить().Пустой();
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат РезультатПроверкиУникальности;
	
КонецФункции

Функция ФизическиеЛицаСотрудников(Знач Сотрудники) Экспорт
	
	Если ТипЗнч(Сотрудники) = Тип("Массив") Тогда
		СписокСотрудников = Сотрудники;
	Иначе
		СписокСотрудников = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Сотрудники);
	КонецЕсли;
	
	Возврат КадровыйУчет.ФизическиеЛицаСотрудников(СписокСотрудников);
	
КонецФункции

#Область ОбработчикиМодулейОбъектаИМенеджера

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка) Экспорт
	
	Если Параметры.Свойство("СтрокаПоиска") 
		И НЕ ПустаяСтрока(Параметры.СтрокаПоиска) Тогда
		
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("СтрокаПоиска",  Параметры.СтрокаПоиска + "%");
		
		Запрос.Текст =
			"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
			|	ФИОФизическихЛиц.Фамилия + ВЫБОР
			|		КОГДА ФИОФизическихЛиц.Имя = """"
			|			ТОГДА """"
			|		ИНАЧЕ "" "" + ФИОФизическихЛиц.Имя
			|	КОНЕЦ + ВЫБОР
			|		КОГДА ФИОФизическихЛиц.Отчество = """"
			|			ТОГДА """"
			|		ИНАЧЕ "" "" + ФИОФизическихЛиц.Отчество
			|	КОНЕЦ КАК ФИО,
			|	ФИОФизическихЛиц.ФизическоеЛицо.Наименование КАК Наименование,
			|	ФИОФизическихЛиц.ФизическоеЛицо КАК ФизическоеЛицо,
			|	ВЫБОР
			|		КОГДА ФИОФизическихЛиц.Период = ФИОФизическихЛицСрезПоследних.Период
			|			ТОГДА ДАТАВРЕМЯ(1, 1, 1)
			|		ИНАЧЕ ФИОФизическихЛицСрезПоследних.Период
			|	КОНЕЦ КАК Период
			|ПОМЕСТИТЬ ВТПрежниеФИО
			|ИЗ
			|	РегистрСведений.ФИОФизическихЛиц КАК ФИОФизическихЛиц
			|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ФИОФизическихЛиц.СрезПоследних КАК ФИОФизическихЛицСрезПоследних
			|		ПО ФИОФизическихЛиц.ФизическоеЛицо = ФИОФизическихЛицСрезПоследних.ФизическоеЛицо
			|ГДЕ
			|	ФИОФизическихЛиц.Фамилия + ВЫБОР
			|			КОГДА ФИОФизическихЛиц.Имя = """"
			|				ТОГДА """"
			|			ИНАЧЕ "" "" + ФИОФизическихЛиц.Имя
			|		КОНЕЦ + ВЫБОР
			|			КОГДА ФИОФизическихЛиц.Отчество = """"
			|				ТОГДА """"
			|			ИНАЧЕ "" "" + ФИОФизическихЛиц.Отчество
			|		КОНЕЦ + ВЫБОР
			|			КОГДА ФИОФизическихЛиц.ФизическоеЛицо.УточнениеНаименования = """"
			|				ТОГДА """"
			|			ИНАЧЕ "" "" + ФИОФизическихЛиц.ФизическоеЛицо.УточнениеНаименования
			|		КОНЕЦ ПОДОБНО &СтрокаПоиска
			|	И ФИОФизическихЛиц.Период <> ФИОФизическихЛицСрезПоследних.Период
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
			|	ПрежниеФИО.ФИО КАК ФИО,
			|	Сотрудники.Наименование КАК ФИОТекущее,
			|	Сотрудники.УточнениеНаименования,
			|	Сотрудники.Ссылка КАК Сотрудник,
			|	МАКСИМУМ(ПрежниеФИО.Период) КАК Период,
			|	Сотрудники.ПометкаУдаления
			|ПОМЕСТИТЬ ВТВсеСовпадения
			|ИЗ
			|	ВТПрежниеФИО КАК ПрежниеФИО
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Сотрудники КАК Сотрудники
			|		ПО ПрежниеФИО.ФизическоеЛицо = Сотрудники.ФизическоеЛицо
			|
			|СГРУППИРОВАТЬ ПО
			|	ПрежниеФИО.ФИО,
			|	Сотрудники.ФизическоеЛицо.ФИО,
			|	Сотрудники.Ссылка,
			|	Сотрудники.Наименование,
			|	Сотрудники.УточнениеНаименования
			|
			|ОБЪЕДИНИТЬ ВСЕ
			|
			|ВЫБРАТЬ
			|	Сотрудники.ФизическоеЛицо.ФИО,
			|	Сотрудники.Наименование,
			|	Сотрудники.УточнениеНаименования,
			|	Сотрудники.Ссылка,
			|	NULL,
			|	Сотрудники.ПометкаУдаления
			|ИЗ
			|	Справочник.Сотрудники КАК Сотрудники
			|ГДЕ
			|	Сотрудники.Наименование ПОДОБНО &СтрокаПоиска
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ
			|	ВсеСовпадения.ФИО КАК ФИО,
			|	ВсеСовпадения.ФИОТекущее КАК ФИОТекущее,
			|	ВсеСовпадения.УточнениеНаименования,
			|	ВсеСовпадения.Сотрудник КАК Сотрудник,
			|	ВсеСовпадения.Период КАК Период,
			|	ВсеСовпадения.Сотрудник.Код КАК Код,
			|	ВсеСовпадения.ПометкаУдаления
			|ИЗ
			|	ВТВсеСовпадения КАК ВсеСовпадения
			|
			|УПОРЯДОЧИТЬ ПО
			|	ФИО";
			
		РезультатЗапроса = Запрос.Выполнить();
		Если Не РезультатЗапроса.Пустой() Тогда
			
			ДанныеВыбора = Новый СписокЗначений;
			СтандартнаяОбработка = Ложь;
			ДлинаСтрокиПоиска = СтрДлина(Параметры.СтрокаПоиска);
			
			Выборка = РезультатЗапроса.Выбрать();
			Пока Выборка.Следующий() Цикл
				
				Если ЗначениеЗаполнено(Выборка.Период) Тогда
					
					Представление = Новый ФорматированнаяСтрока(
						Новый ФорматированнаяСтрока(
							Лев(Выборка.ФИО, ДлинаСтрокиПоиска),
							Новый Шрифт( , , Истина),
							WebЦвета.Зеленый),
						Сред(Выборка.ФИО, ДлинаСтрокиПоиска + 1),
						?(ПустаяСтрока(Выборка.УточнениеНаименования), "", " " + Выборка.УточнениеНаименования));
					
					Представление = Новый ФорматированнаяСтрока(
						Представление,
						" (" + ФизическиеЛицаКлиентСервер.ФамилияИнициалы(Выборка.ФИОТекущее) + " " 
							+ НСтр("ru='с';uk='з'") + " " + Формат(Выборка.Период, "ДЛФ=D") + " (" + Выборка.Код + "))");
					
				Иначе
					
					Представление = Новый ФорматированнаяСтрока(
						Новый ФорматированнаяСтрока(
							Лев(Выборка.ФИОТекущее, ДлинаСтрокиПоиска),
							Новый Шрифт( , , Истина),
							WebЦвета.Зеленый),
						Сред(Выборка.ФИОТекущее, ДлинаСтрокиПоиска + 1));
					
				КонецЕсли;
				
				ДанныеВыбора.Добавить(Выборка.Сотрудник, Представление, Выборка.ПометкаУдаления);
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
	
	СотрудникиФормыВнутренний.ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка) Экспорт
	СотрудникиФормыВнутренний.ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка);
КонецПроцедуры

#КонецОбласти

#КонецОбласти
