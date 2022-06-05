# Личный кабинет садовода для 1C.Садовод

Описание проекта на другом языке: [English](README.en.md)

[Последняя версия приложения apk](README.en.md)

Личный кабинет позволяет пользователю (участнику садоводства):

- Получить информацию о своем имуществе в садоводстве;
- Получить информацию о садоводстве (реквезиты, адрес, номер телефона по которому можно сразу
  позвонить, адрес электронной почты);
- Получить информацию о своем счете (задолженности или переплаты);
- Передать показания по счетчикам, установленным на участке;
- Сформировать квитанцию для оплаты с последующей отправкой на почту или просмотр сразу в
  приложении;
- Получить необходимые реквизиты для оплаты по реквезитам;
- Получать уведомления, например о времени передавать показания;

Для работы личного кабинета необходимо подключить к конфигурации 1С.Садовод
расширение [Gardener's Personal Account Server](https://github.com/Evil-Enot/Gardener-s-Personal-Account-Server)

## Демонстрация приложения:

После установки приложения на устройство и его запуска поллзователь попадает на страницу ввода URL и
кода авторизации на сервере. Эти данные можно получить у председателя или админинистратора своего
садоводства.

После ввода корректных данных пользователь попадает на страницу ввода ФИО и номера телефона, кторый
необходимы для идентификации пользователя в системе. Если пользователь обнаружен в базе, на
указанный номер телефона приходит одноразовый код для аодтверждения входа.

При успешном вводе кода пользователь считается авторизированным и попадает на главную страницу
приложения

[comment]: <> (демонстрация авторизации)

В случае, если пользователь уже был ранее авторизован в приложении, то при запуске приложения
откроется страница ввода одноразового кода, который можно отправить по смс, либо, если устройство
поддерживает авторизацию по биометрическим данным, можно войти в приложение по отпечатку пальца или
распознованию лица.

[comment]: <> (демонстрация входа в приложение авторизированному ранее пользователя)

После успешной авторизации пользователь попадает на гланую страницу, откуда может перейти на
страницу с информацией о садоводстве, настройки, страницу со счетами или с счетчиками:

![Главная страница приложения](/images/img1.jpg)

При открытии страницы информации о садоводстве пользователю отображается информация о самом
садоводстве:

- Наименование садоводства;
- Реквезиты садоводства;
- Контактная информация;

![Страница с информацией](/images/img2.jpg)

При нажатии на номер садоводства, откроетсся приложение для звонков, откуда можно будет сразу
набрать данный номер:

![Выбор приложения для звонка после нажатия на номер телефона](/images/img3.jpg)

При нажатии на почту, данный почтовый адрес скопируется в буфер обмена:

![Оповещение пользователя о копировании почты в буфер обмена](/images/img4.jpg)

На странице настроек пользователь может включить уведомления, например, о веремни передавать
показания:

![Получение уведомления](/images/img5.jpg)

Также на этой странице пользователь может выйти из приложения.

![Страница настроек](/images/img6.jpg)

На странице счетов пользователь может посмотреть информацию о текущем долге и дате последних
переданных показаний:

![Страница со счетами](/images/img7.jpg)

При нажатии на кнопку "Посмотреть квитанцию", сформированная квитанция откроется в выбранном
приложении для просмотра pdf-файлов

![Открытие pdf из приложения](/images/img8.jpg)

При нажатии на кнопку "Получить квитанцию на почту", на почту пользователя, если она указана в базе
данных, придет сформированная квитанция:

![Сообщение об успешной отправке квитанции на почту](/images/img9.jpg)

![Письмо с квитанцией](/images/img10.jpg)

Также при нажати на кнопку "Оплатить" откроется страница с инструкцией для оплаты по реквезитам,
откуда можно, нажав на реквезиты, скопировать нужные значения для заполнения в банковском приложении

![Страница с реквизитами для оплаты](/images/img11.jpg)

На странице счетчиков можно увидеть подробную информациб о счетчиках на участках:

- Дата последней передачи показаний по счетчику
- Последние переданные значения;

![Страница со счетчиками](/images/img12.jpg)

Также на этой странице можно передать показания, введя их в соответствующие поля. Если ввести
некорректные данные, об этом сразу сообщится пользователю:

![Оповещение о некорректных переданных данных](/images/img13.jpg)

Если данные корректны, то после записи их в базу, пользователю отобразится соответствующее сообщение:

![Успешная передача данных](/images/img14.jpg)
