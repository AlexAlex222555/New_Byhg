///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

// Возвращает реквизиты объекта, которые не рекомендуется редактировать
// с помощью обработки группового изменения реквизитов.
//
// Возвращаемое значение:
//  Массив Из Строка -
Функция РеквизитыНеРедактируемыеВГрупповойОбработке() Экспорт
	
	НеРедактируемыеРеквизиты = Новый Массив;
	НеРедактируемыеРеквизиты.Добавить("КомуВыдан");
	НеРедактируемыеРеквизиты.Добавить("Фирма");
	НеРедактируемыеРеквизиты.Добавить("Фамилия");
	НеРедактируемыеРеквизиты.Добавить("Имя");
	НеРедактируемыеРеквизиты.Добавить("Отчество");
	НеРедактируемыеРеквизиты.Добавить("Должность");
	НеРедактируемыеРеквизиты.Добавить("КемВыдан");
	НеРедактируемыеРеквизиты.Добавить("ДействителенДо");
	НеРедактируемыеРеквизиты.Добавить("Подписание");
	НеРедактируемыеРеквизиты.Добавить("Шифрование");
	НеРедактируемыеРеквизиты.Добавить("Отпечаток");
	НеРедактируемыеРеквизиты.Добавить("ДанныеСертификата");
	НеРедактируемыеРеквизиты.Добавить("Программа");
	НеРедактируемыеРеквизиты.Добавить("Отозван");
	НеРедактируемыеРеквизиты.Добавить("УсиленнаяЗащитаЗакрытогоКлюча");
	НеРедактируемыеРеквизиты.Добавить("Организация");
	НеРедактируемыеРеквизиты.Добавить("Пользователь");
	НеРедактируемыеРеквизиты.Добавить("Добавил");
	
	Если Метаданные.Обработки.Найти("ЗаявлениеНаВыпускНовогоКвалифицированногоСертификата") <> Неопределено Тогда
		ОбработкаЗаявлениеНаВыпускНовогоКвалифицированногоСертификата =
			ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(
				"Обработка.ЗаявлениеНаВыпускНовогоКвалифицированногоСертификата");
		ОбработкаЗаявлениеНаВыпускНовогоКвалифицированногоСертификата.РеквизитыНеРедактируемыеВГрупповойОбработке(
			НеРедактируемыеРеквизиты);
	КонецЕсли;
	
	Возврат НеРедактируемыеРеквизиты;
	
КонецФункции

// Конец СтандартныеПодсистемы.ГрупповоеИзменениеОбъектов

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияФормы(ВидФормы, Параметры, ВыбраннаяФорма, ДополнительнаяИнформация, СтандартнаяОбработка)
	
	Если ВидФормы = "ФормаСписка" Тогда
		СтандартнаяОбработка = Ложь;
		Параметры.Вставить("ПоказатьСтраницуСертификаты");
		ВыбраннаяФорма = Метаданные.ОбщиеФормы.НастройкиЭлектроннойПодписиИШифрования;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
