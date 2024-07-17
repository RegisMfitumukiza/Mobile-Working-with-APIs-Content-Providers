import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService {
  Future<List<Contact>> getContacts() async {
    // Request permission to access contacts
    if (await Permission.contacts.request().isGranted) {
      // Get all contacts
      Iterable<Contact> contacts = await ContactsService.getContacts();
      return contacts.toList();
    } else {
      throw Exception("Permission Denied");
    }
  }
}