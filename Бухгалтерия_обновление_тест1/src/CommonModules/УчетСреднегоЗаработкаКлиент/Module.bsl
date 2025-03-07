////////////////////////////////////////////////////////////////////////////////
// Подсистема «Учет среднего заработка».
// 
// Клиентские процедуры и функции.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Процедура предназначена для обработки команды расшифровки значения показателя 
// среднего заработка в форме расчетного документа.
//
// Параметры:
//	- Форма - форма документа
//	- ОписаниеТаблицы - структура с описанием таблиц документа.
//	- Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка -
//		 	параметры обработчика выбора таблицы формы.
//	- ПересчитыватьСотрудника - булево, признак для определения необходимости 
//			пересчитывать результат по сотруднику после выполнения расшифровки.
//
Процедура РасшифровкаЗначенияПоказателяСреднегоЗаработка(Форма, ОписаниеТаблицы, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ПересчитыватьСотрудника = Ложь, ОповещениеЗавершения = Неопределено) Экспорт
	
	ДанныеСтроки = Элемент.ТекущиеДанные;
	
	Если СтрНайти(Поле.Имя, "КомандаРасшифровки") = 0 Тогда
		// Это не поле команды расшифровки.
		Если ОповещениеЗавершения <> Неопределено Тогда
			Результат = Новый Структура("ПересчитыватьСотрудника, СтандартнаяОбработка", ПересчитыватьСотрудника, СтандартнаяОбработка);
			ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Результат);
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	// Если для таблицы контролируется заполнение значений показателей,
	// и если значения интерактивно изменялись - то форму нужно открыть только для просмотр.
	ИспользуетсяФиксЗаполнение = ДанныеСтроки.Свойство("ФиксЗаполнение");
	ТолькоПросмотрСреднегоЗаработка = ИспользуетсяФиксЗаполнение И ДанныеСтроки["ФиксЗаполнение"];
	
	// Получаем шаблон для последующего доступа к полям показателя.
	ИмяПоляШаблон = СтрЗаменить(Сред(Поле.Имя, СтрНайти(Поле.Имя, "КомандаРасшифровки")), "КомандаРасшифровки", "%1");
	
	// Проверяем, что это расшифровка показателя среднего заработка.
	Показатель = ДанныеСтроки[СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ИмяПоляШаблон, "Показатель")];
	ПоказателиСреднийЗаработокОбщий	= УчетСреднегоЗаработкаКлиентСервер.ПоказателиОбщегоСреднегоЗаработка();
	ПоказательСреднийЗаработокФСС	= ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.СреднийЗаработокФСС");
	Если ПоказателиСреднийЗаработокОбщий.Найти(Показатель) = Неопределено И Показатель <> ПоказательСреднийЗаработокФСС Тогда
		Если ОповещениеЗавершения <> Неопределено Тогда
			Результат = Новый Структура("ПересчитыватьСотрудника, СтандартнаяОбработка", ПересчитыватьСотрудника, СтандартнаяОбработка);
			ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Результат);
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	ИмяПоляЗначения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ИмяПоляШаблон, "Значение");
	СреднийЗаработок = ДанныеСтроки[ИмяПоляЗначения];
	
	// Для документов, у которых дата, начисление, время в часах не содержатся в табличной части.
	ДатаНачала = ?(ДанныеСтроки.Свойство("ДатаНачала"), ДанныеСтроки["ДатаНачала"], Форма.Объект[ОписаниеТаблицы.ИмяРеквизитаПериод]);
	Начисление = ?(ДанныеСтроки.Свойство("Начисление"), ДанныеСтроки["Начисление"], Форма.Объект[ОписаниеТаблицы.ИмяРеквизитаВидРасчета]);
	// Определяется признак того, что время измеряется в часах.
	ВремяВЧасах = Ложь;
	Если ДанныеСтроки.Свойство("ВремяВЧасах") Тогда 
		ВремяВЧасах = ДанныеСтроки["ВремяВЧасах"];
	Иначе
		Если Показатель = ОбщегоНазначенияКлиентСервер.ПредопределенныйЭлемент("Справочник.ПоказателиРасчетаЗарплаты.СреднечасовойЗаработок") Тогда
			ВремяВЧасах = Истина;
		КонецЕсли;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Форма", Форма);
	ДополнительныеПараметры.Вставить("ОписаниеТаблицы", ОписаниеТаблицы);
	ДополнительныеПараметры.Вставить("ДанныеСтроки", ДанныеСтроки);
	ДополнительныеПараметры.Вставить("ИмяПоляЗначения", ИмяПоляЗначения);
	ДополнительныеПараметры.Вставить("ПересчитыватьСотрудника", ПересчитыватьСотрудника);
	ДополнительныеПараметры.Вставить("ИспользуетсяФиксЗаполнение", ИспользуетсяФиксЗаполнение);
	ДополнительныеПараметры.Вставить("ТолькоПросмотрСреднегоЗаработка", ТолькоПросмотрСреднегоЗаработка);
	ДополнительныеПараметры.Вставить("ОповещениеЗавершения", ОповещениеЗавершения);
	
	Оповещение = Новый ОписаниеОповещения("РасшифровкаЗначенияПоказателяСреднегоЗаработкаЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	// открываем форму
	Если ПоказателиСреднийЗаработокОбщий.Найти(Показатель) <> Неопределено Тогда
		ПараметрыРедактирования = УчетСреднегоЗаработкаКлиентСервер.ПараметрыРедактированияОбщегоСреднегоЗаработкаПоДокументу();
		ПараметрыРедактирования.Сотрудник = ДанныеСтроки["Сотрудник"];
		ПараметрыРедактирования.Организация = Форма.Объект.Организация;
		ПараметрыРедактирования.ДатаНачалаСобытия = ДатаНачала;
		ПараметрыРедактирования.ТолькоПросмотр = ТолькоПросмотрСреднегоЗаработка;
		// Период расчет среднего не заполняем, он будет определен в самой форме.
		ПараметрыРедактирования.ПорядокРасчета = УчетСреднегоЗаработкаКлиентСервер.ПорядокРасчетаОбщегоСреднегоЗаработка(ДатаНачала);
		ПараметрыРедактирования.ЭтоСреднеЧасовойЗаработок = ВремяВЧасах;
		ОткрытьФормуВводаСреднегоЗаработкаОбщий(ПараметрыРедактирования, Форма, Оповещение);
	ИначеЕсли Показатель = ПоказательСреднийЗаработокФСС Тогда
		ПараметрыРедактирования = УчетПособийСоциальногоСтрахованияКлиентСервер.ПараметрыРедактированияСреднегоЗаработкаФССПоДокументу();
		ПараметрыРедактирования.Сотрудник = ДанныеСтроки["Сотрудник"];
		ПараметрыРедактирования.Организация = Форма.Объект.Организация;
		ПараметрыРедактирования.ДатаНачалаСобытия = ДатаНачала;
		ПараметрыРедактирования.ТолькоПросмотр = ТолькоПросмотрСреднегоЗаработка;
		
		ПериодРасчета = УчетПособийСоциальногоСтрахованияКлиентСервер.ПериодРасчетаСреднегоЗаработкаФСС(ДатаНачала);
		ПараметрыРедактирования.НачалоПериодаРасчета = ПериодРасчета.ДатаНачала;
		ПараметрыРедактирования.ОкончаниеПериодаРасчета = ПериодРасчета.ДатаОкончания; 
		ПараметрыРедактирования.ПорядокРасчета = УчетПособийСоциальногоСтрахованияКлиентСервер.ПорядокРасчетаСреднегоЗаработкаФСС(ДатаНачала);
		ОткрытьФормуВводаСреднегоЗаработкаФСС(ПараметрыРедактирования, Форма, Оповещение);
	КонецЕсли;
	
	// команда выполнена
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

Процедура РасшифровкаЗначенияПоказателяСреднегоЗаработкаЗавершение(РезультатРедактирования, ДополнительныеПараметры) Экспорт

	Форма = ДополнительныеПараметры.Форма;
	ОписаниеТаблицы = ДополнительныеПараметры.ОписаниеТаблицы;
	ДанныеСтроки = ДополнительныеПараметры.ДанныеСтроки;
	ИмяПоляЗначения = ДополнительныеПараметры.ИмяПоляЗначения;
	ПересчитыватьСотрудника = ДополнительныеПараметры.ПересчитыватьСотрудника;
	ИспользуетсяФиксЗаполнение = ДополнительныеПараметры.ИспользуетсяФиксЗаполнение;
	ТолькоПросмотрСреднегоЗаработка = ДополнительныеПараметры.ТолькоПросмотрСреднегоЗаработка;
	ОповещениеЗавершения = ДополнительныеПараметры.ОповещениеЗавершения;
	
	СреднийЗаработок = ДанныеСтроки[ИмяПоляЗначения];
	Если РезультатРедактирования <> Неопределено Тогда
		// Получаем значение показателя средний заработок.
		СреднийЗаработок = РезультатРедактирования.СреднийЗаработок;
	КонецЕсли;
	
	// Поместить значение в ячейку со значением.
	Если ДанныеСтроки[ИмяПоляЗначения] <> СреднийЗаработок Тогда
		ДанныеСтроки[ИмяПоляЗначения] = СреднийЗаработок;
		ПересчитыватьСотрудника = Истина;
	КонецЕсли;
	
	Если ИспользуетсяФиксЗаполнение 
		И Не ТолькоПросмотрСреднегоЗаработка Тогда
		// Подменим прежнее значения, чтобы отличить изменение показателя среднего заработка
		// от интерактивного изменения показателей.
		СтарыеЗначенияКонтролируемыхПолей = Форма.ПолучитьСтарыеЗначенияКонтролируемыхПолей();
		СтарыеЗначенияКонтролируемыхПолей[ОписаниеТаблицы.ИмяТаблицы + ИмяПоляЗначения] = СреднийЗаработок;
	КонецЕсли;
	
	Если ОповещениеЗавершения <> Неопределено Тогда
		Результат = Новый Структура("ПересчитыватьСотрудника, СтандартнаяОбработка", ПересчитыватьСотрудника, Ложь);
		ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Результат);
	КонецЕсли;
	
КонецПроцедуры

#Область ПроцедурыИФункцииКалькулятораСреднегоЗаработка

// Открывает форму ручного ввода данных общего среднего заработка.
// 
Процедура ОткрытьФормуВводаСреднегоЗаработкаОбщий(ПараметрыРедактирования, ВладелецФормы, ОповещениеЗавершения = Неопределено) Экспорт
												 
	Если Не ПараметрыЗаполненыКорректно(ПараметрыРедактирования) Тогда
		Если ОповещениеЗавершения <> Неопределено Тогда 
			ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Неопределено);
		КонецЕсли;	
	КонецЕсли;	
	
	ОткрытьФорму("ОбщаяФорма.ВводДанныхДляРасчетаСреднегоЗаработкаОбщий", ПараметрыРедактирования, ВладелецФормы, , , , ОповещениеЗавершения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

// Процедура открывает форму ручного ввода данных среднего заработка ФСС.
// 
Процедура ОткрытьФормуВводаСреднегоЗаработкаФСС(ПараметрыРедактирования, ВладелецФормы, ОповещениеЗавершения = Неопределено) Экспорт
	
	Если Не ПараметрыЗаполненыКорректно(ПараметрыРедактирования) Тогда
		Если ОповещениеЗавершения <> Неопределено Тогда 
			ВыполнитьОбработкуОповещения(ОповещениеЗавершения, Неопределено);
		КонецЕсли;	
	КонецЕсли;	
	
	ОткрытьФорму("ОбщаяФорма.ВводДанныхДляРасчетаСреднегоЗаработкаФСС", ПараметрыРедактирования, ВладелецФормы, , , , ОповещениеЗавершения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПараметрыЗаполненыКорректно(ПараметрыРедактирования)
	
	Если Не ЗначениеЗаполнено(ПараметрыРедактирования.Сотрудник) Тогда
		ПоказатьПредупреждение(, НСтр("ru='Сотрудник не указан.';uk='Співробітника не вказано.'"));
		Возврат Ложь;
	КонецЕсли;	
	
	Возврат Истина;
	
КонецФункции

Функция ПоказатьПричиныПерерасчетаСреднегоЗаработка(ДокументСреднегоЗаработка, СтандартнаяОбработка, НавигационнаяСсылка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Если НавигационнаяСсылка = "Подробнее" Тогда
		
		СтруктураОтбора = Новый Структура("ДокументСреднегоЗаработка", ДокументСреднегоЗаработка);
		
		ПараметрыОткрытия = Новый Структура("Отбор", СтруктураОтбора);
		
		ОткрытьФорму("РегистрСведений.ПерерасчетСреднегоЗаработка.ФормаСписка", ПараметрыОткрытия, ЭтотОбъект, Истина
			, , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
			
	КонецЕсли;
	
КонецФункции

#КонецОбласти
