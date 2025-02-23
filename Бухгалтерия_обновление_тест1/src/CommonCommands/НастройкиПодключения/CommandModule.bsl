///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Корреспондент = ПараметрКоманды;
	ИдентификаторНастройки = "";
	
	Если ОбменДаннымиСВнешнейСистемой(Корреспондент, ИдентификаторНастройки) Тогда
		Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ИнтернетПоддержкаПользователей.ОбменДаннымиСВнешнимиСистемами") Тогда
			
			Контекст = Новый Структура;
			Контекст.Вставить("ИдентификаторНастройки", ИдентификаторНастройки);
			Контекст.Вставить("Корреспондент", Корреспондент);
			Контекст.Вставить("Режим", "РедактированиеПараметровПодключения");
			
			Отказ = Ложь;
			ИмяФормыПомощника  = "";
			ПараметрыПомощника = Новый Структура;
			
			МодульОбменДаннымиСВнешнимиСистемамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ОбменДаннымиСВнешнимиСистемамиКлиент");
			МодульОбменДаннымиСВнешнимиСистемамиКлиент.ПередНастройкойПараметровПодключения(
				Контекст, Отказ, ИмяФормыПомощника, ПараметрыПомощника);
			
			Если Не Отказ Тогда
				ОткрытьФорму(ИмяФормыПомощника,
					ПараметрыПомощника, ЭтотОбъект, , , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
			КонецЕсли;
		КонецЕсли;
		Возврат;
	КонецЕсли;
	
	Отбор              = Новый Структура("Корреспондент", Корреспондент);
	ЗначенияЗаполнения = Новый Структура("Корреспондент", Корреспондент);
	
	ОбменДаннымиКлиент.ОткрытьФормуЗаписиРегистраСведенийПоОтбору(Отбор,
		ЗначенияЗаполнения, "НастройкиТранспортаОбменаДанными", ПараметрыВыполненияКоманды.Источник);
	
КонецПроцедуры

&НаСервере
Функция ОбменДаннымиСВнешнейСистемой(Корреспондент, ИдентификаторНастройки = "")
	
	ВидТранспорта = РегистрыСведений.НастройкиТранспортаОбменаДанными.ВидТранспортаСообщенийОбменаПоУмолчанию(Корреспондент);
	
	ИдентификаторНастройки = ОбменДаннымиСервер.СохраненныйВариантНастройкиУзлаПланаОбмена(Корреспондент);
	
	Возврат ВидТранспорта = Перечисления.ВидыТранспортаСообщенийОбмена.ВнешняяСистема;
	
КонецФункции

#КонецОбласти
