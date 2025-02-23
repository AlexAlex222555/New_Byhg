////////////////////////////////////////////////////////////////////////////////
// СотрудникиКлиентСервер: методы, обслуживающие работу формы сотрудника.
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Функция определяет пол физлица по его отчеству.
// Параметр:
// 		ОтчествоРаботника - отчество работника.
//
Функция ОпределитьПолПоОтчеству(ОтчествоРаботника) Экспорт
	
	Если Прав(ОтчествоРаботника, 2) = "ич" Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ПолФизическогоЛица.Мужской");
	ИначеЕсли Прав(ОтчествоРаботника, 2) = "на" Тогда
		Возврат ПредопределенноеЗначение("Перечисление.ПолФизическогоЛица.Женский");
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЗависимостиВидовАдресов() Экспорт
	
	ЗависимостиВидов = Новый Соответствие;
	
	МассивЗависимых = Новый Массив;
	МассивЗависимых.Добавить(ПредопределенноеЗначение("Справочник.ВидыКонтактнойИнформации.АдресДляИнформированияФизическиеЛица"));
	
	ЗависимостиВидов.Вставить(ПредопределенноеЗначение("Справочник.ВидыКонтактнойИнформации.АдресМестаПроживанияФизическиеЛица"),
		МассивЗависимых);
	
	МассивЗависимых.Добавить(ПредопределенноеЗначение("Справочник.ВидыКонтактнойИнформации.АдресМестаПроживанияФизическиеЛица"));
	
	ЗависимостиВидов.Вставить(ПредопределенноеЗначение("Справочник.ВидыКонтактнойИнформации.АдресПоПропискеФизическиеЛица"),
		МассивЗависимых);
		
	Возврат ЗависимостиВидов;
	
КонецФункции

Процедура УстановитьВидЗанятостиНовогоСотрудника(Форма) Экспорт
	Если НЕ ЗначениеЗаполнено(Форма.Сотрудник.Ссылка) 
		И НЕ Форма.ПолучитьФункциональнуюОпциюФормы("ИспользоватьКадровыйУчет") Тогда
		Форма.ТекущийВидЗанятости = СотрудникиВызовСервера.ПолучитьВидЗанятостиДляНовогоСотрудника(Форма.Сотрудник, Форма.ТекущаяОрганизация, Форма.ФизическоеЛицоСсылка);
	КонецЕсли;
КонецПроцедуры

Процедура УстановитьВидимостьПолейФИО(Форма) Экспорт
	ФИОВведено = НЕ ПустаяСтрока(Форма.ФИОФизическихЛиц.Фамилия)
		ИЛИ НЕ ПустаяСтрока(Форма.ФИОФизическихЛиц.Имя)
		ИЛИ НЕ ПустаяСтрока(Форма.ФИОФизическихЛиц.Отчество);
	Если ФИОВведено Тогда
		Форма.Элементы.ГруппаСтраницыПолноеИмя.ТекущаяСтраница = Форма.Элементы.ГруппаСтраницаПолноеИмя;
	Иначе
		Форма.Элементы.ГруппаСтраницыПолноеИмя.ТекущаяСтраница = Форма.Элементы.ГруппаСтраницаПолноеИмяСкрытое;
	КонецЕсли;
КонецПроцедуры

Процедура ОбновитьНаборЗаписейИсторииДокументыФизическихЛиц(Форма, ВедущийОбъект) Экспорт
	Перем ЗаписьНабора;
	
	Если Не Форма["ДокументыФизическихЛицНаборЗаписейПрочитан"] Тогда
		
		Форма.ПрочитатьНаборЗаписейПериодическихСведений("ДокументыФизическихЛиц", ВедущийОбъект);
		
	КонецЕсли;
	
	СтруктураЗаписиСтрокой = "";
	ПрежняяЗапись = Новый Структура;
	НужнаЗапятая = Ложь;
	Для Каждого КлючЗначение Из Форма["ДокументыФизическихЛицПрежняя"] Цикл
		Если НужнаЗапятая Тогда
			СтруктураЗаписиСтрокой = СтруктураЗаписиСтрокой + ",";
		КонецЕсли;
		СтруктураЗаписиСтрокой = СтруктураЗаписиСтрокой + КлючЗначение.Ключ;
		НужнаЗапятая = Истина;
		ПрежняяЗапись.Вставить(КлючЗначение.Ключ);
	КонецЦикла;
		
	Если ЗначениеЗаполнено(Форма["ДокументыФизическихЛиц"].Период) Тогда
		ПериодИзменен = Форма["ДокументыФизическихЛиц"].Период > Форма["ДокументыФизическихЛицПрежняя"].Период;
		РесурсыИзменены = Ложь;
		Для Каждого КлючЗначение Из Форма["ДокументыФизическихЛицПрежняя"] Цикл
			Если КлючЗначение.Ключ = "Период" Тогда
				Продолжить;
			КонецЕсли;
			Если КлючЗначение.Значение <> Форма["ДокументыФизическихЛиц"][КлючЗначение.Ключ] Тогда
				РесурсыИзменены = Истина;
				Прервать;
			КонецЕсли;
		КонецЦикла;
		НаборЗаписей = Форма["ДокументыФизическихЛицНаборЗаписей"];
		Если (ПериодИзменен И РесурсыИзменены) ИЛИ НаборЗаписей.Количество() = 0 Тогда
			ЗаписьНаНовуюДату = НаборЗаписей.НайтиСтроки(Новый Структура("Период,ВидДокумента", Форма["ДокументыФизическихЛиц"].Период, Форма["ДокументыФизическихЛиц"].ВидДокумента));
			Если ЗаписьНаНовуюДату.Количество() = 0 Тогда
				ЗаписьНабора = НаборЗаписей.Добавить();
			КонецЕсли;
		Иначе
			ЗаписьНаНовуюДату = НаборЗаписей.НайтиСтроки(Новый Структура("Период,ВидДокумента", Форма["ДокументыФизическихЛиц"].Период, Форма["ДокументыФизическихЛиц"].ВидДокумента));
			Если ЗаписьНаНовуюДату.Количество() > 0 Тогда
				ЗаписьНабора = ЗаписьНаНовуюДату[0];
			Иначе
				ЗаписьНабора = НаборЗаписей.Добавить();
			КонецЕсли; 
		КонецЕсли;
		
		Если ЗаписьНабора <> НеОпределено Тогда
			
			// Если в этом периоде уже есть документы являющиеся удостоверением личности - 
			// сбросим признак
			ЯвляющиесяУдостоверениямиЛичности = НаборЗаписей.НайтиСтроки(Новый Структура("Период,ЯвляетсяДокументомУдостоверяющимЛичность", Форма["ДокументыФизическихЛиц"].Период, Истина));
			Для каждого УдостоверениеЛичности Из ЯвляющиесяУдостоверениямиЛичности Цикл
				Если УдостоверениеЛичности.ВидДокумента <> ЗаписьНабора.ВидДокумента Тогда
					УдостоверениеЛичности.ЯвляетсяДокументомУдостоверяющимЛичность = Ложь;
				КонецЕсли; 
			КонецЦикла;
			
			ЗаполнитьЗначенияСвойств(ЗаписьНабора, Форма["ДокументыФизическихЛиц"]);
			НаборЗаписей.Сортировать("Период,ЯвляетсяДокументомУдостоверяющимЛичность");
			
			ЗаполнитьЗначенияСвойств(ПрежняяЗапись, Форма["ДокументыФизическихЛиц"]);
			Форма["ДокументыФизическихЛицПрежняя"] = Новый ФиксированнаяСтруктура(ПрежняяЗапись);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#Область ОбновлениеПредупреждающихНадписей

Процедура УстановитьИнфоНадпись(Форма, ДатаСеанса) Экспорт
	
	Если НЕ Форма.ПолучитьФункциональнуюОпциюФормы("ИспользоватьКадровыйУчет") Тогда
		Форма.ОформленПоТрудовомуДоговору = ЗначениеЗаполнено(Форма.ДатаПриема)
			И ЗначениеЗаполнено(Форма.ТекущаяОрганизация) И ЗначениеЗаполнено(Форма.ТекущийВидЗанятости);
	КонецЕсли; 
		
	СотрудникИнфо = "";	
	
	Если Форма.Сотрудник.ВАрхиве Тогда
		СотрудникИнфо = НСтр("ru='Все операции по сотруднику уже завершены. Сотрудник не отображается в списках';uk='Всі операції по співробітнику вже завершені. Співробітник не відображається у списках'");
	ИначеЕсли НЕ Форма.ОформленПоТрудовомуДоговору Тогда
		
		Если Форма.ДоступенПросмотрДанныхДляНачисленияЗарплаты Тогда
			ТекстИнфоНадписи = НСтр("ru='Сотрудник не принят на работу, зарплата по нему не начисляется.';uk='Співробітник не прийнятий на роботу, зарплата по ньому не нараховується.'");
		Иначе
			ТекстИнфоНадписи = НСтр("ru='Сотрудник не принят на работу.';uk='Співробітник не прийнятий на роботу.'");
		КонецЕсли;
		
		Если Форма.ПолучитьФункциональнуюОпциюФормы("ИспользоватьКадровыйУчет") Тогда
			ТекстИнфоНадписи = ТекстИнфоНадписи + " " + НСтр("ru='Необходимо оформить прием на работу';uk='Необхідно оформити прийом на роботу'");
		Иначе
			ТекстИнфоНадписи = ТекстИнфоНадписи + " " + НСтр("ru='Для приема на работу необходимо заполнить организацию и дату приема';uk='Для прийому на роботу необхідно заповнити організацію і дату прийому'");
		КонецЕсли;
		
		СотрудникИнфо = ТекстИнфоНадписи;
		
	ИначеЕсли ЗначениеЗаполнено(Форма.ДатаУвольнения) Тогда
		
		ПрошлоДнейСМоментаУвольнения = (ДатаСеанса - Форма.ДатаУвольнения) / 86400;
		Если ПрошлоДнейСМоментаУвольнения > 370 Тогда
			СотрудникИнфо = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru='Сотрудник давно уволен. Для того, чтобы сотрудник не отображался в списках можно установить флажок ""%2""';uk='Співробітник давно звільнений. Для того, щоб співробітник не відображався у списках можна встановити прапорець ""%2""'"),
				Формат(Форма.ДатаУвольнения, "ДФ='ММММ гггг'") + НСтр("ru=' г.';uk=' р.'"), Форма.Элементы.ВАрхиве.Заголовок);

		Иначе
				
			Если Форма.ДоступенПросмотрДанныхДляНачисленияЗарплаты Тогда
				
				СотрудникИнфо = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru='Сотрудник уволен. Месяц, после которого не начисляется зарплата: %1';uk='Співробітник звільнений. Місяць, після якого не нараховується зарплата: %1'"),
					Формат(Форма.ДатаУвольнения, "ДФ='ММММ гггг'") + НСтр("ru=' г.';uk=' р.'"));

					
			Иначе
				СотрудникИнфо = НСтр("ru='Сотрудник уволен.';uk='Співробітник звільнений.'");
			КонецЕсли;
				
		КонецЕсли;			
		
	ИначеЕсли Форма.ДоступенПросмотрДанныхДляНачисленияЗарплаты Тогда
		
		Если НЕ ЗначениеЗаполнено(Форма.ТекущаяТарифнаяСтавка) Тогда
			СотрудникИнфо = НСтр("ru='Сотрудник принят на работу, оклад сотрудника не задан. При начислении зарплаты сумма к начислению заполняется вручную';uk='Співробітник прийнятий на роботу, оклад співробітника не заданий. При нарахуванні зарплати сума до нарахування заповнюється вручну'");
		Иначе
			
			Если ЗначениеЗаполнено(Форма.ДатаПриема) Тогда
				
				СотрудникИнфо = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru='Сотрудник принят на работу. Месяц, с которого начисляется зарплата: %1';uk='Співробітник прийнятий на роботу. Місяць, з якого нараховується зарплата: %1'"),
						Формат(Форма.ДатаПриема, "ДФ='ММММ гггг'") + НСтр("ru=' г.';uk=' р.'"));
						
			Иначе
				СотрудникИнфо = НСтр("ru='Сотрудник принят на работу.';uk='Працівник прийнятий на роботу.'");		
			КонецЕсли;
					
		КонецЕсли;
		
	Иначе
		СотрудникИнфо = НСтр("ru='Сотрудник принят на работу.';uk='Працівник прийнятий на роботу.'");
	КонецЕсли;		
	
	ЗарплатаКадрыКлиентСервер.УстановитьРасширеннуюПодсказкуЭлементуФормы(
		Форма,
		"ДатыПриемаУвольнения",
		СотрудникИнфо);
	
КонецПроцедуры

Процедура УстановитьДоступностьУточненияНаименования(Форма) Экспорт
	Форма.Элементы.УточнениеНаименования.Доступность = Форма.ДополнятьПредставление; 
КонецПроцедуры

Процедура ОбновитьПолеГражданствоПериод(Форма, ДатаСеанса)
	
	// Не обязательно заполнение поля Период если данные по умолчанию и при этом 
	// записи о гражданстве еще нет.
	Если ЗарплатаКадрыКлиентСервер.ГражданствоПоУмолчанию(Форма.ГражданствоФизическихЛиц)
		И (Форма.ГражданствоФизическихЛицПрежняя.Период = ЗарплатаКадрыКлиентСервер.ДатаОтсчетаПериодическихСведений()
			ИЛИ Форма.ГражданствоФизическихЛицПрежняя.Период = '00010101') Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ГражданствоФизическихЛицПериод",
			"АвтоОтметкаНезаполненного",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ГражданствоФизическихЛицПериод",
			"ОтметкаНезаполненного",
			Ложь);
			
	Иначе
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ГражданствоФизическихЛицПериод",
			"АвтоОтметкаНезаполненного",
			Истина);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ГражданствоФизическихЛиц",
			"ОтметкаНезаполненного",
			НЕ ЗначениеЗаполнено(Форма.ГражданствоФизическихЛиц.Период));
		
		Если НЕ ЗарплатаКадрыКлиентСервер.ГражданствоПоУмолчанию(Форма.ГражданствоФизическихЛиц) 
			И Форма.ГражданствоФизическихЛиц.Период = ЗарплатаКадрыКлиентСервер.ДатаОтсчетаПериодическихСведений() Тогда
			
			Форма.ГражданствоФизическихЛиц.Период = НачалоДня(ДатаСеанса);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если Форма.ГражданствоФизическихЛиц.Период = ЗарплатаКадрыКлиентСервер.ДатаОтсчетаПериодическихСведений() Тогда
		Форма.ГражданствоФизическихЛицПериод = '00010101';
	Иначе
		Форма.ГражданствоФизическихЛицПериод = Форма.ГражданствоФизическихЛиц.Период;
	КонецЕсли;

КонецПроцедуры

Процедура ОбновитьДоступностьПолейВводаГражданства(Форма, ДатаСеанса) Экспорт
	
	Форма.Элементы.ГражданствоФизическихЛицСтрана.Доступность = (Форма.ГражданствоФизическихЛицЛицоБезГражданства = 0);
	
	ОбновитьПолеГражданствоПериод(Форма, ДатаСеанса);
	
КонецПроцедуры

Процедура ОбновитьПолеУдостоверениеЛичностиПериод(Форма) Экспорт
	
	Если Форма.ДоступенПросмотрДанныхФизическихЛиц Тогда
		
		ЭтоЗначенияПоУмолчанию = Ложь;
		// Не обязательно заполнение поля Период если данные по умолчанию и при этом 
		// записи о сведениях об инвалидности еще нет.
		Если ЗарплатаКадрыКлиентСервер.УдостоверениеЛичностиПоУмолчанию(Форма.ДокументыФизическихЛиц)
			И НЕ ЗначениеЗаполнено(Форма.ДокументыФизическихЛицПрежняя.Период) Тогда
			
			ЭтоЗначенияПоУмолчанию = Истина;
			Форма.ДокументыФизическихЛиц.Период = '00010101';
			
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				"ДокументыФизическихЛицВидДокумента",
				"АвтоОтметкаНезаполненного",
				Ложь);

			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				"ДокументыФизическихЛицВидДокумента",
				"ОтметкаНезаполненного",
				Ложь);
			
		Иначе
			
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				"ДокументыФизическихЛицВидДокумента",
				"АвтоОтметкаНезаполненного",
				Истина);
				
			Если ЗначениеЗаполнено(Форма.ДокументыФизическихЛиц.ВидДокумента) Тогда
				ВидДокументаОтметкаНезаполненного = Ложь;
			Иначе
				ВидДокументаОтметкаНезаполненного = Истина;
			КонецЕсли;
			
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				"ДокументыФизическихЛицВидДокумента",
				"ОтметкаНезаполненного",
				ВидДокументаОтметкаНезаполненного);
				
			Если НЕ ЗначениеЗаполнено(Форма.ДокументыФизическихЛиц.Период) И ЗначениеЗаполнено(Форма.ДокументыФизическихЛиц.ДатаВыдачи) Тогда
				Форма.ДокументыФизическихЛиц.Период = Форма.ДокументыФизическихЛиц.ДатаВыдачи;
			КонецЕсли;
			
			Форма.ДокументыФизическихЛиц.ЯвляетсяДокументомУдостоверяющимЛичность = Истина;
			
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Форма.ДокументыФизическихЛиц.ДатаВыдачи) И НЕ ЗначениеЗаполнено(Форма.ДокументыФизическихЛицПрежняя.Период) Тогда
			ТолькоПросмотрПоЛяПериод = Истина;
		Иначе
			ТолькоПросмотрПоЛяПериод = Ложь;
		КонецЕсли;
		
		Если НЕ ЭтоЗначенияПоУмолчанию
			И НЕ ЗначениеЗаполнено(Форма.ДокументыФизическихЛицПрежняя.Период) Тогда
			
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				"ДокументыФизическихЛицДатаВыдачи",
				"АвтоОтметкаНезаполненного",
				Истина);
				
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				"ДокументыФизическихЛицДатаВыдачи",
				"ОтметкаНезаполненного",
				НЕ ЗначениеЗаполнено(Форма.ДокументыФизическихЛиц.ДатаВыдачи));

		КонецЕсли; 
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			"ДокументыФизическихЛицПериод",
			"ТолькоПросмотр",
			ТолькоПросмотрПоЛяПериод);
		
		РедактированиеПериодическихСведенийКлиентСервер.ОбновитьОтображениеПолейВвода(Форма, "ДокументыФизическихЛиц", Форма.ФизическоеЛицоСсылка);
		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

#Область ПроцедурыИФункцииДляПолейСодержащихКодДРФО

// Осуществляет проверку заполненного элемента содержащему код ДРФО.
Процедура ОбработатьОтображениеПоляКодПоДРФО(КодПоДРФО, Элемент, Форма) Экспорт	
	
	СообщенияПроверки = "";
	Форма.КодПоДРФОУказанПравильно = Ложь;
	
	Если НЕ ПустаяСтрока(КодПоДРФО) Тогда	
	
		Форма.КодПоДРФОУказанПравильно = РегламентированныеДанныеКлиентСервер.КодПоЕДРПОУСоответствуетТребованиям(КодПоДРФО, Ложь, СообщенияПроверки);
		Если Форма.КодПоДРФОУказанПравильно Тогда	
			ЭлементЦветТекста = Форма.ЦветСтиляЦветТекстаПоля;
		Иначе
			ЭлементЦветТекста = Форма.ЦветСтиляПоясняющийОшибкуТекст;
		КонецЕсли;
		
	Иначе
		
		СообщенияПроверки = НСтр("ru='Не указан код по ДРФО';uk='Не зазначений код за ДРФО'");
		ЭлементЦветТекста = Форма.ЦветСтиляЦветТекстаПоля;
			
	КонецЕсли;
	
	ЗарплатаКадрыКлиентСервер.УстановитьРасширеннуюПодсказкуЭлементуФормы(
		Форма,
		Элемент.Имя,
		СообщенияПроверки);
		
	Элемент.ЦветТекста = ЭлементЦветТекста;
	 
КонецПроцедуры


Процедура ОбработатьОтображениеСерияДокументаФизическогоЛица(ВидДокумента, Серия ,Элемент, Форма) Экспорт
	
	СообщенияПроверки = "";
	ТипСерии = ДокументыФизическихЛицКлиентСервер.ТипСерииДокументаУдостоверяющегоЛичность(ВидДокумента);
	Если ЗначениеЗаполнено(ВидДокумента) И ТипСерии > 0 Тогда
		Если НЕ ПустаяСтрока(Серия) Тогда
			СерияУказанаПравильно = ДокументыФизическихЛицКлиентСервер.СерияДокументаУказанаПравильно(ВидДокумента, Серия, СообщенияПроверки);
			Если СерияУказанаПравильно Тогда
				ЭлементЦветТекста = Форма.ЦветСтиляЦветТекстаПоля;
			Иначе
				ЭлементЦветТекста = Форма.ЦветСтиляПоясняющийОшибкуТекст;
			КонецЕсли;
		Иначе
			СообщенияПроверки = НСтр("ru='Не указана серия документа';uk='Не вказана серія документа'");
			ЭлементЦветТекста = Форма.ЦветСтиляЦветТекстаПоля;
		КонецЕсли;
	Иначе
		ЭлементЦветТекста = Форма.ЦветСтиляЦветТекстаПоля;
	КонецЕсли;
	
	ЗарплатаКадрыКлиентСервер.УстановитьРасширеннуюПодсказкуЭлементуФормы(
		Форма,
		Элемент.Имя,
		СообщенияПроверки);
		
	Элемент.ЦветТекста = ЭлементЦветТекста;
	
КонецПроцедуры

Процедура ОбработатьОтображениеНомерДокументаФизическогоЛица(ВидДокумента, Номер ,Элемент, Форма) Экспорт
	
	СообщенияПроверки = "";
	ТипНомера = ДокументыФизическихЛицКлиентСервер.ТипНомераДокументаУдостоверяющегоЛичность(ВидДокумента);
	Если ЗначениеЗаполнено(ВидДокумента) И ТипНомера > 0 Тогда
		Если НЕ ПустаяСтрока(Номер) Тогда
			СерияУказанаПравильно = ДокументыФизическихЛицКлиентСервер.НомерДокументаУказанПравильно(ВидДокумента, Номер, СообщенияПроверки);
			Если СерияУказанаПравильно Тогда
				ЭлементЦветТекста = Форма.ЦветСтиляЦветТекстаПоля;
			Иначе
				ЭлементЦветТекста = Форма.ЦветСтиляПоясняющийОшибкуТекст;
			КонецЕсли;
		Иначе
			СообщенияПроверки = НСтр("ru='Не указан номер документа';uk='Не вказано номер документа'");
			ЭлементЦветТекста = Форма.ЦветСтиляЦветТекстаПоля;
		КонецЕсли;
	Иначе
		ЭлементЦветТекста = Форма.ЦветСтиляЦветТекстаПоля;
	КонецЕсли;
	
	ЗарплатаКадрыКлиентСервер.УстановитьРасширеннуюПодсказкуЭлементуФормы(
		Форма,
		Элемент.Имя,
		СообщенияПроверки);
		
	Элемент.ЦветТекста = ЭлементЦветТекста;
	
КонецПроцедуры

Процедура УстановитьПодсказкуКДатеРождения(Форма) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСДополнительнымиФормами

Функция ОбщееОписаниеДополнительнойФормы(ИмяОткрываемойФормы) Экспорт
	
	ОписаниеФормы = Новый Структура;
	
	ОписаниеФормы.Вставить("ИмяФормы", ИмяОткрываемойФормы);
	ОписаниеФормы.Вставить("КлючевыеРеквизиты", Новый Структура);
	ОписаниеФормы.Вставить("РеквизитыОбъекта", Новый Структура);
	ОписаниеФормы.Вставить("ДополнительныеДанные", Новый Структура);
	ОписаниеФормы.Вставить("АдресВХранилище", "");
	
	Возврат ОписаниеФормы;
	
КонецФункции

// Частный случай формы сотрудников.
Функция ОписаниеДополнительнойФормы(ИмяОткрываемойФормы) Экспорт
	
	Возврат СотрудникиКлиентСерверВнутренний.ОписаниеДополнительнойФормы(ИмяОткрываемойФормы);
	
КонецФункции

#КонецОбласти

Функция ПредставлениеСотрудникаПоДаннымФормыСотрудника(Форма) Экспорт
	
	Возврат СотрудникиКлиентСерверВнутренний.ПредставлениеСотрудникаПоДаннымФормыСотрудника(Форма);
	
КонецФункции

#КонецОбласти
