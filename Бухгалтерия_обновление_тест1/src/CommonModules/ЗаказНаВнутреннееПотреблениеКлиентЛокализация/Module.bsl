
#Область СлужебныйПрограммныйИнтерфейс

#Область ФормаДокумента

Процедура ТоварыКатегорияЭксплуатацииПриИзменении(Форма, КэшированныеЗначения) Экспорт

	ТекущаяСтрока = Форма.Элементы.Товары.ТекущиеДанные;
	
	СтруктураДействий = Новый Структура;
	СтруктураДействий.Вставить("ЗаполнитьПризнакиКатегорииЭксплуатации");
	
	ОбработкаТабличнойЧастиКлиент.ОбработатьСтрокуТЧ(ТекущаяСтрока, СтруктураДействий, КэшированныеЗначения);	
	
КонецПроцедуры

Процедура ПриВыполненииКоманды(Команда, Форма) Экспорт

	ДополнительныеПараметры = Неопределено;
	ТребуетсяВызовСервера = Ложь;
	Объект = Форма.Объект;
	Элементы = Форма.Элементы;
	ПродолжитьВыполнениеКоманды = Истина;
	
	//++ Локализация
	Если Команда.Имя = Элементы.ТоварыЗаполнитьТМЦ.ИмяКоманды Тогда
		ТребуетсяВызовСервера = Истина;
	КонецЕсли; 

	//-- Локализация
	
	Если ПродолжитьВыполнениеКоманды Тогда
		
		ОбщегоНазначенияУТКлиент.ПродолжитьВыполнениеКоманды(
			Форма, 
			Команда.Имя, 
			ТребуетсяВызовСервера,
			ДополнительныеПараметры);
			
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти