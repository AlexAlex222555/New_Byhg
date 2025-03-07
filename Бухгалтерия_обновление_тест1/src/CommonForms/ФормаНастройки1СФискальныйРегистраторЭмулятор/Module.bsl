
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Параметры.Свойство("Идентификатор", Идентификатор);
	Заголовок = НСтр("ru='ФР';uk='ФР'") + " """ + Строка(Идентификатор) + """";

	времНомерСекции = Неопределено;
	времКодСимволаЧастичногоОтреза = Неопределено;
	времМодель      = Неопределено;
	времТаблицаСоответствий        = Неопределено;


	Параметры.ПараметрыОборудования.Свойство("НомерСекции"               , времНомерСекции);
	Параметры.ПараметрыОборудования.Свойство("КодСимволаЧастичногоОтреза", времКодСимволаЧастичногоОтреза);
	Параметры.ПараметрыОборудования.Свойство("Модель"                    , времМодель);
	Параметры.ПараметрыОборудования.Свойство("ТаблицаСоответствийНалоговыхГрупп", времТаблицаСоответствий);

	НомерСекции                = ?(времНомерСекции                = Неопределено, 0, времНомерСекции);
	КодСимволаЧастичногоОтреза = ?(времКодСимволаЧастичногоОтреза = Неопределено, 22, времКодСимволаЧастичногоОтреза);
	Модель                     = ?(времМодель                     = Неопределено, Элементы.Модель.СписокВыбора[0], времМодель);

	ЗаполнитьТаблицуСоответствийИзПараметров(времТаблицаСоответствий);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)

	ОбновитьИнформациюОДрайвере();

КонецПроцедуры

// Процедура представляет обработчик события "Нажатие" кнопки
// "ОК" командной панели "ОсновныеДействияФормы".
//
// Параметры:
//  Кнопка - <КнопкаКоманднойПанели>
//         - Кнопка, с которой связано данное событие (кнопка "ОК").
//
&НаКлиенте
Процедура ЗаписатьИЗакрытьВыполнить()

	НовыеЗначениеПараметров = Новый Структура;
	НовыеЗначениеПараметров.Вставить("Модель"         	   		 		, Модель);
	НовыеЗначениеПараметров.Вставить("КодСимволаЧастичногоОтреза"		, КодСимволаЧастичногоОтреза);
	НовыеЗначениеПараметров.Вставить("ТаблицаСоответствийНалоговыхГрупп", ПолучитьПараметрыИзТаблицыСоответствий());
	
	Результат = Новый Структура;
	Результат.Вставить("Идентификатор", Идентификатор);
	Результат.Вставить("ПараметрыОборудования", НовыеЗначениеПараметров);
	
	Закрыть(Результат);

КонецПроцедуры // ОсновныеДействияФормыОК()

&НаКлиенте
Процедура ОбновитьИнформациюОДрайвере()

	Драйвер = НСтр("ru='Не требуется';uk='Не потрібно'");
	Версия  = НСтр("ru='Не определена';uk='Не визначена'");

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуСоответствийИзПараметров(ТаблицаСоответствийИзПараметров = Неопределено)
	
	ТаблицаСоответствий.Очистить();
	
	Если ТаблицаСоответствийИзПараметров = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для каждого Элемент Из ТаблицаСоответствийИзПараметров Цикл
		
		Строка = ТаблицаСоответствий.Добавить();
		
		Строка.НалоговаяГруппаРРО = Элемент[0];     
		Строка.СтавкаНДС          = НДСОбщегоНазначенияКлиентСервер.ПолучитьПоСтрокеСтавкуНДС(Элемент[1]);
		Строка.ПодакцизныйТовар   = Элемент[2];
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПараметрыИзТаблицыСоответствий()
	
	Результат = Новый Массив;
	
	Для каждого Строка Из ТаблицаСоответствий Цикл
		
		Элемент = Новый Массив(3);
		
		Элемент[0] = Строка.НалоговаяГруппаРРО;           
		Элемент[1] = НДСОбщегоНазначенияКлиентСервер.ПолучитьСтавкуНДССтрокой(Строка.СтавкаНДС);
		Элемент[2] = Строка.ПодакцизныйТовар;
		
		Результат.Добавить(Элемент);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

