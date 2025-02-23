////////////////////////////////////////////////////////////////////////////////
// СотрудникиКлиентСерверРасширенный: методы, обслуживающие работу формы сотрудника.
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура УстановитьИнформациюОДругихРоляхФизическогоЛица(Форма) Экспорт
	
	КоличествоОписаний = 0;
	Если Форма.РолиФизическогоЛица.Количество() = 0 Тогда
		
		Если Форма.ОднаОрганизация Тогда
			ИнфоТекст = НСтр("ru='%1 не имеет других взаимоотношений с нашей организацией.';uk='%1 не має інших взаємовідносин з нашою організацією.'");
		Иначе
			ИнфоТекст = НСтр("ru='%1 не имеет других взаимоотношений с нашими организациями.';uk='%1 не має інших взаємовідносин з нашими організаціями.'");
		КонецЕсли;
		
		ДругиеРолиИнфоТекст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ИнфоТекст,
			Форма.ФизическоеЛицоСсылка);
		
	Иначе
		
		ЯвляетсяАкционером = Форма.РолиФизическогоЛица.НайтиСтроки(Новый Структура("Роль", ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.Акционер"))).Количество() > 0;
		ПолучаетДоходПоИнымДоговорам = Форма.РолиФизическогоЛица.НайтиСтроки(Новый Структура("Роль", ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.ПрочийПолучательДоходов"))).Количество() > 0;
		БывшийСотрудник = Форма.РолиФизическогоЛица.НайтиСтроки(Новый Структура("Роль", ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.БывшийСотрудник"))).Количество() > 0;
		РаздатчикЗарплаты = Форма.РолиФизическогоЛица.НайтиСтроки(Новый Структура("Роль", ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.РаздатчикЗарплаты"))).Количество() > 0;
		
		МассивОписанийРолей = Новый Массив;
		
		Если ЯвляетсяАкционером Тогда
			
			МассивОписанийРолей.Добавить(НСтр("ru='является акционером';uk='є акціонером'"));
			
		КонецЕсли;
		
		Если ПолучаетДоходПоИнымДоговорам Тогда
			
			МассивОписанийРолей.Добавить(НСтр("ru='получает доход по прочим договорам';uk='отримує дохід за іншими договорами'"));
			
		КонецЕсли;
		
		Если БывшийСотрудник Тогда
			
			МассивОписанийРолей.Добавить(НСтр("ru='является бывшим сотрудником';uk='є колишнім співробітником'"));
			
		КонецЕсли;
		
		Если РаздатчикЗарплаты Тогда
			
			МассивОписанийРолей.Добавить(НСтр("ru='является раздатчиком зарплаты';uk='є роздавальником зарплати'"));
			
		КонецЕсли;
		
		ИнфоТекст = "%1 " + МассивОписанийРолей[0];
		
		Если МассивОписанийРолей.Количество() > 1 Тогда
			
			ИнфоТекст = ИнфоТекст + ", " + НСтр("ru='а также';uk='а також'") + " " + МассивОписанийРолей[1];
			
		КонецЕсли; 
		
		Если МассивОписанийРолей.Количество() > 2 Тогда
			
			Если МассивОписанийРолей.Количество() > 3 Тогда
				ИнфоТекст = ИнфоТекст + ", " + МассивОписанийРолей[2] + " " + НСтр("ru='и';uk='і'") + " " + МассивОписанийРолей[3];
			Иначе
				ИнфоТекст = ИнфоТекст + " " + НСтр("ru='и';uk='і'") + " " + МассивОписанийРолей[2];
			КонецЕсли;
			
		КонецЕсли; 
		
		ДругиеРолиИнфоТекст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ИнфоТекст,
			Форма.ФизическоеЛицоСсылка);
		
	КонецЕсли;
	
	ЗарплатаКадрыКлиентСервер.УстановитьРасширеннуюПодсказкуЭлементуФормы(
		Форма, "ДругиеРолиРасшифровкаГруппа", ДругиеРолиИнфоТекст);
	
	КоличествоПеречисляемыхРолей = 15;
	
	Для каждого РольФизическогоЛица Из Форма.РолиФизическогоЛица Цикл
		
		Если РольФизическогоЛица.Роль = ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.Акционер") Тогда
			ОписаниеРоли = НСтр("ru='Акционер %1';uk='Акціонер %1'");
		ИначеЕсли РольФизическогоЛица.Роль = ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.ПрочийПолучательДоходов") Тогда
			ОписаниеРоли = НСтр("ru='Получает доход  по прочим договорам в %1';uk='Отримує дохід за іншими договорами %1'");
		ИначеЕсли РольФизическогоЛица.Роль = ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.БывшийСотрудник") Тогда
			ОписаниеРоли = НСтр("ru='Бывший сотрудник %1';uk='Колишній співробітник %1'");
		ИначеЕсли РольФизическогоЛица.Роль = ПредопределенноеЗначение("Перечисление.РолиФизическихЛиц.РаздатчикЗарплаты") Тогда
			ОписаниеРоли = НСтр("ru='Раздатчик зарплаты в %1';uk='Роздавальник зарплати у %1'");
		КонецЕсли;
		
		КоличествоОписаний = КоличествоОписаний + 1;
		
		Форма["ДругиеРолиРасшифровка" + КоличествоОписаний] = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ОписаниеРоли,
			РольФизическогоЛица.Организация);
				
		Форма.Элементы["ДругиеРолиРасшифровка" + КоличествоОписаний].Видимость = Истина;
	
		Если КоличествоОписаний >= КоличествоПеречисляемыхРолей Тогда
			Прервать;
		КонецЕсли; 
		
	КонецЦикла;
	
	Для НомерОписания = КоличествоОписаний + 1 По КоличествоПеречисляемыхРолей Цикл
		
		Форма.Элементы["ДругиеРолиРасшифровка" + НомерОписания].Видимость = Ложь;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьРазмерМесяцевСтрокиСтажа(СтрокаСтажа) Экспорт
	СтрокаСтажа.РазмерМесяцев = ВсегоМесяцевПоСтрокеСтажа(СтрокаСтажа);
КонецПроцедуры

Функция ВсегоМесяцевПоСтрокеСтажа(СтрокаСтажа) Экспорт
	
	Возврат СтрокаСтажа.Месяцев + СтрокаСтажа.Лет * 12;;
	
КонецФункции

Функция ОписаниеДополнительнойФормы(ИмяОткрываемойФормы) Экспорт
	
	ОписаниеФормы = СотрудникиКлиентСервер.ОбщееОписаниеДополнительнойФормы(ИмяОткрываемойФормы);
	
	Если ИмяОткрываемойФормы = "Справочник.Сотрудники.Форма.ВыплатаЗарплаты" Тогда
		
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("СотрудникСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ДатаПриема");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ФизическоеЛицоСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ТекущаяОрганизация");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ТекущееПодразделение");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("СозданиеНового");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "Сотрудник.Наименование");

		ОписаниеФормы.ДополнительныеДанные.Вставить("ЛицевыеСчетаСотрудниковПоЗарплатнымПроектам");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ЛицевыеСчетаСотрудниковПоЗарплатнымПроектамНаборЗаписей");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ЛицевыеСчетаСотрудниковПоЗарплатнымПроектамНаборЗаписейПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ЛицевыеСчетаСотрудниковПоЗарплатнымПроектамНоваяЗапись");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ЛицевыеСчетаСотрудниковПоЗарплатнымПроектамПрежняя");
		
		ОписаниеФормы.ДополнительныеДанные.Вставить("МестаВыплатыЗарплатыПодразделений");
		ОписаниеФормы.ДополнительныеДанные.Вставить("МестаВыплатыЗарплатыПодразделенийПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("МестаВыплатыЗарплатыСотрудников");
		ОписаниеФормы.ДополнительныеДанные.Вставить("МестаВыплатыЗарплатыСотрудниковПрочитан");
		
		ОписаниеФормы.ДополнительныеДанные.Вставить("БухучетЗарплатыСотрудников");
		ОписаниеФормы.ДополнительныеДанные.Вставить("БухучетЗарплатыСотрудниковНаборЗаписей");
		ОписаниеФормы.ДополнительныеДанные.Вставить("БухучетЗарплатыСотрудниковНаборЗаписейПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("БухучетЗарплатыСотрудниковНоваяЗапись");
		ОписаниеФормы.ДополнительныеДанные.Вставить("БухучетЗарплатыСотрудниковПрежняя");
		
	ИначеЕсли ИмяОткрываемойФормы = "Справочник.Сотрудники.Форма.ДоговорыГПХ" Тогда
		
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("СотрудникСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "ФизическоеЛицо.Наименование");
		
	ИначеЕсли ИмяОткрываемойФормы = "Справочник.Сотрудники.Форма.НачисленияИУдержания" Тогда
		
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("СотрудникСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "ФизическоеЛицо.Наименование");
		
	ИначеЕсли ИмяОткрываемойФормы = "Справочник.Сотрудники.Форма.Отсутствия" Тогда
		
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("СотрудникСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ТекущаяОрганизация");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "ФизическоеЛицо.Наименование");
		
	ИначеЕсли ИмяОткрываемойФормы = "Справочник.ФизическиеЛица.Форма.СпециальныеСтатусы" Тогда
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("СотрудникСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ФизическоеЛицоСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ГоловнаяОрганизация", "Сотрудник.ГоловнаяОрганизация");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ТекущаяОрганизация");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("СозданиеНового");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "ФизическоеЛицо.Наименование");
		
		ОписаниеФормы.РеквизитыОбъекта.Вставить("ЛьготаПриНачисленииПособий", "ФизическоеЛицо.ЛьготаПриНачисленииПособий");
				
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОбИнвалидностиФизическихЛиц");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОбИнвалидностиФизическихЛицНаборЗаписей");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОбИнвалидностиФизическихЛицНаборЗаписейПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОбИнвалидностиФизическихЛицНоваяЗапись");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОбИнвалидностиФизическихЛицПрежняя");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОЛицахСДополнительнымиГарантиями");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОЛицахСДополнительнымиГарантиямиНаборЗаписей");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОЛицахСДополнительнымиГарантиямиНаборЗаписейПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОЛицахСДополнительнымиГарантиямиНоваяЗапись");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОЛицахСДополнительнымиГарантиямиПрежняя");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОЛьготахФизическихЛицПострадавшихВАварииЧАЭС");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОЛьготахФизическихЛицПострадавшихВАварииЧАЭСПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОПенсионерах");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОПенсионерахНаборЗаписей");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОПенсионерахНаборЗаписейПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОПенсионерахНоваяЗапись");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СведенияОПенсионерахПрежняя");
		
	ИначеЕсли ИмяОткрываемойФормы = "Справочник.ФизическиеЛица.Форма.ВоинскийУчет" Тогда
		
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ФизическоеЛицоСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "ФизическоеЛицо.Наименование");
		
		ОписаниеФормы.ДополнительныеДанные.Вставить("ВоинскийУчет");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ВоинскийУчетНаборЗаписей");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ВоинскийУчетНаборЗаписейПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ВоинскийУчетНоваяЗапись");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ВоинскийУчетПрежняя");
		
	ИначеЕсли ИмяОткрываемойФормы = "Справочник.ФизическиеЛица.Форма.Семья" Тогда
		
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ФизическоеЛицоСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "ФизическоеЛицо.Наименование");

		ОписаниеФормы.ДополнительныеДанные.Вставить("СостоянияВБракеФизическихЛиц");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СостоянияВБракеФизическихЛицНаборЗаписей");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СостоянияВБракеФизическихЛицНаборЗаписейПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СостоянияВБракеФизическихЛицНоваяЗапись");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СостоянияВБракеФизическихЛицПрежняя");

	ИначеЕсли ИмяОткрываемойФормы = "Справочник.ФизическиеЛица.Форма.ТрудоваяДеятельность" Тогда
		
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ФизическоеЛицоСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "ФизическоеЛицо.Наименование");
		
		ОписаниеФормы.ДополнительныеДанные.Вставить("НаградыФизическихЛиц");
		ОписаниеФормы.ДополнительныеДанные.Вставить("НаградыФизическихЛицПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СтажиФизическихЛиц");
		ОписаниеФормы.ДополнительныеДанные.Вставить("СтажиФизическихЛицПрочитан");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ТрудоваяДеятельностьФизическихЛиц");
		ОписаниеФормы.ДополнительныеДанные.Вставить("ТрудоваяДеятельностьФизическихЛицПрочитан");

	ИначеЕсли ИмяОткрываемойФормы = "Справочник.ФизическиеЛица.Форма.ОбразованиеКвалификация" Тогда
		
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("СотрудникСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("ФизическоеЛицоСсылка");
		ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "ФизическоеЛицо.Наименование");
		
		ОписаниеФормы.РеквизитыОбъекта.Вставить("ИмеетИзобретения", "ФизическоеЛицо.ИмеетИзобретения");
		ОписаниеФормы.РеквизитыОбъекта.Вставить("ИмеетНаучныеТруды", "ФизическоеЛицо.ИмеетНаучныеТруды");
		
	ИначеЕсли ИмяОткрываемойФормы = "ОбщаяФорма.РедактированиеСведенийОГосударственномСлужащем" Тогда
		#Если Клиент Тогда
			ГосударственнаяСлужбаСуществует = ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба");
		#Иначе
			ГосударственнаяСлужбаСуществует = ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба");
		#КонецЕсли
		
		Если ГосударственнаяСлужбаСуществует Тогда
			#Если Клиент Тогда
				Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("ГосударственнаяСлужбаКлиентСервер");
			#Иначе
				Модуль = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужбаКлиентСервер");
			#КонецЕсли
			Модуль.ДополнитьОписаниеФормыРедактированиеСведенийОГосударственномСлужащем(ОписаниеФормы);
		КонецЕсли;
		
	ИначеЕсли ИмяОткрываемойФормы = "ОбщаяФорма.СотрудникиОхранаТруда" Тогда
		
		#Если Клиент Тогда
			ОхранаТрудаСуществует = ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.ОхранаТруда");
		#Иначе
			ОхранаТрудаСуществует = ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.ОхранаТруда");
		#КонецЕсли
		
		Если ОхранаТрудаСуществует Тогда
			
			ОписаниеФормы.КлючевыеРеквизиты.Вставить("СотрудникСсылка");
			ОписаниеФормы.КлючевыеРеквизиты.Вставить("Заголовок", "Сотрудник.Наименование");
			
		КонецЕсли;
		
	Иначе
		ОписаниеФормы = СотрудникиКлиентСерверБазовый.ОписаниеДополнительнойФормы(ИмяОткрываемойФормы);
	КонецЕсли;
	
	Возврат ОписаниеФормы;
	
КонецФункции

Функция ПредставлениеСотрудникаПоДаннымФормыСотрудника(Форма) Экспорт
	
	ДанныеДляФормированияПредставления = Новый Структура;
	
	ДанныеДляФормированияПредставления.Вставить("ПравилоФормированияПредставления", Форма.ПравилоФормированияПредставления());
	
	ДанныеДляФормированияПредставления.Вставить("ФИОПолные", Форма.ФизическоеЛицо.ФИО);
	ДанныеДляФормированияПредставления.Вставить("УточнениеНаименованияФизическогоЛица", Форма.ФизическоеЛицо.УточнениеНаименования);
	ДанныеДляФормированияПредставления.Вставить("УточнениеНаименованияСотрудника", Форма.Сотрудник.УточнениеНаименования);
	
	ДанныеДляФормированияПредставления.Вставить("Организация", Форма.ТекущаяОрганизация);
	ДанныеДляФормированияПредставления.Вставить("ВидЗанятости", Форма.ТекущийВидЗанятости);
	ДанныеДляФормированияПредставления.Вставить("ДатаУвольнения", Форма.ДатаУвольнения);
	
	Возврат КадровыйУчетКлиентСервер.ПредставлениеЭлементаСправочникаСотрудники(ДанныеДляФормированияПредставления);
	
КонецФункции

Функция ПользовательскиеОтборы(Список) Экспорт
	
	ПользовательскиеОтборы = Неопределено;
	Для каждого ЭлементПользовательскихНастроек Из Список.КомпоновщикНастроек.ПользовательскиеНастройки.Элементы Цикл
		
		Если ТипЗнч(ЭлементПользовательскихНастроек) = Тип("ОтборКомпоновкиДанных") Тогда
			ПользовательскиеОтборы = ЭлементПользовательскихНастроек;
			Прервать;
		КонецЕсли; 
		
	КонецЦикла;
	
	Если ПользовательскиеОтборы = Неопределено Тогда
		КоллекцияЭлементов = Новый Массив;
	Иначе
		КоллекцияЭлементов = ПользовательскиеОтборы.Элементы;
	КонецЕсли;
	
	Возврат КоллекцияЭлементов;
	
КонецФункции

#КонецОбласти
