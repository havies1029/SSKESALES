import 'dart:io';
import 'dart:typed_data';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:esalesapp/helper/image_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class JobRealCrudFotoWidget extends StatefulWidget {
  final String jobReal1Id;

  const JobRealCrudFotoWidget({super.key, required this.jobReal1Id});

  @override
  JobRealCrudFotoWidgetState createState() => JobRealCrudFotoWidgetState();
}

class JobRealCrudFotoWidgetState extends State<JobRealCrudFotoWidget> {
  late JobRealFotoBloc jobRealFotoBloc;
  late JobRealCrudBloc jobRealCrudBloc;

  @override
  void initState() {
    debugPrint("JobRealCrudFotoWidget -> initState #10");

    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      debugPrint(
          "jobRealCrudBloc.state.viewMode -> ${jobRealCrudBloc.state.viewMode}");
      if (jobRealCrudBloc.state.viewMode != "tambah") {
        downloadFoto();
      } else {
        //jobRealFotoBloc.add(ResetStateJobRealFotoEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build #10 ${DateTime.now()}");

    jobRealFotoBloc = BlocProvider.of<JobRealFotoBloc>(context);
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);

    return BlocConsumer<JobRealFotoBloc, JobRealFotoState>(
      builder: (context, state) {
        debugPrint("Build #20 ${DateTime.now()}");

        return SizedBox(
            height: 300,
            child: Stack(
              children: [
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Dokumentasi',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 320,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: state.fotoPath.isNotEmpty
                            ? NetworkImage(
                                '${AppData.apiDomain}${AppData.endPointViewJobRealImage}${widget.jobReal1Id}/${DateTime.now().millisecondsSinceEpoch}',
                                headers: AppData.httpHeaders)
                            : const AssetImage(
                                    "assets/images/icon-user-default.png")
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ))),
                ),
                jobRealCrudBloc.state.viewMode != "lihat"
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            AppData.kIsWeb
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      handleCameraSelection();
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 0, 0),
                                      radius: 20,
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        //backgroundColor: Color.fromARGB(255, 1, 117, 11),
                                        radius: 19,
                                        child: Icon(
                                          Icons.camera_alt,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                            GestureDetector(
                              onTap: () {
                                handleGallerySelection();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                radius: 20,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  //backgroundColor: Color.fromARGB(255, 1, 117, 11),
                                  radius: 19,
                                  child: Icon(
                                    Icons.folder,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                hapusFoto();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                radius: 20,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  //backgroundColor: Color.fromARGB(255, 1, 117, 11),
                                  radius: 19,
                                  child: Icon(
                                    Icons.delete,
                                    size: 25,
                                    //color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ));
      },
      listener: (context, state) {
        if (state.isDownloaded) {}
      },
      buildWhen: (before, current) {
        debugPrint("current.isUploaded : ${current.isUploaded}");
        return (current.isDownloaded ||
            current.isUploaded ||
            current.isDeleted);
      },
    );
  }

  void handleCameraSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.camera,
    );

    if (result != null) {
      String filePath = result.path;
      debugPrint("filePath #10 : $filePath");

      if (AppData.kIsWeb) {
        debugPrint("filePath #15");
        XFile file = XFile(filePath);
        Uint8List bytes = await file.readAsBytes();

        ImageHelper helper = ImageHelper();
        filePath = await helper.convertBytes2LocalImage(
            fileName: file.name, bytes: bytes);

        debugPrint("filePath #20 : $filePath");
      }

      saveFoto(filePath);

      //debugPrint("Length : ${data.length}");
      //debugPrint(data.toString());
    }
  }

  void handleGallerySelection() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(withData: true, type: FileType.image);

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      debugPrint("fileName : $fileName");

      if (fileBytes != null) {
        debugPrint("fileBytes : ${fileBytes.length}");
        ImageHelper helper = ImageHelper();
        String filePath = await helper.convertBytes2LocalImage(
            fileName: fileName, bytes: fileBytes);

        debugPrint("filePath : $filePath");

        saveFoto(filePath);
      }
    }
  }

  void saveFoto(String filePath) {
    debugPrint("saveFoto -> filePath $filePath");
    if (filePath.isNotEmpty) {
      var viewMode = jobRealCrudBloc.state.viewMode;
      if (viewMode == "tambah") {
        jobRealFotoBloc.add(Save2StateFotoJobRealEvent(filePath: filePath));
      } else if (viewMode == "ubah") {
        jobRealFotoBloc.add(UploadFotoJobRealEvent(
            jobReal1Id: widget.jobReal1Id, filePath: filePath));
      }
    }
  }

  void downloadFoto() {
    debugPrint("downloadFoto widget.jobReal1Id : ${widget.jobReal1Id}");
    jobRealFotoBloc
        .add(DownloadFotoJobRealEvent(jobReal1Id: widget.jobReal1Id));
  }

  void hapusFoto() {
    var viewMode = jobRealCrudBloc.state.viewMode;
    if (viewMode != "tambah") {
      jobRealFotoBloc
          .add(HapusFotoAPIJobRealEvent(jobReal1Id: widget.jobReal1Id));
    } else {
      jobRealFotoBloc.add(HapusFotoStateJobRealFotoEvent());
    }
  }
}

class ForcePicRefresh extends StatefulWidget {
  final String url;

  const ForcePicRefresh(this.url, {super.key});

  @override
  ForcePicRefreshState createState() => ForcePicRefreshState();
}

class ForcePicRefreshState extends State<ForcePicRefresh> {
  late Widget _pic;

  @override
  void initState() {
    _pic = Image.network(widget.url);
    super.initState();
  }

  _updateImgWidget() async {
    setState(() {
      _pic = const CircularProgressIndicator();
    });
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(widget.url)).load(widget.url))
            .buffer
            .asUint8List();
    setState(() {
      _pic = Image.memory(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: _pic,
      onTap: () {
        _updateImgWidget();
      },
    );
  }
}
