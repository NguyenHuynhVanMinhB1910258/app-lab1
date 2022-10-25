import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/products/edit_product_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'ui/screens.dart';
Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key} ): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
         ),
       ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
          // Khi authManager có báo hiệu thay đổi thì đọc lại authToken
          // cho productManager
          productsManager!.authToken = authManager.authToken;
          return productsManager;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager()
          ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager()
          ),
      ],
      child: Consumer<AuthManager>(
        builder:(ctx, authManager,child){
          return MaterialApp(
      title: 'My Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(
          secondary: Colors.deepOrange,
        ),
      ),
      
      // home: Container(
      //   color: Colors.green,
      //   ),
          home: authManager.isAuth
          ? const ProductsOverviewScreen()
          : FutureBuilder(
            future: authManager.tryAutoLogin(),
            builder:(ctx, snapshot){
              return snapshot.connectionState == ConnectionState.waiting
              ? const SplashScreen()
              : const AuthScreen();
              } ,
            ),
          routes: {
            CartScreen.routeName:
              (ctx) => const CartScreen(),
            OrderScreen.routeName:
              (ctx) => const OrderScreen(),
            UserProductsScreen.routeName:
              (ctx) => const UserProductsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == EditProductScreen.routeName) {
              final productId = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (ctx) {
                  return EditProductScreen(
                    productId != null
                    ? ctx.read<ProductsManager>().findById(productId)
                    : null,
                 );
                },
              );
            }
        return null;
      },
    );
    },
    ),   
  );   
}
}