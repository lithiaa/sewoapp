import 'package:flutter/material.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_bloc.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';
import 'package:sewoapp/home/custom_bottom_navbar.dart';
import 'package:sewoapp/login/data/login_apidata.dart';
import 'package:sewoapp/login/login_screen.dart';
import 'package:sewoapp/profil/edit_profil_screen.dart';

class ProfilScreen extends StatefulWidget {
  static const routeName = "profil";

  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  LoginApiData? data;
  DataPelangganBloc bloc = DataPelangganBloc();
  DataPelanggan form = DataPelanggan();
  DataPelangganApiData? profileData;

  // Simplified controllers for basic info
  var namaController = TextEditingController();
  var emailController = TextEditingController();
  var noTeleponController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Setup basic listeners for profile preview
    namaController.addListener(() {
      setState(() {
        form.nama = namaController.text;
      });
    });

    emailController.addListener(() {
      form.email = emailController.text;
    });

    noTeleponController.addListener(() {
      form.noTelepon = noTeleponController.text;
    });

    bloc.stream.listen((event) {
      if (event is DataPelangganLoadSuccess) {
        setForm(event.data.result.isNotEmpty ? event.data.result.first : null);
      }
      if (event is DataPelangganLoadFailure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Tidak dapat mengambil data, periksa sambungan internet anda"),
        ));
      }
    });

    getData();
  }

  void setForm(DataPelangganApiData? data) {
    if (data == null) return;
    
    setState(() {
      profileData = data;
      namaController.text = data.nama ?? "-";
      emailController.text = data.email ?? "-";
      noTeleponController.text = data.noTelepon ?? "-";
    });
  }

  void getData() async {
    var data = await ConfigSessionManager.getInstance().getData();
    if (data != null) {
      setState(() {
        this.data = data;
      });

      bloc.add(
        FetchDataPelanggan(DataFilter(berdasarkan: "id_pelanggan", isi: this.data?.id ?? "***")),
      );
      return;
    }
    await ConfigSessionManager.getInstance().setSudahLogin(false);
    if (mounted) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  void _navigateToEditProfile() {
    Navigator.pushNamed(context, EditProfilScreen.routeName);
  }

  void _showAboutUs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About Us'),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SewoApp',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Aplikasi rental kendaraan terpercaya yang menyediakan berbagai pilihan kendaraan untuk kebutuhan transportasi Anda.',
                ),
                SizedBox(height: 10),
                Text(
                  'Version: 1.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Style.buttonBackgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: 4, // Profile tab index
        onTap: (index) {
          if (index != 4) { // Only navigate if not already on profile
            BottomNavHandler.handleNavigation(context, index);
          }
        },
      ),
      body: data == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Style.buttonBackgroundColor,
                        Style.buttonBackgroundColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Profile Card
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              // Profile Picture
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Style.buttonBackgroundColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Style.buttonBackgroundColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Name
                              Text(
                                profileData?.nama ?? '-',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              // Email
                              Text(
                                profileData?.email ?? '-',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              // Phone
                              Text(
                                profileData?.noTelepon ?? '-',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (profileData?.alamat != null && profileData!.alamat!.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                // Address
                                Text(
                                  profileData?.alamat ?? '-',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Action Buttons
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.edit,
                                color: Style.buttonBackgroundColor,
                              ),
                              title: const Text('Edit Profil'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: _navigateToEditProfile,
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: Icon(
                                Icons.info,
                                color: Style.buttonBackgroundColor,
                              ),
                              title: const Text('About Us'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: _showAboutUs,
                            ),
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.red,
                              ),
                              title: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.red),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Konfirmasi Logout'),
                                      content: const Text(
                                        'Apakah Anda yakin ingin keluar dari aplikasi?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            await ConfigSessionManager.getInstance().logout();
                                            if (mounted) {
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                LoginScreen.routeName,
                                                (Route<dynamic> route) => false,
                                              );
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text('Logout'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Loading Overlay
                StreamBuilder(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data is DataPelangganLoading) {
                      return Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noTeleponController.dispose();
    bloc.close();
    super.dispose();
  }
}
