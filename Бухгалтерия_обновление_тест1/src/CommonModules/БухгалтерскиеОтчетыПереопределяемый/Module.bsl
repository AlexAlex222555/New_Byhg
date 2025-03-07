////////////////////////////////////////////////////////////////////////////////
// Функции и процедуры обеспечения формирования бухгалтерских отчетов.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Вызывается при создании формы отчета на сервере для возможности дополнительной настройки.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - Форма отчета.
//
Процедура ПриСозданииНаСервере(Форма) Экспорт

	УстановитьНастройкиПоУмолчанию(Форма);
	
	ПолеОформления = Форма.Элементы.Найти("КонтрагентДляОтбора");
	Если ПолеОформления <> Неопределено Тогда
		Если ПолучитьФункциональнуюОпцию("ИспользоватьПередачиТоваровМеждуОрганизациями") Тогда
			Если Форма.Отчет.КонтрагентДляОтбора = Неопределено Тогда
				Форма.Отчет.КонтрагентДляОтбора = Справочники.Контрагенты.ПустаяСсылка();
			КонецЕсли;
			НовыйМассив = Новый Массив();
			НовыйМассив.Добавить(Новый ПараметрВыбора("ВыборКонтрагентовИОрганизаций", Истина));
			ПолеОформления.ПараметрыВыбора = Новый ФиксированныйМассив(НовыйМассив);
 		Иначе
			ПолеОформления.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.Контрагенты");	
			ПолеОформления.ВыбиратьТип = Ложь;
		КонецЕсли;
	КонецЕсли;
	
	//++ НЕ УТ
	ДобавитьПоказателиУправленческогоУчетаИОтчетности(Форма);
	//-- НЕ УТ

КонецПроцедуры

// Вызывается при установке настроек по умолчанию для формы отчета.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - Форма отчета.
//
Процедура УстановитьНастройкиПоУмолчанию(Форма) Экспорт

	ЭлементГруппаБыстрыеОтборы = Форма.Элементы.Найти("ГруппаБыстрыеОтборы");
	Если ЭлементГруппаБыстрыеОтборы <> Неопределено Тогда
		ЭлементГруппаБыстрыеОтборы.ЦветФона = Новый Цвет();
	КонецЕсли;

КонецПроцедуры

// Выполняет установку макета оформления для отчета.
//
// Параметры:
//	ПараметрыОтчета - Структура - передается из формы отчета при запуске фонового задания отчета.
//		Может содержать ключ:
//			* МакетОформления - Строка - Название макета оформления.
//	НастройкаКомпоновкиДанных - НастройкиКомпоновкиДанных - Настройки, которые будут использоваться для отчета. 
//	СтандартнаяОбработка - Булево - Если установить внутри процедуры в Ложь, то стандартная обработка не будет выполняться.
//
Процедура УстановитьМакетОформленияОтчета(ПараметрыОтчета, НастройкаКомпоновкиДанных, СтандартнаяОбработка) Экспорт

	Если ПараметрыОтчета.Свойство("МакетОформления")
		И ЗначениеЗаполнено(ПараметрыОтчета.МакетОформления)
		И ПараметрыОтчета.МакетОформления <> "МакетОформленияОтчетовЗеленый"
		И ПараметрыОтчета.МакетОформления <> "ОформлениеОтчетовЗеленый" Тогда
		// В отчете выбран конкретный макет оформления, его не меняем.
		Возврат;
	КонецЕсли;

	СтандартнаяОбработка = Ложь;

	МакетОформления = "ОформлениеОтчетовБежевый";
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметрВывода(НастройкаКомпоновкиДанных, "МакетОформления", МакетОформления);	
	
КонецПроцедуры

//++ НЕ УТ

// Добавляет на форму отчета новые элементы формы - показатели упр. и фин. отчетности
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - Форма отчета.
//
Процедура ДобавитьПоказателиУправленческогоУчетаИОтчетности(Форма) Экспорт
	
	Если МассивФормДляДобавленияПоказателейУправленческогоУчетаИОтчетности().Найти(Форма.ИмяФормы) = Неопределено Тогда
		// Данная форма не обрабатывается, ничего не делаем.
		Возврат;
	КонецЕсли;
	
	Если Форма.Отчет.Свойство("ПоказательУУ") Тогда
		ДобавитьНовыйПоказательОтчетаНаФорму(Форма, "ПоказательУУ", "ПоказательНУ");
	КонецЕсли;	
	Если ПолучитьФункциональнуюОпцию("ВестиУУНаПланеСчетовХозрасчетный") И Форма.Отчет.Свойство("ПоказательРазницаБУиУУ") Тогда
		ДобавитьНовыйПоказательОтчетаНаФорму(Форма, "ПоказательРазницаБУиУУ", "ПоказательНУ");
	КонецЕсли;
	Если Форма.Отчет.Свойство("ПоказательФО") Тогда
		ДобавитьНовыйПоказательОтчетаНаФорму(Форма, "ПоказательФО", "ПоказательВалютнаяСумма");
	КонецЕсли;
	
КонецПроцедуры

// Вызывается перед компоновкой макета бух. отчетов, выводит информацию по валютам регл., упр. и фин. отчетности,
//	если соответствующие показатели выбраны.
//	Параметры:
//		КомпоновщикНастроек - компоновщик настроек отчета;
//		ПараметрыОтчета - Структура - см. функцию "ПодготовитьПараметрыОтчета" форм бух. отчетности.
//
Процедура УстановитьПараметрыВалют(Схема, КомпоновщикНастроек, ПараметрыОтчета) Экспорт
	
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
		КомпоновщикНастроек, "ВалютаРеглУчета",	Константы.ВалютаРегламентированногоУчета.Получить());
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
		КомпоновщикНастроек, "ВалютаУУ", Константы.ВалютаУправленческогоУчета.Получить());
	БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
		КомпоновщикНастроек, "ВалютаФО", Константы.ВалютаФинОтчетности.Получить());
	
	Показатели = Новый Структура;
	Показатели.Вставить("ПоказательБУ", Ложь);
	Показатели.Вставить("ПоказательНУ", Ложь);
	Показатели.Вставить("ПоказательВР", Ложь);
	Показатели.Вставить("ПоказательПР", Ложь);
	Показатели.Вставить("ПоказательРазницаБУиУУ", Ложь);
	Показатели.Вставить("ПоказательУУ", Ложь);
	Показатели.Вставить("ПоказательФО", Ложь);
	ЗаполнитьЗначенияСвойств(Показатели, ПараметрыОтчета);
		
	// Установим вывод параметров валют, в зависимости от выводимых показателей и функциональных опций
	ВыводятсяПоказателиРеглУчета = Макс(Показатели.ПоказательБУ, Показатели.ПоказательНУ,
		Показатели.ПоказательВР, Показатели.ПоказательПР, Показатели.ПоказательРазницаБУиУУ);
	ПараметрыОтчета.СхемаКомпоновкиДанных.Параметры.ВалютаРеглУчета.ОграничениеИспользования =
		Не ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют") И ВыводятсяПоказателиРеглУчета;
	ПараметрыОтчета.СхемаКомпоновкиДанных.Параметры.ВалютаУУ.ОграничениеИспользования =
		Не (ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют") И Показатели.ПоказательУУ);
	ПараметрыОтчета.СхемаКомпоновкиДанных.Параметры.ВалютаФО.ОграничениеИспользования =
		Не (ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют") И Показатели.ПоказательФО);
	Схема.Параметры.ВалютаРеглУчета.ОграничениеИспользования =
		Не ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют") И ВыводятсяПоказателиРеглУчета;
	Схема.Параметры.ВалютаУУ.ОграничениеИспользования =
		Не (ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют") И Показатели.ПоказательУУ);
	Схема.Параметры.ВалютаФО.ОграничениеИспользования =
		Не (ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоВалют") И Показатели.ПоказательФО);
	
КонецПроцедуры

// Вызывается после вывода результата, для корректировки фиксации сверху отчета (вывод доп. параметров влияет на высоту отчета)
//
//	Параметры:
//		Схема - СхемаКомпоновкиДанных - схема компоновки данных отчета.
//
//	Возвращаемое значение:
//		Число - число по которому будем фиксировать шапку отчета.
//
Функция ВысотаВыводимыхПараметров(Схема) Экспорт
	
	КоличествоПараметров = 0;
	
	Для каждого Параметр из Схема.Параметры Цикл
		Если Не Параметр.ОграничениеИспользования Тогда
			КоличествоПараметров = КоличествоПараметров + 1;
		КонецЕсли;
	КонецЦикла;
	
	Возврат ?(КоличествоПараметров = 0, 0, КоличествоПараметров + 2);
	
КонецФункции

// Дополняем показатели расшифровки данными по упр. и фин. отчетности.
//	Параметры:
//		НастройкиРасшифровки - Структура;
//		Отчет - ОтчетОбъект - отчет, для которого производится расшифровка;
//
Процедура ДополнитьНастройкуРасшифровкиПоказателямиУправленческогоУчетаИОтчетности(НастройкиРасшифровки, Отчет) Экспорт
	
	ПоказателиУправленческогоУчетаИОтчетности = Новый Структура("ПоказательУУ, ПоказательРазницаБУиУУ, ПоказательФО");
	ЗаполнитьЗначенияСвойств(ПоказателиУправленческогоУчетаИОтчетности, Отчет);
	Для каждого Показатель из ПоказателиУправленческогоУчетаИОтчетности Цикл
		Если Показатель.Значение <> Неопределено Тогда
			НастройкиРасшифровки.Вставить(Показатель.Ключ, Показатель.Значение);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Вызывается перед проверкой заполнения отчета, обнуляет показатели отчета, если они ранее были скрыты по ФО.
//	Параметры:
//		Отчет - ОтчетОбъект - отчет, для которого проводится проверка заполнения.
//
Процедура ПередПроверкойЗаполнения(Отчет) Экспорт
	
	СтруктураОчищаемыхПоказателей = Новый Структура;
	Если Не ПолучитьФункциональнуюОпцию("ВестиУУНаПланеСчетовХозрасчетный") Тогда
		СтруктураОчищаемыхПоказателей.Вставить("ПоказательУУ", Ложь);
	КонецЕсли;
	Если Не ПолучитьФункциональнуюОпцию("ВестиУчетНаПланеСчетовХозрасчетныйВВалютеФинОтчетности") Тогда
		СтруктураОчищаемыхПоказателей.Вставить("ПоказательФО", Ложь);
	КонецЕсли;
	Если Не ПолучитьФункциональнуюОпцию("ВалютыУпрИРеглУчетаСовпадают") ИЛИ Не ПолучитьФункциональнуюОпцию("ВестиУУНаПланеСчетовХозрасчетный") Тогда
		СтруктураОчищаемыхПоказателей.Вставить("ПоказательРазницаБУиУУ", Ложь);
	КонецЕсли;
	ЗаполнитьЗначенияСвойств(Отчет, СтруктураОчищаемыхПоказателей);
	
КонецПроцедуры

// Позволяет ограничить суммовые показатели справки-расчета.
//
// Параметры:
//   ПоддерживаемыеНаборы - см. СправкиРасчетыКлиентСервер.ВсеНаборыСуммовыхПоказателей - 
//
// Возвращаемое значение:
//   см. СправкиРасчетыКлиентСервер.ВсеНаборыСуммовыхПоказателей - 
//
Функция РазрешенныеНаборыСуммовыхПоказателей(ПоддерживаемыеНаборы) Экспорт
	
	Возврат ПоддерживаемыеНаборы;
	
КонецФункции

//-- НЕ УТ
#КонецОбласти

//++ НЕ УТ

#Область СлужебныеПроцедурыИФункции

Функция МассивФормДляДобавленияПоказателейУправленческогоУчетаИОтчетности()
	
	МассивВозврата = Новый Массив;
	МассивВозврата.Добавить("Отчет.ОборотноСальдоваяВедомость.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.ОборотноСальдоваяВедомостьПоСчету.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.АнализСубконто.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.АнализСчета.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.КарточкаСубконто.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.КарточкаСчета.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.ОборотыМеждуСубконто.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.ОборотыСчета.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.ОтчетПоПроводкам.Форма.ФормаОтчета");
	МассивВозврата.Добавить("Отчет.СводныеПроводки.Форма.ФормаОтчета");
	
	Возврат МассивВозврата;
	
КонецФункции

Процедура ДобавитьНовыйПоказательОтчетаНаФорму(Форма, ИмяПоказателя, ИмяСледующегоЭлемента = Неопределено)
	
	ЭлементПередКоторымБудемВставлятьПоказатель = Форма.Элементы.Найти(ИмяСледующегоЭлемента);
	Если ЭлементПередКоторымБудемВставлятьПоказатель = Неопределено Тогда
		// Элемент перед которым вставляем показатель не найден, будем добавлять в конец,
		// по умолчанию родительская группа - "ГруппаПоказатели".
		Родитель = Форма.Элементы.Найти("ГруппаПоказатели");
		Если Родитель = Неопределено Тогда
			// Родительская группа тоже не найдена - не добавляем показатель
			Возврат;
		КонецЕсли;
	Иначе
		Родитель = ЭлементПередКоторымБудемВставлятьПоказатель.Родитель;
	КонецЕсли;
	
	НовыйПоказатель = Форма.Элементы.Вставить(ИмяПоказателя, Тип("ПолеФормы"),
		Родитель, ЭлементПередКоторымБудемВставлятьПоказатель);
	НовыйПоказатель.ПутьКДанным = "Отчет." + ИмяПоказателя;
	НовыйПоказатель.Вид = ВидПоляФормы.ПолеФлажка;
	НовыйПоказатель.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы.Право;
	
	НовыйПоказатель.УстановитьДействие("ПриИзменении", "Подключаемый_ДополнительныеПоказателиПриИзменении");
	
КонецПроцедуры

#КонецОбласти

//-- НЕ УТ