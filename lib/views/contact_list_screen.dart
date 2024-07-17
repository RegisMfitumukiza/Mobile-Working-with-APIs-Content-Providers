// lib/views/contact_list_screen.dart
import 'package:flutter/material.dart';
import 'package:authentication_api/services/contact_service.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactListScreen extends StatelessWidget {
  final ContactService _contactService = ContactService();

  ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: _contactService.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts found'));
          }

          List<Contact> contacts = snapshot.data!;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Contact contact = contacts[index];
              return ListTile(
                title: Text(contact.displayName ?? 'No name'),
                subtitle: Text(contact.phones?.first.value ?? 'No phone number'),
              );
            },
          );
        },
      ),
    );
  }
}
