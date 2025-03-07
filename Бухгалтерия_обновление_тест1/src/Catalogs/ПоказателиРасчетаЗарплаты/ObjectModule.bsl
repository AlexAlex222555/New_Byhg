#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	// Проверяем допустимость идентификатора.
	
	// - В строке не должно быть разделителей.
	ЕстьРазделители = Ложь;
	Для Позиция = 1 По СтрДлина(Идентификатор) Цикл
		Если СтроковыеФункцииКлиентСервер.ЭтоРазделительСлов(КодСимвола(Идентификатор, Позиция)) Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
				НСтр("ru='Идентификатор содержит недопустимые символы';uk='Ідентифікатор містить неприпустимі символи'"), , "Объект.Идентификатор", , Отказ);
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	// - Строка не должна начинаться с числа.
	КодПервогоСимвола = КодСимвола(Идентификатор, 1);
	Если КодПервогоСимвола >= 48 И КодПервогоСимвола <= 57 Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru='Идентификатор не может начинаться с цифры';uk='Ідентифікатор не може починатися з цифри'"), , "Объект.Идентификатор", , Отказ);
	КонецЕсли;
	
	// Проверяем, нет ли показателя с таким идентификатором.
	ПоказательПоИдентификатору = ЗарплатаКадрыРасширенный.ПоказательПоИдентификатору(Идентификатор);
	Если ПоказательПоИдентификатору <> Неопределено 
		И ПоказательПоИдентификатору <> Ссылка Тогда
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Показатель с идентификатором %1 уже существует.';uk='Показник з ідентифікатором %1 вже існує.'"), Идентификатор);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "Объект.Идентификатор", , Отказ);
	КонецЕсли;
	
	// Проверяем, что в ТЧ ШкалаОценкиСтажа нет одинаковых показателей.
	ШкалаОбъектаСтажаДляПроверки = ШкалаОценкиСтажа.Выгрузить();
	ОбщееКоличествоСтрок = ШкалаОценкиСтажа.Количество(); 
	ШкалаОбъектаСтажаДляПроверки.Колонки.Добавить("Количество");
	ШкалаОбъектаСтажаДляПроверки.ЗаполнитьЗначения(1,"Количество");
	ШкалаОбъектаСтажаДляПроверки.Свернуть("ВерхняяГраницаИнтервалаСтажа","Количество");
	Отбор = Новый Структура;
	Для каждого Строка Из ШкалаОбъектаСтажаДляПроверки Цикл
		Если Строка.Количество > 1 Тогда
			Отбор.Вставить("ВерхняяГраницаИнтервалаСтажа", Строка.ВерхняяГраницаИнтервалаСтажа);
			СтрокиСОдинаковойГраницей = ШкалаОценкиСтажа.НайтиСтроки(Отбор);
			МинимальныйНомерСтроки = ОбщееКоличествоСтрок;
			Для каждого СтрокаСОдинаковойГраницей Из СтрокиСОдинаковойГраницей Цикл
				МинимальныйНомерСтроки = Мин(МинимальныйНомерСтроки, СтрокаСОдинаковойГраницей.НомерСтроки);
			КонецЦикла;
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Граница интервала может быть указана только один раз (до %1 мес.).';uk='Межа інтервалу може бути вказана тільки один раз (до %1 міс.).'"), Строка.ВерхняяГраницаИнтервалаСтажа);
			Поле = "ШкалаОценкиСтажа[" + Формат(МинимальныйНомерСтроки, "ЧН=0; ЧГ=0") + "].ВерхняяГраницаИнтервалаСтажа";
			
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , Поле, "Объект", Отказ);
		КонецЕсли;
	КонецЦикла;
	
	// Проверяем, что показатель не является базовым сам для себя.
	Если ТипПоказателя = Перечисления.ТипыПоказателейРасчетаЗарплаты.ЧисловойЗависящийОтДругогоПоказателя 
		И ЗначениеЗаполнено(Ссылка) И Ссылка = БазовыйПоказатель Тогда 
		ТекстСообщения = НСтр("ru='В поле ""Базовый показатель"" указан текущий показатель';uk='У полі ""Базовий показник"" зазначений поточний показник'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "БазовыйПоказатель", "Объект", Отказ);
	КонецЕсли;	
	
	Если Предопределенный Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "ВидСтажа");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "БазовыйПоказатель");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "НазначениеПоказателя");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "ТипПоказателя");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СпособВводаЗначений");
	Иначе
		Если ТипПоказателя <> Перечисления.ТипыПоказателейРасчетаЗарплаты.ЧисловойЗависящийОтСтажа Или 
			ТипПоказателя <> Перечисления.ТипыПоказателейРасчетаЗарплаты.ПустаяСсылка() Тогда
			ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "ВидСтажа");
		КонецЕсли;
		Если ТипПоказателя <> Перечисления.ТипыПоказателейРасчетаЗарплаты.ЧисловойЗависящийОтДругогоПоказателя Тогда
			ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "БазовыйПоказатель");
		КонецЕсли;
		ПредопределенныеПоказатели = ЗарплатаКадрыРасширенныйПовтИсп.ИменаПредопределенныхПоказателей();
		Если ПредопределенныеПоказатели.Найти(Идентификатор) <> Неопределено Тогда 
			ТекстСообщения = НСтр("ru='Недопустимое значение идентификатора.';uk='Неприпустиме значення ідентифікатора.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "Объект.Идентификатор", , Отказ);
		КонецЕсли;	
	КонецЕсли;
		
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;		
	
	// Тарифной ставкой может быть только денежный показатель.
	Если Не ТипПоказателя = Перечисления.ТипыПоказателейРасчетаЗарплаты.Денежный Тогда 
		ВидТарифнойСтавки = Перечисления.ВидыТарифныхСтавок.ПустаяСсылка();
	КонецЕсли;
	
	ИдентификаторСлужебный = ВРег(Идентификатор);
	
	// Проверить изменились ли ОтображатьВДокументахНачисления и СпособВводаЗначений.
	СтарыеЗначения = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, "ОтображатьВДокументахНачисления,СпособВводаЗначений,Идентификатор");
	Если СтарыеЗначения.СпособВводаЗначений <> СпособВводаЗначений Или СтарыеЗначения.ОтображатьВДокументахНачисления <> ОтображатьВДокументахНачисления Тогда
		ЭтотОбъект.ДополнительныеСвойства.Вставить("ВыполнитьОбновлениеВидовРасчета", Истина);
		ЭтотОбъект.ДополнительныеСвойства.Вставить("ЗаполнитьИнформациюОПоказателях", Истина);
	КонецЕсли;
	
	// Проверка изменения идентификатора.
	Если ЗначениеЗаполнено(Ссылка) Тогда 
		ЭтотОбъект.ДополнительныеСвойства.Вставить("ПрежнийИдентификатор", СтарыеЗначения.Идентификатор);
	КонецЕсли;	
	
	// Проверка изменения шкалы оценки.
	Если ЗначениеЗаполнено(Ссылка) Тогда
		ПрежнийТипПоказателя = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "ТипПоказателя");
		Если ПрежнийТипПоказателя = Перечисления.ТипыПоказателейРасчетаЗарплаты.ЧисловойЗависящийОтДругогоПоказателя
			Или ТипПоказателя = Перечисления.ТипыПоказателейРасчетаЗарплаты.ЧисловойЗависящийОтДругогоПоказателя Тогда
			Если ПрежнийТипПоказателя = Перечисления.ТипыПоказателейРасчетаЗарплаты.ЧисловойЗависящийОтДругогоПоказателя Тогда 
				ПрежнийБазовыйПоказатель = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "БазовыйПоказатель");
				ПрежнийБазовыйПоказательИдентификатор = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПрежнийБазовыйПоказатель, "Идентификатор");
				ПрежнееПредставлениеШкалы = РасчетЗарплатыРасширенный.ТекстЗаменыИндентификатораПоказателяОцениваемогоПоШкале(Ссылка, ПрежнийБазовыйПоказательИдентификатор);
			Иначе 
				ПрежнееПредставлениеШкалы = "";
			КонецЕсли;	
			ЭтотОбъект.ДополнительныеСвойства.Вставить("ПрежнееПредставлениеШкалы", ПрежнееПредставлениеШкалы);
			ЭтотОбъект.ДополнительныеСвойства.Вставить("ПрежнийТипПоказателя", ПрежнийТипПоказателя);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ЗарплатаКадры.ОтключитьБизнесЛогикуПриЗаписи(ЭтотОбъект) Тогда
		Возврат;
	КонецЕсли;		
	
	Если НеИспользуется Или ПометкаУдаления Тогда 
		
		// Помеченные для удаления и неиспользуемые показатели удаляем из списка 
		// показателей, используемых для расчета совокупной тарифной ставки.
		Запрос = Новый Запрос("ВЫБРАТЬ
		                      |	ПоказателиСовокупнойТарифнойСтавкиСотрудников.Показатель
		                      |ИЗ
		                      |	РегистрСведений.ПоказателиСовокупнойТарифнойСтавкиСотрудников КАК ПоказателиСовокупнойТарифнойСтавкиСотрудников
		                      |ГДЕ
		                      |	ПоказателиСовокупнойТарифнойСтавкиСотрудников.Показатель = &Показатель");
							  
		Запрос.УстановитьПараметр("Показатель", Ссылка);
		РезультатЗапроса = Запрос.Выполнить();
		
		Если Не РезультатЗапроса.Пустой() Тогда 
			НаборЗаписей = РегистрыСведений.ПоказателиСовокупнойТарифнойСтавкиСотрудников.СоздатьНаборЗаписей();
			НаборЗаписей.Отбор.Показатель.Установить(Ссылка);
			НаборЗаписей.Записать();
		КонецЕсли;
		
	ИначеЕсли ВидТарифнойСтавки = Перечисления.ВидыТарифныхСтавок.МесячнаяТарифнаяСтавка
		Или ВидТарифнойСтавки = Перечисления.ВидыТарифныхСтавок.ДневнаяТарифнаяСтавка
		Или ВидТарифнойСтавки = Перечисления.ВидыТарифныхСтавок.ЧасоваяТарифнаяСтавка Тогда 
		
		// Тарифные ставки по умолчанию включаем в список показателей, используемых для расчета совокупной тарифной ставки.
		НаборЗаписей = РегистрыСведений.ПоказателиСовокупнойТарифнойСтавкиСотрудников.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Показатель.Установить(Ссылка);
		НаборЗаписей.Добавить().Показатель = Ссылка;
		НаборЗаписей.Записать();
		
	КонецЕсли;
		
	// Проверка изменения идентификатора.
	ПрежнийИдентификатор = Неопределено;
	Если ЭтотОбъект.ДополнительныеСвойства.Свойство("ПрежнийИдентификатор", ПрежнийИдентификатор) И Идентификатор <> ПрежнийИдентификатор Тогда 
		ЭтотОбъект.ДополнительныеСвойства.Вставить("ВыполнитьОбновлениеВидовРасчета", Истина);
		ЭтотОбъект.ДополнительныеСвойства.Вставить("ИдентификаторИзменен", Истина);
	КонецЕсли;	
	
	// Проверка изменения шкалы оценки.
	ПрежнееПредставлениеШкалы = Неопределено;
	Если ЭтотОбъект.ДополнительныеСвойства.Свойство("ПрежнееПредставлениеШкалы", ПрежнееПредставлениеШкалы) Тогда
		ПрежнийТипПоказателя = ЭтотОбъект.ДополнительныеСвойства.ПрежнийТипПоказателя;
		БазовыйПоказательИдентификатор = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(БазовыйПоказатель, "Идентификатор");
		ПредставлениеШкалы = РасчетЗарплатыРасширенный.ТекстЗаменыИндентификатораПоказателяОцениваемогоПоШкале(Ссылка, БазовыйПоказательИдентификатор);
		Если ПрежнийТипПоказателя <> ТипПоказателя Или ПрежнееПредставлениеШкалы <> ПредставлениеШкалы Тогда 
			ЭтотОбъект.ДополнительныеСвойства.Вставить("ВыполнитьОбновлениеВидовРасчета", Истина);
			ЭтотОбъект.ДополнительныеСвойства.Вставить("ШкалаОценкиИзменена", Истина);
		КонецЕсли;
	КонецЕсли;
	
	ВыполнитьОбновлениеВидовРасчета();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВыполнитьОбновлениеВидовРасчета()
	
	Если Не ДополнительныеСвойства.Свойство("ВыполнитьОбновлениеВидовРасчета") Тогда 
		Возврат;
	КонецЕсли;
	
	ЗаполнитьИнформациюОПоказателях = ЭтотОбъект.ДополнительныеСвойства.Свойство("ЗаполнитьИнформациюОПоказателях");
	ИдентификаторИзменен 			= ЭтотОбъект.ДополнительныеСвойства.Свойство("ИдентификаторИзменен");
	ШкалаОценкиИзменена 			= ЭтотОбъект.ДополнительныеСвойства.Свойство("ШкалаОценкиИзменена");
	
	ВидыРасчетаМассив = Новый Массив;
	
	// Обновить вторичные данные в тех видах расчета, которые зависят от показателя.
	Запрос = Новый Запрос(
	"ВЫБРАТЬ
	|	НачисленияПоказатели.Ссылка КАК ВидРасчета,
	|	НачисленияПоказатели.Ссылка.Наименование КАК Наименование,
	|	НачисленияПоказатели.Ссылка.ФормулаРасчета КАК ФормулаРасчета
	|ИЗ
	|	ПланВидовРасчета.Начисления.Показатели КАК НачисленияПоказатели
	|ГДЕ
	|	НачисленияПоказатели.Показатель = &Показатель
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	УдержанияПоказатели.Ссылка,
	|	УдержанияПоказатели.Ссылка.Наименование,
	|	УдержанияПоказатели.Ссылка.ФормулаРасчета
	|ИЗ
	|	ПланВидовРасчета.Удержания.Показатели КАК УдержанияПоказатели
	|ГДЕ
	|	УдержанияПоказатели.Показатель = &Показатель");
	
	Запрос.УстановитьПараметр("Показатель", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		ВидРасчета = Выборка.ВидРасчета.ПолучитьОбъект();
		
		Если ЗаполнитьИнформациюОПоказателях Тогда 
			РасчетЗарплатыРасширенный.ЗаполнитьИнформациюОПоказателяхВидаРасчета(ВидРасчета);
		КонецЕсли;
			
		Если ИдентификаторИзменен Тогда
			ПрежнийИдентификатор = ЭтотОбъект.ДополнительныеСвойства.ПрежнийИдентификатор;
			НоваяФормулаРасчета = РасчетЗарплатыРасширенный.ЗаменитьЗначениеИдентификатораВФормулеРасчета(Идентификатор, ПрежнийИдентификатор, Выборка.ФормулаРасчета);
			ВидРасчета.ФормулаРасчета = НоваяФормулаРасчета;
		КонецЕсли;
		
		Если ИдентификаторИзменен Или ШкалаОценкиИзменена Тогда 
			ЗарплатаКадрыРасширенный.ОбновитьПоказателиФормулыРасчета(ВидРасчета, Ложь);
		КонецЕсли;
		
		ВидыРасчетаМассив.Добавить(ВидРасчета);
		
	КонецЦикла;
	
	РасчетЗарплатыРасширенный.ЗаписатьПакетВидовРасчета(ВидыРасчетаМассив);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли