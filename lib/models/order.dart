class Order {
  String name;
  String phone;
  String address;
  String product;
  int qty;
  double price;
  String notes;

  // ================= بيانات إضافية =================

  String id;
  String date;

  Order({
    required this.name,
    required this.phone,
    required this.address,
    required this.product,
    required this.qty,
    required this.price,
    required this.notes,

    required this.id,
    required this.date,
  });

  // ================= الإجمالي =================

  double get total => qty * price;

  // ================= تحويل لـ JSON =================

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "address": address,
      "product": product,
      "qty": qty,
      "price": price,
      "notes": notes,
      "id": id,
      "date": date,
    };
  }

  // ================= استرجاع من JSON =================

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
      product: json["product"] ?? "",
      qty: json["qty"] ?? 0,

      price: (json["price"] as num).toDouble(),

      notes: json["notes"] ?? "",

      id: json["id"] ?? "",
      date: json["date"] ?? "",
    );
  }
}