
#Область ОбработчикиСобытий

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;

	Если Параметры.Ключ = Неопределено Или Параметры.Ключ.Пустая() Тогда
		Объект.РазделительБлоков1 = "^";
		Объект.РазделительБлоков2 = "=";
		Объект.РазделительБлоков3 = "=";
		
		Объект.ДлинаКода1 = 79;
		Объект.ДлинаКода2 = 40;
		Объект.ДлинаКода3 = 107;
		
		Объект.Префикс1 = "%";
		Объект.Префикс2 = ";";
		Объект.Префикс3 = ";";
		
		Объект.Суффикс1 = "?";
		Объект.Суффикс2 = "?";
		Объект.Суффикс3 = "?";
		
		Объект.ДоступностьДорожки1 = Истина;
		Объект.ДоступностьДорожки2 = Истина;
		Объект.ДоступностьДорожки3 = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// ПодключаемоеОборудование
	ПоддерживаемыеТипыВО = Новый Массив();
	ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
	ОповещенияПриПодключении = Новый ОписаниеОповещения("ПодключитьОборудованиеЗавершение", ЭтотОбъект);    
	МенеджерОборудованияКлиент.НачатьПодключениеОборудованиеПоТипу(ОповещенияПриПодключении, УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	// Конец ПодключаемоеОборудование
	
	УстановитьДоступностьДорожек();
	
КонецПроцедуры

&НаКлиенте
Процедура ПодключитьОборудованиеЗавершение(РезультатВыполнения, Параметры) Экспорт
	
	Если Не РезультатВыполнения.Результат Тогда
		ТекстСообщения = НСтр("ru='При подключении оборудования произошла ошибка:
|""%ОписаниеОшибки%"".'
|;uk='При підключенні обладнання сталася помилка:
|""%ОписаниеОшибки%"".'");
		ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОписаниеОшибки%" , РезультатВыполнения.ОписаниеОшибки);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)	
	
	// ПодключаемоеОборудование
	Если Источник = "ПодключаемоеОборудование"
	   И ВводДоступен() Тогда
		Если ИмяСобытия = "TracksData" Тогда
			Если Параметр[1] = Неопределено Тогда
				ДанныеДорожек = Параметр[0];
			Иначе
				ДанныеДорожек = Параметр[1][1];
			КонецЕсли;
			
			// Выводим считанные данные
			Дорожка1 = ДанныеДорожек[0];
			Дорожка2 = ДанныеДорожек[1];
			Дорожка3 = ДанныеДорожек[2];
			Объект.ДлинаКода1 = СтрДлина(Дорожка1);
			Объект.ДлинаКода2 = СтрДлина(Дорожка2);
			Объект.ДлинаКода3 = СтрДлина(Дорожка3);
			Объект.ДоступностьДорожки1 = НЕ (СтрДлина(Дорожка1) = 0);
			Объект.ДоступностьДорожки2 = НЕ (СтрДлина(Дорожка2) = 0);
			Объект.ДоступностьДорожки3 = НЕ (СтрДлина(Дорожка3) = 0);
			УстановитьДоступностьДорожек();
			Модифицированность = Истина;
		КонецЕсли;
	КонецЕсли;
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	// ПодключаемоеОборудование
	ПоддерживаемыеТипыВО = Новый Массив();
	ПоддерживаемыеТипыВО.Добавить("СчитывательМагнитныхКарт");
	МенеджерОборудованияКлиент.НачатьОтключениеОборудованиеПоТипу(Неопределено, УникальныйИдентификатор, ПоддерживаемыеТипыВО);
	// Конец ПодключаемоеОборудование
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	// Проверка на наличие полей
	ОчиститьСообщения();
	СчетчикПолей = 0;
	Если Объект.ДоступностьДорожки1 Тогда
		СчетчикПолей = СчетчикПолей + Объект.ПоляДорожки1.Количество();
	КонецЕсли;
	Если Объект.ДоступностьДорожки2 Тогда
		СчетчикПолей = СчетчикПолей + Объект.ПоляДорожки2.Количество();
	КонецЕсли;
	Если Объект.ДоступностьДорожки3 Тогда
		СчетчикПолей = СчетчикПолей + Объект.ПоляДорожки3.Количество();
	КонецЕсли;
	Если СчетчикПолей = 0 Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Не добавлено ни одного поля ни в одной из доступных дорожек.';uk='Не додано жодного поля ні в одній з доступних доріжок.'"), , , , Отказ);
	КонецЕсли;
	
	КонтрольУникальностиПолей(Отказ);
	
КонецПроцедуры

&НаКлиенте
Процедура ВнешнееСобытие(Источник, Событие, Данные)
	
	Если ВводДоступен() Тогда
		
		ОписаниеСобытия = Новый Структура();
		ОписаниеОшибки  = "";
		ОписаниеСобытия.Вставить("Источник", Источник);
		ОписаниеСобытия.Вставить("Событие",  Событие);
		ОписаниеСобытия.Вставить("Данные",   Данные);
		
		Результат = МенеджерОборудованияКлиент.ПолучитьСобытиеОтУстройства(ОписаниеСобытия, ОписаниеОшибки);
		Если Результат = Неопределено Тогда 
			ТекстСообщения = НСтр("ru='При обработке внешнего события от устройства произошла ошибка:';uk='При обробці зовнішньої події від пристрою сталася помилка:'")
								+ Символы.ПС + ОписаниеОшибки;
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Иначе
			ОбработкаОповещения(Результат.ИмяСобытия, Результат.Параметр, Результат.Источник);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВзятьПрефикс1(Команда)
	Если СтрДлина(Элементы.Дорожка1.ВыделенныйТекст) > 0 Тогда
		Объект.Префикс1 = Элементы.Дорожка1.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьПрефикс2(Команда)
	Если СтрДлина(Элементы.Дорожка2.ВыделенныйТекст) > 0 Тогда
		Объект.Префикс2 = Элементы.Дорожка2.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьПрефикс3(Команда)
	Если СтрДлина(Элементы.Дорожка3.ВыделенныйТекст) > 0 Тогда
		Объект.Префикс3 = Элементы.Дорожка3.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьСуффикс1(Команда)
	Если СтрДлина(Элементы.Дорожка1.ВыделенныйТекст) > 0 Тогда
		Объект.Суффикс1 = Элементы.Дорожка1.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьСуффикс2(Команда)
	Если СтрДлина(Элементы.Дорожка2.ВыделенныйТекст) > 0 Тогда
		Объект.Суффикс2 = Элементы.Дорожка2.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьСуффикс3(Команда)
	Если СтрДлина(Элементы.Дорожка3.ВыделенныйТекст) > 0 Тогда
		Объект.Суффикс3 = Элементы.Дорожка3.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьРазделитель1(Команда)
	Если СтрДлина(Элементы.Дорожка1.ВыделенныйТекст) > 0 Тогда
		Объект.РазделительБлоков1 = Элементы.Дорожка1.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьРазделитель2(Команда)
	Если СтрДлина(Элементы.Дорожка2.ВыделенныйТекст) > 0 Тогда
		Объект.РазделительБлоков2 = Элементы.Дорожка2.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьРазделитель3(Команда)
	Если СтрДлина(Элементы.Дорожка3.ВыделенныйТекст) > 0 Тогда
		Объект.РазделительБлоков3 = Элементы.Дорожка3.ВыделенныйТекст;
	Иначе
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВзятьПоле1Завершение(Результат, Параметры) Экспорт
	
	Элементы.ПоляДорожки1.ДобавитьСтроку();
	НовоеПоле = Элементы.ПоляДорожки1.ТекущиеДанные;
	НовоеПоле.НомерБлока = Результат.НомерБлока;
	НовоеПоле.НомерПервогоСимволаПоля = Результат.НомерПервогоСимволаПоля;
	НовоеПоле.ДлинаПоля = Результат.ДлинаПоля;
	НовоеПоле.Поле = ПредопределенноеЗначение("Перечисление.ПоляШаблоновМагнитныхКарт.Код");
	Элементы.ПоляДорожки1.ЗакончитьРедактированиеСтроки(Ложь);
	
КонецПроцедуры  

&НаКлиенте
Процедура ВзятьПоле1(Команда)
	
	Перем НСтр, НКол, КСтр, ККол;
	
	ОчиститьСообщения();
		
	Если СтрДлина(Элементы.Дорожка1.ВыделенныйТекст) = 0 Тогда
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ВзятьПоле1Завершение", ЭтотОбъект, );

	Элементы.Дорожка1.ПолучитьГраницыВыделения(НСтр, НКол, КСтр, ККол);
	
	ОпределитьКоординатыПоля(Оповещение, Дорожка1, Объект.Префикс1, Объект.Суффикс1, Объект.РазделительБлоков1, НКол, ККол);
	
КонецПроцедуры

&НаКлиенте
Процедура ВзятьПоле2Завершение(Результат, Параметры) Экспорт
	
	Элементы.ПоляДорожки2.ДобавитьСтроку();
	НовоеПоле = Элементы.ПоляДорожки2.ТекущиеДанные;
	НовоеПоле.НомерБлока = Результат.НомерБлока;
	НовоеПоле.НомерПервогоСимволаПоля = Результат.НомерПервогоСимволаПоля;
	НовоеПоле.ДлинаПоля = Результат.ДлинаПоля;
	НовоеПоле.Поле = ПредопределенноеЗначение("Перечисление.ПоляШаблоновМагнитныхКарт.Код");
	Элементы.ПоляДорожки2.ЗакончитьРедактированиеСтроки(Ложь);
	
КонецПроцедуры  

&НаКлиенте
Процедура ВзятьПоле2(Команда)
	
	Перем НСтр, НКол, КСтр, ККол;
	
	ОчиститьСообщения();
	
	Если СтрДлина(Элементы.Дорожка2.ВыделенныйТекст) = 0 Тогда
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ВзятьПоле2Завершение", ЭтотОбъект, Параметры);

	Элементы.Дорожка2.ПолучитьГраницыВыделения(НСтр, НКол, КСтр, ККол);
	
	ОпределитьКоординатыПоля(Оповещение, Дорожка2, Объект.Префикс2, Объект.Суффикс2, Объект.РазделительБлоков2, НКол, ККол);
	
КонецПроцедуры

&НаКлиенте
Процедура ВзятьПоле3Завершение(Результат, Параметры) Экспорт
	
	Элементы.ПоляДорожки3.ДобавитьСтроку();
	НовоеПоле = Элементы.ПоляДорожки3.ТекущиеДанные;
	НовоеПоле.НомерБлока = Результат.НомерБлока;
	НовоеПоле.НомерПервогоСимволаПоля = Результат.НомерПервогоСимволаПоля;
	НовоеПоле.ДлинаПоля = Результат.ДлинаПоля;
	НовоеПоле.Поле = ПредопределенноеЗначение("Перечисление.ПоляШаблоновМагнитныхКарт.Код");
	Элементы.ПоляДорожки3.ЗакончитьРедактированиеСтроки(Ложь);
	
КонецПроцедуры  

&НаКлиенте
Процедура ВзятьПоле3(Команда)
	
	Перем НСтр, НКол, КСтр, ККол;
	
	ОчиститьСообщения();
	
	Если СтрДлина(Элементы.Дорожка3.ВыделенныйТекст) = 0 Тогда
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделите мышкой участок кода.';uk='Виділіть мишкою фрагмент коду.'"));
		Возврат;
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ВзятьПоле3Завершение", ЭтотОбъект, );

	Элементы.Дорожка3.ПолучитьГраницыВыделения(НСтр, НКол, КСтр, ККол);
	
	ОпределитьКоординатыПоля(Оповещение, Дорожка3, Объект.Префикс3, Объект.Суффикс3, Объект.РазделительБлоков3, НКол, ККол);
	//
КонецПроцедуры

&НаКлиенте
Процедура ОпределитьКоординатыПоляЗавершение(Результат, Контекст) Экспорт
	
	Если Результат.Значение = КодВозвратаДиалога.Нет Тогда
		Контекст.Результат.ДлинаПоля = 0;
	КонецЕсли;
	
	Если Контекст <> Неопределено И Контекст.СледующееОповещение <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(Контекст.СледующееОповещение, Контекст.Результат);
	КонецЕсли;
	
КонецПроцедуры
   
// Определяет координаты поля по выделенному участку кода дорожки.
//
&НаКлиенте
Процедура ОпределитьКоординатыПоля(Оповещение, ДанныеДорожки, Префикс, Суффикс, Разделитель, НКол, ККол)
	
	ДанныеСтрока = ДанныеДорожки;
	Если НЕ ПустаяСтрока(Префикс)
		И Префикс = Лев(ДанныеСтрока, СтрДлина(Префикс)) Тогда
		ДанныеСтрока = Прав(ДанныеСтрока, СтрДлина(ДанныеСтрока)-СтрДлина(Префикс)); // отсекаем префикс если есть
		НКол = НКол - СтрДлина(Префикс);
		ККол = ККол - СтрДлина(Префикс);
		Если НКол < 1 Тогда
			// Выделенный текст залезает на префикс.
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделенный участок кода не должен пересекаться с суффиксом, префиксом или разделителем блоков.';uk='Виділений фрагмент коду не повинен перетинатися з суфіксом, префіксом або роздільником блоків.'"));
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(Суффикс)
		И Суффикс = Прав(ДанныеСтрока, СтрДлина(Суффикс)) Тогда
		ДанныеСтрока = Лев(ДанныеСтрока, СтрДлина(ДанныеСтрока)-СтрДлина(Суффикс)); // отсекаем суффикс если есть
		Если ККол-1 > СтрДлина(ДанныеСтрока) Тогда
			// Выделенный текст залезает на суффикс.
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделенный участок кода не должен пересекаться с суффиксом, префиксом или разделителем блоков.';uk='Виділений фрагмент коду не повинен перетинатися з суфіксом, префіксом або роздільником блоків.'"));
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	НайденРазделитель = Найти(Сред(ДанныеСтрока, НКол, ККол-НКол), Разделитель);
	Если НЕ ПустаяСтрока(Разделитель) И НайденРазделитель > 0 Тогда
		// Выделенный текст пересекается с разделителем.
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделенный участок кода не должен пересекаться с суффиксом, префиксом или разделителем блоков.';uk='Виділений фрагмент коду не повинен перетинатися з суфіксом, префіксом або роздільником блоків.'"));
		Возврат;
	КонецЕсли;
	
	НомерБлока = 1;
	НомерПервогоСимволаПоля = 1;
	ДлинаПоля = 1;
	
	Пока СтрДлина(ДанныеСтрока) > 0 Цикл
		ПозицияРазделителя = Найти(ДанныеСтрока, Разделитель);
		Если ПозицияРазделителя > НКол Тогда
			НомерПервогоСимволаПоля = НКол;
			ДлинаПоля = ?(ККол > ПозицияРазделителя, ПозицияРазделителя - НКол, ККол - НКол);
			Прервать;
		КонецЕсли;
		
		Если ПозицияРазделителя = 0 ИЛИ ПустаяСтрока(Разделитель) Тогда
			НомерПервогоСимволаПоля = НКол;
			ДлинаПоля = ККол - НКол;
			Прервать;
		ИначеЕсли ПозицияРазделителя = 1 Тогда
			// Выделенный текст пересекается с разделителем.
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Выделенный участок кода не должен пересекаться с суффиксом, префиксом или разделителем блоков.';uk='Виділений фрагмент коду не повинен перетинатися з суфіксом, префіксом або роздільником блоків.'"));
			Возврат;
		Иначе
			ДанныеСтрока = Прав(ДанныеСтрока, СтрДлина(ДанныеСтрока)-ПозицияРазделителя);
			НКол = НКол - ПозицияРазделителя;
			ККол = ККол - ПозицияРазделителя;
		КонецЕсли;
		НомерБлока = НомерБлока + 1;
	КонецЦикла;
	
	Если ККол = СтрДлина(ДанныеСтрока)+1
		Или Сред(ДанныеСтрока, ККол, 1) = Разделитель Тогда
		
		Результат = Новый Структура("НомерБлока, НомерПервогоСимволаПоля, ДлинаПоля", НомерБлока, НомерПервогоСимволаПоля, ДлинаПоля);
		
		Контекст = Новый Структура;
		Контекст.Вставить("СледующееОповещение", Оповещение);
		Контекст.Вставить("Результат", Результат);
		СледующееОповещение = Новый ОписаниеОповещения("ОпределитьКоординатыПоляЗавершение", ЭтотОбъект, Контекст);
		
		СписокКнопок = Новый СписокЗначений;
		СписокКнопок.Добавить(КодВозвратаДиалога.Да, НСтр("ru='Длина поля фиксированная';uk='Довжина поля фіксована'"));
		СписокКнопок.Добавить(КодВозвратаДиалога.Нет, НСтр("ru='Длина поля ограничивается разделителем или концом строки';uk='Довжина поля обмежується роздільником або кінцем рядка'"));
		ПоказатьВыборИзМеню(СледующееОповещение, СписокКнопок, );
		Возврат;
		
	КонецЕсли;
	
	Результат = Новый Структура("НомерБлока, НомерПервогоСимволаПоля, ДлинаПоля", НомерБлока, НомерПервогоСимволаПоля, ДлинаПоля);
	ВыполнитьОбработкуОповещения(Оповещение, Результат);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрольУникальностиПолей(Отказ)
	
	СписокДублей = Новый Массив;
	Для ВремИндекс = 1 По 3 Цикл
		Если Объект["ДоступностьДорожки"+Строка(ВремИндекс)] Тогда
			Для каждого текСтрока Из Объект["ПоляДорожки"+Строка(ВремИндекс)] Цикл
				КонтрольУникальностиПоля(СписокДублей, текСтрока.Поле, текСтрока.НомерСтроки, "ПоляДорожки"+Строка(ВремИндекс), Отказ);
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура КонтрольУникальностиПоля(СписокДублей, Поле, НомерТекущейСтроки, ИмяТаблицы, Отказ)
	Если ЗначениеЗаполнено(Поле) Тогда
		Если СписокДублей.Найти(Поле) = Неопределено Тогда
			СчетчикДублей = 0;
			Для ВремИндекс = 1 По 3 Цикл
				Если НЕ Объект["ДоступностьДорожки"+Строка(ВремИндекс)] Тогда
					Продолжить;
				КонецЕсли;
				
				Для каждого текПоле Из Объект["ПоляДорожки"+Строка(ВремИндекс)] Цикл
					Если текПоле.Поле = Поле Тогда
						СчетчикДублей = СчетчикДублей + 1;
						Если СчетчикДублей > 1 Тогда
							СтрСообщение = НСтр("ru='Дорожка %1, строка %2: Поле должно быть уникальным.';uk='Доріжка %1, рядок %2: Поле має бути унікальним.'");
							СтрСообщение = СтрЗаменить(СтрСообщение, "%1", Прав("ПоляДорожки"+Строка(ВремИндекс),1));
							СтрСообщение = СтрЗаменить(СтрСообщение, "%2", Строка(текПоле.НомерСтроки));
							ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрСообщение
								, ,"Объект."+"ПоляДорожки"+Строка(ВремИндекс)+"["+Строка(текПоле.НомерСтроки-1)+"].Поле", , Отказ);
						КонецЕсли;
					КонецЕсли;
				КонецЦикла;
			КонецЦикла;
			Если СчетчикДублей > 1 Тогда
				СписокДублей.Добавить(Поле);
			КонецЕсли;
		КонецЕсли;
		
	Иначе
		СтрСообщение = НСтр("ru='Дорожка %1, строка %2: Поле не может быть пустым.';uk='Доріжка %1, рядок %2: Поле не може бути порожнім.'");
		СтрСообщение = СтрЗаменить(СтрСообщение, "%1", Прав(ИмяТаблицы,1));
		СтрСообщение = СтрЗаменить(СтрСообщение, "%2", Строка(НомерТекущейСтроки));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СтрСообщение
			, ,"Объект."+ИмяТаблицы+"["+Строка(НомерТекущейСтроки-1)+"].Поле", , Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьШаблон()
	
	ДанныеШаблона = Новый Структура();
	ДанныеШаблона.Вставить("ДоступностьДорожки1", Объект.ДоступностьДорожки1);
	ДанныеШаблона.Вставить("ДоступностьДорожки2", Объект.ДоступностьДорожки2);
	ДанныеШаблона.Вставить("ДоступностьДорожки3", Объект.ДоступностьДорожки3);
	ДанныеШаблона.Вставить("Префикс1",   Объект.Префикс1);
	ДанныеШаблона.Вставить("Префикс2",   Объект.Префикс2);
	ДанныеШаблона.Вставить("Префикс3",   Объект.Префикс3);
	ДанныеШаблона.Вставить("ДлинаКода1", Объект.ДлинаКода1);
	ДанныеШаблона.Вставить("ДлинаКода2", Объект.ДлинаКода2);
	ДанныеШаблона.Вставить("ДлинаКода3", Объект.ДлинаКода3);
	ДанныеШаблона.Вставить("Суффикс1",   Объект.Суффикс1);
	ДанныеШаблона.Вставить("Суффикс2",   Объект.Суффикс2);
	ДанныеШаблона.Вставить("Суффикс3",   Объект.Суффикс3);
	ДанныеШаблона.Вставить("РазделительБлоков1", Объект.РазделительБлоков1);
	ДанныеШаблона.Вставить("РазделительБлоков2", Объект.РазделительБлоков2);
	ДанныеШаблона.Вставить("РазделительБлоков3", Объект.РазделительБлоков3);
	ДанныеШаблона.Вставить("Ссылка", Объект.Ссылка);
	
	ОткрытьФорму("Справочник.ШаблоныМагнитныхКарт.Форма.ФормаПроверкиШаблона"
		, Новый Структура("ДанныеШаблона", ДанныеШаблона), ЭтотОбъект, ,,,, РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);      
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьШаблонЗавершение(Результат, Параметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Да Тогда
		
		Если НЕ ЭтотОбъект.Записать() Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Не удалось записать шаблон';uk='Не вдалося записати шаблон'"));
			Возврат;
		КонецЕсли;
		
		ПроверитьШаблон();
		
	КонецЕсли;  
	
КонецПроцедуры  

&НаКлиенте
Процедура ПроверитьШаблонКоманда(Команда)
	
	// Проверяем форму на модифицированность.
	// Чтобы изменения шаблона вступили в силу их надо обязательно записать.
	Если ЭтотОбъект.Модифицированность Тогда
		ТекстВопроса = НСтр("ru='Шаблон был изменен, записать изменения?';uk='Шаблон був змінений, записати зміни?'");
		Оповещение = Новый ОписаниеОповещения("ПроверитьШаблонЗавершение", ЭтотОбъект);
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	Иначе
		ПроверитьШаблон();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

// Устанавливает доступность полей дорожек в зависимости от положения соответствующего флага.
&НаКлиенте
Процедура ДоступностьДорожки1ПриИзменении(Элемент)
	
	УстановитьДоступностьДорожек();
	
КонецПроцедуры

&НаКлиенте
Процедура ДоступностьДорожки2ПриИзменении(Элемент)
	
	УстановитьДоступностьДорожек();
	
КонецПроцедуры

&НаКлиенте
Процедура ДоступностьДорожки3ПриИзменении(Элемент)
	
	УстановитьДоступностьДорожек();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьДорожек()
	
	Элементы.ДоступностьДорожки1.Доступность = Объект.ДоступностьДорожки1;
	Элементы.ДлинаКода1.Доступность = Объект.ДоступностьДорожки1;
	Элементы.Суффикс1.Доступность = Объект.ДоступностьДорожки1;
	Элементы.РазделительБлоков1.Доступность = Объект.ДоступностьДорожки1;
	Элементы.ПоляДорожки1.Доступность = Объект.ДоступностьДорожки1;

	Элементы.ДоступностьДорожки2.Доступность = Объект.ДоступностьДорожки2;
	Элементы.ДлинаКода2.Доступность = Объект.ДоступностьДорожки2;
	Элементы.Суффикс2.Доступность = Объект.ДоступностьДорожки2;
	Элементы.РазделительБлоков2.Доступность = Объект.ДоступностьДорожки2;
	Элементы.ПоляДорожки2.Доступность = Объект.ДоступностьДорожки2;

	Элементы.ДоступностьДорожки3.Доступность = Объект.ДоступностьДорожки3;
	Элементы.ДлинаКода3.Доступность = Объект.ДоступностьДорожки3;
	Элементы.Суффикс3.Доступность = Объект.ДоступностьДорожки3;
	Элементы.РазделительБлоков3.Доступность = Объект.ДоступностьДорожки3;
	Элементы.ПоляДорожки3.Доступность = Объект.ДоступностьДорожки3;
	
КонецПроцедуры

#КонецОбласти
