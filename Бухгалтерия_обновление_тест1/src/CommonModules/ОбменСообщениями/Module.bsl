///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2018
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Выполняет отправку сообщения в адресный канал сообщений.
// Соответствует типу отправки "Конечная точка/Конечная точка".
//
// Параметры:
//  КаналСообщений - Строка - Идентификатор адресного канала сообщений.
//  ТелоСообщения - Произвольный - Тело сообщения системы, которое необходимо отправить.
//  Получатель - Неопределено - получатель сообщения не указан. Сообщение будет отправлено конечным точкам, 
//                              которые определяются настройками текущей информационной системы:
//                              в обработчике ОбменСообщениямиПереопределяемый.ПолучателиСообщения (программно)
//                              и в регистре сведений НастройкиОтправителя (настройка системы).
//             - ПланОбменаСсылка.ОбменСообщениями - узел плана обмена, который соответствует конечной точке,
//                                                   для которой предназначено сообщение. Сообщение будет отправлено
//                                                   только этой конечной точке.
//             - Массив - массив получателей сообщения; элементы массива должны иметь тип ПланОбменаСсылка.ОбменСообщениями.
//                        Сообщение будет отправлено всем конечным точкам, указанным в массиве.
//
Процедура ОтправитьСообщение(КаналСообщений, ТелоСообщения = Неопределено, Получатель = Неопределено) Экспорт
	
	ОтправитьСообщениеВКаналСообщений(КаналСообщений, ТелоСообщения, Получатель);
	
КонецПроцедуры

// Выполняет отправку сообщения в адресный канал сообщений.
// Соответствует типу отправки "Конечная точка/Конечная точка".
//
// Параметры:
//  КаналСообщений - Строка - Идентификатор адресного канала сообщений.
//  ТелоСообщения - Произвольный - Тело сообщения системы, которое необходимо отправить.
//  Получатель - Неопределено - получатель сообщения не указан. Сообщение будет отправлено конечным точкам, 
//                              которые определяются настройками текущей информационной системы:
//                              в обработчике ОбменСообщениямиПереопределяемый.ПолучателиСообщения (программно)
//                              и в регистре сведений НастройкиОтправителя (настройка системы).
//             - ПланОбменаСсылка.ОбменСообщениями - узел плана обмена, который соответствует конечной точке,
//                                                   для которой предназначено сообщение. Сообщение будет отправлено
//                                                   только этой конечной точке.
//             - Массив - массив получателей сообщения; элементы массива должны иметь тип ПланОбменаСсылка.ОбменСообщениями.
//                        Сообщение будет отправлено всем конечным точкам, указанным в массиве.
//
Процедура ОтправитьСообщениеСейчас(КаналСообщений, ТелоСообщения = Неопределено, Получатель = Неопределено) Экспорт
	
	ОтправитьСообщениеВКаналСообщений(КаналСообщений, ТелоСообщения, Получатель, Истина);
	
КонецПроцедуры

// Выполняет отправку сообщения в широковещательный канал сообщений.
// Соответствует типу отправки "Публикация/Подписка".
// Сообщение будет доставлено конечным точкам, которые подписаны на широковещательный канал.
// Настройка подписок на широковещательный канал выполняется через регистр сведений ПодпискиПолучателей.
//
// Параметры:
//  КаналСообщений - Строка - Идентификатор широковещательного канала сообщений.
//  ТелоСообщения - Произвольный - Тело сообщения системы, которое необходимо отправить.
//
Процедура ОтправитьСообщениеПодписчикам(КаналСообщений, ТелоСообщения = Неопределено) Экспорт
	
	ОтправитьСообщениеПодписчикамВКаналСообщений(КаналСообщений, ТелоСообщения);
	
КонецПроцедуры

// Выполняет отправку быстрого сообщения в широковещательный канал сообщений.
// Соответствует типу отправки "Публикация/Подписка".
// Сообщение будет доставлено конечным точкам, которые подписаны на широковещательный канал.
// Настройка подписок на широковещательный канал выполняется через регистр сведений ПодпискиПолучателей.
//
// Параметры:
//  КаналСообщений - Строка - Идентификатор широковещательного канала сообщений.
//  ТелоСообщения - Произвольный - Тело сообщения системы, которое необходимо отправить.
//
Процедура ОтправитьСообщениеПодписчикамСейчас(КаналСообщений, ТелоСообщения = Неопределено) Экспорт
	
	ОтправитьСообщениеПодписчикамВКаналСообщений(КаналСообщений, ТелоСообщения, Истина);
	
КонецПроцедуры

// Выполняет немедленную отправку быстрых сообщений из общей очереди сообщений.
// Отправка сообщений выполняется в цикле до тех пор, пока из очереди сообщений не будут отправлены все быстрые
// сообщения.
// На время отправки сообщений блокируется немедленная отправка сообщений из других сеансов.
//
Процедура ДоставитьСообщения() Экспорт
	
	Если ТранзакцияАктивна() Тогда
		ВызватьИсключение НСтр("ru='Доставка быстрых сообщений системы не может выполняться в активной транзакции.';uk='Доставка швидких повідомлень системи не може виконуватися в активній транзакції.'");
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Не НачатьОтправкуБыстрыхСообщений() Тогда
		Возврат;
	КонецЕсли;
	
	ТекстЗапроса = "";
	СправочникиСообщений = ОбменСообщениямиПовтИсп.ПолучитьСправочникиСообщений();
	Для Каждого СправочникСообщений Из СправочникиСообщений Цикл
		
		ЭтоПервыйФрагмент = ПустаяСтрока(ТекстЗапроса);
		
		Если Не ЭтоПервыйФрагмент Тогда
			
			ТекстЗапроса = ТекстЗапроса + СтрШаблон("%1%1%2%1%1", Символы.ПС, "ОБЪЕДИНИТЬ ВСЕ");
			
		КонецЕсли;
		
		ТекстЗапроса = ТекстЗапроса
			+ "ВЫБРАТЬ
			|	ТаблицаИзменений.Узел КАК КонечнаяТочка,
			|	ТаблицаИзменений.Ссылка КАК Сообщение
			|[ПОМЕСТИТЬ]
			|ИЗ
			|	[СправочникСообщений].Изменения КАК ТаблицаИзменений
			|ГДЕ
			|	ТаблицаИзменений.Ссылка.ЭтоБыстроеСообщение
			|	И ТаблицаИзменений.НомерСообщения ЕСТЬ NULL
			|	И НЕ ТаблицаИзменений.Узел В (&НедоступныеКонечныеТочки)";
		
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "[СправочникСообщений]", СправочникСообщений.ПустаяСсылка().Метаданные().ПолноеИмя());
		Если ЭтоПервыйФрагмент Тогда
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "[ПОМЕСТИТЬ]", "ПОМЕСТИТЬ ВТ_Изменения");
		Иначе
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "[ПОМЕСТИТЬ]", "");
		КонецЕсли;		
	КонецЦикла;
	
	ТекстЗапроса = ТекстЗапроса + "
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТ_Изменения.КонечнаяТочка КАК КонечнаяТочка,
	|	ВТ_Изменения.Сообщение
	|ИЗ
	|	ВТ_Изменения КАК ВТ_Изменения
	|
	|УПОРЯДОЧИТЬ ПО
	|	ВТ_Изменения.Сообщение.Код
	|ИТОГИ ПО
	|	КонечнаяТочка";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	
	НедоступныеКонечныеТочки = Новый Массив;
	
	Попытка
		
		Пока Истина Цикл
			
			Запрос.УстановитьПараметр("НедоступныеКонечныеТочки", НедоступныеКонечныеТочки);
			
			РезультатЗапроса = РаботаВМоделиСервиса.ВыполнитьЗапросВнеТранзакции(Запрос);
			
			Если РезультатЗапроса.Пустой() Тогда
				Прервать;
			КонецЕсли;
			
			Группы = РезультатЗапроса.Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
			
			Для Каждого Группа Из Группы.Строки Цикл
				
				Сообщения = Группа.Строки.ВыгрузитьКолонку("Сообщение");
				
				Попытка
					
					ДоставитьСообщенияПолучателю(Группа.КонечнаяТочка, Сообщения);
					
					УдалитьРегистрациюИзменений(Группа.КонечнаяТочка, Сообщения);
					
				Исключение
					
					НедоступныеКонечныеТочки.Добавить(Группа.КонечнаяТочка);
					
					ЗаписьЖурналаРегистрации(ОбменСообщениямиВнутренний.СобытиеЖурналаРегистрацииЭтойПодсистемы(),
											УровеньЖурналаРегистрации.Ошибка,,, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
				КонецПопытки;
				
			КонецЦикла;
			
		КонецЦикла;
		
	Исключение
		ОтменитьОтправкуБыстрыхСообщений();
		ВызватьИсключение;
	КонецПопытки;
	
	ЗавершитьОтправкуБыстрыхСообщений();
	
КонецПроцедуры

// Выполняет подключение конечной точки.
// Перед подключением конечной точки выполняется проверка установки соединения 
// отправителя к получателю и получателя к отправителю. 
// Также проверяется то, что настройки подключения получателя указывают на текущего отправителя.
//
// Параметры:
//  Отказ - Булево - Флаг выполнения операции; поднимается в случае ошибок при подключении конечной точки.
//  НастройкиПодключенияОтправителя - Структура - Параметры подключения отправителя. Для инициализации используется
//                                    функция ОбменДаннымиСервер.СтруктураПараметровWS. Содержит свойства:
//    * WSURLВебСервиса   - Строка - Веб-адрес подключаемой конечной точки.
//    * WSИмяПользователя - Пользователь для аутентификации в подключаемой конечной точке
//                          при работе через web-сервис подсистемы обмена сообщениями.
//    * WSПароль          - Пароль пользователя в подключаемой конечной точке.
//  НастройкиПодключенияПолучателя - Структура - Параметры подключения получателя. Для инициализации используется
//                                   функция ОбменДаннымиСервер.СтруктураПараметровWS. Содержит свойства:
//    * WSURLВебСервиса   - Строка - Веб-адрес этой информационной базы со стороны подключаемой конечной точки.
//    * WSИмяПользователя - Пользователь для аутентификации в этой информационной базе 
//                          при работе через web-сервис подсистемы обмена сообщениями.
//    * WSПароль          - Пароль пользователя в этой информационной базе.
//  КонечнаяТочка - ПланОбменаСсылка.ОбменСообщениями, Неопределено - Если подключение конечной точки завершилось
//                  успешно, то в этот параметр возвращается ссылка на узел плана обмена,
//                  который соответствует подключенной конечной точке.
//                  Если подключить конечную точку не удалось, то возвращается Неопределено.
//  НаименованиеКонечнойТочкиПолучателя - Строка - Наименование подключаемой конечной точки. Если значение не задано,
//                                        то в качестве наименования используется синоним
//                                        конфигурации подключаемой конечной точки.
//  НаименованиеКонечнойТочкиОтправителя - Строка - Наименование конечной точки, которая соответствует
//                                        этой информационной базе. Если значение не задано, то в качестве
//                                        наименования используется синоним конфигурации этой информационной базы.
//
Процедура ПодключитьКонечнуюТочку(Отказ,
									НастройкиПодключенияОтправителя,
									НастройкиПодключенияПолучателя,
									КонечнаяТочка = Неопределено,
									НаименованиеКонечнойТочкиПолучателя = "",
									НаименованиеКонечнойТочкиОтправителя = "") Экспорт
	
	ОбменСообщениямиВнутренний.ВыполнитьПодключениеКонечнойТочкиНаСторонеОтправителя(Отказ, 
														НастройкиПодключенияОтправителя,
														НастройкиПодключенияПолучателя,
														КонечнаяТочка,
														НаименованиеКонечнойТочкиПолучателя,
														НаименованиеКонечнойТочкиОтправителя);
	
КонецПроцедуры

// Выполняет обновление настроек подключения для конечной точки.
// Обновляются настройки подключения этой информационной базы к указанной конечной точке
// и настройки подключения конечной точки к этой информационной базе.
// Перед применением настроек выполняется проверка подключения на правильность задания настроек.
// Также проверяется то, что настройки подключения получателя указывают на текущего отправителя.
//
// Параметры:
//  Отказ         - Булево - Флаг выполнения операции; поднимается в случае ошибок.
//  КонечнаяТочка - ПланОбменаСсылка.ОбменСообщениями - Ссылка на узел плана обмена, который соответствует конечной
//                                                      точке.
//  НастройкиПодключенияОтправителя - Структура - Параметры подключения отправителя. Для инициализации используется
//                                    функция ОбменДаннымиСервер.СтруктураПараметровWS. Содержит свойства:
//    * WSURLВебСервиса   - Строка - Веб-адрес подключаемой конечной точки.
//    * WSИмяПользователя - Пользователь для аутентификации в подключаемой конечной точке
//                          при работе через web-сервис подсистемы обмена сообщениями.
//    * WSПароль          - Пароль пользователя в подключаемой конечной точке.
//  НастройкиПодключенияПолучателя - Структура - Параметры подключения получателя. Для инициализации используется
//                                   функция ОбменДаннымиСервер.СтруктураПараметровWS. Содержит свойства:
//    * WSURLВебСервиса   - Строка - Веб-адрес этой информационной базы со стороны подключаемой конечной точки.
//    * WSИмяПользователя - Пользователь для аутентификации в этой информационной базе 
//                          при работе через web-сервис подсистемы обмена сообщениями.
//    * WSПароль          - Пароль пользователя в этой информационной базе.
//
Процедура ОбновитьНастройкиПодключенияКонечнойТочки(Отказ,
									КонечнаяТочка,
									НастройкиПодключенияОтправителя,
									НастройкиПодключенияПолучателя) Экспорт
	
	ОбменСообщениямиВнутренний.ВыполнитьОбновлениеНастроекПодключенияКонечнойТочки(Отказ, КонечнаяТочка, НастройкиПодключенияОтправителя, НастройкиПодключенияПолучателя);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОтправитьСообщениеВКаналСообщений(КаналСообщений, ТелоСообщения, Получатель, ЭтоБыстроеСообщение = Ложь)
	
	Если ТипЗнч(Получатель) = Тип("ПланОбменаСсылка.ОбменСообщениями") Тогда
		
		ОтправитьСообщениеПолучателю(КаналСообщений, ТелоСообщения, Получатель, ЭтоБыстроеСообщение);
		
	ИначеЕсли ТипЗнч(Получатель) = Тип("Массив") Тогда
		
		Для Каждого Элемент Из Получатель Цикл
			
			Если ТипЗнч(Элемент) <> Тип("ПланОбменаСсылка.ОбменСообщениями") Тогда
				
				ВызватьИсключение НСтр("ru='Указан неправильный получатель для метода ОбменСообщениями.ОтправитьСообщение().';uk='Вказано неправильну одержувач для методу ОбменСообщениями.ОтправитьСообщение().'");
				
			КонецЕсли;
			
			ОтправитьСообщениеПолучателю(КаналСообщений, ТелоСообщения, Элемент, ЭтоБыстроеСообщение);
			
		КонецЦикла;
		
	ИначеЕсли Получатель = Неопределено Тогда
		
		ОтправитьСообщениеПолучателям(КаналСообщений, ТелоСообщения, ЭтоБыстроеСообщение);
		
	Иначе
		
		ВызватьИсключение НСтр("ru='Указан неправильный получатель для метода ОбменСообщениями.ОтправитьСообщение().';uk='Вказано неправильну одержувач для методу ОбменСообщениями.ОтправитьСообщение().'");
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОтправитьСообщениеПодписчикамВКаналСообщений(КаналСообщений, ТелоСообщения, ЭтоБыстроеСообщение = Ложь)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Получатели = РегистрыСведений.ПодпискиПолучателей.ПодписчикиКаналаСообщений(КаналСообщений);
	
	// Отправка сообщения получателю (конечной точке).
	Для Каждого Получатель Из Получатели Цикл
		
		ОтправитьСообщениеПолучателю(КаналСообщений, ТелоСообщения, Получатель, ЭтоБыстроеСообщение);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОтправитьСообщениеПолучателям(КаналСообщений, ТелоСообщения, ЭтоБыстроеСообщение)
	Перем ДинамическиПодключенныеПолучатели;
	
	УстановитьПривилегированныйРежим(Истина);
	
	// Получатели сообщения из регистра.
	Получатели = РегистрыСведений.НастройкиОтправителя.ПодписчикиКаналаСообщений(КаналСообщений);
	
	// Получатели сообщения из кода.
	ОбменСообщениямиПереопределяемый.ПолучателиСообщения(КаналСообщений, ДинамическиПодключенныеПолучатели);
	
	// Получаем массив уникальных получателей из двух массивов. 
	// Для этого используем временную таблицу значений.
	ТаблицаПолучателей = Новый ТаблицаЗначений;
	ТаблицаПолучателей.Колонки.Добавить("Получатель");
	Для Каждого Получатель Из Получатели Цикл
		ТаблицаПолучателей.Добавить().Получатель = Получатель;
	КонецЦикла;
	
	Если ТипЗнч(ДинамическиПодключенныеПолучатели) = Тип("Массив") Тогда
		
		Для Каждого Получатель Из ДинамическиПодключенныеПолучатели Цикл
			ТаблицаПолучателей.Добавить().Получатель = Получатель;
		КонецЦикла;
		
	КонецЕсли;
	
	ТаблицаПолучателей.Свернуть("Получатель");
	
	Получатели = ТаблицаПолучателей.ВыгрузитьКолонку("Получатель");
	
	// Отправка сообщения получателю (конечной точке).
	Для Каждого Получатель Из Получатели Цикл
		
		ОтправитьСообщениеПолучателю(КаналСообщений, ТелоСообщения, Получатель, ЭтоБыстроеСообщение);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОтправитьСообщениеПолучателю(КаналСообщений, ТелоСообщения, Получатель, ЭтоБыстроеСообщение)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если Не ТранзакцияАктивна() Тогда
		
		ВызватьИсключение НСтр("ru='Отправка сообщений может выполняться только в транзакции.';uk='Відправлення повідомлень може виконуватися тільки в транзакції.'");
		
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(КаналСообщений) Тогда
		
		ВызватьИсключение НСтр("ru='Не задано значение параметра ""КаналСообщений"" для метода ОбменСообщениями.ОтправитьСообщение.';uk='Не задане значення параметру ""КаналСообщений"" для методу ОбменСообщениями.ОтправитьСообщение.'");
		
	ИначеЕсли СтрДлина(КаналСообщений) > 150 Тогда
		
		ВызватьИсключение НСтр("ru='Длина имени канала сообщений не должна превышать 150 символов.';uk='Довжина імені каналу повідомлень не повинна перевищувати 150 символів.'");
		
	ИначеЕсли Не ЗначениеЗаполнено(Получатель) Тогда
		
		ВызватьИсключение НСтр("ru='Не задано значение параметра ""Получатель"" для метода ОбменСообщениями.ОтправитьСообщение.';uk='Не задане значення параметру ""Одержувач"" для методу ОбменСообщениями.ОтправитьСообщение.'");
		
	ИначеЕсли ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Получатель, "Заблокирована") Тогда
		
		ВызватьИсключение СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru='Попытка отправки сообщения заблокированной конечной точке ""%1"".';uk='Спроба відправки повідомлення заблокованій кінцевій точці ""%1"".'"),
			Строка(Получатель));
	КонецЕсли;
	
	СправочникДляСообщения = Справочники.СообщенияСистемы;
	
	Если РаботаВМоделиСервисаПовтИсп.ЭтоРазделеннаяКонфигурация() Тогда
		МодульСообщенияВМоделиСервисаРазделениеДанных = ОбщегоНазначения.ОбщийМодуль("СообщенияВМоделиСервисаРазделениеДанных");
		ПереопределенныйСправочник = МодульСообщенияВМоделиСервисаРазделениеДанных.ПриВыбореСправочникаДляСообщения(ТелоСообщения);
		Если ПереопределенныйСправочник <> Неопределено Тогда
			СправочникДляСообщения = ПереопределенныйСправочник;
		КонецЕсли;
	КонецЕсли;
	
	НовоеСообщение = СправочникДляСообщения.СоздатьЭлемент();
	НовоеСообщение.Наименование = КаналСообщений;
	НовоеСообщение.Код = 0;
	НовоеСообщение.КоличествоПопытокОбработкиСообщения = 0;
	НовоеСообщение.Заблокировано = Ложь;
	НовоеСообщение.ТелоСообщения = Новый ХранилищеЗначения(ТелоСообщения);
	НовоеСообщение.Отправитель = ОбменСообщениямиВнутренний.ЭтотУзел();
	НовоеСообщение.ЭтоБыстроеСообщение = ЭтоБыстроеСообщение;
	
	Если Получатель = ОбменСообщениямиВнутренний.ЭтотУзел() Тогда
		
		НовоеСообщение.Получатель = ОбменСообщениямиВнутренний.ЭтотУзел();
		
	Иначе
		
		НовоеСообщение.ОбменДанными.Получатели.Добавить(Получатель);
		НовоеСообщение.ОбменДанными.Получатели.АвтоЗаполнение = Ложь;
		
		НовоеСообщение.Получатель = Получатель;
		
	КонецЕсли;
	
	СтандартнаяОбработкаЗаписи = Истина;
	Если РаботаВМоделиСервисаПовтИсп.ЭтоРазделеннаяКонфигурация() Тогда
		МодульСообщенияВМоделиСервисаРазделениеДанных = ОбщегоНазначения.ОбщийМодуль("СообщенияВМоделиСервисаРазделениеДанных");
		МодульСообщенияВМоделиСервисаРазделениеДанных.ПередЗаписьюСообщения(НовоеСообщение, СтандартнаяОбработкаЗаписи);
	КонецЕсли;
	
	Если СтандартнаяОбработкаЗаписи Тогда
		НовоеСообщение.Записать();
	КонецЕсли;
	
КонецПроцедуры

Функция НачатьОтправкуБыстрыхСообщений()
	
	НачатьОтправку = Истина;
	
	НачатьТранзакцию();
	Попытка
		Блокировка = Новый БлокировкаДанных;
		Блокировка.Добавить("Константа.БлокировкаОтправкиБыстрыхСообщений");
		Блокировка.Заблокировать();
		
		БлокировкаОтправкиБыстрыхСообщений = Константы.БлокировкаОтправкиБыстрыхСообщений.Получить();
		
		// Метод ТекущаяДатаСеанса() использовать нельзя.
		// Текущая дата сервера в данном случае используется в качестве ключа уникальности.
		Если БлокировкаОтправкиБыстрыхСообщений >= ТекущаяДата() Тогда
			НачатьОтправку = Ложь;
		Иначе
			Константы.БлокировкаОтправкиБыстрыхСообщений.Установить(ТекущаяДата() + 60 * 5);
		КонецЕсли;
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
	Возврат НачатьОтправку;
КонецФункции

Процедура ЗавершитьОтправкуБыстрыхСообщений()
	
	НачатьТранзакцию();
	Попытка
		Блокировка = Новый БлокировкаДанных;
		Блокировка.Добавить("Константа.БлокировкаОтправкиБыстрыхСообщений");
		Блокировка.Заблокировать();
		
		Константы.БлокировкаОтправкиБыстрыхСообщений.Установить(Дата('00010101'));
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

Процедура ОтменитьОтправкуБыстрыхСообщений()
	
	ЗавершитьОтправкуБыстрыхСообщений();
	
КонецПроцедуры

Процедура УдалитьРегистрациюИзменений(КонечнаяТочка, Знач Сообщения)
	
	Для Каждого Сообщение Из Сообщения Цикл
		
		ПланыОбмена.УдалитьРегистрациюИзменений(КонечнаяТочка, Сообщение);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ДоставитьСообщенияПолучателю(КонечнаяТочка, Знач Сообщения)
	
	Поток = "";
	
	ОбменСообщениямиВнутренний.СериализоватьДанныеВПоток(Сообщения, Поток);
	
	ОбменСообщениямиПовтИсп.WSПроксиКонечнойТочки(КонечнаяТочка, 10).DeliverMessages(ОбменСообщениямиВнутренний.КодЭтогоУзла(), Новый ХранилищеЗначения(Поток, Новый СжатиеДанных(9)));
	
КонецПроцедуры

#КонецОбласти
