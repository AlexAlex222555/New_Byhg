
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ПрочитатьСписокПечатныхФорм(Параметры.Ссылка, Параметры.ПечатныеФормы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	МассивПечатныхФорм = Новый Массив;
	Для Каждого ПечатнаяФорма Из ПечатныеФормыДокумента Цикл
		Если ПечатнаяФорма.Пометка Тогда
			МассивПечатныхФорм.Добавить(ПечатнаяФорма.Значение);
		КонецЕсли;
	КонецЦикла;
	
	Закрыть(МассивПечатныхФорм);
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОтмена(Команда)
	Закрыть();
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьПечатнуюФорму(Команда)
	
	ПараметрыОткрытия = ПараметрыСозданияПечатнойФормы();
	
	ОткрытьФорму("Справочник.ДополнительныеОтчетыИОбработки.ФормаОбъекта", ПараметрыОткрытия, ЭтаФорма);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПараметрыСозданияПечатнойФормы()
	
	ИмяНазначения = "Документ.ДанныеДляРасчетаЗарплаты";
	
	Назначение = Новый Соответствие;
	Назначение.Вставить(ИмяНазначения, Новый Структура("ОбъектНазначения", ОбщегоНазначения.ИдентификаторОбъектаМетаданных(ИмяНазначения)));
	
	ПараметрыОткрытия = Новый Структура;
	ПараметрыОткрытия.Вставить("ЗначенияЗаполнения", Новый Структура("Назначение", Назначение));
	
	Возврат ПараметрыОткрытия;
	
КонецФункции

&НаСервере
Процедура ПрочитатьСписокПечатныхФорм(Ссылка, ПечатныеФормы)
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("ПечатныеФормы", ПечатныеФормы);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	СправочникДополнительныеОтчетыИОбработки.Ссылка КАК ПечатнаяФорма,
	|	ВЫБОР
	|		КОГДА СправочникДополнительныеОтчетыИОбработки.Ссылка В (&ПечатныеФормы)
	|			ТОГДА ИСТИНА
	|		ИНАЧЕ ЛОЖЬ
	|	КОНЕЦ КАК Пометка
	|ИЗ
	|	Справочник.ДополнительныеОтчетыИОбработки.Назначение КАК СправочникДополнительныеОтчетыИОбработки
	|ГДЕ
	|	СправочникДополнительныеОтчетыИОбработки.Ссылка.Вид = ЗНАЧЕНИЕ(Перечисление.ВидыДополнительныхОтчетовИОбработок.ПечатнаяФорма)
	|	И СправочникДополнительныеОтчетыИОбработки.ОбъектНазначения.ПолноеИмя = ""Документ.ДанныеДляРасчетаЗарплаты""
	|	И СправочникДополнительныеОтчетыИОбработки.Ссылка.Публикация = ЗНАЧЕНИЕ(Перечисление.ВариантыПубликацииДополнительныхОтчетовИОбработок.Используется)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ПечатныеФормыДокумента.Очистить();
	
	Пока Выборка.Следующий() Цикл
		ПечатныеФормыДокумента.Добавить(Выборка.ПечатнаяФорма, , Выборка.Пометка);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
