/**
 * Pseudo-enumeration for DOM element types.
 * These could easily be strings, but this is ever so slightly more convenient
 * in the developer console and in code.
 */

/**
 * Closing tags are represented as negative values.
 * For example, -38 represents the closing tag for <H1>.
 * The 0th index is unused, as it can't be negated.
 */
::ABBR <- 1;
::ADDRESS <- 2;
::AREA <- 3;
::ARTICLE <- 4;
::ASIDE <- 5;
::AUDIO <- 6;
::B <- 7;
::BASE <- 8;
::BDI <- 9;
::BDO <- 10;
::BLOCKQUOTE <- 11;
::BODY <- 12;
::BR <- 13;
::BUTTON <- 14;
::CANVAS <- 15;
::CAPTION <- 16;
::CITE <- 17;
::CODE <- 18;
::COL <- 19;
::COLGROUP <- 20;
::DATA <- 21;
::DATALIST <- 22;
::DD <- 23;
::DEL <- 24;
::DETAILS <- 25;
::DFN <- 26;
::DIALOG <- 27;
::DIV <- 28;
::DL <- 29;
::DT <- 30;
::EM <- 31;
::EMBED <- 32;
::FIELDSET <- 33;
::FIGCAPTION <- 34;
::FIGURE <- 35;
::FOOTER <- 36;
::FORM <- 37;
::H1 <- 38;
::H2 <- 39;
::H3 <- 40;
::H4 <- 41;
::H5 <- 42;
::H6 <- 43;
::HEAD <- 44;
::HEADER <- 45;
::HGROUP <- 46;
::HR <- 47;
::HTML <- 48;
::I <- 49;
::IFRAME <- 50;
::IMG <- 51;
::INPUT <- 52;
::INS <- 53;
::KBD <- 54;
::LABEL <- 55;
::LEGEND <- 56;
::LI <- 57;
::LINK <- 58;
::MAIN <- 59;
::MAP <- 60;
::MARK <- 61;
::MATH <- 62;
::MENU <- 63;
::META <- 64;
::METER <- 65;
::NAV <- 66;
::NOSCRIPT <- 67;
::OBJECT <- 68;
::OL <- 69;
::OPTGROUP <- 70;
::OPTION <- 71;
::OUTPUT <- 72;
::P <- 73;
::PICTURE <- 74;
::PRE <- 75;
::PROGRESS <- 76;
::Q <- 77;
::RB <- 78;
::RP <- 79;
::RT <- 80;
::RTC <- 81;
::RUBY <- 82;
::S <- 83;
::SAMP <- 84;
::SCRIPT <- 85;
::SECTION <- 86;
::SELECT <- 87;
::SLOT <- 88;
::SMALL <- 89;
::SOURCE <- 90;
::SPAN <- 91;
::STRONG <- 92;
::STYLE <- 93;
::SUB <- 94;
::SUMMARY <- 95;
::SUP <- 96;
::SVG <- 97;
::TABLE <- 98;
::TBODY <- 99;
::TD <- 100;
::TEMPLATE <- 101;
::TEXTAREA <- 102;
::TFOOT <- 103;
::TH <- 104;
::THEAD <- 105;
::TIME <- 106;
::TITLE <- 107;
::TR <- 108;
::TRACK <- 109;
::U <- 110;
::UL <- 111;
::VAR <- 112;
::VIDEO <- 113;
::WBR <- 114;
::A <- 115;
::TEXT <- 116;

// Used for converting enum to string
::DOM_ELEMENTS <- [
  "UNUSED",
  "ABBR",
  "ADDRESS",
  "AREA",
  "ARTICLE",
  "ASIDE",
  "AUDIO",
  "B",
  "BASE",
  "BDI",
  "BDO",
  "BLOCKQUOTE",
  "BODY",
  "BR",
  "BUTTON",
  "CANVAS",
  "CAPTION",
  "CITE",
  "CODE",
  "COL",
  "COLGROUP",
  "DATA",
  "DATALIST",
  "DD",
  "DEL",
  "DETAILS",
  "DFN",
  "DIALOG",
  "DIV",
  "DL",
  "DT",
  "EM",
  "EMBED",
  "FIELDSET",
  "FIGCAPTION",
  "FIGURE",
  "FOOTER",
  "FORM",
  "H1",
  "H2",
  "H3",
  "H4",
  "H5",
  "H6",
  "HEAD",
  "HEADER",
  "HGROUP",
  "HR",
  "HTML",
  "I",
  "IFRAME",
  "IMG",
  "INPUT",
  "INS",
  "KBD",
  "LABEL",
  "LEGEND",
  "LI",
  "LINK",
  "MAIN",
  "MAP",
  "MARK",
  "MATH",
  "MENU",
  "META",
  "METER",
  "NAV",
  "NOSCRIPT",
  "OBJECT",
  "OL",
  "OPTGROUP",
  "OPTION",
  "OUTPUT",
  "P",
  "PICTURE",
  "PRE",
  "PROGRESS",
  "Q",
  "RB",
  "RP",
  "RT",
  "RTC",
  "RUBY",
  "S",
  "SAMP",
  "SCRIPT",
  "SECTION",
  "SELECT",
  "SLOT",
  "SMALL",
  "SOURCE",
  "SPAN",
  "STRONG",
  "STYLE",
  "SUB",
  "SUMMARY",
  "SUP",
  "SVG",
  "TABLE",
  "TBODY",
  "TD",
  "TEMPLATE",
  "TEXTAREA",
  "TFOOT",
  "TH",
  "THEAD",
  "TIME",
  "TITLE",
  "TR",
  "TRACK",
  "U",
  "UL",
  "VAR",
  "VIDEO",
  "WBR",
  "A"
];

// Used for coloring cubes in-game
// Indices correspond to DOM_ELEMENTS and the enums
::DOM_COLORS <- [
  "120 120 120",
  "100 100 255",   // ABBR - light blue
  "150 75 0",      // ADDRESS - brown
  "0 191 255",     // AREA - sky blue
  "255 228 181",   // ARTICLE - moccasin
  "211 211 211",   // ASIDE - light gray
  "70 130 180",    // AUDIO - steel blue
  "255 0 0",       // B - red (bold)
  "128 0 128",     // BASE - purple
  "105 105 105",   // BDI - dim gray
  "112 128 144",   // BDO - slate gray
  "169 169 169",   // BLOCKQUOTE - dark gray
  "255 255 255",   // BODY - white
  "200 200 200",   // BR - light gray
  "0 128 0",       // BUTTON - green
  "255 165 0",     // CANVAS - orange
  "192 192 192",   // CAPTION - silver
  "138 43 226",    // CITE - blue violet
  "0 0 0",         // CODE - black
  "119 136 153",   // COL - light slate gray
  "105 105 105",   // COLGROUP - dim gray
  "255 215 0",     // DATA - gold
  "255 240 245",   // DATALIST - lavender blush
  "245 245 245",   // DD - white smoke
  "178 34 34",     // DEL - firebrick
  "47 79 79",      // DETAILS - dark slate gray
  "255 250 205",   // DFN - lemon chiffon
  "176 196 222",   // DIALOG - light steel blue
  "220 220 220",   // DIV - gainsboro
  "211 211 211",   // DL - light gray
  "192 192 192",   // DT - silver
  "255 20 147",    // EM - deep pink
  "0 0 139",       // EMBED - dark blue
  "34 139 34",     // FIELDSET - forest green
  "218 112 214",   // FIGCAPTION - orchid
  "186 85 211",    // FIGURE - medium orchid
  "169 169 169",   // FOOTER - dark gray
  "0 100 0",       // FORM - dark green
  "255 0 0",       // H1 - bright red
  "255 69 0",      // H2 - orange red
  "255 140 0",     // H3 - dark orange
  "255 215 0",     // H4 - gold
  "173 255 47",    // H5 - green yellow
  "127 255 0",     // H6 - chartreuse
  "70 130 180",    // HEAD - steel blue
  "105 105 105",   // HEADER - dim gray
  "119 136 153",   // HGROUP - light slate gray
  "128 128 128",   // HR - gray
  "240 248 255",   // HTML - alice blue
  "75 0 130",      // I - indigo
  "0 0 0",         // IFRAME - black
  "255 255 0",     // IMG - yellow
  "173 216 230",   // INPUT - light blue
  "34 139 34",     // INS - forest green
  "255 160 122",   // KBD - light salmon
  "255 222 173",   // LABEL - navajo white
  "176 224 230",   // LEGEND - powder blue
  "255 192 203",   // LI - pink
  "0 0 128",       // LINK - navy
  "240 255 255",   // MAIN - azure
  "124 252 0",     // MAP - lawn green
  "255 255 224",   // MARK - light yellow
  "255 250 250",   // MATH - snow
  "210 180 140",   // MENU - tan
  "135 206 250",   // META - light sky blue
  "60 179 113",    // METER - medium sea green
  "70 130 180",    // NAV - steel blue
  "245 245 220",   // NOSCRIPT - beige
  "255 228 196",   // OBJECT - bisque
  "250 250 210",   // OL - light goldenrod
  "100 149 237",   // OPTGROUP - cornflower blue
  "30 144 255",    // OPTION - dodger blue
  "176 224 230",   // OUTPUT - powder blue
  "255 255 255",   // P - white
  "135 206 235",   // PICTURE - sky blue
  "211 211 211",   // PRE - light gray
  "0 255 127",     // PROGRESS - spring green
  "220 20 60",     // Q - crimson
  "238 130 238",   // RB - violet
  "199 21 133",    // RP - medium violet red
  "255 105 180",   // RT - hot pink
  "219 112 147",   // RTC - pale violet red
  "255 182 193",   // RUBY - light pink
  "192 192 192",   // S - silver
  "255 228 225",   // SAMP - misty rose
  "0 0 0",         // SCRIPT - black
  "245 245 245",   // SECTION - white smoke
  "224 255 255",   // SELECT - light cyan
  "255 248 220",   // SLOT - cornsilk
  "250 235 215",   // SMALL - antique white
  "255 248 220",   // SOURCE - cornsilk
  "255 255 255",   // SPAN - white
  "255 0 0",       // STRONG - red
  "0 0 0",         // STYLE - black
  "102 205 170",   // SUB - medium aquamarine
  "255 239 213",   // SUMMARY - papaya whip
  "0 191 255",     // SUP - deep sky blue
  "0 128 128",     // SVG - teal
  "240 255 255",   // TABLE - azure
  "224 255 255",   // TBODY - light cyan
  "175 238 238",   // TD - pale turquoise
  "255 250 240",   // TEMPLATE - floral white
  "255 239 213",   // TEXTAREA - papaya whip
  "255 245 238",   // TFOOT - seashell
  "245 255 250",   // TH - mint cream
  "240 255 240",   // THEAD - honeydew
  "255 222 173",   // TIME - navajo white
  "0 0 0",         // TITLE - black
  "211 211 211",   // TR - light gray
  "255 255 255",   // TRACK - white
  "128 0 128",     // U - purple
  "240 248 255",   // UL - alice blue
  "0 0 255",       // VAR - blue
  "25 25 112",     // VIDEO - midnight blue
  "211 211 211",   // WBR - light gray
  "0 0 238",       // A - link blue
];

