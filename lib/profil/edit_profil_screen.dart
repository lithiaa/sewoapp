import 'package:flutter/material.dart';
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
            content: Text('Profile saved successfully'),
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
          content: Text('Name cannot be empty'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email cannot be empty'),
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
          content: Text('Invalid session, please login again'),
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

  void _showPhotoOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Profile Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF11316C)),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF11316C)),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Remove Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _removePhoto();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _takePhoto() {
    // TODO: Implement camera functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Camera functionality will be implemented soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _pickFromGallery() {
    // TODO: Implement gallery picker functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery picker functionality will be implemented soon'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _removePhoto() {
    // TODO: Implement remove photo functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Remove photo functionality will be implemented soon'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11316C),
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
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
                  'SAVE',
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
          SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Photo Edit Section
                    Card(
                      elevation: 4,
                      color: Colors.white.withOpacity(0.95),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profile Photo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF11316C),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF11316C).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF11316C).withOpacity(0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      size: 60,
                                      color: const Color(0xFF11316C),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF11316C),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _showPhotoOptionsDialog();
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
                            const SizedBox(height: 16),
                            Center(
                              child: Text(
                                'Tap the camera icon to change your profile photo',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Edit Form Section
                    Card(
                      elevation: 4,
                      color: Colors.white.withOpacity(0.95),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF11316C),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: namaController,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                  color: const Color(0xFF11316C),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: const Color(0xFF11316C),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C).withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C),
                                    width: 2,
                                  ),
                                ),
                              ),
                              cursorColor: const Color(0xFF11316C),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: const Color(0xFF11316C),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: const Color(0xFF11316C),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C).withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C),
                                    width: 2,
                                  ),
                                ),
                              ),
                              cursorColor: const Color(0xFF11316C),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: noTeleponController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle: TextStyle(
                                  color: const Color(0xFF11316C),
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: const Color(0xFF11316C),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C).withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C),
                                    width: 2,
                                  ),
                                ),
                              ),
                              cursorColor: const Color(0xFF11316C),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: alamatController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                  color: const Color(0xFF11316C),
                                ),
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: const Color(0xFF11316C),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C).withOpacity(0.5),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color(0xFF11316C),
                                    width: 2,
                                  ),
                                ),
                              ),
                              cursorColor: const Color(0xFF11316C),
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
                                label: const Text('Edit Complete Information'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF11316C),
                                  side: BorderSide(color: const Color(0xFF11316C)),
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
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        isSaving ? 'Saving...' : 'Loading...',
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
