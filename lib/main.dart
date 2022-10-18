import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key} ): super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductsManager(),
         ),
      
      ],
      child: MaterialApp(
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
          home: const ProductsOverviewScreen(),
          routes: {
            CartScreen.routeName:
              (ctx) => const CartScreen(),
            OrderScreen.routeName:
              (ctx) => const OrderScreen(),
            UserProductsScreen.routeName:
              (ctx) => const UserProductsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == ProductsDateilScreen.routeName) {
              final productId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (ctx) {
                  return ProductsDateilScreen(
                    ctx.read<ProductsManager>().findById(productId),
                 );
                },
              );
            }
        return null;
      },
    ),
  );
    
  }
}