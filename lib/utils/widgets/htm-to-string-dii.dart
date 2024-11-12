import 'package:html/parser.dart' show parse;

String extractFirstTwoSentences(String html, int number) {
  // Parse the HTML string
  var document = parse(html);

  // Find all <p> tags
  var pTags = document.querySelectorAll('p');

  // Loop through each <p> tag
  for (var pTag in pTags) {
    // Check if the <p> tag contains text
    if (pTag.text.trim().isNotEmpty) {
      return pTag.outerHtml;
    }
  }

  // If no <p> tag contains text, return an empty string
  return '';
}

String extractFirstTwoSentencesDescription(String html, int number) {
  // Parse the HTML string
  var document = parse(html);

  // Find all <p> tags
  var pTags = document.querySelectorAll('p');

  // Loop through each <p> tag
  for (var pTag in pTags) {
    // Check if the <p> tag contains text
    if (pTag.text.trim().isNotEmpty) {
      return pTag.outerHtml.split('<p>')[1].split('</p>')[0];
    }
  }

  // If no <p> tag contains text, return an empty string
  return '';
}
