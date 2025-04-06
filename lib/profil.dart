import 'package:flutter/material.dart';
import 'main.dart';

class ProfilSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profil',
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade900,
                  child: Text(
                    'MK',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade900,
                    radius: 18,
                    child: IconButton(
                      icon:
                          Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      onPressed: () {
                        // TODO: Profil fotoğrafı değiştirme işlemi
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.person, color: Colors.blue.shade900),
              title: Text('Ad Soyad'),
              subtitle: Text('Muhammed Kartal'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue.shade900),
              title: Text('E-posta'),
              subtitle: Text('muhammed@example.com'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.book, color: Colors.blue.shade900),
              title: Text('Toplam Okunan Kitap'),
              subtitle: Text('0'),
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.blue.shade900),
              title: Text('Beğenilen Kitaplar'),
              subtitle: Text('0'),
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                // Oturum kapatma işlemi
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout),
              label: Text('Oturumu Kapat'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
