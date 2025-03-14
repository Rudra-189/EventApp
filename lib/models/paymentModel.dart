import 'package:cloud_firestore/cloud_firestore.dart';

class paymentDataModel{
  final String id;
  final String eventId;
  final String ticketId;
  final String userId;
  final String organizerId;
  final int amount;
  final String status;
  final DateTime timestamp;

  paymentDataModel({
    required this.id,
    required this.eventId,
    required this.ticketId,
    required this.userId,
    required this.organizerId,
    required this.amount,
    required this.status,
    required this.timestamp
  });

  factory paymentDataModel.fromMap(Map<String, dynamic> json,String documentId){
    return paymentDataModel(
      id: json['id'] ?? '',
      eventId: json['eventId'] ?? '',
      ticketId: json['ticketId'] ?? '',
      userId: json['userId'] ?? '',
      organizerId: json['organizerId'],
      amount: json['amount'] ?? 0,
      status: json['status'] ?? '',
      timestamp: (json['timestamp'] as Timestamp).toDate()
    );
  }
}