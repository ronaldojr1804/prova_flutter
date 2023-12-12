import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prova_flutter/services/auth_service.dart';
import 'package:prova_flutter/views/widgets/politica_widget.dart';
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
                  child: Observer(
                    builder: (_) {
                      return Column(
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
                              enabled: !authService.isLoading,
                              maxLength: 20,
                              decoration: InputDecoration(
                                hintText: 'Digite seu usuário',
                                fillColor: Colors.white,
                                filled: true,
                                counterText: '',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                prefixIcon: const Icon(Icons.people),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
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
                              enabled: !authService.isLoading,
                              decoration: InputDecoration(
                                hintText: 'Digite sua senha',
                                fillColor: Colors.white,
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                          if (authService.isLoading)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.transparent,
                                color: Colors.white,
                              ),
                            ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: authService.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        await authService
                                            .login('usuarioteste', 'senhateste')
                                            .then((loginSuccess) {
                                          if (loginSuccess) {
                                            Navigator.pushNamed(
                                              context,
                                              '/cards',
                                            );
                                          } else {
                                            if (kDebugMode) {
                                              print(
                                                'Credenciais inválidas. Tente novamente.',
                                              );
                                            }
                                          }
                                        });
                                      }
                                    },
                              child: const Text('Entrar'),
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const WdPoliticaPrivacidadeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
