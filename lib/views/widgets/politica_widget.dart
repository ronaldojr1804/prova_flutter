import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WdPoliticaPrivacidadeButton extends StatelessWidget {
  const WdPoliticaPrivacidadeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        String url = 'www.google.com';
        if (!await launchUrl(Uri.parse(url))) {
          throw Exception('Could not launch $url');
        }
      },
      child: const Center(
        child: Text(
          'Política de privacidade',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
