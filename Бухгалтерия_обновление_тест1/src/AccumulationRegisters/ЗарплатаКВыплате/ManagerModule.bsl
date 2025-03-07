#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(ФизическоеЛицо)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом


#Область СлужебныеПроцедурыИФункции

#Область ПервоначальноеЗаполнениеИОбновлениеИнформационнойБазы

Процедура ЗаполнитьОрганизацию() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЗарплатаКВыплате.Регистратор КАК Ссылка,
	|	ЗарплатаКВыплате.Регистратор.Организация КАК Организация
	|ИЗ
	|	РегистрНакопления.ЗарплатаКВыплате КАК ЗарплатаКВыплате
	|ГДЕ
	|	ЗарплатаКВыплате.Организация = ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
	|
	|УПОРЯДОЧИТЬ ПО
	|	НАЧАЛОПЕРИОДА(ЗарплатаКВыплате.Регистратор.Дата, ГОД),
	|	ЗарплатаКВыплате.Регистратор.Организация,
	|	ЗарплатаКВыплате.Регистратор.Номер";
	
	ВыборкаРегистраторов = Запрос.Выполнить().Выбрать();
	
	Пока ВыборкаРегистраторов.Следующий() Цикл
		
		НаборЗаписей = СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Регистратор.Значение = ВыборкаРегистраторов.Ссылка;
		НаборЗаписей.ОбменДанными.Загрузка = Истина;
		
		НаборЗаписей.Прочитать();
		
		Для Каждого Запись Из НаборЗаписей Цикл
			Запись.Организация = ВыборкаРегистраторов.Организация;
		КонецЦикла;	
		
		НаборЗаписей.Записать();
		
	КонецЦикла
	
КонецПроцедуры	

Процедура ЗаполнитьПериодДвиженийВедомостейПериодомРегистрации() Экспорт
	
	Запрос = Новый Запрос;
	
	ТипыВедомостей = Новый Массив;
	Для Каждого ВидМестаВыплаты Из Перечисления.ВидыМестВыплатыЗарплаты Цикл
		МенеджерДокумента = ВзаиморасчетыССотрудниками.МенеджерДокументаВедомостьПоВидуМестаВыплаты(ВидМестаВыплаты);
		Если МенеджерДокумента <> Неопределено Тогда
			ТипыВедомостей.Добавить(ТипЗнч(МенеджерДокумента.ПустаяСсылка()))
		КонецЕсли	
	КонецЦикла;
	
	Запрос.УстановитьПараметр("ТипыВедомостей", ТипыВедомостей);
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ЗарплатаКВыплате.Регистратор КАК Ссылка,
	|	ЗарплатаКВыплате.Регистратор.ПериодРегистрации КАК ПериодРегистрации
	|ИЗ
	|	РегистрНакопления.ЗарплатаКВыплате КАК ЗарплатаКВыплате
	|ГДЕ
	|	ТИПЗНАЧЕНИЯ(ЗарплатаКВыплате.Регистратор) В (&ТипыВедомостей)
	|	И ЗарплатаКВыплате.Период <> ЗарплатаКВыплате.Регистратор.ПериодРегистрации
	|
	|УПОРЯДОЧИТЬ ПО
	|	НАЧАЛОПЕРИОДА(ЗарплатаКВыплате.Регистратор.Дата, ГОД),
	|	ЗарплатаКВыплате.Регистратор.Организация,
	|	ЗарплатаКВыплате.Регистратор.Номер";
	
	ВыборкаРегистраторов = Запрос.Выполнить().Выбрать();
	
	Пока ВыборкаРегистраторов.Следующий() Цикл
		
		НаборЗаписей = СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.Регистратор.Значение = ВыборкаРегистраторов.Ссылка;
		НаборЗаписей.ОбменДанными.Загрузка = Истина;
		
		НаборЗаписей.Прочитать();
		
		Для Каждого Запись Из НаборЗаписей Цикл
			Запись.Период = ВыборкаРегистраторов.ПериодРегистрации;
		КонецЦикла;	
		
		НаборЗаписей.Записать();
		
	КонецЦикла
	
КонецПроцедуры	

#КонецОбласти

#КонецОбласти

#КонецЕсли