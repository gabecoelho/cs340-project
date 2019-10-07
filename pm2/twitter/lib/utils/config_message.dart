// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// enum WordType { User, Hashtag, Url }

// class ConfigMessage {
//   GestureRecognizer onWordTap(WordType wordType, String word) {}

//   List<TextSpan> _configureMessage(BuildContext context, double fontSize) {
//     List<TextSpan> configuredMessage = [];
//     List<String> words = widget.tweet.message.split(RegExp('\\s+'));
//     words.forEach((word) {
//       TextSpan wordWidget;
//       if (word.startsWith('@')) {
//         wordWidget = TextSpan(
//           text: '$word ',
//           recognizer: onWordTap(WordType.User, word),
//           style: TextStyle(
//             color: Theme.of(context).primaryColor,
//             fontSize: fontSize,
//           ),
//         );
//       } else if (word.startsWith('#')) {
//         wordWidget = TextSpan(
//           text: '$word ',
//           recognizer: onWordTap(WordType.Hashtag, word),
//           style: TextStyle(
//             color: Theme.of(context).primaryColor,
//             fontSize: fontSize,
//           ),
//         );
//       } else if (word.startsWith('http')) {
//         wordWidget = TextSpan(
//           text: '$word ',
//           recognizer: onWordTap(WordType.Url, word),
//           style: TextStyle(
//             color: Theme.of(context).primaryColor,
//             fontSize: fontSize,
//           ),
//         );
//       } else {
//         wordWidget = TextSpan(
//           text: '$word ',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: fontSize,
//           ),
//         );
//       }

//       configuredMessage.add(wordWidget);
//     });
//     return configuredMessage;
//   }
// }
