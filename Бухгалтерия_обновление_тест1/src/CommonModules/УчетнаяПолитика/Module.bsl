
#Область ПрограммныйИнтерфейс

//++ НЕ УТ

Функция Существует(Организация, Период, ВыводитьСообщениеОбОтсутствииУчетнойПолитики = Ложь, ДокументСсылка = Неопределено) Экспорт

	Возврат УчетнаяПолитикаПереопределяемый.Существует(Организация, Период, ВыводитьСообщениеОбОтсутствииУчетнойПолитики, ДокументСсылка);

КонецФункции

Функция ПлательщикНалогаНаПрибыль(Организация, Период) Экспорт

	Возврат УчетнаяПолитикаПереопределяемый.ПлательщикНалогаНаПрибыль(Организация, Период);

КонецФункции 



Функция ИспользуемыеКлассыСчетовРасходов(Организация, Период) Экспорт

	Возврат УчетнаяПолитикаПереопределяемый.ИспользуемыеКлассыСчетовРасходов(Организация, Период);

КонецФункции 

Функция НалогНаПрибыльБезКорректировокФинансовогоРезультата(Организация, Период) Экспорт

	Возврат УчетнаяПолитикаПереопределяемый.НалогНаПрибыльБезКорректировокФинансовогоРезультата(Организация, Период);

КонецФункции 

Функция ВключатьСуммуДооценокОСВСоставНераспределеннойПрибыли(Организация, Период) Экспорт

	Возврат УчетнаяПолитикаПереопределяемый.ВключатьСуммуДооценокОСВСоставНераспределеннойПрибыли(Организация, Период);

КонецФункции 


//-- НЕ УТ

// Параметры учетной политики по НДС

Функция ПлательщикНДС(Организация, Период) Экспорт

	Возврат УчетнаяПолитикаПереопределяемый.ПлательщикНДС(Организация, Период);

КонецФункции 


//++ НЕ УТ

//-- НЕ УТ


//++ НЕ УТ


Функция СистемаНалогообложения(Организация, Период) Экспорт

	Возврат УчетнаяПолитикаПереопределяемый.СистемаНалогообложения(Организация, Период);

КонецФункции 


//-- НЕ УТ

Функция ПлательщикЕН(Организация, Период) Экспорт

	Возврат УчетнаяПолитикаПереопределяемый.ПлательщикЕН(Организация, Период);

КонецФункции 




#КонецОбласти
