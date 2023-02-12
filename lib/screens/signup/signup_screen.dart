import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quem_ama_da_doce/models/app_user/app_user.dart';
import '../../helpers/validators.dart';
import '../../models/app_user/app_user_manager.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  late AppUser userApp;
  String _confirmSenha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: _formKey,
              child: Consumer<UserManager>(
                builder: (__, userManager, _) => ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Nome Completo'),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'O sobrenome é obrigatório';
                        }
                        return null;
                      },
                      onSaved: (name) {
                        _nameController.text = name!;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (!emailValid(email)) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                      onSaved: (email) {
                        _emailController.text = email!;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) {
                        _passwordController.text = pass!;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Repita a Senha'),
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return 'Campo obrigatório';
                        } else if (pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) {
                        _confirmSenha = pass!;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            userApp = AppUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                                name: _nameController.text);
                            if (userApp.password != _confirmSenha) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: const Text('As senhas não conferem'),
                                duration: const Duration(seconds: 1),
                              ));
                            }
                          }
                          context.read<UserManager>().signUp(
                              userApp: userApp,
                              failFunction: (code) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('$code'),
                                  duration: const Duration(seconds: 1),
                                ));
                              },
                              sucessFunction: () {
                                Navigator.of(context).pop();
                              });
                        },
                        child: userManager.loading
                            ? const CircularProgressIndicator(color: Colors.white,)
                            : const Text(
                                'Criar Conta',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
