
import 'package:cloud_firestore/cloud_firestore.dart';

class eventDataModel{
  final String id;
  final String title;
  final String img;
  final String category;
  final String description;
  final String location;
  final int price;
  final String organizer_id;
  final DateTime date;
  final String time;

  eventDataModel({
    required this.id,
    required this.title,
    required this.img,
    required this.category,
    required this.description,
    required this.location,
    required this.price,
    required this.organizer_id,
    required this.date,
    required this.time
  });

  factory eventDataModel.fromMap(Map<String, dynamic> json,String documentId){
    return eventDataModel(
      id: json['id'] ?? "0",
      title: json['title'] ?? "title",
      img: json['image'] ?? "no img",
      category: json['category'] ?? "no category",
      description: json['description'] ?? "no description",
      location: json['location'] ?? "no location",
      price: json['price'] ?? 0,
      organizer_id: json['organizer_id'] ?? "0",
      date: (json['date'] as Timestamp).toDate() ?? DateTime.now(),
      time: json['time'] ?? "no time"
    );
  }
}