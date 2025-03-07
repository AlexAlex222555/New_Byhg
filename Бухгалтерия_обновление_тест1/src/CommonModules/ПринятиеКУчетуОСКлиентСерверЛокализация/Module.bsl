////////////////////////////////////////////////////////////////////////////////
// Процедуры, используемые для локализации документа "Принятие к учету ОС".
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

Процедура ДополнитьВспомогательныеРеквизиты(Форма, ВспомогательныеРеквизиты) Экспорт

	//++ Локализация
	ВспомогательныеРеквизиты.Вставить("ПлательщикНалогаНаПрибыль", Форма.СлужебныеПараметрыФормы.ПлательщикНалогаНаПрибыль);
	ВспомогательныеРеквизиты.Вставить("ВариантПримененияЦелевогоФинансирования", Форма.Объект.ВариантПримененияЦелевогоФинансирования);
	//-- Локализация
	
КонецПроцедуры

Процедура ДополнитьПараметрыПринятияКУчетуОС(Объект, ВспомогательныеРеквизиты, ПараметрыПринятияКУчетуОС) Экспорт

	//++ Локализация
	
	ДоступныПараметрыАмортизацииБУ = 
		ВспомогательныеРеквизиты.ОтражатьВРеглУчете
		И ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА;
									
	//
	ДоступныПараметрыАмортизацииНУ =
		ВспомогательныеРеквизиты.ОтражатьВРеглУчете
		И ВспомогательныеРеквизиты.ПлательщикНалогаНаПрибыль
		И ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА;
									
	//								
	АмортизацияБУДоступна = 
		ВспомогательныеРеквизиты.ОтражатьВРеглУчете
		И ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА;
							
	//								
	ДоступноОтражениеРасходовБУ = 
		ВспомогательныеРеквизиты.ОтражатьВРеглУчете
		И ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА;
			
	ДоступноОтражениеРасходовНУ = 
		ВспомогательныеРеквизиты.ОтражатьВРеглУчете
		И ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА
		И ВспомогательныеРеквизиты.ПлательщикНалогаНаПрибыль;
		
	//
	СтатьяРасходовУУОбязательна = 
		ВспомогательныеРеквизиты.ОтражатьВУпрУчете 
		И НЕ ДоступноОтражениеРасходовБУ 
		И НЕ ДоступноОтражениеРасходовНУ;
		
	СтатьяРасходовНУОбязательна = 
		ВспомогательныеРеквизиты.ОтражатьВРеглУчете 
		И ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА
		И НЕ ДоступноОтражениеРасходовБУ;
		
		
	//
	ПоНаработке = 
		ПараметрыПринятияКУчетуОС.ПоНаработке 
		ИЛИ Объект.МетодНачисленияАмортизацииБУ = ПредопределенноеЗначение("Перечисление.СпособыНачисленияАмортизацииОС.ПропорциональноОбъемуПродукции");
	ПоНаработкеНУ = Объект.МетодНачисленияАмортизацииНУ = ПредопределенноеЗначение("Перечисление.СпособыНачисленияАмортизацииОС.ПропорциональноОбъемуПродукции");
	//
	НаправлениеДеятельностиОбязательно =
		(НЕ ВспомогательныеРеквизиты.Свойство("ХозяйственнаяОперация")
		ИЛИ ВспомогательныеРеквизиты.ХозяйственнаяОперация <> ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ВводОстатковОсновныхСредств"))
		И ВспомогательныеРеквизиты.Свойство("ВариантПримененияЦелевогоФинансирования")
		И ЗначениеЗаполнено(ВспомогательныеРеквизиты.ВариантПримененияЦелевогоФинансирования)
		И ВспомогательныеРеквизиты.ВариантПримененияЦелевогоФинансирования <> ПредопределенноеЗначение("Перечисление.ВариантыПримененияЦелевогоФинансирования.НеИспользуется");
					
	//
	ПараметрыПринятияКУчетуОС.Вставить("ДоступныПараметрыАмортизацииБУ", ДоступныПараметрыАмортизацииБУ);
	ПараметрыПринятияКУчетуОС.Вставить("ДоступныПараметрыАмортизацииНУ", ДоступныПараметрыАмортизацииНУ);
	ПараметрыПринятияКУчетуОС.Вставить("ДоступноОтражениеРасходовБУ",    ДоступноОтражениеРасходовБУ);
	ПараметрыПринятияКУчетуОС.Вставить("ДоступноОтражениеРасходовНУ",    ДоступноОтражениеРасходовНУ);
	ПараметрыПринятияКУчетуОС.Вставить("АмортизацияБУДоступна",          АмортизацияБУДоступна);
	ПараметрыПринятияКУчетуОС.Вставить("СтатьяРасходовУУОбязательна",    СтатьяРасходовУУОбязательна);
	ПараметрыПринятияКУчетуОС.Вставить("СтатьяРасходовНУОбязательна",    СтатьяРасходовНУОбязательна);
	ПараметрыПринятияКУчетуОС.Вставить("ПоНаработке",                    ПоНаработке);
	ПараметрыПринятияКУчетуОС.Вставить("ПоНаработкеНУ",                  ПоНаработкеНУ);
	ПараметрыПринятияКУчетуОС.Вставить("НаправлениеДеятельностиОбязательно", НаправлениеДеятельностиОбязательно);

	//-- Локализация
	
КонецПроцедуры

Процедура НастроитьЗависимыеЭлементыФормы(Форма, ВспомогательныеРеквизиты, СтруктураИзмененныхРеквизитов, ПараметрыРеквизитовОбъекта) Экспорт

	//++ Локализация

	ОбновитьВсе = СтруктураИзмененныхРеквизитов.Количество() = 0;

	Объект = Форма.Объект;
	Элементы = Форма.Элементы;

	ПараметрыПринятияКУчетуОС = ВнеоборотныеАктивыКлиентСервер.ПараметрыПринятияКУчетуОС(Объект, ВспомогательныеРеквизиты);

	ДоступныНастройкиРеглУчета = (Объект.ОтражатьВРеглУчете И ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА);

	#Область СтраницаОсновное

	Если СтруктураИзмененныхРеквизитов.Свойство("ХозяйственнаяОперация")
		ИЛИ ОбновитьВсе Тогда
		
		Если Объект.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ПринятиеКУчетуОСпоИнвентаризации") Тогда
			
			Элементы.ДокументОснование.Заголовок = НСтр("ru='Инвентаризация';uk='Інвентаризація'");
			Элементы.ДокументОснование.ОграничениеТипа = Новый ОписаниеТипов("ДокументСсылка.ИнвентаризацияОС");
			
		КонецЕсли; 
		
		
	КонецЕсли; 

	
	#КонецОбласти
	
	#Область СтраницаОС

	Если СтруктураИзмененныхРеквизитов.Свойство("ХозяйственнаяОперация")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВУпрУчете")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВРеглУчете")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("Организация")
		ИЛИ ОбновитьВсе Тогда
		
		Форма.РасширеннаяСтоимостьРегл = 
				Объект.ОтражатьВРеглУчете
					И ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА
					И (Объект.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ПринятиеКУчетуОСпоИнвентаризации") 
						ИЛИ НЕ ВспомогательныеРеквизиты.ЕстьУчетСебестоимости)
					И Форма.СлужебныеПараметрыФормы.ПлательщикНалогаНаПрибыль;
					
					
					
		Если НЕ ВспомогательныеРеквизиты.ВедетсяРегламентированныйУчетВНА Тогда
			
			Элементы.ОССтоимостьБУ_Отдельно.Видимость = Истина;
			Элементы.ОССтоимостьУУ_Отдельно.Видимость = НЕ ВспомогательныеРеквизиты.ВалютыСовпадают;
		
			Элементы.ОССтоимостьУУ.Видимость = Ложь;
			Элементы.ОССтоимостьБУ.Видимость = Ложь;
			Элементы.ОССтоимостьБУ_Расширенная.Видимость = Ложь;
			Элементы.ОСГруппаРасширеннаяСтоимостьРегл.Видимость = Ложь;
			
		ИначеЕсли Форма.РасширеннаяСтоимостьРегл Тогда
			
			Элементы.ОССтоимостьБУ_Расширенная.Видимость = Истина;
			Элементы.ОССтоимостьУУ_Отдельно.Видимость = Объект.ОтражатьВУпрУчете;
			
			Элементы.ОССтоимостьБУ_Отдельно.Видимость = Ложь;
			Элементы.ОССтоимостьУУ.Видимость = Ложь;
			Элементы.ОССтоимостьБУ.Видимость = Ложь;
			Элементы.ОСГруппаРасширеннаяСтоимостьРегл.Видимость = Истина;
			
		ИначеЕсли Объект.ОтражатьВРеглУчете И Объект.ОтражатьВУпрУчете Тогда	
			
			Элементы.ОССтоимостьУУ.Видимость = Истина;
			Элементы.ОССтоимостьБУ.Видимость = Истина;
		
			Элементы.ОССтоимостьБУ_Отдельно.Видимость = Ложь;
			Элементы.ОССтоимостьУУ_Отдельно.Видимость = Ложь;
			Элементы.ОССтоимостьБУ_Расширенная.Видимость = Ложь;
			Элементы.ОСГруппаРасширеннаяСтоимостьРегл.Видимость = Ложь;
			
		Иначе
			
			Элементы.ОССтоимостьБУ_Отдельно.Видимость = Объект.ОтражатьВРеглУчете;
			Элементы.ОССтоимостьУУ_Отдельно.Видимость = Объект.ОтражатьВУпрУчете;
			
			Элементы.ОССтоимостьУУ.Видимость = Ложь;
			Элементы.ОССтоимостьБУ.Видимость = Ложь;
			Элементы.ОССтоимостьБУ_Расширенная.Видимость = Ложь;
			Элементы.ОСГруппаРасширеннаяСтоимостьРегл.Видимость = Ложь;
			
		КонецЕсли;
		
	КонецЕсли;

	Если СтруктураИзмененныхРеквизитов.Свойство("Дата")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("Организация")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ХозяйственнаяОперация") Тогда
		
		Если Форма.СлужебныеПараметрыФормы.ПлательщикНалогаНаПрибыль
			И Объект.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ПринятиеКУчетуОСпоИнвентаризации") Тогда
				
			Для Каждого ДанныеСтроки Из Объект.ОС Цикл
				Если ДанныеСтроки.СтоимостьНУ = 0 Тогда
					ДанныеСтроки.СтоимостьНУ = ДанныеСтроки.СтоимостьБУ;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		
	КонецЕсли;

	#КонецОбласти

	#Область СтраницаУчет


	Если СтруктураИзмененныхРеквизитов.Свойство("СрокИспользованияБУ")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВРеглУчете")
		ИЛИ ОбновитьВсе Тогда
		
		Форма.СрокИспользованияБУРасшифровка = ВнеоборотныеАктивыКлиентСервер.РасшифровкаСрокаПолезногоИспользования(
			Объект.СрокИспользованияБУ);
			
	КонецЕсли;

	Если СтруктураИзмененныхРеквизитов.Свойство("СрокИспользованияНУ")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВРеглУчете")
		ИЛИ ОбновитьВсе Тогда
		
		Форма.СрокИспользованияНУРасшифровка = ВнеоборотныеАктивыКлиентСервер.РасшифровкаСрокаПолезногоИспользования(
			Объект.СрокИспользованияНУ);
			
	КонецЕсли;

	Если СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВРеглУчете")
		ИЛИ ОбновитьВсе Тогда
		Элементы.ГруппаУчетУУ.ОтображатьЗаголовок = ДоступныНастройкиРеглУчета;
		Элементы.ГруппаУчетОбщее.ОтображатьЗаголовок = ДоступныНастройкиРеглУчета;
	КонецЕсли;

	
	#КонецОбласти

	#Область СтраницаОтражениеРасходов

	Если СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВРеглУчете")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВУпрУчете")
		ИЛИ ОбновитьВсе Тогда
		
			Элементы.ГруппаОтражениеРасходовПоАмортизацииУпр.Заголовок = 
				?(ДоступныНастройкиРеглУчета, НСтр("ru='Амортизация (управленческий учет)';uk='Амортизація (управлінський облік)'"), НСтр("ru='Амортизация';uk='Амортизація'"));

	КонецЕсли;
	
	Если СтруктураИзмененныхРеквизитов.Свойство("ХозяйственнаяОперация") 
		ИЛИ ОбновитьВсе Тогда
			
		ДокументНаОснованииИнвентаризации =
			(Объект.ХозяйственнаяОперация = ПредопределенноеЗначение("Перечисление.ХозяйственныеОперации.ПринятиеКУчетуОСпоИнвентаризации"));
				
		Элементы.СтраницаОтражениеРасходов.Заголовок = ?(
			ДокументНаОснованииИнвентаризации,
			НСтр("ru='Отражение доходов и расходов';uk='Відображення доходів і витрат'"),
			НСтр("ru='Отражение расходов';uk='Відображення витрат'"));
		
	КонецЕсли;

	Если СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВРеглУчете") 
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВУпрУчете") 
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("СтатьяРасходовУУ")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("СтатьяРасходовБУ")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("Организация")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("Дата")
		ИЛИ ОбновитьВсе Тогда
		
		Если ПараметрыПринятияКУчетуОС.СтатьяРасходовУУОбязательна 
			ИЛИ ЗначениеЗаполнено(Объект.СтатьяРасходовУУ) Тогда
			
			Элементы.СтатьяРасходовУУ.ПодсказкаВвода = "";
			Элементы.АналитикаРасходовУУ.ПодсказкаВвода = "";
			
		ИначеЕсли НЕ ПараметрыПринятияКУчетуОС.СтатьяРасходовУУОбязательна Тогда
			Если ПараметрыПринятияКУчетуОС.ДоступноОтражениеРасходовБУ Тогда
				ПодсказкаВводаСтатьи = НСтр("ru='совпадает с бухгалтерским учетом';uk='збігається з бухгалтерським обліком'");
			Иначе
				ПодсказкаВводаСтатьи = НСтр("ru='совпадает с налоговым учетом';uk='збігається з податковим обліком'");
			КонецЕсли;
			
			Элементы.СтатьяРасходовУУ.ПодсказкаВвода = ПодсказкаВводаСтатьи;
			Элементы.АналитикаРасходовУУ.ПодсказкаВвода = ПодсказкаВводаСтатьи;
		КонецЕсли; 
		
	КонецЕсли;

	Если СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВРеглУчете") 
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("СтатьяРасходовНУ")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("Организация")
		ИЛИ ОбновитьВсе Тогда
		
		Если ПараметрыПринятияКУчетуОС.СтатьяРасходовНУОбязательна 
			ИЛИ ЗначениеЗаполнено(Объект.СтатьяРасходовНУ) Тогда
			
			Элементы.СтатьяРасходовНУ.ПодсказкаВвода = "";
			Элементы.АналитикаРасходовНУ.ПодсказкаВвода = "";
			
		Иначе
			ПодсказкаВводаСтатьи = НСтр("ru='совпадает с бухгалтерским учетом';uk='збігається з бухгалтерським обліком'");
			Элементы.СтатьяРасходовНУ.ПодсказкаВвода = ПодсказкаВводаСтатьи;
			Элементы.АналитикаРасходовНУ.ПодсказкаВвода = ПодсказкаВводаСтатьи;
		КонецЕсли; 
		
	КонецЕсли;


	Если ОбновитьВсе Тогда
		Элементы.ГруппаОтражениеРасходовПоАмортизацииНУ.Заголовок = НСтр("ru='Амортизация (налоговый учет)';uk='Амортизація (податковий облік)'");
		Элементы.ГруппаОтражениеРасходовПоАмортизацииНУ.Подсказка = НСтр("ru='Статья расходов, по которой отражаются амортизационные расходы';uk='Стаття витрат, по якій відображаються амортизаційні витрати'");
	КонецЕсли;

	Если СтруктураИзмененныхРеквизитов.Свойство("Организация")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ОтражатьВРеглУчете")
		ИЛИ СтруктураИзмененныхРеквизитов.Свойство("ХозяйственнаяОперация")
		ИЛИ ОбновитьВсе Тогда
		
		Элементы.ГруппаОтражениеРасходовПоАмортизацииУпр.ОтображатьЗаголовок = 
			Элементы.СтатьяРасходовБУ.Видимость
			ИЛИ Элементы.СтатьяРасходовНУ.Видимость
			ИЛИ Элементы.СтатьяДоходовПоИнвентаризации.Видимость
			ИЛИ Объект.ОтражатьВРеглУчете;
	КонецЕсли;
	
	
	#КонецОбласти

	//-- Локализация
	
КонецПроцедуры

Процедура ПриИзмененииРеквизитов(Объект, ВспомогательныеРеквизиты, СписокРеквизитов) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

Функция ПрименяетсяФактическаяСтоимость(Объект) Экспорт

	Результат = Ложь;
	
	//++ Локализация
	//-- Локализация

	Возврат Результат;
	
КонецФункции
 
#КонецОбласти
