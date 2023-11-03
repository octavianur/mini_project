import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_project/providers/books.dart';
import 'package:mini_project/screens/bookshelf_screen.dart';
import 'package:mini_project/screens/home_screen.dart';
import 'package:mini_project/screens/search_screen.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  final String currentRoute;

  const NavBar(this.currentRoute, {super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool openNav = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: min(MediaQuery.of(context).size.height * 0.09, 60),
      width: min(
          openNav
              ? MediaQuery.of(context).size.width * 0.6
              : MediaQuery.of(context).size.width * 0.2,
          200),
      child: Row(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(15),
            )),
            color: Colors.white,
            elevation: 4,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (openNav)
                    NavbarButton(Icons.bookmark, BookShelfScreen.routeName,
                        widget.currentRoute),
                  if (openNav)
                    NavbarButton(
                        Icons.home, HomeScreen.routeName, widget.currentRoute),
                  if (openNav)
                    NavbarButton(Icons.search, SearchScreen.routeName,
                        widget.currentRoute),
                ]),
          ),
          SizedBox(
            width: 42,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              child: Icon(
                openNav ? Icons.chevron_right : Icons.chevron_left,
                color: const Color(0xff0DB067),
              ),
              onPressed: () {
                setState(() {
                  openNav = !openNav;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NavbarButton extends StatelessWidget {
  final IconData icon;
  final String route;
  final String currentRoute;

  const NavbarButton(this.icon, this.route, this.currentRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<Books>(context, listen: false);
    return IconButton(
        color: const Color(0xff0DB067),
        onPressed: () {
          if (currentRoute == route) return;
          Navigator.of(context).pushReplacementNamed(route);
          books.setFirstLoad(true);
        },
        icon: Icon(icon));
  }
}
