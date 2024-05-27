import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class Collapsible extends StatefulWidget {
  const Collapsible({super.key, required this.child, required this.title});

  final Widget child;
  final String title;

  @override
  State<Collapsible> createState() => _CollapsibleState();
}

class _CollapsibleState extends State<Collapsible> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOpen = !_isOpen;
        });
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(249, 178, 53, 0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(72, 2, 151, 1)),
                  ),
                  _isOpen
                      ? const HeroIcon(HeroIcons.chevronUp)
                      : const HeroIcon(HeroIcons.chevronDown)
                ],
              ),
              Builder(builder: (context) {
                if (_isOpen) {
                  return Column(
                    children: [const SizedBox(height: 20), widget.child],
                  );
                }

                return Container();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
