import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/order.dart';

class DetailsScreen extends StatelessWidget {
  final Order order;

  const DetailsScreen({
    super.key,
    required this.order,
  });

  // ================= معلومات =================

  Widget infoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),

        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(.06),
            Colors.white.withOpacity(.03),
          ],
        ),

        border: Border.all(
          color: Colors.white.withOpacity(.08),
        ),

        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.08),
            blurRadius: 25,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(.6),
                ],
              ),

              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(.35),
                  blurRadius: 18,
                ),
              ],
            ),

            child: Icon(
              icon,
              color: Colors.black,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.55),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= هيدر =================

  Widget topHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),

      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),

        child: Container(
          padding: const EdgeInsets.all(28),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),

            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.cyanAccent.withOpacity(.22),
                Colors.blue.withOpacity(.16),
                Colors.purple.withOpacity(.12),
              ],
            ),

            border: Border.all(
              color: Colors.white.withOpacity(.08),
            ),
          ),

          child: Column(
            children: [
              Container(
                width: 95,
                height: 95,

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
                      blurRadius: 30,
                    ),
                  ],
                ),

                child: Center(
                  child: Text(
                    order.name.isNotEmpty ? order.name[0] : "?",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                "تفاصيل الطلب",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                order.product,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= السعر والإجمالي =================

  Widget priceCard(
      String title,
      String value,
      IconData icon,
      List<Color> colors,
      ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(colors: colors),

          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(.3),
              blurRadius: 22,
            ),
          ],
        ),

        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),

            const SizedBox(height: 15),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,

        title: const Text(
          "تفاصيل الطلب",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            topHeader(),

            const SizedBox(height: 28),

            Row(
              children: [
                priceCard(
                  "الإجمالي",
                  "${order.total} ج",
                  Icons.payments_rounded,
                  [
                    const Color(0xff00E5FF),
                    const Color(0xff2979FF),
                  ],
                ),

                const SizedBox(width: 16),

                priceCard(
                  "الكمية",
                  "${order.qty}",
                  Icons.inventory_2_rounded,
                  [
                    const Color(0xff7C4DFF),
                    const Color(0xff512DA8),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            infoCard(
              icon: Icons.person_rounded,
              title: "اسم العميل",
              value: order.name,
              color: Colors.cyanAccent,
            ),

            infoCard(
              icon: Icons.phone_rounded,
              title: "رقم الهاتف",
              value: order.phone,
              color: Colors.greenAccent,
            ),

            infoCard(
              icon: Icons.location_on_rounded,
              title: "العنوان",
              value: order.address,
              color: Colors.orangeAccent,
            ),

            infoCard(
              icon: Icons.shopping_bag_rounded,
              title: "اسم المنتج",
              value: order.product,
              color: Colors.purpleAccent,
            ),

            infoCard(
              icon: Icons.payments_rounded,
              title: "السعر",
              value: "${order.price} ج",
              color: Colors.redAccent,
            ),

            if (order.notes.isNotEmpty)
              infoCard(
                icon: Icons.notes_rounded,
                title: "ملاحظات",
                value: order.notes,
                color: Colors.tealAccent,
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}