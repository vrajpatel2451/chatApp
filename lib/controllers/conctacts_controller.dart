import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ConctactsController extends GetxController {
  RxList<Contact> contacts = <Contact>[].obs;
  RxList<Contact> filteredContacts = <Contact>[].obs;
  TextEditingController searchQuery = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getInitialContacts();
  }

  @override
  void dispose() {
    searchQuery.dispose();
    super.dispose();
  }

  Future<void> getInitialContacts() async {
    if (await FlutterContacts.requestPermission()) {
      contacts.value = await FlutterContacts.getContacts(withProperties: true);
      filteredContacts.value = contacts.value;
      contacts.refresh();
      filteredContacts.refresh();
    }
  }

  void updateFilteredContacts() {
    filteredContacts.value = contacts.value
        .where((contact) =>
            contact.name.first
                .toLowerCase()
                .contains(searchQuery.text.toLowerCase()) ||
            contact.name.last
                .toLowerCase()
                .contains(searchQuery.text.toLowerCase()) ||
            contact.phones.first.number
                .toLowerCase()
                .contains(searchQuery.text.toLowerCase()))
        .toList();
  }
}
