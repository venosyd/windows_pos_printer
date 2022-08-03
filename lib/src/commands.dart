///
/// esc_pos_utils
/// Created by Andrey U.
///
/// Copyright (c) 2019-2020. All rights reserved.
/// See LICENSE for distribution and usage details.
///
library windows_pos_print.commands;

///
const esc = '\x1B';

///
const gs = '\x1D';

///
const fs = '\x1C';

// Miscellaneous

/// Initialize printer
const cInit = '$esc@';

/// Beeper [count] [duration]
const cBeep = '${esc}B';

// Mech. Control

/// Full cut
const cCutFull = '${gs}V0';

/// Partial cut
const cCutPart = '${gs}V1';

// Character

/// Turn white/black reverse print mode on
const cReverseOn = '${gs}B\x01';

/// Turn white/black reverse print mode off
const cReverseOff = '${gs}B\x00';

/// Select character size [N]
const cSizeGSn = '$gs!';

/// Select character size [N]
const cSizeESCn = '$esc!';

/// Turns off underline mode
const cUnderlineOff = '$esc-\x00';

/// Turns on underline mode (1-dot thick)
const cUnderline1dot = '$esc-\x01';

/// Turns on underline mode (2-dots thick)
const cUnderline2dots = '$esc-\x02';

/// Turn emphasized mode on
const cBoldOn = '${esc}E\x01';

/// Turn emphasized mode off
const cBoldOff = '${esc}E\x00';

/// Font A
const cFontA = '${esc}M\x00';

/// Font B
const cFontB = '${esc}M\x01';

/// Turn 90° clockwise rotation mode on
const cTurn90On = '${esc}V\x01';

/// Turn 90° clockwise rotation mode off
const cTurn90Off = '${esc}V\x00';

/// Select character code table [N]
const cCodeTable = '${esc}t';

/// Select Kanji character mode
const cKanjiOn = '$fs&';

/// Cancel Kanji character mode
const cKanjiOff = '$fs.';

// Print Position

/// Left justification
const cAlignLeft = '${esc}a0';

/// Centered
const cAlignCenter = '${esc}a1';

/// Right justification
const cAlignRight = '${esc}a2';

/// Set absolute print position [nL] [nH]
const cPos = '$esc\$';

// Print

/// Print and feed n lines [N]
const cFeedN = '${esc}d';

/// Print and reverse feed n lines [N]
const cReverseFeedN = '${esc}e';

// Bit Image

/// Print image - raster bit format (graphics)
const cRasterImg = '$gs(L';

/// Print image - raster bit format (bitImageRaster) [obsolete]
const cRasterImg2 = '${gs}v0';

/// Print image - column format
const cBitImg = '$esc*';

// Barcode

/// Select print position of HRI characters [N]
const cBarcodeSelectPos = '${gs}H';

/// Select font for HRI characters [N]
const cBarcodeSelectFont = '${gs}f';

/// Set barcode height [N]
const cBarcodeSetH = '${gs}h';

/// Set barcode width [N]
const cBarcodeSetW = '${gs}w';

/// Print barcode
const cBarcodePrint = '${gs}k';

// Cash Drawer Open

///
const cCashDrawerPin2 = '${esc}p030';

///
const cCashDrawerPin5 = '${esc}p130';

/// QR Code
const cQrHeader = '$gs(k';
