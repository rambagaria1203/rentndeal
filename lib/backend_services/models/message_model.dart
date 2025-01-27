class MessageModel {
  String? messageid;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdon;

  MessageModel({this.messageid, this.sender, this.text, this.seen, this.createdon});

  Map<String, dynamic> toJson() {
    return {
      'messageid': messageid,
      'sender': sender,
      'text': text,
      'seen': seen,
      'createdon': createdon
    };
  }
  
  MessageModel.fromSnapshot(Map<String, dynamic> map) {
    sender = map['sender'];
    text = map['text'];
    seen = map['seen'];
    messageid = map['messageid'];
    createdon = map["createdon"].toDate();
  }

}