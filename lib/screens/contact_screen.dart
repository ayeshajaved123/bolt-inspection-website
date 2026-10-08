import 'package:flutter/material.dart';
import '../widgets/simple_page_scaffold.dart';
import '../widgets/contact_form.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimplePageScaffold(
      title: 'Contact Us',
      body: ContactForm(),
    );
  }
}
