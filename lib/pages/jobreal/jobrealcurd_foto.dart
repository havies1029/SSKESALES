import 'dart:io';
import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
    jobRealFotoBloc = BlocProvider.of<JobRealFotoBloc>(context);
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);

    return BlocConsumer<JobRealFotoBloc, JobRealFotoState>(
      builder: (context, state) {
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
                            ? FileImage(File(state.fotoPath))
                            : const AssetImage(
                                    "assets/images/icon-user-default.png")
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ))),
                ),
                jobRealCrudBloc.state.viewMode != "lihat" ? Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          handleCameraSelection();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          radius: 20,
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                          hapusFoto();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          radius: 20,
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                ):Container(),
              ],
            ));
      },
      listener: (context, state) {
        if (state.isDownloaded) {}
      },
      buildWhen: (before, current) {
        //debugPrint("current.isDownloaded : ${current.isDownloaded}");
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

      saveFoto(filePath);

      //debugPrint("Length : ${data.length}");
      //debugPrint(data.toString());
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
