
#Область ПрограммныйИнтерфейс

// Заполняет индекс картинки у строки дерева цен
//
// Параметры:
//  СтрокаДереваЦен - ДанныеФормыКоллекцияЭлементовДерева,СтрокаДереваЗначений - элемент дерева значений.
//
Процедура ЗаполнитьИндексКартинкиСтрокиДереваЦен(СтрокаДереваЦен) Экспорт
	
	Если ТипЗнч(СтрокаДереваЦен) = Тип("ДанныеФормыЭлементДерева") Тогда
		Если СтрокаДереваЦен.ПолучитьРодителя() = Неопределено Тогда
			СтрокаДереваЦен.ИндексКартинки = 0;
		Иначе
			СтрокаДереваЦен.ИндексКартинки = 2;
		КонецЕсли;
	ИначеЕсли ТипЗнч(СтрокаДереваЦен) = Тип("СтрокаДереваЗначений") Тогда
		Если СтрокаДереваЦен.Родитель = Неопределено Тогда
			СтрокаДереваЦен.ИндексКартинки = 0;
		Иначе
			СтрокаДереваЦен.ИндексКартинки = 2;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Осуществляет поиск строки с определенным видом цен в таблице
//
// Параметры:
//  ВыбранныеЦены - ДанныеФормыКоллекция - Таблица, в которой осуществляется поиск
//  ВидЦены - СправочникСсылка.ВидыЦен - Ссылка на вид цен, который необходимо найти.
//
// Возвращаемое значение:
//  ДанныеФормыЭлементКоллекции - найденный вид цен, содержит:
//  * Ссылка - СправочникСсылка.ВидыЦен
//
Функция НайтиСтрокуВидаЦен(ВыбранныеЦены, ВидЦены) Экспорт
	
	НайденныеСтроки = ВыбранныеЦены.НайтиСтроки(Новый Структура("Ссылка", ВидЦены));
	
	Если НайденныеСтроки.Количество()>0 Тогда
		Возврат НайденныеСтроки[0];
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Осуществляет поиск строки с определенным видом цен в таблице по имени измененного поля.
//
// Параметры:
//  ВыбранныеЦены - ДанныеФормыКоллекция - Таблица, в которой осуществляется поиск
//  ИзмененноеПоле - Строка - Имя поля.
//
// Возвращаемое значение:
//  ДанныеФормыЭлементКоллекции - найденный вид цен.
//
Функция СтрокаВидаЦеныПоИмениПоля(ВыбранныеЦены, Знач ИзмененноеПоле) Экспорт
	
	СтрокаИзмененныйВидЦены = Неопределено;
	Для Каждого СтрокаВидЦены Из ВыбранныеЦены Цикл
		Если СтрокаВидЦены.ИмяКолонки = ИзмененноеПоле
			Или "Упаковка" + СтрокаВидЦены.ИмяКолонки = ИзмененноеПоле
			Или "СтараяЦена" + СтрокаВидЦены.ИмяКолонки = ИзмененноеПоле
			Или "ПроцентИзменения" + СтрокаВидЦены.ИмяКолонки = ИзмененноеПоле Тогда
			СтрокаИзмененныйВидЦены = СтрокаВидЦены;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат СтрокаИзмененныйВидЦены;
	
КонецФункции

// Помечает все зависимые цены в таблице
//
// Параметры:
//  Форма - см. УстановкаЦенСервер.ПостроитьДеревоЦен.Форма
//
Процедура ВыбратьВсеЗависимыеЦены(Форма) Экспорт
	
	Заполнять = Истина;
	Пока Заполнять Цикл
		
		Заполнять = Ложь;
		Для Каждого ТекСтрока Из Форма.ВыбранныеЦены Цикл
			
			Если ТекСтрока.Выбрана Тогда 
				
				Для Каждого ЗависимаяЦена Из ТекСтрока.ЗависимыеЦены Цикл
					СтрокаЗависимойЦены = НайтиСтрокуВидаЦен(Форма.ВыбранныеЦены, ЗависимаяЦена.Значение);
					Если СтрокаЗависимойЦены <> Неопределено И Не СтрокаЗависимойЦены.Выбрана И Не СтрокаЗависимойЦены.ЗапрещенныйВидЦены Тогда
						СтрокаЗависимойЦены.Выбрана = Истина;
						ВыбранныеЦеныИзменены = Истина;
						Заполнять = Истина;
					КонецЕсли;
				КонецЦикла;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	УстановкаЦенКлиентСервер.ПроставитьФлагиВлияетЗависитНаКлиенте(Форма);
	
КонецПроцедуры

// Помечает все влияющие цены в таблице
//
// Параметры:
//  Форма - см. УстановкаЦенСервер.ПостроитьДеревоЦен.Форма
//
Процедура ВыбратьВсеВлияющиеЦены(Форма) Экспорт
	
	Заполнять = Истина;
	Пока Заполнять Цикл
		
		Заполнять = Ложь;
		Для Каждого ТекСтрока Из Форма.ВыбранныеЦены Цикл
			
			Если ТекСтрока.Выбрана Тогда 
				
				Для Каждого ВлияющаяЦена Из ТекСтрока.ВлияющиеЦены Цикл
					СтрокаВыбраннойЦены = НайтиСтрокуВидаЦен(Форма.ВыбранныеЦены, ВлияющаяЦена.Значение);
					Если Не СтрокаВыбраннойЦены.Выбрана И Не СтрокаВыбраннойЦены.ЗапрещенныйВидЦены Тогда
						СтрокаВыбраннойЦены.Выбрана = Истина;
						ВыбранныеЦеныИзменены = Истина;
						Заполнять = Истина;
					КонецЕсли;
				КонецЦикла;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	УстановкаЦенКлиентСервер.ПроставитьФлагиВлияетЗависитНаКлиенте(Форма);
	
КонецПроцедуры

// Возвращает выбранные строки видов цен
//
// Параметры:
//  Форма - см. УстановкаЦенСервер.ПостроитьДеревоЦен.Форма
//
// Возвращаемое значение:
//  Массив из Структура - Выбранные строки видов цен:
//  * Ссылка - СправочникСсылка.ВидыЦен, СправочникСсылка.ВидыЦенПоставщиков - Виды цен
//  * Наименование - Строка - Наименование видов цен
//
Функция ВыбранныеСтрокиТаблицыВидовЦен(Форма) Экспорт
	
	ВидыЦен = Новый Массив();
	
	Для Каждого ТекСтрока Из Форма.ВыбранныеЦены Цикл
		Если ТекСтрока.Выбрана Тогда
			ВидыЦен.Добавить(ТекСтрока);
		КонецЕсли;
	КонецЦикла;
	
	Возврат ВидыЦен;
	
КонецФункции

// Проверяет выбранность всех зависимых видов цен
//
// Параметры:
//  Форма - см. УстановкаЦенСервер.ПостроитьДеревоЦен.Форма
//
// Возвращаемое значение:
//  Булево - Истина, если в форме обнаружены невыбранные зависимые цены.
//
Функция НеВыбраныЗависимыеЦены(Форма) Экспорт
	
	Для Каждого СтрокаВидаЦен Из ВыбранныеСтрокиТаблицыВидовЦен(Форма) Цикл
		
		ЗависимыеЦены = Новый Массив;
		Для Каждого ЗависимаяЦена Из СтрокаВидаЦен.ЗависимыеЦены Цикл
			СтрокаЗависимойЦены = УстановкаЦенКлиентСервер.НайтиСтрокуВидаЦен(Форма.ВыбранныеЦены, ЗависимаяЦена.Значение);
			Если СтрокаЗависимойЦены <> Неопределено Тогда
				ЗависимыеЦены.Добавить(СтрокаЗависимойЦены);
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого СтрокаЗависимойЦены Из ЗависимыеЦены Цикл
			
			Если Не СтрокаЗависимойЦены.Выбрана Тогда
				Возврат Истина;
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

// Возвращает массив ссылок на выбранные пользователем виды цен
//
// Параметры:
//  Форма - см. УстановкаЦенСервер.ПостроитьДеревоЦен.Форма
//
// Возвращаемое значение:
//  Массив из СправочникСсылка.ВидыЦен, СправочникСсылка.ВидыЦенПоставщиков - Массив ссылок на выбранные пользователем виды цен.
//
Функция ВыбранныеВидыЦен(Форма) Экспорт
	
	ВидыЦен = Новый Массив();
	
	Для Каждого ТекСтрока Из Форма.ВыбранныеЦены Цикл
		Если ТекСтрока.Выбрана Тогда
			ВидыЦен.Добавить(ТекСтрока.Ссылка);
		КонецЕсли;
	КонецЦикла;
	
	Возврат ВидыЦен;
	
КонецФункции

// Заполняет флаги Влияет и Зависит в таблице выбранных цен
//
// Параметры:
//  Форма - см. УстановкаЦенСервер.ПостроитьДеревоЦен.Форма
//
Процедура ПроставитьФлагиВлияетЗависитНаКлиенте(Форма) Экспорт
	
	Для Каждого Цена Из Форма.ВыбранныеЦены Цикл
		
		Цена.Зависит = Ложь;
		Цена.Влияет  = Ложь;
		
	КонецЦикла;
	
	Для Каждого Цена Из Форма.ВыбранныеЦены Цикл
		
		Если Цена.Выбрана Тогда 
			
			Для Каждого ЗависимаяЦена Из Цена.ЗависимыеЦены Цикл
				
				СтрокаЗависимойЦены         = НайтиСтрокуВидаЦен(Форма.ВыбранныеЦены, ЗависимаяЦена.Значение);
				Если СтрокаЗависимойЦены <> Неопределено Тогда
					СтрокаЗависимойЦены.Зависит = Не СтрокаЗависимойЦены.Выбрана;
				КонецЕсли;
				
			КонецЦикла;
			
			Для Каждого ВлияющаяЦена Из Цена.ВлияющиеЦены Цикл
				
				СтрокаВыбраннойЦены        = НайтиСтрокуВидаЦен(Форма.ВыбранныеЦены, ВлияющаяЦена.Значение);
				СтрокаВыбраннойЦены.Влияет = Не СтрокаВыбраннойЦены.Выбрана;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Осуществляет округление цены в соответствии с правилами округления для вида цен
//
// Параметры:
//  ЗначениеЦены - Число - значение цены, которое необходимо округлить
//  СтрокаСправочникаВидовЦен - СтрокаТаблицыЗначений - вид цены, в соответствии с которым необходимо округлить цену.
//
// Возвращаемое значение:
//  Число - Округленное значение цены.
//
Функция ОкруглитьЦену(ЗначениеЦены, СтрокаСправочникаВидовЦен) Экспорт
	
	КоличествоСтрок = СтрокаСправочникаВидовЦен.ПравилаОкругленияЦены.Количество();
	
	Для Индекс = 1 По КоличествоСтрок Цикл
		
		ПравилаОкругления = СтрокаСправочникаВидовЦен.ПравилаОкругленияЦены[КоличествоСтрок - Индекс];
		
		Если ПравилаОкругления.НижняяГраницаДиапазонаЦен <= ЗначениеЦены Тогда
			
			Если ЗначениеЗаполнено(ПравилаОкругления.ТочностьОкругления) Тогда
				ЗначениеЦены = ЦенообразованиеКлиентСервер.ОкруглитьЦену(ЗначениеЦены, ПравилаОкругления.ТочностьОкругления, СтрокаСправочникаВидовЦен.ВариантОкругления);
			КонецЕсли;
			
			Если ЗначениеЗаполнено(ПравилаОкругления.ПсихологическоеОкругление) Тогда
				ЗначениеЦены = ЦенообразованиеКлиентСервер.ПрименитьПсихологическоеОкругление(ЗначениеЦены, ПравилаОкругления.ПсихологическоеОкругление);
			КонецЕсли;
			
			Прервать;
			
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ЗначениеЦены;
	
КонецФункции

// Возвращает строку кода на языке платформы BAF для пересчета цен из упаковки в упаковку.
//
// Параметры:
//  СтрокаТаблицыЦен       							- ДанныеФормыЭлементКоллекции 	- строка таблицы
//  ВидЦеныИсточник   						    	- СправочникСсылка.ВидыЦен 		- вид цен, из которого необходимо пересчитать
//  ВидЦеныНазначение  						    	- СправочникСсылка.ВидыЦен 		- вид цен, в который необходимо пересчитать
//  СоответствиеКоэффициентовУпаковокНоменклатуры  	- Соответствие 					- ключ - <УИД номенклатуры> + <УИД упаковки>, значение - коэффициент пары номенклатуры и упаковки.
//
// Возвращаемое значение:
//  Строка - выражение для пересчета цены из упаковки в упаковку.
//
Функция СтрокаПересчетаУпаковок(СтрокаТаблицыЦен,
	                            ВидЦеныИсточник,
	                            ВидЦеныНазначение,
	                            СоответствиеКоэффициентовУпаковокНоменклатуры) Экспорт
	
	СтрокаПересчетаУпаковок = "";
	
	// Определение коэффициента упаковки текущей цены
	УпаковкаЦеныИсточника = СтрокаТаблицыЦен["Упаковка" + ВидЦеныИсточник.ИмяКолонки];
	КоэффициентУпаковкиЦеныИсточника = 1;
	Если ЗначениеЗаполнено(УпаковкаЦеныИсточника) Тогда
		РезультатПоиска = ПолучитьКоэффициентУпаковкиНоменклатуры(СоответствиеКоэффициентовУпаковокНоменклатуры, 
																	СтрокаТаблицыЦен.Номенклатура, 
																	УпаковкаЦеныИсточника);
		Если РезультатПоиска <> Неопределено Тогда 
			КоэффициентУпаковкиЦеныИсточника = РезультатПоиска;
		КонецЕсли;
	КонецЕсли;
	
	// Определение коэффициента упаковки влияющей цены
	УпаковкаЦеныНазначения = СтрокаТаблицыЦен["Упаковка" + ВидЦеныНазначение.ИмяКолонки];
	КоэффициентУпаковкиЦеныНазначения = 1;
	Если ЗначениеЗаполнено(УпаковкаЦеныНазначения) Тогда	
		РезультатПоиска = ПолучитьКоэффициентУпаковкиНоменклатуры(СоответствиеКоэффициентовУпаковокНоменклатуры, 
																	СтрокаТаблицыЦен.Номенклатура, 
																	УпаковкаЦеныНазначения);		
		Если РезультатПоиска <> Неопределено Тогда 
			КоэффициентУпаковкиЦеныНазначения = РезультатПоиска;
		КонецЕсли;																	
	КонецЕсли;
	
	ФорматнаяСтрока = "ЧРД=.; ЧГ=0";
	Если КоэффициентУпаковкиЦеныИсточника <> КоэффициентУпаковкиЦеныНазначения Тогда
		СтрокаПересчетаУпаковок = "/" + Строка(Формат(КоэффициентУпаковкиЦеныИсточника, ФорматнаяСтрока))
		                          + "*" + Строка(Формат(КоэффициентУпаковкиЦеныНазначения, ФорматнаяСтрока));
	КонецЕсли;
		
	Возврат СтрокаПересчетаУпаковок;
	
КонецФункции

// Возвращает строку для пересчета цен из валюты в валюту
//
// Параметры:
//  ВалютаИсточник - СправочникСсылка.Валюты - валюта, из которой необходимо пересчитать
//  ВалютаНазначение - СправочникСсылка.Валюты - валюта, в которую необходимо пересчитать.
//
// Возвращаемое значение:
//  Строка - выражение для пересчета цены из валюты в валюту.
//
Функция СтрокаПересчетаВалюты(ВалютаИсточник, ВалютаНазначение, СоответствиеВалют) Экспорт
	
	Если ВалютаИсточник <> ВалютаНазначение Тогда
		
		СтрокаВалютыИсточника  = НайтиСтрокуВалюты(СоответствиеВалют, ВалютаИсточник);
		СтрокаВалютыНазначения = НайтиСтрокуВалюты(СоответствиеВалют, ВалютаНазначение);
		
		ФорматнаяСтрока = "ЧРД=.; ЧГ=0";
		Если СтрокаВалютыИсточника <> Неопределено И СтрокаВалютыНазначения <> Неопределено Тогда
			Возврат СтрЗаменить("*(" + Строка(Формат(СтрокаВалютыИсточника.Курс, ФорматнаяСтрока))
			        + "*" + Строка(Формат(СтрокаВалютыНазначения.Кратность, ФорматнаяСтрока))
			        + ")/(" + Строка(Формат(СтрокаВалютыНазначения.Курс, ФорматнаяСтрока)) + "*"
			        + Строка(Формат(СтрокаВалютыИсточника.Кратность, ФорматнаяСтрока)) + ")", ",", ".");
		КонецЕсли;
	КонецЕсли;

	Возврат "";
	
КонецФункции

// Осуществляет поиск курса валюты в таблице курсов валют
//
// Параметры:
//  СоответствиеВалют - Соответствие - курсы валют
//  Валюта - СправочникСсылка.Валюты - ссылка на валюту, курсы которой необходимо получить.
//
// Возвращаемое значение:
//  СтрокаТаблицыЗначений - если курс найден, Неопределено в противном случае.
//
Функция НайтиСтрокуВалюты(СоответствиеВалют, Валюта) Экспорт
	
	СтруктураВалюты = СоответствиеВалют.Получить(Валюта);
	
	Если СтруктураВалюты = Неопределено Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрЗаменить(НСтр("ru='Не установлен курс валюты: %Валюта%';uk='Не встановлений курс валюти: %Валюта%'"), "%Валюта%", Валюта));
	КонецЕсли;
	
	Возврат СтруктураВалюты;
	
КонецФункции

// Рассчитывает дату документа по дате и номеру в пределах дня
//
// Параметры:
//  ДатаДокумента - Дата
//  НомерВПределахДня - Число
//
// Возвращаемое значение:
//  Дата - Рассчитанная дата документа.
//
Функция РассчитатьДатуДокумента(ДатаДокумента, НомерВПределахДня) Экспорт
	
	Возврат НачалоДня(ДатаДокумента) + НомерВПределахДня - 1;
	
КонецФункции

// Отметить рекурсивно вниз
//
// Параметры:
//  Родитель - СтрокаДерева - Строка родитель.
//
Процедура ОтметитьРекурсивноВниз(Родитель) Экспорт
	
	Для Каждого СтрокаДерева Из Родитель.ПолучитьЭлементы() Цикл
		
		СтрокаДерева.Выбран = Родитель.Выбран;
		
		ОтметитьРекурсивноВниз(СтрокаДерева);
		
	КонецЦикла;
	
КонецПроцедуры

// Отметить рекурсивно вверх
//
// Параметры:
//  Родитель - СтрокаДерева - Строка дерева.
//
Процедура ОтметитьРекурсивноВверх(СтрокаДерева) Экспорт
	
	Родитель = СтрокаДерева.ПолучитьРодителя();
	Если Родитель <> Неопределено Тогда
		
		Выбран = Неопределено;
		Для Каждого СтрокаТЧ Из Родитель.ПолучитьЭлементы() Цикл
			Если СтрокаТЧ.Выбран И Выбран = Неопределено Тогда
				Выбран = Истина;
			ИначеЕсли Не СтрокаТЧ.Выбран И Выбран = Неопределено Тогда
				Выбран = Ложь;
			ИначеЕсли Выбран <> СтрокаТЧ.Выбран Тогда
				Выбран = 2;
			КонецЕсли;
		КонецЦикла;
		
		Если Выбран = Неопределено Тогда
			Выбран = Ложь;
		КонецЕсли;
		
		Родитель.Выбран = Выбран;
		
		ОтметитьРекурсивноВверх(Родитель);
		
	КонецЕсли;
	
КонецПроцедуры

// Функция - Получить коэффициент упаковки номенклатуры
//
// Параметры:
//  СоответствиеКоэффициентов	 - 	Соответствие 					- ключ - <УИД номенклатуры> + <УИД упаковки>, значение - коэффициент пары номенклатуры и упаковки
//  Номенклатура	 - 	СправочникСсылка.Номенклатура 				- номенклатура, по которой будет производиться поиск
//  Упаковка		 - 	СправочникСсылка.УпаковкиЕдиницыИзмерения 	- упаковка/единица измерения по которой будет производиться поиск.
// 
// Возвращаемое значение:
//  Число, Неопределено - Коэффициент упаковки относительно номенклатуры; Неопределено - если пара "Номенклатура +
//  Упаковка" не найдена.
//
Функция ПолучитьКоэффициентУпаковкиНоменклатуры(СоответствиеКоэффициентов, Номенклатура, Упаковка) Экспорт
	
	СтрокаПоиска = Строка(Номенклатура.УникальныйИдентификатор()) + Строка(Упаковка.УникальныйИдентификатор());
	Возврат СоответствиеКоэффициентов.Получить(СтрокаПоиска);
	
КонецФункции

// Функция - Получить структуру упаковок номенклатуры
// 
// Возвращаемое значение:
//  Структура - структура с ключами Номенклатура и Упаковка.
//
Функция ИнициализироватьОписаниеУпаковкиНоменклатуры() Экспорт
	
	Возврат Новый Структура("Номенклатура, Упаковка");
	
КонецФункции

// Функция - Найти структуру упаковки номенклатуры в массиве
//
// Параметры:
//  МассивСтруктур	 - 	Массив 										- Массив структур с ключами Номенклатура и Упаковка
//  Номенклатура	 - 	СправочникСсылка.Номенклатура 				- номенклатура, по которой будет производиться поиск
//  Упаковка		 - 	СправочникСсылка.УпаковкиЕдиницыИзмерения 	- упаковка/единица измерения по которой будет производиться поиск.
// 
// Возвращаемое значение:
//  Структура, Неопределено - найденная структура или Неопределено, если ничего не найдено.
//
Функция НайтиСтруктуруУпаковкиНоменклатурыВМассиве(МассивСтруктур, Номенклатура, Упаковка) Экспорт 
	
	Для Каждого Структура Из МассивСтруктур Цикл
		
		Если Структура.Номенклатура = Номенклатура И Структура.Упаковка = Упаковка Тогда
			Возврат Структура;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

// Возвращаемое значение:
// 	Структура:
// * ДатаДействующихЦен 		- Дата
// * ПоказыватьПроцентНаценки 	- Булево
// * ПоказыватьИзменениеЦены 	- Булево
// * ПоказыватьДействующиеЦены 	- Булево
// * УстановленыНастройкиОтбора - Булево
// * ВидНоменклатуры 			- СправочникСсылка.ВидыНоменклатуры
// * ВариантНавигации 			- Строка
// * ВидНастройки 				- Строка
// * ТаблицаПараметровОтбора 	- ТаблицаЗначений
// * ВыбранныеЦены 				- см. УстановкаЦенКлиентСервер.ВыбранныеВидыЦен
// * НастройкиКомпоновщика 		- НастройкиКомпоновкиДанных
//
Функция НоваяСтруктураНастроекФормы() Экспорт
	
	Результат = Новый Структура();
	
	Результат.Вставить("НастройкиКомпоновщика");
	Результат.Вставить("ВыбранныеЦены");
	Результат.Вставить("ТаблицаПараметровОтбора");
	Результат.Вставить("ВидНастройки");
	Результат.Вставить("ВариантНавигации");
	Результат.Вставить("ВидНоменклатуры");
	Результат.Вставить("УстановленыНастройкиОтбора");
	Результат.Вставить("ПоказыватьДействующиеЦены");
	Результат.Вставить("ПоказыватьИзменениеЦены");
	Результат.Вставить("ПоказыватьПроцентНаценки");
	Результат.Вставить("ДатаДействующихЦен");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти