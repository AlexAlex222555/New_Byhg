
#Область СлужебныеПроцедурыИФункции


// Процедура открывает общую форму, показывающую, какие вычеты были применены при расчете НДФЛ в документе.
//
// Параметры:
//	Объект					- ДанныеФормаСтруктура, основной реквизит формы документа.
//	ИмяДокумента			- Строка, имя документа.
//	Владелец				- УправляемаяФорма, элемент, в который необходимо возвратить результат оповещения.
//	ОписаниеДокумента		- Структура
//	УчитываемыеСотрудники	- СправочникСсылка.Сотрудники
//							- СправочникСсылка.ФизическиеЛица
//							- Массив
//	ОписаниеПанелиВычеты	- Структура
//
// Возвращаемое значение
//	Форма при закрытии отправляет оповещение владельцу, с которым передается содержимое ТЧ НДФЛ и
//	ПримененныеВычетыНаДетейИИмущественные.
//
Процедура ОткрытьФормуПодробнееОРасчетеНДФЛ(Объект, ИмяДокумента, Владелец, ОписаниеДокумента, УчитываемыеСотрудники, ОписаниеПанелиВычеты = Неопределено) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Организация", Объект.Организация);
	ПараметрыФормы.Вставить("СведенияОбНДФЛ", Владелец.СведенияОбНДФЛ());
	ПараметрыФормы.Вставить("ИмяДокумента",	ИмяДокумента);
	ПараметрыФормы.Вставить("МесяцНачисления", Объект[ОписаниеДокумента.МесяцНачисленияИмя]);
	ПараметрыФормы.Вставить("ОписаниеДокумента", ОписаниеДокумента);
	ПараметрыФормы.Вставить("ТолькоПросмотр", Владелец.ТолькоПросмотр);
	ПараметрыФормы.Вставить("УчитываемыеСотрудники", УчитываемыеСотрудники);
	
	Если ОписаниеПанелиВычеты <> Неопределено Тогда
		ПараметрыФормы.Вставить("ОписаниеПанелиВычеты", ОписаниеПанелиВычеты);
	КонецЕсли; 
	
	ОткрытьФорму("ОбщаяФорма.ПодробнееОРасчетеНДФЛ", ПараметрыФормы, Владелец);
	
КонецПроцедуры

#Область ПанельПримененныеВычеты

Процедура ФормаПодробнееОРасчетеНДФЛНДФЛВыбор(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ОписаниеТаблицыНДФЛ, МесяцНачисления, Организация) Экспорт
	
	УчетНДФЛКлиентВнутренний.ФормаПодробнееОРасчетеНДФЛНДФЛВыбор(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ОписаниеТаблицыНДФЛ, МесяцНачисления, Организация);
	
КонецПроцедуры

Процедура НДФЛПередНачаломИзменения(Форма, ТекущиеДанные, Отказ) Экспорт
	
	УчетНДФЛКлиентВнутренний.НДФЛПередНачаломИзменения(Форма, ТекущиеДанные, Отказ);
	
КонецПроцедуры

Процедура НДФЛПередУдалением(Форма, НДФЛТекущиеДанные, Отказ) Экспорт
	
	УчетНДФЛКлиентВнутренний.НДФЛПередУдалением(Форма, НДФЛТекущиеДанные, Отказ);
	
КонецПроцедуры

Процедура НДФЛПриАктивизацииСтроки(Форма) Экспорт
	
	УчетНДФЛКлиентВнутренний.НДФЛПриАктивизацииСтроки(Форма);
	
КонецПроцедуры

Процедура НДФЛПриНачалеРедактирования(Форма, ТекущиеДанные, НоваяСтрока, Копирование) Экспорт
	
	РасчетЗарплатыКлиент.СтрокаРасчетаПриНачалеРедактирования(Форма, "НДФЛ", ТекущиеДанные, НоваяСтрока, Копирование);
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
	
	УчетНДФЛКлиентСервер.НазначитьИдентификаторСтрокеНДФЛ(ТекущиеДанные, Форма[ОписаниеПанелиВычеты.ИмяГруппыФормыПанелиВычеты + "МаксимальныйИдентификаторСтрокиНДФЛ"], НоваяСтрока);
	
	Если Копирование ИЛИ НоваяСтрока Тогда
		НДФЛПриАктивизацииСтроки(Форма);
	КонецЕсли;
	
КонецПроцедуры

Процедура НДФЛПриОкончанииРедактирования(Форма) Экспорт
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
	ИмяГруппыФормыПанелиВычеты = ОписаниеПанелиВычеты.ИмяГруппыФормыПанелиВычеты;
	
	НДФЛТекущиеДанные = УчетНДФЛКлиентСервер.НДФЛТекущиеДанные(Форма, ОписаниеПанелиВычеты);
	
	НДФЛТекущиеДанные["ПримененныйВычетЛичный"] 						= Форма[ИмяГруппыФормыПанелиВычеты + "ПримененныйВычетЛичный"];
	НДФЛТекущиеДанные["ПримененныйВычетЛичныйКодВычета"] 				= Форма[ИмяГруппыФормыПанелиВычеты + "ПримененныйВычетЛичныйКодВычета"];
	НДФЛТекущиеДанные["ПримененныйВычетЛичныйКЗачетуВозврату"] 			= Форма[ИмяГруппыФормыПанелиВычеты + "ПримененныйВычетЛичныйКЗачетуВозврату"];
	НДФЛТекущиеДанные["ПримененныйВычетЛичныйКЗачетуВозвратуКодВычета"] = Форма[ИмяГруппыФормыПанелиВычеты + "ПримененныйВычетЛичныйКЗачетуВозвратуКодВычета"];
	
	УчетНДФЛКлиентСервер.ЗаполнитьПредставлениеВычетовЛичныхСтрокиНДФЛ(Форма, НДФЛТекущиеДанные, ОписаниеПанелиВычеты);
	Форма[ИмяГруппыФормыПанелиВычеты + "ПредставлениеВычетовЛичных"] = НДФЛТекущиеДанные.ПредставлениеВычетовЛичных;
	
	НДФЛПриАктивизацииСтроки(Форма);
	
КонецПроцедуры

Процедура НДФЛУстановитьДоступностьЭлементовЛичныхВычетов(Форма) Экспорт
	
	УчетНДФЛКлиентВнутренний.НДФЛУстановитьДоступностьЭлементовЛичныхВычетов(Форма)
	
КонецПроцедуры

Процедура ВычетыПриНачалеРедактирования(СтрокаПримененныеВычетыНаДетейИИмущественные, НоваяСтрока, СтрокаИсточникЗаполнения) Экспорт
	
	Если Не НоваяСтрока Тогда
		Возврат;
	КонецЕсли;
	
	ЗаполнитьЗначенияСвойств(СтрокаПримененныеВычетыНаДетейИИмущественные, СтрокаИсточникЗаполнения);
	
КонецПроцедуры

// Процедура реализует печать объектов, отображаемых на закладке Отчеты и Уведомления формы Отчетность.
// Параметры - (см. РегламентированнаяОтчетностьКлиентПереопределяемый.Печать) 
//	 
Процедура ПечатьДокументаОтчетности(Ссылка, ИмяМакетаДляПечати, СтандартнаяОбработка) Экспорт
КонецПроцедуры	

// Процедура реализует печать объектов, отображаемых на закладке Отчеты и Уведомления формы Отчетность.
// Параметры - (см. РегламентированнаяОтчетностьКлиентПереопределяемый.Выгрузить) 
//	 
Процедура ВыгрузитьДокументОтчетности(Ссылка) Экспорт
	
КонецПроцедуры	

// Процедура реализует печать объектов, отображаемых на закладке Отчеты и Уведомления формы Отчетность.
// Параметры - (см. РегламентированнаяОтчетностьКлиентПереопределяемый.СоздатьНовыйОбъект) 
//	 
Процедура СоздатьНовыйДокументОтчетности(Организация, Тип, СтандартнаяОбработка) Экспорт
КонецПроцедуры	

Процедура ФормаПодробнееОРасчетеНДФЛОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	УчетНДФЛКлиентВнутренний.ФормаПодробнееОРасчетеНДФЛОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

Процедура МожноИзменятьПримененныеВычеты(Форма, Отказ) Экспорт
	
	УчетНДФЛКлиентВнутренний.МожноИзменятьПримененныеВычеты(Форма, Отказ);
	
КонецПроцедуры

Функция ВычетыИзменены(Форма, ТекущиеДанные, ОтменаРедактирования) Экспорт
	
	Если Не ОтменаРедактирования
		И ТекущиеДанные <> Неопределено Тогда
		
		Если ТекущиеДанные.Свойство("КодВычета")
			И ТекущиеДанные.Свойство("КодВычетаПредыдущий") Тогда
			Если ТекущиеДанные.КодВычета <> ТекущиеДанные.КодВычетаПредыдущий Тогда
				Возврат Истина;
			КонецЕсли; 
		КонецЕсли; 
		
		Если ТекущиеДанные.Свойство("РазмерВычета")
			И ТекущиеДанные.Свойство("РазмерВычетаПредыдущий") Тогда
			Если ТекущиеДанные.РазмерВычета <> ТекущиеДанные.РазмерВычетаПредыдущий Тогда
				Возврат Истина;
			КонецЕсли; 
		КонецЕсли; 
		
		Если ТекущиеДанные.Свойство("СуммаВычета")
			И ТекущиеДанные.Свойство("СуммаВычетаПредыдущая") Тогда
			Если ТекущиеДанные.СуммаВычета <> ТекущиеДанные.СуммаВычетаПредыдущая Тогда
				Возврат Истина;
			КонецЕсли; 
		КонецЕсли; 
		
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// Обработчики событий тч вычеты.

Процедура ПримененныеВычетыНаДетейИИмущественныеПередНачаломИзменения(Форма, Элемент, Отказ) Экспорт
	
	МожноИзменятьПримененныеВычеты(Форма, Отказ);
	
	Если Не Отказ Тогда
		Элемент.ТекущиеДанные.КодВычетаПредыдущий = Элемент.ТекущиеДанные.КодВычета;
		Элемент.ТекущиеДанные.РазмерВычетаПредыдущий = Элемент.ТекущиеДанные.РазмерВычета;
	КонецЕсли; 
	
КонецПроцедуры

Процедура ПримененныеВычетыКДоходам(Форма, Элемент, Отказ) Экспорт
	
	МожноИзменятьПримененныеВычеты(Форма, Отказ);
	
	Если Не Отказ Тогда
		Элемент.ТекущиеДанные.СуммаВычетаПредыдущая = Элемент.ТекущиеДанные.СуммаВычета;
	КонецЕсли; 
	
КонецПроцедуры

Процедура ФормаПодробнееОРасчетеНДФЛПерераспределитьНДФЛ(СтрокаНДФЛ, РаботаВБюджетномУчреждении) Экспорт
	
	УчетНДФЛКлиентВнутренний.ФормаПодробнееОРасчетеНДФЛПерераспределитьНДФЛ(СтрокаНДФЛ, РаботаВБюджетномУчреждении);
	
КонецПроцедуры

#КонецОбласти

#Область ПрочиеПроцедурыИФункции

Процедура УстановитьОтборыПримененныхВычетов(Форма, НДФЛТекущиеДанные) Экспорт
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
	
	ГруппаФормыПанельВычеты = Форма.Элементы.Найти(ОписаниеПанелиВычеты.ИмяГруппыФормыПанелиВычеты);
	
	Если ГруппаФормыПанельВычеты = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	НастраиваемыеПанели = ОписаниеПанелиВычеты.НастраиваемыеПанели;
	
	ВычетыНаДетейИИмущественные = НастраиваемыеПанели.Получить("ВычетыНаДетейИИмущественные");
	Если ВычетыНаДетейИИмущественные <> Неопределено Тогда
		
		СтруктураОтбораПримененныеВычетыНаДетейИИмущественные = Новый Структура("ИдентификаторСтрокиНДФЛ");
		Если НДФЛТекущиеДанные <> Неопределено Тогда
			ЗаполнитьЗначенияСвойств(СтруктураОтбораПримененныеВычетыНаДетейИИмущественные, НДФЛТекущиеДанные);
		КонецЕсли;
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			ГруппаФормыПанельВычеты.Имя + "ВычетыНаДетейИИмущественные",
			"ОтборСтрок",
			Новый ФиксированнаяСтруктура(СтруктураОтбораПримененныеВычетыНаДетейИИмущественные));
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			ГруппаФормыПанельВычеты.Имя + "ВычетыНаДетейИИмущественные",
			"ТолькоПросмотр",
			(НДФЛТекущиеДанные = Неопределено));
		
	КонецЕсли;
	
	ВычетыКДоходам = НастраиваемыеПанели.Получить("ВычетыКДоходам");
	Если ВычетыКДоходам <> Неопределено Тогда
		
		СтруктураОтбораВычетыПримененныеКДоходам = Новый Структура("ФизическоеЛицо,Подразделение,ВычетПримененныйКДоходам");
		Если НДФЛТекущиеДанные <> Неопределено Тогда
			ЗаполнитьЗначенияСвойств(СтруктураОтбораВычетыПримененныеКДоходам, НДФЛТекущиеДанные);
			СтруктураОтбораВычетыПримененныеКДоходам.ВычетПримененныйКДоходам = Истина;
		КонецЕсли;
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			ГруппаФормыПанельВычеты.Имя + "ВычетыКДоходам",
			"ОтборСтрок",
			Новый ФиксированнаяСтруктура(СтруктураОтбораВычетыПримененныеКДоходам));
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Форма.Элементы,
			ГруппаФормыПанельВычеты.Имя + "ВычетыКДоходам",
			"ТолькоПросмотр",
			(НДФЛТекущиеДанные = Неопределено));
		
	КонецЕсли;
	
КонецПроцедуры

Процедура УдалитьПримененныеВычетыНаДетейИИмущественные(Форма) Экспорт
	
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
	
	МассивИменТаблицВычетов = Новый Массив;
	
	Если ОписаниеПанелиВычеты.НастраиваемыеПанели["ВычетыНаДетей"] <> Неопределено Тогда
		МассивИменТаблицВычетов.Добавить(ОписаниеПанелиВычеты.НастраиваемыеПанели["ВычетыНаДетей"]);
	КонецЕсли; 
	
	Если ОписаниеПанелиВычеты.НастраиваемыеПанели["ВычетыИмущественные"] <> Неопределено Тогда
		Если МассивИменТаблицВычетов.Найти(ОписаниеПанелиВычеты.НастраиваемыеПанели["ВычетыИмущественные"]) <> Неопределено Тогда
			МассивИменТаблицВычетов.Добавить(ОписаниеПанелиВычеты.НастраиваемыеПанели["ВычетыИмущественные"]);
		КонецЕсли;
	КонецЕсли;
	
	ИдентификаторУдаляемойСтрокиСтрокиНДФЛ = Форма[ОписаниеПанелиВычеты.ИмяГруппыФормыПанелиВычеты + "ИдентификаторУдаляемойСтрокиСтрокиНДФЛ"];
	Для каждого ИмяТаблицыВычетов Из МассивИменТаблицВычетов Цикл
		НайденныеСтроки = Форма.Объект[ИмяТаблицыВычетов].НайтиСтроки(Новый Структура("ИдентификаторСтрокиНДФЛ", ИдентификаторУдаляемойСтрокиСтрокиНДФЛ));
		Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			Форма.Объект[ИмяТаблицыВычетов].Удалить(НайденнаяСтрока);
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

Процедура СправкиНДФЛПриИзмененииФиксируемогоЗначения(Форма, ДанныеСправки, ПутькДанным) Экспорт
	ДанныеСправки["Фикс" + ПутькДанным] = Истина;
	УчетНДФЛКлиентСервер.СправкиНДФЛУстановитьСвойстваЭлементовСФиксациейДанных(Форма, ДанныеСправки, Форма.ДокументПроведен);
	УчетНДФЛКлиентСервер.СправкиНДФЛУстановитьИнфонадписьИсправления(Форма.ИнфоНадписьИсправления, ДанныеСправки, Форма.ДокументПроведен);
КонецПроцедуры	

Процедура СправкиНДФЛПриИзмененииУдостоверенияЛичности(Форма, ДанныеСправки) Экспорт
	СправкиНДФЛПриИзмененииФиксируемогоЗначения(Форма, ДанныеСправки, "ВидДокумента");
	СправкиНДФЛПриИзмененииФиксируемогоЗначения(Форма, ДанныеСправки, "СерияДокумента");
	СправкиНДФЛПриИзмененииФиксируемогоЗначения(Форма, ДанныеСправки, "НомерДокумента");
КонецПроцедуры	

Процедура СправкиНДФЛГражданствоПриИзменении(Форма, ДанныеСправки) Экспорт
	СправкиНДФЛПриИзмененииФиксируемогоЗначения(Форма, ДанныеСправки, "Гражданство");
	УчетНДФЛКлиентСервер.СправкиНДФЛУстановитьПризнакНаличияГражданства(Форма, ДанныеСправки);
КонецПроцедуры	

Процедура СправкиНДФЛЛицБезГражданстваПриИзменении(Форма, ДанныеСправки) Экспорт
	Если Форма.ЛицоБезГражданства = 1 Тогда
		ДанныеСправки.Гражданство = ПредопределенноеЗначение("Справочник.СтраныМира.ПустаяСсылка");
		Форма.Элементы.Гражданство.Доступность = Ложь;
	Иначе
		Форма.Элементы.Гражданство.Доступность = Истина;	
	КонецЕсли;
	
	СправкиНДФЛПриИзмененииФиксируемогоЗначения(Форма, ДанныеСправки, "Гражданство");	
КонецПроцедуры	

Процедура СправкиНДФЛУстановитьСтарыеЗначенияКонтролируемыхПолей(РедактируемыеДанные, СтарыеЗначенияКонтролируемыхПолей, КонтролируемыеПоля, Раздел) Экспорт
	КонтролируемыеПоляРаздела = КонтролируемыеПоля[Раздел];
	
	Если РедактируемыеДанные = Неопределено Тогда
		СтарыеЗначенияКонтролируемыхПолейРаздела = Новый Соответствие;
		СтарыеЗначенияКонтролируемыхПолей.Вставить(Раздел, СтарыеЗначенияКонтролируемыхПолейРаздела);
		
		Для Каждого Поле Из КонтролируемыеПоляРаздела Цикл
			СтарыеЗначенияКонтролируемыхПолейРаздела.Вставить(Поле, Неопределено);		
		КонецЦикла;		
	Иначе			
		СтарыеЗначенияКонтролируемыхПолейРаздела = СтарыеЗначенияКонтролируемыхПолей.Получить(Раздел);
		Если СтарыеЗначенияКонтролируемыхПолейРаздела = Неопределено Тогда
			СтарыеЗначенияКонтролируемыхПолейРаздела = Новый Соответствие;
			СтарыеЗначенияКонтролируемыхПолей.Вставить(Раздел, СтарыеЗначенияКонтролируемыхПолейРаздела);
		КонецЕсли;
		
		Для Каждого Поле Из КонтролируемыеПоляРаздела Цикл
			СтарыеЗначенияКонтролируемыхПолейРаздела.Вставить(Поле, РедактируемыеДанные[Поле]);		
		КонецЦикла;		
	КонецЕсли;	
КонецПроцедуры	

Процедура СправкиНДФЛПриОкончанииРедактирования(Форма, ДанныеСправки, РедактируемыеДанные, СтарыеЗначенияКонтролируемыхПолей, КонтролируемыеПоля, Раздел) Экспорт
	Если РедактируемыеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;	
	
	КонтролируемыеПоляРаздела = КонтролируемыеПоля[Раздел];	
	СтарыеЗначенияКонтролируемыхПолейРаздела = СтарыеЗначенияКонтролируемыхПолей[Раздел];
	
	Для Каждого Поле Из КонтролируемыеПоляРаздела Цикл
		Если РедактируемыеДанные[Поле] <> СтарыеЗначенияКонтролируемыхПолейРаздела[Поле] Тогда
			Если Раздел = "Уведомление" Тогда
				ДанныеСправки.ФиксУведомление = Истина	
			Иначе	
				ДанныеСправки.ФиксНалоги = Истина;
			КонецЕсли;	
		КонецЕсли;	
		СтарыеЗначенияКонтролируемыхПолейРаздела.Вставить(Поле, РедактируемыеДанные[Поле]);
	КонецЦикла;	
КонецПроцедуры	

Процедура СправкиНДФЛРегистрацияВНалоговомОрганеОткрытие(Форма, СтандартнаяОбработка) Экспорт
КонецПроцедуры	

Процедура КодДоходаПриИзменении(Форма, ГодНалоговогоПериода, ИмяТаблицы, КодДоходаИмяРеквизита, ИмяПоляКодВычета, КодВычетаИмяРеквизита, СуммаВычетаИмяРеквизита = "") Экспорт
	ДанныеТекущейСтроки = Форма.Элементы[ИмяТаблицы].ТекущиеДанные;
	КодДохода = ДанныеТекущейСтроки[КодДоходаИмяРеквизита];
	
	ОписаниеКодаДохода = УчетНДФЛКлиентПовтИсп.ПолучитьОписаниеКодаДохода(КодДохода);		
	
	СоответствиеДоступныхВычетовДоходам = УчетНДФЛКлиентПовтИсп.ВычетыКДоходам(ГодНалоговогоПериода);
	
	МассивДоступныхВычетов = СоответствиеДоступныхВычетовДоходам.Получить(КодДохода);
	
	Если МассивДоступныхВычетов <> Неопределено Тогда 
		Форма.Элементы[ИмяПоляКодВычета].СписокВыбора.ЗагрузитьЗначения(МассивДоступныхВычетов);
	КонецЕсли;	
		
	ДанныеТекущейСтроки[КодВычетаИмяРеквизита] = ОписаниеКодаДохода.ВычетПоУмолчанию;
	
	Если СуммаВычетаИмяРеквизита <> "" Тогда 
		ДанныеТекущейСтроки[СуммаВычетаИмяРеквизита] = 0;		
	КонецЕсли;
КонецПроцедуры

Процедура КодДоходаАктивацииСтроки(Форма, ГодНалоговогоПериода, ИмяТаблицы, КодДоходаИмяРеквизита, ИмяПоляКодВычета) Экспорт
	ДанныеТекущейСтроки = Форма.Элементы[ИмяТаблицы].ТекущиеДанные;
	
	Если ДанныеТекущейСтроки <> Неопределено Тогда 
		КодДохода = ДанныеТекущейСтроки[КодДоходаИмяРеквизита];
	
		СоответствиеДоступныхВычетовДоходам = УчетНДФЛКлиентПовтИсп.ВычетыКДоходам(ГодНалоговогоПериода);
		
		МассивДоступныхВычетов = СоответствиеДоступныхВычетовДоходам.Получить(КодДохода);

		Если МассивДоступныхВычетов <> Неопределено Тогда 
			Форма.Элементы[ИмяПоляКодВычета].СписокВыбора.ЗагрузитьЗначения(МассивДоступныхВычетов);
		КонецЕсли;	
	КонецЕсли;	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
