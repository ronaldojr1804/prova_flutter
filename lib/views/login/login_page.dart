import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prova_flutter/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String usuario = '';
  String senha = '';
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF004D40),
              Color(0xFF00796B),
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Usuário',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          onSaved: (newValue) {
                            if (newValue != null) {
                              usuario = newValue;
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o usuário';
                            } else if (value.endsWith(' ')) {
                              return 'Não pode terminar com espaço';
                            } else {
                              return null;
                            }
                          },
                          maxLength: 20,
                          decoration: InputDecoration(
                            hintText: 'Digite seu usuário',
                            fillColor: Colors.white,
                            filled: true,
                            counterText: '',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: const Icon(Icons.people),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Senha',
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: TextFormField(
                          maxLength: 20,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Digite sua senha',
                            fillColor: Colors.white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefixIcon: const Icon(Icons.lock),
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a senha';
                            } else if (value.endsWith(' ')) {
                              return 'Não pode terminar com espaço';
                            } else if (value.length < 2) {
                              return 'A senha não pode ter menos que dois caracteres';
                            } else if (!RegExp(r'^[a-zA-Z0-9]+$')
                                .hasMatch(value)) {
                              return 'A senha não pode conter caracteres especiais';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            if (newValue != null) {
                              senha = newValue;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Observer(
                        builder: (context) {
                          return SizedBox(
                            child: (authService.isLoading)
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                      color: Colors.white,
                                    ),
                                  )
                                : const SizedBox(),
                          );
                        },
                      ),
                      Observer(
                        builder: (context) {
                          return Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: authService.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        bool loginSuccess =
                                            await authService.login(
                                                'usuarioteste', 'senhateste');

                                        if (loginSuccess) {
                                          if (kDebugMode) {
                                            print('Login bem-sucedido!');
                                          }
                                        } else {
                                          if (kDebugMode) {
                                            print(
                                              'Credenciais inválidas. Tente novamente.',
                                            );
                                          }
                                        }
                                      }
                                    },
                              child: const Text('Entrar'),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  String url = 'www.google.com';
                  if (!await launchUrl(Uri.parse(url))) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: const Text(
                  'Política de privacidade',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
