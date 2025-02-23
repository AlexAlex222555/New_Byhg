
// С помощью ПриОпределенииВидовПодключаемыхКоманд можно определить собственные виды подключаемых команд,
// помимо уже предусмотренных в стандартной поставке (печатные формы, отчеты и команды заполнения).
// см. ОбщийМодуль.ПодключаемыеКомандыПереопределяемый.ПриОпределенииВидовПодключаемыхКоманд
//
Процедура ПриОпределенииВидовПодключаемыхКоманд(ВидыПодключаемыхКоманд) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Позволяет расширить состав параметра Настройки процедуры ПриОпределенииНастроек в модулях менеджеров отчетов и 
// обработок, включенных в состав подсистемы ПодключаемыеОтчетыИОбработки, с помощью чего отчеты и обработки могут 
// сообщить о себе, что они предоставляют определенные виды команд и взаимодействуют с подсистемами через их 
// программный интерфейс.
//
// см. ОбщийМодуль.ПодключаемыеКомандыПереопределяемый.ПриОпределенииСоставаНастроекПодключаемыхОбъектов()
//
Процедура ПриОпределенииСоставаНастроекПодключаемыхОбъектов(НастройкиПрограммногоИнтерфейса) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры

// Вызывается однократно при первом формировании списка команд, выводимых в форме конкретного объекта конфигурации.
// Список добавленных команд следует вернуть в параметре Команды.
// Результат кэшируется с помощью модуля с повторными использованием возвращаемых значений (в разрезе имен форм).
// см. ОбщийМодуль.ПодключаемыеКомандыПереопределяемый.ПриОпределенииКомандПодключенныхКОбъекту()
//	
Процедура ПриОпределенииКомандПодключенныхКОбъекту(НастройкиФормы, Источники, ПодключенныеОтчетыИОбработки, Команды) Экспорт
	
	//++ Локализация
	//-- Локализация
	
КонецПроцедуры