#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	НастройкиИспользованияСерий = Справочники.ВидыНоменклатуры.НастройкиИспользованияСерий(ВидНоменклатуры);
	
	Для Каждого Реквизит Из НастройкиИспользованияСерий.ОписанияИспользованияРеквизитовСерии Цикл
		Если Не Реквизит.Использование Тогда
			ЭтотОбъект[Реквизит.ИмяРеквизита] = Неопределено;
		КонецЕсли;
	КонецЦикла;
	
	Номер = СокрЛП(Номер);
	
	Если НастройкиИспользованияСерий.ТочностьУказанияСрокаГодностиСерии = Перечисления.ТочностиУказанияСрокаГодности.СТочностьюДоЧасов Тогда
		ГоденДо = НачалоЧаса(ГоденДо);
	ИначеЕсли НастройкиИспользованияСерий.ТочностьУказанияСрокаГодностиСерии = Перечисления.ТочностиУказанияСрокаГодности.СТочностьюДоМесяцев Тогда
		ГоденДо = НачалоМесяца(ГоденДо);
	Иначе
		ГоденДо = НачалоДня(ГоденДо);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(НастройкиИспользованияСерий.ШаблонРабочегоНаименованияСерии) Тогда
		Наименование = НоменклатураСервер.НаименованиеПоШаблону(НастройкиИспользованияСерий.ШаблонРабочегоНаименованияСерии, ЭтотОбъект);
	Иначе
		Наименование = НоменклатураКлиентСервер.ПредставлениеСерииБезРасчетаПоШаблонуНаименования(НастройкиИспользованияСерий, ЭтотОбъект);
	КонецЕсли;
	
	ОбщегоНазначенияУТ.ПодготовитьДанныеДляСинхронизацииКлючей(ЭтотОбъект, ПараметрыСинхронизацииКлючей());	
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
		
	ОбщегоНазначенияУТ.СинхронизироватьКлючи(ЭтотОбъект);	
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	НастройкиИспользованияСерий = Справочники.ВидыНоменклатуры.НастройкиИспользованияСерий(ВидНоменклатуры);

	Для Каждого Реквизит Из НастройкиИспользованияСерий.ОписанияИспользованияРеквизитовСерии Цикл
		Если Не Реквизит.Использование
			Или Не Реквизит.ПроверятьЗаполнение Тогда
			МассивНепроверяемыхРеквизитов.Добавить(Реквизит.ИмяРеквизита);
		КонецЕсли;
	КонецЦикла;
		
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если ДанныеЗаполнения = "АвтоТест" Тогда
		Возврат;
	КонецЕсли;
	
	ВидНоменклатуры = ДанныеЗаполнения.ВидНоменклатуры;
	НастройкиИспользованияСерий = Новый ФиксированнаяСтруктура(Справочники.ВидыНоменклатуры.НастройкиИспользованияСерий(ВидНоменклатуры));
	
	СтруктураПолей = Новый Структура;
	
	Для Каждого Реквизит Из НастройкиИспользованияСерий.ОписанияИспользованияРеквизитовСерии Цикл
		Если Реквизит.Использование Тогда
			СтруктураПолей.Вставить(Реквизит.ИмяРеквизита);
		КонецЕсли;
	КонецЦикла;
			
	ЗаполнитьЗначенияСвойств(СтруктураПолей, ДанныеЗаполнения);
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, СтруктураПолей);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПараметрыСинхронизацииКлючей()
	
	Результат = Новый Соответствие;
	
	Результат.Вставить("Справочник.КлючиАналитикиУчетаНоменклатуры", "ПометкаУдаления");
	
	//++ НЕ УТ
	Результат.Вставить("Справочник.ПартииПроизводства", "ПометкаУдаления");
	//-- НЕ УТ
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
#КонецЕсли