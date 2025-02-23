////////////////////////////////////////////////////////////////////////////////
// НСИ производства: Процедуры подсистемы управления данными об изделиях
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс


// Возвращает описание источников данных операндов по менеджеру
//
// Параметры:
//  ИмяМенеджера - Строка	 - имя менеджер справочника.
// 
// Возвращаемое значение:
//  Структура - см. Справочники.РесурсныеСпецификации.ОписаниеИсточниковДанныхОперандов().
//
Функция ОписаниеИсточниковДанныхОперандов(ИмяМенеджера) Экспорт
	
	Возврат Справочники[ИмяМенеджера].ОписаниеИсточниковДанныхОперандов();
	
КонецФункции

#Область ПараметрыНазначения

// Проверяет использование вида параметра назначения спецификаций
//
// Параметры:
//  ВидПараметра  - ПеречислениеСсылка.ВидыПараметровНазначенияСпецификаций - вид параметра, использование которого необходимо определить
//  ПроверятьФункциональнуюОпцию - Булево - определяет необходимость проверки при выключенной функциональной опции
//
// Возвращаемое значение:
//   Булево   - признак использования вида параметра назначения
//
Функция ПараметрНазначенияИспользуется(ВидПараметра, ПроверятьФункциональнуюОпцию = Истина) Экспорт
	
	Если ПроверятьФункциональнуюОпцию И ПолучитьФункциональнуюОпцию("ИспользоватьПараметрыНазначенияСпецификаций") = Ложь Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ТекстЗапроса = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИСТИНА
	|ИЗ
	|	РегистрСведений.ПараметрыНазначенияСпецификаций КАК Т
	|ГДЕ
	|	Т.ВидПараметра В (&ВидыПараметров)";
	
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("ВидыПараметров", УправлениеДаннымиОбИзделиях.ВидПараметраНазначенияВМассив(ВидПараметра));
	
	Возврат НЕ Запрос.Выполнить().Пустой();
	
КонецФункции

#КонецОбласти


#КонецОбласти