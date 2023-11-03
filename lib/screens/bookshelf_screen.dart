import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/providers/bookshelf.dart';
import 'package:mini_project/widgets/navbar.dart';
import 'package:mini_project/widgets/saved_book_item.dart';
import 'package:provider/provider.dart';

class BookShelfScreen extends StatefulWidget {
  static const routeName = '/bookshelf';

  const BookShelfScreen({super.key});

  @override
  State<BookShelfScreen> createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends State<BookShelfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const NavBar(BookShelfScreen.routeName),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          return Future.delayed(Duration.zero);
        },
        child: Consumer<Bookshelf>(
            builder: (BuildContext context, bookshelf, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 2,
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/code.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    color: Colors.black38,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 0, left: 16, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Bookshelf',
                              textAlign: TextAlign.end,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                      future: Provider.of<Bookshelf>(context, listen: false)
                          .fetchAndSetBooks(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const Center(child: CircularProgressIndicator())
                            : bookshelf.savedBooks.isEmpty
                                ? const EmptyBookshelfWidget()
                                : ListView.builder(
                                    itemCount: bookshelf.savedBooks.length,
                                    itemBuilder: (ctx, i) => SavedBookItem(
                                        bookshelf.savedBooks.reversed
                                            .toList()[i]));
                      }))
            ],
          );
        }),
      ),
    );
  }
}

class EmptyBookshelfWidget extends StatelessWidget {
  const EmptyBookshelfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
          text: const TextSpan(children: [
        TextSpan(
          text: "Click",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        WidgetSpan(child: Icon(Icons.bookmark_border, size: 18)),
        TextSpan(
          text: "to add books to the bookshelf",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ])),
    );
  }
}
