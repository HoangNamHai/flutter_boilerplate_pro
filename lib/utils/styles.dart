import 'dart:io';

import '/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

const kFontHeader = 'Bebas Neue';
const kFontBody = 'Poppins';

const kButtonBorderRadius = 4.0;

TextStyle ksHeader = GoogleFonts.getFont(
  kFontHeader,
  textStyle: TextStyle(
    fontSize: 32,
    color: kcPrimary,
  ),
);

TextStyle ksH1 = GoogleFonts.getFont(
  kFontHeader,
  textStyle: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: kcPrimary,
  ),
);

TextStyle ksH2 = GoogleFonts.getFont(
  kFontHeader,
  textStyle: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: kcPrimary,
  ),
);

TextStyle ksH3 = GoogleFonts.getFont(
  kFontHeader,
  textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: kcPrimary,
  ),
);

TextStyle ksH4 = GoogleFonts.getFont(
  kFontHeader,
  textStyle: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: kcPrimary,
  ),
);

TextStyle ksH5 = GoogleFonts.getFont(
  kFontBody,
  textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: kcWhite,
  ),
);

TextStyle ksH6 = GoogleFonts.getFont(
  kFontBody,
  textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: kcWhite,
  ),
);

TextStyle ksNumber = GoogleFonts.getFont(
  kFontHeader,
  textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
  ),
);

TextStyle ksHeadline = GoogleFonts.getFont(
  kFontHeader,
  textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: kcPrimary,
  ),
);

TextStyle ksBody = GoogleFonts.getFont(
  kFontBody,
  textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kcWhite,
  ),
);

TextStyle ksCode = TextStyle(
  fontFamily: Platform.isIOS ? "Courier" : "monospace",
  fontWeight: FontWeight.bold,
  backgroundColor: Colors.blue.shade900,
  fontSize: 18,
  color: kcWhite,
);

TextStyle ksSubHeading = GoogleFonts.getFont(
  kFontBody,
  textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: kcText,
  ),
);

TextStyle ksCaption = GoogleFonts.getFont(
  kFontBody,
  textStyle: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: kcText,
  ),
);

TextStyle ksButtonText = GoogleFonts.getFont(
  kFontBody,
  textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kcWhite,
  ),
);

extension ExtendedText on Text {
  Text applyStyle(TextStyle style) {
    return Text(
      this.data ?? '',
      style: style.merge(this.style),
      strutStyle: this.strutStyle,
      textAlign: this.textAlign,
      locale: this.locale,
      maxLines: this.maxLines,
      overflow: this.overflow,
      semanticsLabel: this.semanticsLabel,
      softWrap: this.softWrap,
      textDirection: this.textDirection,
      textScaleFactor: this.textScaleFactor,
      textWidthBasis: this.textWidthBasis,
    );
  }

  Text h1() => applyStyle(ksH1);
  Text h2() => applyStyle(ksH2);
  Text h3() => applyStyle(ksH3);
  Text h5() => applyStyle(ksH5);
  Text h6() => applyStyle(ksH6);
  Text number() => applyStyle(ksNumber);
  Text body() => applyStyle(ksBody);

  Widget markdown() {
    return Markdown(
      data: this.data ?? '',
      shrinkWrap: true,
      onTapLink: (text, href, title) {
        launch('$href');
      },
      styleSheet: MarkdownStyleSheet(
        a: TextStyle(
          color: Colors.grey,
          decoration: TextDecoration.underline,
        ),
        p: ksBody,
        h1: ksH1,
        h2: ksH2,
        h3: ksH3,
        h4: ksH4,
        h5: ksH5,
        h6: ksH6,
        code: ksCode,
      ),
    );
  }

  void debug() {
    print(this.style);
  }
}

extension ExtendedString on String {
  Widget body() => Text(this, style: ksBody);
  Widget h1() => Text(this, style: ksH1);
  Widget h2() => Text(this, style: ksH2);
  Widget h3() => Text(this, style: ksH3);
  Widget h4() => Text(this, style: ksH4);
  Widget h5() => Text(this, style: ksH5);
  Widget h6() => Text(this, style: ksH6);
  Widget caption() => Text(this, style: ksCaption);
  Widget code() => Text(this, style: ksCode);
  Widget markdown() => Text(this).markdown();
}
