import 'package:calculadoraimcdio/pages/list_imc_page.dart';
import 'package:calculadoraimcdio/pages/usuario_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController(initialPage: 0);
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          onPageChanged: (value) {
            setState(() {
              _page = value;
            });
          },
          controller: _pageController,
          children: const [ListImcPage(), UsuarioPage(isInicio: false)]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          _pageController.jumpToPage(value);
        },
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(label: "Meus IMCs", icon: Icon(Icons.list)),
          BottomNavigationBarItem(label: "Usuário", icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
