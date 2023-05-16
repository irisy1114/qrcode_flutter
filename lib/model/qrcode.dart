class QRCode {
  final int id;
  final String text;
  static const String tableName = "qrcodes";

  const QRCode ({ required this.id, required this.text});

  Map<String, dynamic> toMap() {
    return { 'id': id, 'text': text};
  }

  @override
  String toString() {
    return 'QRCode{id: $id, $text}';
  }
}