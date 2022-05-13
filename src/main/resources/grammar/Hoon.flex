package com.ashelkov.hoon.plugin;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import org.intellij.sdk.language.psi.HoonTypes;
import com.intellij.psi.TokenType;

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

//
// SPACING & DOCUMENTATION STRUCTURES
//

// GAP
newline = \R
spaces = " "{2} " "*
short_gap = {newline} | {spaces}
full_gap = {short_gap}+

// COMMENT
comment = "::" .* {newline}

//
// LITERALS
//

// LOOBEAN
true = "&" | "%.y"
false = "|" | "%.n"
loobean = {true} | {false}

// UNSIGNED DECIMAL
zero = "0"
decimal = [0-9]
nonzero_decimal = [1-9]
hoon_decimal = {nonzero_decimal} {decimal}{0,2} ("." {decimal}{3})*
unsigned_decimal = {zero} | {hoon_decimal}

// UNSIGNED BINARY
binary = [01]
hoon_binary = "1" {binary}{0,3} ("." {binary}{4})*
unsigned_binary = "0b" {zero} | {hoon_binary}

// UNSIGNED HEXADECIMAL
hexadecimal = [0-9a-f]
nonzero_hexadecimal = [1-9a-f]
hoon_hex_block = {nonzero_hexadecimal} {hexadecimal}{0,3}
hoon_hex = {hoon_hex_block} ("." {hexadecimal}{4})*
unsigned_hex = "0x" {zero} | {hoon_hex}

// UNSIGNED BASE32
base32 = [0-9a-v]
nonzero_base32 = [1-9a-v]
hoon_base32 = {nonzero_base32} {base32}{0,4} ("." {base32}{5})*
unsigned_base32 = "0v" {zero} | {hoon_base32}

// UNSIGNED BASE64
base64 = [0-9a-zA-Z~\-]
nonzero_base64 = [1-9a-zA-Z~\-]
hoon_base64 = {nonzero_base64} {base64}{0,4} ("." {base64}{5})*
unsigned_base64 = "0w" {zero} | {hoon_base64}

// SIGNED DECIMAL
signed_decimal = "-"{1,2} {unsigned_decimal}

// SIGNED BINARY
signed_binary = "-"{1,2} {unsigned_binary}

// SIGNED HEXADECIMAL
signed_hex = "-"{1,2} {unsigned_hex}

// SIGNED BASE32
signed_base32 = "-"{1,2} {unsigned_base32}

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

// TERM
term_alphabet = [0-9a-z\-]
term_text = [a-z] {term_alphabet}*
term = "%" ({unsigned_decimal} | {term_text} | "$")

// KNOT
knot_alphabet = [0-9a-z~\.\-]
knot = "~." {knot_alphabet}*

// CORD
cord_alphabet = [[.]--[']] | (\\ \')
cord_single_line = "'" {cord_alphabet}* "'"
cord_multi_line = "'''" ([.]* {newline})* [.]* "'''"
cord = {cord_single_line} | {cord_multi_line}

// TAPE
tape_alphabet = [[.]--[\"]] | (\\ \")
tape_single_line = \" {tape_alphabet}* \"
tape_continuation = "." {newline} " "* {tape_single_line}
tape = {tape_single_line} {tape_continuation}*

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
ipv6_block = "." {hoon_hex_block}
ipv6 = {ipv6_block}{4}

// ABSOLUTE DATE
month = {nonzero_decimal} | ("1" [0-2])
day = {nonzero_decimal} | ([12] {decimal}) | ("3" [01])
hour = ([01] {decimal}) | ("2" [0-3])
min_or_sec = [0-5] {decimal}
date_block = {nonzero_decimal_number} "." {month} "." {day}
time_block = {hour} "." {min_or_sec} "." {min_or_sec}
millisecond_block = {hexadecimal}{4}
absolute_date = "~" {date_block} (".." {time_block} (".." {millisecond_block})?)?

// RELATIVE DATE
day_block = "d" {any_decimal}
hour_block = "h" {any_decimal}
minute_block = "m" {any_decimal}
second_block = "s" {any_decimal}
relative_date_block = {day_block} | {hour_block} | {minute_block} | {second_block}
relative_date = "~" {relative_date_block} ("." {relative_date_block})*

// UNICODE POINT
unicode_point = "~" {hexadecimal}+ "."
unicode_text = [0-9a-z_\.\-]+
unicode_codepoint = "~-" ({unicode_point} | {unicode_text})?

// PATH
path_start = "%" | "/" | "/%"
current_path_block = "="+
path_block = "~" | {current_path_block} | {term_text} | {cord_single_line} | {knot} | {unsigned_decimal} |
             {unsigned_binary} | {unsigned_hex} | {unsigned_base32} | {unsigned_base64} | {signed_decimal} |
             {signed_binary} | {signed_hex} | {signed_base32} | {signed_base64} | {single_precision_float} |
             {double_precision_float} | {half_precision_float} | {quad_precision_float} | {ship} | {unscrambled_ship} |
             {absolute_date} | {relative_date} | {ipv4} | {ipv6} | {unicode_codepoint}
path = {path_start} ("/" {path_block})*

// LARK
lark_alpha = "-" | "+"
lark_beta = "<" | ">"
lark_followup_block = {lark_beta} {lark_alpha}
lark = {lark_alpha} {lark_followup_block}* {lark_beta}?

// TREE_SLOT
tree_slot = "+" {nonzero_decimal_number}

// LIST_SLOT
list_slot_command = "&" | "|"
list_slot = {list_slot_command} {nonzero_decimal_number}

// AURA
aura_unicode = "c"
aura_date = "d" [ar]?
aura_ip = "i" [fs]?
aura_ship = "p" | "q"
aura_float = "r" [hsdq]?
aura_signed_num = "s" [bdvwx]?
aura_unsigned_num = "u" [bdvwx]?
aura_text = "t" ("a" "s"?)?
aura_keyword = {aura_unicode} | {aura_date} | {aura_ip} | {aura_ship} | {aura_float} | {aura_signed_num} |
               {aura_unsigned_num} | {aura_text}
aura_width_marker = [A-Z]+
aura = "@" {aura_keyword} {aura_width_marker}?

// SKIN
skin = {term_text}

%%

{full_gap}               { return HoonTypes.GAP; }
{loobean}                { return HoonTypes.LOOBEAN; }
{unsigned_decimal}       { return HoonTypes.UNSIGNED_DECIMAL; }
{unsigned_binary}        { return HoonTypes.UNSIGNED_BINARY; }
{unsigned_hex}           { return HoonTypes.UNSIGNED_HEXADECIMAL; }
{unsigned_base32}        { return HoonTypes.UNSIGNED_B32; }
{unsigned_base64}        { return HoonTypes.UNSIGNED_B64; }
{signed_decimal}         { return HoonTypes.SIGNED_DECIMAL; }
{signed_binary}          { return HoonTypes.SIGNED_BINARY; }
{signed_hex}             { return HoonTypes.SIGNED_HEXADECIMAL; }
{signed_base32}          { return HoonTypes.SIGNED_B32; }
{signed_base64}          { return HoonTypes.SIGNED_B64; }
{single_precision_float} { return HoonTypes.FLOAT; }
{double_precision_float} { return HoonTypes.DOUBLE; }
{half_precision_float}   { return HoonTypes.HALF; }
{quad_precision_float}   { return HoonTypes.QUAD; }
{term}                   { return HoonTypes.TERM; }
{knot}                   { return HoonTypes.KNOT; }
{cord}                   { return HoonTypes.CORD; }
{tape}                   { return HoonTypes.TAPE; }
{ship}                   { return HoonTypes.SHIP; }
{unscrambled_ship}       { return HoonTypes.UNSCRAMBLED_SHIP; }
{ipv4}                   { return HoonTypes.IPV4; }
{ipv6}                   { return HoonTypes.IPV6; }
{absolute_date}          { return HoonTypes.ABSOLUTE_DATE; }
{relative_date}          { return HoonTypes.RELATIVE_DATE; }
{unicode_codepoint}      { return HoonTypes.UNICODE_CODEPOINT; }
{path}                   { return HoonTypes.PATH; }
{lark}                   { return HoonTypes.LARK; }
{tree_slot}              { return HoonTypes.TREE_SLOT; }
{list_slot}              { return HoonTypes.LIST_SLOT; }
{aura}                   { return HoonTypes.AURA; }
{skin}                   { return HoonTypes.SKIN; }
{comment}                { return HoonTypes.COMMENT; }
{nonzero_decimal_number} { return HoonTypes.NON_HOON_NUM; }
