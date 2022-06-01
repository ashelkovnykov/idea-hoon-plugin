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
    int kelCount = 0;
    int palCount = 0;
    int selCount = 0;
%}

//
// INDIVIDUAL SYMBOLS
//

bar = "|"
buc = "$"
cab = "_"
cen = "%"
col = ":"
com = ","
dot = "."
fas = "/"
gal = "<"
gar = ">"
hax = "#"
hep = "-"
kel = "{"
ker = "}"
ket = "^"
lus = "+"
mic = ";"
pal = "("
pam = "&"
par = ")"
pat = "@"
sel = "["
ser = "]"
sig = "~"
tar = "*"
tic = "`"
tis = "="
wut = "?"
zap = "!"

//
// SPACING & DOCUMENTATION STRUCTURES
//

// ACE
ace = " "

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
term = "%" ({term_text} | "$")

// TAPE
tape_alphabet = [^\\\{\"\r\n\u2028\u2029\u000B\u000C\u0085] | (\\\\) | (\\\{) | (\\\") | {string_hex_digit}
tape_interpol_alphabet = [^\}\r\n\u2028\u2029\u000B\u000C\u0085]

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

// SKIN
skin = {term_text}

// CAMEL_CASE_SKIN
camel_case_skin = {lowercase_text} ({lowercase_text} | {uppercase_text})*

%state CORD

%state TAPE
%state TAPE_INTERPOL

%state MULTI_CORD
%state MULTI_TAPE

%%

<YYINITIAL> {
    {bar}                      { return HoonTypes.BAR; }
    {buc}                      { return HoonTypes.BUC; }
    {cab}                      { return HoonTypes.CAB; }
    {cen}                      { return HoonTypes.CEN; }
    {col}                      { return HoonTypes.COL; }
    {com}                      { return HoonTypes.COM; }
    {dot}                      { return HoonTypes.DOT; }
    {fas}                      { return HoonTypes.FAS; }
    {gal}                      { return HoonTypes.GAL; }
    {gar}                      { return HoonTypes.GAR; }
    {hax}                      { return HoonTypes.HAX; }
    {hep}                      { return HoonTypes.HEP; }
    {kel}                      { return HoonTypes.KEL; }
    {ker}                      { return HoonTypes.KER; }
    {ket}                      { return HoonTypes.KET; }
    {lus}                      { return HoonTypes.LUS; }
    {mic}                      { return HoonTypes.MIC; }
    {pal}                      { return HoonTypes.PAL; }
    {pam}                      { return HoonTypes.PAM; }
    {par}                      { return HoonTypes.PAR; }
    {pat}                      { return HoonTypes.PAT; }
    {sel}                      { return HoonTypes.SEL; }
    {ser}                      { return HoonTypes.SER; }
    {sig}                      { return HoonTypes.SIG; }
    {tar}                      { return HoonTypes.TAR; }
    {tic}                      { return HoonTypes.TIC; }
    {tis}                      { return HoonTypes.TIS; }
    {wut}                      { return HoonTypes.WUT; }
    {zap}                      { return HoonTypes.ZAP; }

    {ace}                      { return HoonTypes.ACE; }
    {gap}                      { return HoonTypes.GAP; }
    {comment}                  { return HoonTypes.COMMENT; }

    {loobean}                  { return HoonTypes.LOOBEAN; }
    {unsigned_decimal}         { return HoonTypes.UNSIGNED_DECIMAL; }
    {unsigned_binary}          { return HoonTypes.UNSIGNED_BINARY; }
    {unsigned_hex}             { return HoonTypes.UNSIGNED_HEXADECIMAL; }
    {unsigned_base32}          { return HoonTypes.UNSIGNED_B32; }
    {unsigned_base58}          { return HoonTypes.UNSIGNED_B58; }
    {unsigned_base64}          { return HoonTypes.UNSIGNED_B64; }
    {signed_decimal}           { return HoonTypes.SIGNED_DECIMAL; }
    {signed_binary}            { return HoonTypes.SIGNED_BINARY; }
    {signed_hex}               { return HoonTypes.SIGNED_HEXADECIMAL; }
    {signed_base32}            { return HoonTypes.SIGNED_B32; }
    {signed_base58}            { return HoonTypes.SIGNED_B58; }
    {signed_base64}            { return HoonTypes.SIGNED_B64; }
    {single_precision_float}   { return HoonTypes.FLOAT; }
    {double_precision_float}   { return HoonTypes.DOUBLE; }
    {half_precision_float}     { return HoonTypes.HALF; }
    {quad_precision_float}     { return HoonTypes.QUAD; }
    {knot}                     { return HoonTypes.KNOT; }
    {term}                     { return HoonTypes.TERM; }
    {ship}                     { return HoonTypes.SHIP; }
    {unscrambled_ship}         { return HoonTypes.UNSCRAMBLED_SHIP; }
    {ipv4}                     { return HoonTypes.IPV4; }
    {ipv6}                     { return HoonTypes.IPV6; }
    {absolute_date}            { return HoonTypes.ABSOLUTE_DATE; }
    {relative_date}            { return HoonTypes.RELATIVE_DATE; }
    {unicode_codepoint}        { return HoonTypes.UNICODE_CODEPOINT; }
    {aura}                     { return HoonTypes.AURA; }
    {skin}                     { return HoonTypes.SKIN; }
    {chum}                     { return HoonTypes.CHUM; }
    {three_digit_decimal}      { return HoonTypes.THREE_DIGIT_DECIMAL; }
    {nonzero_decimal_number}   { return HoonTypes.NON_HOON_NUM; }
    {camel_case_skin}          { return HoonTypes.CAMEL_CASE_SKIN; }

    "'''" {newline}            { yybegin(MULTI_CORD); }
    "'"                        { yybegin(CORD); }

    \"\"\" {newline}           { yybegin(MULTI_TAPE); }
    \"                         { yybegin(TAPE); }
}

<CORD> {
    {cord_alphabet}+           { /* do nothing */ }
    \\ {newline} " "* "/"      { /* do nothing */ }
    "'"                        { yybegin(YYINITIAL); return HoonTypes.SIMPLE_CORD; }
}

<TAPE> {
    "{"                        { ++kelCount; yybegin(TAPE_INTERPOL); }
    {tape_alphabet}+           { /* do nothing */ }
    \" "." {newline} " "* \"   { /* do nothing */ }
    \"                         { yybegin(YYINITIAL); assert(kelCount == 0); return HoonTypes.SIMPLE_TAPE; }
}

<TAPE_INTERPOL> {
    {tape_interpol_alphabet}+  { /* do nothing */ }
    "}"                        { --kelCount; if (kelCount == 0) yybegin(TAPE); }
}

<MULTI_CORD> {
    .                          { /* do nothing */ }
    {newline}                  { /* do nothing */ }
    {newline} " "* "'''"       { yybegin(YYINITIAL); return HoonTypes.MULTILINE_CORD; }
}

<MULTI_TAPE> {
    .                          { /* do nothing */ }
    {newline}                  { /* do nothing */ }
    {newline} " "* \"\"\"      { yybegin(YYINITIAL); return HoonTypes.MULTILINE_TAPE; }
}
