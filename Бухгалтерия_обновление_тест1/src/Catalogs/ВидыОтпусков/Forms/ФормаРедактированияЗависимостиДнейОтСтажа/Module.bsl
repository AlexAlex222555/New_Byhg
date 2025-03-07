
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Пропускаем инициализацию, чтобы гарантировать получение формы при передаче параметра "АвтоТест".
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ПриПолученииДанныхНаСервере(Параметры);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыШкалаОценки

&НаКлиенте
Процедура ШкалаОценкиЗначениеОтПриИзменении(Элемент)
	
	СформироватьПредставлениеИнтервалаШкалыОценки(ШкалаОценки);
	
КонецПроцедуры

&НаКлиенте
Процедура ШкалаОценкиЗначениеДоПриИзменении(Элемент)
	
	СформироватьПредставлениеИнтервалаШкалыОценки(ШкалаОценки);
	
КонецПроцедуры

&НаКлиенте
Процедура ШкалаОценкиПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	УпорядочитьСтрокиШкалыОценки(ТекущийЭлемент.ТекущиеДанные);
	СкорректироватьСоседниеСтрокиШкалыОценки(ТекущийЭлемент.ТекущиеДанные);
	ДобавитьСтрокиШкалыОценки(ШкалаОценки);
	СкорректироватьИнтервалыШкалыОценки();
	
КонецПроцедуры

&НаКлиенте
Процедура ШкалаОценкиПослеУдаления(Элемент)
	
	ДобавитьСтрокиШкалыОценки(ШкалаОценки);
	СкорректироватьИнтервалыШкалыОценки();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Если ШкалаОценкиЗаполненаПравильно() Тогда 
		ПараметрыЗакрытия = Новый Структура("ВидСтажа", ВидСтажа);
		ПараметрыЗакрытия.Вставить("АдресШкалыОценкиСтажа", АдресШкалыОценкиСтажа());
		Оповестить("ЗаписанаШкалаОценкиСтажа", ПараметрыЗакрытия);
		Закрыть();
	Иначе
		Оповещение = Новый ОписаниеОповещения("ОбработатьОтветОКорректировкеШкалыОценки", ЭтаФорма);
		ТекстВопроса = НСтр("ru='Обнаружены неверно заполненные интервалы шкалы. Скорректировать значения интервалов автоматически?';uk='Виявлені невірно заповнені інтервали шкали. Скорегувати значення інтервалів автоматично?'");
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриПолученииДанныхНаСервере(Параметры)

	ВидСтажа = Параметры.ВидСтажа;
	ШкалаОценкиСтажа.Загрузить(ПолучитьИзВременногоХранилища(Параметры.АдресШкалыОценкиСтажа));
	ЗагрузитьШкалуСтажа();
	ПодготовитьШкалуНаСервере();

КонецПроцедуры

&НаКлиенте
Процедура УпорядочитьСтрокиШкалыОценки(ТекущиеДанные)
	
	Если ТекущиеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ТекущаяПозиция = ШкалаОценки.Индекс(ТекущиеДанные);
	НоваяПозиция = 0;
	
	Для Каждого ТекСтрока Из ШкалаОценки Цикл 
		Если НоваяПозиция <> ТекущаяПозиция И ТекСтрока.ЗначениеОт >= ТекущиеДанные.ЗначениеОт Тогда 
			Прервать;
		КонецЕсли;
		НоваяПозиция = НоваяПозиция + 1;
	КонецЦикла;
	
	Сдвиг = ?(НоваяПозиция < ТекущаяПозиция, НоваяПозиция - ТекущаяПозиция, НоваяПозиция - ТекущаяПозиция - 1);
	ШкалаОценки.Сдвинуть(ТекущаяПозиция, Сдвиг);
	
КонецПроцедуры

&НаКлиенте
Процедура СкорректироватьСоседниеСтрокиШкалыОценки(ТекущиеДанные);

	Если ТекущиеДанные = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.ЗначениеДо <= ТекущиеДанные.ЗначениеОт Тогда
		ТекущиеДанные.ЗначениеДо = 0;
		Возврат;
	КонецЕсли;	
	
	КоличествоСтрок = ШкалаОценки.Количество();
	ИндексСтроки = ШкалаОценки.Индекс(ТекущиеДанные);
	
	Если ИндексСтроки = (КоличествоСтрок - 1) Тогда 
		Возврат;
	КонецЕсли;
	
	СледующаяСтрока = ШкалаОценки[ИндексСтроки+1];
	СледующаяСтрока.ЗначениеОт = ТекущиеДанные.ЗначениеДо;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ДобавитьСтрокиШкалыОценки(ШкалаОценки)

	КоличествоСтрок = ШкалаОценки.Количество();
	Если КоличествоСтрок = 0 Тогда 
		ШкалаОценки.Добавить();
	ИначеЕсли ШкалаОценки[КоличествоСтрок-1].ЗначениеДо <> 0 
		И ШкалаОценки[КоличествоСтрок-1].ЗначениеДо > ШкалаОценки[КоличествоСтрок-1].ЗначениеОт Тогда  
		НоваяСтрока = ШкалаОценки.Добавить();
		НоваяСтрока.ЗначениеОт = ШкалаОценки[КоличествоСтрок-1].ЗначениеДо;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СкорректироватьИнтервалыШкалыОценки() 
	
	НижняяГраница = Неопределено;
	КоличествоСтрок = ШкалаОценки.Количество();
	
	Для Сч = 1 По КоличествоСтрок Цикл 
		
		ИндексСтроки = КоличествоСтрок - Сч;
		ТекСтрока = ШкалаОценки[ИндексСтроки];
		
		Если НижняяГраница <> Неопределено И НижняяГраница <> ТекСтрока.ЗначениеДо Тогда 
			ТекСтрока.ЗначениеДо = НижняяГраница;
		КонецЕсли;
		
		Если НижняяГраница = Неопределено И  ТекСтрока.ЗначениеОт = ТекСтрока.ЗначениеДо Тогда 
			ТекСтрока.ЗначениеДо = 0;
		КонецЕсли;
		
		Если ТекСтрока.ЗначениеОт > ТекСтрока.ЗначениеДо И ТекСтрока.ЗначениеДо <> 0 
			Или ТекСтрока.ЗначениеОт = ТекСтрока.ЗначениеДо И ТекСтрока.ЗначениеОт <> 0 Тогда
			ШкалаОценки.Удалить(ТекСтрока);
			Продолжить;
		КонецЕсли;
		
		НижняяГраница = ТекСтрока.ЗначениеОт;
		
	КонецЦикла;
	
	// В первой строке может быть нулевое значение До, только если это единственная строка.
	Пока ШкалаОценки.Количество() > 1 Цикл 
		Если ШкалаОценки[0].ЗначениеДо <> 0 Тогда 
			Прервать;
		КонецЕсли;
		ШкалаОценки.Удалить(0);
	КонецЦикла;
	
	СформироватьПредставлениеИнтервалаШкалыОценки(ШкалаОценки);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьОтветОКорректировкеШкалыОценки(Результат, Параметры) Экспорт

	Если Результат <> КодВозвратаДиалога.Да Тогда 
		Возврат;
	КонецЕсли;
	
	СкорректироватьИнтервалыШкалыОценки();
	
КонецПроцедуры

&НаКлиенте
Функция ШкалаОценкиЗаполненаПравильно()
	
	Отказ = Ложь;
	Ошибки = Неопределено;
	
	НижняяГраница = Неопределено;
	КоличествоСтрок = ШкалаОценки.Количество();
	
	Если КоличествоСтрок > 1 И ШкалаОценки[0].ЗначениеДо = 0 Тогда 
		ТекстСообщения = НСтр("ru='Значение ""До"" в строке 1 равно 0';uk='Значення ""До"" в рядку 1 дорівнює 0'");
		ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "ШкалаОценки[0].ЗначениеДо", ТекстСообщения);
	КонецЕсли;
	
	Для Сч = 1 По КоличествоСтрок Цикл 
		
		ИндексСтроки = КоличествоСтрок - Сч;
		ТекСтрока = ШкалаОценки[ИндексСтроки];
		
		Если ТекСтрока.ЗначениеДо <= ТекСтрока.ЗначениеОт И ТекСтрока.ЗначениеДо <> 0 Тогда 
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='В строке %1 значение ""До"" меньше или равно значению ""От""';uk='У рядку %1 значення ""До"" менше або дорівнює значенню ""Від""'"), ИндексСтроки + 1);
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "ШкалаОценки[" + Формат(ИндексСтроки, "ЧН=0; ЧГ=0") + "].ЗначениеДо", ТекстСообщения);
		КонецЕсли;
		
		Если НижняяГраница <> Неопределено И НижняяГраница <> ТекСтрока.ЗначениеДо Тогда 
			ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru='Значение ""До"" строки %1 не равно значению ""От"" строки %2';uk='Значення ""До"" рядку %1 не дорівнює значенню ""Від"" рядку %2'"), ИндексСтроки + 1, ИндексСтроки + 2);
			ОбщегоНазначенияКлиентСервер.ДобавитьОшибкуПользователю(Ошибки, "ШкалаОценки[" + Формат(ИндексСтроки, "ЧН=0; ЧГ=0") + "].ЗначениеДо", ТекстСообщения);
		КонецЕсли;
		
		НижняяГраница = ТекСтрока.ЗначениеОт;
		
	КонецЦикла;
	
	Отказ = Ложь;
	ОбщегоНазначенияКлиентСервер.СообщитьОшибкиПользователю(Ошибки, Отказ);
	
	Возврат Не Отказ;
	
КонецФункции

&НаСервере
Процедура ПодготовитьШкалуНаСервере()
	
	ДобавитьСтрокиШкалыОценки(ШкалаОценки);
	
	РеквизитыПоказателя = Новый Структура("Наименование, КраткоеНаименование, Точность", "", НСтр("ru='Стаж, мес.';uk='Стаж, міс.'"), 0); 
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "БазовыйПараметр", "Заголовок", 
		?(ЗначениеЗаполнено(РеквизитыПоказателя.КраткоеНаименование), РеквизитыПоказателя.КраткоеНаименование, РеквизитыПоказателя.Наименование));
	
	ФорматнаяСтрока = ФорматнаяСтрокаЗначения(РеквизитыПоказателя.Точность);
	Для Каждого СтрокаШкалы Из ШкалаОценки Цикл
	    СтрокаШкалы.ЗначениеОт = Формат(СтрокаШкалы.ЗначениеОт, ФорматнаяСтрока);
	    СтрокаШкалы.ЗначениеДо = Формат(СтрокаШкалы.ЗначениеДо, ФорматнаяСтрока);
	КонецЦикла;
	
	УстановитьФорматИнтервалаШкалыОценки(ЭтаФорма, ФорматнаяСтрока);
	
	СформироватьПредставлениеИнтервалаШкалыОценки(ШкалаОценки);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьФорматИнтервалаШкалыОценки(Форма, ФорматнаяСтрока)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "ШкалаОценкиЗначениеОт", "Формат", ФорматнаяСтрока);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "ШкалаОценкиЗначениеОт", "ФорматРедактирования", ФорматнаяСтрока);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "ШкалаОценкиЗначениеДо", "Формат", ФорматнаяСтрока);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "ШкалаОценкиЗначениеДо", "ФорматРедактирования", ФорматнаяСтрока);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура СформироватьПредставлениеИнтервалаШкалыОценки(ТаблицаИнтервалов)
	
	Для Каждого ТекСтрока Из ТаблицаИнтервалов Цикл 
		
		Если ТекСтрока.ЗначениеОт = 0 И ТекСтрока.ЗначениеДо = 0 Тогда 
			ПредставлениеОт = НСтр("ru='от';uk='від'");
			ПредставлениеДо = НСтр("ru='до';uk='до'");
		ИначеЕсли ТекСтрока.ЗначениеОт = 0 И ТекСтрока.ЗначениеДо <> 0 Тогда
			ПредставлениеОт = "";
			ПредставлениеДо = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='до %1';uk='до %1'"), ТекСтрока.ЗначениеДо);
		ИначеЕсли ТекСтрока.ЗначениеОт <> 0 И ТекСтрока.ЗначениеДо = 0 Тогда
			ПредставлениеОт = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='свыше %1';uk='понад %1'"), ТекСтрока.ЗначениеОт);
			ПредставлениеДо = "";
		Иначе
			ПредставлениеОт = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='от %1';uk='від %1'"), ТекСтрока.ЗначениеОт);
			ПредставлениеДо = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='до %1';uk='до %1'"), ТекСтрока.ЗначениеДо);
		КонецЕсли;
		
		ТекСтрока.ПредставлениеОт = ПредставлениеОт;	
		ТекСтрока.ПредставлениеДо = ПредставлениеДо;	
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция АдресШкалыОценкиСтажа()

	ШкалаОценкиСтажа.Очистить();
	
	// Помещаем "виртуальные" данные в таблицу значений
	ПерваяСтрока = Истина;
	Для Каждого ТекСтрока Из ШкалаОценки Цикл
		Если ПерваяСтрока Тогда 
			ПерваяСтрока = Ложь;
			Если ТекСтрока.ЗначениеОт <> 0 Тогда 
				НоваяСтрока = ШкалаОценкиСтажа.Добавить();
				НоваяСтрока.ВерхняяГраницаИнтервалаСтажа = ТекСтрока.ЗначениеОт;
				НоваяСтрока.КоличествоДнейВГод = 0;
			КонецЕсли;
		КонецЕсли;
		
		НоваяСтрока = ШкалаОценкиСтажа.Добавить();
		НоваяСтрока.ВерхняяГраницаИнтервалаСтажа = ТекСтрока.ЗначениеДо;
		НоваяСтрока.КоличествоДнейВГод = ТекСтрока.КоличествоДнейВГод;
	КонецЦикла;
	
	// Помещаем во временное хранилище. 
	Возврат ПоместитьВоВременноеХранилище(ШкалаОценкиСтажа.Выгрузить());

КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ФорматнаяСтрокаЗначения(Точность)
	
	ФорматнаяСтрока = "ЧДЦ=%1";
	ФорматнаяСтрока = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ФорматнаяСтрока, Точность);
	Возврат ФорматнаяСтрока; 
	
КонецФункции

&НаСервере
Процедура ЗагрузитьШкалуСтажа()

	ЗначениеДоПредыдущее = 0;
	Для Каждого ТекСтрока Из ШкалаОценкиСтажа Цикл 
		
		НоваяСтрока = ШкалаОценки.Добавить();
		НоваяСтрока.ЗначениеОт = ЗначениеДоПредыдущее;
		НоваяСтрока.ЗначениеДо = ТекСтрока.ВерхняяГраницаИнтервалаСтажа;
		НоваяСтрока.КоличествоДнейВГод = ТекСтрока.КоличествоДнейВГод;
		
		ЗначениеДоПредыдущее = НоваяСтрока.ЗначениеДо;
		
	КонецЦикла;

КонецПроцедуры

#КонецОбласти
