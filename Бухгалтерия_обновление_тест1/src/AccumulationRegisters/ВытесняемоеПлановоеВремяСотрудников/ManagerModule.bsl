#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Функция ОписаниеРегистра() Экспорт
	ОписаниеРегистра = УчетРабочегоВремени.ОписаниеРегистраДанныхУчетаВремени();
	
	ОписаниеРегистра.МетаданныеРегистра = Метаданные.РегистрыНакопления.ВытесняемоеПлановоеВремяСотрудников;
	ОписаниеРегистра.ИмяПоляСотрудник = "Сотрудник";
	ОписаниеРегистра.ИмяПоляПериод = "Период";
	ОписаниеРегистра.ИмяПоляПериодРегистрации = "ПериодРегистрации";
	ОписаниеРегистра.ИмяПоляВидДанных = Неопределено;
	ОписаниеРегистра.ВидДанных = Перечисления.ВидыДанныхУчетаВремениСотрудников.ВытесняемоеПлановоеВремя;
	
	Возврат ОписаниеРегистра;
КонецФункции	

#КонецЕсли



