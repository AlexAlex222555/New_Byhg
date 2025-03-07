#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);

	Если НЕ ЗначениеЗаполнено(ТипМестаХранения) Тогда 
		
		Если ТипЗнч(МестоХранения) = Тип("СправочникСсылка.Склады") Тогда
			
			ТипМестаХранения = Перечисления.ТипыМестХранения.Склад;
			СкладскаяТерритория = МестоХранения;
			
		ИначеЕсли ТипЗнч(МестоХранения) = Тип("СправочникСсылка.ДоговорыКонтрагентов") Тогда
			
			ПоляДоговора = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(МестоХранения, "Партнер, Контрагент");
			
			ТипМестаХранения = Перечисления.ТипыМестХранения.ДоговорКонтрагента;
			Договор = МестоХранения;
			
			Партнер = ПоляДоговора.Партнер;
			Контрагент = ПоляДоговора.Контрагент;
			
		ИначеЕсли ТипЗнч(МестоХранения) = Тип("СправочникСсылка.Организации") Тогда
			
			ТипМестаХранения = Перечисления.ТипыМестХранения.Организация;
			Организация = МестоХранения;
			
		ИначеЕсли ТипЗнч(МестоХранения) = Тип("СправочникСсылка.Партнеры") Тогда
			
			ТипМестаХранения = Перечисления.ТипыМестХранения.Партнер;
			Партнер = МестоХранения;
			
		ИначеЕсли ТипЗнч(МестоХранения) = Тип("СправочникСсылка.СтруктураПредприятия") Тогда
			
			ТипМестаХранения = Перечисления.ТипыМестХранения.Подразделение;
			Подразделение = МестоХранения;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	УдалитьАналитикуКлюча();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

Процедура УдалитьАналитикуКлюча()
	
	Запрос = Новый Запрос("
	|ВЫБРАТЬ
	|	*
	|ИЗ
	|	РегистрСведений.АналитикаУчетаНоменклатуры КАК ДанныеРегистра
	|ГДЕ
	|	ДанныеРегистра.КлючАналитики = &Ключ
	|");
	Запрос.УстановитьПараметр("Ключ", Ссылка);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		МенеджерЗаписи = РегистрыСведений.АналитикаУчетаНоменклатуры.СоздатьМенеджерЗаписи();
		ЗаполнитьЗначенияСвойств(МенеджерЗаписи, Выборка);
		МенеджерЗаписи.Удалить();
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецЕсли
