import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:esalesapp/blocs/jobreal/jobrealcrud_bloc.dart';
import 'package:esalesapp/blocs/jobreal/jobrealfoto_bloc.dart';
import 'package:esalesapp/common/app_data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        //downloadFoto();
      } else {
        //jobRealFotoBloc.add(ResetStateJobRealFotoEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Build #10 ${DateTime.now()}");
    debugPrint("widget.jobReal1Id : ${widget.jobReal1Id}");

    jobRealFotoBloc = BlocProvider.of<JobRealFotoBloc>(context);
    jobRealCrudBloc = BlocProvider.of<JobRealCrudBloc>(context);

    return BlocConsumer<JobRealFotoBloc, JobRealFotoState>(
      builder: (context, state) {
        debugPrint("Build #20 ${DateTime.now()}");
        debugPrint(
            'url : ${AppData.apiDomain}${AppData.endPointViewJobRealImage}${widget.jobReal1Id}/${DateTime.now().millisecondsSinceEpoch}');
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
                      width: AppData.kIsWeb
                          ? 500
                          : MediaQuery.of(context).size.width,
                      height: 320,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: state.isPendingUpload
                            ? (state.imageSource == "camera"
                                ? Image.file(File(state.fotoPath)).image
                                : MemoryImage(state.fotoBytes!))
                            : !state.hasFailure
                                ? NetworkImage(
                                    '${AppData.apiDomain}${AppData.endPointViewJobRealImage}${widget.jobReal1Id}/${DateTime.now().millisecondsSinceEpoch}',
                                    headers: AppData.httpHeaders)
                                : const AssetImage(
                                        "assets/images/icon-user-default.png")
                                    as ImageProvider,
                        onError: (exception, stackTrace) {
                          jobRealFotoBloc.add(SetErrorJobRealFotoEvent(
                              errorMsg: exception.toString()));
                        },
                        fit: BoxFit.cover,
                      ))),
                ),
                jobRealCrudBloc.state.viewMode != "lihat"
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                            AppData.kIsWeb
                                ? GestureDetector(
                                    onTap: () async {
                                      handleGallerySelection();
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
                                          Icons.folder,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
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
        String displayMessage = "";
        if (state.isDownloaded) {
          displayMessage = "Photo has been downloaded";
        }
        /*
        if (state.isDownloading) {
          if (displayMessage.isNotEmpty) displayMessage += '\r';
          displayMessage += "Foto isDownloading";
        }
        
        if (state.isUploading) {
          if (displayMessage.isNotEmpty) displayMessage += '\r';
          displayMessage += "Foto isUploading";
        }
        */
        if (state.isUploaded) {
          if (displayMessage.isNotEmpty) displayMessage += '\r';
          displayMessage += "Photo has been uploaded";
        }
        /*
        if (state.isDeleting) {
          if (displayMessage.isNotEmpty) displayMessage += '\r';
          displayMessage += "Foto isDeleting";
        }
        */
        if (state.isDeleted) {
          if (displayMessage.isNotEmpty) displayMessage += '\r';
          displayMessage += "Photo has been deleted";
        }

        if (displayMessage.isNotEmpty) {
          if (state.hasFailure) {
            if (displayMessage.isNotEmpty) displayMessage += '\r';
            displayMessage += "Photo has failure : ${state.errorMsg}";
          }
        }
        /*
        if (state.isPendingUpload) {
          if (displayMessage.isNotEmpty) displayMessage += '\r';
          displayMessage += "Photo isPendingUpload";
        }
        if (state.fotoPath.isNotEmpty) {
          if (displayMessage.isNotEmpty) displayMessage += '\r';
          displayMessage += "fotoPath : ${state.fotoPath}";
        }
        */
        if (displayMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(displayMessage),
            backgroundColor: Colors.orange,
          ));
        }
      },
      buildWhen: (before, current) {
        debugPrint("current.isUploaded : ${current.isUploaded}");
        debugPrint("state.hasFailure : ${current.hasFailure}");
        return (current.isDownloaded ||
            current.isUploaded ||
            current.isDeleted ||
            current.hasFailure);
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

      /*
      if (AppData.kIsWeb) {
        debugPrint("filePath #15");
        XFile file = XFile(filePath);
        Uint8List bytes = await file.readAsBytes();

        ImageHelper helper = ImageHelper();
        filePath = await helper.convertBytes2LocalImage(
            fileName: file.name, bytes: bytes);

        debugPrint("filePath #20 : $filePath");
      }
      */

      saveFotoCamera(filePath, "camera");

      //debugPrint("Length : ${data.length}");
      //debugPrint(data.toString());
    }
  }

  void handleGallerySelection() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(withData: true, type: FileType.image);

    if (result != null) {
      if (result.files.first.bytes != null) {
        Uint8List fileBytes = compressAndResizeImage(result.files.first.bytes!);
        //Uint8List? fileBytes = result.files.first.bytes;
        String fileName = result.files.first.name;
        debugPrint("fileName : $fileName");

        debugPrint("fileBytes : ${fileBytes.length}");
        var viewMode = jobRealCrudBloc.state.viewMode;
        debugPrint("viewMode : $viewMode");
        if (viewMode == "tambah") {
          jobRealFotoBloc.add(Save2StateFotoBinaryJobRealEvent(
              fotoBytes: fileBytes,
              imageSource: "gallery",
              fileName: fileName));
        } else {
          jobRealFotoBloc.add(UploadFotoBytesJobRealEvent(
              jobReal1Id: widget.jobReal1Id,
              fileName: fileName,
              bytes: fileBytes,
              imageSource: "gallery"));
        }
      }
    } else {
      jobRealFotoBloc.add(
          const SetErrorJobRealFotoEvent(errorMsg: "FilePickerResult is null"));
    }
  }

  Uint8List compressAndResizeImage(Uint8List fileBytes) {
    debugPrint("compressAndResizeImage");
    img.Image? image = img.decodeImage(fileBytes);

    // Resize the image to have the longer side be 800 pixels
    int width;
    int height;

    if (image!.width > image.height) {
      width = 800;
      height = (image.height / image.width * 800).round();
    } else {
      height = 800;
      width = (image.width / image.height * 800).round();
    }

    img.Image resizedImage =
        img.copyResize(image, width: width, height: height);

    // Compress the image with JPEG format
    Uint8List compressedBytes =
        img.encodeJpg(resizedImage, quality: 85); // Adjust quality as needed

    return compressedBytes;
  }

  void saveFotoCamera(String filePath, String imageSource) {
    debugPrint("saveFotoCamera -> filePath $filePath");
    if (filePath.isNotEmpty) {
      var viewMode = jobRealCrudBloc.state.viewMode;
      if (viewMode == "tambah") {
        debugPrint("saveFotoCamera -> viewMode : $viewMode");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("saveFotoCamera -> Save2StateFotoLocalPathJobRealEvent"),
          backgroundColor: Colors.orange,
        ));
        jobRealFotoBloc.add(Save2StateFotoLocalPathJobRealEvent(
            filePath: filePath, imageSource: imageSource));
      } else if (viewMode == "ubah") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("saveFotoCamera -> UploadFotoJobRealEvent"),
          backgroundColor: Colors.orange,
        ));
        jobRealFotoBloc.add(UploadFotoJobRealEvent(
            jobReal1Id: widget.jobReal1Id,
            filePath: filePath,
            imageSource: imageSource));
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
