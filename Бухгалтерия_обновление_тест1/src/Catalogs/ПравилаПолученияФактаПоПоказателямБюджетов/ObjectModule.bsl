#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	МассивНепроверяемыхРеквизитов.Добавить("ТипИтога");
	
	Если НЕ ЗначениеЗаполнено(РазделИсточникаДанных) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ИсточникДанных");
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
	НеЗаполненТипИтога = (РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.РегламентированныйУчет
							ИЛИ РазделИсточникаДанных = Перечисления.РазделыИсточниковДанныхБюджетирования.МеждународныйУчет)
						И Не ЗначениеЗаполнено(ТипИтога);
	
	Если НеЗаполненТипИтога Тогда
		ТекстСообщения = НСтр("ru='Поле Тип итога не заполнено';uk='Поле Тип підсумку не заповнено'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			ТекстСообщения, ,"ТипИтога", "Запись", Отказ);
	КонецЕсли;

КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда 
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Наименование = Строка(РазделИсточникаДанных) + ": " + ИсточникДанных;
	Если ЗначениеЗаполнено(ТипИтога) Тогда
		Наименование = Наименование + ", " + ТипИтога;
	КонецЕсли;
	Если ЗначениеЗаполнено(ПредставлениеОтбора) Тогда
		Наименование = Наименование + ", " + ПредставлениеОтбора;
	КонецЕсли;
	
	МаксимальноеКоличествоАналитик = БюджетированиеКлиентСервер.МаксимальноеКоличествоАналитик();
	Для Сч = 1 По МаксимальноеКоличествоАналитик Цикл
		
		Если ЭтотОбъект["ЗаполнятьУказаннымЗначениемАналитику" + Сч]
		   И ЗначениеЗаполнено(ПоказательБюджетов["ВидАналитики" + Сч]) Тогда
			
			ТипАналитики = ПоказательБюджетов["ВидАналитики" + Сч].ТипЗначения;
			ЭтотОбъект["ЗначениеАналитики" + Сч] = БюджетированиеКлиентСервер.ПриведенноеЗначениеАналитики(
				ЭтотОбъект["ЗначениеАналитики" + Сч],
				ТипАналитики);
				
		Иначе
			
			ЭтотОбъект["ЗначениеАналитики" + Сч] = БюджетированиеКлиентСервер.ПустоеЗначениеАналитики();
			
		КонецЕсли;
		
	КонецЦикла;
	
	// Сделаем слепок настроек и схемы для будущего сравнения их между собой без анализа каждого элемента.
	Если Не ЭтотОбъект.ПометкаУдаления Тогда
		БюджетированиеСервер.ЗаполнитьРеквизитыХешейНастроекИСхемы(ЭтотОбъект);
	КонецЕсли;
	
	// Заполним настройки заполнения аналитик
	Если Не ЭтотОбъект.РасширенныйРежимНастройкиЗаполненияАналитики Тогда
		БюджетированиеСервер.ЗаполнитьРеквизитыОбъектаНастроекЗаполненияАналитики(ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
