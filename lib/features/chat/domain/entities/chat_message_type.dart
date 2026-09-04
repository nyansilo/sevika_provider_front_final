enum ChatMessageType {
  text,
  location,
  unknown;

  static ChatMessageType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'text':
        return ChatMessageType.text;
      case 'location':
        return ChatMessageType.location;
      default:
        return ChatMessageType.unknown;
    }
  }
}
