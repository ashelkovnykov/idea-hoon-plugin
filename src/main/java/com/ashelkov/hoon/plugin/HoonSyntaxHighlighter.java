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

    public static final TextAttributesKey CORD = createTextAttributesKey(
            "HOON_CORD",
            DefaultLanguageHighlighterColors.STRING);

    public static final TextAttributesKey TAPE = createTextAttributesKey(
            "HOON_TAPE",
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

    public static final TextAttributesKey CONSTANT = createTextAttributesKey(
            "HOON_CONSTANT",
            DefaultLanguageHighlighterColors.CONSTANT);

    public static final TextAttributesKey PATH = createTextAttributesKey(
            "HOON_PATH",
            DefaultLanguageHighlighterColors.HIGHLIGHTED_REFERENCE);

    public static final TextAttributesKey PARENTHESES = createTextAttributesKey(
            "HOON_PARENTEHSES",
            DefaultLanguageHighlighterColors.PARENTHESES);

    public static final TextAttributesKey BRACKETS = createTextAttributesKey(
            "HOON_BRACKETS",
            DefaultLanguageHighlighterColors.BRACKETS);

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
        // Ford runes
        //

        if (tokenType.equals(HoonTypes.FASBUC)) {
            return new TextAttributesKey[]{FORD_RUNE};
        }
        if (tokenType.equals(HoonTypes.FASCEN)) {
            return new TextAttributesKey[]{FORD_RUNE};
        }
        if (tokenType.equals(HoonTypes.FASHEP)) {
            return new TextAttributesKey[]{FORD_RUNE};
        }
        if (tokenType.equals(HoonTypes.FASLUS)) {
            return new TextAttributesKey[]{FORD_RUNE};
        }
        if (tokenType.equals(HoonTypes.FASSIG)) {
            return new TextAttributesKey[]{FORD_RUNE};
        }
        if (tokenType.equals(HoonTypes.FASTAR)) {
            return new TextAttributesKey[]{FORD_RUNE};
        }
        if (tokenType.equals(HoonTypes.FASTIS)) {
            return new TextAttributesKey[]{FORD_RUNE};
        }
        if (tokenType.equals(HoonTypes.FASWUT)) {
            return new TextAttributesKey[]{FORD_RUNE};
        }

        //
        // Hoon Runes
        //

        // DOT runes
        if (tokenType.equals(HoonTypes.DOTKET)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.DOTLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.DOTTAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.DOTTIS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.DOTWUT)) {
            return new TextAttributesKey[]{RUNE};
        }

        // ZAP runes
        if (tokenType.equals(HoonTypes.ZAPCOL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPCOM)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPDOT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPGAL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPGAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPMIC)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPPAT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPTIS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPWUT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.ZAPZAP)) {
            return new TextAttributesKey[]{RUNE};
        }

        // TIS runes
        if (tokenType.equals(HoonTypes.TISBAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISCOL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISCOM)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISDOT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISFAS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISGAL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISGAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISHEP)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISKET)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISMIC)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISSIG)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISTAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISWUT)) {
            return new TextAttributesKey[]{RUNE};
        }

        // WUT runes
        if (tokenType.equals(HoonTypes.WUTBAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTCOL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTDOT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTGAL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTGAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTHEP)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTKET)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTPAM)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTPAT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTSIG)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTTIS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.WUTZAP)) {
            return new TextAttributesKey[]{RUNE};
        }

        // BAR runes
        if (tokenType.equals(HoonTypes.BARBUC)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARCAB)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARCEN)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARCOL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARDOT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARHEP)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARKET)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARPAT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARSIG)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARTAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARTIS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BARWUT)) {
            return new TextAttributesKey[]{RUNE};
        }

        // COL runes
        if (tokenType.equals(HoonTypes.COLCAB)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.COLHEP)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.COLKET)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.COLLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.COLSIG)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.COLTAR)) {
            return new TextAttributesKey[]{RUNE};
        }

        // CEN runes
        if (tokenType.equals(HoonTypes.CENCAB)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.CENCOL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.CENDOT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.CENHEP)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.CENKET)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.CENLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.CENSIG)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.CENTAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.CENTIS)) {
            return new TextAttributesKey[]{RUNE};
        }

        // KET runes
        if (tokenType.equals(HoonTypes.KETBAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETCOL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETDOT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETHEP)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETPAM)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETSIG)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETTAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETTIS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.KETWUT)) {
            return new TextAttributesKey[]{RUNE};
        }

        // BUC runes
        if (tokenType.equals(HoonTypes.BUCBAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCCAB)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCCEN)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCCOL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCGAL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCGAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCHEP)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCMIC)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCKET)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCPAM)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCPAT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCSIG)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCTIS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.BUCWUT)) {
            return new TextAttributesKey[]{RUNE};
        }

        // MIC runes
        if (tokenType.equals(HoonTypes.MICCOL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.MICFAS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.MICGAL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.MICLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.MICMIC)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.MICSIG)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.MICTAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.MICTIS)) {
            return new TextAttributesKey[]{RUNE};
        }

        // SIG runes
        if (tokenType.equals(HoonTypes.SIGBAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGBUC)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGCAB)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGFAS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGGAL)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGGAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGPAM)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGTIS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGWUT)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.SIGZAP)) {
            return new TextAttributesKey[]{RUNE};
        }

        // Arm runes
        if (tokenType.equals(HoonTypes.LUSBAR)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.LUSBUC)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.LUSLUS)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.LUSTAR)) {
            return new TextAttributesKey[]{RUNE};
        }

        // Terminator runes
        if (tokenType.equals(HoonTypes.HEPHEP)) {
            return new TextAttributesKey[]{RUNE};
        }
        if (tokenType.equals(HoonTypes.TISTIS)) {
            return new TextAttributesKey[]{RUNE};
        }

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

        if (tokenType.equals(HoonTypes.CHUM)) {
            return new TextAttributesKey[]{TERM};
        }
        if (tokenType.equals(HoonTypes.TERM)) {
            return new TextAttributesKey[]{TERM};
        }

        //
        // Text
        //

        // Cord
        if (tokenType.equals(HoonTypes.SIMPLE_CORD)) {
            return new TextAttributesKey[]{CORD};
        }
        if (tokenType.equals(HoonTypes.MULTILINE_CORD)) {
            return new TextAttributesKey[]{CORD};
        }

        // Tape
        if (tokenType.equals(HoonTypes.SIMPLE_TAPE)) {
            return new TextAttributesKey[]{TAPE};
        }
        if (tokenType.equals(HoonTypes.MULTILINE_TAPE)) {
            return new TextAttributesKey[]{TAPE};
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
        // Constants
        //

        if (tokenType.equals(HoonTypes.CONSTANT)) {
            return new TextAttributesKey[]{CONSTANT};
        }

        //
        // Paths
        //

        if (tokenType.equals(HoonTypes.SIMPLE_PATH)) {
            return new TextAttributesKey[]{PATH};
        }
        if (tokenType.equals(HoonTypes.PATH_FRAGMENT)) {
            return new TextAttributesKey[]{PATH};
        }

        //
        // Language constructs
        //

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

        // Comments
        if (tokenType.equals(HoonTypes.COMMENT)) {
            return new TextAttributesKey[]{COMMENT};
        }

        //
        // Everything else
        //

        return new TextAttributesKey[0];
    }

}