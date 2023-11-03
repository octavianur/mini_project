import 'package:flutter/material.dart';
import 'package:mini_project/providers/books.dart';
import 'package:mini_project/widgets/books_overview_item.dart';
import 'package:mini_project/widgets/network_sensitive.dart';
import 'package:mini_project/widgets/pagination.dart';
import 'package:provider/provider.dart';

class BooksGrid extends StatelessWidget {
  final String routeName;

  const BooksGrid({Key? key, required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NetworkSensitive(
      offlineChild: Center(
        child: Image.asset('assets/images/nointernet.png'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Consumer<Books>(
          builder: (BuildContext context, books, _) {
            return Column(
              children: [
                if (books.firstLoad)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, left: 16, right: 16),
                    child: Paginator(),
                  ),
                books.spesificScreenLoadingState || books.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : books.reachedEnd
                        ? Center(
                            child: Text('No books found'),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                            child: GridView.builder(
                              itemCount: books.getBooksList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 2,
                                childAspectRatio: 2 / 3,
                              ),
                              itemBuilder: (context, i) {
                                return BookOverviewItem(books.getBooksList[i].toString());
                              },
                            ),
                          ),
              ],
            );
          },
        ),
      ),
    );
  }
}
