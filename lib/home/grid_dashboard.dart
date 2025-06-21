import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sewoapp/config/config_global.dart';
import "package:sewoapp/frame/frame_screen.dart";
import 'package:sewoapp/data_katalog/data_katalog_screen.dart';

class GridDashboard extends StatelessWidget {
  const GridDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Items item1 = Items(
      title: "Katalog",
      subtitle: "March, Wednesday",
      event: "3 Events",
      img: "assets/icon1.png",
      click: () {
        Navigator.of(context).pushNamed(DataKatalogScreen.routeName);
      },
    );

    Items item2 = Items(
        title: "Statistik",
        subtitle: "Bocali, Apple",
        event: "4 Items",
        img: "assets/icon2.png",
        click: () {
          Navigator.of(context).pushNamed(
            FrameScreen.routeName,
            arguments: '${ConfigGlobal.baseUrl}/frame/app/page/statistik.php',
          );
        });

    Items item3 = Items(
      title: "Widyaswara",
      subtitle: "Homework, Design",
      event: "4 Items",
      img: "assets/icon5.png",
      click: () {
        Navigator.of(context).pushNamed(
          FrameScreen.routeName,
          arguments: '${ConfigGlobal.baseUrl}/frame/app/page/widyaswara.php',
        );
      },
    );
    Items item4 = Items(
      title: "Kesan Peserta",
      subtitle: "",
      event: "2 Items",
      img: "assets/icon6.png",
      click: () {
        Navigator.of(context).pushNamed(
          FrameScreen.routeName,
          arguments: '${ConfigGlobal.baseUrl}/frame/app/page/kesan_peserta.php',
        );
      },
    );
    Items item5 = Items(
      title: "Ajukan Training",
      subtitle: "Lucy Mao going to Office",
      event: "",
      img: "assets/icon3.png",
      click: () {
        Navigator.of(context).pushNamed(
          FrameScreen.routeName,
          arguments:
              '${ConfigGlobal.baseUrl}/frame/app/page/ajukan_training.php',
        );
      },
    );
    Items item6 = Items(
      title: "Informasi Terbaru",
      subtitle: "Rose favirited your Post",
      event: "",
      img: "assets/icon4.png",
      click: () {
        Navigator.of(context).pushNamed(
          FrameScreen.routeName,
          arguments:
              '${ConfigGlobal.baseUrl}/frame/app/page/informasi_terbaru.php',
        );
      },
    );

    Items item7 = Items(
      title: "F.A.Q",
      subtitle: "",
      event: "2 Items",
      img: "assets/icon7.png",
      click: () {
        Navigator.of(context).pushNamed(
          FrameScreen.routeName,
          arguments: '${ConfigGlobal.baseUrl}/frame/app/page/faq.php',
        );
      },
    );

    Items item8 = Items(
      title: "Help Desk",
      subtitle: "",
      event: "2 Items",
      img: "assets/icon8.png",
      click: () {
        Navigator.of(context).pushNamed(
          FrameScreen.routeName,
          arguments: '${ConfigGlobal.baseUrl}/frame/app/page/help_desk.php',
        );
      },
    );

    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8
    ];
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.68,
      padding: const EdgeInsets.only(left: 16, right: 16),
      crossAxisCount: ConfigGlobal.jumlahDashboardGrid,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      children: myList.map((data) {
        return InkWell(
          onTap: data.click,
          child: Card(
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(data.img, width: double.infinity),
                ),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Null Function() click;

  Items({
    required this.title,
    required this.subtitle,
    required this.event,
    required this.img,
    required this.click,
  });
}
