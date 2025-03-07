
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = БюджетнаяОтчетностьКлиентСервер.ПараметрыОткрытияФормыНастройкиПериода(Параметры);
	ЗаполнитьЗначенияСвойств(ЭтаФорма, ПараметрыФормы);
	
	Если Не Параметры.Свойство("НефинансовыйПоказатель") Тогда
	
		УстановитьВидимостьНастройкиГруппировки(Параметры);
		
		СписокВыбора = Элементы.ГраницыДанных.СписокВыбора;
		Если Параметры.ВариантРасположенияГраницыФактическихДанных = Перечисления.ВариантыРасположенияГраницыФактическиДанных.ДоНачалаСоставленияБюджета Тогда
			СписокВыбора.Удалить(СписокВыбора.НайтиПоЗначению("НачалоФакт"));
		ИначеЕсли Параметры.ВариантРасположенияГраницыФактическихДанных = Перечисления.ВариантыРасположенияГраницыФактическиДанных.ВнутриПериодаБюджета Тогда
			СписокВыбора.Удалить(СписокВыбора.НайтиПоЗначению("ФактНачало"));
		КонецЕсли;
		
	Иначе
		
		Элементы.ГруппаДеталиГраницДанных.Видимость = Ложь;
		Элементы.ГраницыДанных.Видимость = Ложь;
		Элементы.ПериодЗначения.Видимость = Ложь;
		
	КонецЕсли;
	
	УстановитьВариантыПериодов();
	УправлениеФормой();
	
	ВариантОкна = "БезГруппировки";
	Если Не Элементы.ГраницыДанных.Видимость Тогда
		ВариантОкна = "НефинансовыйПоказатель";
	ИначеЕсли Элементы.ПериодЗначения.Видимость Тогда
		ВариантОкна = "ГруппировкаПериод";
	КонецЕсли;
	
	ЭтаФорма.КлючСохраненияПоложенияОкна = "ВариантФормы_" + ВариантОкна;
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	Ошибки = Неопределено;
	
	НепроверяемыеРеквизиты = Новый Массив;
	ЕстьОшибкаВНачале = Ложь; ЕстьОшибкаВКонце = Ложь;
	
	Если Элементы.ГраницыДанных.Видимость Тогда
		УпорядоченныеПериодичности = Новый Массив;
		УпорядоченныеПериодичности.Добавить("СЕКУНДА");
		УпорядоченныеПериодичности.Добавить("МИНУТА");
		УпорядоченныеПериодичности.Добавить("ЧАС");
		Для Каждого ИмяЗапрещеннойПериодичности Из УпорядоченныеПериодичности Цикл
			Если Не ЕстьОшибкаВНачале И СтрНайти(ВРЕГ(НижняяГраницаДанных), ВРЕГ(ИмяЗапрещеннойПериодичности)) Тогда
				ТекстОшибки = НСтр("ru='Выражение границ начала периода не может содержать периодичность меньшую, чем день';uk='Вираз меж початку періоду не може містити меншу періодичність, ніж день'");
				ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "НижняяГраницаДанных", ТекстОшибки, "");
				ЕстьОшибкаВНачале = Истина;
			КонецЕсли;
			Если Не ЕстьОшибкаВКонце И СтрНайти(ВРЕГ(ВерхняяГраницаДанных), ВРЕГ(ИмяЗапрещеннойПериодичности)) Тогда
				ТекстОшибки = НСтр("ru='Выражение границ конца периода не может содержать периодичность меньшую, чем день';uk='Вираз меж кінця періоду не може містити меншу періодичність, ніж день'");
				ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "ВерхняяГраницаДанных", ТекстОшибки, "");
				ЕстьОшибкаВКонце = Истина;
			КонецЕсли;
			Если ЕстьОшибкаВНачале И ЕстьОшибкаВКонце Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла;
	Иначе
		НепроверяемыеРеквизиты.Добавить("НижняяГраницаДанных");
		НепроверяемыеРеквизиты.Добавить("ВерхняяГраницаДанных");
	КонецЕсли;
	
	ЕстьОшибкаВНачале = Ложь; ЕстьОшибкаВКонце = Ложь;
	
	Если ЗначениеЗаполнено(ПериодичностьГруппировки)
		И Элементы.ПериодЗначения.Видимость Тогда
		УпорядоченныеПериодичности = БюджетнаяОтчетностьКлиентСервер.УпорядоченныеПериодичности();
		УпорядоченныеПериодичности.Вставить(0, "СЕКУНДА");
		УпорядоченныеПериодичности.Вставить(0, "МИНУТА");
		УпорядоченныеПериодичности.Вставить(0, "ЧАС");
		Для Каждого Периодичность Из УпорядоченныеПериодичности Цикл
			Если Не ЗначениеЗаполнено(Периодичность) Тогда
				Продолжить;
			КонецЕсли;
			Если Периодичность = ПериодичностьГруппировки Тогда
				Прервать;
			КонецЕсли;
			Если ТипЗнч(Периодичность) = Тип("Строка") Тогда
				ИмяЗапрещеннойПериодичности = Периодичность;
			Иначе
				ИмяЗапрещеннойПериодичности = ФинансоваяОтчетностьКлиентСерверПовтИсп.ПериодичностьСтрокой(Периодичность);
			КонецЕсли;
			Если Не ЕстьОшибкаВНачале И СтрНайти(ВРЕГ(НачалоПериодаГруппировки), ВРЕГ(ИмяЗапрещеннойПериодичности)) Тогда
				ТекстОшибки = НСтр("ru='Выражение смещения начала периода группировки не может содержать периодичность меньшую, чем %1';uk='Вираз зміщення початку періоду групування не може містити меншу періодичність, ніж %1'");
				ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстОшибки, ПериодичностьГруппировки);
				ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "НачалоПериодаГруппировки", ТекстОшибки, "");
				ЕстьОшибкаВНачале = Истина;
			КонецЕсли;
			Если Не ЕстьОшибкаВКонце И СтрНайти(ВРЕГ(КонецПериодаГруппировки), ВРЕГ(ИмяЗапрещеннойПериодичности)) Тогда
				ТекстОшибки = НСтр("ru='Выражение смещения конца периода группировки не может содержать периодичность меньшую, чем %1';uk='Вираз зміщення кінця періоду групування не може містити меншу періодичність, ніж %1'");
				ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстОшибки, ПериодичностьГруппировки);
				ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "КонецПериодаГруппировки", ТекстОшибки, "");
				ЕстьОшибкаВКонце = Истина;
			КонецЕсли;
			Если ЕстьОшибкаВНачале И ЕстьОшибкаВКонце Тогда
				Прервать;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если Не Элементы.ПериодЗначения.Видимость Тогда
		НепроверяемыеРеквизиты.Добавить("НачалоПериодаГруппировки");
		НепроверяемыеРеквизиты.Добавить("КонецПериодаГруппировки");
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, НепроверяемыеРеквизиты);
	ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	Если ПроверитьЗаполнение() Тогда
		ЗначенияЗакрытия = БюджетнаяОтчетностьКлиентСервер.ПараметрыОткрытияФормыНастройкиПериода(ЭтаФорма, Ложь);
		Закрыть(ЗначенияЗакрытия);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ГраницыДанныхПриИзменении(Элемент)
	
	ПеременныеПериодов = БюджетнаяОтчетностьКлиентСервер.ПеременныеПериодовБюджетирования();
	
	Если ГраницыДанных = "" Тогда
		
		НижняяГраницаДанных = ПеременныеПериодов.НачалоПериодаДанных.Имя;
		ВерхняяГраницаДанных = ПеременныеПериодов.КонецПериодаДанных.Имя;
		
	ИначеЕсли ГраницыДанных = "ФактНачало" Тогда
		
		НижняяГраницаДанных = ПеременныеПериодов.ГраницаФактДанных.Имя;
		ВерхняяГраницаДанных = "ДобавитьКДате(" + ПеременныеПериодов.НачалоПериодаДанных.Имя + ", ДЕНЬ, -1)";
		
	ИначеЕсли ГраницыДанных = "НачалоФакт" Тогда
		
		НижняяГраницаДанных = ПеременныеПериодов.НачалоПериодаДанных.Имя;
		ВерхняяГраницаДанных = ПеременныеПериодов.ГраницаФактДанных.Имя;
		
	ИначеЕсли ГраницыДанных = "ФактКонец" Тогда
		
		НижняяГраницаДанных = "ДобавитьКДате(" + ПеременныеПериодов.ГраницаФактДанных.Имя + ", ДЕНЬ, 1)";
		ВерхняяГраницаДанных = ПеременныеПериодов.КонецПериодаДанных.Имя;
		
	ИначеЕсли ГраницыДанных = "Произвольный" Тогда
		
		НижняяГраницаДанных = ПеременныеПериодов.НачалоПериодаДанных.Имя;
		ВерхняяГраницаДанных = ПеременныеПериодов.КонецПериодаДанных.Имя;
		
	КонецЕсли;
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура ВариантПериодаОтносительноГруппировкиПриИзменении(Элемент)
	
	ПеременныеПериодов = БюджетнаяОтчетностьКлиентСервер.ПеременныеПериодовБюджетирования();
	
	Если ВариантПериодаОтносительноГруппировки = "" Тогда
		
		НачалоПериодаГруппировки = ПеременныеПериодов.ПериодГруппировки.Имя;
		КонецПериодаГруппировки = ПеременныеПериодов.ПериодГруппировки.Имя;
		
	ИначеЕсли ВариантПериодаОтносительноГруппировки = "НарастающийИтог" Тогда
		
		НачалоПериодаГруппировки = ПеременныеПериодов.НачалоПериодаДанных.Имя;
		КонецПериодаГруппировки = ПеременныеПериодов.ПериодГруппировки.Имя;
		
	ИначеЕсли ВариантПериодаОтносительноГруппировки = "ВесьПериод" Тогда
		
		НачалоПериодаГруппировки = ПеременныеПериодов.НачалоПериодаДанных.Имя;
		КонецПериодаГруппировки = ПеременныеПериодов.КонецПериодаДанных.Имя;
		
	ИначеЕсли ВариантПериодаОтносительноГруппировки = "Произвольный" Тогда
		
		НачалоПериодаГруппировки = ПеременныеПериодов.ПериодГруппировки.Имя;
		КонецПериодаГруппировки = ПеременныеПериодов.ПериодГруппировки.Имя;
		
	КонецЕсли;
	
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура НижняяГраницаПериодаНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОписаниеОповещения = Новый ОписаниеОповещения("ИзменениеФормулы", ЭтаФорма, "НижняяГраницаДанных");
	ОткрытьФорму("ОбщаяФорма.КонструкторФормул", 
		ПолучитьПараметрыФормыПериодаДанных(НижняяГраницаДанных),,,,,
		ОписаниеОповещения,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ВерхняяГраницаПериодаНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОписаниеОповещения = Новый ОписаниеОповещения("ИзменениеФормулы", ЭтаФорма, "ВерхняяГраницаДанных");
	ОткрытьФорму("ОбщаяФорма.КонструкторФормул", 
		ПолучитьПараметрыФормыПериодаДанных(ВерхняяГраницаДанных),,,,,
		ОписаниеОповещения,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ТекстНачалаГруппировкиНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОписаниеОповещения = Новый ОписаниеОповещения("ИзменениеФормулы", ЭтаФорма, "НачалоПериодаГруппировки");
	ОткрытьФорму("ОбщаяФорма.КонструкторФормул", 
		ПолучитьПараметрыФормыПериодаГруппировки(НачалоПериодаГруппировки),,,,,
		ОписаниеОповещения,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ТекстОкончанияГруппировкиНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОписаниеОповещения = Новый ОписаниеОповещения("ИзменениеФормулы", ЭтаФорма, "КонецПериодаГруппировки");
	ОткрытьФорму("ОбщаяФорма.КонструкторФормул", 
		ПолучитьПараметрыФормыПериодаГруппировки(КонецПериодаГруппировки),,,,,
		ОписаниеОповещения,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьВидимостьНастройкиГруппировки(Параметры)
	
	ЕстьПериод = Справочники.ЭлементыФинансовыхОтчетов.ЭлементРазвернутПоПериоду(Параметры, ПериодичностьГруппировки);
	Элементы.ПериодЗначения.Видимость = ЕстьПериод;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВариантыПериодов()
	
	ПеременныеПериодов = БюджетнаяОтчетностьКлиентСервер.ПеременныеПериодовБюджетирования();
	
	Если НижняяГраницаДанных = ПеременныеПериодов.НачалоПериодаДанных.Имя
		И ВерхняяГраницаДанных = ПеременныеПериодов.КонецПериодаДанных.Имя Тогда
		
		ГраницыДанных = "";
		
	ИначеЕсли НижняяГраницаДанных = ПеременныеПериодов.ГраницаФактДанных.Имя
		И ВерхняяГраницаДанных = "ДобавитьКДате(" + ПеременныеПериодов.НачалоПериодаДанных.Имя + ", ДЕНЬ, -1)" Тогда
		
		ГраницыДанных = "ФактНачало";
		
	ИначеЕсли НижняяГраницаДанных = ПеременныеПериодов.НачалоПериодаДанных.Имя
		И ВерхняяГраницаДанных = ПеременныеПериодов.ГраницаФактДанных.Имя Тогда
		
		ГраницыДанных = "НачалоФакт";
		
	ИначеЕсли НижняяГраницаДанных = "ДобавитьКДате(" + ПеременныеПериодов.ГраницаФактДанных.Имя + ", ДЕНЬ, 1)"
		И ВерхняяГраницаДанных = ПеременныеПериодов.КонецПериодаДанных.Имя Тогда
	
		ГраницыДанных = "ФактКонец";
		
	Иначе
		
		ГраницыДанных = "Произвольный";
		
	КонецЕсли;
	
	Если НачалоПериодаГруппировки = ПеременныеПериодов.ПериодГруппировки.Имя 
		И КонецПериодаГруппировки = ПеременныеПериодов.ПериодГруппировки.Имя Тогда
		
		ВариантПериодаОтносительноГруппировки = "";
		
	ИначеЕсли НачалоПериодаГруппировки = ПеременныеПериодов.НачалоПериодаДанных.Имя
		И КонецПериодаГруппировки = ПеременныеПериодов.ПериодГруппировки.Имя Тогда
		
		ВариантПериодаОтносительноГруппировки = "НарастающийИтог";
		
	ИначеЕсли НачалоПериодаГруппировки = ПеременныеПериодов.НачалоПериодаДанных.Имя
		И КонецПериодаГруппировки = ПеременныеПериодов.КонецПериодаДанных.Имя Тогда
		
		ВариантПериодаОтносительноГруппировки = "ВесьПериод";
		
	Иначе
		
		ВариантПериодаОтносительноГруппировки = "Произвольный";
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УправлениеФормой()
	
	ПроизвольныйПериодДанных = ГраницыДанных = "Произвольный";
	
	Элементы.НижняяГраницаДанных.Доступность = ПроизвольныйПериодДанных;
	Элементы.ВерхняяГраницаДанных.Доступность = ПроизвольныйПериодДанных;
	
	ПроизвольныйПериодГруппировки = ВариантПериодаОтносительноГруппировки = "Произвольный";
	
	Элементы.НачалоПериодаГруппировки.Доступность = ПроизвольныйПериодГруппировки;
	Элементы.КонецПериодаГруппировки.Доступность = ПроизвольныйПериодГруппировки;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеФормулы(Результат, ИмяПоля) Экспорт
	
	Если Результат <> Неопределено Тогда
		ЭтаФорма[ИмяПоля] = Результат.Формула;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПостроитьДеревоОператоров()
	
	ДеревоОператоров = ФинансоваяОтчетностьВызовСервера.ПостроитьДеревоОператоров();
	НаименованиеОператора = НСтр("ru='Функции';uk='Функції'");
	СтрокаФункции = ДеревоОператоров.Строки.Найти(НаименованиеОператора);
	
	НаименованиеОператора = НСтр("ru='Добавить месяц';uk='Додати місяць'");
	ОператорНаЯзыкеКода   = "ДобавитьКДате( , МЕСЯЦ, 1)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Добавить год';uk='Додати рік'");
	ОператорНаЯзыкеКода   = "ДобавитьКДате( , ГОД, 1)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	
	НаименованиеОператора = НСтр("ru='Начало года';uk='Початок року'");
	ОператорНаЯзыкеКода   = "НачалоПериода( , ГОД)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Начало полугодия';uk='Початок півріччя'");
	ОператорНаЯзыкеКода   = "НачалоПериода( , ПОЛУГОДИЕ)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Начало квартала';uk='Початок кварталу'");
	ОператорНаЯзыкеКода   = "НачалоПериода( , КВАРТАЛ)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Начало месяца';uk='Початок місяця'");
	ОператорНаЯзыкеКода   = "НачалоПериода( , МЕСЯЦ)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Начало недели';uk='Початок тижня'");
	ОператорНаЯзыкеКода   = "НачалоПериода( , НЕДЕЛЯ)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	
	НаименованиеОператора = НСтр("ru='Конец года';uk='Кінець року'");
	ОператорНаЯзыкеКода   = "КонецПериода( , ГОД)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Конец полугодия';uk='Кінець півріччя'");
	ОператорНаЯзыкеКода   = "КонецПериода( , ПОЛУГОДИЕ)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Конец квартала';uk='Кінець кварталу'");
	ОператорНаЯзыкеКода   = "КонецПериода( , КВАРТАЛ)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Конец месяца';uk='Кінець місяця'");
	ОператорНаЯзыкеКода   = "КонецПериода( , МЕСЯЦ)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	НаименованиеОператора = НСтр("ru='Конец недели';uk='Кінець тижня'");
	ОператорНаЯзыкеКода   = "КонецПериода( , НЕДЕЛЯ)";
	РаботаСФормулами.ДобавитьОператор(ДеревоОператоров, СтрокаФункции, НаименованиеОператора, ОператорНаЯзыкеКода);
	
	Возврат ПоместитьВоВременноеХранилище(ДеревоОператоров);
	
КонецФункции

&НаСервере
Функция ПолучитьПараметрыФормыПериодаДанных(Формула)
	
	ПеременныеПериодовБезСкобок = БюджетнаяОтчетностьКлиентСервер.ПеременныеПериодовБюджетирования(Истина);
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("Идентификатор");
	Таблица.Колонки.Добавить("Представление");
	
	НоваяСтрока = Таблица.Добавить();
	НоваяСтрока.Идентификатор = ПеременныеПериодовБезСкобок.НачалоПериодаДанных.Имя;
	НоваяСтрока.Представление = ПеременныеПериодовБезСкобок.НачалоПериодаДанных.Представление;
	
	НоваяСтрока = Таблица.Добавить();
	НоваяСтрока.Идентификатор = ПеременныеПериодовБезСкобок.КонецПериодаДанных.Имя;;
	НоваяСтрока.Представление = ПеременныеПериодовБезСкобок.КонецПериодаДанных.Представление;
	
	НоваяСтрока = Таблица.Добавить();
	НоваяСтрока.Идентификатор = ПеременныеПериодовБезСкобок.ГраницаФактДанных.Имя;
	НоваяСтрока.Представление = ПеременныеПериодовБезСкобок.ГраницаФактДанных.Представление;
	
	АдресДат = ПоместитьВоВременноеХранилище(Таблица);
	
	ВозвращаемыеПараметры = Новый Структура;
	ВозвращаемыеПараметры.Вставить("Формула",                      Формула);
	ВозвращаемыеПараметры.Вставить("Операнды",                     АдресДат);
	ВозвращаемыеПараметры.Вставить("ОперандыЗаголовок",            НСтр("ru='Даты для расчета';uk='Дати для розрахунку'"));
	ВозвращаемыеПараметры.Вставить("Операторы",                    ПостроитьДеревоОператоров());
	ВозвращаемыеПараметры.Вставить("ФормулаДляВычисленияВЗапросе", Истина);
	ВозвращаемыеПараметры.Вставить("ТипРезультата",                ОбщегоНазначения.ОписаниеТипаДата(ЧастиДаты.ДатаВремя));
	ВозвращаемыеПараметры.Вставить("НеИспользоватьПредставление",  Истина);
	
	ВозвращаемыеПараметры.Вставить("Расширенный",                  Истина);
	ВозвращаемыеПараметры.Вставить("ВключитьЗначение",             Ложь);
	ВозвращаемыеПараметры.Вставить("ТипПлана",                     Неопределено);
	ВозвращаемыеПараметры.Вставить("Представление"                 "");
	ВозвращаемыеПараметры.Вставить("Отбор",                        Новый Структура);
	
	
	Возврат ВозвращаемыеПараметры;
	
КонецФункции

&НаСервере
Функция ПолучитьПараметрыФормыПериодаГруппировки(Формула)
	
	ПеременныеПериодовБезСкобок = БюджетнаяОтчетностьКлиентСервер.ПеременныеПериодовБюджетирования(Истина);
	
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("Идентификатор");
	Таблица.Колонки.Добавить("Представление");
	
	НоваяСтрока = Таблица.Добавить();
	НоваяСтрока.Идентификатор = ПеременныеПериодовБезСкобок.НачалоПериодаДанных.Имя;
	НоваяСтрока.Представление = ПеременныеПериодовБезСкобок.НачалоПериодаДанных.Представление;
	
	НоваяСтрока = Таблица.Добавить();
	НоваяСтрока.Идентификатор = ПеременныеПериодовБезСкобок.КонецПериодаДанных.Имя;
	НоваяСтрока.Представление = ПеременныеПериодовБезСкобок.КонецПериодаДанных.Представление;
	
	НоваяСтрока = Таблица.Добавить();
	НоваяСтрока.Идентификатор = ПеременныеПериодовБезСкобок.ПериодГруппировки.Имя;
	НоваяСтрока.Представление = ПеременныеПериодовБезСкобок.ПериодГруппировки.Представление;
	
	НоваяСтрока = Таблица.Добавить();
	НоваяСтрока.Идентификатор = ПеременныеПериодовБезСкобок.ГраницаФактДанных.Имя;
	НоваяСтрока.Представление = ПеременныеПериодовБезСкобок.ГраницаФактДанных.Представление;
	
	АдресДат = ПоместитьВоВременноеХранилище(Таблица);
	
	ВозвращаемыеПараметры = Новый Структура;
	ВозвращаемыеПараметры.Вставить("Формула",                      Формула);
	ВозвращаемыеПараметры.Вставить("Операнды",                     АдресДат);
	ВозвращаемыеПараметры.Вставить("ОперандыЗаголовок",            НСтр("ru='Даты для расчета';uk='Дати для розрахунку'"));
	ВозвращаемыеПараметры.Вставить("Операторы",                    ПостроитьДеревоОператоров());
	ВозвращаемыеПараметры.Вставить("ФормулаДляВычисленияВЗапросе", Истина);
	ВозвращаемыеПараметры.Вставить("ТипРезультата",                ОбщегоНазначения.ОписаниеТипаДата(ЧастиДаты.ДатаВремя));
	ВозвращаемыеПараметры.Вставить("НеИспользоватьПредставление",  Истина);
	
	ВозвращаемыеПараметры.Вставить("Расширенный",                  Истина);
	ВозвращаемыеПараметры.Вставить("ВключитьЗначение",             Ложь);
	ВозвращаемыеПараметры.Вставить("ТипПлана",                     Неопределено);
	ВозвращаемыеПараметры.Вставить("Представление"                 "");
	ВозвращаемыеПараметры.Вставить("Отбор",                        Новый Структура);
	
	Возврат ВозвращаемыеПараметры;
	
КонецФункции

#КонецОбласти