import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository{
  static String loginID = '';
  static String password = '';
  static String firstName = '';
  static String lastName = '';
  static String email = '';
  static String phone = '';

  static void saveData() async
  {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    await prefs.setString('String1', loginID );
    await prefs.setString('String2', password );
    await prefs.setString('String3', firstName);
    await prefs.setString('String4', lastName);
    await prefs.setString('String5', email);
    await prefs.setString('String6', phone);
  }

  static void loadData() async
  {
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    loginID = await prefs.getString('String1');
    password = await prefs.getString('String2');
    firstName = await prefs.getString('String3');
    lastName = await prefs.getString('String4');
    email = await prefs.getString('String5');
    phone = await prefs.getString('String6');
    }
}
