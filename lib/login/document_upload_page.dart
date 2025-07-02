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

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Privacy Policy and Terms of Use"),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("By registering an account and using our vehicle rental services, you agree to the collection and processing of your personal data as described below."),
                  SizedBox(height: 12),
                  Text("1. Collection of Personal Data", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("In order to provide and secure our services, we collect essential personal information, including but not limited to: Identity Card (KTP), Family Card (KK), Spouse's ID, Driver's License (SIM), Vehicle Registration Document (BPKB), Tax Identification Number (NPWP), and other relevant personal data."),
                  SizedBox(height: 8),
                  Text("2. Purpose of Data Use", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("The personal data collected will be used solely for the following purposes:"),
                  SizedBox(height: 4),
                  Text("• Verification of identity and completeness of documentation during the rental process."),
                  Text("• Ensuring the security and integrity of transactions and vehicle usage."),
                  Text("• Addressing urgent or emergency situations where access to personal data is necessary to protect the safety of all parties involved."),
                  SizedBox(height: 8),
                  Text("3. Data Protection and Confidentiality", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("We are committed to safeguarding your personal data by implementing appropriate technical and organizational measures to prevent unauthorized access, disclosure, alteration, or destruction of your information. Access to personal data is strictly limited to authorized personnel who require it for legitimate business purposes."),
                  SizedBox(height: 8),
                  Text("4. Data Sharing and Disclosure", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Your personal data will not be disclosed to any third party except under the following conditions:"),
                  SizedBox(height: 4),
                  Text("• When required by law or governmental authorities."),
                  Text("• In urgent circumstances related to security or safety concerns."),
                  SizedBox(height: 8),
                  Text("5. Consent and Rights", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("By proceeding with registration, you provide explicit consent for the collection and use of your personal data as outlined herein. You retain the right to access, correct, or request deletion of your personal data in accordance with applicable data protection laws."),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  policyAccepted = false;
                });
              },
              child: const Text("Decline"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  policyAccepted = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF11316C),
                foregroundColor: Colors.white,
              ),
              child: const Text("Accept"),
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
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: policyAccepted,
                  onChanged: (val) {
                    if (val == true) {
                      _showTermsDialog();
                    } else {
                      setState(() => policyAccepted = false);
                    }
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showTermsDialog(),
                    child: const Text(
                      "I confirm that I have read, consent, and agree to the terms and privacy policy.",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color(0xFF11316C),
                      ),
                    ),
                  ),
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