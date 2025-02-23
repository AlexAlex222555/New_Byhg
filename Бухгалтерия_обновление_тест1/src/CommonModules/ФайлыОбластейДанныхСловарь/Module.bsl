
#Область СлужебныйПрограммныйИнтерфейс

Функция КорневоеСобытие() Экспорт
	
	КодЯзыка = ОбщегоНазначения.КодОсновногоЯзыка();
	Возврат НСтр("ru='Файлы областей данных';uk='Файли областей даних'",КодЯзыка);
	
КонецФункции

Функция ФайлНеНайденПоИдентификатору() Экспорт
	Возврат НСтр("ru='Файл с идентификатором ''%1'' не найден.';uk='Файл з ідентифікатором ''%1'' не знайдено.'");
КонецФункции

Функция ФайлНеНайденПоПолномуИмени() Экспорт
	Возврат НСтр("ru='Файл ''%1'' не найден.';uk='Файл ''%1'' не знайдений.'");
КонецФункции

Функция ИмяФайлаДляСохраненияНеЗадано() Экспорт
	Возврат НСтр("ru='Не задано имя файла для сохранения.';uk='Не вказано ім''я файлу для збереження.'");
КонецФункции

Функция ИнформацияОФайлеОтсутствует() Экспорт
	Возврат НСтр("ru='Отсутствует информация о файле.';uk='Відсутня інформація про файл.'");
КонецФункции

Функция НеверныйТипЗаданияФайла() Экспорт
	Возврат НСтр("ru='Неверный тип задания файла.';uk='Невірний тип завдання файлу.'");
КонецФункции

Функция УдалениеФайлаИзХранилища() Экспорт
	КодЯзыка = ОбщегоНазначения.КодОсновногоЯзыка();
	Возврат НСтр("ru='Удаление файла из хранилища.';uk='Вилучення файлу зі сховища.'",КодЯзыка);
КонецФункции

Функция УдалениеФайлаТома() Экспорт
	КодЯзыка = ОбщегоНазначения.КодОсновногоЯзыка();
	Возврат НСтр("ru='Удаление файла тома';uk='Вилучення файлу тома'",КодЯзыка);	
КонецФункции

Функция УстановкаПризнакаВременный() Экспорт
	КодЯзыка = ОбщегоНазначения.КодОсновногоЯзыка();
	Возврат НСтр("ru='Установка признака ''Временный''.';uk='Встановлення ознаки ''Тимчасовий''.'",КодЯзыка);
КонецФункции

Функция ПереданИдентификаторНекорректногоТипа() Экспорт 
	
	Возврат НСтр("ru='Передан идентификатор некорректного типа. Ожидается: УникальныйИдентификатор, получено: %1';uk='Переданий ідентифікатор некоректного типу. Очікується: УникальныйИдентификатор, отримано: %1'");
	
КонецФункции

Функция НельзяЗаписыватьДанныеПриВключенномРазделенииБезУказанияРазделителя() Экспорт
	
	Возврат НСтр("ru='Нельзя записывать данные при включенном разделении без указания разделителя.';uk='Неможна записувати дані при включеному поділі без зазначення роздільника.'");
	
КонецФункции

#КонецОбласти 
