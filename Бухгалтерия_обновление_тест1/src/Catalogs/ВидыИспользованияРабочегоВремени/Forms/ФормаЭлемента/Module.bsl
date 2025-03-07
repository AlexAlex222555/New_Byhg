
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	Если Объект.Ссылка = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ВидыИспользованияРабочегоВремени.РабочееВремя") Тогда
		ТолькоПросмотр = Истина;
	КонецЕсли;	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	УстановитьДоступностьЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Запись_ВидыИспользованияРабочегоВремени", Объект.Ссылка); 
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОсновноеВремяПриИзменении(Элемент)
	УстановитьСвойстваВидаВремениПоОсновномуВремени();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере 
Процедура УстановитьДоступностьЭлементов()
	ДоступносьЭлементов = Не Объект.Предопределенный;
	
	Элементы.ОсновноеВремя.Доступность = ДоступносьЭлементов;
КонецПроцедуры	

&НаСервере
Процедура УстановитьСвойстваВидаВремениПоОсновномуВремени()
	Если Объект.ОсновноеВремя.Пустая() Тогда
		Объект.РабочееВремя = Ложь;
		Объект.Целосменное = Ложь;
		Объект.УважительнаяПричинаДляБольничных = Ложь;
	Иначе
		СвойстваОсновногоВидаВремени = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Объект.ОсновноеВремя, "РабочееВремя, Целосменное, УважительнаяПричинаДляБольничных");
		ЗаполнитьЗначенияСвойств(Объект, СвойстваОсновногоВидаВремени);
	КонецЕсли;		
КонецПроцедуры	

#КонецОбласти
