import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/card_alert_dialog.dart';
import '../components/card_input_formatter.dart';
import '../components/card_month_input_formatter.dart';
import '../components/master_card.dart';
import '../components/my_painter.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  final FlipCardController flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        } //Esconde o teclado ao clicar em outro lugar!!!!!
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 217, 250),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                FlipCard(
                  fill: Fill.fillFront,
                  direction: FlipDirection.HORIZONTAL,
                  controller: flipCardController,
                  onFlip: () {

                  },
                  flipOnTouch: true,
                  onFlipDone: (isFront) {

                  },
                  front: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildCreditCard(
                      color: kDarkPurple,
                      cardHolder: cardHolderNameController.text.isEmpty
                          ? "SEU NOME..."
                          : cardHolderNameController.text.toUpperCase(),
                    ),
                  ),
                  back: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      elevation: 4.0,
                      color: kDarkPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        height: 230,
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 0),
                            const Text(
                              'issued by Nubank under licence by Mastercard International',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 6,
                              ),
                            ),
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            CustomPaint(
                              painter: MyPainter(),
                              child: SizedBox(
                                height: 35,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              cardNumberController.text.isEmpty
                                  ? "XXXX XXXX XXXX XXXX"
                                  : cardNumberController.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                letterSpacing: 4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                buildDetailsBlock(
                                  label: 'VALID THRU',
                                  value: cardExpiryDateController.text.isEmpty
                                      ? "07/30"
                                      : cardExpiryDateController.text,
                                ),

                                SizedBox(width: 50,),

                                buildDetailsBlock(
                                  label: 'SECURITY CODE',
                                  value: cardCvvController.text.isEmpty
                                      ? "322"
                                      : cardCvvController.text,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: cardHolderNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Seu Nome',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        cardHolderNameController.value =
                            cardHolderNameController.value.copyWith(
                                text: value,
                                selection:
                                    TextSelection.collapsed(offset: value.length),
                                composing: TextRange.empty);
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Número do Cartão',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.credit_card,
                        color: Colors.grey,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardInputFormatter(),
                    ],
                    onChanged: (value) {
                      var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                      setState(() {
                        cardNumberController.value = cardNumberController.value
                            .copyWith(
                                text: text,
                                selection:
                                    TextSelection.collapsed(offset: text.length),
                                composing: TextRange.empty);
                      });
                    },
                    onTap: () {
                      setState(() {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          flipCardController.toggleCard();
                        });
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: cardExpiryDateController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'MM/AA',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardDateInputFormatter(),
                        ],
                        onChanged: (value) {
                          var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                          setState(() {
                            cardExpiryDateController.value =
                                cardExpiryDateController.value.copyWith(
                                    text: text,
                                    selection: TextSelection.collapsed(
                                        offset: text.length),
                                    composing: TextRange.empty);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: cardCvvController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'CVV',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onChanged: (value) {
                          setState(() {
                            int length = value.length;
                            if (length == 4 || length == 9 || length == 14) {
                              cardNumberController.text = '$value ';
                              cardNumberController.selection =
                                  TextSelection.fromPosition(
                                      TextPosition(offset: value.length + 1));
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20 * 3),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 1.12, 55),
                  ),
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 300), () {
                      showDialog(
                          context: context,
                          builder: (context) => const CardAlertDialog());
                      cardCvvController.clear();
                      cardExpiryDateController.clear();
                      cardHolderNameController.clear();
                      cardNumberController.clear();
                      flipCardController.toggleCard();
                    });
                  },
                  child: Text(
                    'ADICIONAR CARTÃO'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
