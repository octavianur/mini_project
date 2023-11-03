import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:mini_project/providers/books.dart';
import 'package:mini_project/widgets/books_grid.dart';
import 'package:mini_project/widgets/navbar.dart';
import 'package:mini_project/widgets/network_sensitive.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loadGrid = false;

  // Future<void> clearBooksList(BuildContext context) async {
  //   await Future.delayed(Duration.zero);
  //   Provider.of<Books>(context, listen: false).clearList();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // clearBooksList().then((_) {
    //   setState(() {
    //     loadGrid = true;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const NavBar(SearchScreen.routeName),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 2,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/code.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 32, left: 16, right: 16, bottom: 2),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Discover',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                'Search from more then 30 million books with over 10 million free ebooks...',
                                style: GoogleFonts.notoSans(
                                    textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  letterSpacing: 0.2,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              NetworkSensitive(offlineChild: Container(), child: const SearchBar())
            ],
          ),
          if (loadGrid) const BooksGrid(routeName: SearchScreen.routeName),
        ],
      ),
    );
  }
}
