import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import '../core/colors/colors.dart';
import '../core/constants/strings.dart';
import '../core/themes/text_style.dart';
import '../icons/icons.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getAllContacts();
  }

  void getAllContacts() async {
    List<Contact> contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      //appbar
      appBar: AppBar(
        title: const Text(
          Strings.appTitle,
          style: AppTextStyle.h1TextStyle,
        ),
        backgroundColor: AppColors.titleBackground,
      ),

      // fab
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.titleBackground,
        onPressed: () async {
          try {
            Contact contact = await ContactsService.openContactForm();
            getAllContacts();
          } on FormOperationException catch (e) {
            switch (e.errorCode) {
              case FormOperationErrorCode.FORM_OPERATION_CANCELED:
              case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
              case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
                print(e.toString());
                break;
              default:
            }
          }
        },
        child: IconsWidget.add,
      ),

      //body
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contact = contacts[index];

          //list
          return ListTile(
            leading: (contact.avatar != null)
                ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar!))
                : const CircleAvatar(
                    child: IconsWidget.person,
                  ),
            title: Text(contact.givenName ?? "Default Value"),
            subtitle: Text(contact.phones!.isNotEmpty
                ? contact.phones?.elementAt(0).value ?? "Default Value"
                : ""),
          );
        },
      ),
    );
  }
}
