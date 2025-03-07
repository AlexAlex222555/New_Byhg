                                            
///////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

// Функция возвращает возможность работы модуля в асинхронном режиме.
// Стандартные команды модуля:
// - ПодключитьУстройство
// - ОтключитьУстройство
// - ВыполнитьКоманду
// Команды модуля для работы асинхронном режиме (должны быть определены):
// - НачатьПодключениеУстройства
// - НачатьОтключениеУстройства
// - НачатьВыполнениеКоманды
//
Функция ПоддержкаАсинхронногоРежима() Экспорт
	
	Возврат Ложь;
	
КонецФункции

// Функция осуществляет подключение устройства.
//
// Параметры:
//  ОбъектДрайвера   - <*>
//           - ОбъектДрайвера драйвера торгового оборудования.
//
// Возвращаемое значение:
//  <Булево> - Результат работы функции.
//
Функция ПодключитьУстройство(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры) Экспорт

	Результат = Истина;
	ВыходныеПараметры = Новый Массив();
	ПараметрыПодключения.Вставить("ИДУстройства", Неопределено);
	
											   
	Если Результат Тогда
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.Подключить(ОбъектДрайвера, Параметры);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		КонецЕсли;
	КонецЕсли;

	Возврат Результат;

КонецФункции

// Функция осуществляет отключение устройства.
//
// Параметры:
//  ОбъектДрайвера - <*>
//         - ОбъектДрайвера драйвера торгового оборудования.
//
// Возвращаемое значение:
//  <Булево> - Результат работы функции.
//
Функция ОтключитьУстройство(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры) Экспорт

	Результат = Истина;

	ВыходныеПараметры = Новый Массив();

	ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.Отключить(ОбъектДрайвера);

	Возврат Результат;

КонецФункции

// Функция получает, обрабатывает и перенаправляет на исполнение команду к драйверу
//
Функция ВыполнитьКоманду(Команда, ВходныеПараметры = Неопределено, ВыходныеПараметры = Неопределено,
                         ОбъектДрайвера, Параметры, ПараметрыПодключения) Экспорт
	
	Результат = Истина;
	
	ВыходныеПараметры = Новый Массив();
	
	// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩИЕ ДЛЯ ВСЕХ ТИПОВ ДРАЙВЕРОВ
	
	// Тестирование устройства
	Если Команда = "ТестУстройства" ИЛИ Команда = "CheckHealth" Тогда
		Результат = ТестУстройства(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
		
	// Получение версии драйвера
	ИначеЕсли Команда = "ПолучитьВерсиюДрайвера" ИЛИ Команда = "GetVersion" Тогда
		Результат = ПолучитьВерсиюДрайвера(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Получение описание драйвера
	ИначеЕсли Команда = "ПолучитьОписаниеДрайвера" ИЛИ Команда = "GetDescription" Тогда
		Результат = ПолучитьОписаниеДрайвера(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩИЕ ДЛЯ РАБОТЫ С ФИСКАЛЬНЫМИ РЕГИСТРАТОРАМИ
	
	// Открыть смену
	ИначеЕсли Команда = "OpenShift" ИЛИ Команда = "ОткрытьСмену" Тогда
		Результат = ОткрытьСмену(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
	ИначеЕсли Команда = "CloseShift" ИЛИ Команда = "ЗакрытьСмену" Тогда
		Результат = НапечататьОтчетСГашением(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Печать отчета без гашения
	ИначеЕсли Команда = "PrintXReport" ИЛИ Команда = "НапечататьОтчетБезГашения" Тогда
		Результат = НапечататьОтчетБезГашения(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Печать отчета с гашением
	ИначеЕсли Команда = "PrintZReport" ИЛИ Команда = "НапечататьОтчетСГашением" Тогда
		Результат = НапечататьОтчетСГашением(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Печать чека
	ИначеЕсли Команда = "PrintReceipt" ИЛИ Команда = "ПечатьЧека" Тогда
		Результат = ПечатьЧека(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры);
		
		
	// Печать слип чека
	ИначеЕсли Команда = "PrintText" ИЛИ Команда = "ПечатьТекста"  Тогда
		СтрокаТекста = ВходныеПараметры[0];
		Результат = ПечатьТекста(ОбъектДрайвера, Параметры, ПараметрыПодключения,
		                         СтрокаТекста, ВыходныеПараметры);
	// Отменить открытый чек
	ИначеЕсли Команда = "OpenCheck" ИЛИ Команда = "ОткрытьЧек"  Тогда
		ЧекВозврата   = ВходныеПараметры[0];
		ФискальныйЧек = ВходныеПараметры[1];
		Результат = ОткрытьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ЧекВозврата, ФискальныйЧек, ВыходныеПараметры);
		
	// Отменить открытый чек
	ИначеЕсли Команда = "CancelCheck" ИЛИ Команда = "ОтменитьЧек"  Тогда
		Результат = ОтменитьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Печать чека внесения/выемки
	ИначеЕсли Команда = "Encash" ИЛИ Команда = "Инкассация" Тогда
		ТипИнкассации  = ?(ВходныеПараметры.Свойство("ТипИнкассации"), ВходныеПараметры.ТипИнкассации, 0);  
		Сумма          = ?(ВходныеПараметры.Свойство("Сумма"), ВходныеПараметры.Сумма, 0); 
		Результат = Инкассация(ОбъектДрайвера, Параметры, ПараметрыПодключения, ТипИнкассации, Сумма, ВыходныеПараметры);
		
	ИначеЕсли Команда = "PrintBarCode" ИЛИ Команда = "ПечатьШтрихкода" Тогда
		ТипШтрихКода2 = ВходныеПараметры[0];
		ШтрихКод     = ВходныеПараметры[1];
		Результат = ПечатьШтрихкода(ОбъектДрайвера, Параметры, ПараметрыПодключения, ТипШтрихКода2, ШтрихКод, ВыходныеПараметры);
		
	// Открытие денежного ящика
	ИначеЕсли Команда = "OpenCashDrawer" ИЛИ Команда = "ОткрытьДенежныйЯщик" Тогда
		Результат = ОткрытьДенежныйЯщик(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Получение ширины строки в символах
	ИначеЕсли Команда = "GetLineLength" ИЛИ Команда = "ПолучитьШиринуСтроки" Тогда
		Результат = ПолучитьШиринуСтроки(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Печать переодического отчета по датам
	ИначеЕсли Команда = "PrintPReportDate" ИЛИ Команда = "НапечататьПериодическийОтчетПоДатам" Тогда
		Результат = НапечататьПериодическийОтчетПоДатам(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры);
		
	// Печать периодического отчета по номерам
	ИначеЕсли Команда = "PrintPReportNumber" ИЛИ Команда = "НапечататьПериодическийОтчетПоНомерам" Тогда
		Результат = НапечататьПериодическийОтчетПоНомерам(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры);
		
	// Печать нулевого чека
	ИначеЕсли Команда = "PrintNullReceipt" ИЛИ Команда = "НапечататьНулевойЧек" Тогда
		Результат = НапечататьНулевойЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Печать отчета о проданных товарах
	ИначеЕсли Команда = "PrintSoldReport" ИЛИ Команда = "НапечататьОтчетОПроданныхТоварах" Тогда
		Результат = НапечататьОтчетОПроданныхТоварах(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		
	// Вывод информации на дисплей
	ИначеЕсли Команда = "DisplayText" ИЛИ Команда = "ВывестиИнформациюНаДисплейПокупателя" Тогда
		Результат = ВывестиИнформациюНаДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры);
	// Очистка дисплея
	ИначеЕсли Команда = "ClearText" ИЛИ Команда = "ОчиститьДисплейПокупателя" Тогда
		Результат = ОчиститьДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);

	// Указанная команда не поддерживается данным драйвером
	Иначе
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Команда ""%Команда%"" не поддерживается данным драйвером.';uk='Команда ""%Команда%"" не підтримується цим драйвером.'"));
		ВыходныеПараметры[1] = СтрЗаменить(ВыходныеПараметры[1], "%Команда%", Команда);
		Результат = Ложь;
//>

	КонецЕсли;
		
	Возврат Результат;

КонецФункции


///////////////////////////////////////////////////////////////////////////////
// Процедуры и функции общие для работы с фискальными регистраторами

// Функция осуществляет открытие смены
//
Функция ОткрытьСмену(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)
	
	Результат = Истина;
	
	// Заполнение выходных параметров
	ВыходныеПараметры.Добавить(0);
	ВыходныеПараметры.Добавить(0);
	ВыходныеПараметры.Добавить(0);
	ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
	Возврат Результат;
	
КонецФункции

// Осуществляет печать фискального чека
//
Функция ПечатьЧека(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры)
	
	Если ВходныеПараметры[2][19] И НЕ Параметры.НесколькоАкцизныхМарокДляОдногоТовара Тогда
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='РРО не поддерживает печать нескольких акцизных марок для одного товара.';uk='РРО не підтримує друк кількох акцизних марок одного товару.'"));
		Возврат Ложь;
	Иначе
		Возврат МенеджерОборудованияКлиентПереопределяемый.ПечатьЧека(ПодключаемоеОборудованиеАртСофтФискальныйРегистратор,
			ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры);
	КонецЕсли;
	
		
КонецФункции

// Осуществляет печать текста
//
Функция ПечатьТекста(ОбъектДрайвера, Параметры, ПараметрыПодключения,
                       СтрокаТекста, ВыходныеПараметры)
	   
	Результат  = Истина;  
	
	// Открываем чек
	Результат = ОткрытьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, Ложь, Ложь, ВыходныеПараметры);
	
	// Печатаем строки чека
	Если Результат Тогда
		Для НомерСтроки = 1 По СтрЧислоСтрок(СтрокаТекста) Цикл
			ВыделеннаяСтрока = СтрПолучитьСтроку(СтрокаТекста, НомерСтроки);
			
			Если (Найти(ВыделеннаяСтрока, "[отрезка]") > 0)
			 Или (Найти(ВыделеннаяСтрока, "[cut]") > 0) Тогда
				ТаблицаОплат = Новый Массив();
				Результат = ЗакрытьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ТаблицаОплат, ВыходныеПараметры, Ложь);
				Результат = ОткрытьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, Ложь, Ложь, ВыходныеПараметры);
			Иначе
				Если НЕ НапечататьНефискальнуюСтроку(ОбъектДрайвера, Параметры, ПараметрыПодключения,
				                                     ВыделеннаяСтрока, ВыходныеПараметры, Ложь) Тогда
					Прервать;
				КонецЕсли;
			КонецЕсли;
			
		КонецЦикла;
	КонецЕсли;
	
	// Закрываем чек
	Если Результат Тогда
		ТаблицаОплат = Новый Массив();
		Результат = ЗакрытьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ТаблицаОплат, ВыходныеПараметры, Ложь);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет открытие нового чека
//
Функция ОткрытьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ЧекВозврата, ФискальныйЧек, ВыходныеПараметры) Экспорт
	
	Результат  = Истина;
	НомерСмены = 0;
	НомерЧека  = 0;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ОткрытьЧек(ОбъектДрайвера, ФискальныйЧек, ЧекВозврата,  Истина, НомерЧека, НомерСмены);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			// Заполнение выходных параметров
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(НомерСмены);
			ВыходныеПараметры.Добавить(НомерЧека);
			ВыходныеПараметры.Добавить(0); // Номер документа
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.ОткрытьЧек>:';uk='Помилка виклику методу <ОбъектДрайвера.ОткрытьЧек>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет закрытие ранее открытого чека
//
Функция ЗакрытьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ТаблицаОплат, ВыходныеПараметры, ФискальныйЧек = Истина) Экспорт

	Результат = Истина;
	
	СуммаНаличнойОплаты     = 0;
	СуммаБезналичнойОплаты1 = 0;
	СуммаБезналичнойОплаты2 = 0;
	СуммаБезналичнойОплаты3 = 0;
	
	Для ИндексОплаты = 0 По ТаблицаОплат.Количество() - 1 Цикл
		Если ТаблицаОплат[ИндексОплаты][0].Значение = 0 Тогда
			СуммаНаличнойОплаты = СуммаНаличнойОплаты + ТаблицаОплат[ИндексОплаты][1].Значение;
		ИначеЕсли ТаблицаОплат[ИндексОплаты][0].Значение = 1 Тогда
			СуммаБезналичнойОплаты1 = СуммаБезналичнойОплаты1 + ТаблицаОплат[ИндексОплаты][1].Значение;
		ИначеЕсли ТаблицаОплат[ИндексОплаты][0].Значение = 2 Тогда
			СуммаБезналичнойОплаты2 = СуммаБезналичнойОплаты2 + ТаблицаОплат[ИндексОплаты][1].Значение;
		Иначе
			СуммаБезналичнойОплаты3 = СуммаБезналичнойОплаты3 + ТаблицаОплат[ИндексОплаты][1].Значение;
		КонецЕсли;
	КонецЦикла;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ЗакрытьЧек(ОбъектДрайвера,
	                                     				СуммаНаличнойОплаты,
														СуммаБезналичнойОплаты1,
														СуммаБезналичнойОплаты2,
														СуммаБезналичнойОплаты3,
														ФискальныйЧек);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
			
			ОтменитьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		КонецЕсли
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.ЗакрытьЧек>:';uk='Помилка виклику методу <ОбъектДрайвера.ЗакрытьЧек>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;

КонецФункции

// Функция осуществляет отмену ранее открытого чека.
//
Функция ОтменитьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры) Экспорт
	
	Результат = Истина;
	
	Попытка
		ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ОтменитьЧек(ОбъектДрайвера);
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.ОтменитьЧек>:';uk='Помилка виклику методу <ОбъектДрайвера.ОтменитьЧек>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;   
	
КонецФункции

// Функция осуществляет снятие отчета без гашения 
//
Функция НапечататьОтчетБезГашения(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)
	
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьОтчетБезГашения(ОбъектДрайвера);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьОтчетБезГашения>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьОтчетБезГашения>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет снятие отчета с гашением 
//
Функция НапечататьОтчетСГашением(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)
	
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьОтчетСГашением(ОбъектДрайвера);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьОтчетСГашением>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьОтчетСГашением>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет печать фискальной строки 
//
Функция НапечататьФискальнуюСтроку(ОбъектДрайвера, Параметры, ПараметрыПодключения,
                                   Наименование, Количество, Цена, Сумма,
                                   НомерСекции, СтавкаНДС, ДопРеквизиты, ВыходныеПараметры) Экспорт
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьФискСтроку(ОбъектДрайвера, Наименование, Количество, Цена,
	                                                Сумма, НомерСекции, СтавкаНДС, ДопРеквизиты, Параметры);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
			ОтменитьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьФискСтроку>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьФискСтроку>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет печать нефискальной строки 
//
Функция НапечататьНефискальнуюСтроку(ОбъектДрайвера, Параметры, ПараметрыПодключения, СтрокаТекста, ВыходныеПараметры, ФискальныйЧек = Ложь) Экспорт
	
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьНефискСтроку(ОбъектДрайвера, СтрокаТекста, ФискальныйЧек);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
			ОтменитьЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры);
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьНефискСтроку>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьНефискСтроку>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет внесение или выемку суммы 
//
Функция Инкассация(ОбъектДрайвера, Параметры, ПараметрыПодключения, ТипИнкассации, Сумма, ВыходныеПараметры)
	
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьЧекВнесенияВыемки(ОбъектДрайвера,
	                           ?(ТипИнкассации = 1, Сумма, -Сумма));
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьЧекВнесенияВыемки>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьЧекВнесенияВыемки>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет печать штрихкода 
//
Функция ПечатьШтрихкода(ОбъектДрайвера, Параметры, ПараметрыПодключения, ТипШтрихКода2, ШтрихКод, ВыходныеПараметры)
	
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьШтрихКод(ОбъектДрайвера, ТипШтрихКода2, ШтрихКод);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьШтрихКод>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьШтрихКод>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет открытие денежного ящика
//
Функция ОткрытьДенежныйЯщик(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)
	
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ОткрытьДенежныйЯщик(ОбъектДрайвера);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.ОткрытьДенежныйЯщик>:';uk='Помилка виклику методу <ОбъектДрайвера.ОткрытьДенежныйЯщик>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;

КонецФункции

// Функция получает ширину строки в символах
//  
Функция ПолучитьШиринуСтроки(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)
	
	Результат = Истина;
	ШиринаСтроки = 0;
	 
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьШиринуСтроки(ОбъектДрайвера, ШиринаСтроки);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();  
			ВыходныеПараметры.Добавить(ШиринаСтроки);
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.ПолучитьШиринуСтроки>:';uk='Помилка виклику методу <ОбъектДрайвера.ПолучитьШиринуСтроки>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;

КонецФункции

// Функция осуществляет печать периодического отчёта по датам.
//
Функция НапечататьПериодическийОтчетПоДатам(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры)
 	
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьПериодическийОтчетПоДатам(ОбъектДрайвера, ВходныеПараметры[0], ВходныеПараметры[1], Ложь);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьОтчетСГашением>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьОтчетСГашением>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет печать периодического отчёта по номерам дневных отчетов.
//
Функция НапечататьПериодическийОтчетПоНомерам(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры)

	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьПериодическийОтчетПоНомерам(ОбъектДрайвера, ВходныеПараметры[0], ВходныеПараметры[1], Ложь);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьОтчетСГашением>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьОтчетСГашением>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет печать нулевого чека.
//
Функция НапечататьНулевойЧек(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьНулевойЧек(ОбъектДрайвера);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьОтчетСГашением>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьОтчетСГашением>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;

КонецФункции

// Функция осуществляет печать отчёта о проданных товарах.
//
Функция НапечататьОтчетОПроданныхТоварах(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)
	
	Результат = Истина;
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.НапечататьОтчетОПроданныхТоварах(ОбъектДрайвера);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.НапечататьОтчетСГашением>:';uk='Помилка виклику методу <ОбъектДрайвера.НапечататьОтчетСГашением>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции


// Функция осуществляет вывод информации на дисплей покупателя.
//
Функция ВывестиИнформациюНаДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВходныеПараметры, ВыходныеПараметры)
	
	Результат = Истина;
	
	ДлинаПоля = ?(Параметры.Модель="501",16,20);  // 16 для модели МІНІ-ФП54.01
	СтрокаТекста = ВходныеПараметры[0];
	СтрокаСуммы = ?(ВходныеПараметры.Количество() >= 2, ВходныеПараметры[1], "0");
	
	МассивСтрок = Новый Массив();
	МассивСтрок.Добавить(МенеджерОборудованияКлиентСервер.ПостроитьПоле(СтрПолучитьСтроку(СтрокаТекста, 1), ДлинаПоля));
	МассивСтрок.Добавить(МенеджерОборудованияКлиентСервер.ПостроитьПоле(СтрПолучитьСтроку(СтрокаТекста, 2), ДлинаПоля));	
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ВывестиИнформациюНаДисплейПокупателя(ОбъектДрайвера, МассивСтрок, СтрокаСуммы);
		Если НЕ Ответ Тогда
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
			ВыходныеПараметры.Добавить("");
			ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОшибку(ОбъектДрайвера, ВыходныеПараметры[1]);
		Иначе
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(0);
			ВыходныеПараметры.Добавить(ОбщегоНазначенияКлиент.ДатаСеанса());
		КонецЕсли;
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.ВывестиСтрокуНаДисплейПокупателя>:';uk='Помилка виклику методу <ОбъектДрайвера.ВывестиСтрокуНаДисплейПокупателя>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Функция осуществляет очистку дисплея покупателя.
//
Функция ОчиститьДисплейПокупателя(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = Истина;

	Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ОчиститьДисплейПокупателя(ОбъектДрайвера);
	Если Не Ответ Тогда
		Результат = Ложь;
		ОбъектДрайвера.ПолучитьОшибку(ОбъектДрайвера.ОписаниеОшибки);
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(ОбъектДрайвера.ОписаниеОшибки);
	КонецЕсли;

	Возврат Результат;

КонецФункции

//////////////////////////////////////////////////////////////////////////////
// Процедуры и функции общие для всех типов драйверов

// Функция осуществляет тестирование устройства.
//
Функция ТестУстройства(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат            = Истина;
	РезультатТеста       = "";
	АктивированДемоРежим = "";
	
	
	Попытка
		Ответ = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ТестУстройства(ОбъектДрайвера, РезультатТеста, АктивированДемоРежим, Параметры);
	
		Если Ответ Тогда
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(0);
		Иначе
			Результат = Ложь;
			ВыходныеПараметры.Очистить();
			ВыходныеПараметры.Добавить(999);
		КонецЕсли;
		ВыходныеПараметры.Добавить(РезультатТеста);
		ВыходныеПараметры.Добавить(АктивированДемоРежим);
	
	Исключение
		Результат = Ложь;
		ВыходныеПараметры.Очистить();
		ВыходныеПараметры.Добавить(999);
		ВыходныеПараметры.Добавить(НСтр("ru='Ошибка вызова метода <ОбъектДрайвера.ТестУстройства>:';uk='Помилка виклику методу <ОбъектДрайвера.ТестУстройства>:'") + ОписаниеОшибки());
	КонецПопытки;
	
	Возврат Результат;

КонецФункции


// Функция возвращает версию установленного драйвера
//
Функция ПолучитьВерсиюДрайвера(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = Истина;

	ВыходныеПараметры.Добавить(НСтр("ru='Установлен';uk='Встановлений'"));
	ВыходныеПараметры.Добавить(НСтр("ru='Не определена';uk='Не визначена'"));

	Попытка
		ВыходныеПараметры[1] = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьНомерВерсии(ОбъектДрайвера);
	Исключение
		Результат = Ложь;
	КонецПопытки;

	Возврат Результат;

КонецФункции

// Функция возвращает описание установленного драйвера
//
Функция ПолучитьОписаниеДрайвера(ОбъектДрайвера, Параметры, ПараметрыПодключения, ВыходныеПараметры)

	Результат = Истина;
	
	ВыходныеПараметры.Очистить();
	ВыходныеПараметры.Добавить(НСтр("ru='Установлен';uk='Встановлений'"));
	ВыходныеПараметры.Добавить(НСтр("ru='Не определена';uk='Не визначена'"));
	
	ВыходныеПараметры.Добавить(НСтр("ru='Не определено';uk='Не визначено'"));
	ВыходныеПараметры.Добавить(НСтр("ru='Не определено';uk='Не визначено'"));
	ВыходныеПараметры.Добавить(НСтр("ru='Не определено';uk='Не визначено'"));
	ВыходныеПараметры.Добавить(Неопределено);
	ВыходныеПараметры.Добавить(Неопределено);
	ВыходныеПараметры.Добавить(Неопределено);
	ВыходныеПараметры.Добавить(Неопределено);
	ВыходныеПараметры.Добавить(Неопределено);
	ВыходныеПараметры.Добавить(Неопределено);
	
	НаименованиеДрайвера      = "";
	ОписаниеДрайвера          = "";
	ТипОборудования           = "";
	ИнтеграционнаяБиблиотека  = "";
	ОсновнойДрайверУстановлен = "";
	РевизияИнтерфейса         = "";
	URLЗагрузкиДрайвера       = "";
	ПараметрыДрайвера         = "";
	ДополнительныеДействия    = "";
	
	Попытка
		// Получаем версию драйвера
		ВерсияДрайвера = ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьНомерВерсии(ОбъектДрайвера);
		ВыходныеПараметры[1] = ВерсияДрайвера;

		// Получаем описание драйвера
		ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьОписание(ОбъектДрайвера,
										НаименованиеДрайвера,
										ОписаниеДрайвера, 
										ТипОборудования, 
										РевизияИнтерфейса, 
										ИнтеграционнаяБиблиотека, 
										ОсновнойДрайверУстановлен, 
										URLЗагрузкиДрайвера);
		ВыходныеПараметры[2] = НаименованиеДрайвера;
		ВыходныеПараметры[3] = ОписаниеДрайвера;
		ВыходныеПараметры[4] = ТипОборудования;
		ВыходныеПараметры[5] = РевизияИнтерфейса;
		ВыходныеПараметры[6] = ИнтеграционнаяБиблиотека;
		ВыходныеПараметры[7] = ОсновнойДрайверУстановлен;
		ВыходныеПараметры[8] = URLЗагрузкиДрайвера;
		
		// Получаем описание драйвера
		ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьПараметры(ОбъектДрайвера, ПараметрыДрайвера);
		ВыходныеПараметры[9] = ПараметрыДрайвера;
		
		// Получаем дополнительные действия
		ПодключаемоеОборудованиеАртСофтФискальныйРегистраторИнтерфейсВК.ПолучитьДополнительныеДействия(ОбъектДрайвера, ДополнительныеДействия);
		ВыходныеПараметры[10] = ДополнительныеДействия;
	Исключение
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Ошибка получения описания драйвера';uk='Помилка отримання опису драйвера'"));
	КонецПопытки;
	
	Возврат Результат;

КонецФункции