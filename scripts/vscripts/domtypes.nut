/**
 * Portal 2 DOM Element Type System
 * ===============================
 * This script provides a type system for HTML DOM elements in Portal 2,
 * including color mappings for visual representation in-game.
 * 
 * Features:
 * - Enum-like constants for all HTML5 elements
 * - Color mappings for visual representation
 * - Helper functions for type conversion and validation
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
  "120 120 120",    // UNUSED
  "102 204 255",    // ABBR (Text-level semantics, light blue)
  "153 102 204",    // ADDRESS (Grouping content, purple)
  "255 204 102",    // AREA (Image maps, orange-yellow)
  "255 102 102",    // ARTICLE (Sectioning content, red)
  "255 153 51",     // ASIDE (Sectioning content, orange)
  "0 153 204",      // AUDIO (Media, cool blue)
  "255 51 51",      // B (Text-level semantics, bold red)
  "102 255 102",    // BASE (Document metadata, bright green)
  "51 204 153",     // BDI (Text-level semantics, teal)
  "51 153 204",     // BDO (Text-level semantics, medium blue)
  "204 102 255",    // BLOCKQUOTE (Grouping content, vibrant purple)
  "51 153 51",      // BODY (Document structure, deep green)
  "204 204 204",    // BR (Edits, light gray)
  "255 153 204",    // BUTTON (Forms, pink)
  "255 102 255",    // CANVAS (Graphics, bright pink/purple)
  "102 255 153",    // CAPTION (Table content, mint green)
  "153 51 255",     // CITE (Text-level semantics, dark purple)
  "51 204 255",     // CODE (Text-level semantics, bright cyan)
  "204 153 102",    // COL (Table content, brown-ish)
  "204 102 51",     // COLGROUP (Table content, darker orange)
  "0 204 102",      // DATA (Text-level semantics, emerald green)
  "153 255 51",     // DATALIST (Forms, lime green)
  "255 204 51",     // DD (List content, golden yellow)
  "255 102 153",    // DEL (Edits, raspberry pink)
  "102 153 255",    // DETAILS (Interactive elements, medium blue)
  "153 51 102",     // DFN (Text-level semantics, deep rose)
  "255 51 153",     // DIALOG (Interactive elements, hot pink)
  "153 204 255",    // DIV (Grouping content, soft blue)
  "255 153 102",    // DL (List content, peach)
  "255 102 51",     // DT (List content, vivid orange)
  "204 255 51",     // EM (Text-level semantics, bright yellow-green)
  "51 255 204",     // EMBED (Embedded content, turquoise)
  "255 204 153",    // FIELDSET (Forms, light peach)
  "255 153 153",    // FIGCAPTION (Figure content, light red)
  "255 102 102",    // FIGURE (Figure content, red)
  "102 102 255",    // FOOTER (Sectioning content, medium purple)
  "255 255 102",    // FORM (Forms, bright yellow)
  "255 0 0",        // H1 (Sectioning content, primary red)
  "204 0 0",        // H2 (Sectioning content, slightly darker red)
  "153 0 0",        // H3 (Sectioning content, even darker red)
  "102 0 0",        // H4 (Sectioning content, darker red)
  "51 0 0",         // H5 (Sectioning content, deep red)
  "0 0 0",          // H6 (Sectioning content, black for contrast)
  "153 255 153",    // HEAD (Document metadata, light green)
  "102 255 102",    // HEADER (Sectioning content, bright green)
  "51 255 51",      // HGROUP (Sectioning content, vivid green)
  "102 102 102",    // HR (Edits, dark gray)
  "51 102 51",      // HTML (Document structure, dark green)
  "153 51 153",     // I (Text-level semantics, purple-pink)
  "51 153 255",     // IFRAME (Embedded content, sky blue)
  "0 204 204",      // IMG (Embedded content, cyan)
  "255 255 0",      // INPUT (Forms, yellow)
  "102 255 204",    // INS (Edits, light teal)
  "255 153 51",     // KBD (Text-level semantics, orange)
  "255 102 51",     // LABEL (Forms, vivid orange)
  "255 51 102",     // LEGEND (Forms, deep pink)
  "51 153 102",     // LI (List content, green-teal)
  "51 51 204",      // LINK (Document metadata, deep blue)
  "255 153 0",      // MAIN (Sectioning content, dark orange)
  "204 255 102",    // MAP (Image maps, lime yellow)
  "255 255 153",    // MARK (Text-level semantics, light yellow)
  "153 102 255",    // MATH (Embedded content, vibrant purple)
  "102 204 153",    // MENU (List content, grayish green)
  "204 102 204",    // META (Document metadata, medium purple)
  "102 255 51",     // METER (Forms, bright green)
  "0 102 255",      // NAV (Sectioning content, bright blue)
  "255 51 51",      // NOSCRIPT (Scripting, red)
  "204 51 255",     // OBJECT (Embedded content, bright purple)
  "102 153 51",     // OL (List content, olive green)
  "102 102 51",     // OPTGROUP (Forms, dark olive)
  "153 153 51",     // OPTION (Forms, medium olive)
  "255 204 51",     // OUTPUT (Forms, golden yellow)
  "102 102 255",    // P (Grouping content, medium purple)
  "0 153 153",      // PICTURE (Embedded content, deep teal)
  "51 51 153",      // PRE (Text-level semantics, dark blue-purple)
  "51 255 153",     // PROGRESS (Forms, vivid green)
  "255 51 204",     // Q (Text-level semantics, fuchsia)
  "255 102 102",    // RB (Ruby annotation, red)
  "255 153 102",    // RP (Ruby annotation, peach)
  "255 204 102",    // RT (Ruby annotation, orange-yellow)
  "255 51 51",      // RTC (Ruby annotation, red)
  "204 51 51",      // RUBY (Ruby annotation, darker red)
  "255 102 153",    // S (Text-level semantics, raspberry pink)
  "153 51 51",      // SAMP (Text-level semantics, dark red)
  "255 51 255",     // SCRIPT (Scripting, bright pink/purple)
  "0 204 51",       // SECTION (Sectioning content, vivid green)
  "102 153 204",    // SELECT (Forms, grayish blue)
  "255 153 204",    // SLOT (Web Components, pink)
  "153 204 255",    // SMALL (Text-level semantics, soft blue)
  "0 255 255",      // SOURCE (Media, bright cyan)
  "255 0 255",      // SPAN (Text-level semantics, magenta)
  "204 0 204",      // STRONG (Text-level semantics, dark magenta)
  "255 102 204",    // STYLE (Document metadata, vibrant pink)
  "102 153 255",    // SUB (Text-level semantics, medium blue)
  "255 153 102",    // SUMMARY (Interactive elements, peach)
  "102 204 255",    // SUP (Text-level semantics, light blue)
  "255 255 51",     // SVG (Graphics, vibrant yellow)
  "102 51 0",       // TABLE (Table content, dark brown)
  "153 102 51",     // TBODY (Table content, medium brown)
  "204 153 102",    // TD (Table content, lighter brown)
  "51 255 102",     // TEMPLATE (Scripting, bright green)
  "204 102 153",    // TEXTAREA (Forms, dusty pink)
  "102 102 51",     // TFOOT (Table content, dark olive)
  "51 51 0",        // TH (Table content, very dark olive)
  "51 51 0",        // THEAD (Table header, very dark olive)
  "102 51 204",     // TIME (Text-level semantics, deep purple)
  "51 102 153",     // TITLE (Document metadata, grayish blue)
  "153 51 0",       // TR (Table content, dark orange-brown)
  "51 204 102",     // TRACK (Media, emerald green)
  "204 102 255",    // U (Text-level semantics, vibrant purple)
  "51 102 102",     // UL (List content, dark teal)
  "153 51 102",     // VAR (Text-level semantics, deep rose)
  "0 102 204",      // VIDEO (Media, cool blue)
  "204 204 204",    // WBR (Text-level semantics, light gray)
  "0 0 255"         // A (Text-level semantics, primary blue)
];

/**
 * Helper Functions
 * ===============
 */

/**
 * Converts a DOM element type to its string representation
 * @param type The numeric DOM element type
 * @return The string name of the element
 */
function GetElementName(type) {
    if (type < 0) {
        return "/" + DOM_ELEMENTS[-type];
    }
    return DOM_ELEMENTS[type];
}

/**
 * Gets the color for a DOM element type
 * @param type The numeric DOM element type
 * @return The RGB color string
 */
function GetElementColor(type) {
    if (type < 0) {
        return DOM_COLORS[-type];
    }
    return DOM_COLORS[type];
}

/**
 * Checks if a type represents a closing tag
 * @param type The numeric DOM element type
 * @return True if it's a closing tag
 */
function IsClosingTag(type) {
    return type < 0;
}

/**
 * Gets the corresponding opening tag for a closing tag
 * @param type The numeric DOM element type
 * @return The opening tag type
 */
function GetOpeningTag(type) {
    return -type;
}

/**
 * Gets the corresponding closing tag for an opening tag
 * @param type The numeric DOM element type
 * @return The closing tag type
 */
function GetClosingTag(type) {
    return -type;
}

