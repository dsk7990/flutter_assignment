import 'package:flutter/material.dart';
import 'package:flutter_assignment/constants/colors.dart';
import 'package:flutter_assignment/widgets/cbutton.dart';

class Error extends StatelessWidget {
  final String? errorMessage;

  final Function()? onRetryPressed;

  const Error({Key? key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustColorButton(
              title: 'Retry',
              onPressed: onRetryPressed,
              color: colorPrimary,
            ),
          )
        ],
      ),
    );
  }
}
