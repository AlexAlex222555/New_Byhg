
#Область ПрограммныйИнтерфейс

// Обработчик двойного щелчка мыши, нажатия клавиши Enter или гиперссылки в табличном документе формы отчета.
//
// См. ОтчетыКлиентПереопределяемый.ОбработкаВыбораТабличногоДокумента()
//
Процедура ОбработкаВыбораТабличногоДокумента(ФормаОтчета, Элемент, Область, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Обработчик расшифровки табличного документа формы отчета.
//
// См. ОтчетыКлиентПереопределяемый.ОбработкаВыбораТабличногоДокумента()
//
Процедура ОбработкаРасшифровки(ФормаОтчета, Элемент, Расшифровка, СтандартнаяОбработка) Экспорт
	
	//++ Локализация
	//++ НЕ БЗК

	//++ НЕ УТ
	РеглУчетКлиент.ОбработкаРасшифровки(ФормаОтчета, Элемент, Расшифровка, СтандартнаяОбработка);
	//-- НЕ УТ
	
	ПолноеИмяОтчета = ФормаОтчета.НастройкиОтчета.ПолноеИмя;
	КлючТекущегоВарианта = ФормаОтчета.КлючТекущегоВарианта;
	//++ НЕ УТ
	Если ПолноеИмяОтчета = "Отчет.ДвижениеМатериаловПолуфабрикатовРаботВПроизводстве" Тогда
		
		МенюОтчетов  = Новый Массив;
		МенюДействий = Новый Массив;
		
		Если КлючТекущегоВарианта = "ДвижениеМатериаловПолуфабрикатовРаботВПроизводстве"
			ИЛИ КлючТекущегоВарианта = "ДвижениеМатериаловПолуфабрикатовРаботВПроизводствеКонтекст" Тогда
			
			// Расшифровать отчетом -> Поступление материалов в производство (расшифровка)
			#Область РасшифровкаПоступлениеМатериаловВПроизводство
			ПараметрыОтчета = Новый Структура;
			ПараметрыОтчета.Вставить("Имя", "РасшифровкаПоступлениеМатериаловВПроизводство");
			ПараметрыОтчета.Вставить("Заголовок", НСтр("ru='Поступление материалов в производство';uk='Надходження матеріалів у виробництво'"));
			ПараметрыОтчета.Вставить("ИмяОтчета", "Отчет.РасшифровкаПоступлениеМатериаловВПроизводство");
			
			ПоляРасшифровки  = Новый Массив;
			ПоляРасшифровки.Добавить("Организация");
			ПоляРасшифровки.Добавить("Подразделение");
			ПоляРасшифровки.Добавить("Номенклатура");
			ПоляРасшифровки.Добавить("Характеристика");
			ПоляРасшифровки.Добавить("Серия");
			ПоляРасшифровки.Добавить("Назначение");
			ПараметрыОтчета.Вставить("ПоляРасшифровки", ПоляРасшифровки);
			
			НеобходимыеПараметры = Новый Структура;
			НеобходимыеПараметры.Вставить("Подразделение");
			НеобходимыеПараметры.Вставить("Номенклатура");
			ПараметрыОтчета.Вставить("НеобходимыеПараметры", НеобходимыеПараметры);
			
			СписокПараметров = Новый Массив;
			СписокПараметров.Добавить("Период");
			СписокПараметров.Добавить("Организация");
			ПараметрыОтчета.Вставить("СписокПараметров", СписокПараметров);
			
			МенюОтчетов.Добавить(ПараметрыОтчета);
			#КонецОбласти
			
			// Расшифровать отчетом -> Расходы на производство
			#Область РасшифровкаРасходовНаПроизводство
			ПараметрыОтчета = Новый Структура;
			ПараметрыОтчета.Вставить("Имя", "РасшифровкаРасходовНаПроизводство2КА");
			ПараметрыОтчета.Вставить("Заголовок", НСтр("ru='Расходы на производство';uk='Витрати на виробництво'"));
			ПараметрыОтчета.Вставить("ИмяОтчета", "Отчет.РасшифровкаРасходовНаПроизводство");
			
			ПоляРасшифровки  = Новый Массив;
			ПоляРасшифровки.Добавить("Организация");
			ПоляРасшифровки.Добавить("Подразделение");
			ПоляРасшифровки.Добавить("Номенклатура");
			ПоляРасшифровки.Добавить("Характеристика");
			ПоляРасшифровки.Добавить("Назначение");
			ПараметрыОтчета.Вставить("ПоляРасшифровки", ПоляРасшифровки);
			
			НеобходимыеПараметры = Новый Структура;
			НеобходимыеПараметры.Вставить("Подразделение");
			НеобходимыеПараметры.Вставить("Номенклатура");
			ПараметрыОтчета.Вставить("НеобходимыеПараметры", НеобходимыеПараметры);
			
			СписокПараметров = Новый Массив;
			СписокПараметров.Добавить("Период");
			СписокПараметров.Добавить("Организация");
			ПараметрыОтчета.Вставить("СписокПараметров", СписокПараметров);
			
			МенюОтчетов.Добавить(ПараметрыОтчета);
			#КонецОбласти
			
		КонецЕсли;
		
		ПараметрыРасшифровки = Новый Структура;
		ПараметрыРасшифровки.Вставить("МенюОтчетов",  МенюОтчетов);
		ПараметрыРасшифровки.Вставить("МенюДействий", МенюДействий);
		ПараметрыРасшифровки.Вставить("Расшифровка",  Расшифровка);
		
		КомпоновкаДанныхКлиент.ОбработкаРасшифровкиСДополнительнымМеню(ФормаОтчета, ПараметрыРасшифровки, СтандартнаяОбработка);
		
		
	ИначеЕсли ПолноеИмяОтчета = "Отчет.СверкаРасчетовСПартнерами" Тогда
		СтандартнаяОбработка  = Ложь;
		
	КонецЕсли;
	//-- НЕ УТ
    //-- НЕ БЗК
	//-- Локализация
	
КонецПроцедуры

// Обработчик дополнительной расшифровки (меню табличного документа формы отчета).
//
// Параметры:
//   см. ОтчетыКлиентПереопределяемый.ОбработкаДополнительнойРасшифровки().
//
Процедура ОбработкаДополнительнойРасшифровки(ЭтаФорма, Элемент, Расшифровка, СтандартнаяОбработка) Экспорт
	
	ПолноеИмяОтчета = ЭтаФорма.НастройкиОтчета.ПолноеИмя;
	КлючТекущегоВарианта = ЭтаФорма.КлючТекущегоВарианта;
	
	Если ПолноеИмяОтчета = "Отчет.СверкаРасчетовСПартнерами" Тогда
		СтандартнаяОбработка  = Ложь;
	КонецЕсли;

КонецПроцедуры

// Обработчик команд, добавленных динамически и подключенных к обработчику "Подключаемый_Команда".
// Пример добавления команды см. ОтчетыПереопределяемый.ПриСозданииНаСервере().
//
// Параметры:
//   ФормаОтчета - ФормаКлиентскогоПриложения - Форма отчета.
//   Команда     - КомандаФормы     - Команда, которая была вызвана.
//   Результат   - Булево           - Истина, если вызов команды обработан.
//
Процедура ОбработчикКоманды(ФормаОтчета, Команда, Результат) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

//++ Локализация
#Область МенюОтчеты

//++ НЕ БЗК

#Область СверкаРасчетовСПартнерами

Функция СверкаРасчетовСПартнерами(СсылкаНаОбъект, ПараметрыВыполнения) Экспорт
	
	Если ТипЗнч(СсылкаНаОбъект) <> Тип("Массив") Тогда
		МассивДокументов = Новый Массив();
		МассивДокументов.Добавить(СсылкаНаОбъект);
	Иначе
		МассивДокументов = СсылкаНаОбъект;
	КонецЕсли; 
	
	ОписаниеОповещения = Новый ОписаниеОповещения("СверкаРасчетовСПартнерамиЗавершение", ЭтотОбъект);
	
	УправлениеПечатьюКлиент.ПроверитьПроведенностьДокументов(ОписаниеОповещения, МассивДокументов);
	
КонецФункции

Процедура СверкаРасчетовСПартнерамиЗавершение(МассивДокументов, ДополнительныеПараметры) Экспорт
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Отбор", Новый Структура("СверкаВзаиморасчетов", МассивДокументов));
	ПараметрыФормы.Вставить("КлючНазначенияИспользования", "СверкаВзаиморасчетов");
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	ПараметрыФормы.Вставить("ВидимостьКомандВариантовОтчетов", Ложь);
	ПараметрыФормы.Вставить("КлючВарианта", "СверкаРасчетовСПартнерамиКонтекст");
		
	ОткрытьФорму("Отчет.СверкаРасчетовСПартнерами.Форма", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти

//-- НЕ БЗК

#КонецОбласти
//-- Локализация
#КонецОбласти