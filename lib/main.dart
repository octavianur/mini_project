import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project/providers/books.dart';
import 'package:mini_project/providers/bookshelf.dart';
import 'package:mini_project/providers/categories.dart';
import 'package:mini_project/providers/nyt.dart';
import 'package:mini_project/screens/bookshelf_screen.dart';
import 'package:mini_project/screens/home_screen.dart';
import 'package:mini_project/screens/search_screen.dart';
import 'package:mini_project/screens/spesific_search_screen.dart';
import 'package:mini_project/services/connectivity_service.dart';
import 'package:mini_project/services/connectivity_status.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const BookApp());
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    // mengatur orientasi layar yang diinginkan untuk aplikasi Anda.
    SystemChrome.setPreferredOrientations([
      // mode potret dengan perangkat dalam posisi tegak
      DeviceOrientation.portraitUp,
      // mode potret dengan perangkat dalam posisi terbalik
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Books(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => NYT(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Bookshelf(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Categories(),
        ),
        // mengelola status konektivitas dalam aplikasi 
        StreamProvider<ConnectivityStatus>(
          create: (context) =>
              ConnectivityService().connectionStatusController.stream,
          initialData: ConnectivityStatus.Cellular,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))),
        debugShowCheckedModeBanner: false,
        title: 'Book App',
        initialRoute: HomeScreen.routeName,
        routes: {
          SearchScreen.routeName: (context) =>  SearchScreen(),
          BookShelfScreen.routeName: (context) =>  BookShelfScreen(),
          SpesificSearchScreen.routeName: (context) => SpesificSearchScreen(),
          HomeScreen.routeName: (context) =>   HomeScreen(),
        },
      ),
    );
  }
}
