//
//  AppDelegate.h
//  ProjectAPI.GOV.UA
//
//  Created by Admin on 28.04.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//
/*
 
 Використовуючи API  HYPERLINK "https://public.nazk.gov.ua/"  Єдиного державного реєстру декларацій потрібно написати додаток , який буде:
 1.через пошук по ключовому слові (наприклад, прізвище) отримувати список людей, які відповідають умовам пошуку
 відображати отриманий список в таблиці, де по кожному елементу відображати основну інформацію (ПІБ, місце роботи, посада) а також дві іконки: «книжечка» і «зірочка»+
 2.по натисненні на «книжечку» відкривати для перегляду pdf-декларацію обраної людини+
 3.по натисненні на «зірочку» додавати дану людину в «список обраних» (або видаляти її звідти якщо вона вже є тому списку) та при додаванні має бути можливість написати коментар до цього запису+
 4.давати можливість переглянути «список обраних» людей (по суті має відобразитись такий самий  список як у п.2, але там мають бути тільки ті люди, яким користувач проставив «зірочку») + коментар користувача (якщо такий був доданий)+
 5.при перегляді «списку обраних» давати можливість відредагувати коментар по кожній людині (або додати його, якщо він не був доданий спочатку)+

 */
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

