import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/providers/books.dart';
import 'package:mini_project/screens/book_detail_screen.dart';
import 'package:mini_project/services/utils.dart';
import 'package:provider/provider.dart';

class BookOverviewItem extends StatelessWidget {
  final String bookId;

  const BookOverviewItem(this.bookId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBookDetails(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Card(
                color: Colors.grey,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildBookCoverImage(context),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Expanded(
            flex: 2,
            child: _buildBookTitle(context),
          ),
        ],
      ),
    );
  }

  void _showBookDetails(BuildContext context) {
    final book = Provider.of<Books>(context, listen: false).getBookById(bookId);
    showModalBottomSheet(
      elevation: 18,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BookDetailsScreen(book, bookId: '',);
      },
    );
  }

  Widget _buildBookCoverImage(BuildContext context) {
    final book = Provider.of<Books>(context, listen: false).getBookById(bookId);
    return Image.network(
      book.thumbnailUrl.toString(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error); // Display an error icon or message
      },
      fit: BoxFit.cover,
    );
  }

  Widget _buildBookTitle(BuildContext context) {
    final book = Provider.of<Books>(context, listen: false).getBookById(bookId);
    return Text(
      Utils.trimString(book.title.toString(), 22),
      textAlign: TextAlign.center,
      maxLines: 2,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
