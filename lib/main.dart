import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_kullanimi1/controller.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(
    SimpleBuilder(
      builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: TemaYonetimi().theme,
          home: Home(),
        );
      },
    ),
  );
}

class TemaYonetimi extends GetxController {
  final box = GetStorage();
  bool get isLight => box.read('lightmode') ?? false;
  ThemeData get theme => isLight ? ThemeData.light() : ThemeData.dark();
  void changeTheme(bool val) => box.write('lightmode', val);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final kontrol = Get.put(Kontrol());

  @override
  void initState() {
    print("Ana Sayfa");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Kullanımı"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'Tıklanma: ${kontrol.sayi}',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Diğer Sayfa'),
              onPressed: () {
                Get.to(() => Second());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          kontrol.arttir();
        },
      ),
    );
  }
}

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final Kontrol kontrol = Get.find();
  final temaYonetimi = Get.put(TemaYonetimi());
  bool _darkThemeEnabled = false;
  GlobalKey<NavigatorState>? dialogKey = GlobalKey();

  @override
  void initState() {
    print("İkinci Sayfa");
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diğer Sayfa"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${kontrol.sayi}",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            /*ElevatedButton(
              onPressed: () {
                if (_darkThemeEnabled) {
                  Get.changeTheme(
                    ThemeData(
                      primaryColor: Colors.blue,
                      buttonColor: Colors.blue,
                      accentColor: Colors.blue,
                    ),
                  );
                  _darkThemeEnabled = false;
                } else {
                  Get.changeTheme(
                    ThemeData(
                      primaryColor: Colors.grey[900],
                      buttonColor: Colors.grey[900],
                      accentColor: Colors.grey[900],
                    ), /*ThemeData.dark()*/
                  );
                  _darkThemeEnabled = true;
                }
              },
              child: Text(
                'Tema Değiştir',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),*/
            ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  "Örnek Başlık",
                  "Örnek Mesaj",
                  showProgressIndicator: true,
                  colorText: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  mainButton: TextButton(
                    onPressed: () {
                      print("Tamam'a bastın");
                      Get.back();
                    },
                    child: Text(
                      "Tamam",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                'Basit Snackbar',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Örnek Dialog",
                  onConfirm: () {
                    print("Onayladın");
                    Get.back();
                  },
                  onCancel: () {
                    print("Reddettin");
                  },
                  textConfirm: "Tamam",
                  textCancel: "Hayır",
                  confirmTextColor: Colors.white,
                );
              },
              child: Text(
                'Basit Dialog',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                temaYonetimi.changeTheme(!temaYonetimi.isLight);
                setState(() {});
              },
              child: Text(
                'Shared Preferences',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
            SwitchListTile(
              value: temaYonetimi.isLight,
              title: temaYonetimi.isLight
                  ? Text("Kapalı Tema")
                  : Text("Açık Tema"),
              onChanged: (val) {
                temaYonetimi.changeTheme(val);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
