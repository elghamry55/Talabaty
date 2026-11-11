import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';
import 'orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Order> orders = [];

  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final product = TextEditingController();
  final qty = TextEditingController();
  final price = TextEditingController();
  final notes = TextEditingController();

  final formKey = GlobalKey<FormState>();

  int currentIndex = 0;

  // ================= STORAGE =================

  void saveOrders() async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode(orders.map((e) => e.toJson()).toList());

    await prefs.setString("orders", data);
  }

  void loadOrders() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString("orders");

    if (data != null) {
      final list = jsonDecode(data) as List;

      setState(() {
        orders.clear();

        orders.addAll(list.map((e) => Order.fromJson(e)).toList());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  // ================= ADD ORDER =================

  void addOrder() {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      orders.insert(
        0,
        Order(
          name: name.text,
          phone: phone.text.trim().isEmpty ? "لا يوجد" : phone.text.trim(),
          address: address.text,
          product: product.text,
          qty: int.parse(qty.text),
          price: double.parse(price.text),
          notes: notes.text,

          id: DateTime.now().millisecondsSinceEpoch.toString(),

          date:
              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
        ),
      );
    });

    saveOrders();

    name.clear();
    phone.clear();
    address.clear();
    product.clear();
    qty.clear();
    price.clear();
    notes.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [
                    Colors.cyanAccent.withOpacity(.25),
                    Colors.blue.withOpacity(.25),
                  ],
                ),
                border: Border.all(color: Colors.white.withOpacity(.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.cyanAccent),
                  SizedBox(width: 12),
                  Text(
                    "تم إضافة الطلب بنجاح",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= DELETE =================

  void deleteOrder(Order o) {
    setState(() {
      orders.remove(o);
    });

    saveOrders();
  }

  // ================= FIELD =================

  Widget customField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(.06),
              blurRadius: 20,
              spreadRadius: 1,
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: type == TextInputType.phone ? TextInputType.text : type,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return "هذا الحقل مطلوب";
            }

            // ✅ السماح بـ "لا يوجد"
            if (hint.contains("رقم") &&
                v.trim() != "لا يوجد" &&
                !RegExp(r'^[0-9]+$').hasMatch(v)) {
              return "اكتب أرقام أو (لا يوجد)";
            }

            return null;
          },
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(.45)),
            prefixIcon: Icon(icon, color: Colors.cyanAccent),
            filled: true,
            fillColor: const Color(0xff111827).withOpacity(.75),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.white.withOpacity(.05)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              borderSide: BorderSide(color: Colors.cyanAccent, width: 1.4),
            ),
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget topHeader() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.cyanAccent.withOpacity(.25),
            Colors.blue.withOpacity(.25),
            Colors.purple.withOpacity(.22),
          ],
        ),
        border: Border.all(color: Colors.white.withOpacity(.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(.12),
            blurRadius: 35,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.cyanAccent, Colors.blue],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withOpacity(.5),
                  blurRadius: 30,
                ),
              ],
            ),
            child: const Icon(
              Icons.shopping_bag_rounded,
              color: Colors.black,
              size: 35,
            ),
          ),

          const SizedBox(width: 18),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "إدارة الطلبات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= INFO CARDS =================

  Widget statsCard(
    String title,
    String value,
    IconData icon,
    List<Color> colors,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(colors: colors),
          boxShadow: [
            BoxShadow(color: colors.first.withOpacity(.3), blurRadius: 20),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 30),

            const SizedBox(height: 14),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final totalOrders = orders.length;

    final totalMoney = orders.fold(0.0, (sum, item) => sum + item.total);

    return Scaffold(
      backgroundColor: const Color(0xff050816),

      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.cyanAccent.withOpacity(.5), blurRadius: 25),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.cyanAccent,
          onPressed: addOrder,
          child: const Icon(Icons.add, color: Colors.black, size: 32),
        ),
      ),

      // ================= NAVIGATION =================
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.06),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.white.withOpacity(.08)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navButton(
                    icon: Icons.home_rounded,
                    title: "الرئيسية",
                    selected: currentIndex == 0,
                    onTap: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                  ),

                  navButton(
                    icon: Icons.inventory_2_rounded,
                    title: "الطلبات",
                    selected: currentIndex == 1,
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrdersScreen(
                            orders: orders,
                            onUpdate: () => setState(() {}),
                            onDelete: deleteOrder,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              topHeader(),

              const SizedBox(height: 28),

              Row(
                children: [
                  statsCard(
                    "عدد الطلبات",
                    "$totalOrders",
                    Icons.shopping_cart_checkout_rounded,
                    [const Color(0xff00E5FF), const Color(0xff2979FF)],
                  ),

                  const SizedBox(width: 15),

                  statsCard(
                    "إجمالي الأرباح",
                    "${totalMoney.toStringAsFixed(0)} ج",
                    Icons.payments_rounded,
                    [const Color(0xff7C4DFF), const Color(0xff512DA8)],
                  ),
                ],
              ),

              const SizedBox(height: 35),

              const Text(
                "إضافة طلب جديد",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 22),

              customField(
                hint: "اسم العميل",
                icon: Icons.person_rounded,
                controller: name,
              ),

              customField(
                hint: "رقم الهاتف",
                icon: Icons.phone_rounded,
                controller: phone,
                type: TextInputType.phone,
              ),

              customField(
                hint: "العنوان",
                icon: Icons.location_on_rounded,
                controller: address,
              ),

              customField(
                hint: "اسم المنتج",
                icon: Icons.inventory_2_rounded,
                controller: product,
              ),

              customField(
                hint: "الكمية",
                icon: Icons.format_list_numbered_rounded,
                controller: qty,
                type: TextInputType.number,
              ),

              customField(
                hint: "السعر",
                icon: Icons.payments_rounded,
                controller: price,
                type: TextInputType.number,
              ),

              customField(
                hint: "ملاحظات إضافية",
                icon: Icons.notes_rounded,
                controller: notes,
              ),

              const SizedBox(height: 130),
            ],
          ),
        ),
      ),
    );
  }

  // ================= NAV BUTTON =================

  Widget navButton({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: selected
              ? const LinearGradient(
                  colors: [Color(0xff00E5FF), Color(0xff2979FF)],
                )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.black : Colors.white60,
              size: 28,
            ),

            if (selected) ...[
              const SizedBox(width: 10),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
