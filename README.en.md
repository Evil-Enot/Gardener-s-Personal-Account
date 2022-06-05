# Gardener's personal account for 1C.Gardener

Description of the project in another language: [Русский](README.md)

[Latest version of app apk](README.en.md)

The personal account allows the user (horticulture participant):

- Get information about your property in gardening;
- Get information about gardening (details, address, phone number where you can immediately call,
  email address)
- Get information about your account (debt or overpayment);
- Submit readings on the meters installed on the site;
- Generate a receipt for payment with subsequent sending to the mail or viewing immediately in
  application;
- Get the necessary details for payment by details;
- Receive notifications, for example, about the time to transfer readings;

For the personal account to work, you need to connect it to the 1C.Gardener configuration
extension [Gardener's Personal Account Server](https://github.com/Evil-Enot/Gardener-s-Personal-Account-Server)

## Application demo:

After installing the application on the device and launching it, the user gets to the URL entry page
and authorization code on the server. This information can be obtained from the chairman or
administrator of your gardening.

After entering the correct data, the user enters the page for entering the full name and phone
number, which necessary to identify the user in the system. If the user is found in the database,
The specified phone number receives a one-time code to confirm the entry.

If the code is successfully entered, the user is considered authorized and gets to the main page
applications

[comment]: <> (authorization demonstration)

If the user has already been previously authorized in the application, then when the application
starts a page for entering a one-time code will open, which can be sent via SMS, or, if the device
supports authorization by biometric data, you can enter the application by fingerprint or face
recognition.

[comment]: <> (demonstration of logging into the application to a previously authorized user)

After successful authorization, the user gets to the main page, from where he can go to gardening
information page, settings, invoices or counters page:

<p align="center">
  <img src="/images/img1.jpg" alt="Application home page" width="250"/>
</p>

When opening the gardening information page, the user is shown information about the gardening:

- Name of gardening;
- Details of gardening;
- Contact Information;

<p align="center">
  <img src="/images/img2.jpg" alt="Information page" width="250"/>
</p>

When you click on the gardening number, the call application will open, from where you can
immediately dial this number:

<p align="center">
  <img src="/images/img3.jpg" alt="Select application to call after clicking on phone number" width="250"/>
</p>

When you click on the mail, this mail address will be copied to the clipboard:

<p align="center">
  <img src="/images/img4.jpg" alt="Notify user about copying mail to clipboard" width="250"/>
</p>

On the settings page, the user can enable notifications, for example, about the ropes to pass
indications:

<p align="center">
  <img src="/images/img5.jpg" alt="Receive notification" width="250"/>
</p>

Also on this page, the user can log out of the application.

<p align="center">
  <img src="/images/img6.jpg" alt="Settings Page" width="250"/>
</p>

On the bills page, the user can view information about the current debt and the date of the last
transmitted testimonies:

<p align="center">
  <img src="/images/img7.jpg" alt="Bills page" width="250"/>
</p>

When you click on the "View receipt" button, the generated receipt will open in the selected pdf
viewer app

<p align="center">
  <img src="/images/img8.jpg" alt="Opening pdf from application" width="250"/>
</p>

When you click on the "Get a receipt by mail" button, to the user's mail, if it is specified in the
database data, the generated receipt will come:

<p align="center">
  <img src="/images/img9.jpg" alt="Message about the successful sending of the receipt to the mail" width="250"/>
</p>

<p align="center">
  <img src="/images/img10.jpg" alt="Letter with receipt" width="250"/>
</p>

Also, when you click on the "Pay" button, a page with instructions for paying for details will open,
from where you can, by clicking on the details, copy the necessary values ​​\u200b\u200bfor filling
in the banking application

<p align="center">
  <img src="/images/img11.jpg" alt="Page with payment details" width="250"/>
</p>

On the counters page, you can see detailed information about the counters at the sites:

- Date of last transmission of meter readings
- Last transferred values;

<p align="center">
  <img src="/images/img12.jpg" alt="Page with counters" width="250"/>
</p>

You can also submit readings on this page by entering them in the appropriate fields. If you enter
incorrect data, the user will be immediately informed about this:

<p align="center">
  <img src="/images/img13.jpg" alt="Incorrect transmitted data alert" width="250"/>
</p>

If the data is correct, then after writing it to the database, the corresponding message will be
displayed to the user:

<p align="center">
  <img src="/images/img14.jpg" alt="Data Transfer Successful" width="250"/>
</p>
