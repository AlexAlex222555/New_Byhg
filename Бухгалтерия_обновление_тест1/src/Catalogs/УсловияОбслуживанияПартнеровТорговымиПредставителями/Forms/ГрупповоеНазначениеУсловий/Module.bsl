
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	Куратор = Настройки.Получить("Куратор");
	ТорговыйПредставитель = Настройки.Получить("ТорговыйПредставитель");
	БизнесРегион = Настройки.Получить("БизнесРегион");
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "ТорговыйПредставитель", ТорговыйПредставитель, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(ТорговыйПредставитель));
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Куратор", Куратор, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Куратор));
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "БизнесРегион", БизнесРегион, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(БизнесРегион));
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Элементы.СписокДобавитьУсловия.Видимость = ПравоДоступа("Добавление", Метаданные.Справочники.УсловияОбслуживанияПартнеровТорговымиПредставителями);
	Элементы.СписокИзменитьУсловия.Видимость = ПравоДоступа("Изменение",  Метаданные.Справочники.УсловияОбслуживанияПартнеровТорговымиПредставителями);
	
	СобытияФорм.ПриСозданииНаСервере(ЭтаФорма, Отказ, СтандартнаяОбработка);

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТорговыйПредставительДляОтбораПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "ТорговыйПредставитель", ТорговыйПредставитель, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(ТорговыйПредставитель));
	
КонецПроцедуры

&НаКлиенте
Процедура БизнесРегионДляОтбораПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "БизнесРегион", БизнесРегион, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(БизнесРегион));
	
КонецПроцедуры

&НаКлиенте
Процедура КураторДляОтбораПриИзменении(Элемент)
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Куратор", Куратор, ВидСравненияКомпоновкиДанных.Равно,, ЗначениеЗаполнено(Куратор));
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИзменитьУсловия(Команда)
	
	ОчиститьСообщения();
	
	Если Элементы.Список.ВыделенныеСтроки.Количество() = 0 Тогда
		ТекстСообщения = НСтр("ru='Не указаны условия, подлежащие изменению';uk='Не зазначені умови, які підлягають зміні'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	ВыделенныеКлиенты = Новый Массив;
	
	Для Каждого ВыделеннаяСтрока Из Элементы.Список.ВыделенныеСтроки Цикл
		
		ДанныеСтроки = Элементы.Список.ДанныеСтроки(ВыделеннаяСтрока);
		Если ВыделенныеКлиенты.Найти(ДанныеСтроки.Владелец) = Неопределено Тогда
			ВыделенныеКлиенты.Добавить(ДанныеСтроки.Владелец);
		КонецЕсли;
		
	КонецЦикла;
	
	ПараметрыФормыВыбора = Новый Структура;
	
	Если ВыделенныеКлиенты.Количество() = 1 Тогда
		ПараметрыФормыВыбора.Вставить("Партнер", ВыделенныеКлиенты[0]);
	КонецЕсли;
	
	ОткрытьФорму("Справочник.УсловияОбслуживанияПартнеровТорговымиПредставителями.Форма.ИзменяемыеУсловияОбслуживания",
	    ПараметрыФормыВыбора,,,,, 
		Новый ОписаниеОповещения("ИзменитьУсловияЗавершение", ЭтотОбъект), 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьУсловияЗавершение(Результат, ДополнительныеПараметры) Экспорт
    
    Если ТипЗнч(Результат) = Тип("Структура") Тогда
        
        МассивУсловий = Элементы.Список.ВыделенныеСтроки;
        
        ИзменитьУсловияОбслуживания(МассивУсловий, Результат);
        ЗаголовокОповещения = НСтр("ru='Изменение условий обслуживания партнеров';uk='Зміна умов обслуговування партнерів'");
        ТекстОповещения = НСтр("ru='Условия обслуживания партнеров изменены';uk='Умови обслуговування партнерів змінені'");
        
        ПоказатьОповещениеПользователя(ЗаголовокОповещения,,ТекстОповещения);
        
        Элементы.Список.Обновить();
        
    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ДобавитьУсловия(Команда)
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("БизнесРегион", БизнесРегион);
	
	Результат = Неопределено;

	
	ОткрытьФорму("Справочник.УсловияОбслуживанияПартнеровТорговымиПредставителями.Форма.ДобавляемыеУсловияОбслуживания", ПараметрыФормы,,,,, Новый ОписаниеОповещения("ДобавитьУсловияЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ДобавитьУсловияЗавершение(Результат, ДополнительныеПараметры) Экспорт
    
    Если ТипЗнч(Результат) = Тип("Структура") Тогда
        
        ДобавитьНовыеУсловияОбслуживания(Результат);
        ЗаголовокОповещения = НСтр("ru='Добавление условий обслуживания партнеров';uk='Додавання умов обслуговування партнерів'");
        ТекстОповещения = НСтр("ru='Добавлены новые условия обслуживания партнеров';uk='Додані нові умови обслуговування партнерів'");
        
        ПоказатьОповещениеПользователя(ЗаголовокОповещения,,ТекстОповещения);
        
        Элементы.Список.Обновить();
        
    КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ВыполнитьПереопределяемуюКоманду(Команда)
	
	СобытияФормКлиент.ВыполнитьПереопределяемуюКоманду(ЭтаФорма, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ДобавитьНовыеУсловияОбслуживания(Данные)
	
	МассивПартнеров = Данные.Партнеры; // Массив из СправочникСсылка.Партнеры
	СтруктураУсловийОбслуживания = Данные.УсловияОбслуживания;
	
	ПартнерыБезПризнакаОбслуживания = ПартнерыБезПризнакаОбслуживанияТорговымиПредставителями(МассивПартнеров);
	
	НачатьТранзакцию();
	
	Попытка
		
		Для Каждого Партнер Из МассивПартнеров Цикл
			
			Если ПартнерыБезПризнакаОбслуживания.Найти(Партнер)<>Неопределено Тогда
					
					ПартнерОбъект = Партнер.ПолучитьОбъект();
					ПартнерОбъект.ОбслуживаетсяТорговымиПредставителями = Истина;
					
					ПартнерОбъект.Записать();
				
			КонецЕсли;
			
			СоздатьНовыеУсловия(Партнер, СтруктураУсловийОбслуживания);
			
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
		
	Исключение
		
		ОтменитьТранзакцию();
		
		ТекстСообщения = НСтр("ru='Не удалось добавить условия обслуживания.';uk='Не вдалося додати умови обслуговування.'");
		
		ТекстСообщения = ТекстСообщения + Символы.ПС + НСтр("ru='Добавление условий не выполнено';uk='Додавання умов не виконано'");
		ТекстСообщения = ТекстСообщения + Символы.ПС + ОписаниеОшибки();
		
		ВызватьИсключение(ТекстСообщения);
				
	КонецПопытки;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьНовыеУсловия(Партнер, СтруктураУсловий)
	
	НовыеУсловия = Справочники.УсловияОбслуживанияПартнеровТорговымиПредставителями.СоздатьЭлемент();
			
	НовыеУсловия.Владелец = Партнер;
	ЗаполнитьЗначенияСвойств(НовыеУсловия, СтруктураУсловий,, "ГрафикПосещения");
	
	КоллекцияСтрокГрафика = СтруктураУсловий.ГрафикПосещения;
	
	Для Каждого СтрокаГрафика Из КоллекцияСтрокГрафика Цикл
		НоваяСтрока = НовыеУсловия.ГрафикПосещения.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаГрафика);
	КонецЦикла;
	
	НовыеУсловия.Записать();
			
КонецПроцедуры

&НаСервере
Функция ПартнерыБезПризнакаОбслуживанияТорговымиПредставителями(МассивПартнеров)
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Партнеры.Ссылка КАК Партнер
	|ИЗ
	|	Справочник.Партнеры КАК Партнеры
	|ГДЕ
	|	Партнеры.Ссылка В(&МассивПартнеров)
	|	И НЕ Партнеры.ОбслуживаетсяТорговымиПредставителями"
	;
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("МассивПартнеров", МассивПартнеров);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		Возврат Новый Массив;
	КонецЕсли;
	
	Возврат РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("Партнер");
	
КонецФункции

&НаСервере
// Изменяет указанные условия
//
// Параметры:
//  МассивИзменяемыхУсловий - Массив - массив из СправочникСсылка.УсловияОбслуживанияПартнеровТорговымиПредставителями   
//
Процедура ИзменитьУсловияОбслуживания(МассивИзменяемыхУсловий, СтруктураНазначаемыхУсловий)
	
	НачатьТранзакцию();
	
	Попытка
		
		Для Каждого ЭлементСправочникаУсловий Из МассивИзменяемыхУсловий Цикл
			
			УсловияОбъект = ЭлементСправочникаУсловий.ПолучитьОбъект(); // СправочникОбъект.УсловияОбслуживанияПартнеровТорговымиПредставителями 
			
			Если СтруктураНазначаемыхУсловий.Свойство("ГрафикПосещения") Тогда
				ИсключаемыеСвойства = "ГрафикПосещения";
			Иначе
				ИсключаемыеСвойства = "";
			КонецЕсли;
			
			ЗаполнитьЗначенияСвойств(УсловияОбъект, СтруктураНазначаемыхУсловий,, ИсключаемыеСвойства);
			
			Если СтруктураНазначаемыхУсловий.Свойство("ГрафикПосещения") Тогда
				
				УсловияОбъект.ГрафикПосещения.Очистить();
				
				КоллекцияСтрокГрафика = СтруктураНазначаемыхУсловий.ГрафикПосещения;
				
				Для Каждого СтрокаГрафика Из КоллекцияСтрокГрафика Цикл
					НоваяСтрока = УсловияОбъект.ГрафикПосещения.Добавить();
					ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаГрафика);
				КонецЦикла;
				
			КонецЕсли;
			
			УсловияОбъект.Записать();
			
		КонецЦикла;
		
		ЗафиксироватьТранзакцию();
	
	Исключение
		
		ОтменитьТранзакцию();
		
		ТекстСообщения = НСтр("ru='Не удалось изменить условия обслуживания.';uk='Не вдалося змінити умови обслуговування.'");
		ТекстСообщения = ТекстСообщения + Символы.ПС + НСтр("ru='Изменение условий не выполнено';uk='Зміна умов не виконана'");
		ТекстСообщения = ТекстСообщения + Символы.ПС + ОписаниеОшибки();
		
		ВызватьИсключение(ТекстСообщения);
			
	КонецПопытки;
		
КонецПроцедуры

#КонецОбласти
