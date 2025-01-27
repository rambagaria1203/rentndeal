class ChatRoomModel {
  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastMessage;
  //DateTime? createdon;

  ChatRoomModel({this.chatroomid, this.participants, this.lastMessage});

  Map<String, dynamic> toJson() {
    return {
      "chatroomid": chatroomid,
      "participants": participants,
      "lastmessage": lastMessage,
      //"createdon": createdon
    };
  }
  
  ChatRoomModel.fromSnapshot(Map<String, dynamic> map) {
    chatroomid = map['chatroomid'];
    participants = map['participants'];
    lastMessage = map['lastmessage'];
   // createdon = map["createdon"].toDate();
  }
}