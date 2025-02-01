﻿&НаКлиенте
Процедура Поиск()
	Искать(0);
КонецПроцедуры

&НаКлиенте
Процедура ПредыдущаяСтраница()
	Искать(-1);
КонецПроцедуры

&НаКлиенте
Процедура СледующаяСтраница()
	Искать(1);
КонецПроцедуры

&НаКлиенте
// Процедура поиска, получение и отображение результата
Процедура Искать(Направление)
	Если ПустаяСтрока(ПоисковоеВыражение)  Тогда Предупреждение("Не задана строка поиска."); Возврат;
	КонецЕсли; 
	ИскатьСервер(Направление); 
КонецПроцедуры


&НаСервере
Процедура ИскатьСервер(Направление) Экспорт
	// создаем список поиска
	СписокПоиска = ПолнотекстовыйПоиск.СоздатьСписок();
	
	// устанавливаем поисковое выражение
	СписокПоиска.СтрокаПоиска = ПоисковоеВыражение;
	
	// в  зависимости от направления поиска выполняем метод
	Если Направление = 0 Тогда
		СписокПоиска.ПерваяЧасть(); 
	ИначеЕсли Направление  = -1 Тогда
		СписокПоиска.ПредыдущаяЧасть(ТекущаяПозиция); 
	ИначеЕсли Направление = 1 Тогда
		СписокПоиска.СледующаяЧасть(ТекущаяПозиция); 
	КонецЕсли;
	
	// очищаем список значений
	РезультатыПоиска.Очистить();  
	
	// заполняем его найденными элементами
	Для Каждого Результат Из СписокПоиска Цикл
		РезультатыПоиска.Добавить(Результат.Значение); 
	КонецЦикла;
	
	// Получаем  результат   полнотекстового  поиска  
	РезультатПоиска = СписокПоиска.ПолучитьОтображение(ВидОтображенияПолнотекстовогоПоиска.HTMLТекст);
	ТекущаяПозиция = СписокПоиска.НачальнаяПозиция();
	ПолноеКоличество = СписокПоиска.ПолноеКоличество();
	
	// анализируем  количество  элементов  в  списке  
	Если СписокПоиска.Количество() <>  0 Тогда 
		// формируем сообщение   о    том,   какие   элементы   отображены   и    сколько   всего элементов найдено
		СообщениеОРезультате = "Показаны " + Строка(ТекущаяПозиция + 1) + " - " + Строка(ТекущаяПозиция + СписокПоиска.Количество()) + " из " +	Строка(ПолноеКоличество);
		Элементы.СледующаяСтраница.Доступность = (ПолноеКоличество - ТекущаяПозиция) > СписокПоиска.Количество(); 
		Элементы.ПредыдущаяСтраница.Доступность = (ТекущаяПозиция > 0); 
	Иначе
		СообщениеОРезультате = "Не найдено"; 
		Элементы.СледующаяСтраница.Доступность = Ложь; 
		Элементы.ПредыдущаяСтраница.Доступность = Ложь; 
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура РезультатПоискаПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	ЭлементHTML = ДанныеСобытия.Event.srcElement; 
	Если (ЭлементHTML.id = "FullTextSearchListItem") Тогда
		
		// Получить имя файла (номер строки списка поиска), содержащегося в гиперссылке
		НомерВСписке = Число(ЭлементHTML.nameProp);
		
		// Получить строку списка поиска по номеру
		ВыбраннаяСтрока = РезультатыПоиска[НомерВСписке].Значение;
		
		// Открыть форму найденного объекта
		ОткрытьЗначение(ВыбраннаяСтрока); 
		СтандартнаяОбработка = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры


