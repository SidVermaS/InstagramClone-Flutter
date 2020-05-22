import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      "submit": "Submit",
      "send_otp": "Send OTP",
      "verify": "Verify",
      "add_customer": "Add customer",
      'verify_phone_number_hint_text_field_1': 'Enter Phone Number',
      'verify_phone_number_label_text_field_1': 'Phone Number',
      'verify_phone_number_error_text_field_1':
          'Mobile No. should be of 10 digits only',
      'select_country': 'Select Country',
      'get_pin': 'GET PIN',
      'start_using_rokda': 'START USING ROKDA',
      'start_intro_message_1': 'Manage your debit/credit from phone',
      'start_intro_message_2': 'Helping Businessmen\nacross India',
      'next': 'NEXT',
      'add_business_message_1': 'Business/Shop name',
      'add_business_message_2': 'You can send FREE SMS to your customers',
      'add_business_message_3':
          'You can send FREE Your customers can identify your business to your customers',
      'add_business_text_field_hint_1': 'Enter shop/business name',
      'add_business_text_field_error_1': 'Atlest 1 character is expected',
      'create_new_ledgerbook': 'CREATE NEW LEDGERBOOK',
      'home': 'Home',
      'more': 'More',
      'add_customer': 'ADD CUSTOMER',
      'add_customer_text_field_hint_1': 'Type Customer Name',
      'new_entry_enter_details_hint':
          'Enter Details (Item Name, Bill No, Quantity...)',
      'new_entry_enter_details_error':
          'Details needs to be less than 50 characters',
      'transactions': 'Transactions',
      'share_on_whatsapp': 'Share on Whatsapp',
      'share': 'Share',
      'entry_details': 'Entry Details',
      'edit_entry_details': 'Edit Entry Details',
      'edit': 'Edit',
      'sms_delivered': 'SMS delivered',
      'took': 'took',
      'save': 'SAVE',
      'invalid_amount': 'Invalid Amount',
      'delete_transaction': 'Delete Transaction',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'enter_amount': 'Enter Amount',
      'enter_note': 'Enter Note',
      'you_will_get': 'You will get',
      'you_will_give': 'You will give',
      'entries': 'ENTRIES',
      'you_gave': 'YOU GAVE',
      'you_got': 'YOU GOT',
      'payment_is_due': 'Payment is due',
      'today': 'Today',
      'set_date_for_payment': 'Set date for payment',
      'collect_money_on': 'Collect money on',
      'settled_up': 'Settled Up',
      'you_gave_lc': 'You Gave',
      'you_got_lc': 'You Got',
      'net_balance': 'Net Balance',
      'start_date': 'START DATE',
      'end_date': 'END DATE',
      'note': 'Note',
      'reports': 'Reports',
      'report': 'Report',
      'payment': 'Payment',
      'reminder': 'Reminder',
      'sms': 'SMS',
      'log_out': 'Log Out',
      'language': 'Language',
      'delete': 'Delete',
      'delete_khata': 'Delete Khata',
      'delete_khata_1':
          'You are going to delete this business. By doing so, you will loose all the entries in this Khata. Are you ABSOLUTELY sure?',
      'delete_khata_2': 'To delete, type',
      'delete_khata_3': 'and press the delete button',
      'type': 'Type',
      'invalid_business_name': 'Invalid business name',
      'business_photo': 'Business Photo',
      'profile': 'Profile',
      'your_name': 'Your Name',
      'business_name': 'Business Name',
      'registered_phone_number': 'Registered Phone Number',
      'enter_your_name': 'Enter Your Name',
      'enter_business_name': 'Enter Business Name',
      'invalid_business_name': 'Invalid business name',
      'invalid_name': 'Invalid name',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
    },
    'hi': {
      "submit": "Submit",
      "send_otp": "Send OTP",
      "verify": "Verify",
      "add_customer": "Add customer",
      'verify_phone_number_hint_text_field_1': 'Enter Phone Number',
      'verify_phone_number_label_text_field_1': 'Phone Number',
      'verify_phone_number_error_text_field_1':
          'Mobile No. should be of 10 digits only',
      'select_country': 'Select Country',
      'get_pin': 'GET PIN',
      'start_using_rokda': 'START USING ROKDA',
      'start_intro_message_1': 'Manage your debit/credit from phone',
      'start_intro_message_2': 'Helping Businessmen\nacross India',
      'next': 'NEXT',
      'add_business_message_1': 'Business/Shop name',
      'add_business_message_2': 'You can send FREE SMS to your customers',
      'add_business_message_3':
          'You can send FREE Your customers can identify your business to your customers',
      'add_business_text_field_hint_1': 'Enter shop/business name',
      'add_business_text_field_error_1': 'Atlest 1 character is expected',
      'create_new_ledgerbook': 'CREATE NEW LEDGERBOOK',
      'home': 'Home',
      'more': 'More',
      'add_customer': 'ADD CUSTOMER',
      'add_customer_text_field_hint_1': 'Type Customer Name',
      'new_entry_enter_details_hint':
          'Enter Details (Item Name, Bill No, Quantity...)',
      'new_entry_enter_details_error':
          'Details needs to be less than 50 characters',
      'transactions': 'Transactions',
      'share_on_whatsapp': 'Share on Whatsapp',
      'share': 'Share',
      'entry_details': 'Entry Details',
      'edit_entry_details': 'Edit Entry Details',
      'edit': 'Edit',
      'sms_delivered': 'SMS delivered',
      'took': 'took',
      'save': 'SAVE',
      'invalid_amount': 'Invalid Amount',
      'delete_transaction': 'Delete Transaction',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'enter_amount': 'Enter Amount',
      'enter_note': 'Enter Note',
      'you_will_get': 'You will get',
      'you_will_give': 'You will give',
      'entries': 'ENTRIES',
      'you_gave': 'YOU GAVE',
      'you_got': 'YOU GOT',
      'payment_is_due': 'Payment is due',
      'today': 'Today',
      'set_date_for_payment': 'Set date for payment',
      'collect_money_on': 'Collect money on',
      'settled_up': 'Settled Up',
      'you_gave_lc': 'You Gave',
      'you_got_lc': 'You Got',

      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
      'home': 'Home',
    },
  };

  String translate(key) {
    return _localizedValues[locale.languageCode][key];
  }

  static String of(BuildContext context, String key) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations)
        .translate(key);
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'hi', 'mr'].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(MyLocalizations(locale));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
