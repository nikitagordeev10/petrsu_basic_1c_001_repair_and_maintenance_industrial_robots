﻿Процедура ПриНачалеРаботыСистемы()                    
	
	// Получить существующий вид поиска.
	ПланПоиска = ГлобальныйПоиск.ПолучитьПлан();      
	
	// Удалить из плана поиска поиск в меню "Функции для технического специалиста" и поиск по справке.
	ПланПоиска.Удалить(СтандартныйВидГлобальногоПоиска.ФункцииДляТехническогоСпециалиста);
	ПланПоиска.Удалить(СтандартныйВидГлобальногоПоиска.Справка);  
	
	// Вернуть план поиска "на место".
	ГлобальныйПоиск.УстановитьПлан(ПланПоиска);    
	
	// Установить собственное описание поисковой строки.
	ГлобальныйПоиск.УстановитьОписание("Введите строку поиска, ссылку или арифметическое выражение." + Символы.ПС +
	"Для поиска документов об оказании услуг по номеру введите ""№"" и сразу за ним без пробела часть номера.");
	
КонецПроцедуры               

Процедура ПриГлобальномПоиске(СтрокаПоиска, ПланПоиска)
	Если СтрНайти(СтрокаПоиска, "№") = 1 Тогда
		//Установить собственный вид поиска, в котором есть только поиск по номеру документа.
		ПланПоиска.Очистить();
		ПланПоиска.Вставить(0, "ПоискДокументовПоНомеру", "ГлобальныйПоискВДанныхСервер", Истина, Ложь);
	КонецЕсли;
КонецПроцедуры