import 'package:flutter/material.dart';
import 'main.dart';
import 'profil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:convert';
import 'dart:io';

class IndirilenKitaplar extends StatefulWidget {
  const IndirilenKitaplar({super.key});

  @override
  State<IndirilenKitaplar> createState() => _IndirilenKitaplarState();
}

class _IndirilenKitaplarState extends State<IndirilenKitaplar> {
  List<Map<String, String>> indirilenKitaplar = [];

  @override
  void initState() {
    super.initState();
    _loadKitaplar();
  }

  // Kitapları yükle
  Future<void> _loadKitaplar() async {
    final prefs = await SharedPreferences.getInstance();
    final kitaplarJson = prefs.getString('indirilenKitaplar');
    if (kitaplarJson != null) {
      setState(() {
        indirilenKitaplar = List<Map<String, String>>.from(
            json.decode(kitaplarJson).map((x) => Map<String, String>.from(x)));
      });
    }
  }

  // Kitapları kaydet
  Future<void> _saveKitaplar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('indirilenKitaplar', json.encode(indirilenKitaplar));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.75,
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
                  Navigator.pop(context); // Drawer'ı kapat
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                    (route) => false,
                  );
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
        automaticallyImplyLeading:
            false, // Geri okunu otomatik olarak eklemeyi engeller
        title: Text(
          'İndirilen Kitaplar',
          style: TextStyle(color: Colors.blue.shade900),
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
      body: indirilenKitaplar.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book,
                    size: 64,
                    color: Colors.blue.shade200,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Henüz indirilen kitap yok',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Kitap eklemek için + butonuna tıklayın',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: indirilenKitaplar.length,
              itemBuilder: (context, index) {
                final kitap = indirilenKitaplar[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Icon(
                              Icons.book,
                              color: Colors.blue.shade900,
                              size: 30,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            left: 2,
                            child: Icon(
                              Icons.phone_android,
                              color: Colors.blue.shade900,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      kitap['name'] ?? 'Kitap Adı',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    subtitle: Text(kitap['author'] ?? 'Yazar Adı'),
                    onTap: () {
                      _openBook(kitap['path']!);
                    },
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Kitabı Sil'),
                          content: Text(
                              '${kitap['name']} kitabını silmek istediğinize emin misiniz?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('İptal'),
                            ),
                            TextButton(
                              onPressed: () async {
                                setState(() {
                                  indirilenKitaplar.removeAt(index);
                                });
                                await _saveKitaplar();
                                Navigator.pop(context);
                              },
                              child: Text('Sil',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // İzin kontrolü
          var status = await Permission.storage.status;

          if (status.isGranted) {
            // İzin zaten verilmiş, dosya seçiciyi aç
            _pickFile(context);
          } else {
            // İzin iste
            var result = await Permission.storage.request();

            if (result.isGranted) {
              // İzin verildi, dosya seçiciyi aç
              _pickFile(context);
            } else {
              // İzin reddedildi
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Dosya seçmek için izin gerekiyor'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        backgroundColor: Colors.blue.shade900,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'epub', 'mobi'],
      );

      if (result != null && result.files.isNotEmpty) {
        String fileName = result.files.single.name;
        String? filePath = result.files.single.path;

        if (filePath != null) {
          setState(() {
            indirilenKitaplar.add({
              'name': fileName,
              'author': 'Yerel Dosya',
              'path': filePath,
            });
          });
          await _saveKitaplar();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$fileName seçildi'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      print('Hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dosya seçilirken bir hata oluştu'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Kitap açma fonksiyonu
  void _openBook(String filePath) async {
    try {
      if (filePath.toLowerCase().endsWith('.pdf')) {
        final file = File(filePath);
        if (await file.exists()) {
          // Son okunan sayfayı yükle
          final prefs = await SharedPreferences.getInstance();
          final lastPage = prefs.getInt('last_page_$filePath') ?? 0;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('PDF Görüntüleyici'),
                  backgroundColor: Colors.blue.shade900,
                ),
                body: SfPdfViewer.file(
                  file,
                  controller: PdfViewerController()..jumpToPage(lastPage),
                  enableDoubleTapZooming: true,
                  enableTextSelection: true,
                  onPageChanged: (PdfPageChangedDetails details) async {
                    // Sayfa değiştiğinde kaydet
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setInt(
                        'last_page_$filePath', details.newPageNumber);
                  },
                ),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Dosya bulunamadı'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Diğer dosya formatları için varsayılan uygulamayı kullan
        final result = await OpenFile.open(filePath);
        if (result.type != ResultType.done) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kitap açılırken bir hata oluştu'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('Kitap açılırken hata: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kitap açılırken bir hata oluştu'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
