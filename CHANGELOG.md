# Change Log
## 2.4.0
date: 2024-10-11
changes:
- add: new method `registerByPhone`

## 2.3.0
date: 2024-10-09
changes:
- update: flutter sdk min version to 3.2.0
- update: stash to 5.2.0 and stash_sqlite to 5.3.0

## 2.2.3
date: 2023-10-28
changes:
- fix: default vault path.

## 2.2.1
date: 2023-09-29
changes:
- fix: await fetch userinfo when init.
- fix: catch error info when fetch app config.

## 2.2.0
date: 2023-09-20
changes:
- add methods for soft delete account
- add methods for cancel soft delete account


## 2.1.0
date: 2023-06-21
changes:
- add methods for password recovery

## 2.0.0
date: 2023-06-20
changes:
- BREAKING CHANGE, NOT COMPATIBLE WITH V1 

## 1.1.2
date: 2022-09-18
changes:
- refactoring.
- persist storage token.

## 1.1.0
date: 2022-09-18
changes:
- Add example app.
- Add method getCaptcha.
- Add method: logout, loginByCode.
- Add register: by phone, by email.
- Add method to send phone and email verify code.

## 1.0.0 
date: 2022-08-09

changes:
- Init `CASAuth`, `Client`, `User` classes.
- Add registerByUserName, loginByUserName to `Client` class.
- Add unit test cases to test login via username and password.
- Add unit test cases to test register new user via username and password.
