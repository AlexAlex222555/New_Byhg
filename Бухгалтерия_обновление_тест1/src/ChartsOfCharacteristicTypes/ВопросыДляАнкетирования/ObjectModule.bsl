///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	МассивНепроверяемыхРеквизитов = Новый Массив();
	
	Если Не ТребуетсяКомментарий Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ПояснениеКомментария");
	КонецЕсли;
	
	Если (ТипОтвета <> Перечисления.ТипыОтветовНаВопрос.Строка)
		И (ТипОтвета <> Перечисления.ТипыОтветовНаВопрос.Число) Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Длина");
	КонецЕсли;
	Если ТипОтвета <> Перечисления.ТипыОтветовНаВопрос.ЗначениеИнформационнойБазы Тогда
		МассивНепроверяемыхРеквизитов.Добавить("ТипЗначения");
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(ЭтотОбъект);
	
	Если Не ЭтоГруппа Тогда
		ОчиститьНенужныеРеквизиты();
		УстановкаТипаПВХ();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедура очищает значения ненужных реквизитов,
// Такая ситуация возникает, когда пользователь изменяет тип ответа при редактировании.
Процедура ОчиститьНенужныеРеквизиты()
	
	Если ((ТипОтвета <> Перечисления.ТипыОтветовНаВопрос.Число) И (ТипОтвета <> Перечисления.ТипыОтветовНаВопрос.Строка)  И (ТипОтвета <> Перечисления.ТипыОтветовНаВопрос.Текст))
	   И (Длина <> 0)Тогда
		
		Длина = 0;
		
	КонецЕсли;
	
	Если (ТипОтвета <> Перечисления.ТипыОтветовНаВопрос.Число) Тогда	
		
		МинимальноеЗначение       = 0;
		МаксимальноеЗначение      = 0;
		АгрегироватьСуммуВОтчетах = Ложь;
		
	КонецЕсли;
	
	Если ТипОтвета = Перечисления.ТипыОтветовНаВопрос.НесколькоВариантовИз Тогда
		ТребуетсяКомментарий = Ложь;
		ПояснениеКомментария = "";
	КонецЕсли;

КонецПроцедуры

// Устанавливает тип значения ПВХ в зависимости от типа ответа.
Процедура УстановкаТипаПВХ()
	
	ТипыОтветовНаВопрос = Перечисления.ТипыОтветовНаВопрос;
	
	// Квалификаторы
	КЧ = Новый КвалификаторыЧисла(?(Длина = 0,15,Длина),Точность);
	КС = Новый КвалификаторыСтроки(Длина);
	КД = Новый КвалификаторыДаты(ЧастиДаты.Дата);
	
	// Описание типов
	ОписаниеТиповЧисло  = Новый ОписаниеТипов("Число",,КЧ);
	ОписаниеТиповСтрока = Новый ОписаниеТипов("Строка", , КС);
	ОписаниеТиповДата   = Новый ОписаниеТипов("Дата",КД , , );
	ОписаниеТиповБулево = Новый ОписаниеТипов("Булево");
	ОписаниеТиповВО     = Новый ОписаниеТипов("СправочникСсылка.ВариантыОтветовАнкет");
	
	Если ТипОтвета = ТипыОтветовНаВопрос.Строка Тогда
		
		ТипЗначения = ОписаниеТиповСтрока;
		
	ИначеЕсли ТипОтвета = ТипыОтветовНаВопрос.Текст Тогда
		
		ТипЗначения = ОписаниеТиповСтрока;
		
	ИначеЕсли ТипОтвета = ТипыОтветовНаВопрос.Число Тогда
		
		ТипЗначения = ОписаниеТиповЧисло;
		
	ИначеЕсли ТипОтвета = ТипыОтветовНаВопрос.Дата Тогда
		
		ТипЗначения = ОписаниеТиповДата;
		
	ИначеЕсли ТипОтвета = ТипыОтветовНаВопрос.Булево Тогда
		
		ТипЗначения = ОписаниеТиповБулево;
		
	ИначеЕсли ТипОтвета =ТипыОтветовНаВопрос.ОдинВариантИз
		  ИЛИ ТипОтвета = ТипыОтветовНаВопрос.НесколькоВариантовИз Тогда
		
		ТипЗначения = ОписаниеТиповВО;
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru='Недопустимый вызов объекта на клиенте.';uk='Неправильний виклик об''єкта на клієнті.'");
#КонецЕсли