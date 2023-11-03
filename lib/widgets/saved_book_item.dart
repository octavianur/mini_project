import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/models/savedBook.dart';
import 'package:mini_project/providers/bookshelf.dart';
import 'package:mini_project/screens/book_detail_screen.dart';
import 'package:mini_project/services/book_search_utils.dart';
import 'package:mini_project/services/utils.dart';
import 'package:mini_project/widgets/network_sensitive.dart';
import 'package:provider/provider.dart';


class SavedBookItem extends StatelessWidget {
  final SavedBook savedBook;

  const SavedBookItem(this.savedBook, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _showBookDetails(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Dismissible(
          key: ValueKey(savedBook.id),
          background: Container(
            alignment: Alignment.centerRight,
            color: Colors.grey[100],
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            await Provider.of<Bookshelf>(context, listen: false)
                .removeSavedBook(savedBook.id.toString());
          },
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.11,
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Card(
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        child: NetworkSensitive(
                          offlineChild: const Center(
                            child: Text(
                              'NO INTERNET CONNECTION',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          child: Image.network(
                            savedBook.imageUrl.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            savedBook.authors.toString(),
                            style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Utils.trimString(savedBook.title.toString(), 50),
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showBookDetails(BuildContext context) async {
    final searchBook = await BookSearchUtils.fetchBookById(savedBook.id.toString());
    showModalBottomSheet(
      elevation: 18,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return searchBook != null
            ? BookDetailsScreen(searchBook, bookId: '',)
            : const Center(
                child: Text('Failed to load book details.'),
              );
      },
    );
  }
}
