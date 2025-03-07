///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Обработка входящих сообщений с типом {http://www.1c.ru/SaaS/ManageZonesBackup/a.b.c.d}PlanZoneBackup.
//
// Параметры:
//  КодОбластиДанных - Число - код области данных,
//  ИдентификаторРезервнойКопии - УникальныйИдентификатор - идентификатор резервной копии,
//  МоментРезервнойКопии - Дата - дата и время резервной копии,
//  Принудительно - Булево - флаг принудительного создания резервной копии.
//
Процедура ПланироватьСозданиеРезервнойКопииОбласти(Знач КодОбластиДанных,
		Знач ИдентификаторРезервнойКопии, Знач МоментРезервнойКопии,
		Знач Принудительно) Экспорт
	
	ПараметрыВыгрузки = РезервноеКопированиеОбластейДанных.СоздатьПустыеПараметрыВыгрузки();
	ПараметрыВыгрузки.ОбластьДанных = КодОбластиДанных;
	ПараметрыВыгрузки.ИДКопии = ИдентификаторРезервнойКопии;
	ПараметрыВыгрузки.МоментЗапуска = МестноеВремя(МоментРезервнойКопии, // !Перевести универсальное в местное -
		// В очередях на вход должно поступать местное.
		РаботаВМоделиСервиса.ПолучитьЧасовойПоясОбластиДанных(КодОбластиДанных));
	ПараметрыВыгрузки.Принудительно = Принудительно;
	ПараметрыВыгрузки.ПоТребованию = Ложь;
	
	РезервноеКопированиеОбластейДанных.ЗапланироватьАрхивациюВОчереди(ПараметрыВыгрузки);
	
КонецПроцедуры

// Обработка входящих сообщений с типом {http://www.1c.ru/SaaS/ManageZonesBackup/a.b.c.d}CancelZoneBackup.
//
// Параметры:
//  КодОбластиДанных - Число - код области данных,
//  ИдентификаторРезервнойКопии - УникальныйИдентификатор - идентификатор резервной копии.
//
Процедура ОтменитьСозданиеРезервнойКопииОбласти(Знач КодОбластиДанных, Знач ИдентификаторРезервнойКопии) Экспорт
	
	ПараметрыОтмены = Новый Структура("ОбластьДанных, ИДКопии", КодОбластиДанных, ИдентификаторРезервнойКопии);
	РезервноеКопированиеОбластейДанных.ОтменитьСозданиеРезервнойКопииОбласти(ПараметрыОтмены);
	
КонецПроцедуры

// Обработка входящих сообщений с типом
// {http://www.1c.ru/SaaS/ManageZonesBackup/a.b.c.d}UpdateScheduledZoneBackupSettings.
//
// Параметры:
//  ОбластьДанных - Число - значение разделителя области данных.
//  Настройки - Структура - новые настройки резервного копирования.
Процедура ОбновитьНастройкиПериодическогоРезервногоКопирования(Знач ОбластьДанных, Знач Настройки) Экспорт
	
	ПараметрыСоздания = Новый Структура;
	ПараметрыСоздания.Вставить("СоздаватьЕжедневные");
	ПараметрыСоздания.Вставить("СоздаватьЕжемесячные");
	ПараметрыСоздания.Вставить("СоздаватьЕжегодные");
	ПараметрыСоздания.Вставить("ТолькоПриАктивностиПользователей");
	ПараметрыСоздания.Вставить("ДеньСозданияЕжемесячных");
	ПараметрыСоздания.Вставить("МесяцСозданияЕжегодных");
	ПараметрыСоздания.Вставить("ДеньСозданияЕжегодных");
	ЗаполнитьЗначенияСвойств(ПараметрыСоздания, Настройки);
	
	СостояниеСоздания = Новый Структура;
	СостояниеСоздания.Вставить("ДатаСозданияПоследнейЕжедневной");
	СостояниеСоздания.Вставить("ДатаСозданияПоследнейЕжемесячной");
	СостояниеСоздания.Вставить("ДатаСозданияПоследнейЕжегодной");
	ЗаполнитьЗначенияСвойств(СостояниеСоздания, Настройки);
	
	ПараметрыМетода = Новый Массив;
	ПараметрыМетода.Добавить(Новый ФиксированнаяСтруктура(ПараметрыСоздания));
	ПараметрыМетода.Добавить(Новый ФиксированнаяСтруктура(СостояниеСоздания));
	
	Расписание = Новый РасписаниеРегламентногоЗадания;
	Расписание.ВремяНачала = Настройки.НачалоИнтервалаФормированияКопий;
	Расписание.ВремяКонца = Настройки.ОкончаниеИнтервалаФормированияКопий;
	Расписание.ПериодПовтораДней = 1;
	
	ПараметрыЗадания = Новый Структура;
	ПараметрыЗадания.Вставить("Параметры", ПараметрыМетода);
	ПараметрыЗадания.Вставить("Расписание", Расписание);
	
	ОтборЗадания = Новый Структура;
	ОтборЗадания.Вставить("ОбластьДанных", ОбластьДанных);
	ОтборЗадания.Вставить("ИмяМетода", "РезервноеКопированиеОбластейДанных.СозданиеКопий");
	ОтборЗадания.Вставить("Ключ", "1");
	
	НачатьТранзакцию();
	Попытка
		Задания = ОчередьЗаданий.ПолучитьЗадания(ОтборЗадания);
		Если Задания.Количество() > 0 Тогда
			ОчередьЗаданий.ИзменитьЗадание(Задания.Получить(0).Идентификатор, ПараметрыЗадания);
		Иначе
			ПараметрыЗадания.Вставить("ОбластьДанных", ОбластьДанных);
			ПараметрыЗадания.Вставить("ИмяМетода", "РезервноеКопированиеОбластейДанных.СозданиеКопий");
			ПараметрыЗадания.Вставить("Ключ", "1");
			ПараметрыЗадания.Вставить("КоличествоПовторовПриАварийномЗавершении", 3);
			ПараметрыЗадания.Вставить("ИнтервалПовтораПриАварийномЗавершении", 600); // 10 минут
			ОчередьЗаданий.ДобавитьЗадание(ПараметрыЗадания);
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

// Обработка входящих сообщений с типом {http://www.1c.ru/SaaS/ManageZonesBackup/a.b.c.d}CancelScheduledZoneBackup.
//
// Параметры:
//  ОбластьДанных - Число - значение разделителя области данных.
Процедура ОтменитьПериодическоеРезервноеКопирование(Знач ОбластьДанных) Экспорт
	
	ОтборЗадания = Новый Структура;
	ОтборЗадания.Вставить("ОбластьДанных", ОбластьДанных);
	ОтборЗадания.Вставить("ИмяМетода", "РезервноеКопированиеОбластейДанных.СозданиеКопий");
	ОтборЗадания.Вставить("Ключ", "1");
	
	НачатьТранзакцию();
	Попытка
		Задания = ОчередьЗаданий.ПолучитьЗадания(ОтборЗадания);
		Если Задания.Количество() > 0 Тогда
			ОчередьЗаданий.УдалитьЗадание(Задания.Получить(0).Идентификатор);
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти
