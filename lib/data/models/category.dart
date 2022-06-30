class Category {
  Category({required this.title, this.isPressed = false});
  String title;
  bool isPressed;

  void pressed() {
    isPressed = true;
  }

  void notPressed() {
    isPressed = false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && title == other.title && isPressed == other.isPressed;

  @override
  int get hashCode => title.hashCode ^ isPressed.hashCode;
}
