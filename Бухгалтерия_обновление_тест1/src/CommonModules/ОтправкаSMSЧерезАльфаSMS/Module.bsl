////////////////////////////////////////////////////////////////////////////////
// Подсистема "Отправка SMS"
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Отправляет SMS через веб-сервис Альфа SMS, возвращает идентификатор сообщения.
//
// Параметры:
//  НомераПолучателей - Массив - номера получателей в формате +7ХХХХХХХХХХ (строкой);
//  Текст             - Строка - текст сообщения, длиной не более 1000 символов;
//  ИмяОтправителя 	  - Строка - имя отправителя, которое будет отображаться вместо номера входящего SMS;
//  Логин             - Строка - логин пользователя услуги отправки sms;
//  Пароль            - Строка - пароль пользователя услуги отправки sms.
//
// Возвращаемое значение:
//  Структура: ОтправленныеСообщения - Массив структур: НомерОтправителя
//                                                  ИдентификаторСообщения
//             ОписаниеОшибки    - Строка - пользовательское представление ошибки, если пустая строка,
//                                          то ошибки нет.
&НаСервере
Функция ОтправитьSMS(НомераПолучателей, Текст, ИмяОтправителя, Логин, Знач Пароль) Экспорт
	
	Результат = Новый Структура("ОтправленныеСообщения,ОписаниеОшибки", Новый Массив, "");
	
	ИмяВходящегоФайла = "" + КаталогВременныхФайлов() + "outsms.txt";
	СерверSMS =  "alphasms.com.ua";
	
	СтрокаПараметраПолучения = "api/http.php?version=http&login=" + Логин + "&password=" + Пароль + "&command=";
	
	Для Каждого Элемент Из НомераПолучателей Цикл
		НомерПолучателя = ФорматироватьНомер(Элемент);
		Если Не ПустаяСтрока(НомерПолучателя) Тогда
			Попытка
				ТекстовыйДок = Новый ТекстовыйДокумент();
				Ответ = ЗапросHTTP(СтрокаПараметраПолучения + "send&from=" + ИмяОтправителя + "&to=" + НомерПолучателя + "&message=" + СокрЛП(Текст), СерверSMS, ИмяВходящегоФайла, ТекстовыйДок);
				
				ИдентификаторСообщения = Ответ.id;
				
				Результат.ОтправленныеСообщения.Добавить(Новый Структура("НомерПолучателя,ИдентификаторСообщения",	
																  НомерПолучателя, Формат(ИдентификаторСообщения, "ЧГ=")));
																  
				Если ЗначениеЗаполнено(Ответ.errors) Тогда
					Результат.ОписаниеОшибки = Результат.ОписаниеОшибки 
											 + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='SMS на номер %1 не отправлено';uk='SMS на номер %1 не відправлено'"), Элемент)
											 + ": " + Ответ.errors
											 + Символы.ПС;
				КонецЕсли;									
			Исключение
				ЗаписьЖурналаРегистрации(
					НСтр("ru='Отправка SMS';uk='Отправка SMS'"),
					УровеньЖурналаРегистрации.Ошибка,
					,
					,
					ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
				Результат.ОписаниеОшибки = Результат.ОписаниеОшибки 
										 + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='SMS на номер %1 не отправлено';uk='SMS на номер %1 не відправлено'"), Элемент)
										 + ": " + КраткоеПредставлениеОшибки(ИнформацияОбОшибке())
										 + Символы.ПС;
			КонецПопытки;
		КонецЕсли;
	КонецЦикла;
	
	Результат.ОписаниеОшибки = СокрП(Результат.ОписаниеОшибки);
	
	Возврат Результат;
	
КонецФункции

// Возвращает текстовое представление статуса доставки сообщения.
//
// Параметры:
//  ИдентификаторСообщения - Строка - идентификатор, присвоенный sms при отправке;
//  Логин                  - Строка - логин пользователя услуги отправки sms;
//  Пароль                 - Строка - пароль пользователя услуги отправки sms.
//
// Возвращаемое значение:
//  Строка - статус доставки. См. описание функции ОтправкаSMS.СтатусДоставки.
Функция СтатусДоставки(ИдентификаторСообщения, Логин, Знач Пароль) Экспорт
	
	ИмяВходящегоФайла = "" + КаталогВременныхФайлов() + "outsms.txt";
	СерверSMS =  "alphasms.com.ua";
	СтрокаПараметраПолучения = "api/http.php?version=http&login=" + Логин + "&password=" + Пароль + "&command=";
	ТекстовыйДок = Новый ТекстовыйДокумент();
	
	Статус = ЗапросHTTP(СтрокаПараметраПолучения + "receive&id=" + Формат(ИдентификаторСообщения, "ЧГ=0"), СерверSMS, ИмяВходящегоФайла, ТекстовыйДок);
	
	Возврат СтатусДоставкиSMS(Строка(Статус.code));
	
	Возврат "Ошибка";
	
КонецФункции

Функция ФорматироватьНомер(Номер)
	
	Результат = "";
	ДопустимыеСимволы = "1234567890";
	Для Позиция = 1 По СтрДлина(Номер) Цикл
		Символ = Сред(Номер,Позиция,1);
		Если СтрНайти(ДопустимыеСимволы, Символ) > 0 Тогда
			Результат = Результат + Символ;
		КонецЕсли;
	КонецЦикла;
	Возврат Результат;	
	
КонецФункции

Функция СтатусДоставкиSMS(СтатусСтрокой)
	
	СоответствиеСтатусов = Новый Соответствие;
	СоответствиеСтатусов.Вставить("0", "НеОтправлялось");
	СоответствиеСтатусов.Вставить("1", "Отправляется");
	СоответствиеСтатусов.Вставить("2", "Отправлено");
	СоответствиеСтатусов.Вставить("3", "Доставлено");
	СоответствиеСтатусов.Вставить("5", "НеДоставлено");
	
	Результат = СоответствиеСтатусов[СтатусСтрокой];
	Возврат ?(Результат = Неопределено, "Ошибка", Результат);
	
КонецФункции

//Делаем запрос к web сервису
// СтрокаПолучения - строка запроса которую отсылаем на сервер
Функция ЗапросHTTP(СтрокаПолучения, Сервер, ИмяВходящегоФайла, Текст)
	
	СтруктураОтвета = Новый Структура;
	СтруктураОтвета.Вставить("balance","");
	СтруктураОтвета.Вставить("id","");
	СтруктураОтвета.Вставить("code","");
	СтруктураОтвета.Вставить("status","");
	СтруктураОтвета.Вставить("errors","");
	
	Попытка
		Соединение = Новый HTTPСоединение(Сервер,,,,);
		Соединение.Получить(СтрокаПолучения, ИмяВходящегоФайла,);
		ВходящийФайл = Новый Файл(ИмяВходящегоФайла);
		Если НЕ ВходящийФайл.Существует() Тогда
			СтруктураОтвета.errors = "Не удалось получить ответ с сервера";
			Возврат СтруктураОтвета;
		КонецЕсли;
		ВыбСтатус = "";
		Текст.Прочитать(ИмяВходящегоФайла, КодировкаТекста.UTF8);
		КолСтрок = Текст.КоличествоСтрок();
		Для Инд = 1 По КолСтрок Цикл
			Стр = Текст.ПолучитьСтроку(Инд);
			Если Лев(Стр, 8) = "balance:" Тогда
				Стр = СтрЗаменить(Стр, "balance:", "");
				СтруктураОтвета.balance = Число(Стр);
			ИначеЕсли Лев(Стр, 3) = "id:" Тогда
				Стр = СтрЗаменить(Стр, "id:", "");
				СтруктураОтвета.id = Число(Стр);
			ИначеЕсли Лев(Стр, 5) = "code:" Тогда
				Стр = СтрЗаменить(Стр, "code:", "");
				СтруктураОтвета.code = Число(Стр);
			ИначеЕсли Лев(Стр, 7) = "status:" Тогда
				Стр = СтрЗаменить(Стр, "status:", "");
				СтруктураОтвета.status = Стр;
			ИначеЕсли Лев(Стр, 7) = "errors:" Тогда
				Стр = СтрЗаменить(Стр, "errors:", "");
				СтруктураОтвета.errors = Стр;
			КонецЕсли;
		КонецЦикла;
	Исключение
		СтруктураОтвета.errors = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат СтруктураОтвета;
	
КонецФункции

Функция ПолучитьБаланс(Логин, Знач Пароль)Экспорт
	
	ИмяВходящегоФайла = "" + КаталогВременныхФайлов() + "outsms.txt";
	СерверSMS =  "alphasms.com.ua";
	СтрокаПараметраПолучения = "api/http.php?version=http&login=" + Логин + "&password=" + Пароль + "&command=";
	ТекстовыйДок = Новый ТекстовыйДокумент();
	
	Баланс = ЗапросHTTP(СтрокаПараметраПолучения + "balance", СерверSMS, ИмяВходящегоФайла, ТекстовыйДок);
	
	Возврат Баланс.balance;
	
КонецФункции

// Возвращает список разрешений для отправки SMS с использованием всех доступных провайдеров.
//
// Возвращаемое значение:
//  Массив.
//
Функция Разрешения() Экспорт
	Протокол = "HTTP";
	Адрес = "alphasms.com.ua";
	Порт = Неопределено;
	Описание = НСтр("ru='Отправка SMS через АльфаSMS.';uk='Відправлення SMS через АльфаЅМЅ.'");
	
	Разрешения = Новый Массив;
	Разрешения.Добавить(
		РаботаВБезопасномРежиме.РазрешениеНаИспользованиеИнтернетРесурса(Протокол, Адрес, Порт, Описание));
	
	Возврат Разрешения;
КонецФункции

Процедура ПриОпределенииНастроек(Настройки) Экспорт
	
	Настройки.АдресОписанияУслугиВИнтернете = "https://alphasms.ua";
	
КонецПроцедуры
 
#КонецОбласти
