////////////////////////////////////////////////////////////////////////////////
// Функции и процедуры обеспечения выбора периода.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Заполняет переданный в параметрах список выбора. 
// 
// Параметры: 
// 	МинимальныйПериод   - Перечисление.ДоступныеПериодыОтчета - минимальный вид периода, 
//                       начиная с которого необходимо включать остальные виды периода по возрастанию.
// 	СписокВыбора        - СписокЗначений - в списке возвращаются заполненный список выбора
// 	ЗначениеПоУмолчанию - Перечисление.ДоступныеПериодыОтчета - в параметре возвращает вид периода по умолчанию.
//
Процедура ЗаполнитьСписокВыбораВидПериода(Знач МинимальныйПериод, СписокВыбора, ЗначениеПоУмолчанию = Неопределено) Экспорт
	
	Если ТипЗнч(СписокВыбора) <> Тип("СписокЗначений") Тогда
		Возврат;
	КонецЕсли;
	
	СписокДоступныхПериодов = ПолучитьСписокДоступныхПериодов();
	
	ЭлементСписка = СписокДоступныхПериодов.НайтиПоЗначению(МинимальныйПериод);
	Если ЭлементСписка <> Неопределено Тогда
		ИндексЭлемента = СписокДоступныхПериодов.Индекс(ЭлементСписка);
		Для Сч = ИндексЭлемента По СписокДоступныхПериодов.Количество() - 1 Цикл
			Период = СписокДоступныхПериодов.Получить(Сч);
			СписокВыбора.Добавить(Период.Значение, Период.Представление);
		КонецЦикла;
		Если Не ЗначениеЗаполнено(ЗначениеПоУмолчанию) Тогда
			ЗначениеПоУмолчанию = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.ПроизвольныйПериод");
		КонецЕсли;
	Иначе
		Возврат; 
	КонецЕсли;
	
КонецПроцедуры

// Возвращает дату начала переданного вида периода, сам период определяется по переданной дате.
//
// Параметры:
// 	ВидПериода - ПеречислениеСсылка.ДоступныеПериодыОтчета - Вид периода.
//  ДатаПериода - Дата - Дата, принадлежащая периоду.
//
// Возвращаемое значение:
//   Дата - Дата начала периода.
//
Функция НачалоПериодаОтчета(ВидПериода, ДатаПериода) Экспорт
	
	НачалоПериода = ДатаПериода;
	
	Если ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Год") Тогда
		НачалоПериода = НачалоГода(ДатаПериода);
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Полугодие") Тогда
		Если Месяц(ДатаПериода) > 6 Тогда
			НачалоПериода = Дата(Год(ДатаПериода), 7, 1);
		Иначе
			НачалоПериода = Дата(Год(ДатаПериода), 1, 1);
		КонецЕсли;
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Квартал") Тогда
		НачалоПериода = НачалоКвартала(ДатаПериода);
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Месяц") Тогда
		НачалоПериода = НачалоМесяца(ДатаПериода);
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Декада") Тогда
		Если День(ДатаПериода) <= 10 Тогда
			НачалоПериода = Дата(Год(ДатаПериода), Месяц(ДатаПериода), 1);
		ИначеЕсли День(ДатаПериода) > 10 И День(ДатаПериода) <= 20 Тогда
			НачалоПериода = Дата(Год(ДатаПериода), Месяц(ДатаПериода), 11);
		Иначе
			НачалоПериода = Дата(Год(ДатаПериода), Месяц(ДатаПериода), 21);
		КонецЕсли;
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Неделя") Тогда
		НачалоПериода = НачалоНедели(ДатаПериода);
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.День") Тогда
		НачалоПериода = НачалоДня(ДатаПериода);
		
	КонецЕсли;
		
	Возврат НачалоПериода;
	
КонецФункции
 
// Возвращает дату окончания переданного вида периода, сам период определяется по переданной дате.
//
// Параметры:
//   ВидПериода - ПеречислениеСсылка.ДоступныеПериодыОтчета - Вид периода.
//   ДатаПериода - Дата - Дата, принадлежащая периоду.
//
// Возвращаемое значение:
//   Дата - Дата окончания периода.
//
Функция КонецПериодаОтчета(ВидПериода, ДатаПериода) Экспорт
	
	КонецПериода = ДатаПериода;
	
	Если ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Год") Тогда
		КонецПериода = КонецГода(ДатаПериода);
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Полугодие") Тогда
		Если Месяц(ДатаПериода) > 6 Тогда
			КонецПериода = КонецГода(ДатаПериода);
		Иначе
			КонецПериода = КонецДня(Дата(Год(ДатаПериода), 6, 30));
		КонецЕсли;
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Квартал") Тогда
		КонецПериода = КонецКвартала(ДатаПериода);
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Месяц") Тогда
		КонецПериода = КонецМесяца(ДатаПериода);
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Декада") Тогда
		Если День(ДатаПериода) <= 10 Тогда
			КонецПериода = КонецДня(Дата(Год(ДатаПериода), Месяц(ДатаПериода), 10));
		ИначеЕсли День(ДатаПериода) > 10 И День(ДатаПериода) <= 20 Тогда
			КонецПериода = КонецДня(Дата(Год(ДатаПериода), Месяц(ДатаПериода), 20));
		Иначе
			КонецПериода = КонецМесяца(ДатаПериода);
		КонецЕсли;
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Неделя") Тогда
		КонецПериода = КонецНедели(ДатаПериода);
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.День") Тогда
		КонецПериода = КонецДня(ДатаПериода);
		
	КонецЕсли;
		
	Возврат КонецПериода;
	
КонецФункции

// Возвращает список периодов, список определяется по переданной дате и виду периода.
// 
// Параметры:
//   НачалоПериода - Дата - Дата начала периода.
//   ВидПериода    - ПеречислениеСсылка.ДоступныеПериодыОтчета - Вид периода.
// 
// Возвращаемое значение:
//   СписокЗначений - Список возможных периодов.
// 
Функция ПолучитьСписокПериодов(Знач НачалоПериода, Знач ВидПериода) Экспорт
	
	СписокПериодов = Новый СписокЗначений;
	Если НачалоПериода = '00010101' Тогда
		Возврат Новый СписокЗначений;
	Иначе
		ЗначениеНачалоПериода = НачалоПериода;
	КонецЕсли;
	
	Если ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Год") Тогда
		ТекущийГод = Год(ЗначениеНачалоПериода);
		СписокПериодов.Добавить(Дата(ТекущийГод - 7, 1, 1), НСтр("ru='Предыдущие года';uk='Попередні роки'"));
		Для Сч = ТекущийГод - 3 По ТекущийГод + 3 Цикл
			СписокПериодов.Добавить(Дата(Сч, 1, 1), Формат(Сч, "ЧГ=0"));
		КонецЦикла;
		СписокПериодов.Добавить(Дата(ТекущийГод + 7, 1, 1), НСтр("ru='Последующие года';uk='Наступні роки'"));
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Полугодие") Тогда
		ТекущийГод = Год(ЗначениеНачалоПериода);
		СписокПериодов.Добавить(Дата(ТекущийГод - 2, 1, 1), Формат(ТекущийГод - 2, "ЧГ=0") + "...");
		Для Сч = ТекущийГод - 1 По ТекущийГод + 1 Цикл
			СписокПериодов.Добавить(Дата(Сч, 1, 1), СтрШаблон(НСтр("ru='I полугодие %1';uk='I півріччя %1'"), Формат(Сч, "ЧГ=0")));
			СписокПериодов.Добавить(Дата(Сч, 7, 1), СтрШаблон(НСтр("ru='II полугодие %1';uk='II півріччя %1'"), Формат(Сч, "ЧГ=0")));
		КонецЦикла;
		СписокПериодов.Добавить(Дата(ТекущийГод + 2, 1, 1), Формат(ТекущийГод + 2, "ЧГ=0") + "...");
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Квартал") Тогда
		ТекущийГод = Год(ЗначениеНачалоПериода);
		СписокПериодов.Добавить(Дата(ТекущийГод - 2, 1, 1), Формат(ТекущийГод - 2, "ЧГ=0") + "...");
		Для Сч = ТекущийГод - 1 По ТекущийГод Цикл
			СписокПериодов.Добавить(Дата(Сч, 1, 1),	 СтрШаблон(НСтр("ru='1 квартал %1';uk='1 квартал %1'"), Формат(Сч, "ЧГ=0")));
			СписокПериодов.Добавить(Дата(Сч, 4, 1),	 СтрШаблон(НСтр("ru='2 квартал %1';uk='2-й квартал %1'"), Формат(Сч, "ЧГ=0")));
			СписокПериодов.Добавить(Дата(Сч, 7, 1),	 СтрШаблон(НСтр("ru='3 квартал %1';uk='3-й квартал %1'"), Формат(Сч, "ЧГ=0")));
			СписокПериодов.Добавить(Дата(Сч, 10, 1), СтрШаблон(НСтр("ru='4 квартал %1';uk='4 квартал %1'"), Формат(Сч, "ЧГ=0")));
		КонецЦикла;
		СписокПериодов.Добавить(Дата(ТекущийГод + 1, 1, 1), Формат(ТекущийГод + 1, "ЧГ=0") + "...");
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Месяц") Тогда
		ТекущийГод = Год(ЗначениеНачалоПериода);
		СписокПериодов.Добавить(Дата(ТекущийГод - 1, 1, 1), Формат(ТекущийГод - 1, "ЧГ=0") + "...");
		Для Сч = 1 По 12 Цикл
			СписокПериодов.Добавить(Дата(ТекущийГод, Сч, 1), Формат(Дата(ТекущийГод, Сч, 1), "ДФ='MMMM yyyy'"));
		КонецЦикла;
		СписокПериодов.Добавить(Дата(ТекущийГод + 1, 1, 1), Формат(ТекущийГод + 1, "ЧГ=0") + "...");

	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Декада") Тогда
		ТекущийГод   = Год(ЗначениеНачалоПериода);
		ТекущийМесяц = Месяц(ЗначениеНачалоПериода);
		
		СчМесяц = ?(ТекущийМесяц - 4 < 1, 12 + ТекущийМесяц - 4, ТекущийМесяц - 4);
		СчГод   = ?(ТекущийМесяц - 4 < 1, ТекущийГод - 1       , ТекущийГод);
		Сч = 6;
		
		Период = Дата(?(СчМесяц <> 1, СчГод, СчГод - 1), ?(СчМесяц > 1, СчМесяц - 1, 12), 1);
		СписокПериодов.Добавить(Период, Формат(Период, "ДФ='MMMM yyyy'") + "...");
		Пока Сч >0 Цикл
			СписокПериодов.Добавить(Дата(СчГод, СчМесяц, 1),  СтрШаблон(НСтр("ru='I дек. %1';uk='I дек. %1'"), Нрег(Формат(Дата(СчГод, СчМесяц, 1), "ДФ='MMMM yyyy'"))));
			СписокПериодов.Добавить(Дата(СчГод, СчМесяц, 11), СтрШаблон(НСтр("ru='II дек. %1';uk='II дек. %1'"), Нрег(Формат(Дата(СчГод, СчМесяц, 1), "ДФ='MMMM yyyy'"))));
			СписокПериодов.Добавить(Дата(СчГод, СчМесяц, 21), СтрШаблон(НСтр("ru='III дек. %1';uk='III дек. %1'"), Нрег(Формат(Дата(СчГод, СчМесяц, 1), "ДФ='MMMM yyyy'"))));
			СчМесяц = СчМесяц + 1;
			Если СчМесяц > 12 Тогда
				СчГод = СчГод + 1;
				СчМесяц = 1;
			КонецЕсли;
			Сч = Сч - 1;
		КонецЦикла;
		СписокПериодов.Добавить(Дата(СчГод, СчМесяц, 1), Формат(Дата(СчГод, СчМесяц, 1), "ДФ='MMMM yyyy'") + "...");
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Неделя") Тогда
		НачалоНедели = НачалоНедели(ЗначениеНачалоПериода) - 21 * 86400;
		
		СписокПериодов.Добавить(НачалоНедели - 7 * 86400, НСтр("ru='Пред. недели ...';uk='Поперед. тижні ...'"));
		Для Сч = 0 По 6 Цикл
			НачНедели = НачалоНедели + 7 * Сч * 86400;  
			КонНедели = КонецНедели(НачНедели);
			СписокПериодов.Добавить(НачНедели, Формат(НачНедели, "ДФ=dd.MM") + " - " + Формат(КонНедели, "ДФ=dd.MM"));
		КонецЦикла;
		СписокПериодов.Добавить(НачалоНедели + 7 * 86400, НСтр("ru='След. недели ...';uk='Наст. тижні ...'"));
		
	ИначеЕсли ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.День") Тогда
		КонецНедели   = КонецНедели(ЗначениеНачалоПериода);
		ДатаДняНедели = НачалоНедели(ЗначениеНачалоПериода);
		
		СписокПериодов.Добавить(ДатаДняНедели - 86400, НСтр("ru='Предыдущая неделя';uk='Попередній тиждень'"));
		
		Пока ДатаДняНедели < КонецНедели Цикл
			ДеньНед = ДеньНедели(ДатаДняНедели);
			
			СписокПериодов.Добавить(ДатаДняНедели, Формат(ДатаДняНедели, "ДФ='dd MMMM yyyy (ddd)'"));
			
			ДатаДняНедели = ДатаДняНедели + 86400;
		КонецЦикла;
		
		СписокПериодов.Добавить(КонецНедели + 1, НСтр("ru='Следующая неделя';uk='Наступний тиждень'"));
	КонецЕсли;
		
	Возврат СписокПериодов;
	
КонецФункции

// Возвращает вид периода по переданным датам начала и окончания этого периода.
// 
// Параметры:
// 	НачалоПериода - Дата - Дата начала периода.
//  КонецПериода  - Дата - Дата окончания периода.
//	МинимальныйВидПериода - Перечисление.ДоступныеПериодыОтчета - Наименьший доступный вид периода.
// 
// Возвращаемое значение:
//   ПеречислениеСсылка.ДоступныеПериодыОтчета - Вид периода.
// 
Функция ПолучитьВидПериода(Знач НачалоПериода, Знач КонецПериода, Знач МинимальныйВидПериода = Неопределено) Экспорт
	
	ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.ПроизвольныйПериод");
	Если ЗначениеЗаполнено(НачалоПериода) И ЗначениеЗаполнено(КонецПериода) Тогда
		Начало = НачалоДня(НачалоПериода);
		Конец  = КонецДня(КонецПериода);
		Если Начало = НачалоДня(НачалоПериода) И Конец = КонецДня(НачалоПериода) Тогда
			ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.День");
		ИначеЕсли Начало = НачалоНедели(НачалоПериода) И Конец = КонецНедели(НачалоПериода) Тогда
			ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Неделя");
		ИначеЕсли Начало = НачалоМесяца(НачалоПериода) И Конец = КонецМесяца(НачалоПериода) Тогда
			ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Месяц");
		ИначеЕсли Начало = НачалоКвартала(НачалоПериода) И Конец = КонецКвартала(НачалоПериода) Тогда
			ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Квартал");
		ИначеЕсли Начало = НачалоГода(НачалоПериода) И Конец = КонецГода(НачалоПериода) Тогда
			ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Год");
		ИначеЕсли Начало = Дата(Год(НачалоПериода), 1, 1) И Конец = Дата(Год(НачалоПериода), 6, 30, 23, 59, 59)
			ИЛИ Начало = Дата(Год(НачалоПериода), 7, 1) И Конец = Дата(Год(НачалоПериода), 12, 31, 23, 59, 59) Тогда
			ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Полугодие");
		ИначеЕсли Начало = Дата(Год(НачалоПериода), Месяц(НачалоПериода), 1) 
			И Конец = Дата(Год(НачалоПериода), Месяц(НачалоПериода), 10, 23, 59, 59)
			ИЛИ Начало = Дата(Год(НачалоПериода), Месяц(НачалоПериода), 11) 
			И Конец = Дата(Год(НачалоПериода), Месяц(НачалоПериода), 20, 23, 59, 59)
			ИЛИ Начало = Дата(Год(НачалоПериода), Месяц(НачалоПериода), 1) 
			И Конец = КонецМесяца(НачалоПериода)	Тогда
			ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Декада");
		КонецЕсли;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(МинимальныйВидПериода) Тогда
		СписокДоступныхПериодов = ПолучитьСписокДоступныхПериодов();
		
		ПозицияВидПериода            = СписокДоступныхПериодов.Индекс(СписокДоступныхПериодов.НайтиПоЗначению(ВидПериода));
		ПозицияМинимальныйВидПериода = СписокДоступныхПериодов.Индекс(СписокДоступныхПериодов.НайтиПоЗначению(МинимальныйВидПериода));
		
		Если ПозицияВидПериода < ПозицияМинимальныйВидПериода Тогда
			ВидПериода = МинимальныйВидПериода;
		КонецЕсли;
	КонецЕсли;
	
	Возврат ВидПериода;
	
КонецФункции

// Возвращает представление периода.
// 
// Параметры:
//   ВидПериода    - ПеречислениеСсылка.ДоступныеПериодыОтчета - Вид периода.
//   НачалоПериода - Дата - Дата начала периода.
//   КонецПериода  - Дата - Дата окончания периода.
// 
// Возвращаемое значение:
//   Строка - Текстовое представление периода.
// 
Функция ПолучитьПредставлениеПериодаОтчета(ВидПериода, Знач НачалоПериода, Знач КонецПериода) Экспорт
	
	Если ВидПериода = ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.ПроизвольныйПериод") Тогда	
		Если Не ЗначениеЗаполнено(НачалоПериода) И Не ЗначениеЗаполнено(КонецПериода) Тогда
			Возврат "";
		Иначе
			Возврат Формат(НачалоПериода, "ДФ=dd.MM.yy") + " - " + Формат(КонецПериода, "ДФ=dd.MM.yy");
		КонецЕсли;
	Иначе
		РасчетныйВидПериода = ПолучитьВидПериода(НачалоПериода, КонецПериода);
		Если РасчетныйВидПериода <> ВидПериода И ЗначениеЗаполнено(НачалоПериода) Тогда
			ВидПериода = РасчетныйВидПериода;
		КонецЕсли;
		
		Список = ПолучитьСписокПериодов(НачалоПериода, ВидПериода);
		
		ЭлементСписка = Список.НайтиПоЗначению(НачалоПериода);
		Если ЭлементСписка <> Неопределено Тогда
			Возврат ЭлементСписка.Представление;
		Иначе
			Возврат "";
		КонецЕсли;
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

// Подбирает период отчета по виду периода и текущим датам отчетов.
//
// Параметры:
//	ВидПериода    - ПеречислениеСсылка.ДоступныеПериодыОтчета - Вид периода.
//	Текст         - Строка - Текстовое описание периода.
//	ДатаНачала    - Дата - Дата начала периода.
//	ДатаОкончания - Дата - Дата окончания периода.
//
// Возвращаемое значение:
//	СписокЗначений - Список возможных периодов.
//		* Значение - Дата - Дата начала периода.
//		* Представление - Строка - Текстовое описание периода.
//
Функция ПодобратьПериодОтчета(ВидПериода, Текст, ДатаНачала, ДатаОкончания) Экспорт
	
	ДанныеДляВыбора = Новый СписокЗначений;
	
	МассивСлов = ПолучитьМассивСловПредставляющихПериодОтчета(Текст);
	
	ПолучитьЗначениеПериода(ВидПериода, МассивСлов, ДанныеДляВыбора);
	
	Возврат ДанныеДляВыбора;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПолучитьЗначениеПериода(ВидПериода, МассивСлов, ДанныеДляВыбора)

	ДатаСегодня = ТекущаяДата(); // Дата сеанса не используется.

	День  = День(ДатаСегодня);
	Месяц = Месяц(ДатаСегодня);
	Год   = Год(ДатаСегодня);
	
	Если ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.День") = ВидПериода Тогда
		Если МассивСлов.Количество() > 0 Тогда                 
			Если СодержитСимволы(МассивСлов[0], "1234567890") Тогда
				День = Число(МассивСлов[0]);
			КонецЕсли;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 1 Тогда
			НомерМесяца = ПолучитьМесяц(МассивСлов[1]);
			Если НомерМесяца <> Неопределено Тогда
				Месяц = НомерМесяца;
			КонецЕсли;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 2 Тогда
			Если СодержитСимволы(МассивСлов[2], "1234567890") Тогда
				Год = ПолучитьМесяц(МассивСлов[2]);
			КонецЕсли;
		КонецЕсли;
		
		Попытка
			ДатаДляВыбора = Дата(Год, Месяц, День);
		Исключение
			Возврат;
		КонецПопытки;
	
		ДанныеДляВыбора.Добавить(ДатаДляВыбора, Формат(ДатаДляВыбора, "ДЛФ=DD"));
		
	ИначеЕсли ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Неделя") = ВидПериода Тогда
	// Период Неделя не обрабатывается.
	ИначеЕсли ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Декада") = ВидПериода Тогда
		Если День <= 10 Тогда
			НомерДекады = 1;
		ИначеЕсли День >= 11 И День <= 20 Тогда
			НомерДекады = 2;
		ИначеЕсли День >= 21 Тогда
			НомерДекады = 3;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 0 Тогда
			Если СодержитСимволы(МассивСлов[0], "123") Тогда
				НомерДекады = Число(МассивСлов[0]);
			Иначе
				Возврат;
			КонецЕсли;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 1 Тогда
			Если СтрНайти(МассивСлов[1], "дек") = 0  Тогда
				Возврат;
			КонецЕсли;
		КонецЕсли;
		
		
		Если МассивСлов.Количество() > 2 Тогда
			НомерМесяца = ПолучитьМесяц(МассивСлов[2]);
			Если НомерМесяца <> Неопределено Тогда
				Месяц = НомерМесяца;
			КонецЕсли;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 3 Тогда
			Если СодержитСимволы(МассивСлов[3], "1234567890") Тогда 
				Год = ПолучитьМесяц(МассивСлов[3]);
			КонецЕсли;
		КонецЕсли;
		
		Попытка 
			НачалоДекады = Дата(Год, Месяц, (НомерДекады - 1) * 10 + 1);
			КонецДекады  = КонецПериодаОтчета(ВидПериода, НачалоДекады);
		Исключение
			Возврат;
		КонецПопытки;
		
		ДанныеДляВыбора.Добавить(НачалоДекады, ПолучитьПредставлениеПериодаОтчета(ВидПериода, НачалоДекады, КонецДекады))
		
	ИначеЕсли ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Месяц") = ВидПериода Тогда
		День = 1;

		Если МассивСлов.Количество() > 0 Тогда
			НомерМесяца = ПолучитьМесяц(МассивСлов[0]);
			Если НомерМесяца <> Неопределено Тогда
				Месяц = НомерМесяца;
			КонецЕсли;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 1 Тогда
			Если СодержитСимволы(МассивСлов[1], "1234567890") Тогда 
				Год = ПолучитьМесяц(МассивСлов[1]);
			КонецЕсли;
		КонецЕсли;
		
		Попытка
			НачалоМесяца = Дата(Год, Месяц, День);
			КонецМесяца  = КонецПериодаОтчета(ВидПериода, НачалоМесяца);
		Исключение
			Возврат;
		КонецПопытки;
		
		ДанныеДляВыбора.Добавить(НачалоМесяца, ПолучитьПредставлениеПериодаОтчета(ВидПериода, НачалоМесяца, КонецМесяца))
		
	ИначеЕсли ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Квартал") = ВидПериода Тогда
		НомерКвартала = 1;
		Если Месяц <= 3 Тогда
			НомерКвартала = 1;
		ИначеЕсли Месяц >= 4 И Месяц <= 6 Тогда
			НомерКвартала = 2;
		ИначеЕсли Месяц >= 7 И Месяц <= 9 Тогда
			НомерКвартала = 3;
		ИначеЕсли Месяц >= 10 Тогда
			НомерКвартала = 4;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 0 Тогда
			Если СодержитСимволы(МассивСлов[0], "1234") Тогда
				НомерКвартала = Число(МассивСлов[0]);
			Иначе
				Возврат;
			КонецЕсли;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 1 Тогда
			Если СтрНайти(МассивСлов[1], "кв") = 0  Тогда
				Возврат;
			КонецЕсли;
		КонецЕсли;

		Если МассивСлов.Количество() > 2 Тогда
			Если СодержитСимволы(МассивСлов[2], "1234567890") Тогда 
				Год = ПолучитьМесяц(МассивСлов[2]);
			КонецЕсли;
		КонецЕсли;
		
		Попытка 
			НачалоКвартала = НачалоКвартала(Дата(Год, (НомерКвартала - 1) * 3 + 1, 1));
			КонецКвартала  = КонецПериодаОтчета(ВидПериода, НачалоКвартала);
		Исключение
			Возврат;
		КонецПопытки;
	
		ДанныеДляВыбора.Добавить(НачалоКвартала, ПолучитьПредставлениеПериодаОтчета(ВидПериода, НачалоКвартала, КонецКвартала))

	ИначеЕсли ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Полугодие") = ВидПериода Тогда
		НомерПолугодия = 1;
		Если Месяц <= 6 Тогда
			НомерПолугодия = 1;
		Иначе
			НомерПолугодия = 2;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 0 Тогда
			Если СодержитСимволы(МассивСлов[0], "12") Тогда
				НомерПолугодия = Число(МассивСлов[0]);
			Иначе
				Возврат;
			КонецЕсли;
		КонецЕсли;
		
		Если МассивСлов.Количество() > 1 Тогда
			Если СтрНайти(МассивСлов[1], "пол") = 0  Тогда
				Возврат;
			КонецЕсли;
		КонецЕсли;

		Если МассивСлов.Количество() > 2 Тогда
			Если СодержитСимволы(МассивСлов[2], "1234567890") Тогда 
				Год = ПолучитьМесяц(МассивСлов[2]);
			КонецЕсли;
		КонецЕсли;
		
		Попытка 
			НачалоПолугодия = НачалоКвартала(Дата(Год, (НомерПолугодия - 1) * 6 + 1, 1));
			КонецПолугодия  = КонецПериодаОтчета(ВидПериода, НачалоПолугодия);
		Исключение
			Возврат;
		КонецПопытки;
		
		ДанныеДляВыбора.Добавить(НачалоПолугодия, ПолучитьПредставлениеПериодаОтчета(ВидПериода, НачалоПолугодия, КонецПолугодия))
		
	ИначеЕсли ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Год") = ВидПериода Тогда
		Для Каждого Слово Из МассивСлов Цикл
			Если СодержитСимволы(Слово, "1234567890") Тогда 
				Год = Число(Слово);
				Если Год < 10 Тогда // Один знак.
					ТекГод = Год(ДатаСегодня);
					Год = Цел(ТекГод / 10) * 10 + Год;
				ИначеЕсли Год >= 10 И Год < 100  Тогда // Два знака.
					ТекГод             = Год(ДатаСегодня);
					ТекСтолетие        = Цел(ТекГод / 100) * 100;
					ПредыдущееСтолетие = ТекСтолетие - 100;
					ВерхняяГраницаТекСтолетия = ТекГод - ТекСтолетие + 20;
					Если Год >= 0 И ВерхняяГраницаТекСтолетия >= Год Тогда
						Год = Год + ТекСтолетие;
					Иначе
						Год = Год + ПредыдущееСтолетие;
					КонецЕсли;
				КонецЕсли;
				Попытка 
					НачалоГода = Дата(Год, 1, 1);
					КонецГода  = Дата(Год, 12, 31, 23, 59, 59);
				Исключение
					Возврат;
				КонецПопытки;
				ДанныеДляВыбора.Добавить(НачалоГода, ПолучитьПредставлениеПериодаОтчета(ВидПериода, НачалоГода, КонецГода))
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьМесяц(СтрокаПредставленияМесяца)
	
	СписокМесяцев = Новый СписокЗначений;
	СписокМесяцев.Добавить(1, "янв");
	СписокМесяцев.Добавить(2, "фев");
	СписокМесяцев.Добавить(3, "мар");
	СписокМесяцев.Добавить(4, "апр");
	СписокМесяцев.Добавить(5, "май");
	СписокМесяцев.Добавить(6, "июн");
	СписокМесяцев.Добавить(7, "июл");
	СписокМесяцев.Добавить(8, "авг");
	СписокМесяцев.Добавить(9, "сен");
	СписокМесяцев.Добавить(10, "окт");
	СписокМесяцев.Добавить(11, "ноя");
	СписокМесяцев.Добавить(12, "дек");
	
	Месяц = Неопределено;
	
	Если СодержитСимволы(СтрокаПредставленияМесяца, "1234567890") Тогда
		Месяц = Число(СтрокаПредставленияМесяца);
	Иначе
		Для Каждого ЭлементСписка Из СписокМесяцев Цикл
			Если СтрНайти(СтрокаПредставленияМесяца, ЭлементСписка.Представление) > 0 Тогда
				Месяц = ЭлементСписка.Значение;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	Возврат Месяц;
	
КонецФункции 

Функция СодержитСимволы(СтрокаНаПроверки, СтрокаСимволов)
	
	СодержатТолькоПодстроку = Истина;
	
	СимволыПроверки = Новый СписокЗначений;
	
	Для Сч = 1 По СтрДлина(СтрокаСимволов) Цикл
		СимволыПроверки.Добавить(КодСимвола(СтрокаСимволов, Сч));
	КонецЦикла;
	
	Для Сч = 1 По СтрДлина(СтрокаНаПроверки) Цикл
		Если СимволыПроверки.НайтиПоЗначению(КодСимвола(СтрокаНаПроверки, Сч)) = Неопределено Тогда
			СодержатТолькоПодстроку = Ложь;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат СодержатТолькоПодстроку;
	
КонецФункции

Функция ПолучитьСписокДоступныхПериодов()
	
	СписокДоступныхПериодов = Новый СписокЗначений;
	СписокДоступныхПериодов.Добавить(ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.День"));
	СписокДоступныхПериодов.Добавить(ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Месяц"));
	СписокДоступныхПериодов.Добавить(ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Квартал"));
	СписокДоступныхПериодов.Добавить(ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Полугодие"));
	СписокДоступныхПериодов.Добавить(ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Год"));
	СписокДоступныхПериодов.Добавить(ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.ПроизвольныйПериод"));
	
	Возврат СписокДоступныхПериодов;
	
КонецФункции

// Из переданного текста извлекаются строки, задающие период отчета.
//
// Параметры:
//  Текст        - текст, содержащий данные периода отчета.
//
// Возвращаемое значение:
//   Массив      - строки, задающие период отчета.
//
Функция ПолучитьМассивСловПредставляющихПериодОтчета(Текст)
	
	МассивСлов = Новый Массив;
	ПоисковыйТекст = НРег(СокрЛП(Текст));
	ПозицияРазделителя = 1;
	Пока ПоисковыйТекст <> "" Цикл
		Слово = "";
		ПозицияРазделителя = 0;
		Если СтрНайти(ПоисковыйТекст, " ") > 0 Тогда
			 ПозицияРазделителя = ?(ПозицияРазделителя > 0, Мин(ПозицияРазделителя, СтрНайти(ПоисковыйТекст, " ")), СтрНайти(ПоисковыйТекст, " "));
		КонецЕсли;
		Если СтрНайти(ПоисковыйТекст, ".") > 0 Тогда
			 ПозицияРазделителя = ?(ПозицияРазделителя > 0, Мин(ПозицияРазделителя, СтрНайти(ПоисковыйТекст, ".")), СтрНайти(ПоисковыйТекст, "."));
		КонецЕсли;
		Если СтрНайти(ПоисковыйТекст, "/") > 0 Тогда
			 ПозицияРазделителя = ?(ПозицияРазделителя > 0, Мин(ПозицияРазделителя, СтрНайти(ПоисковыйТекст, "/")), СтрНайти(ПоисковыйТекст, "/"));
		КонецЕсли;
		Если СтрНайти(ПоисковыйТекст, "\") > 0 Тогда
			 ПозицияРазделителя = ?(ПозицияРазделителя > 0, Мин(ПозицияРазделителя, СтрНайти(ПоисковыйТекст, "\")), СтрНайти(ПоисковыйТекст, "\"));
		КонецЕсли;
		
		Если ПозицияРазделителя = 0 Тогда
			Слово = СокрЛП(ПоисковыйТекст);
			ПоисковыйТекст = "";
		Иначе
			Слово = СокрЛП(Сред(ПоисковыйТекст, 1, ПозицияРазделителя-1));
		КонецЕсли;
		
		Если Слово <> " " И Слово <> "." И Слово <> "/" И Слово <> "\" И Слово <> "" Тогда
			МассивСлов.Добавить(Слово);
		КонецЕсли;

		ПоисковыйТекст = СокрЛП(Прав(ПоисковыйТекст, СтрДлина(ПоисковыйТекст) - ПозицияРазделителя));
	КонецЦикла;
	
	Возврат МассивСлов;
	
КонецФункции

#КонецОбласти