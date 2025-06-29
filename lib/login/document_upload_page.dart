import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadPage extends StatefulWidget {
  static const String routeName = '/document-upload';

  const DocumentUploadPage({Key? key}) : super(key: key);

  @override
  State<DocumentUploadPage> createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  final ImagePicker _picker = ImagePicker();
  bool policyAccepted = false;

  // Simpan file per dokumen
  Map<String, File?> uploadedFiles = {
    "ID Card": null,
    "Face Capture": null,
    "Driving License": null,
    "Spouse/Parents ID": null,
    "Family Card": null,
    "NPWP": null,
    "Company ID": null,
  };

  Future<void> _takePhoto(String key) async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        uploadedFiles[key] = File(picked.path);
      });
    }
  }

  Future<void> _uploadDocument(String key) async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.single.path != null) {
      setState(() {
        uploadedFiles[key] = File(result.files.single.path!);
      });
    }
  }

  Widget _buildUploadRow(String title, {bool required = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title${required ? "*" : ""}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _takePhoto(title),
                icon: const Icon(Icons.camera_alt),
                label: const Text("Take Photo"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF11316C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _uploadDocument(title),
                icon: const Icon(Icons.upload_file),
                label: const Text("Upload"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (uploadedFiles[title] != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              "✔ Uploaded: ${uploadedFiles[title]!.path.split('/').last}",
              style: const TextStyle(color: Colors.green),
            ),
          ),
        const SizedBox(height: 16),
      ],
    );
  }

  bool _allRequiredUploaded() {
    return uploadedFiles["ID Card"] != null &&
        uploadedFiles["Face Capture"] != null &&
        uploadedFiles["Driving License"] != null &&
        uploadedFiles["Company ID"] != null &&
        policyAccepted;
  }

  void _submitForm() {
    if (_allRequiredUploaded()) {
      Navigator.pushNamed(context, '/register-success');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all required fields.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11316C),
      appBar: AppBar(
        title: const Text(
          'Upload Requirements Documents',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 8,
              color: Colors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
            _buildUploadRow("ID Card", required: true),
            _buildUploadRow("Face Capture", required: true),
            _buildUploadRow("Driving License", required: true),
            _buildUploadRow("Spouse/Parents ID"),
            _buildUploadRow("Family Card"),
            _buildUploadRow("NPWP"),
            _buildUploadRow("Company ID", required: true),

            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),

            // Terms and Privacy Policy
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("1. Definition", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Sewaapp: A digital platform that brings together vehicle renters with trusted vehicle provider partners."),
                  Text("Guest: Sewaapp app user who rents a vehicle."),
                  Text("Host: Vehicle rental service provider partners who have been registered and verified on Sewaapp."),
                  SizedBox(height: 8),
                  Text("2. General Terms", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("By registering and using Sewaapp, users agree to all applicable Terms and Conditions."),
                  SizedBox(height: 8),
                  Text("3. User Account", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Users are responsible for providing accurate and up-to-date information."),
                ],
              ),
            ),

            Row(
              children: [
                Checkbox(
                  value: policyAccepted,
                  onChanged: (val) => setState(() => policyAccepted = val ?? false),
                ),
                const Expanded(
                  child: Text("I confirm that I have read, consent, and agree to the terms and privacy policy."),
                )
              ],
            ),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF11316C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text(
                  "REGISTER", 
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}