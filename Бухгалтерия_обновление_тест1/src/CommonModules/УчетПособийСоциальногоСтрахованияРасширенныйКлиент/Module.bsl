
#Область СлужебныеПроцедурыИФункции

// Записывает файл сведений документа в каталог, указанный пользователем.
//
Процедура ВыгрузитьДокументОтчетности(Ссылка) Экспорт 
	
	ПараметрыВыгрузки = Новый Структура("Ссылка, ОписаниеФайла");
	ПараметрыВыгрузки.Ссылка = Ссылка;
	
	ТекстСообщения = НСтр("ru='Для выгрузки файлов рекомендуется установить расширение для веб-клиента платформы.';uk='Для вивантаження файлів рекомендується встановити розширення для вебклієнта платформи.'");
	Обработчик = Новый ОписаниеОповещения("ВыгрузитьДокументОтчетностиПослеПодключенияРасширения", ЭтотОбъект, ПараметрыВыгрузки);
	ОбщегоНазначенияКлиент.ПоказатьВопросОбУстановкеРасширенияРаботыСФайлами(Обработчик, ТекстСообщения);
	
КонецПроцедуры	

Процедура ВыгрузитьДокументОтчетностиПослеПодключенияРасширения(Подключено, ПараметрыВыгрузки) Экспорт 
	
	Отказ = Ложь;
	
	ОписаниеФайла = ЗарплатаКадрыРасширенныйВызовСервера.ПолучитьОписаниеДокументаОтчетности(ПараметрыВыгрузки.Ссылка, Отказ);
	
	Если ОписаниеФайла = Неопределено Или Отказ Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыВыгрузки.ОписаниеФайла = ОписаниеФайла.Описание;
	
	Если Не Подключено Тогда
		ПолучитьФайл(ПараметрыВыгрузки.ОписаниеФайла.Хранение, ПараметрыВыгрузки.ОписаниеФайла.Имя);
		Возврат;
	КонецЕсли;
	
	ПолучаемыеФайлы = Новый Массив;
	ПолучаемыеФайлы.Добавить(ПараметрыВыгрузки.ОписаниеФайла);
	
	ДиалогВыбораКаталога = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	ДиалогВыбораКаталога.Заголовок = НСтр("ru='Выберите каталог';uk='Виберіть каталог'");
	
	ОповещениеЗавершения = Новый ОписаниеОповещения("ВыгрузитьДокументОтчетностиЗавершение", ЭтотОбъект, ПараметрыВыгрузки);
	НачатьПолучениеФайлов(ОповещениеЗавершения, ПолучаемыеФайлы, ДиалогВыбораКаталога, Истина);
	
КонецПроцедуры

Процедура ВыгрузитьДокументОтчетностиЗавершение(ПолученныеФайлы, ПараметрыВыгрузки) Экспорт 
	
	Если ПолученныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекстОповещения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru='Файл-пачка записан под именем: %1';uk='Файл-пачка записаний під іменем: %1'"), ПараметрыВыгрузки.ОписаниеФайла.Имя);
	
	ПоказатьПредупреждение(, ТекстОповещения);
	
КонецПроцедуры

#КонецОбласти
