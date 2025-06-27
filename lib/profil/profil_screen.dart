import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sewoapp/config/color.dart';
import 'package:sewoapp/config/config_session_manager.dart';
import 'package:sewoapp/data/data_filter.dart';
import 'package:sewoapp/data_peserta/bloc/data_peserta_bloc.dart';
import 'package:sewoapp/data_peserta/data/data_peserta.dart';
import 'package:sewoapp/data_peserta/data/data_peserta_apidata.dart';
import 'package:sewoapp/enum/enum_widget.dart';
import 'package:sewoapp/enum/repo/enum_remote.dart';
import 'package:sewoapp/login/data/login_apidata.dart';
import 'package:sewoapp/login/login_screen.dart';

class ProfilScreen extends StatefulWidget {
  static const routeName = "profil";

  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  LoginApiData? data;
  EnumRemote enumRemote = EnumRemote();

  DataPesertaBloc bloc = DataPesertaBloc();

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
  var pangkatGolonganController = TextEditingController();
  var idJabatanController = TextEditingController();
  var jabatanController = TextEditingController();
  var namaJabatanController = TextEditingController();
  var idUnitKerjaController = TextEditingController();
  var unitKerjaController = TextEditingController();
  var idUnitController = TextEditingController();
  var unitController = TextEditingController();
  var alamatUnitKerjaController = TextEditingController();
  var idPendidikanController = TextEditingController();
  var pendidikanController = TextEditingController();
  var alamatRumahController = TextEditingController();
  var noTeleponController = TextEditingController();
  var pekerjaanController = TextEditingController();
  var kelompokOrganisasiController = TextEditingController();
  var idJabatanDalamKelompokController = TextEditingController();
  var jabatanDalamKelompokController = TextEditingController();
  var idDesaKelurahanController = TextEditingController();
  var desaKelurahanController = TextEditingController();
  var idKecamatanController = TextEditingController();
  var kecamatanController = TextEditingController();
  var idKabupatenController = TextEditingController();
  var kabupatenController = TextEditingController();
  var idProvinsiController = TextEditingController();
  var provinsiController = TextEditingController();
  var telpFaxController = TextEditingController();
  var emailController = TextEditingController();
  var pengalamanPelatihanController = TextEditingController();
  var keteranganController = TextEditingController();
  var statusController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  List<String> agama = [];

  Future<void> fetchAgama() async {
    var data = await enumRemote.getData('data_peserta', 'agama');
    agama = data.result;
  }

  List<String> jenisKelamin = [];

  Future<void> fetchJenisKelamin() async {
    var data = await enumRemote.getData('data_peserta', 'jenis_kelamin');
    jenisKelamin = data.result;
  }

  List<String> statusPerkawinan = [];

  Future<void> fetchStatusPerkawinan() async {
    var data = await enumRemote.getData('data_peserta', 'status_perkawinan');
    statusPerkawinan = data.result;
  }

  List<String> status = [];

  Future<void> fetchStatus() async {
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
      setState(() {
        form.nama = namaController.text;
      });
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

    // pangkatGolonganController.addListener(() {
    //   pangkatGolonganController.text;
    // });

    idJabatanController.addListener(() {
      form.idJabatan = idJabatanController.text;
    });

    // jabatanController.addListener(() {
    //   form.idJabatan = jabatanController.text;
    // });

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
      idDesaKelurahanController.text = "";
      desaKelurahanController.text = "";
    });

    idKabupatenController.addListener(() {
      form.idKabupaten = idKabupatenController.text;
      idKecamatanController.text = "";
      kecamatanController.text = "";
    });

    idProvinsiController.addListener(() {
      form.idProvinsi = idProvinsiController.text;
      idKabupatenController.text = "";
      kabupatenController.text = "";
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

    bloc.stream.listen((event) {
      if (event is DataPesertaLoadSuccess) {
        setForm(event.data);
      }
    });

    fetchAgama();
    fetchJenisKelamin();
    fetchStatusPerkawinan();
    fetchStatus();

    getData();
  }

  void setForm(DataPesertaApiData? data) {
    if (data == null) {
      return;
    }
    namaController.text = data.nama ?? "-";
    nipController.text = data.nip ?? "-";
    nikController.text = data.nik ?? "-";
    tempatLahirController.text = data.tempatLahir ?? "-";
    tanggalLahirController.text = data.tanggalLahir ?? "-";
    agamaController.text = data.agama ?? "-";
    jenisKelaminController.text = data.jenisKelamin ?? "-";
    statusPerkawinanController.text = data.statusPerkawinan ?? "-";

    idPangkatGolonganController.text = data.idPangkatGolongan ?? "-";
    pangkatGolonganController.text = data.pangkatGolongan ?? "-";

    idJabatanController.text = data.idJabatan ?? "-";
    jabatanController.text = data.jabatan ?? "-";

    namaJabatanController.text = data.namaJabatan ?? "-";

    idUnitKerjaController.text = data.idUnitKerja ?? "-";
    unitKerjaController.text = data.unitKerja ?? "-";

    idUnitController.text = data.idUnit ?? "-";
    unitController.text = data.unit ?? "-";

    alamatUnitKerjaController.text = data.alamatUnitKerja ?? "-";
    idPendidikanController.text = data.idPendidikan ?? "-";
    pendidikanController.text = data.pendidikan ?? "-";

    alamatRumahController.text = data.alamatRumah ?? "-";
    noTeleponController.text = data.noTelepon ?? "-";
    pekerjaanController.text = data.pekerjaan ?? "-";
    kelompokOrganisasiController.text = data.kelompokOrganisasi ?? "-";

    idJabatanDalamKelompokController.text = data.idJabatanDalamKelompok ?? "-";
    jabatanDalamKelompokController.text = data.jabatanDalamKelompok ?? "-";

    idProvinsiController.text = data.idProvinsi ?? "-";
    provinsiController.text = data.provinsi ?? "-";

    idKabupatenController.text = data.idKabupaten ?? "-";
    kabupatenController.text = data.kabupaten ?? "-";

    idKecamatanController.text = data.idKecamatan ?? "-";
    kecamatanController.text = data.kecamatan ?? "-";

    idDesaKelurahanController.text = data.idDesaKelurahan ?? "-";
    desaKelurahanController.text = data.desaKelurahan ?? "-";

    telpFaxController.text = data.telpFax ?? "-";
    emailController.text = data.email ?? "-";
    pengalamanPelatihanController.text = data.pengalamanPelatihan ?? "-";
    keteranganController.text = data.keterangan ?? "-";
    statusController.text = data.status ?? "-";
    usernameController.text = data.username ?? "-";
  }

  void getData() async {
    var data = await ConfigSessionManager.getInstance().getData();
    if (data != null) {
      setState(() {
        this.data = data;
        idPesertaController.text = this.data?.id ?? "-";
      });

      bloc.stream.listen((event) {
        if (event is DataPesertaSimpanSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Style.buttonBackgroundColor,
            content: Text('Berhasil disimpan!'),
          ));
          setForm(event.data.result);
        }
        if (event is DataPesertaLoadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                "Tidak dapat mengambil data, periksa sambungan internet anda"),
          ));
          Navigator.of(context).pop();
        }
      });

      bloc.add(
        FetchDataPeserta(DataFilter(idPeserta: this.data?.id ?? "***")),
      );

      return;
    }
    await ConfigSessionManager.getInstance().setSudahLogin(false);
    if (mounted) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        actions: [
          IconButton(
              onPressed: () {
                bloc.add(SimpanDataPeserta(data: form));
              },
              icon: const Icon(Icons.save)),
          IconButton(
              onPressed: () async {
                await ConfigSessionManager.getInstance().logout();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(context,
                      LoginScreen.routeName, (Route<dynamic> route) => false);
                }
              },
              icon: const Icon(Icons.power_settings_new)),
        ],
      ),
      body: data == null
          ? Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.all(3),
              child: const Center(child: CircularProgressIndicator()),
            )
          : Stack(children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Image.asset(
                          'assets/background_login.png',
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Image.asset("assets/logo.png", height: 80),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                  form.nama ?? '-',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // TextFormField(
                              //   decoration: const InputDecoration(
                              //     prefixIcon: Icon(Icons.book),
                              //     border: OutlineInputBorder(),
                              //     labelText: 'Id Peserta',
                              //   ),
                              //   controller: idPesertaController,
                              // ),
                              // const SizedBox(height: 15),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harus disi!';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950, 1),
                                    lastDate: DateTime(2025, 12),
                                  ).then((pickedDate) {
                                    if (pickedDate != null) {
                                      tanggalLahirController.text =
                                          DateFormat('y-M-d')
                                              .format(pickedDate);
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harus disi!';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Pilih agama'),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harus disi!';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Pilih jenis kelamin'),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Harus disi!';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Pilih status perkawinan'),
                                        content: EnumWidget(
                                          items: statusPerkawinan,
                                          onChange: (String value) {
                                            statusPerkawinanController.text =
                                                value;
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
                              // const SizedBox(height: 15),
                              // TextFormField(
                              //   readOnly: true,
                              //   onTap: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (BuildContext context) {
                              //         return AlertDialog(
                              //           title: const Text('Pilih Status'),
                              //           content: EnumWidget(
                              //             items: status,
                              //             onChange: (String value) {
                              //               statusController.text = value;
                              //               Navigator.of(context).pop();
                              //             },
                              //           ),
                              //         );
                              //       },
                              //     );
                              //   },
                              //   controller: statusController,
                              //   decoration: const InputDecoration(
                              //     prefixIcon: Icon(Icons.book),
                              //     suffixIcon: Icon(Icons.keyboard_arrow_down),
                              //     border: OutlineInputBorder(),
                              //     labelText: 'Status',
                              //   ),
                              // ),
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
                  ],
                ),
              ),
              StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  if (snapshot.data is DataPesertaLoading) {
                    return Positioned.fill(
                      child: SizedBox.expand(
                        child: Container(
                          color: Colors.grey[200]!.withOpacity(0.7),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                  return const Text("");
                },
              ),
            ]),
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
    pangkatGolonganController.dispose();
    idJabatanController.dispose();
    jabatanController.dispose();
    namaJabatanController.dispose();
    idUnitKerjaController.dispose();
    unitKerjaController.dispose();
    idUnitController.dispose();
    unitController.dispose();
    alamatUnitKerjaController.dispose();
    idPendidikanController.dispose();
    pendidikanController.dispose();
    alamatRumahController.dispose();
    noTeleponController.dispose();
    pekerjaanController.dispose();
    kelompokOrganisasiController.dispose();
    idJabatanDalamKelompokController.dispose();
    jabatanDalamKelompokController.dispose();
    desaKelurahanController.dispose();
    idKecamatanController.dispose();
    kecamatanController.dispose();
    idKabupatenController.dispose();
    kabupatenController.dispose();
    idProvinsiController.dispose();
    provinsiController.dispose();
    telpFaxController.dispose();
    emailController.dispose();
    pengalamanPelatihanController.dispose();
    keteranganController.dispose();
    statusController.dispose();
    usernameController.dispose();
    passwordController.dispose();

    bloc.close();

    super.dispose();
  }
}
