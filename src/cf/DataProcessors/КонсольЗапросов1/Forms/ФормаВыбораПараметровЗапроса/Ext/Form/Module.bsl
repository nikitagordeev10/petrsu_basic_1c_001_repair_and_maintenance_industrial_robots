﻿
// ОБЩИЕ ПРОЦЕДУРЫ И ФУНКЦИИ

// На сервере

// На сервере без контекста

// На клиенте

&НаКлиенте
Процедура ИзменитьПометки(Команда)
	
	ТекущийЗапрос = Элементы.ДеревоЗапросов.ТекущиеДанные;
	Если ТекущийЗапрос = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ПараметрыЗапроса = ТекущийЗапрос.ПараметрыЗапроса;
	Для Каждого СтрокаПараметров Из ПараметрыЗапроса Цикл 
		СтрокаПараметров.Пометка = ?(Команда.Имя = "ИнвертироватьПометки", Не СтрокаПараметров.Пометка, Команда.Имя = "УстановитьПометки");
	КонецЦикла;
	
КонецПроцедуры

// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ СОБЫТИЙ

// Обработчики событий элементов формы

&НаКлиенте
Процедура ДеревоЗапросовПриАктивизацииСтроки(Элемент)
	
	ТекущийЗапрос = Элемент.ТекущиеДанные;
	Если ТекущийЗапрос = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ПараметрыЗапроса = ТекущийЗапрос.ПараметрыЗапроса;
	Для Каждого СтрокаПараметра Из ПараметрыЗапроса Цикл 
		СтрокаПараметра.Пометка = Истина;
		Если Не ЗначениеЗаполнено(СтрокаПараметра.СпособУстановки) Тогда 
			СтрокаПараметра.СпособУстановки = "Значение";
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Обработчики событий формы

// На сервере

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Не ЭтоАдресВременногоХранилища(Параметры.АдресДереваЗапросов) Тогда 
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	ЗначениеХранилища = ПолучитьИзВременногоХранилища(Параметры.АдресДереваЗапросов);
	Если Не ТипЗнч(ЗначениеХранилища) = Тип("ДеревоЗначений") Тогда 
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	ЗначениеВДанныеФормы(ЗначениеХранилища, ДеревоЗапросов);
	
КонецПроцедуры

// На клиенте

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Элементы.ДеревоЗапросов.ТекущаяСтрока = Параметры.ИдентификаторЗапроса;
	
КонецПроцедуры

// ПРОЦЕДУРЫ - ОБРАБОТЧИКИ ДЕЙСТВИЙ

&НаКлиенте
Процедура УстановитьПометки(Команда)
	
	ИзменитьПометки(Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьПометки(Команда)
	
	ИзменитьПометки(Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура ИнвертироватьПометки(Команда)
	
	ИзменитьПометки(Команда);
	
КонецПроцедуры

&НаКлиенте
Процедура КопироватьПараметры(Команда)
	
	ОповеститьОВыборе(ПоместитьВоВременноеХранилище(
		ДеревоЗапросов.НайтиПоИдентификатору(Элементы.ДеревоЗапросов.ТекущаяСтрока).ПараметрыЗапроса.НайтиСтроки(Новый Структура("Пометка", Истина)),
		Новый УникальныйИдентификатор));
	//
КонецПроцедуры




