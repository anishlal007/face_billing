class AddProductRequest {
  int itemType;

  AddProductRequest({
    required this.itemType,
  });

  Map<String, dynamic> toJson() {
    return {"ItemType": itemType};
  }
}
