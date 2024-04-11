import 'package:flutter/material.dart';

Card buildCreditCard({
  required Color color,
  required String cardHolder,
}) {
  return Card(
    elevation: 4.0,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    child: Container(
      height: 230,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Image.asset(
                "assets/logos/mastercard.png",
                height: 60,
                width: 60,
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                "assets/images/chip.png",
                height: 50,
                width: 60,
              ),
              const SizedBox(width: 8),
              Image.asset(
                "assets/icons/contact_less.png",
                height: 30,
                width: 30,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildDetailsBlock(
                label: 'TITULAR',
                value: cardHolder,
              ),

            ],
          ),
        ],
      ),
    ),
  );
}

Column buildDetailsBlock({required String label, required String value}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: .5,
        ),
      )
    ],
  );
}
