import 'package:flutter/material.dart';
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
          content: Text("Unable to fetch data, please check your internet connection"),
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
                  'A trusted vehicle rental application that provides various vehicle options for your transportation needs.',
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
      backgroundColor: const Color(0xFF11316C),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF11316C),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
          : SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  getData();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Content
                        Card(
                          elevation: 8,
                          color: Colors.white.withOpacity(0.95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Profile Picture
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF11316C).withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 40,
                                    color: const Color(0xFF11316C),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Profile Information
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Name
                                      Text(
                                        profileData?.nama ?? '-',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Email
                                      Text(
                                        profileData?.email ?? '-',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // Phone
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            size: 16,
                                            color: Colors.grey[600],
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            profileData?.noTelepon ?? '-',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (profileData?.alamat != null && profileData!.alamat!.isNotEmpty) ...[
                                        const SizedBox(height: 8),
                                        // Address
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                profileData?.alamat ?? '-',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Action Buttons
                        Card(
                          elevation: 4,
                          color: Colors.white.withOpacity(0.95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.edit,
                                  color: const Color(0xFF11316C),
                                ),
                                title: const Text('Edit Profile'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: _navigateToEditProfile,
                              ),
                              const Divider(height: 1),
                              ListTile(
                                leading: Icon(
                                  Icons.info,
                                  color: const Color(0xFF11316C),
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
                                        title: const Text('Logout Confirmation'),
                                        content: const Text(
                                          'Are you sure you want to logout from the application?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            child: const Text('Cancel'),
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
                        const SizedBox(height: 20),
                        // Loading Overlay
                        StreamBuilder(
                          stream: bloc.stream,
                          builder: (context, snapshot) {
                            if (snapshot.data is DataPelangganLoading) {
                              return Container(
                                padding: const EdgeInsets.all(40),
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      strokeWidth: 3,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Loading profile...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
