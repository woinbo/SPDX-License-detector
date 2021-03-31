import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

void main(List<String> arguments) {
  fetchXMLDoc();
}

Future fetchXMLDoc() async {
  var hello1 = await http.get(Uri(
    scheme: 'https',
    host: 'raw.githubusercontent.com',
    path: 'spdx/license-list-XML/master/src/CC-BY-2.5.xml',
  ));

  var hello2 = await http.get(Uri(
    scheme: 'https',
    host: 'raw.githubusercontent.com',
    path: 'spdx/license-list-XML/master/src/CC-BY-2.5.xml',
  ));

  print(diceCoefficient(XmlDocument.parse(hello1.body).toString(),
      XmlDocument.parse(hello2.body).toString()));
}

// Percentage of how much the text matched?
double diceCoefficient(String string1, String string2) {
  var intersection = 0;
  var length1 = string1.length - 1;
  var length2 = string2.length - 1;
  if (length1 < 1 || length2 < 1) return 0;
  var bigrams2 = [];
  for (var i = 0; i < length2; i++) {
    // print('${string2.substring(i, length2)} $i');
    bigrams2.add(string2.substring(i, string2.length));
  }
  for (var i = 0; i < length1; i++) {
    var bigram1 = string1.substring(i, string1.length);
    for (var j = 0; j < length2; j++) {
      if (bigram1 == bigrams2[j]) {
        intersection++;
        bigrams2[j] = null;
        break;
      }
    }
  }
  return (2.0 * intersection) / (length1 + length2) * 100;
}

// Future fetchXMLDoc() async {

//   .then((value) => print('SPDX-License-Identifier: ' +
//       XmlDocument.parse(value.body)
//           .findAllElements('license')
//           .first
//           .getAttribute('licenseId')));
// }
