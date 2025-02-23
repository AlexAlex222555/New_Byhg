////////////////////////////////////////////////////////////////////////////////
// ПОДСИСТЕМА ОСТАТКИ ОТПУСКОВ
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Функция возвращает количество дней отпуска в год по умолчанию.
//
// Параметры:
//	ВидЕжегодногоОтпуска - СправочникСсылка.ВидОтпуска - вид отпуска, для которого необходимо получить количество дней
//	                                                     по умолчанию.
//
Функция КоличествоДнейОтпускаВГодПоУмолчанию(ВидЕжегодногоОтпуска) Экспорт
	
	Возврат ОстаткиОтпусков.КоличествоДнейОтпускаВГодПоУмолчанию(ВидЕжегодногоОтпуска);
	
КонецФункции

Функция ДатаОкончанияЕжегодногоОтпуска(Знач Сотрудник, Знач ДатаНачала, Знач КоличествоДней) Экспорт
	
	Если НЕ ЗначениеЗаполнено(Сотрудник) ИЛИ КоличествоДней = 0 Тогда
		Возврат ДатаНачала;
	КонецЕсли;
	
	// Получаем графики работы сотрудника
	ПриблизительнаяДатаОкончания = ДатаНачала + (КоличествоДней + 30)*86400;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.Текст = "ВЫБРАТЬ
	               |	&Сотрудник КАК Сотрудник,
	               |	&ДатаНачала КАК ДатаНачала,
	               |	&ДатаОкончания КАК ДатаОкончания
	               |ПОМЕСТИТЬ ВТСотрудники";
	Запрос.УстановитьПараметр("Сотрудник", 		Сотрудник);
	Запрос.УстановитьПараметр("ДатаНачала", 	ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", 	ПриблизительнаяДатаОкончания);
	Запрос.Выполнить();
	
	ПараметрыПостроения = ЗарплатаКадрыОбщиеНаборыДанных.ПараметрыПостроенияДляСоздатьВТИмяРегистра();
	ПараметрыПостроения.ВключатьЗаписиНаНачалоПериода = Истина;
	
	ЗарплатаКадрыОбщиеНаборыДанных.СоздатьВТИмяРегистра(
		"ГрафикРаботыСотрудников",
		Запрос.МенеджерВременныхТаблиц,
		Истина,
		ЗарплатаКадрыОбщиеНаборыДанных.ОписаниеФильтраДляСоздатьВТИмяРегистра("ВТСотрудники", "Сотрудник"),
		ПараметрыПостроения,
		"ВТГрафикиСотрудниковСрезИДвижения");
		
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ГрафикиРаботыСотрудников.ПроизводственныйКалендарь,
		|	ВТГрафикиСотрудниковСрезИДвижения.Период
		|ПОМЕСТИТЬ ВТПериодыПроизводственныхКалендарей
		|ИЗ
		|	Справочник.ГрафикиРаботыСотрудников КАК ГрафикиРаботыСотрудников
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТГрафикиСотрудниковСрезИДвижения КАК ВТГрафикиСотрудниковСрезИДвижения
		|		ПО ГрафикиРаботыСотрудников.Ссылка = ВТГрафикиСотрудниковСрезИДвижения.ГрафикРаботы
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТПериодыПроизводственныхКалендарей.ПроизводственныйКалендарь,
		|	ВТПериодыПроизводственныхКалендарей.Период КАК ДатаНачала,
		|	МИНИМУМ(ВЫБОР
		|			КОГДА ВТПериодыПроизводственныхКалендарейСледующие.Период ЕСТЬ NULL 
		|				ТОГДА &ДатаОкончания
		|			ИНАЧЕ ДОБАВИТЬКДАТЕ(ВТПериодыПроизводственныхКалендарейСледующие.Период, ДЕНЬ, -1)
		|		КОНЕЦ) КАК ДатаОкончания
		|ПОМЕСТИТЬ ВТПериодыРаботыПоКалендарям
		|ИЗ
		|	ВТПериодыПроизводственныхКалендарей КАК ВТПериодыПроизводственныхКалендарей
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТПериодыПроизводственныхКалендарей КАК ВТПериодыПроизводственныхКалендарейСледующие
		|		ПО ВТПериодыПроизводственныхКалендарей.Период < ВТПериодыПроизводственныхКалендарейСледующие.Период
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТПериодыПроизводственныхКалендарей.ПроизводственныйКалендарь,
		|	ВТПериодыПроизводственныхКалендарей.Период
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ДанныеПроизводственногоКалендаря.ПроизводственныйКалендарь,
		|	ДанныеПроизводственногоКалендаря.Дата
		|ПОМЕСТИТЬ ВТРабочиеДни
		|ИЗ
		|	РегистрСведений.ДанныеПроизводственногоКалендаря КАК ДанныеПроизводственногоКалендаря
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТПериодыРаботыПоКалендарям КАК ВТПериодыКалендарей
		|		ПО ДанныеПроизводственногоКалендаря.ПроизводственныйКалендарь = ВТПериодыКалендарей.ПроизводственныйКалендарь
		|			И ДанныеПроизводственногоКалендаря.Дата >= ВТПериодыКалендарей.ДатаНачала
		|			И ДанныеПроизводственногоКалендаря.Дата <= ВТПериодыКалендарей.ДатаОкончания
		|ГДЕ
		|	ДанныеПроизводственногоКалендаря.ВидДня <> &ВидДняПраздник
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТРабочиеДни.Дата КАК ДатаОкончания,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ВТРабочиеДниВспомогательные.Дата) КАК НомерДня
		|ПОМЕСТИТЬ ВТНомераДней
		|ИЗ
		|	ВТРабочиеДни КАК ВТРабочиеДни
		|		ЛЕВОЕ СОЕДИНЕНИЕ ВТРабочиеДни КАК ВТРабочиеДниВспомогательные
		|		ПО ВТРабочиеДни.Дата >= ВТРабочиеДниВспомогательные.Дата
		|
		|СГРУППИРОВАТЬ ПО
		|	ВТРабочиеДни.Дата
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	ВТНомераДней.ДатаОкончания,
		|	ВТНомераДней.НомерДня КАК НомерДня
		|ИЗ
		|	ВТНомераДней КАК ВТНомераДней
		|ГДЕ
		|	ВТНомераДней.НомерДня = &КоличествоДней";
		
	Запрос.УстановитьПараметр("ВидДняПраздник", ПредопределенноеЗначение("Перечисление.ВидыДнейПроизводственногоКалендаря.Праздник"));
	Запрос.УстановитьПараметр("КоличествоДней", КоличествоДней);
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		ДатаОкончания = ДатаНачала;
	Иначе	
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		ДатаОкончания = Выборка.ДатаОкончания;
	КонецЕсли;
	
	Возврат ДатаОкончания;
	
КонецФункции

#КонецОбласти
