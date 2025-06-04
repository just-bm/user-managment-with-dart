class MessageModel {
  final int? id;
  final String name;
  final String email;
  final String message;
  final DateTime? createdAt;

  MessageModel({
    this.id,
    required this.name,
    required this.email,
    required this.message,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      message: json['message'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }
}
