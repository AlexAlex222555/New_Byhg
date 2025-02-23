#Область ОбработчикиСобытий

Процедура ОбработкаПолученияДанныхВыбора(ДанныеВыбора, Параметры, СтандартнаяОбработка)
	ЗарплатаКадрыВызовСервера.ПодготовитьДанныеВыбораКлассификаторовСПорядкомКодов(ДанныеВыбора, Параметры, СтандартнаяОбработка, "Справочник.ВидыДоходовНДФЛ");
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает реквизиты справочника, которые образуют естественный ключ
//  для элементов справочника.
// Используется для сопоставления элементов механизмом «Выгрузка/загрузка областей данных».
//
// Возвращаемое значение: Массив(Строка) - массив имен реквизитов, образующих
//  естественный ключ.
//
Функция ПоляЕстественногоКлюча() Экспорт
	
	Результат = Новый Массив;
	
	Результат.Добавить("Код");
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

Функция ВидыДоходовДляФСС(НДФЛ = Истина, ВС = Истина) Экспорт
	
	МассивНДФЛ = Новый Массив();
	
	Если НДФЛ Тогда
		МассивНДФЛ.Добавить(Справочники.ВидыДоходовНДФЛ.Код101ФСС);
	КонецЕсли;
	Если ВС Тогда
		МассивНДФЛ.Добавить(Справочники.ВидыДоходовНДФЛ.ВоенныйСборФСС);
	КонецЕсли;
	
	Возврат МассивНДФЛ;
	
КонецФункции	

Функция ВидДоходовДивиденды() Экспорт
	
	Возврат Справочники.ВидыДоходовНДФЛ.Код109;
	
КонецФункции