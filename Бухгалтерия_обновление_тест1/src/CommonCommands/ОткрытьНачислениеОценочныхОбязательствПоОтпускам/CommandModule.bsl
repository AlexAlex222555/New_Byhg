
#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	ОткрытьФорму("Документ.НачислениеОценочныхОбязательствПоОтпускам.ФормаСписка", ,
	ПараметрыВыполненияКоманды.Источник,
	ПараметрыВыполненияКоманды.Уникальность,
	ПараметрыВыполненияКоманды.Окно,
	ПараметрыВыполненияКоманды.НавигационнаяСсылка);
КонецПроцедуры

#КонецОбласти

