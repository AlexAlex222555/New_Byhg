#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ПараметрыФормы = Новый Структура;
	
	Если ТипЗнч(ПараметрыВыполненияКоманды.Источник) = Тип("ФормаКлиентскогоПриложения") Тогда
		
		Если ПараметрыВыполненияКоманды.Источник.ИмяФормы =
		         "Справочник.Пользователи.Форма.ФормаСписка" Тогда
			
			ПараметрыФормы.Вставить("Отбор", "Пользователи");
			
		ИначеЕсли ПараметрыВыполненияКоманды.Источник.ИмяФормы =
		              "Справочник.ВнешниеПользователи.Форма.ФормаСписка" Тогда
			
			ПараметрыФормы.Вставить("Отбор", "ВнешниеПользователи");
		КонецЕсли;
	КонецЕсли;
	
	ОткрытьФорму(
		"Справочник.Пользователи.Форма.ПользователиИнформационнойБазы",
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник,
		ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно);
	
КонецПроцедуры

#КонецОбласти
