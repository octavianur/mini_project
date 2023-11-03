import 'package:flutter/material.dart';
import 'package:mini_project/providers/books.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool byTitle = true;
  late String searchString = '';
  bool free = false;

  void search() {
    // Toggle between TITLE and AUTHOR search
    byTitle = !byTitle;
    Provider.of<Books>(context, listen: false).setStartIndex();
    Provider.of<Books>(context, listen: false).toggleTotalItemsCalculation(true);
    Provider.of<Books>(context, listen: false).getSearchedBookData(searchString, byTitle, free);
    Provider.of<Books>(context, listen: false).toggleTotalItemsCalculation(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: SizedBox(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        free = !free;
                        search();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        free ? 'FREE' : 'ALL',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 56,
                    child: VerticalDivider(
                      width: 0,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      search();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(byTitle ? 'TITLE' : 'AUTHOR',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 56,
                child: VerticalDivider(
                  width: 0,
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    autofocus: true,
                    cursorColor: Colors.black38,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                      hintText: 'Search Book',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ).copyWith(
                      hintText: byTitle ? 'Search by Title' : 'Search by Author',
                    ),
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      searchString = value;
                    },
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        search();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      search();
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
