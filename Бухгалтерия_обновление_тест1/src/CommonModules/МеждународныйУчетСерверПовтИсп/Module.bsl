////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции подсистемы "Международный финансовый учет".
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Возвращает параметры регистра для отражения в международном учете.
//
// Параметры:
//	ИмяРегистра - Строка - имя регистра, для которого возвращаются параметры отражения.
//
// Возвращаемое значение:
//	Структура из КлючИЗначение - Структура возвращаемых параметров:
//		* Показатели - см. МеждународныйУчетСерверПовтИсп.Показатели
//		* ПоказателиВВалюте - см. МеждународныйУчетСерверПовтИсп.ПоказателиВВалюте
//		* ПоказателиКоличества - см. МеждународныйУчетСерверПовтИсп.ПоказателиКоличества
//		* ИсточникиУточненияСчета - см. МеждународныйУчетСерверПовтИсп.ИсточникиУточненияСчета
//		* ИсточникиПодразделений - см. МеждународныйУчетСерверПовтИсп.ИсточникиПодразделений
//		* ИсточникиНаправлений - см. МеждународныйУчетСерверПовтИсп.ИсточникиНаправлений
//		* ИсточникиСубконто - см. МеждународныйУчетСерверПовтИсп.ИсточникиСубконто
Функция ПараметрыРегистра(ИмяРегистра) Экспорт

	ПараметрыОтражения = Новый Структура();
	ПараметрыОтражения.Вставить("Показатели", МеждународныйУчетСерверПовтИсп.Показатели(ИмяРегистра));
	ПараметрыОтражения.Вставить("ПоказателиВВалюте", МеждународныйУчетСерверПовтИсп.ПоказателиВВалюте(ИмяРегистра));
	ПараметрыОтражения.Вставить("ПоказателиКоличества", МеждународныйУчетСерверПовтИсп.ПоказателиКоличества(ИмяРегистра));
	ПараметрыОтражения.Вставить("ИсточникиУточненияСчета", МеждународныйУчетСерверПовтИсп.ИсточникиУточненияСчета(ИмяРегистра));
	ПараметрыОтражения.Вставить("ИсточникиПодразделений", МеждународныйУчетСерверПовтИсп.ИсточникиПодразделений(ИмяРегистра));
	ПараметрыОтражения.Вставить("ИсточникиНаправлений", МеждународныйУчетСерверПовтИсп.ИсточникиНаправлений(ИмяРегистра));
	ПараметрыОтражения.Вставить("ИсточникиСубконто", МеждународныйУчетСерверПовтИсп.ИсточникиСубконто(ИмяРегистра));
	
	Возврат ПараметрыОтражения;

КонецФункции

// Определяет источники уточнения счета, доступные в регистре и их свойства.
//
// Параметры:
//  ИмяРегистра - Строка - имя регистра.
//
// Возвращаемое значение:
//  Соответствие - Ключ - название источника уточнения счета. 
//				   Значение - структура свойств источника уточнения счета.
//
Функция ИсточникиУточненияСчета(ИмяРегистра) Экспорт

	Если ПустаяСтрока(ИмяРегистра) ИЛИ Метаданные.РегистрыНакопления.Найти(ИмяРегистра) = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	СвойстваИсточника = СвойстваИсточникаУточненияСчета();
	ИсточникиУточненияСчета = РегистрыНакопления[ИмяРегистра].ИсточникиУточненияСчета(СвойстваИсточника);
	
	Возврат ИсточникиУточненияСчета;

КонецФункции

// Определяет источники подразделений регистра и их свойства.
//
// Параметры:
//  ИмяРегистра - Строка - имя регистра.
//
// Возвращаемое значение:
//  Соответствие - Ключ - имя источника. 
//				   Значение - структура свойств источника. 
//
Функция ИсточникиПодразделений(ИмяРегистра) Экспорт

	Если ПустаяСтрока(ИмяРегистра) ИЛИ Метаданные.РегистрыНакопления.Найти(ИмяРегистра) = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ИсточникиПодразделений = РегистрыНакопления[ИмяРегистра].ИсточникиПодразделений();
	
	Возврат ИсточникиПодразделений;

КонецФункции

// Определяет источники направлений регистра и их свойства.
//
// Параметры:
//  ИмяРегистра - Строка - имя регистра.
//
// Возвращаемое значение:
//  Соответствие - Ключ - имя источника. 
//				   Значение - структура свойств источника. 
//
Функция ИсточникиНаправлений(ИмяРегистра) Экспорт

	Если ПустаяСтрока(ИмяРегистра) ИЛИ Метаданные.РегистрыНакопления.Найти(ИмяРегистра) = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ИсточникиНаправлений = РегистрыНакопления[ИмяРегистра].ИсточникиНаправлений();
	
	Возврат ИсточникиНаправлений;

КонецФункции

// Определяет источники заполнения субконто.
//
// Параметры:
//  ИмяРегистра - Строка - имя регистра.
//
// Возвращаемое значение:
//  Массив - массив атрибутов регистра.
//
Функция ИсточникиСубконто(ИмяРегистра) Экспорт

	Если ПустаяСтрока(ИмяРегистра) ИЛИ Метаданные.РегистрыНакопления.Найти(ИмяРегистра) = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	ИсточникиСубконто = РегистрыНакопления[ИмяРегистра].ИсточникиСубконто();
	
	Возврат ИсточникиСубконто;

КонецФункции

// Определяет показатели регистра.
//
// Параметры:
//  ИмяРегистра - Строка - имя регистра.
//
// Возвращаемое значение:
//  Соответствие из КлючИЗначение - :
//   Ключ - Перечисления.ПоказателиАналитическихРегистров - имя показателя
//   Значение - Структура из КлючИЗначение - Описание свойств показателя:
//    *Ресурсы - Массив из Структура-:
//     **Имя - Строка - 
//     **ИсточникВалюты - Массив Из Строка -
//
Функция Показатели(ИмяРегистра) Экспорт

	Если ПустаяСтрока(ИмяРегистра) ИЛИ Метаданные.РегистрыНакопления.Найти(ИмяРегистра) = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	СвойстваПоказателей = СвойстваПоказателей();
	Если Метаданные.РегистрыНакопления.Найти(ИмяРегистра) <> Неопределено Тогда
		Показатели = РегистрыНакопления[ИмяРегистра].Показатели(СвойстваПоказателей);
	Иначе
		Показатели = Неопределено;
	КонецЕсли;
	
	Возврат Показатели;

КонецФункции

// Определяет показатели в валюте регистра.
//
// Параметры:
//  ИмяРегистра - Строка - имя регистра.
//
// Возвращаемое значение:
//  Соответствие - Ключ - имя показателя.
//				   Значение - структура свойств показателя.
//
Функция ПоказателиВВалюте(ИмяРегистра) Экспорт

	Если ПустаяСтрока(ИмяРегистра) ИЛИ Метаданные.РегистрыНакопления.Найти(ИмяРегистра) = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	СвойстваПоказателей = СвойстваПоказателейВВалюте();
	ПоказателиВВалюте = РегистрыНакопления[ИмяРегистра].ПоказателиВВалюте(СвойстваПоказателей);
	
	Возврат ПоказателиВВалюте;

КонецФункции

// Определяет показатели количества.
//
// Параметры:
//  ИмяРегистра - Строка - имя регистра.
//
// Возвращаемое значение:
//  Соответствие - Ключ - имя источника. 
//				   Значение - структура свойств источника. 
//
Функция ПоказателиКоличества(ИмяРегистра) Экспорт

	Если ПустаяСтрока(ИмяРегистра) ИЛИ Метаданные.РегистрыНакопления.Найти(ИмяРегистра) = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ПоказателиКоличества = РегистрыНакопления[ИмяРегистра].ПоказателиКоличества();
	
	Возврат ПоказателиКоличества;

КонецФункции
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция СвойстваИсточникаУточненияСчета()

	// Расшифровка свойств источника:
	// ИмяПоля - имя атрибута регистра накопления, из которого планируется получать источник уточнения счета.
	
	Возврат "ИмяПоля";

КонецФункции

Функция СвойстваПоказателей()

	СвойстваПоказателей = Новый Структура("СвойстваПоказателей, СвойстваРесурсов");
	
	// Расшифровка свойств показателей:
	// Ресурсы - массив ресурсов регистра, связанных с показателем.
	СвойстваПоказателей.СвойстваПоказателей = "Ресурсы";
	
	// Расшифровка свойств ресурсов:
	// Имя - имя ресурса регистра.
	// ИсточникВалюты - источник валюты для ресурса регистра.
	СвойстваПоказателей.СвойстваРесурсов = "Имя, ИсточникВалюты";
	
	Возврат СвойстваПоказателей;

КонецФункции

Функция СвойстваПоказателейВВалюте()

	// Расшифровка свойств показателей:
	// ИсточникВалюты - источник валюты для показателя регистра.
	
	Возврат "ИсточникВалюты";

КонецФункции

#КонецОбласти
