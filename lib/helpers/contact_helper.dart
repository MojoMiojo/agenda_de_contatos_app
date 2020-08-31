import 'package:sqflite/sqflite.dart';

final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

class ContactHelper{

}

//  id    name    email   phone   img
//   0    Daniel  da@..   34247   /images/

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