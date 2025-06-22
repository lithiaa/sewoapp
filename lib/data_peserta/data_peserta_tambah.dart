import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/enum/enum_widget.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/data_peserta/bloc/data_peserta_bloc.dart';
import 'package:sewoapp/data_peserta/data/data_peserta.dart';

class DataPesertaTambahScreen extends StatefulWidget {
  static const routeName = "data_peserta/tambah";
  const DataPesertaTambahScreen({super.key});

  @override
  State<DataPesertaTambahScreen> createState() => _DataPesertaTambahScreenState();
}

class _DataPesertaTambahScreenState extends State<DataPesertaTambahScreen> {
  EnumRemote enumRemote = EnumRemote();

  DataPeserta form = DataPeserta();
    
  var idPesertaController = TextEditingController();
var namaController = TextEditingController();
var nipController = TextEditingController();
var nikController = TextEditingController();
var tempatLahirController = TextEditingController();
var tanggalLahirController = TextEditingController();
var agamaController = TextEditingController();
var jenisKelaminController = TextEditingController();
var statusPerkawinanController = TextEditingController();
var idPangkatGolonganController = TextEditingController();
var idJabatanController = TextEditingController();
var namaJabatanController = TextEditingController();
var idUnitKerjaController = TextEditingController();
var idUnitController = TextEditingController();
var alamatUnitKerjaController = TextEditingController();
var idPendidikanController = TextEditingController();
var alamatRumahController = TextEditingController();
var noTeleponController = TextEditingController();
var pekerjaanController = TextEditingController();
var kelompokOrganisasiController = TextEditingController();
var idJabatanDalamKelompokController = TextEditingController();
var idDesaKelurahanController = TextEditingController();
var idKecamatanController = TextEditingController();
var idKabupatenController = TextEditingController();
var idProvinsiController = TextEditingController();
var telpFaxController = TextEditingController();
var emailController = TextEditingController();
var pengalamanPelatihanController = TextEditingController();
var keteranganController = TextEditingController();
var statusController = TextEditingController();
var usernameController = TextEditingController();
var passwordController = TextEditingController();
List<String> agama = [];
 
        fetchAgama() async {
            var data = await enumRemote.getData('data_peserta', 'agama');
            agama = data.result;
        }
        
List<String> jenisKelamin = [];
 
        fetchJenisKelamin() async {
            var data = await enumRemote.getData('data_peserta', 'jenis_kelamin');
            jenisKelamin = data.result;
        }
        
List<String> statusPerkawinan = [];
 
        fetchStatusPerkawinan() async {
            var data = await enumRemote.getData('data_peserta', 'status_perkawinan');
            statusPerkawinan = data.result;
        }
        
List<String> status = [];
 
        fetchStatus() async {
            var data = await enumRemote.getData('data_peserta', 'status');
            status = data.result;
        }
        


  @override
  void initState() {
    super.initState();

    idPesertaController.addListener(() {
        form.idPeserta = idPesertaController.text;
        });
        
namaController.addListener(() {
        form.nama = namaController.text;
        });
        
nipController.addListener(() {
        form.nip = nipController.text;
        });
        
nikController.addListener(() {
        form.nik = nikController.text;
        });
        
tempatLahirController.addListener(() {
        form.tempatLahir = tempatLahirController.text;
        });
        
tanggalLahirController.addListener(() {
        form.tanggalLahir = tanggalLahirController.text;
        });
        
agamaController.addListener(() {
        form.agama = agamaController.text;
        });
        
jenisKelaminController.addListener(() {
        form.jenisKelamin = jenisKelaminController.text;
        });
        
statusPerkawinanController.addListener(() {
        form.statusPerkawinan = statusPerkawinanController.text;
        });
        
idPangkatGolonganController.addListener(() {
        form.idPangkatGolongan = idPangkatGolonganController.text;
        });
        
idJabatanController.addListener(() {
        form.idJabatan = idJabatanController.text;
        });
        
namaJabatanController.addListener(() {
        form.namaJabatan = namaJabatanController.text;
        });
        
idUnitKerjaController.addListener(() {
        form.idUnitKerja = idUnitKerjaController.text;
        });
        
idUnitController.addListener(() {
        form.idUnit = idUnitController.text;
        });
        
alamatUnitKerjaController.addListener(() {
        form.alamatUnitKerja = alamatUnitKerjaController.text;
        });
        
idPendidikanController.addListener(() {
        form.idPendidikan = idPendidikanController.text;
        });
        
alamatRumahController.addListener(() {
        form.alamatRumah = alamatRumahController.text;
        });
        
noTeleponController.addListener(() {
        form.noTelepon = noTeleponController.text;
        });
        
pekerjaanController.addListener(() {
        form.pekerjaan = pekerjaanController.text;
        });
        
kelompokOrganisasiController.addListener(() {
        form.kelompokOrganisasi = kelompokOrganisasiController.text;
        });
        
idJabatanDalamKelompokController.addListener(() {
        form.idJabatanDalamKelompok = idJabatanDalamKelompokController.text;
        });
        
idDesaKelurahanController.addListener(() {
        form.idDesaKelurahan = idDesaKelurahanController.text;
        });
        
idKecamatanController.addListener(() {
        form.idKecamatan = idKecamatanController.text;
        });
        
idKabupatenController.addListener(() {
        form.idKabupaten = idKabupatenController.text;
        });
        
idProvinsiController.addListener(() {
        form.idProvinsi = idProvinsiController.text;
        });
        
telpFaxController.addListener(() {
        form.telpFax = telpFaxController.text;
        });
        
emailController.addListener(() {
        form.email = emailController.text;
        });
        
pengalamanPelatihanController.addListener(() {
        form.pengalamanPelatihan = pengalamanPelatihanController.text;
        });
        
keteranganController.addListener(() {
        form.keterangan = keteranganController.text;
        });
        
statusController.addListener(() {
        form.status = statusController.text;
        });
        
usernameController.addListener(() {
        form.username = usernameController.text;
        });
        
passwordController.addListener(() {
        form.password = passwordController.text;
        });
        
fetchAgama();
fetchJenisKelamin();
fetchStatusPerkawinan();
fetchStatus();


  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<DataPesertaBloc>(context),
      listener: ((context, state) {
        //if (state is DataPesertaSuccess) {
          // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          //BlocProvider.of<LoginFormBloc>(context).add(ShowLogin());
          //const snackBar = SnackBar(
            //content: Text('Registrasi berhasil, silahkan login!'),
          //);
          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //}
      }),
      child: BlocBuilder<DataPesertaBloc, DataPesertaState>(
        builder: (context, state) {
          return SingleChildScrollView(
              child: Form(
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      children: [
                        // const LoginDataPesertaScreen(),
                        const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Selamat datang',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Silahkan lengkapi form pendaftaran',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 15),
                        
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Peserta',
                      ),
                      controller: idPesertaController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nama',
                      ),
                      controller: namaController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nip',
                      ),
                      controller: nipController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nik',
                      ),
                      controller: nikController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Tempat Lahir',
                      ),
                      controller: tempatLahirController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      controller: tanggalLahirController,
                      readOnly: true,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1990, 1),
                          lastDate: DateTime(2025, 12),
                        ).then((pickedDate) {
                          if (pickedDate != null) {
                            tanggalLahirController.text =
                                DateFormat('y-M-d').format(pickedDate);
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Tanggal Lahir',
                      ),
                    ),
                    const SizedBox(height: 15),
        
TextFormField(
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Pilih Agama'),
                  content: EnumWidget(
                    items: agama,
                    onChange: (String value) {
                      agamaController.text = value;
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          },
          controller: agamaController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            border: OutlineInputBorder(),
            labelText: 'Agama',
          ),
        ),
        const SizedBox(height: 15),

TextFormField(
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Pilih Jenis Kelamin'),
                  content: EnumWidget(
                    items: jenisKelamin,
                    onChange: (String value) {
                      jenisKelaminController.text = value;
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          },
          controller: jenisKelaminController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            border: OutlineInputBorder(),
            labelText: 'Jenis Kelamin',
          ),
        ),
        const SizedBox(height: 15),

TextFormField(
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Pilih Status Perkawinan'),
                  content: EnumWidget(
                    items: statusPerkawinan,
                    onChange: (String value) {
                      statusPerkawinanController.text = value;
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          },
          controller: statusPerkawinanController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            border: OutlineInputBorder(),
            labelText: 'Status Perkawinan',
          ),
        ),
        const SizedBox(height: 15),


                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Pangkat Golongan',
                      ),
                      controller: idPangkatGolonganController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Jabatan',
                      ),
                      controller: idJabatanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Nama Jabatan',
                      ),
                      controller: namaJabatanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Unit Kerja',
                      ),
                      controller: idUnitKerjaController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Unit',
                      ),
                      controller: idUnitController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Alamat Unit Kerja',
                      ),
                      controller: alamatUnitKerjaController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Pendidikan',
                      ),
                      controller: idPendidikanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Alamat Rumah',
                      ),
                      controller: alamatRumahController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'No Telepon',
                      ),
                      controller: noTeleponController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Pekerjaan',
                      ),
                      controller: pekerjaanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Kelompok Organisasi',
                      ),
                      controller: kelompokOrganisasiController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Jabatan Dalam Kelompok',
                      ),
                      controller: idJabatanDalamKelompokController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Desa Kelurahan',
                      ),
                      controller: idDesaKelurahanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Kecamatan',
                      ),
                      controller: idKecamatanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Kabupaten',
                      ),
                      controller: idKabupatenController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Id Provinsi',
                      ),
                      controller: idProvinsiController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Telp Fax',
                      ),
                      controller: telpFaxController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      controller: emailController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Pengalaman Pelatihan',
                      ),
                      controller: pengalamanPelatihanController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Keterangan',
                      ),
                      controller: keteranganController,
                    ),
                    const SizedBox(height: 15),
        
TextFormField(
          readOnly: true,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Pilih Status'),
                  content: EnumWidget(
                    items: status,
                    onChange: (String value) {
                      statusController.text = value;
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            );
          },
          controller: statusController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.book),
            suffixIcon: Icon(Icons.keyboard_arrow_down),
            border: OutlineInputBorder(),
            labelText: 'Status',
          ),
        ),
        const SizedBox(height: 15),


                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      controller: usernameController,
                    ),
                    const SizedBox(height: 15),
        

                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.book),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      controller: passwordController,
                    ),
                    const SizedBox(height: 15),
        

                      ],
                    ),
                  ),
                ),
              ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    idPesertaController.dispose();
namaController.dispose();
nipController.dispose();
nikController.dispose();
tempatLahirController.dispose();
tanggalLahirController.dispose();
agamaController.dispose();
jenisKelaminController.dispose();
statusPerkawinanController.dispose();
idPangkatGolonganController.dispose();
idJabatanController.dispose();
namaJabatanController.dispose();
idUnitKerjaController.dispose();
idUnitController.dispose();
alamatUnitKerjaController.dispose();
idPendidikanController.dispose();
alamatRumahController.dispose();
noTeleponController.dispose();
pekerjaanController.dispose();
kelompokOrganisasiController.dispose();
idJabatanDalamKelompokController.dispose();
idDesaKelurahanController.dispose();
idKecamatanController.dispose();
idKabupatenController.dispose();
idProvinsiController.dispose();
telpFaxController.dispose();
emailController.dispose();
pengalamanPelatihanController.dispose();
keteranganController.dispose();
statusController.dispose();
usernameController.dispose();
passwordController.dispose();

    super.dispose();
  }

}
