<?php

/**
* LODEL: Transforme une chaine de caractère UTF8 en minuscules désaccentuées
*
* Cette fonction prends en entrée une chaîne en UTF8 et donne en sortie une chaîne
* o les accents ont été remplacés par leur équivalent désaccentué. De plus les caractères
* sont mis en minuscules et les espaces en début et fin de chaine sont enlevés.
*
* Cette fonction est utilisée pour les entrees d'index ainsi que dans le moteur de recherche
* et pour le calcul des identifiants littéraux.
*
* @param string $text le texte à passer en entrée
* @return le texte transformé en minuscule
*/
function _makeSortKey($text)
{
    $text = strip_tags($text);
    //remplacement des caractères accentues en UTF8
    $replacement = array(
                            chr(194).chr(165) => 'Y', chr(194).chr(181) => 'u',
                            
                            chr(195).chr(128) => 'A',
                            chr(195).chr(129) => 'A', chr(195).chr(130) => 'A',
                            chr(195).chr(131) => 'A', chr(195).chr(132) => 'A',
                            chr(195).chr(133) => 'A', chr(195).chr(134) => 'AE',
                            chr(195).chr(135) => 'C', chr(195).chr(136) => 'E',
                            chr(195).chr(137) => 'E', chr(195).chr(138) => 'E',
                            chr(195).chr(139) => 'E', chr(195).chr(140) => 'I',
                            chr(195).chr(141) => 'I', chr(195).chr(142) => 'I',
                            chr(195).chr(143) => 'I', chr(195).chr(144) => 'D',
                            chr(195).chr(145) => 'N', chr(195).chr(146) => 'O',
                            chr(195).chr(147) => 'O', chr(195).chr(148) => 'O',
                            chr(195).chr(149) => 'O', chr(195).chr(150) => 'O',
                            chr(195).chr(152) => 'O', chr(195).chr(153) => 'U',
                            chr(195).chr(154) => 'U', chr(195).chr(155) => 'U',
                            chr(195).chr(156) => 'U', chr(195).chr(157) => 'Y',
                            chr(195).chr(159) => 'SS', chr(195).chr(160) => 'a',
                            chr(195).chr(161) => 'a', chr(195).chr(162) => 'a',
                            chr(195).chr(163) => 'a', chr(195).chr(164) => 'a',
                            chr(195).chr(165) => 'a', chr(195).chr(166) => 'ae',
                            chr(195).chr(167) => 'c', chr(195).chr(168) => 'e',
                            chr(195).chr(169) => 'e', chr(195).chr(170) => 'e',
                            chr(195).chr(171) => 'e', chr(195).chr(172) => 'i',
                            chr(195).chr(173) => 'i', chr(195).chr(174) => 'i',
                            chr(195).chr(175) => 'i', chr(195).chr(176) => 'o',
                            chr(195).chr(177) => 'n', chr(195).chr(178) => 'o',
                            chr(195).chr(179) => 'o', chr(195).chr(180) => 'o',
                            chr(195).chr(181) => 'o', chr(195).chr(182) => 'o',
                            chr(195).chr(184) => 'o', chr(195).chr(185) => 'u',
                            chr(195).chr(186) => 'u', chr(195).chr(187) => 'u',
                            chr(195).chr(188) => 'u', chr(195).chr(189) => 'y',
                            chr(195).chr(191) => 'y',

                            chr(196).chr(128) => 'A', chr(196).chr(129) => 'a',
                            chr(196).chr(130) => 'A', chr(196).chr(131) => 'a',
                            chr(196).chr(132) => 'A', chr(196).chr(133) => 'a',
                            chr(196).chr(134) => 'C', chr(196).chr(135) => 'c',
                            chr(196).chr(136) => 'C', chr(196).chr(137) => 'c',
                            chr(196).chr(138) => 'C', chr(196).chr(139) => 'c',
                            chr(196).chr(140) => 'C', chr(196).chr(141) => 'c',
                            chr(196).chr(142) => 'D', chr(196).chr(143) => 'd',
                            chr(196).chr(144) => 'D', chr(196).chr(145) => 'd',
                            chr(196).chr(146) => 'E', chr(196).chr(147) => 'e',
                            chr(196).chr(148) => 'E', chr(196).chr(149) => 'e',
                            chr(196).chr(150) => 'E', chr(196).chr(151) => 'e',
                            chr(196).chr(152) => 'E', chr(196).chr(153) => 'e',
                            chr(196).chr(154) => 'E', chr(196).chr(155) => 'e',
                            chr(196).chr(156) => 'G', chr(196).chr(157) => 'g',
                            chr(196).chr(158) => 'G', chr(196).chr(159) => 'g',
                            chr(196).chr(160) => 'G', chr(196).chr(161) => 'g',
                            chr(196).chr(162) => 'G', chr(196).chr(163) => 'g',
                            chr(196).chr(164) => 'H', chr(196).chr(165) => 'h',
                            chr(196).chr(166) => 'H', chr(196).chr(167) => 'h',
                            chr(196).chr(168) => 'I', chr(196).chr(169) => 'i',
                            chr(196).chr(170) => 'I', chr(196).chr(171) => 'i',
                            chr(196).chr(172) => 'I', chr(196).chr(173) => 'i',
                            chr(196).chr(174) => 'I', chr(196).chr(175) => 'i',
                            chr(196).chr(176) => 'I', chr(196).chr(177) => 'i',
                            chr(196).chr(178) => 'IJ', chr(196).chr(179) => 'ij',
                            chr(196).chr(180) => 'J', chr(196).chr(181) => 'j',
                            chr(196).chr(182) => 'K', chr(196).chr(183) => 'k',
                            chr(196).chr(184) => 'K', chr(196).chr(185) => 'L',
                            chr(196).chr(186) => 'l', chr(196).chr(187) => 'L',
                            chr(196).chr(188) => 'l', chr(196).chr(189) => 'L',
                            chr(196).chr(190) => 'l', chr(196).chr(191) => 'L',

                            chr(197).chr(128) => 'l', chr(197).chr(129) => 'L',
                            chr(197).chr(130) => 'l', chr(197).chr(131) => 'N',
                            chr(197).chr(132) => 'n', chr(197).chr(133) => 'N',
                            chr(197).chr(134) => 'n', chr(197).chr(135) => 'N',
                            chr(197).chr(136) => 'n', chr(197).chr(137) => 'n',
                            chr(197).chr(138) => 'N', chr(197).chr(139) => 'n',
                            chr(197).chr(140) => 'O', chr(197).chr(141) => 'o',
                            chr(197).chr(142) => 'O', chr(197).chr(143) => 'o',
                            chr(197).chr(144) => 'O', chr(197).chr(145) => 'o',
                            chr(197).chr(146) => 'OE', chr(197).chr(147) => 'oe',
                            chr(197).chr(148) => 'R', chr(197).chr(149) => 'r',
                            chr(197).chr(150) => 'R', chr(197).chr(151) => 'r',
                            chr(197).chr(152) => 'R', chr(197).chr(153) => 'r',
                            chr(197).chr(154) => 'S', chr(197).chr(155) => 's',
                            chr(197).chr(156) => 'S', chr(197).chr(157) => 's',
                            chr(197).chr(158) => 'S', chr(197).chr(159) => 's',
                            chr(197).chr(160) => 'S', chr(197).chr(161) => 's',
                            chr(197).chr(162) => 'T', chr(197).chr(163) => 't',
                            chr(197).chr(164) => 'T', chr(197).chr(165) => 't',
                            chr(197).chr(166) => 'T', chr(197).chr(167) => 't',
                            chr(197).chr(168) => 'U', chr(197).chr(169) => 'u',
                            chr(197).chr(170) => 'U', chr(197).chr(171) => 'u',
                            chr(197).chr(172) => 'U', chr(197).chr(173) => 'u',
                            chr(197).chr(174) => 'U', chr(197).chr(175) => 'u',
                            chr(197).chr(176) => 'U', chr(197).chr(177) => 'u',
                            chr(197).chr(178) => 'U', chr(197).chr(179) => 'u',
                            chr(197).chr(180) => 'W', chr(197).chr(181) => 'w',
                            chr(197).chr(182) => 'Y', chr(197).chr(183) => 'y',
                            chr(197).chr(184) => 'Y', chr(197).chr(185) => 'Z',
                            chr(197).chr(186) => 'z', chr(197).chr(187) => 'Z',
                            chr(197).chr(188) => 'z', chr(197).chr(189) => 'Z',
                            chr(197).chr(190) => 'z', chr(197).chr(191) => 'z',

                    );
    $text = strtr($text,$replacement);
    return trim( mb_strtolower($text, "UTF-8"));
}


function _windobclean($str) {
    $replace = array (
                    "\xc2\x80" => "\xe2\x82\xac", /* EURO SIGN */
                    "\xc2\x81" => "",
                    "\xc2\x82" => "\xe2\x80\x9a", /* SINGLE LOW-9 QUOTATION MARK */
                    "\xc2\x83" => "\xc6\x92",     /* LATIN SMALL LETTER F WITH HOOK */
                    "\xc2\x84" => "\xe2\x80\x9e", /* DOUBLE LOW-9 QUOTATION MARK */
                    "\xc2\x85" => "\xe2\x80\xa6", /* HORIZONTAL ELLIPSIS */
                    "\xc2\x86" => "\xe2\x80\xa0", /* DAGGER */
                    "\xc2\x87" => "\xe2\x80\xa1", /* DOUBLE DAGGER */
                    "\xc2\x88" => "\xcb\x86",     /* MODIFIER LETTER CIRCUMFLEX ACCENT */
                    "\xc2\x89" => "\xe2\x80\xb0", /* PER MILLE SIGN */
                    "\xc2\x8a" => "\xc5\xa0",     /* LATIN CAPITAL LETTER S WITH CARON */
                    "\xc2\x8b" => "\xe2\x80\xb9", /* SINGLE LEFT-POINTING ANGLE QUOTATION */
                    "\xc2\x8c" => "\xc5\x92",     /* LATIN CAPITAL LIGATURE OE */
                    "\xc2\x8d" => "",
                    "\xc2\x8e" => "\xc5\xbd",     /* LATIN CAPITAL LETTER Z WITH CARON */
                    "\xc2\x8f" => "",
                    "\xc2\x90" => "",
                    "\xc2\x91" => "\xe2\x80\x98", /* LEFT SINGLE QUOTATION MARK */
                    "\xc2\x92" => "\xe2\x80\x99", /* RIGHT SINGLE QUOTATION MARK */
                    "\xc2\x93" => "\xe2\x80\x9c", /* LEFT DOUBLE QUOTATION MARK */
                    "\xc2\x94" => "\xe2\x80\x9d", /* RIGHT DOUBLE QUOTATION MARK */
                    "\xc2\x95" => "\xe2\x80\xa2", /* BULLET */
                    "\xc2\x96" => "\xe2\x80\x93", /* EN DASH */
                    "\xc2\x97" => "\xe2\x80\x94", /* EM DASH */
                    "\xc2\x98" => "\xcb\x9c",     /* SMALL TILDE */
                    "\xc2\x99" => "\xe2\x84\xa2", /* TRADE MARK SIGN */
                    "\xc2\x9a" => "\xc5\xa1",     /* LATIN SMALL LETTER S WITH CARON */
                    "\xc2\x9b" => "\xe2\x80\xba", /* SINGLE RIGHT-POINTING ANGLE QUOTATION*/
                    "\xc2\x9c" => "\xc5\x93",     /* LATIN SMALL LIGATURE OE */
                    "\xc2\x9e" => "\xc5\xbe",     /* LATIN SMALL LETTER Z WITH CARON */
                    "\xc2\x9f" => "\xc5\xb8",      /* LATIN CAPITAL LETTER Y WITH DIAERESIS*/
                    '&#39;'    => "'",
            );

    return strtr($str, $replace);
}

?>