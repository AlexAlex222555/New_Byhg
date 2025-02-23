#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТекстОписания = ПолучитьОписаниеСчета(Параметры.Счет);
	ОбновитьЗаголовокФормы(ЭтаФорма, Параметры.Счет);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТекстОписанияПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	
	Позиция = СтрНайти(ДанныеСобытия.Href, "ОписаниеСчета=");
	Если Позиция > 0 Тогда
		ПредставлениеСчета = Сред(ДанныеСобытия.Href, Позиция + 14);
		Попытка
			ТекстОписания = ПолучитьОписаниеСчета(ПредставлениеСчета);
			ОбновитьЗаголовокФормы(ЭтаФорма, ПредставлениеСчета);
		Исключение
			// Запись в журнал регистрации не требуется.
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьЗаголовокФормы(Форма, Счет) 
	
	Если ЗначениеЗаполнено(Счет) Тогда
		ТекстЗаголовка = НСтр("ru='Описание счета: %1';uk='Опис рахунку: %1'");
		Форма.Заголовок = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстЗаголовка, Счет);
	Иначе
		Форма.Заголовок = НСтр("ru='Не указан счет';uk='Не вказаний рахунок'");
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьОписаниеСчета(Счет) 
	
	ТекстОписания = "";
	
	Если ТипЗнч(Счет) = Тип("Строка") Тогда
		Счет = ЗначениеИзСтрокиВнутр(Счет);
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Счет) Тогда
		Возврат ТекстОписания;
	КонецЕсли;
	
	ПланСчетов = ПланыСчетов.Хозрасчетный;
	Макет      = ПланСчетов.ПолучитьМакет("Описание");
	ИмяСчета   = ПланСчетов.ПолучитьИмяПредопределенного(Счет);
	
	Попытка
		Область = Макет.ПолучитьОбласть(ИмяСчета + "|Описание");
	Исключение
		// Запись в журнал регистрации не требуется
		Область = Макет.ПолучитьОбласть("ОписаниеНеЗадано|Описание");
	КонецПопытки;
	
	// Заголовок HTML документа
	ЗаголовокHTMLДокумента = 
	"<HTML>
	|<HEAD>
	|<STYLE>	
	|BODY {	FONT-SIZE: 10pt; FONT-FAMILY: Verdana }
	|H1 { FONT-WEIGHT: bold; FONT-SIZE: 14pt; FONT-FAMILY: Arial, Tahoma; TEXT-ALIGN: left }
	|H2 { FONT-WEIGHT: bold; FONT-SIZE: 12pt; FONT-FAMILY: Arial, Tahoma; TEXT-ALIGN: left }
	|</STYLE>
	|</HEAD>
	|";
	
	// Подвал HTML документа
	ПодвалHTMLДокумента = "
	|</HTML>";
	
	// Заголовок описания
	ТекстЗаголовка = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru='Счет %1<br>%2';uk='Рахунок %1<br>%2'"), 
		Счет.Код, 
		Счет.Наименование);
	ЗаголовокОписания = "<h1>" + ТекстЗаголовка + "</h1>";
	
	// Список ссылок на описания субсчетов
	СписокСубсчетов = "";
	Выборка = ПланСчетов.Выбрать(Счет);
	Пока Выборка.Следующий() Цикл
		Если ПустаяСтрока(СписокСубсчетов) Тогда
			УровеньСчета = Счет.Уровень();
			Если УровеньСчета > 0 Тогда
				ТекстСпискаСубсчетов = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru='К счету открыты следующие субсчета %1-го уровня:';uk='До рахунку відкриті такі субрахунки %1-го рівня:'"),
					УровеньСчета + 1);
			Иначе
				ТекстСпискаСубсчетов = НСтр("ru='К счету открыты следующие субсчета:';uk='До рахунку відкриті такі субрахунки:'");
			КонецЕсли;
			СписокСубсчетов = "<h2>" + ТекстСпискаСубсчетов + "</h2><ul>";
		КонецЕсли;
		ТекстСпискаСубсчетов = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='%1 ""%2""';uk='%1 ""%2""'"), 
			Выборка.Код, 
			Выборка.Наименование);
		СписокСубсчетов = СписокСубсчетов + "<li><a href='ОписаниеСчета=" + ЗначениеВСтрокуВнутр(Выборка.Ссылка) + "'>" 
			+ ТекстСпискаСубсчетов + "</a></li>";
	КонецЦикла;
	СписокСубсчетов = СписокСубсчетов + "</ul>";
	
	// Ссылка на описание счета-родителя
	ОписаниеРодителя = "";
	Если НЕ Счет.Родитель.Пустая() Тогда
		ТекстОписаниеРодителя = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Описание счета %1 ""%2""';uk='Опис рахунку %1 ""%2""'"), 
			Счет.Родитель.Код, 
			Счет.Родитель.Наименование);
		ОписаниеРодителя = "<p><a href='ОписаниеСчета=" + ЗначениеВСтрокуВнутр(Счет.Родитель) + "'>"
			+ ТекстОписаниеРодителя + "</a></p>";
	КонецЕсли;
	
	ТекстОписания = ЗаголовокHTMLДокумента
		+ ЗаголовокОписания 
		+ "<p>" + СтрЗаменить(Область.ТекущаяОбласть.Текст, Символы.ПС, "<p></p>") + "</p>" 
		+ СписокСубсчетов
		+ ОписаниеРодителя
		+ ПодвалHTMLДокумента;
	
	Возврат ТекстОписания;

КонецФункции

#КонецОбласти