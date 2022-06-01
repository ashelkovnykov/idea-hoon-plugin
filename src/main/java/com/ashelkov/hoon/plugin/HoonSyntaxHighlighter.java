package com.ashelkov.hoon.plugin;

import com.intellij.lexer.Lexer;
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighterBase;
import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NotNull;

import com.ashelkov.hoon.plugin.psi.HoonTypes;

import static com.intellij.openapi.editor.colors.TextAttributesKey.createTextAttributesKey;

public class HoonSyntaxHighlighter extends SyntaxHighlighterBase {

    public static final TextAttributesKey RUNE = createTextAttributesKey(
            "HOON_RUNE",
            DefaultLanguageHighlighterColors.KEYWORD);

    public static final TextAttributesKey FORD_RUNE = createTextAttributesKey(
            "HOON_FORD_RUNE",
            DefaultLanguageHighlighterColors.KEYWORD);

    public static final TextAttributesKey IDENTIFIER = createTextAttributesKey(
            "HOON_SKIN",
            DefaultLanguageHighlighterColors.IDENTIFIER);

    public static final TextAttributesKey LOOBEAN = createTextAttributesKey(
            "HOON_LOOBEAN",
            DefaultLanguageHighlighterColors.CONSTANT);

    public static final TextAttributesKey UNSIGNED_NUMBER = createTextAttributesKey(
            "HOON_UNSIGNED_NUMBER",
            DefaultLanguageHighlighterColors.NUMBER);

    public static final TextAttributesKey SIGNED_NUMBER = createTextAttributesKey(
            "HOON_SIGNED_NUMBER",
            DefaultLanguageHighlighterColors.NUMBER);

    public static final TextAttributesKey FLOATING_POINT = createTextAttributesKey(
            "HOON_FLOATING_POINT",
            DefaultLanguageHighlighterColors.NUMBER);

    public static final TextAttributesKey SHIP = createTextAttributesKey(
            "HOON_SHIP",
            DefaultLanguageHighlighterColors.NUMBER);

    public static final TextAttributesKey IP_ADDRESS = createTextAttributesKey(
            "HOON_IP_ADDRESS",
            DefaultLanguageHighlighterColors.NUMBER);

    public static final TextAttributesKey DATE = createTextAttributesKey(
            "HOON_DATE",
            DefaultLanguageHighlighterColors.NUMBER);

    public static final TextAttributesKey STRING = createTextAttributesKey(
            "HOON_STRING",
            DefaultLanguageHighlighterColors.STRING);

    public static final TextAttributesKey TERM = createTextAttributesKey(
            "HOON_TERM",
            DefaultLanguageHighlighterColors.CONSTANT);

    public static final TextAttributesKey KNOT = createTextAttributesKey(
            "HOON_KNOT",
            DefaultLanguageHighlighterColors.STRING);

    public static final TextAttributesKey UNICODE_POINT = createTextAttributesKey(
            "HOON_UNICODE_POINT",
            DefaultLanguageHighlighterColors.STRING);

    public static final TextAttributesKey PATH = createTextAttributesKey(
            "HOON_PATH",
            DefaultLanguageHighlighterColors.HIGHLIGHTED_REFERENCE);

    public static final TextAttributesKey BRACES = createTextAttributesKey(
            "HOON_BRACES",
            DefaultLanguageHighlighterColors.BRACES);

    public static final TextAttributesKey PARENTHESES = createTextAttributesKey(
            "HOON_PARENTEHSES",
            DefaultLanguageHighlighterColors.PARENTHESES);

    public static final TextAttributesKey BRACKETS = createTextAttributesKey(
            "HOON_BRACKETS",
            DefaultLanguageHighlighterColors.BRACKETS);

    public static final TextAttributesKey OPERATOR = createTextAttributesKey(
            "HOON_OPERATOR",
            DefaultLanguageHighlighterColors.OPERATION_SIGN);

    public static final TextAttributesKey COMMENT = createTextAttributesKey(
            "HOON_COMMENT",
            DefaultLanguageHighlighterColors.DOC_COMMENT);

    @NotNull
    @Override
    public Lexer getHighlightingLexer() {
        return new HoonLexerAdapter();
    }

    @NotNull
    @Override
    public TextAttributesKey[] getTokenHighlights(IElementType tokenType) {

        //
        // Boolean
        //

        if (tokenType.equals(HoonTypes.LOOBEAN)) {
            return new TextAttributesKey[]{LOOBEAN};
        }

        //
        // Numbers
        //

        // Unsigned numbers
        if (tokenType.equals(HoonTypes.THREE_DIGIT_DECIMAL)) {
            return new TextAttributesKey[]{UNSIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.NON_HOON_NUM)) {
            return new TextAttributesKey[]{UNSIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.UNSIGNED_DECIMAL)) {
            return new TextAttributesKey[]{UNSIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.UNSIGNED_BINARY)) {
            return new TextAttributesKey[]{UNSIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.UNSIGNED_HEXADECIMAL)) {
            return new TextAttributesKey[]{UNSIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.UNSIGNED_B32)) {
            return new TextAttributesKey[]{UNSIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.UNSIGNED_B58)) {
            return new TextAttributesKey[]{UNSIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.UNSIGNED_B64)) {
            return new TextAttributesKey[]{UNSIGNED_NUMBER};
        }

        // Signed numbers
        if (tokenType.equals(HoonTypes.SIGNED_DECIMAL)) {
            return new TextAttributesKey[]{SIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.SIGNED_BINARY)) {
            return new TextAttributesKey[]{SIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.SIGNED_HEXADECIMAL)) {
            return new TextAttributesKey[]{SIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.SIGNED_B32)) {
            return new TextAttributesKey[]{SIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.SIGNED_B58)) {
            return new TextAttributesKey[]{SIGNED_NUMBER};
        }
        if (tokenType.equals(HoonTypes.SIGNED_B64)) {
            return new TextAttributesKey[]{SIGNED_NUMBER};
        }

        // Floating point numbers
        if (tokenType.equals(HoonTypes.FLOAT)) {
            return new TextAttributesKey[]{FLOATING_POINT};
        }
        if (tokenType.equals(HoonTypes.DOUBLE)) {
            return new TextAttributesKey[]{FLOATING_POINT};
        }
        if (tokenType.equals(HoonTypes.HALF)) {
            return new TextAttributesKey[]{FLOATING_POINT};
        }
        if (tokenType.equals(HoonTypes.QUAD)) {
            return new TextAttributesKey[]{FLOATING_POINT};
        }

        //
        // Ships
        //

        if (tokenType.equals(HoonTypes.SHIP)) {
            return new TextAttributesKey[]{SHIP};
        }
        if (tokenType.equals(HoonTypes.UNSCRAMBLED_SHIP)) {
            return new TextAttributesKey[]{SHIP};
        }

        //
        // IP addresses
        //

        if (tokenType.equals(HoonTypes.IPV4)) {
            return new TextAttributesKey[]{IP_ADDRESS};
        }
        if (tokenType.equals(HoonTypes.IPV6)) {
            return new TextAttributesKey[]{IP_ADDRESS};
        }

        //
        // Date
        //

        if (tokenType.equals(HoonTypes.ABSOLUTE_DATE)) {
            return new TextAttributesKey[]{DATE};
        }
        if (tokenType.equals(HoonTypes.RELATIVE_DATE)) {
            return new TextAttributesKey[]{DATE};
        }

        //
        // Terms
        //

        if (tokenType.equals(HoonTypes.TERM)) {
            return new TextAttributesKey[]{TERM};
        }
        if (tokenType.equals(HoonTypes.CHUM)) {
            return new TextAttributesKey[]{TERM};
        }

        //
        // Text
        //

        // Strings
        if (tokenType.equals(HoonTypes.SIMPLE_CORD)) {
            return new TextAttributesKey[]{STRING};
        }
        if (tokenType.equals(HoonTypes.SIMPLE_TAPE)) {
            return new TextAttributesKey[]{STRING};
        }
        if (tokenType.equals(HoonTypes.MULTILINE_CORD)) {
            return new TextAttributesKey[]{STRING};
        }
        if (tokenType.equals(HoonTypes.MULTILINE_TAPE)) {
            return new TextAttributesKey[]{STRING};
        }

        // Knot
        if (tokenType.equals(HoonTypes.KNOT)) {
            return new TextAttributesKey[]{KNOT};
        }

        // Unicode
        if (tokenType.equals(HoonTypes.UNICODE_CODEPOINT)) {
            return new TextAttributesKey[]{UNICODE_POINT};
        }

        //
        // Language constructs
        //

        // Skin
        if (tokenType.equals(HoonTypes.SKIN)) {
            return new TextAttributesKey[]{IDENTIFIER};
        }

        // Braces
        if (tokenType.equals(HoonTypes.KEL)) {
            return new TextAttributesKey[]{BRACES};
        }
        if (tokenType.equals(HoonTypes.KER)) {
            return new TextAttributesKey[]{BRACES};
        }

        // Brackets
        if (tokenType.equals(HoonTypes.SEL)) {
            return new TextAttributesKey[]{BRACKETS};
        }
        if (tokenType.equals(HoonTypes.SER)) {
            return new TextAttributesKey[]{BRACKETS};
        }

        // Parentheses
        if (tokenType.equals(HoonTypes.PAL)) {
            return new TextAttributesKey[]{PARENTHESES};
        }
        if (tokenType.equals(HoonTypes.PAR)) {
            return new TextAttributesKey[]{PARENTHESES};
        }

        // Operator symbols
        if (tokenType.equals(HoonTypes.BAR)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.CAB)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.COM)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.FAS)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.KET)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.LUS)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.PAM)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.TAR)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.TIC)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.TIS)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.WUT)) {
            return new TextAttributesKey[]{OPERATOR};
        }
        if (tokenType.equals(HoonTypes.ZAP)) {
            return new TextAttributesKey[]{OPERATOR};
        }

        // Comments
        if (tokenType.equals(HoonTypes.COMMENT)) {
            return new TextAttributesKey[]{COMMENT};
        }

        //
        // Everything else
        //

        return new TextAttributesKey[0];
    }

    // TODO: Move to annotator
//    if (tokenType.equals(HoonTypes.HOON_RUNE)) {
//        return new TextAttributesKey[]{RUNE};
//    }
//        if (tokenType.equals(HoonTypes.FORD_RUNE)) {
//        return new TextAttributesKey[]{FORD_RUNE};
//    }
//        if (tokenType.equals(HoonTypes.CONSTANT)) {
//        return new TextAttributesKey[]{CONSTANT};
//    }
//        if (tokenType.equals(HoonTypes.PATH)) {
//        return new TextAttributesKey[]{PATH};
//    }
//        if (tokenType.equals(HoonTypes.SAIL_EXPRESSION)) {
//        return new TextAttributesKey[]{SAIL_EXPRESSION};
//    }
//        if (tokenType.equals(HoonTypes.SKIN_AS_WING_OR_SPEC)) {
//        return new TextAttributesKey[]{IDENTIFIER};
//    }

}