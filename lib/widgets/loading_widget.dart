import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class NoInternetWidget extends StatefulWidget {
  String pesan;
  NoInternetWidget({super.key, this.pesan = ""});

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height * 0.7,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/images/error.gif",
              width: width / 2,
            ),
            const SizedBox(height: 10),
            Text(
              widget.pesan,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 15),
            const Text(
              "Usah kebawah untuk mengambil data ulang.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// class NoInternetWidget extends StatelessWidget with TickerProviderStateMixin {
//   const NoInternetWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return SizedBox(
//       width: width,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset("assets/images/error.png"),
//           GifImage(
//             controller: FlutterGifController(
//               vsync: this,
//               duration: const Duration(milliseconds: 200),
//               reverseDuration: const Duration(milliseconds: 200),
//             ),
//             image: const AssetImage("images/animate.gif"),
//           ),
//           const Text("Device anda tidak terhubung dengan internet"),
//         ],
//       ),
//     );
//   }
// }

class NoDataWidget extends StatefulWidget {
  String? pesan;

  NoDataWidget({super.key, this.pesan});

  @override
  State<NoDataWidget> createState() => _NoDataWidgetState();
}

class _NoDataWidgetState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(9),
      height: height * 0.7,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/nodata.gif",
          ),
          Text(
            widget.pesan == null ? "Data masih kosong" : widget.pesan!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Usah kebawah untuk mengambil data ulang.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// class NoDataWidget extends StatelessWidget {
//   String? pesan;
//
//   NoDataWidget({Key? key, this.pesan}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset("assets/images/error.png"),
//         Text(
//           pesan == null ? "Data masih kosong" : pesan!,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//       ],
//     );
//   }
// }

class PreparingWidget extends StatelessWidget {
  const PreparingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [Text("Mempersiapkan content")],
      ),
    );
  }
}
