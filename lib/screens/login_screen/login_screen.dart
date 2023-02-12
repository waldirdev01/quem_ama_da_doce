import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quem_ama_da_doce/models/app_user/app_user.dart';

import '../../helpers/validators.dart';
import '../../models/app_user/app_user_manager.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: const Text(
              'CRIAR CONTA',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Consumer<UserManager>(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Esqueci a senha',
                      style: TextStyle(
                        color: UserManager().loading
                            ? Theme.of(context).primaryColor.withOpacity(0.2)
                            : Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                builder: (context, userManager, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (email != null) {
                            if (!emailValid(email)) return 'E-mail inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                        ),
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        obscureText: true,
                        validator: (password) {
                          if (password != null) {
                            if (password.isEmpty || password.length < 6) {
                              return 'Senha inválida';
                            }
                          }
                          return null;
                        },
                      ),
                      child!,
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: userManager.loading
                              ? MaterialStateProperty.all(Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2))
                              : MaterialStateProperty.all(
                                  Theme.of(context).primaryColor,
                                ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  final userapp = AppUser(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      name: '');
                                  userManager.signIn(
                                      userApp: userapp,
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
                                }
                              },
                        child: userManager.loading
                            ? CircularProgressIndicator(
                                backgroundColor: Theme.of(context).primaryColor,
                                valueColor:
                                    const AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
