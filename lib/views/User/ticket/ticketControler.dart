import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../../models/eventmodel.dart';
import '../../../models/ticketModel.dart';
import '../../loaderControler.dart';


class ticketControler extends GetxController{

  final loaderControler loader = Get.put(loaderControler());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var tickets = RxList<ticketDataModel>();

  var _isShare = false.obs;

  void getTicket()async{
    try{
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('ticket').where('user_id', isEqualTo: uid).orderBy("timestamp", descending: true).get();

      if(snapshot.docs.isNotEmpty){
        tickets.value = snapshot.docs.map((doc) {
          return ticketDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

  Future<void> generateAndDownloadPdf(ticketDataModel ticket,bool share) async {
    try{
      loader.startLoading();
      final pdf = pw.Document();

      Uint8List? imageBytes = await downloadImage(ticket.eventData.img);
      if (imageBytes == null) {
        print("Failed to load image");
        return;
      }

      final pdfImage = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
                child: pw.Container(
                    width: 150,
                    height: 275,
                    padding: pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                        color: PdfColors.grey900
                    ),
                    child: pw.Column(
                        children: [
                          pw.Text("EVENT ERA",style: pw.TextStyle(color: PdfColors.green600,fontSize: 10,letterSpacing: 1)),
                          pw.SizedBox(height: 10),
                          pw.Container(
                            width: 125,
                            height: 75,
                            child: pw.Image(pdfImage, fit: pw.BoxFit.cover), // Show Image
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(ticket.eventData.title,style: pw.TextStyle(color: PdfColors.green600,fontSize: 8,fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 10),
                          pw.Divider(
                              color: PdfColors.white,
                              height: 0.01
                          ),
                          pw.SizedBox(height: 10),
                          pw.Container(
                              width: 100,
                              child: pw.Column(
                                  children: [
                                    pw.Row(
                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        children:[
                                          pw.Column(
                                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                                              children: [
                                                pw.Text("Date :",style: pw.TextStyle(color: PdfColors.white,fontSize: 6),),
                                                pw.SizedBox(height: 1),
                                                pw.Text("Time :",style: pw.TextStyle(color: PdfColors.white,fontSize: 6),),
                                                pw.SizedBox(height: 1),
                                                pw.Text("Seat :",style: pw.TextStyle(color: PdfColors.white,fontSize: 6),),
                                                pw.SizedBox(height: 1),
                                                pw.Text("Venue :",style: pw.TextStyle(color: PdfColors.white,fontSize: 6),),
                                              ]
                                          ),
                                          pw.SizedBox(width: 5),
                                          pw.Column(
                                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(DateFormat('MM/dd/yyyy').format(ticket.eventData.date),style: pw.TextStyle(color: PdfColors.white,fontSize: 6),),
                                                pw.SizedBox(height: 1),
                                                pw.Text(DateFormat('hh:mm a').format(ticket.eventData.date),style: pw.TextStyle(color: PdfColors.white,fontSize: 6),),
                                                pw.SizedBox(height: 1),
                                                pw.Text(ticket.seat.toString(),style: pw.TextStyle(color: PdfColors.white,fontSize: 6),),
                                                pw.SizedBox(height: 1),
                                                pw.SizedBox(
                                                  width: 100,
                                                  child: pw.Text(ticket.eventData.location,style: pw.TextStyle(color: PdfColors.white,fontSize: 6),),
                                                ),
                                              ]
                                          )


                                        ]
                                    ),

                                  ]
                              )
                          ),
                          pw.SizedBox(height: 10),
                          pw.Divider(
                              color: PdfColors.white,
                              height: 0.01
                          ),
                          pw.SizedBox(height: 10),
                          pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data: ticket.qrCode,
                            width: 50,
                            height: 50,
                            drawText: false,
                            color: ticket.type == 'vip' ? PdfColors.green600 : PdfColors.white ,
                          ),
                        ]
                    )
                )
            );
          },
        ),
      );
      Directory? directory = await getExternalStorageDirectory();
      String path = "${directory!.path}/Download";
      Directory(path).createSync(recursive: true);

      File file = File("$path/Event_Ticket.pdf");
      await file.writeAsBytes(await pdf.save());

      if(_isShare == share){
        OpenFile.open(file.path);
      }else{
        Share.shareXFiles([XFile(file.path)], text: "Here's your event ticket!");
      }


      print(file.path);
    }catch(e){
      print("/////////////${e.toString()}////////////");
    }finally{
      loader.stopLoading();
    }
  }
  Future<Uint8List?> downloadImage(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.bodyBytes; // Convert response to Uint8List
      } else {
        print("Failed to load image: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }
}

