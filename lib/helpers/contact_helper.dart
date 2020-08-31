import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//  id    name    email   phone   img
//   0    Daniel  da@..   34247   /images/

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

//Singleton
class ContactHelper{
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  Database _db;

  ContactHelper.internal();

  //initDB
  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contact.db");
    
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)"
      );
    });
  }//end initDb

  //db
  Future<Database> get db async{
    if(db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }//end else
  }//end get db

}//end class ContactHelper

class Contact{
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }//end fromMap

  Map toMap(){
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
    };
    if(id !=  null){
      map[idColumn] = id;
    }
  }//end toMap()

  @override
  String toString() {
    return "Contact:(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }//end toString

}//end class Contact