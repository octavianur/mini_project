import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/providers/books.dart';
import 'package:mini_project/services/connectivity_status.dart';
import 'package:mini_project/widgets/books_grid.dart';
import 'package:provider/provider.dart';

class SpesificSearchScreen extends StatefulWidget {
  static const routeName = '/spesific-search-screen';

  const SpesificSearchScreen({super.key});

  @override
  State<SpesificSearchScreen> createState() => _SpesificSearchScreenState();
}

class _SpesificSearchScreenState extends State<SpesificSearchScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var connectivity = Provider.of<ConnectivityStatus>(context);
    if (connectivity != ConnectivityStatus.Online) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> searchArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Provider.of<Books>(context, listen: false).setStartIndex();
    Provider.of<Books>(context, listen: false)
        .toggleTotalItemsCalculation(true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 2,
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/code.jpg"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: GestureDetector(
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              searchArgs['categoryTitle'] != null
                                  ? 'CATEGORY'
                                  : 'Search result for : ',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              searchArgs['bookTitle'] ??
                                  searchArgs['categoryTitle'],
                              softWrap: true,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: Provider.of<Books>(context, listen: false)
                  .getSearchedBookByArgs(searchArgs),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  Provider.of<Books>(context, listen: false)
                      .toggleTotalItemsCalculation(false);
                  return const BooksGrid(
                      routeName: SpesificSearchScreen.routeName);
                }
              }),
        ],
      ),
    );
  }
}
