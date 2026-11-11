import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../models/order.dart';
import 'details_screen.dart';

class OrdersScreen extends StatefulWidget {
  final List<Order> orders;
  final Function onUpdate;
  final Function(Order) onDelete;

  const OrdersScreen({
    super.key,
    required this.orders,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final ScreenshotController controller = ScreenshotController();

  // ================= مشاركة كصورة احترافية =================

  void shareAsImage(Order o) async {
    final image = await controller.captureFromWidget(
      Directionality(
        textDirection: TextDirection.rtl,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff0B1220),
                  Color(0xff111827),
                  Color(0xff1E293B),
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Colors.cyanAccent,
                        Colors.blue,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(.45),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.black,
                    size: 42,
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  "تفاصيل الطلب",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 35),

                shareItem("اسم العميل", o.name),
                shareItem("رقم الهاتف", o.phone),
                shareItem("العنوان", o.address),
                shareItem("المنتج", o.product),
                shareItem("الكمية", "${o.qty}"),
                shareItem("الإجمالي", "${o.total} ج"),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withOpacity(.05),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: Colors.cyanAccent,
                      ),

                      SizedBox(width: 10),

                      Text(
                        "تم إنشاء الطلب عبر التطبيق",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    final dir = await getTemporaryDirectory();

    final file = File("${dir.path}/طلب.png");

    await file.writeAsBytes(image);

    await Share.shareXFiles(
      [XFile(file.path)],
      text: "تفاصيل الطلب",
    );
  }

  // ================= تعديل الطلب =================

  void editOrder(Order o) {
    final name = TextEditingController(text: o.name);
    final phone = TextEditingController(text: o.phone);
    final address = TextEditingController(text: o.address);
    final product = TextEditingController(text: o.product);
    final qty = TextEditingController(text: o.qty.toString());
    final price = TextEditingController(text: o.price.toString());
    final notes = TextEditingController(text: o.notes);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(35),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xff111827).withOpacity(.94),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text(
                        "تعديل الطلب",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      field("اسم العميل", name),
                      field("رقم الهاتف", phone),
                      field("العنوان", address),
                      field("اسم المنتج", product),
                      field("الكمية", qty),
                      field("السعر", price),
                      field("ملاحظات", notes),

                      const SizedBox(height: 25),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            o.name = name.text;
                            o.phone = phone.text;
                            o.address = address.text;
                            o.product = product.text;
                            o.qty = int.parse(qty.text);
                            o.price = double.parse(price.text);
                            o.notes = notes.text;
                          });

                          widget.onUpdate();

                          Navigator.pop(context);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xff00E5FF),
                                Color(0xff2979FF),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "حفظ التعديلات",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ================= عنصر المشاركة =================

  Widget shareItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white.withOpacity(.05),
          border: Border.all(
            color: Colors.white.withOpacity(.08),
          ),
        ),
        child: Row(
          children: [
            Text(
              "$title : ",
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= الحقول =================

  Widget field(
      String hint,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: Colors.white.withOpacity(.04),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ================= أزرار الأكشن =================

  Widget actionButton({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: color.withOpacity(.12),
            border: Border.all(
              color: color.withOpacity(.35),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),

              const SizedBox(width: 10),

              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= الكارد =================

  Widget orderCard(Order o) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(order: o),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(.07),
              Colors.white.withOpacity(.03),
            ],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(.08),
              blurRadius: 25,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff00E5FF),
                        Color(0xff2979FF),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(.45),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      o.name.isNotEmpty ? o.name[0] : "?",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        o.product,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            Row(
              children: [
                infoBox(
                  Icons.shopping_cart_checkout_rounded,
                  "الكمية",
                  "${o.qty}",
                ),

                const SizedBox(width: 15),

                infoBox(
                  Icons.payments_rounded,
                  "الإجمالي",
                  "${o.total} ج",
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                actionButton(
                  icon: Icons.edit_rounded,
                  color: Colors.orange,
                  title: "تعديل",
                  onTap: () => editOrder(o),
                ),

                const SizedBox(width: 12),

                actionButton(
                  icon: Icons.share_rounded,
                  color: Colors.cyanAccent,
                  title: "مشاركة",
                  onTap: () => shareAsImage(o),
                ),

                const SizedBox(width: 12),

                actionButton(
                  icon: Icons.delete_rounded,
                  color: Colors.redAccent,
                  title: "حذف",
                  onTap: () {
                    widget.onDelete(o);

                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= معلومات الكارد =================

  Widget infoBox(
      IconData icon,
      String title,
      String value,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white.withOpacity(.04),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.cyanAccent,
              size: 28,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff050816),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "الطلبات",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: widget.orders.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              color: Colors.white.withOpacity(.2),
              size: 120,
            ),

            const SizedBox(height: 20),

            const Text(
              "لا توجد طلبات حالياً",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: widget.orders.length,
        itemBuilder: (context, index) {
          return orderCard(
            widget.orders[index],
          );
        },
      ),
    );
  }
}