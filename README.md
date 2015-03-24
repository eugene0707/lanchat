LanChat
=======

Приложение текстового чата для локальной сети. Используются следующие технологии и фреймворки:

0. IP Multicast в реализации протокола RTMFP.
0. AS3 приложение, предоставляющее API для сетевого обмена сообщениями.
0. WebUI, выполненный на основе AngularJS. Имеет 2 состояния - форма логина и текстовый чат.

Работающее приложение доступно по адресу http://eugene0707.github.io/lanchat/LanChat.html

Приложение полностью работоспособно в Firefox, Safari, IE под Windows. В Chrome и Opera - условно работоспособно.

В Pepperflash (Chrome, Opera) multicast RTMFP работает нестабильно, а именно:
0. Если к группе подключились только пользователи Pepperflash, то они не видят "соседей" и multicast RTMFP не работает. Трекер Chrome https://code.google.com/p/chromium/issues/detail?id=380715
0. Если к группе подключились пользователи Pepperflash и Adobe Flash, то multicast работает нормально.
0. Если в броузере отключить плагин Pepperflash и использовать Adobe Flash, то multicast работает нормально.


TO-DO
-----

0. Список участников
0. Рефакторинг
