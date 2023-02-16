
import 'package:shopapp/Models/DBHelper.dart';
class AppData {
  static final AppData _appData = AppData._internal();
  
  String text="";
  DBHelper _dbHelper = DBHelper();
  
  factory AppData() {
    
    return _appData;
  }


  // ignore: non_constant_identifier_names
  DBHelper get get_dbhelper {
    return _dbHelper;
  }
 
  // Creating the setter method
  // to set the input in Field/Property
  // ignore: non_constant_identifier_names
  set set_dbhelper(DBHelper dbHelper) {
    _dbHelper = dbHelper;
  }


  AppData._internal();
}
final appData = AppData();