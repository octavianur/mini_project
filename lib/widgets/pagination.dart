import 'package:flutter/material.dart';
import 'package:mini_project/providers/books.dart';
import 'package:provider/provider.dart';

class Paginator extends StatelessWidget {
  const Paginator({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Books>(
      builder: (BuildContext context, books, _) {
        final totalBookCount = books.totalBookCount;
        final itemsPerPage = 18;
        final canPaginateForward = books.startIndex <= totalBookCount - itemsPerPage;

        return Card(
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$totalBookCount books found',
                  style: const TextStyle(
                    color: Color(0xff0DB067),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  color: const Color(0xff0DB067),
                  icon: const Icon(Icons.chevron_left),
                  onPressed: books.startIndex == 0
                      ? null
                      : () {
                          books.paginate(false);
                          books.setSpesificScreenLoadingState(true);
                        },
                ),
                IconButton(
                  color: const Color(0xff0DB067),
                  icon: const Icon(Icons.chevron_right),
                  onPressed: canPaginateForward
                      ? () {
                          books.paginate(true);
                          books.setSpesificScreenLoadingState(true);
                        }
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
