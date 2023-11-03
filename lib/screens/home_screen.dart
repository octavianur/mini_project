import 'package:flutter/material.dart';
import 'package:mini_project/providers/nyt.dart';
import 'package:mini_project/widgets/categoriesWidgets/categories_section.dart';
import 'package:mini_project/widgets/navbar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
@override
  void initState() {
    super.initState();
    // Fetch data when the screen is initially loaded
    getBooksData();
  }

//  untuk mengambil data buku dari penyedia layanan (provider)
  Future<void> getBooksData() async {
    await Provider.of<NYT>(context, listen: false).getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const NavBar(HomeScreen.routeName),
      // daftar atau tampilan yang dapat di-refresh ketika pengguna menarik layarnya.

      body: RefreshIndicator(
        color: const Color(0xff0DB067),
        backgroundColor: Colors.white,
        // mengontrol berapa jarak yang harus ditarik oleh pengguna sebelum refresh dimulai
        displacement: 80,
        //  fungsi yang akan dipanggil saat pengguna menarik dan melepaskan tampilan untuk melakukan refresh
        onRefresh: () async {
          await getBooksData();
        },
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            CategoriesSection()
          ],
        ),
      ),
    );
  }
}
