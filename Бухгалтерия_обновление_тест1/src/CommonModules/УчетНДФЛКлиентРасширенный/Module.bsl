
#Область ПрограммныйИнтерфейс

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

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ФормаПодробнееОРасчетеНДФЛОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	Если ИмяСобытия = "ИзмененоРаспределениеИсточниковФинансирования" Тогда
		
		ЗарплатаКадрыРасширенныйКлиент.ОбработкаОповещенияИзмененияРаспределенияИсточниковФинансирования(
			Форма, ИмяСобытия, Параметр, Источник);
		
	КонецЕсли;
	
КонецПроцедуры

// Обработчики событий тч ндфл.

Процедура НДФЛПриАктивизацииСтроки(Форма) Экспорт
	
	УчетНДФЛКлиентБазовый.НДФЛПриАктивизацииСтроки(Форма);
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
	Если ОписаниеПанелиВычеты.ТабличнаяЧастьНДФЛ.ИспользуетсяФиксРасчет Тогда
		
		НДФЛТекущиеДанные = УчетНДФЛКлиентСервер.НДФЛТекущиеДанные(Форма, ОписаниеПанелиВычеты);
		ГруппаФормыПанельВычеты = Форма.Элементы.Найти(ОписаниеПанелиВычеты.ИмяГруппыФормыПанелиВычеты);
		
		Если ГруппаФормыПанельВычеты <> Неопределено
			И НДФЛТекущиеДанные <> Неопределено Тогда
			
			УстановитьДоступностьЭлементовЛичныхВычетов(Форма, НДФЛТекущиеДанные.ФиксРасчет ИЛИ НДФЛТекущиеДанные.ФиксСтрока);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура НДФЛУстановитьДоступностьЭлементовЛичныхВычетов(Форма) Экспорт
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
	Если ОписаниеПанелиВычеты.ТабличнаяЧастьНДФЛ.ИспользуетсяФиксРасчет Тогда
		
		НДФЛТекущиеДанные = УчетНДФЛКлиентСервер.НДФЛТекущиеДанные(Форма, ОписаниеПанелиВычеты);
		Если НДФЛТекущиеДанные <> Неопределено Тогда
			УстановитьДоступностьЭлементовЛичныхВычетов(Форма, НДФЛТекущиеДанные.ФиксРасчет ИЛИ НДФЛТекущиеДанные.ФиксСтрока);
		КонецЕсли; 
		
	КонецЕсли; 
	
КонецПроцедуры

Процедура НДФЛПередУдалением(Форма, НДФЛТекущиеДанные, Отказ) Экспорт
	
	НДФЛПередНачаломИзменения(Форма, НДФЛТекущиеДанные,Отказ);
	Если НЕ Отказ Тогда
		УчетНДФЛКлиентБазовый.НДФЛПередУдалением(Форма, НДФЛТекущиеДанные, Отказ);
	КонецЕсли;
	
КонецПроцедуры

Процедура НДФЛПередНачаломИзменения(Форма, НДФЛТекущиеДанные, Отказ) Экспорт
	
	НачалоРедактированияДанных = Истина;
	Если ТипЗнч(Форма.ТекущийЭлемент) = Тип("ТаблицаФормы") Тогда
		НачалоРедактированияДанных = НЕ Форма.ТекущийЭлемент.ТекущийЭлемент.ГиперссылкаЯчейки;
	КонецЕсли; 
	
	Если НачалоРедактированияДанных Тогда
		
		МассивИдентификаторовСтрокНДФЛСОшибками = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "МассивИдентификаторовСтрокНДФЛСОшибками");
		
		Если МассивИдентификаторовСтрокНДФЛСОшибками = Неопределено
			ИЛИ МассивИдентификаторовСтрокНДФЛСОшибками.Найти(НДФЛТекущиеДанные.ПолучитьИдентификатор()) = Неопределено Тогда
		
			ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
			
			Если ОписаниеПанелиВычеты.ТабличнаяЧастьНДФЛ.ИспользуетсяФиксРасчет И НЕ (НДФЛТекущиеДанные.ФиксРасчет ИЛИ НДФЛТекущиеДанные.ФиксСтрока) Тогда
				
				ТекстПредупреждения = НСтр("ru='НДФЛ рассчитан автоматически, его редактирование не рекомендуется. Редактирование следует выполнять только в том случае, если вы полностью уверены в своих действиях.';uk='ПДФО розрахований автоматично, його редагування не рекомендується. Редагування слід виконувати тільки в тому випадку, якщо ви повністю впевнені у своїх діях.'");
				ТекстЗаголовка = НСтр("ru='Конфигурация BAS';uk='Конфігурація BAS'");
				
				ПоказатьПредупреждение(, ТекстПредупреждения, , ТекстЗаголовка);
				
			КонецЕсли; 
		
		КонецЕсли; 
		
	КонецЕсли; 
	
КонецПроцедуры

Функция НеобходимоОткрытьФормуНДФЛПодробнее(Поле) Экспорт
	
	Возврат Поле.Имя = "НДФЛПредставлениеВычетовНаДетейИИмущественных"
		Или Поле.Имя = "НДФЛПредставлениеВычетовЛичных"
		Или Поле.Имя = "НДФЛПредставлениеВычетовКДоходам";
		
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

// Вспомогательные процедуры и функции.

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

Процедура УстановитьДоступностьЭлементовЛичныхВычетов(Форма, ФиксРасчет, СделатьДоступными = Ложь)
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
	ГруппаФормыПанельВычеты = Форма.Элементы.Найти(ОписаниеПанелиВычеты.ИмяГруппыФормыПанелиВычеты);
	
	Если ГруппаФормыПанельВычеты <> Неопределено Тогда
		
		Если ФиксРасчет ИЛИ СделатьДоступными Тогда
			РежимОтображениеПредупрежденияПриРедактировании = ОтображениеПредупрежденияПриРедактировании.НеОтображать;
		Иначе
			РежимОтображениеПредупрежденияПриРедактировании = ОтображениеПредупрежденияПриРедактировании.Отображать;
		КонецЕсли;
		
		Если РежимОтображениеПредупрежденияПриРедактировании <> Форма.Элементы[ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичный"].ОтображениеПредупрежденияПриРедактировании Тогда
			
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичный",
				"ОтображениеПредупрежденияПриРедактировании",
				РежимОтображениеПредупрежденияПриРедактировании);
				
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКодВычета",
				"ОтображениеПредупрежденияПриРедактировании",
				РежимОтображениеПредупрежденияПриРедактировании);
				
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКЗачетуВозврату",
				"ОтображениеПредупрежденияПриРедактировании",
				РежимОтображениеПредупрежденияПриРедактировании);
				
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Форма.Элементы,
				ГруппаФормыПанельВычеты.Имя + "ПримененныйВычетЛичныйКЗачетуВозвратуКодВычета",
				"ОтображениеПредупрежденияПриРедактировании",
				РежимОтображениеПредупрежденияПриРедактировании);
				
		КонецЕсли; 
			
	КонецЕсли; 
	
КонецПроцедуры

Процедура МожноИзменятьПримененныеВычеты(Форма, Отказ) Экспорт
	
	ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
	НДФЛТекущиеДанные = УчетНДФЛКлиентСервер.НДФЛТекущиеДанные(Форма, ОписаниеПанелиВычеты);
	НДФЛПередНачаломИзменения(Форма, НДФЛТекущиеДанные, Отказ);
	
КонецПроцедуры

Процедура УдалитьПримененныеВычеты(Форма) Экспорт
	
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

Процедура ИзменитьЛичныеВычеты(Форма) Экспорт
	
	Отказ = Ложь;
	МожноИзменятьПримененныеВычеты(Форма, Отказ);
	Если НЕ Отказ Тогда

		ОписаниеПанелиВычеты = Форма.ОписаниеПанелиВычетыНаКлиенте();
		Если ОписаниеПанелиВычеты.ТабличнаяЧастьНДФЛ.ИспользуетсяФиксРасчет Тогда
			
			НДФЛТекущиеДанные = УчетНДФЛКлиентСервер.НДФЛТекущиеДанные(Форма, ОписаниеПанелиВычеты);
			УстановитьДоступностьЭлементовЛичныхВычетов(Форма, НДФЛТекущиеДанные.ФиксРасчет, Истина);
			
		КонецЕсли; 
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ФормаПодробнееОРасчетеНДФЛНДФЛВыбор(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ОписаниеТаблицыНДФЛ, МесяцНачисления, Организация) Экспорт
	
	Если СтрНайти(Поле.Имя, "КомандаРедактированияРаспределения") = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ЗарплатаКадрыРасширенныйКлиент.ОткрытьФормуРедактированияРезультатовРаспределенияПоИсточникамФинансирования(
		Форма, ОписаниеТаблицыНДФЛ, ВыбраннаяСтрока, МесяцНачисления, Организация);
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры

Процедура ФормаПодробнееОРасчетеНДФЛПерераспределитьНДФЛ(СтрокаНДФЛ, РаботаВБюджетномУчреждении) Экспорт
	
	ОтражениеЗарплатыВБухучетеКлиентСерверРасширенный.ПерераспределитьНДФЛ(СтрокаНДФЛ, РаботаВБюджетномУчреждении);
	
КонецПроцедуры

#КонецОбласти
