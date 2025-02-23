
#Область ПрограммныйИнтерфейс

// Возвращает массив, элементами которого являются структуры параметров форм, которые требуется открыть при начале 
// работы системы.
//
// Возвращаемое значение:
//	МассивОткрываемыхФорм - Массив - массив, элементами которого являются структуры параметров форм, которые требуется 
//		открыть при начале работы системы:
//		* ИмяЗапускаемойФормы - Строка - полное имя открываемой формы.
//		* Роль - Строка - имя роли, которая дает пользователю право на запуск формы.
//		* НеобходимыНастройки - Булево - для открываемой формы должны быть заданы настройки.
//		* ИмяФормыНастроек - Строка - если НеобходимыНастройки = ИСТИНА, то в этом параметре указывается полное имя формы
//			редактирования настроек.
//		* ПараметрЗапуска - Строка - параметр запуска, наличие которого будет проверяться при начале работы системы,
//			форма будет открыта, если передан параметр запуска или настроено, что эту форму нужно открывать по умолчанию 
//			(т.е. без проверки параметра запуска).
//		* НастройкиУстановлены - Булево. Истина - настройки, необходимые для открытия формы установлены.
//		* Параметры - Структура - параметры формы, используемые при открытии формы.
//		* ОткрыватьПоУмолчанию - Булево. Истина - форма открывается по умолчанию при начале работы системы.
//
Функция ФормыОткрываемыеПриНачалеРаботыСистемы() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	МассивОткрываемыхФорм = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ФормыОткрываемыеПриНачалеРаботыСистемы.Ссылка КАК ОткрываемаяФорма,
	|	ВЫБОР
	|		КОГДА НастройкиОткрытияФормПриНачалеРаботыСистемы.Пользователь ЕСТЬ NULL 
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК НастройкиУстановлены,
	|	НастройкиОткрытияФормПриНачалеРаботыСистемы.Параметры,
	|	ВЫБОР
	|		КОГДА НастройкиОткрытияФормПриНачалеРаботыСистемы.ОткрыватьПоУмолчанию ЕСТЬ NULL 
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ НастройкиОткрытияФормПриНачалеРаботыСистемы.ОткрыватьПоУмолчанию
	|	КОНЕЦ КАК ОткрыватьПоУмолчанию
	|ИЗ
	|	Перечисление.ФормыОткрываемыеПриНачалеРаботыСистемы КАК ФормыОткрываемыеПриНачалеРаботыСистемы
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.НастройкиОткрытияФормПриНачалеРаботыСистемы КАК НастройкиОткрытияФормПриНачалеРаботыСистемы
	|		ПО ФормыОткрываемыеПриНачалеРаботыСистемы.Ссылка = НастройкиОткрытияФормПриНачалеРаботыСистемы.ОткрываемаяФорма
	|			И (НастройкиОткрытияФормПриНачалеРаботыСистемы.Пользователь = &Пользователь)";
	
	Запрос.УстановитьПараметр("Пользователь", Пользователи.АвторизованныйПользователь());
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		СтруктураПараметровФормы = ОткрытиеФормПриНачалеРаботыСистемыКлиентСерверПереопределяемый.НастройкиФормы(Выборка.ОткрываемаяФорма);
		
		СтруктураПараметровФормы.Вставить("НастройкиУстановлены", Выборка.НастройкиУстановлены);
		СтруктураПараметровФормы.Вставить("Параметры",            Новый Структура);
		СтруктураПараметровФормы.Вставить("ОткрыватьПоУмолчанию", Выборка.ОткрыватьПоУмолчанию);
		
		Если Выборка.НастройкиУстановлены Тогда
			
			Параметры = Выборка.Параметры.Получить();
			Если ТипЗнч(Параметры) = Тип("Структура") Тогда
				СтруктураПараметровФормы.Вставить("Параметры", Параметры);
			КонецЕсли;
			
		КонецЕсли;
		
		МассивОткрываемыхФорм.Добавить(СтруктураПараметровФормы);
		
	КонецЦикла;
	
	Возврат МассивОткрываемыхФорм;
	
КонецФункции

// Возвращает массив, элементами которого являются значения перечислений форм, открываемых при начале работы системы.
//
// Параметры:
//	ДанныеВыбора - Неопределено, СписокЗначений - список значений открываемых форм.
//	Параметры - Неопределено, Структура - параметры выбора.
//
// Возвращаемое значение:
//	Результат - Массив - массив, элементами которого являются значения перечислений форм, открываемых при начале 
//		работы системы.
//
Функция ИспользуемыеФормыПриНачалеРаботыСистемы(ДанныеВыбора = Неопределено, Параметры = Неопределено) Экспорт
	
	Если ПолучитьФункциональнуюОпцию("БазоваяВерсия") Тогда
		
		Если Параметры = Неопределено Тогда
			// Заполним пустые параметры аналогично параметрам события ОбработкаПолученияДанныхВыбора.
			// Необходимо если эта процедура зовется "извне".
			Параметры = Новый Структура;
			Параметры.Вставить("Отбор", Новый Структура);
			Параметры.Вставить("СтрокаПоиска");
		КонецЕсли;
		
		МассивИсключаемыхЗначений = Новый Массив;
		МассивИсключаемыхЗначений.Добавить(Перечисления.ФормыОткрываемыеПриНачалеРаботыСистемы.РабочееМестоРаботникаСклада);
		МассивИсключаемыхЗначений.Добавить(Перечисления.ФормыОткрываемыеПриНачалеРаботыСистемы.РабочееМестоМенеджераПоДоставке);
		МассивИсключаемыхЗначений.Добавить(Перечисления.ФормыОткрываемыеПриНачалеРаботыСистемы.ПомощникПродаж);
		
		ОбщегоНазначенияУТ.ДоступныеДляВыбораЗначенияПеречисления(
			"ФормыОткрываемыеПриНачалеРаботыСистемы",
			ДанныеВыбора,
			Параметры,
			МассивИсключаемыхЗначений);
		
		Результат = ДанныеВыбора.ВыгрузитьЗначения();
		
	Иначе
		
		Результат = Новый Массив;
		Для Каждого ЗначениеПеречисления Из Перечисления.ФормыОткрываемыеПриНачалеРаботыСистемы Цикл
			Результат.Добавить(ЗначениеПеречисления);
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
