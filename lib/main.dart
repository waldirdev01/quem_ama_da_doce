import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quem_ama_da_doce/models/cart/cart_manager.dart';
import 'package:quem_ama_da_doce/models/home_section/home_manager.dart';
import 'package:quem_ama_da_doce/models/products/product_manager.dart';
import 'package:quem_ama_da_doce/screens/base/base_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quem_ama_da_doce/screens/cart/cart_screen.dart';
import 'package:quem_ama_da_doce/screens/login_screen/login_screen.dart';
import 'package:quem_ama_da_doce/screens/product/product_screen.dart';
import 'package:quem_ama_da_doce/screens/signup/signup_screen.dart';
import 'models/admin_user_manager/admin_user_manager.dart';
import 'models/app_user/app_user_manager.dart';
import 'models/products/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: true,
          update: (_, userManager, cartManager) => cartManager!..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
          adminUsersManager!..updateUser(userManager),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 4, 125, 141),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BaseScreen(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) =>  SignUpScreen());
            case '/product':
              return MaterialPageRoute(builder: (_) =>ProductScreen(settings.arguments as Product));
               case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
              case '/':
            default:
              MaterialPageRoute(builder: (_) => BaseScreen());
          }
          return null;
        },
      ),
    );
  }
}
