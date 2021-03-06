# Личный кабинет садовода для 1C.Садовод

Описание проекта на другом языке: [English](README.en.md)

[Последняя версия приложения apk](/app/Gardener-LK.apk)

[Последняя версия приложения ipa](/app/Gardener-LK.ipa)

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

После установки приложения на устройство и его запуска пользователь попадает на страницу ввода URL и
кода авторизации на сервере. Эти данные можно получить у председателя или админинистратора своего
садоводства.

После ввода корректных данных пользователь попадает на страницу ввода ФИО и номера телефона, кторый
необходимы для идентификации пользователя в системе. Если пользователь обнаружен в базе, на
указанный номер телефона приходит одноразовый код для аодтверждения входа.

При успешном вводе кода пользователь считается авторизированным и попадает на главную страницу
приложения

<p align="center">
  <img src="/images/Auth1.gif" alt="Авторизация нового пользователя" width="250"/>
</p>
  
В случае, если пользователь уже был ранее авторизован в приложении, то при запуске приложения
откроется страница ввода одноразового кода, который можно отправить по смс, либо, если устройство
поддерживает авторизацию по биометрическим данным, можно войти в приложение по отпечатку пальца или
распознованию лица.

<p align="center">
  <img src="/images/Auth2.gif" alt="Авторизация уже авторизованного ранее пользователя" width="250"/>
</p>

После успешной авторизации пользователь попадает на гланую страницу, откуда может перейти на
страницу с информацией о садоводстве, настройки, страницу со счетами или с счетчиками:

<p align="center">
  <img src="/images/img1.jpg" alt="Главная страница приложения" width="250"/>
</p>

При открытии страницы информации о садоводстве пользователю отображается информация о самом
садоводстве:

- Наименование садоводства;
- Реквезиты садоводства;
- Контактная информация;

<p align="center">
  <img src="/images/img2.jpg" alt="Страница с информацией" width="250"/>
</p>

При нажатии на номер садоводства, откроетсся приложение для звонков, откуда можно будет сразу
набрать данный номер:

<p align="center">
  <img src="/images/img3.jpg" alt="Страница с информацией" width="250"/>
</p>

При нажатии на почту, данный почтовый адрес скопируется в буфер обмена:

<p align="center">
  <img src="/images/img4.jpg" alt="Оповещение пользователя о копировании почты в буфер обмена" width="250"/>
</p>

На странице настроек пользователь может включить уведомления, например, о веремни передавать
показания:

<p align="center">
  <img src="/images/img5.jpg" alt="Получение уведомления" width="250"/>
</p>

Также на этой странице пользователь может выйти из приложения.

<p align="center">
  <img src="/images/img6.jpg" alt="Страница настроек" width="250"/>
</p>

На странице счетов пользователь может посмотреть информацию о текущем долге и дате последних
переданных показаний:

<p align="center">
  <img src="/images/img7.jpg" alt="Страница со счетами" width="250"/>
</p>

При нажатии на кнопку "Посмотреть квитанцию", сформированная квитанция откроется в выбранном
приложении для просмотра pdf-файлов

<p align="center">
  <img src="/images/img8.jpg" alt="Открытие pdf из приложения" width="250"/>
</p>

При нажатии на кнопку "Получить квитанцию на почту", на почту пользователя, если она указана в базе
данных, придет сформированная квитанция:

<p align="center">
  <img src="/images/img9.jpg" alt="Сообщение об успешной отправке квитанции на почту" width="250"/>
</p>

<p align="center">
  <img src="/images/img10.jpg" alt="Письмо с квитанцией" width="250"/>
</p>

Также при нажати на кнопку "Оплатить" откроется страница с инструкцией для оплаты по реквезитам,
откуда можно, нажав на реквезиты, скопировать нужные значения для заполнения в банковском приложении

<p align="center">
  <img src="/images/img11.jpg" alt="Страница с реквизитами для оплаты" width="250"/>
</p>

На странице счетчиков можно увидеть подробную информациб о счетчиках на участках:

- Дата последней передачи показаний по счетчику
- Последние переданные значения;

<p align="center">
  <img src="/images/img12.jpg" alt="Страница со счетчиками" width="250"/>
</p>

Также на этой странице можно передать показания, введя их в соответствующие поля. Если ввести
некорректные данные, об этом сразу сообщится пользователю:

<p align="center">
  <img src="/images/img13.jpg" alt="Оповещение о некорректных переданных данных" width="250"/>
</p>

Если данные корректны, то после записи их в базу, пользователю отобразится соответствующее
сообщение:

<p align="center">
  <img src="/images/img14.jpg" alt="Успешная передача данных" width="250"/>
</p>
