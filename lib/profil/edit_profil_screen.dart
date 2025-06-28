import 'package:flutter/material.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_bloc.dart';
import 'package:sewoapp/data_pelanggan/bloc/data_pelanggan_ubah_bloc.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan.dart';
import 'package:sewoapp/data_pelanggan/data/data_pelanggan_apidata.dart';

class EditProfilScreen extends StatefulWidget {
  static const routeName = "edit_profil";

  const EditProfilScreen({super.key});

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  DataPelangganBloc bloc = DataPelangganBloc();
  DataPelangganUbahBloc ubahBloc = DataPelangganUbahBloc();
  DataPelanggan form = DataPelanggan();
  DataPelangganApiData? profileData;
  bool isLoading = false;
  bool isSaving = false;
  
  var namaController = TextEditingController();
  var emailController = TextEditingController();
  var noTeleponController = TextEditingController();
  var alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Setup listeners
    namaController.addListener(() {
      form.nama = namaController.text;
    });

    emailController.addListener(() {
      form.email = emailController.text;
    });

    noTeleponController.addListener(() {
      form.noTelepon = noTeleponController.text;
    });

    alamatController.addListener(() {
      form.alamat = alamatController.text;
    });

    // Listen to bloc events
    bloc.stream.listen((event) {
      if (event is DataPelangganLoadSuccess) {
        setState(() {
          isLoading = false;
        });
        setForm(event.data.result.isNotEmpty ? event.data.result.first : null);
      } else if (event is DataPelangganLoading) {
        setState(() {
          isLoading = true;
        });
      }
    });

    // Listen to ubah bloc events
    ubahBloc.stream.listen((event) {
      setState(() {
        isSaving = false;
      });
      
      if (event is DataPelangganUbahLoadSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil berhasil disimpan'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate back to profile screen after successful save
        Navigator.pop(context);
      } else if (event is DataPelangganUbahLoadFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(event.pesan),
            backgroundColor: Colors.red,
          ),
        );
      } else if (event is DataPelangganUbahLoading) {
        setState(() {
          isSaving = true;
        });
      }
    });

    getData();
  }

  void setForm(DataPelangganApiData? data) {
    if (data == null) return;
    
    setState(() {
      profileData = data;
      namaController.text = data.nama ?? "";
      emailController.text = data.email ?? "";
      noTeleponController.text = data.noTelepon ?? "";
      alamatController.text = data.alamat ?? "";
    });
  }

  void getData() async {
    var data = await ConfigSessionManager.getInstance().getData();
    if (data != null) {
      bloc.add(
        FetchDataPelanggan(DataFilter(berdasarkan: "id_pelanggan", isi: data.id ?? "***")),
      );
    }
  }

  void saveProfile() async {
    // Validate form
    if (namaController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email tidak boleh kosong'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get session data for ID
    var sessionData = await ConfigSessionManager.getInstance().getData();
    if (sessionData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Session tidak valid, silakan login ulang'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create DataPelanggan object with updated data
    DataPelanggan updatedData = DataPelanggan(
      idPelanggan: sessionData.id,
      nama: namaController.text.trim(),
      email: emailController.text.trim(),
      noTelepon: noTeleponController.text.trim(),
      alamat: alamatController.text.trim(),
      username: profileData?.username,
      password: profileData?.password,
    );

    // Trigger save
    ubahBloc.add(FetchDataPelangganUbah(updatedData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Edit Profil"),
        backgroundColor: Style.buttonBackgroundColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: isSaving ? null : saveProfile,
            child: isSaving 
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'SIMPAN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Profile Picture Section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Style.buttonBackgroundColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Style.buttonBackgroundColor,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Style.buttonBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // TODO: Implement change photo functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Change photo functionality coming soon'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Form Fields
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namaController,
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            labelStyle: TextStyle(
                              color: Style.buttonBackgroundColor,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Style.buttonBackgroundColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor.withOpacity(0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor,
                                width: 2,
                              ),
                            ),
                          ),
                          cursorColor: Style.buttonBackgroundColor,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Style.buttonBackgroundColor,
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Style.buttonBackgroundColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor.withOpacity(0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor,
                                width: 2,
                              ),
                            ),
                          ),
                          cursorColor: Style.buttonBackgroundColor,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: noTeleponController,
                          decoration: InputDecoration(
                            labelText: 'No. Telepon',
                            labelStyle: TextStyle(
                              color: Style.buttonBackgroundColor,
                            ),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Style.buttonBackgroundColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor.withOpacity(0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor,
                                width: 2,
                              ),
                            ),
                          ),
                          cursorColor: Style.buttonBackgroundColor,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: alamatController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Alamat',
                            labelStyle: TextStyle(
                              color: Style.buttonBackgroundColor,
                            ),
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Style.buttonBackgroundColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor.withOpacity(0.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Style.buttonBackgroundColor,
                                width: 2,
                              ),
                            ),
                          ),
                          cursorColor: Style.buttonBackgroundColor,
                        ),
                        const SizedBox(height: 30),
                        // Additional Info Button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Navigate to detailed edit screen
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Detailed edit functionality coming soon'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit Informasi Lengkap'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Style.buttonBackgroundColor,
                              side: BorderSide(color: Style.buttonBackgroundColor),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Loading Overlay
          if (isLoading || isSaving)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        isSaving ? 'Menyimpan...' : 'Memuat...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
    alamatController.dispose();
    bloc.close();
    ubahBloc.close();
    super.dispose();
  }
}
