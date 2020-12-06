import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:skooleo/src/screens/tabs/home_tab.dart';
import 'package:skooleo/src/screens/tabs/invoice_list_tab.dart';
import 'package:skooleo/src/screens/tabs/more_tab.dart';
import 'package:skooleo/src/screens/tabs/savings_tab.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> slides = [
    HomeTab(),
    InvoiceListTab(),
    SavingsTab(),
    MoreTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            'assets/logos/skooleo_logo3.png',
            height: 40,
            // width: 150,
            // fit: BoxFit.cover,
          ),
        ),
      ),
      body: IndexedStack(
        children: slides,
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              LineIcons.home,
              size: 23,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              LineIcons.file,
              size: 23,
            ),
            label: 'Invoices',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              LineIcons.money,
              size: 23,
            ),
            label: 'Savings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              LineIcons.bars,
              size: 23,
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
