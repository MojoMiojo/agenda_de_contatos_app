import 'dart:io';

import 'package:agenda_de_contatos_app/helpers/contact_helper.dart';
import 'package:agenda_de_contatos_app/ui/contact_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();
    _getAllContacts();
  } //end initState

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _contactCard(context, index);
          }),
    );
  }

  //_contactCard
  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: contacts[index].img != null
                            ? FileImage(File(contacts[index].img))
                            : AssetImage("images/person.png"))),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contacts[index].name ?? "",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contacts[index].email ?? "",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        contacts[index].phone ?? "",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      onTap: () {
        _showContactPage(contact: contacts[index]);
      },
    );
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContactPage(
                  contact: contact,
                )));
    if (contact != null && recContact != null) {
      await helper.updateContact(recContact);
    } else if (contact == null && recContact != null) {
      print("Passou aqui");
      await helper.saveContact(recContact);
    }
    _getAllContacts();
  } //end showContactPage

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }
} //end class
