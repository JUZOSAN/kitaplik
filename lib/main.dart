import 'package:flutter/material.dart';
import 'profil.dart';
import 'indirilen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uygulama Adı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width *
            0.75, // Ekranın 3/4'ü kadar genişlik
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Drawer'ı kapat
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilSayfasi()),
                  );
                },
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                  ),
                  accountName: Text(
                    'Muhammed Kartal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text('muhammed@example.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      'MK',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.blue.shade900),
                title: Text('Ana Sayfa'),
                onTap: () {
                  // Ana sayfa yönlendirmesi
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite, color: Colors.blue.shade900),
                title: Text('Beğendiğim Kitaplar'),
                onTap: () {
                  // Beğenilen kitaplar sayfası yönlendirmesi
                },
              ),
              ListTile(
                leading: Icon(Icons.download, color: Colors.blue.shade900),
                title: Text('İndirilen Kitaplar'),
                onTap: () {
                  Navigator.pop(context); // Drawer'ı kapat
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const IndirilenKitaplar()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.blue.shade900),
                title: Text('Ayarlar'),
                onTap: () {
                  // Ayarlar sayfası yönlendirmesi
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.info, color: Colors.blue.shade900),
                title: Text('Hakkında'),
                onTap: () {
                  // Hakkında sayfası yönlendirmesi
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.search, color: Colors.blue.shade900),
          onPressed: () {
            // Arama sayfasına yönlendirme işlemi buraya gelecek
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.black12,
            height: 1.0,
          ),
        ),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // Popüler butonuna tıklandığında yapılacak işlemler
                },
                child: Container(
                  width: 110,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Popüler',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.favorite,
                          color: Colors.blue.shade900, size: 16),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              InkWell(
                onTap: () {
                  // En Son butonuna tıklandığında yapılacak işlemler
                },
                child: Container(
                  width: 110,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'En Son',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.access_time,
                          color: Colors.blue.shade900, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.blue.shade900),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hoş Geldiniz',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
