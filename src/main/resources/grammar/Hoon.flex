package com.ashelkov.hoon.plugin;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.intellij.psi.TokenType;

import com.ashelkov.hoon.plugin.psi.HoonTypes;

//
// https://jflex.de/manual.html
//

%%

%class HoonLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

%{
    int selCount = 0;
%}

//
// SPACING & DOCUMENTATION STRUCTURES
//

// GAP
newline = \R
two_spaces = " "{2}
gap = ({newline} | {two_spaces}) ({newline} | " ")*

// COMMENT
comment = "::" .*

//
// LITERALS
//

// LOOBEAN
loobean = "%.y" | "%.n"

// UNSIGNED DECIMAL
zero = "0"
decimal = [0-9]
nonzero_decimal = [1-9]
three_digit_decimal = {nonzero_decimal} {decimal}{0,2}
hoon_decimal = {three_digit_decimal} ("." ({newline} " "*)? {decimal}{3})+
unsigned_decimal = {zero} | {hoon_decimal}

// UNSIGNED BINARY
binary = [01]
hoon_binary = "1" {binary}{0,3} ("." ({newline} " "*)? {binary}{4})*
unsigned_binary = "0b" ({zero} | {hoon_binary})

// UNSIGNED HEXADECIMAL
hexadecimal = [0-9a-fA-F]
nonzero_hexadecimal = [1-9a-fA-F]
hoon_hex_block = {nonzero_hexadecimal} {hexadecimal}{0,3}
hoon_hex = {hoon_hex_block} ("." ({newline} " "*)? {hexadecimal}{4})*
unsigned_hex = "0x" ({zero} | {hoon_hex})

// UNSIGNED BASE32
base32 = [0-9a-v]
nonzero_base32 = [1-9a-v]
hoon_base32 = {nonzero_base32} {base32}{0,4} ("." ({newline} " "*)? {base32}{5})*
unsigned_base32 = "0v" ({zero} | {hoon_base32})

// UNSIGNED BASE58
base58 = [[0-9]||[[a-z]--l]||[[A-Z]--[IO]]]
unsigned_base58 = "0c" {base58}+

// UNSIGNED BASE64
base64 = [0-9a-zA-Z~\-]
nonzero_base64 = [1-9a-zA-Z~\-]
hoon_base64 = {nonzero_base64} {base64}{0,4} ("." ({newline} " "*)? {base64}{5})*
unsigned_base64 = "0w" ({zero} | {hoon_base64})

// SIGNED DECIMAL
signed_decimal = "-"{1,2} ({three_digit_decimal} | {unsigned_decimal})

// SIGNED BINARY
signed_binary = "-"{1,2} {unsigned_binary}

// SIGNED HEXADECIMAL
signed_hex = "-"{1,2} {unsigned_hex}

// SIGNED BASE32
signed_base32 = "-"{1,2} {unsigned_base32}

// SIGNED BASE58
signed_base58 = "-"{1,2} {unsigned_base58}

// SIGNED BASE64
signed_base64 = "-"{1,2} {unsigned_base64}

// FLOAT
nonzero_decimal_number = {nonzero_decimal} {decimal}*
any_decimal = {zero} | {nonzero_decimal_number}
floating_point = "-"? {any_decimal} ("." {decimal}+)? ("e" "-"? {any_decimal})?
not_a_number = "nan"
infinity = "inf"
special_floats = {not_a_number} | ("-"? {infinity})
hoon_float = {special_floats} | {floating_point}
single_precision_float = "." {hoon_float}

// DOUBLE
double_precision_float = ".~" {hoon_float}

// HALF
half_precision_float = ".~~" {hoon_float}

// QUAD
quad_precision_float = ".~~~" {hoon_float}

// KNOT
knot_alphabet = [0-9a-z~\.\-]
knot = "~." {knot_alphabet}*

// CORD
string_hex_alphabet = [0-9a-fA-F]
string_hex_digit = \\ {string_hex_alphabet}{2}
cord_alphabet = [^\\'\r\n\u2028\u2029\u000B\u000C\u0085] | (\\\\) | (\\') | {string_hex_digit}

// TERM
term_alphabet = [0-9a-z\-]
term_text = [a-z] {term_alphabet}*
term = "%" {term_text}

// TAPE
tape_alphabet = [^\\\{\"\r\n\u2028\u2029\u000B\u000C\u0085] | (\\\\) | (\\\{) | (\\\") | {string_hex_digit}
tape_interpol_text = [^\}\r\n\u2028\u2029\u000B\u000C\u0085]

// SHIP
vowel = [aeiouy]
consonant = [[a-z]--[aeiouy]]
phoneme = {consonant} {vowel} {consonant}
phoneme_pair = {phoneme}{2}
phoneme_quad = {phoneme_pair} "-" {phoneme_pair}
phoneme_oct = {phoneme_quad} "-" {phoneme_quad}
phoneme_chain = {phoneme_oct} ("--" {phoneme_oct})+
celestial_body = {phoneme} | {phoneme_pair} | {phoneme_quad} | {phoneme_oct} | {phoneme_chain}
ship = "~" {celestial_body}

// UNSCRAMBLED_PHONEMES
unscrambled_ship = "." {ship}

// IPV4
tens = {nonzero_decimal} {decimal}
one_hundreds = "1" {decimal} {decimal}
low_two_hundreds = "2" [0-4] {decimal}
two_hundreds_limit = "25" [0-5]
limit_255 = {decimal} | {tens} | {one_hundreds} | {low_two_hundreds} | {two_hundreds_limit}
ipv4_block = "." {limit_255}
ipv4 = {ipv4_block}{4}

// IPV6
ipv6_hex_block = "0" | {hoon_hex_block}
ipv6_block = "." {ipv6_hex_block}
ipv6 = {ipv6_block}{4}

// ABSOLUTE DATE
month = {nonzero_decimal} | ("1" [0-2])
day = {nonzero_decimal} | ([12] {decimal}) | ("3" [01])
hour = ([01] {decimal}) | ("2" [0-3])
min_or_sec = [0-5] {decimal}
date_block = {nonzero_decimal_number} "." {month} "." {day}
time_block = {hour} "." {min_or_sec} "." {min_or_sec}
millisecond_block = ".." {hexadecimal}{4}
absolute_date = "~" {date_block} (".." {time_block} {millisecond_block}?)?

// RELATIVE DATE
day_block = "d" {any_decimal}
hour_block = "h" {any_decimal}
minute_block = "m" {any_decimal}
second_block = "s" {any_decimal}
relative_date_block = {day_block} | {hour_block} | {minute_block} | {second_block}
relative_date = "~" {relative_date_block} ("." {relative_date_block})* {millisecond_block}?

// UNICODE CODEPOINT
unicode_point = "~" {hexadecimal}+ "."
unicode_text = [0-9a-z_\.\-]+
unicode_codepoint = "~-" ({unicode_point} | {unicode_text})?

// AURA
// Currently, auras can be whatever you want. The pretty printer does a prefix match, and the type checker has generic
// nesting rules.

//aura_unicode = "c"
//aura_date = "d" [ar]?
//aura_ip = "i" [fs]?
//aura_ship = "p" | "q"
//aura_float = "r" [hsdq]?
//aura_signed_num = "s" [bcdvwx]?
//aura_unsigned_num = "u" [bcdvwx]?
//aura_text = "t" ("a" "s"?)?
//aura_keyword = {aura_unicode} | {aura_date} | {aura_ip} | {aura_ship} | {aura_float} | {aura_signed_num} |
//               {aura_unsigned_num} | {aura_text}

lowercase_text = [a-z]
uppercase_text = [A-Z]
aura_plain = "@" {lowercase_text}+ {uppercase_text}*
aura_width_only = "@" {uppercase_text}+
aura = {aura_plain} | {aura_width_only}

// CHUM
chum = {term} "." {nonzero_decimal_number}

// CONSTANT
all_numeric = {three_digit_decimal} | {unsigned_decimal} | {unsigned_binary} | {unsigned_hex} | {unsigned_base32} |
              {unsigned_base58} | {unsigned_base64} | {signed_decimal} | {signed_binary} | {signed_hex} |
              {signed_base32} | {signed_base58} | {signed_base64} | {single_precision_float} |
              {double_precision_float} | {half_precision_float} | {quad_precision_float}
simplest_cord = "'" {cord_alphabet}* "'"
constant_component = {all_numeric} | {simplest_cord} | {ship} | {unscrambled_ship} | {ipv4} | {ipv6} | {absolute_date} |
                     {relative_date} | {unicode_codepoint} | "|" | "$" | "&" | "~"
constant = "%" {constant_component}

//
// IDENTIFIERS
//

// SKIN
skin = {term_text}

// CAMEL_CASE_SKIN
camel_case_skin = {lowercase_text} ({lowercase_text} | {uppercase_text})*

//
// EXPRESSION FRAGMENTS
//

// CASK HEADER
cask_mark = {three_digit_decimal} | {unsigned_decimal} | {skin} | "|" | "$" | "&"
cask_header = {cask_mark} ("+" | "/")

// FACE ASSIGNMENT
face_assignment = {skin} "="

face_block_type = {term} | {constant} | {aura} | "^" | "@" | "~" | "*" | "?"
face_block_input = {skin} | {face_block_type}
explicit_face_assignment = ({skin} "=")+ {face_block_input}
default_face_assignment = "=" ({skin} "=")* {face_block_type}
face_block_component = {explicit_face_assignment} | {default_face_assignment} | {face_block_input}

non_block_alphabet = [^\[\]\r\n\u2028\u2029\u000B\u000C\u0085]
face_block_lookahead = ({non_block_alphabet}+ | (({non_block_alphabet}* \[ .+ \])+ {non_block_alphabet}*)) "]="

// PATHS
path_component = {all_numeric} | {ship} | {unscrambled_ship} | {absolute_date} | {relative_date} | {ipv4} | {ipv6} |
                 {unicode_codepoint} | {simplest_cord} | {knot} | {skin} | "$" | "~"
simple_path = ("/"+ {path_component})+
path_fragment = {simple_path} "/"+

//
// RUNE TOKENIZATION HELPERS
//

rune_trailer = {newline} | "  " | "::" | \(

//
// STATES
//

%state CORD
%state MULTI_CORD

%state TAPE
%state TAPE_INTERPOL
%state MULTI_TAPE

%state FACE_BLOCK
%state FACE_BLOCK_CLOSE

%%

// TODO: larks as tokens?
// TODO: tree addresses as tokens?

<YYINITIAL> {
    "/$" / {rune_trailer}       { return HoonTypes.FASBUC; }
    "/%" / {rune_trailer}       { return HoonTypes.FASCEN; }
    "/-" / {rune_trailer}       { return HoonTypes.FASHEP; }
    "/+" / {rune_trailer}       { return HoonTypes.FASLUS; }
    "/~" / {rune_trailer}       { return HoonTypes.FASSIG; }
    "/*" / {rune_trailer}       { return HoonTypes.FASTAR; }
    "/=" / {rune_trailer}       { return HoonTypes.FASTIS; }
    "/?" / {rune_trailer}       { return HoonTypes.FASWUT; }

    ".^" / {rune_trailer}       { return HoonTypes.DOTKET; }
    ".+" / {rune_trailer}       { return HoonTypes.DOTLUS; }
    ".*" / {rune_trailer}       { return HoonTypes.DOTTAR; }
    ".=" / {rune_trailer}       { return HoonTypes.DOTTIS; }
    ".?" / {rune_trailer}       { return HoonTypes.DOTWUT; }

    "!:" / {rune_trailer}       { return HoonTypes.ZAPCOL; }
    "!," / {rune_trailer}       { return HoonTypes.ZAPCOM; }
    "!." / {rune_trailer}       { return HoonTypes.ZAPDOT; }
    "!<" / {rune_trailer}       { return HoonTypes.ZAPGAL; }
    "!>" / {rune_trailer}       { return HoonTypes.ZAPGAR; }
    "!;" / {rune_trailer}       { return HoonTypes.ZAPMIC; }
    "!@" / {rune_trailer}       { return HoonTypes.ZAPPAT; }
    "!=" / {rune_trailer}       { return HoonTypes.ZAPTIS; }
    "!?" / {rune_trailer}       { return HoonTypes.ZAPWUT; }
    "!!"                        { return HoonTypes.ZAPZAP; }

    "=|" / {rune_trailer}       { return HoonTypes.TISBAR; }
    "=:" / {rune_trailer}       { return HoonTypes.TISCOL; }
    "=," / {rune_trailer}       { return HoonTypes.TISCOM; }
    "=." / {rune_trailer}       { return HoonTypes.TISDOT; }
    "=/" / {rune_trailer}       { return HoonTypes.TISFAS; }
    "=<" / {rune_trailer}       { return HoonTypes.TISGAL; }
    "=>" / {rune_trailer}       { return HoonTypes.TISGAR; }
    "=-" / {rune_trailer}       { return HoonTypes.TISHEP; }
    "=^" / {rune_trailer}       { return HoonTypes.TISKET; }
    "=+" / {rune_trailer}       { return HoonTypes.TISLUS; }
    "=;" / {rune_trailer}       { return HoonTypes.TISMIC; }
    "=~" / {rune_trailer}       { return HoonTypes.TISSIG; }
    "=*" / {rune_trailer}       { return HoonTypes.TISTAR; }
    "=?" / {rune_trailer}       { return HoonTypes.TISWUT; }

    "?|" / {rune_trailer}       { return HoonTypes.WUTBAR; }
    "?:" / {rune_trailer}       { return HoonTypes.WUTCOL; }
    "?." / {rune_trailer}       { return HoonTypes.WUTDOT; }
    "?<" / {rune_trailer}       { return HoonTypes.WUTGAL; }
    "?>" / {rune_trailer}       { return HoonTypes.WUTGAR; }
    "?-" / {rune_trailer}       { return HoonTypes.WUTHEP; }
    "?^" / {rune_trailer}       { return HoonTypes.WUTKET; }
    "?+" / {rune_trailer}       { return HoonTypes.WUTLUS; }
    "?&" / {rune_trailer}       { return HoonTypes.WUTPAM; }
    "?@" / {rune_trailer}       { return HoonTypes.WUTPAT; }
    "?~" / {rune_trailer}       { return HoonTypes.WUTSIG; }
    "?=" / {rune_trailer}       { return HoonTypes.WUTTIS; }
    "?!" / {rune_trailer}       { return HoonTypes.WUTZAP; }

    "|$" / {rune_trailer}       { return HoonTypes.BARBUC; }
    "|_" / {rune_trailer}       { return HoonTypes.BARCAB; }
    "|%" / {rune_trailer}       { return HoonTypes.BARCEN; }
    "|:" / {rune_trailer}       { return HoonTypes.BARCOL; }
    "|." / {rune_trailer}       { return HoonTypes.BARDOT; }
    "|-" / {rune_trailer}       { return HoonTypes.BARHEP; }
    "|^" / {rune_trailer}       { return HoonTypes.BARKET; }
    "|@" / {rune_trailer}       { return HoonTypes.BARPAT; }
    "|~" / {rune_trailer}       { return HoonTypes.BARSIG; }
    "|*" / {rune_trailer}       { return HoonTypes.BARTAR; }
    "|=" / {rune_trailer}       { return HoonTypes.BARTIS; }
    "|?" / {rune_trailer}       { return HoonTypes.BARWUT; }

    ":_" / {rune_trailer}       { return HoonTypes.COLCAB; }
    ":-" / {rune_trailer}       { return HoonTypes.COLHEP; }
    ":^" / {rune_trailer}       { return HoonTypes.COLKET; }
    ":+" / {rune_trailer}       { return HoonTypes.COLLUS; }
    ":~" / {rune_trailer}       { return HoonTypes.COLSIG; }
    ":*" / {rune_trailer}       { return HoonTypes.COLTAR; }

    "%_" / {rune_trailer}       { return HoonTypes.CENCAB; }
    "%:" / {rune_trailer}       { return HoonTypes.CENCOL; }
    "%." / {rune_trailer}       { return HoonTypes.CENDOT; }
    "%-" / {rune_trailer}       { return HoonTypes.CENHEP; }
    "%^" / {rune_trailer}       { return HoonTypes.CENKET; }
    "%+" / {rune_trailer}       { return HoonTypes.CENLUS; }
    "%~" / {rune_trailer}       { return HoonTypes.CENSIG; }
    "%*" / {rune_trailer}       { return HoonTypes.CENTAR; }
    "%=" / {rune_trailer}       { return HoonTypes.CENTIS; }

    "^|" / {rune_trailer}       { return HoonTypes.KETBAR; }
    "^:" / {rune_trailer}       { return HoonTypes.KETCOL; }
    "^." / {rune_trailer}       { return HoonTypes.KETDOT; }
    "^-" / {rune_trailer}       { return HoonTypes.KETHEP; }
    "^+" / {rune_trailer}       { return HoonTypes.KETLUS; }
    "^&" / {rune_trailer}       { return HoonTypes.KETPAM; }
    "^~" / {rune_trailer}       { return HoonTypes.KETSIG; }
    "^*" / {rune_trailer}       { return HoonTypes.KETTAR; }
    "^=" / {rune_trailer}       { return HoonTypes.KETTIS; }
    "^?" / {rune_trailer}       { return HoonTypes.KETWUT; }

    "$|" / {rune_trailer}       { return HoonTypes.BUCBAR; }
    "$_" / {rune_trailer}       { return HoonTypes.BUCCAB; }
    "$%" / {rune_trailer}       { return HoonTypes.BUCCEN; }
    "$:" / {rune_trailer}       { return HoonTypes.BUCCOL; }
    "$<" / {rune_trailer}       { return HoonTypes.BUCGAL; }
    "$>" / {rune_trailer}       { return HoonTypes.BUCGAR; }
    "$-" / {rune_trailer}       { return HoonTypes.BUCHEP; }
    "$;" / {rune_trailer}       { return HoonTypes.BUCMIC; }
    "$^" / {rune_trailer}       { return HoonTypes.BUCKET; }
    "$&" / {rune_trailer}       { return HoonTypes.BUCPAM; }
    "$@" / {rune_trailer}       { return HoonTypes.BUCPAT; }
    "$~" / {rune_trailer}       { return HoonTypes.BUCSIG; }
    "$=" / {rune_trailer}       { return HoonTypes.BUCTIS; }
    "$?" / {rune_trailer}       { return HoonTypes.BUCWUT; }

    ";:" / {rune_trailer}       { return HoonTypes.MICCOL; }
    ";/" / {rune_trailer}       { return HoonTypes.MICFAS; }
    ";<" / {rune_trailer}       { return HoonTypes.MICGAL; }
    ";+" / {rune_trailer}       { return HoonTypes.MICLUS; }
    ";;" / {rune_trailer}       { return HoonTypes.MICMIC; }
    ";~" / {rune_trailer}       { return HoonTypes.MICSIG; }
    ";*" / {rune_trailer}       { return HoonTypes.MICTAR; }
    ";=" / {rune_trailer}       { return HoonTypes.MICTIS; }
      
    "~|" / {rune_trailer}       { return HoonTypes.SIGBAR; }
    "~$" / {rune_trailer}       { return HoonTypes.SIGBUC; }
    "~_" / {rune_trailer}       { return HoonTypes.SIGCAB; }
    "~%" / {rune_trailer}       { return HoonTypes.SIGCEN; }
    "~/" / {rune_trailer}       { return HoonTypes.SIGFAS; }
    "~<" / {rune_trailer}       { return HoonTypes.SIGGAL; }
    "~>" / {rune_trailer}       { return HoonTypes.SIGGAR; }
    "~+" / {rune_trailer}       { return HoonTypes.SIGLUS; }
    "~&" / {rune_trailer}       { return HoonTypes.SIGPAM; }
    "~=" / {rune_trailer}       { return HoonTypes.SIGTIS; }
    "~?" / {rune_trailer}       { return HoonTypes.SIGWUT; }
    "~!" / {rune_trailer}       { return HoonTypes.SIGZAP; }

    "+|"                        { return HoonTypes.LUSBAR; }
    "+$"                        { return HoonTypes.LUSBUC; }
    "++"                        { return HoonTypes.LUSLUS; }
    "+*"                        { return HoonTypes.LUSTAR; }

    "--"                        { return HoonTypes.HEPHEP; }
    "=="                        { return HoonTypes.TISTIS; }

    "|"                         { return HoonTypes.BAR; }
    "$"                         { return HoonTypes.BUC; }
    "_"                         { return HoonTypes.CAB; }
    ":"                         { return HoonTypes.COL; }
    ","                         { return HoonTypes.COM; }
    "."                         { return HoonTypes.DOT; }
    "/"                         { return HoonTypes.FAS; }
    "<"                         { return HoonTypes.GAL; }
    ">"                         { return HoonTypes.GAR; }
    "#"                         { return HoonTypes.HAX; }
    "-"                         { return HoonTypes.HEP; }
    "^"                         { return HoonTypes.KET; }
    "+"                         { return HoonTypes.LUS; }
    ";"                         { return HoonTypes.MIC; }
    "("                         { return HoonTypes.PAL; }
    "&"                         { return HoonTypes.PAM; }
    ")"                         { return HoonTypes.PAR; }
    "@"                         { return HoonTypes.PAT; }
    "["                         { return HoonTypes.SEL; }
    "]"                         { return HoonTypes.SER; }
    "~"                         { return HoonTypes.SIG; }
    "*"                         { return HoonTypes.TAR; }
    "`"                         { return HoonTypes.TIC; }
    "="                         { return HoonTypes.TIS; }
    "?"                         { return HoonTypes.WUT; }
    "!"                         { return HoonTypes.ZAP; }

    " "                         { return HoonTypes.ACE; }
    {gap}                       { return HoonTypes.GAP; }
    {comment}                   { return HoonTypes.COMMENT; }

    {loobean}                   { return HoonTypes.LOOBEAN; }
    {unsigned_decimal}          { return HoonTypes.UNSIGNED_DECIMAL; }
    {unsigned_binary}           { return HoonTypes.UNSIGNED_BINARY; }
    {unsigned_hex}              { return HoonTypes.UNSIGNED_HEXADECIMAL; }
    {unsigned_base32}           { return HoonTypes.UNSIGNED_B32; }
    {unsigned_base58}           { return HoonTypes.UNSIGNED_B58; }
    {unsigned_base64}           { return HoonTypes.UNSIGNED_B64; }
    {signed_decimal}            { return HoonTypes.SIGNED_DECIMAL; }
    {signed_binary}             { return HoonTypes.SIGNED_BINARY; }
    {signed_hex}                { return HoonTypes.SIGNED_HEXADECIMAL; }
    {signed_base32}             { return HoonTypes.SIGNED_B32; }
    {signed_base58}             { return HoonTypes.SIGNED_B58; }
    {signed_base64}             { return HoonTypes.SIGNED_B64; }
    {single_precision_float}    { return HoonTypes.FLOAT; }
    {double_precision_float}    { return HoonTypes.DOUBLE; }
    {half_precision_float}      { return HoonTypes.HALF; }
    {quad_precision_float}      { return HoonTypes.QUAD; }
    {knot}                      { return HoonTypes.KNOT; }
    {term}                      { return HoonTypes.TERM; }
    {ship}                      { return HoonTypes.SHIP; }
    {unscrambled_ship}          { return HoonTypes.UNSCRAMBLED_SHIP; }
    {ipv4}                      { return HoonTypes.IPV4; }
    {ipv6}                      { return HoonTypes.IPV6; }
    {absolute_date}             { return HoonTypes.ABSOLUTE_DATE; }
    {relative_date}             { return HoonTypes.RELATIVE_DATE; }
    {unicode_codepoint}         { return HoonTypes.UNICODE_CODEPOINT; }
    {aura}                      { return HoonTypes.AURA; }
    {chum}                      { return HoonTypes.CHUM; }
    {constant}                  { return HoonTypes.CONSTANT; }
    {three_digit_decimal}       { return HoonTypes.THREE_DIGIT_DECIMAL; }
    {nonzero_decimal_number}    { return HoonTypes.NON_HOON_NUM; }

    {skin}                      { return HoonTypes.SKIN; }
    {camel_case_skin}           { return HoonTypes.CAMEL_CASE_SKIN; }

    {cask_header}               { return HoonTypes.CASK_HEADER; }
    {face_assignment}           { return HoonTypes.FACE_ASSIGNMENT; }
    {simple_path}               { return HoonTypes.SIMPLE_PATH; }
    {path_fragment}             { return HoonTypes.PATH_FRAGMENT; }

    "'''" {newline}             { yybegin(MULTI_CORD); }
    "'"                         { yybegin(CORD); }

    \"\"\" {newline}            { yybegin(MULTI_TAPE); }
    \"                          { yybegin(TAPE); }

    \[ / {face_block_lookahead} { ++selCount; yybegin(FACE_BLOCK); }
}

<CORD> {
    {cord_alphabet}+            { /* do nothing */ }
    \\ {newline} " "* "/"       { /* do nothing */ }
    "'"                         { yybegin(YYINITIAL); return HoonTypes.SIMPLE_CORD; }
}

<MULTI_CORD> {
    .                           { /* do nothing */ }
    {newline}                   { /* do nothing */ }
    {newline} " "* "'''"        { yybegin(YYINITIAL); return HoonTypes.MULTILINE_CORD; }
}

<TAPE> {
    "{"                         { yybegin(TAPE_INTERPOL); }
    {tape_alphabet}+            { /* do nothing */ }
    \" "." {newline} " "* \"    { /* do nothing */ }
    \"                          { yybegin(YYINITIAL); return HoonTypes.SIMPLE_TAPE; }
}

<TAPE_INTERPOL> {
    {tape_interpol_text}+       { /* do nothing */ }
    "}"                         { yybegin(TAPE); }
}

<MULTI_TAPE> {
    .+                          { /* do nothing */ }
    {newline}                   { /* do nothing */ }
    {newline} " "* \"\"\"       { yybegin(YYINITIAL); return HoonTypes.MULTILINE_TAPE; }
}

// [[* wit] [* [@ @] *] [wit *]]=wer
<FACE_BLOCK> {
    "["                         { ++selCount; }
    {face_block_component} " "  { /* do nothing */ }
    {face_block_component} / \] { yybegin(FACE_BLOCK_CLOSE); }
}

<FACE_BLOCK_CLOSE> {
    "]"                         { --selCount; }
    "] "                        { --selCount; assert(selCount != 0); yybegin(FACE_BLOCK); }
    "="                         { assert(selCount == 0); yybegin(YYINITIAL); return HoonTypes.BLOCK_FACE_ASSIGNMENT; }
}

[^]                             { return TokenType.BAD_CHARACTER; }
