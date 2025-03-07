////////////////////////////////////////////////////////////////////////////////
// Содержит процедуры документа ВнутреннееПотреблениеТоваров, предназначенные для локализации.
// 
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область ФормаДокумента

// Вызывается при изменении реквизита ХозяйственнаяОперация в документе
//
Процедура ХозяйственнаяОперацияПриИзменении(Форма) Экспорт

	//++ Локализация
	//-- Локализация
	
	ОбщегоНазначенияУТКлиент.ПродолжитьИзменениеРеквизита(
		Форма, 
		"ХозяйственнаяОперация", 
		Истина, 
		Новый Структура("ОчиститьТовары", Ложь));
	
КонецПроцедуры

Функция МожноРазбитьСтроку(ТекущаяСтрока) Экспорт

	//++ Локализация
	//-- Локализация
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

#Область Локализация

//++ Локализация

// Вызывается при изменении реквизита КатегорияЭксплуатации в документе
//
Процедура ТоварыКатегорияЭксплуатацииПриИзменении(Форма, КэшированныеЗначения) Экспорт

	Элементы = Форма.Элементы;
	
	ТекущаяСтрока = Элементы.Товары.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ЗаполнитьПризнакиКатегорииЭксплуатации");
	
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);
	
КонецПроцедуры

//-- Локализация

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++ Локализация
//-- Локализация

#КонецОбласти
