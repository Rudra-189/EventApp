class cancelDataModel{
  final String id;
  final String eventId;
  final String ticketId;
  final String userId;
  final String paymentId;
  final String cancel_reason;
  final bool organizer_approval;

  cancelDataModel({
    required this.id,
    required this.eventId,
    required this.ticketId,
    required this.userId,
    required this.paymentId,
    required this.cancel_reason,
    required this.organizer_approval,
  });

  factory cancelDataModel.fromMap(Map<String, dynamic> json,String documentId){
    return cancelDataModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      eventId: json['eventId'] ?? '',
      ticketId: json['ticketId'] ?? '',
      paymentId: json['paymentId'] ?? '',
      cancel_reason: json['cancel_reason'] ?? '',
      organizer_approval: json['organizer_approval'] ?? ''
    );
  }
}