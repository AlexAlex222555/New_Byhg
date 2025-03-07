////////////////////////////////////////////////////////////////////////////////
// Подсистема «Учет среднего заработка».
//
// Методы, обслуживающие подписки на события.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Процедура заполняет настройки учета среднего заработка в зависимости 
//  от количества в информационной базе специализированных начислений.
//
Процедура ЗаполнитьНастройкиУчетаСреднегоЗаработка(Источник, Отказ) Экспорт
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(Источник) Тогда
		Возврат;
	КонецЕсли;
	
	УчетСреднегоЗаработка.ЗаполнитьНастройкиУчетаСреднегоЗаработка();
	
КонецПроцедуры

Процедура ПодготовитьСведенияОПериодахСреднегоЗаработкаОбщий(Источник, Отказ, Замещение) Экспорт
		
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(Источник) Тогда
		Возврат;
	КонецЕсли;
	
	СобратьДанныеДляРегистрацииПерерасчетов(Источник);
	
КонецПроцедуры

Процедура ПроверитьНеобходимостьПерерасчетаСреднегоЗаработкаОбщий(Источник, Отказ, Замещение) Экспорт
		
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(Источник) Тогда
		Возврат;
	КонецЕсли;
	
	ПроверитьНеобходимостьРегистрацииПерерасчетов(Источник, "Общий");
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

Процедура СобратьДанныеДляРегистрацииПерерасчетов(Источник) Экспорт
	
	ИмяРегистра = Источник.Метаданные().Имя;
	Регистратор = Источник.Отбор.Регистратор.Значение;
	
	ДанныеДляРегистрацииПерерасчетов = Новый МенеджерВременныхТаблиц;
	
	СобратьДанныеОДвиженияхРегистратора(ДанныеДляРегистрацииПерерасчетов, Регистратор, ИмяРегистра, "ВТПредыдущиеДвижения");
	
	Источник.ДополнительныеСвойства.Вставить("ДанныеДляРегистрацииПерерасчетов", ДанныеДляРегистрацииПерерасчетов);
	
КонецПроцедуры

Процедура ПроверитьНеобходимостьРегистрацииПерерасчетов(Источник, ВидСреднегоЗаработка) Экспорт
	
	ДанныеДляРегистрацииПерерасчетов = Неопределено;
	Если Источник.ДополнительныеСвойства.Свойство("ДанныеДляРегистрацииПерерасчетов", ДанныеДляРегистрацииПерерасчетов) Тогда
		
		ИмяРегистра = Источник.Метаданные().Имя;
		Регистратор = Источник.Отбор.Регистратор.Значение;
		
		СобратьДанныеОДвиженияхРегистратора(ДанныеДляРегистрацииПерерасчетов, Регистратор, ИмяРегистра, "ВТТекущиеДвижения");
		
		Запрос = Новый Запрос;
		Запрос.МенеджерВременныхТаблиц = ДанныеДляРегистрацииПерерасчетов;
		
		ОписаниеРегистра = ЗарплатаКадрыОбщиеНаборыДанных.ОписаниеРегистра(ИмяРегистра);
		
		ЕстьПолеФизическоеЛицо = Ложь;
		ЕстьПолеГоловнаяОрганизация = Ложь;
		
		ТекстЗапроса = "";
		
		РегистрСПериодом = РегистрСРеквизитомПериод(ОписаниеРегистра.ТипРегистра + "." + ИмяРегистра);
		
		Если РегистрСПериодом Тогда
			ТекстЗапроса =
				"ВЫБРАТЬ
				|	ЕСТЬNULL(ДвиженияПредыдущие.Период, ДвиженияТекущие.Период) КАК Период";
			УсловияСоединения = "ДвиженияПредыдущие.Период = ДвиженияТекущие.Период";
		Иначе
			ТекстЗапроса =
				"ВЫБРАТЬ
				|	ЕСТЬNULL(ДвиженияПредыдущие.Месяц, ДвиженияТекущие.Месяц) КАК Период";
			УсловияСоединения = "ДвиженияПредыдущие.Месяц = ДвиженияТекущие.Месяц";
		КонецЕсли; 

		Для каждого ИмяПоля Из ОписаниеРегистра.Измерения Цикл
			
			ТекстЗапроса = ТекстЗапроса + ",
				|	ЕСТЬNULL(ДвиженияПредыдущие." + ИмяПоля + ", ДвиженияТекущие." + ИмяПоля + ") КАК " + ИмяПоля;
				
			УсловияСоединения = УсловияСоединения + Символы.ПС + "И "
				+ "ДвиженияПредыдущие." + ИмяПоля + " = ДвиженияТекущие." + ИмяПоля;
				
			Если Не ЕстьПолеФизическоеЛицо И ИмяПоля = "ФизическоеЛицо" Тогда
				ЕстьПолеФизическоеЛицо = Истина;
			КонецЕсли; 
				
			Если Не ЕстьПолеГоловнаяОрганизация И ИмяПоля = "ГоловнаяОрганизация" Тогда
				ЕстьПолеГоловнаяОрганизация = Истина;
			КонецЕсли; 
				
		КонецЦикла;
		
		Для каждого ИмяПоля Из ОписаниеРегистра.Ресурсы Цикл
			
			ТекстЗапроса = ТекстЗапроса + ",
				|	ЕСТЬNULL(ДвиженияПредыдущие." + ИмяПоля + ", ДвиженияТекущие." + ИмяПоля + ") КАК " + ИмяПоля;
				
			УсловияСоединения = УсловияСоединения + Символы.ПС + "И "
				+ "ДвиженияПредыдущие." + ИмяПоля + " = ДвиженияТекущие." + ИмяПоля;
			
			Если Не ЕстьПолеФизическоеЛицо И ИмяПоля = "ФизическоеЛицо" Тогда
				ЕстьПолеФизическоеЛицо = Истина;
			КонецЕсли; 
				
			Если Не ЕстьПолеГоловнаяОрганизация И ИмяПоля = "ГоловнаяОрганизация" Тогда
				ЕстьПолеГоловнаяОрганизация = Истина;
			КонецЕсли; 
				
		КонецЦикла;
			
		Для каждого ИмяПоля Из ОписаниеРегистра.Реквизиты Цикл
			
			ТекстЗапроса = ТекстЗапроса + ",
				|	ЕСТЬNULL(ДвиженияПредыдущие." + ИмяПоля + ", ДвиженияТекущие." + ИмяПоля + ") КАК " + ИмяПоля;
				
			УсловияСоединения = УсловияСоединения + Символы.ПС + "И "
				+ "ДвиженияПредыдущие." + ИмяПоля + " = ДвиженияТекущие." + ИмяПоля;
			
			Если Не ЕстьПолеФизическоеЛицо И ИмяПоля = "ФизическоеЛицо" Тогда
				ЕстьПолеФизическоеЛицо = Истина;
			КонецЕсли; 
				
			Если Не ЕстьПолеГоловнаяОрганизация И ИмяПоля = "ГоловнаяОрганизация" Тогда
				ЕстьПолеГоловнаяОрганизация = Истина;
			КонецЕсли; 
				
		КонецЦикла;
		
		Если Не ЕстьПолеФизическоеЛицо Тогда
			
			ТекстЗапроса = ТекстЗапроса + ",
				|	ЕСТЬNULL(ДвиженияПредыдущие.Сотрудник.ФизическоеЛицо, ДвиженияТекущие.Сотрудник.ФизическоеЛицо) КАК ФизическоеЛицо";
				
		КонецЕсли; 
		
		Если Не ЕстьПолеГоловнаяОрганизация Тогда
			
			ТекстЗапроса = ТекстЗапроса + ",
				|	ЕСТЬNULL(ДвиженияПредыдущие.Сотрудник.ГоловнаяОрганизация, ДвиженияТекущие.Сотрудник.ГоловнаяОрганизация) КАК ГоловнаяОрганизация";
				
		КонецЕсли; 
		
		ТекстЗапроса = ТекстЗапроса + "
			|Поместить ВТРезультатОбъединения
			|ИЗ	ВТПредыдущиеДвижения КАК ДвиженияПредыдущие
			|	ПОЛНОЕ СОЕДИНЕНИЕ ВТТекущиеДвижения КАК ДвиженияТекущие
			|	ПО " + УсловияСоединения;
			
		Если РегистрСПериодом Тогда
			ТекстЗапроса = ТекстЗапроса + "
				|ГДЕ
				|	(ДвиженияПредыдущие.Период ЕСТЬ NULL
				|		ИЛИ ДвиженияТекущие.Период ЕСТЬ NULL)";
		Иначе
			ТекстЗапроса = ТекстЗапроса + "
				|ГДЕ
				|	(ДвиженияПредыдущие.Месяц ЕСТЬ NULL
				|		ИЛИ ДвиженияТекущие.Месяц ЕСТЬ NULL)";
		КонецЕсли;
			
		Запрос.Текст = ТекстЗапроса;
		Запрос.Выполнить();
		
		Запрос.Текст =
			"ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	НАЧАЛОПЕРИОДА(Различия.Период, МЕСЯЦ) КАК Период,
			|	Различия.ГоловнаяОрганизация КАК ГоловнаяОрганизация,
			|	Различия.ФизическоеЛицо КАК ФизическоеЛицо
			|ПОМЕСТИТЬ ВТПериодыСреднегоЗаработка
			|ИЗ
			|	ВТРезультатОбъединения КАК Различия
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ ПЕРВЫЕ 1
			|	ТаблицаПериодов.Период
			|ИЗ
			|	ВТПериодыСреднегоЗаработка КАК ТаблицаПериодов";
			
		РезультатЗапроса = Запрос.Выполнить();
		Если Не РезультатЗапроса.Пустой() Тогда
			
			ВыявитьИЗарегистрироватьПерерасчетыСреднегоЗаработка(ДанныеДляРегистрацииПерерасчетов,
				Регистратор, ВидСреднегоЗаработка, ЭтоИндексацияВПериодСохраненияСреднегоЗаработка(ИмяРегистра));		
			
		КонецЕсли; 
		
	КонецЕсли;
	
КонецПроцедуры

Функция СобратьДанныеОДвиженияхРегистратора(ДанныеДляРегистрацииПерерасчетов, Регистратор, ИмяРегистра, ИмяСоздаваемойВременнойТаблицы)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = ДанныеДляРегистрацииПерерасчетов;
	
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	
	ОписаниеРегистра = ЗарплатаКадрыОбщиеНаборыДанных.ОписаниеРегистра(ИмяРегистра);
	
	ТекстЗапроса = "";
	ЕстьИзмерениеСоставнаяЧасть = Ложь;
	Для каждого ИмяПоля Из ОписаниеРегистра.Измерения Цикл
		
		Если Не ЕстьИзмерениеСоставнаяЧасть И ВРег(ИмяПоля) = ВРег("СоставнаяЧасть") Тогда
			ЕстьИзмерениеСоставнаяЧасть = Истина;
		КонецЕсли;
		
		ТекстЗапроса = ТекстЗапроса + ",
			|	Регистр." + ИмяПоля;
		
	КонецЦикла;
	
	Если РегистрСРеквизитомПериод(ОписаниеРегистра.ТипРегистра + "." + ИмяРегистра) Тогда
		
		Если ЕстьИзмерениеСоставнаяЧасть Тогда
			
			ТекстЗапроса =
				"ВЫБРАТЬ
				|	ВЫБОР КОГДА Регистр.СоставнаяЧасть В (&СоставнаяЧастьГодовыеПремии)
				|		ТОГДА ДОБАВИТЬКДАТЕ(ДАТАВРЕМЯ(1, 12, 31), ГОД, Регистр.Год - 1)
				|		ИНАЧЕ Регистр.Период
				|	КОНЕЦ КАК Период"
				+ ТекстЗапроса;
			
			Запрос.УстановитьПараметр("СоставнаяЧастьГодовыеПремии", Перечисления.УчетНачисленийВСреднемЗаработкеОбщий.ГодовыеПремии());
			
		Иначе
			
			ТекстЗапроса =
				"ВЫБРАТЬ
				|	Регистр.Период"
				+ ТекстЗапроса;
			
		КонецЕсли;
		
	Иначе
		
		ТекстЗапроса =
			"ВЫБРАТЬ
			|	Регистр.Месяц"
			+ ТекстЗапроса;
		
	КонецЕсли;
	
	Для каждого ИмяПоля Из ОписаниеРегистра.Ресурсы Цикл
		ТекстЗапроса = ТекстЗапроса + ",
			|	Регистр." + ИмяПоля;
	КонецЦикла;
		
	Для каждого ИмяПоля Из ОписаниеРегистра.Реквизиты Цикл
		ТекстЗапроса = ТекстЗапроса + ",
			|	Регистр." + ИмяПоля;
	КонецЦикла;
		
	ТекстЗапроса = ТекстЗапроса + "
		|Поместить " + ИмяСоздаваемойВременнойТаблицы + "
		|ИЗ	" + ОписаниеРегистра.ТипРегистра + "." + ИмяРегистра + " КАК Регистр
		|ГДЕ
		|	Регистр.Регистратор = &Регистратор
		|	И Регистр.Активность";
		
	Запрос.Текст = ТекстЗапроса;
	Запрос.Выполнить();

КонецФункции

Функция РегистрСРеквизитомПериод(ПолноеИмяРегистра)
	
	Если СтрНайти(ПолноеИмяРегистра, "РегистрСведений") = 1
		И Метаданные.НайтиПоПолномуИмени(ПолноеИмяРегистра).ПериодичностьРегистраСведений = Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический Тогда
		РезультатПроверки = Ложь;
	Иначе
		РезультатПроверки = Истина;
	КонецЕсли;
	
	Возврат РезультатПроверки;
	
КонецФункции

Процедура ВыявитьИЗарегистрироватьПерерасчетыСреднегоЗаработка(ДанныеДляРегистрацииПерерасчетов, Регистратор, ВидСреднегоЗаработка, ЭтоИндексация = Ложь)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = ДанныеДляРегистрацииПерерасчетов;
	
	Запрос.УстановитьПараметр("Регистратор", Регистратор);
	
	ИмяТабличнойЧасти = "СреднийЗаработок" + ВидСреднегоЗаработка;
	ОписанияДокументов = Новый Соответствие;
	Для каждого МетаданныеДокумента Из Метаданные.Документы Цикл
		
		Если МетаданныеДокумента.ТабличныеЧасти.Найти(ИмяТабличнойЧасти) <> Неопределено Тогда
			
			ПолноеИмя = МетаданныеДокумента.ПолноеИмя();
			ОписаниеДокумента = Новый Структура("ПутьКРеквизитуСотрудник,ПутьКРеквизитуФизическоеЛицо");
			
			ИскомыйРеквизит = МетаданныеДокумента.Реквизиты.Найти("Сотрудник");
			Если ИскомыйРеквизит <> Неопределено Тогда
				
				Если Не ИскомыйРеквизит.Тип.СодержитТип(Тип("СправочникСсылка.Сотрудники")) Тогда
					
					ИскомыйРеквизит = МетаданныеДокумента.Реквизиты.Найти("ОсновнойСотрудник");
					Если ИскомыйРеквизит <> Неопределено Тогда
						ОписаниеДокумента.ПутьКРеквизитуСотрудник = "ТаблицаДокумента.ОсновнойСотрудник";
						ОписаниеДокумента.ПутьКРеквизитуФизическоеЛицо = "ТаблицаДокумента.Сотрудник";
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЕсли;
			
			Если Не ЗначениеЗаполнено(ОписаниеДокумента.ПутьКРеквизитуФизическоеЛицо) Тогда
				
				ИскомыйРеквизит = МетаданныеДокумента.Реквизиты.Найти("ФизическоеЛицо");
				Если ИскомыйРеквизит <> Неопределено Тогда
					ОписаниеДокумента.ПутьКРеквизитуФизическоеЛицо = "ТаблицаДокумента.ФизическоеЛицо";
				КонецЕсли; 
				
			КонецЕсли;
			
			ОписанияДокументов.Вставить(ПолноеИмя, ОписаниеДокумента);
			
		КонецЕсли;
		
	КонецЦикла;
	
	ТекстЗапроса = "";
	ДобавитьОбъединение = Ложь;
	УдалитьСозданиеВременнойТаблицы = Ложь;
	Для каждого ЭлементОписанияДокумента Из ОписанияДокументов Цикл
		
		ПолноеИмяДокумента = ЭлементОписанияДокумента.Ключ;
		ОписаниеДокумента = ЭлементОписанияДокумента.Значение;
		
		Если ДобавитьОбъединение Тогда
			
			ТекстЗапроса = ТекстЗапроса +
				"
				|ОБЪЕДИНИТЬ ВСЕ
				|";
				
		Иначе
			ДобавитьОбъединение = Истина;
		КонецЕсли;
		
		ТекстЗапросаКДокументу =
			"ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	ТаблицаДокумента.Организация КАК Организация,
			|	ТаблицаДокумента.Сотрудник КАК Сотрудник,
			|	ПериодыСреднегоЗаработка.ГоловнаяОрганизация,
			|	ТаблицаДокумента.Ссылка КАК ДокументСреднегоЗаработка,
			|	&Регистратор КАК ДокументОснование
			|ПОМЕСТИТЬ ВТДокументыКПерерасчетуПредварительно
			|ИЗ
			|	ВТПериодыСреднегоЗаработка КАК ПериодыСреднегоЗаработка
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТТаблицаДокумента КАК ТаблицаДокумента
			|		ПО (ТаблицаДокумента.Проведен)
			|			И ПериодыСреднегоЗаработка.ФизическоеЛицо = ТаблицаДокумента.Сотрудник.ФизическоеЛицо
			|			И ПериодыСреднегоЗаработка.Период >= ТаблицаДокумента.ПериодРасчетаСреднегоЗаработкаНачало
			|			И ПериодыСреднегоЗаработка.Период <= ТаблицаДокумента.ПериодРасчетаСреднегоЗаработкаОкончание
			|ГДЕ
			|	ТаблицаДокумента.Ссылка <> &Регистратор";
			
		Если УдалитьСозданиеВременнойТаблицы Тогда
			ТекстЗапросаКДокументу = СтрЗаменить(ТекстЗапросаКДокументу, "ПОМЕСТИТЬ ВТДокументыКПерерасчетуПредварительно", "");
		Иначе
			УдалитьСозданиеВременнойТаблицы = Истина;
		КонецЕсли; 
			
		Если ПолноеИмяДокумента = "Документ.УвольнениеСписком" Тогда
			
			ТекстЗапросаКДокументу = СтрЗаменить(ТекстЗапросаКДокументу, "ВТТаблицаДокумента", "Документ.УвольнениеСписком.Сотрудники");
			ТекстЗапросаКДокументу = СтрЗаменить(ТекстЗапросаКДокументу, "ТаблицаДокумента.Организация", "ТаблицаДокумента.Ссылка.Организация");
			ТекстЗапросаКДокументу = СтрЗаменить(ТекстЗапросаКДокументу, "ТаблицаДокумента.Проведен", "ТаблицаДокумента.Ссылка.Проведен");
			
		Иначе
			
			ТекстЗапросаКДокументу = СтрЗаменить(ТекстЗапросаКДокументу, "ВТТаблицаДокумента", ПолноеИмяДокумента);
			
			ПутьКРеквизитуФизическоеЛицо = "ТаблицаДокумента.Сотрудник.ФизическоеЛицо";
			Если ОписаниеДокумента.ПутьКРеквизитуСотрудник <> Неопределено Тогда
				ТекстЗапросаКДокументу = СтрЗаменить(ТекстЗапросаКДокументу, "ТаблицаДокумента.Сотрудник", ОписаниеДокумента.ПутьКРеквизитуСотрудник);
				ПутьКРеквизитуФизическоеЛицо = СтрЗаменить(ПутьКРеквизитуФизическоеЛицо, "ТаблицаДокумента.Сотрудник", ОписаниеДокумента.ПутьКРеквизитуСотрудник);
			КонецЕсли; 
			
			Если ОписаниеДокумента.ПутьКРеквизитуФизическоеЛицо <> Неопределено Тогда
				ТекстЗапросаКДокументу = СтрЗаменить(ТекстЗапросаКДокументу, ПутьКРеквизитуФизическоеЛицо, ОписаниеДокумента.ПутьКРеквизитуФизическоеЛицо);
			КонецЕсли;
			
		КонецЕсли;
		
		ТекстЗапроса = ТекстЗапроса + ТекстЗапросаКДокументу;
		
	КонецЦикла;
	
	Запрос.Текст = ТекстЗапроса;
	РезультатЗапроса = Запрос.Выполнить();
	
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДокументыКПерерасчету.Организация,
		|	ДокументыКПерерасчету.Сотрудник,
		|	ДокументыКПерерасчету.ДокументСреднегоЗаработка,
		|	ДокументыКПерерасчету.ДокументОснование
		|ПОМЕСТИТЬ ВТДокументыКПерерасчету
		|ИЗ
		|	ВТДокументыКПерерасчетуПредварительно КАК ДокументыКПерерасчету
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Организации КАК Организации
		|		ПО ДокументыКПерерасчету.Организация = Организации.Ссылка
		|			И ДокументыКПерерасчету.ГоловнаяОрганизация = Организации.ГоловнаяОрганизация
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	ДокументыКПерерасчету.Организация
		|ИЗ
		|	ВТДокументыКПерерасчету КАК ДокументыКПерерасчету";
		
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда
		ЗарегистрироватьНеобходимостьПерерасчетовДокументовСреднегоЗаработка(ДанныеДляРегистрацииПерерасчетов);
	КонецЕсли; 
	
	Если ЭтоИндексация Тогда
		
		КатегорииНачисленийОплатыПериодаОтсутствий = Новый Массив;
		КатегорииНачисленийОплатыПериодаОтсутствий.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ДенежноеСодержаниеКомпенсацияОтпуска);
		КатегорииНачисленийОплатыПериодаОтсутствий.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ДенежноеСодержаниеКомпенсацияОтпуска);
		КатегорииНачисленийОплатыПериодаОтсутствий.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.ОплатаОтпуска);
		КатегорииНачисленийОплатыПериодаОтсутствий.Добавить(Перечисления.КатегорииНачисленийИНеоплаченногоВремени.КомпенсацияОтпуска);
		
		Запрос.УстановитьПараметр("КатегорииНачисленийОплатыПериодаОтсутствий", КатегорииНачисленийОплатыПериодаОтсутствий);
		
		Запрос.Текст =
			"ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	Начисления.Ссылка
			|ИЗ
			|	ПланВидовРасчета.Начисления КАК Начисления
			|ГДЕ
			|	Начисления.КатегорияНачисленияИлиНеоплаченногоВремени В(&КатегорииНачисленийОплатыПериодаОтсутствий)";
			
		ВидыРасчетаОплатыПериодаОтсутствий = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
		
		Запрос.УстановитьПараметр("ВидыРасчетаОплатыПериодаОтсутствий", ВидыРасчетаОплатыПериодаОтсутствий);
		Запрос.Текст =
			"УНИЧТОЖИТЬ ВТДокументыКПерерасчету
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ РАЗЛИЧНЫЕ
			|	Начисления.Организация,
			|	Начисления.Сотрудник,
			|	Начисления.Регистратор КАК ДокументСреднегоЗаработка,
			|	&Регистратор КАК ДокументОснование
			|ПОМЕСТИТЬ ВТДокументыКПерерасчету
			|ИЗ
			|	РегистрРасчета.Начисления КАК Начисления
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТПериодыСреднегоЗаработка КАК ПериодыСреднегоЗаработка
			|		ПО Начисления.ФизическоеЛицо = ПериодыСреднегоЗаработка.ФизическоеЛицо
			|			И Начисления.ГоловнаяОрганизация = ПериодыСреднегоЗаработка.ГоловнаяОрганизация
			|			И Начисления.ПериодДействияНачало <= ПериодыСреднегоЗаработка.Период
			|			И Начисления.ПериодДействияКонец >= ПериодыСреднегоЗаработка.Период
			|ГДЕ
			|	Начисления.ВидРасчета В(&ВидыРасчетаОплатыПериодаОтсутствий)
			|;
			|
			|////////////////////////////////////////////////////////////////////////////////
			|ВЫБРАТЬ ПЕРВЫЕ 1
			|	ДокументыКПерерасчету.Организация
			|ИЗ
			|	ВТДокументыКПерерасчету КАК ДокументыКПерерасчету";
			
		РезультатЗапроса = Запрос.Выполнить();
		Если Не РезультатЗапроса.Пустой() Тогда
			ЗарегистрироватьНеобходимостьПерерасчетовДокументовСреднегоЗаработка(ДанныеДляРегистрацииПерерасчетов);
		КонецЕсли; 
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗарегистрироватьНеобходимостьПерерасчетовДокументовСреднегоЗаработка(ДанныеДляРегистрацииПерерасчетов)
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = ДанныеДляРегистрацииПерерасчетов;
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ДокументыКПерерасчету.Организация,
		|	ДокументыКПерерасчету.Сотрудник,
		|	ДокументыКПерерасчету.ДокументСреднегоЗаработка,
		|	ДокументыКПерерасчету.ДокументОснование
		|ИЗ
		|	ВТДокументыКПерерасчету КАК ДокументыКПерерасчету
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ПерерасчетСреднегоЗаработка КАК ПерерасчетСреднегоЗаработка
		|		ПО ДокументыКПерерасчету.Организация = ПерерасчетСреднегоЗаработка.Организация
		|			И ДокументыКПерерасчету.Сотрудник = ПерерасчетСреднегоЗаработка.Сотрудник
		|			И ДокументыКПерерасчету.ДокументСреднегоЗаработка = ПерерасчетСреднегоЗаработка.ДокументСреднегоЗаработка
		|			И ДокументыКПерерасчету.ДокументОснование = ПерерасчетСреднегоЗаработка.ДокументОснование
		|ГДЕ
		|	ПерерасчетСреднегоЗаработка.ДокументОснование ЕСТЬ NULL ";
	
	РезультатЗапроса = Запрос.Выполнить();
	Если Не РезультатЗапроса.Пустой() Тогда
		
		Выборка = РезультатЗапроса.Выбрать();
		Пока Выборка.Следующий() Цикл
			
			НаборЗаписей = РегистрыСведений.ПерерасчетСреднегоЗаработка.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Организация.Установить(Выборка.Организация);
			НаборЗаписей.Отбор.Сотрудник.Установить(Выборка.Сотрудник);
			НаборЗаписей.Отбор.ДокументСреднегоЗаработка.Установить(Выборка.ДокументСреднегоЗаработка);
			НаборЗаписей.Отбор.ДокументОснование.Установить(Выборка.ДокументОснование);
			
			Запись = НаборЗаписей.Добавить();
			Запись.Организация = Выборка.Организация;
			Запись.Сотрудник = Выборка.Сотрудник;
			Запись.ДокументСреднегоЗаработка = Выборка.ДокументСреднегоЗаработка;
			Запись.ДокументОснование = Выборка.ДокументОснование;
			
			НаборЗаписей.Записать();
			
		КонецЦикла; 
		
	КонецЕсли; 
	
КонецПроцедуры

Функция ЭтоИндексацияВПериодСохраненияСреднегоЗаработка(ИмяРегистра)
	
	Возврат ВРег("РегистрыСведений." + ИмяРегистра) = ВРег("РегистрыСведений.КоэффициентИндексацииЗаработка");
	
КонецФункции

#КонецОбласти
