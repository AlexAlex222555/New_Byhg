
#Область СлужебныйПрограммныйИнтерфейс

#Область Свойства

// См. УправлениеСвойствамиПереопределяемый.ПриПолученииПредопределенныхНаборовСвойств.
Процедура ПриПолученииПредопределенныхНаборовСвойств(Наборы) Экспорт
	
	УправлениеСвойствамиБЗК.ЗарегистрироватьНаборСвойств(Наборы, "d42dbfab-9802-11e9-80cd-4cedfb43b11a", Метаданные.Документы.ЗаявлениеНаПредоставлениеЛьготыПоНДФЛ);
	УправлениеСвойствамиБЗК.ЗарегистрироватьНаборСвойств(Наборы, "d42dbf43-9802-11e9-80cd-4cedfb43b11a", Метаданные.Документы.ПерерасчетНДФЛ);
	
КонецПроцедуры

#КонецОбласти

#Область УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииСписковСОграничениемДоступа(Списки) Экспорт
	
	Списки.Вставить(Метаданные.Документы.ПерерасчетНДФЛ, Истина);
	Списки.Вставить(Метаданные.Справочники.ПерерасчетНДФЛПрисоединенныеФайлы, Истина);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти