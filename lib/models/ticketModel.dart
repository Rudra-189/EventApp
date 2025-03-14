
import 'package:cloud_firestore/cloud_firestore.dart';

class ticketDataModel {
  final String id;
  final String userId;
  final String eventId;
  final String type;
  final int seat;
  final String status;
  final String qrCode;
  final EventData eventData;
  final String payment_id;

  ticketDataModel({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.type,
    required this.seat,
    required this.status,
    required this.qrCode,
    required this.eventData,
    required this.payment_id,
  });

  // Factory method to create a Ticket object from Firestore document
  factory ticketDataModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ticketDataModel(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      eventId: map['event_id'] ?? '',
      type: map['type'] ?? '',
      seat: map['seat'] ?? 0,
      status: map['status'] ?? '',
      qrCode: map['qr_code'] ?? '',
      eventData: EventData.fromMap(map['event_data'] ?? {}),
      payment_id: map['payment_id'] ?? '',
    );
  }
}

class EventData {
  final String title;
  final DateTime date;
  final String img;
  final String location;

  EventData({
    required this.title,
    required this.date,
    required this.img,
    required this.location,
  });

  factory EventData.fromMap(Map<String, dynamic> map) {
    return EventData(
      title: map['title'] ?? '',
      date: (map['date'] as Timestamp).toDate() ?? DateTime.now(),
      img: map['img'] ?? '',
      location: map['location'] ?? '',
    );
  }
}
