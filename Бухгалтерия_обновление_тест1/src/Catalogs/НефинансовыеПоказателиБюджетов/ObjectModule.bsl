#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	БюджетированиеСервер.ЗаполнитьВспомогательныеРеквизитыПередЗаписью(ЭтотОбъект);
	
	МаксимальноеКоличествоАналитик = БюджетированиеКлиентСервер.МаксимальноеКоличествоАналитик();
	Для Сч = 1 По МаксимальноеКоличествоАналитик Цикл
		Если ЭтотОбъект["ЗаполнятьУказаннымЗначениемАналитику" + Сч]
		   И ЗначениеЗаполнено(ЭтотОбъект["ВидАналитики" + Сч]) Тогда
			ВидАналитики = ЭтотОбъект["ВидАналитики" + Сч];
			ТипАналитики = ВидАналитики.ТипЗначения;
			ЭтотОбъект["ЗначениеАналитики" + Сч] = БюджетированиеКлиентСервер.ПриведенноеЗначениеАналитики(
				ЭтотОбъект["ЗначениеАналитики" + Сч],
				ТипАналитики);
		Иначе
			ЭтотОбъект["ЗначениеАналитики" + Сч] = БюджетированиеКлиентСервер.ПустоеЗначениеАналитики();
		КонецЕсли;
	КонецЦикла;
	
	Если ЗагружатьИзДругихПодсистем Тогда
		// Сделаем слепок настроек для будущего сравнения их между собой без анализа каждого элемента.
		НастройкиКД = Неопределено;
		Если Не ДополнительныеСвойства.Свойство("НастройкиКД", НастройкиКД) Тогда
			НастройкиКД = ХранилищеНастроекКомпоновкиДанных.Получить();
		КонецЕсли;
			
		ХешНастроек = ОбщегоНазначенияУТ.ХешСуммаСериализуемогоОбъекта(НастройкиКД, ХешФункция.MD5);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ПроверенныеРеквизитыОбъекта = Новый Массив;
	Если Не ЭтоГруппа Тогда
		Если Не ПоПериодам И Не УстанавливатьЗначениеНаКаждыйПериод Тогда
			ПроверенныеРеквизитыОбъекта.Добавить("Периодичность");
		КонецЕсли;
		
		Если Не ПоПериодам Тогда
			ПроверенныеРеквизитыОбъекта.Добавить("ПериодичностьПодпериодов");
		КонецЕсли;
		
		Если ВидПоказателя <> Перечисления.ВидыНефинансовыхПоказателей.Денежный Тогда
			ПроверенныеРеквизитыОбъекта.Добавить("АналитикаВалюты");
		ИначеЕсли Не ВалютаОпределяетсяАналитикой Тогда
			ПроверенныеРеквизитыОбъекта.Добавить("АналитикаВалюты");
		КонецЕсли;
		
		Если ВидПоказателя <> Перечисления.ВидыНефинансовыхПоказателей.Количественный Тогда
			ПроверенныеРеквизитыОбъекта.Добавить("ЕдиницаИзмерения");
			ПроверенныеРеквизитыОбъекта.Добавить("АналитикаЕдиницыИзмерения");
		Иначе
			Если ЕдиницаИзмеренияОпределяетсяАналитикой Тогда
				ПроверенныеРеквизитыОбъекта.Добавить("ЕдиницаИзмерения");
			Иначе
				ПроверенныеРеквизитыОбъекта.Добавить("АналитикаЕдиницыИзмерения");
			КонецЕсли;
		КонецЕсли;
		
		Если Не Справочники.ГруппыДоступаСтатейИПоказателейБюджетов.ИспользуютсяГруппыДоступа() Тогда
			ПроверенныеРеквизитыОбъекта.Добавить("ГруппаДоступа");
		КонецЕсли;

	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, ПроверенныеРеквизитыОбъекта);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли