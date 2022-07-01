import 'package:graduation_project/shared/network/local/cash_helper.dart';


class SharedPreferenceRepository {
  SharedPreferenceRepository();

  // static Future<void> setLanguageSeen() async {
  //   final SharedPreferences sharedPreferences =
  //   await SharedPreferences.getInstance();
  //
  //   sharedPreferences.setBool('languageSeen', true);
  // }
  //
  // static Future<bool> isLanguageSeen() async {
  //   final SharedPreferences sharedPreferences =
  //   await SharedPreferences.getInstance();
  //
  //   return sharedPreferences.getBool('languageSeen') ?? false;
  // }

  static Future<String> getHomeRoute() async {
    String route;

    if (await CashHelper.getData(key: 'role') == 'user') {
      route = 'userHome';
    }else if (await CashHelper.getData(key: 'role') == 'center'){
      route = 'centerHome';

    }else if (await CashHelper.getData(key: 'role') == 'store'){
      route = 'storeHome';

    }else if (await CashHelper.getData(key: 'role') == 'volunteer'){
      route = 'volunteerHome';

    }else if (await CashHelper.getData(key: 'role') == 'admin'){
      route = 'adminHome';

    }
    // else if (await isLanguageSeen() == false) {
    //   route = RouteNames.selectLanguageScreen;
    // }
    else {
      route = 'start';
    }
    return route;
  }
}