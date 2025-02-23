
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ Параметры.Свойство("АдресТаблицыЭлементов")
		ИЛИ НЕ Параметры.Свойство("АдресЭлементовОтчета")
		ИЛИ НЕ Параметры.Свойство("ИспользоватьДляВводаПлана", ИспользоватьДляВводаПлана)
		ИЛИ НЕ Параметры.Свойство("АдресРедактируемогоЭлемента", АдресРедактируемогоЭлемента) Тогда
		
		ТекстСообщения = НСтр("ru='Непосредственное открытие этой формы не предусмотрено.';uk='Безпосереднє відкриття цієї форми не передбачено.'");
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	Справочники.ЭлементыФинансовыхОтчетов.ФормаПриСозданииНаСервере(ЭтотОбъект);
	ЗначениеВРеквизитФормы(ПолучитьИзВременногоХранилища(Параметры.АдресТаблицыЭлементов), "ЭлементыТаблицы");
	
	Элементы.ФормаЗавершитьРедактирование.Заголовок = НСтр("ru='Выбрать';uk='Обрати'");
	
	ЭтоПростаяТаблица = Ложь;
	
	Шапка = РеквизитФормыВЗначение("Объект").ПолучитьМакет("ЛегендаНастройкиЯчеек");
	ПредставлениеОтчета.Очистить();
	ПредставлениеОтчета.Вывести(Шапка.ПолучитьОбласть("ЛегендаОбластиВыбора"));
	
	ДеревоЭлементовОтчета = ПолучитьИзВременногоХранилища(Параметры.АдресЭлементовОтчета);
	ЗначениеВРеквизитФормы(ДеревоЭлементовОтчета, "ЭлементыОтчета");
	СтруктураШирин = Справочники.ЭлементыФинансовыхОтчетов.ВывестиТаблицуНастройкиСложнойТаблицы(
		ЭтотОбъект, ДеревоЭлементовОтчета);
	
	ШиринаМакета = СтруктураШирин.мШиринаМакета;
	ВысотаМакета = СтруктураШирин.мВысотаМакета;
	ВысотаШапки = СтруктураШирин.мВысотаШапки;
	ГлубинаОбъединения = БюджетнаяОтчетностьРасчетКэшаСервер.РассчитатьГлубинуУровней(ДеревоЭлементовОтчета);
	
	РедактируемаяЯчейка = ЭлементыТаблицы.НайтиСтроки(Новый Структура("Элемент", АдресРедактируемогоЭлемента))[0];
	
	ДоступныеЭлементыСоответствие = Новый Соответствие;
	
	СтартРасчета = ФинансоваяОтчетностьСервер.ПодчиненныйЭлемент(
		ДеревоЭлементовОтчета, "АдресСтруктурыЭлемента", РедактируемаяЯчейка.Строка);
	РассчитатьДоступныеРодительскиеЭлементы(ДоступныеЭлементыСоответствие, СтартРасчета);
	
	СтартРасчета = ФинансоваяОтчетностьСервер.ПодчиненныйЭлемент(
		ДеревоЭлементовОтчета, "АдресСтруктурыЭлемента", РедактируемаяЯчейка.Колонка);
	РассчитатьДоступныеРодительскиеЭлементы(ДоступныеЭлементыСоответствие, СтартРасчета);

	ДоступныеЭлементы = Новый ФиксированноеСоответствие(ДоступныеЭлементыСоответствие);
	
	РассчитатьДоступностьЯчеек();

	СобытияФорм.ПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);

КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Справочники.ЭлементыФинансовыхОтчетов.ФормаПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПредставлениеОтчетаВыбор(Элемент, Область, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЗавершитьРедактирование(Неопределено);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗавершитьРедактирование(Команда)
	
	Область = Элементы.ПредставлениеОтчета.ТекущаяОбласть;
	
	Расшифровка = РасшифровкаОбластиТабличногоДокумента(Область);
	РасшифровкаЭтоСтруктура = (ТипЗнч(Расшифровка) = Тип("Структура"));
	
	Если Область.Лево <> Область.Право
		ИЛИ Область.Верх <> Область.Низ
		ИЛИ Не РасшифровкаЭтоСтруктура
		ИЛИ Не Область.Расшифровка.Свойство("ДоступнаДляВыбора")
		ИЛИ Не Область.Расшифровка.ДоступнаДляВыбора Тогда
		
		Если Не РасшифровкаЭтоСтруктура Или Не Область.Расшифровка.Свойство("ТипЯчейки") Тогда
			
			ТекстПредупреждения = НСтр("ru='Область недоступна для выбора.';uk='Область недоступна для вибору.'");
			
		ИначеЕсли Область.Расшифровка.Свойство("ТипЯчейки") Тогда
			
			Если Область.Расшифровка.ТипЯчейки = -1 Тогда // Не указан вид элемента
				ТекстПредупреждения = НСтр("ru='Ячейка не доступна, так как у нее не выбран тип.';uk='Комірка не доступна, так як у неї не вибрано тип.'");
			ИначеЕсли Область.Расшифровка.ТипЯчейки = 0 Тогда // Недоступна для выбора
				ТекстПредупреждения = НСтр("ru='Область недоступна для выбора.';uk='Область недоступна для вибору.'");
			ИначеЕсли Область.Расшифровка.ТипЯчейки = 2 Тогда // Текущая выбранная ячейка
				ТекстПредупреждения = НСтр("ru='Текущая ячейка уже выбрана.';uk='Поточна комірка вже вибрана.'");
			ИначеЕсли Область.Расшифровка.ТипЯчейки = 3 Тогда // Исходная ячейка
				ТекстПредупреждения = НСтр("ru='Текущая ячейка не может быть выбрана в качестве операнда для самой себя.';uk='Поточна комірка не може бути вибрана в якості операнда для самої себе.'");
			КонецЕсли;
			
		КонецЕсли;
		
		ПоказатьПредупреждение(, ТекстПредупреждения);
		Возврат;
		
	КонецЕсли;
	
	СтрокаЯчейки = Неопределено;
	КолонкаЯчейки = Неопределено;
		
	ИмяЯчейки = "";
	Если РасшифровкаЭтоСтруктура Тогда
		СтрокаЯчейки = Расшифровка.Строка.ЭлементОтчета;
		КолонкаЯчейки = Расшифровка.Колонка.ЭлементОтчета;
		ИмяЯчейки = Расшифровка.Строка.Наименование + БюджетнаяОтчетностьКлиентСервер.РазделительЯчеекСложнойТаблицы()
			+ " " + Расшифровка.Колонка.Наименование;
	КонецЕсли;
	
	ДополнительныеПараметры = Новый Структура("ИмяЯчейки", ИмяЯчейки);
	
	ФинансоваяОтчетностьКлиент.ЗавершитьРедактированиеЭлементаОтчета(ЭтотОбъект, ДополнительныеПараметры);
	
КонецПроцедуры


&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтотОбъект, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции


// Возвращает описанное значение расшифровки из области табличного документа.
// 
// Параметры:
// 	Область - ОбластьЯчеекТабличногоДокумента - 
// Возвращаемое значение:
// 	Структура - Структура расшифровки (см. Справочник.ЭлементыФинансовыхОтчетов.ВывестиЯчейки):
// 	 *Строка - Структура -:
// 	   **Наименование - Строка -
// 	   **ЭлементОтчета - СправочникСсылка.ЭлементыФинансовыхОтчетов, Строка - Элемент отчета или адрес временного хранилища.
// 	 *Колонка - Структура -:
// 	   **Наименование - Строка -
// 	   **ЭлементОтчета - СправочникСсылка.ЭлементыФинансовыхОтчетов, Строка - Элемент отчета или адрес временного хранилища.
// 	 *ВидЭлемента - ПеречислениеСсылка.ВидыЭлементовФинансовогоОтчета -
// 	 *ЭлементОтчета - СправочникСсылка.ЭлементыФинансовыхОтчетов, Строка - Элемент отчета или адрес временного хранилища.
// 	 *ЭтоСвязанный - Булево -
// 	
&НаКлиенте
Функция РасшифровкаОбластиТабличногоДокумента(Область)
	Возврат Область.Расшифровка;
КонецФункции

&НаСервере
Процедура ДополнитьДоступныеЭлементыПодчиненными(ДоступныеСтроки, СтартРасчета, ТолькоФиксированные = Ложь)
	
	Для Каждого Элемент Из СтартРасчета.Строки Цикл
		Если ТолькоФиксированные И Не БюджетнаяОтчетностьРасчетКэшаСервер.ЭтоФиксированныйЭлемент(Элемент) Тогда
			Продолжить;
		КонецЕсли;
		
		ДоступныеСтроки.Вставить(Элемент.АдресСтруктурыЭлемента, Истина);
		ДополнитьДоступныеЭлементыПодчиненными(ДоступныеСтроки, Элемент, ТолькоФиксированные);
			
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура РассчитатьДоступныеРодительскиеЭлементы(ДоступныеЭлементы, СтартРасчета)
	
	// доступны все "фиксированные" колонки текущего и верхнего уровней
	ВПорядкеРодителейБылПеречислимыйТип = Не БюджетнаяОтчетностьРасчетКэшаСервер.ЭтоФиксированныйЭлемент(СтартРасчета);
	ТекущийРодитель = СтартРасчета.Родитель;
	Пока Истина Цикл
		
		ДоступныеЭлементы.Вставить(ТекущийРодитель.АдресСтруктурыЭлемента, Истина);
		
		Для Каждого ЭлементТекущегоУровня Из ТекущийРодитель.Строки Цикл
			
			ЭтоТекущаяКолонка = ЭлементТекущегоУровня.АдресСтруктурыЭлемента = СтартРасчета.АдресСтруктурыЭлемента;
			Если БюджетнаяОтчетностьРасчетКэшаСервер.ЭтоФиксированныйЭлемент(ЭлементТекущегоУровня)
				ИЛИ ЭтоТекущаяКолонка Тогда
				
				ДоступныеЭлементы.Вставить(ЭлементТекущегоУровня.АдресСтруктурыЭлемента, Истина);
				ДополнитьДоступныеЭлементыПодчиненными(ДоступныеЭлементы,
							ЭлементТекущегоУровня,
							ВПорядкеРодителейБылПеречислимыйТип
							И Не ЭтоТекущаяКолонка);
				
			КонецЕсли;
			
		КонецЦикла;
		
		Если ТекущийРодитель.ВидЭлемента = Перечисления.ВидыЭлементовФинансовогоОтчета.Строки
			ИЛИ ТекущийРодитель.ВидЭлемента = Перечисления.ВидыЭлементовФинансовогоОтчета.Колонки Тогда
			Возврат;
		КонецЕсли;
		
		ВПорядкеРодителейБылПеречислимыйТип = ВПорядкеРодителейБылПеречислимыйТип
				ИЛИ Не БюджетнаяОтчетностьРасчетКэшаСервер.ЭтоФиксированныйЭлемент(ТекущийРодитель);
		
		ТекущийРодитель = ТекущийРодитель.Родитель;
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьОбластьРедактирования(Форма)
	
	Результат = Новый Структура;
	Результат.Вставить("Верх",  Форма.ПерваяСтрока + Форма.ВысотаШапки + 1); //первая строка после шапки
	Результат.Вставить("Лево",  2 + Форма.ГлубинаОбъединения);               //все строки во второй колонке, значит редактируем с третьей колонки
	Результат.Вставить("Низ",   Форма.ПерваяСтрока + Форма.ВысотаМакета);    //до последней строки
	Результат.Вставить("Право", 2 + Форма.ГлубинаОбъединения - 1 + Форма.ШиринаМакета); //до последней колонки
	
	Возврат Результат;
	
КонецФункции

// Возвращает тип ячейки.
// 
// Параметры:
// 	ОписаниеЯчейки - См. РасшифровкаОбластиТабличногоДокумента
// Возвращаемое значение:
// 	Число - тия ячейки.
// 		1 - не указан вид элемента.
// 		0 - недоступна для выбора.
// 		1 - доступна для выбора.
// 		2 - текущая выбранная ячейка.
// 		3 - исходная ячейка.
&НаСервере
Функция ТипЯчейки(ОписаниеЯчейки)
	
	Если ОписаниеЯчейки.Строка.ЭлементОтчета = СтрокаЯчейки
		И ОписаниеЯчейки.Колонка.ЭлементОтчета = КолонкаЯчейки Тогда
		Возврат 2;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ОписаниеЯчейки.ЭлементОтчета) Тогда
		Возврат -1;
	КонецЕсли;
	
	Если ОписаниеЯчейки.ЭлементОтчета = АдресРедактируемогоЭлемента Тогда
		Возврат 3;
	КонецЕсли;
	
	Если ДоступныеЭлементы.Получить(ОписаниеЯчейки.Строка.ЭлементОтчета) <> Истина Тогда
		Возврат 0;
	КонецЕсли;
	
	Если ДоступныеЭлементы.Получить(ОписаниеЯчейки.Колонка.ЭлементОтчета) <> Истина Тогда
		Возврат 0;
	КонецЕсли;
	
	Возврат 1;
	
КонецФункции

&НаСервере
Процедура РассчитатьДоступностьЯчеек()
	
	ЛокальныйКэш = Новый Структура;
	
	ОбластьРедактирования = ПолучитьОбластьРедактирования(ЭтотОбъект);
	Для Колонка = ОбластьРедактирования.Лево По ОбластьРедактирования.Право Цикл
		Для Строка = ОбластьРедактирования.Верх По ОбластьРедактирования.Низ Цикл
			Область = ПредставлениеОтчета.Область(Строка, Колонка);
			ОписаниеЯчейки = Область.Расшифровка;
			ТипЯчейки = ТипЯчейки(ОписаниеЯчейки);
			ОписаниеЯчейки.Вставить("ДоступнаДляВыбора", ТипЯчейки = 1);
			ОписаниеЯчейки.Вставить("ТипЯчейки", ТипЯчейки);
			Если ТипЯчейки = -1 Тогда
				Область.ЦветТекста = 
					БюджетнаяОтчетностьКлиентСервер.ПолучитьЦветСтиля(ЛокальныйКэш, "ТекстЗапрещеннойЯчейкиЦвет");
				Область.ГоризонтальноеПоложение	 = ГоризонтальноеПоложение.Центр;
				Область.ВертикальноеПоложение	 = ВертикальноеПоложение.Центр;
			Иначе
				Область.ГоризонтальноеПоложение	 = ГоризонтальноеПоложение.Лево;
				Область.ВертикальноеПоложение	 = ВертикальноеПоложение.Верх;
				Если ТипЯчейки = 0 Тогда
					Область.ЦветТекста = 
						БюджетнаяОтчетностьКлиентСервер.ПолучитьЦветСтиля(ЛокальныйКэш, "ТекстЗапрещеннойЯчейкиЦвет");
				ИначеЕсли ТипЯчейки = 2 Тогда
					Область.ЦветФона = Новый Цвет(201, 226, 255);
				ИначеЕсли ТипЯчейки = 3 Тогда
					Область.ЦветФона = 
						БюджетнаяОтчетностьКлиентСервер.ПолучитьЦветСтиля(ЛокальныйКэш, "ЦветФонаВыделенияПоля");
					Область.ЦветТекста = 
						БюджетнаяОтчетностьКлиентСервер.ПолучитьЦветСтиля(ЛокальныйКэш, "ЦветТекстаВыделенияПоля");
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
