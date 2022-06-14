package com.ashelkov.hoon.plugin;

import com.intellij.openapi.editor.colors.TextAttributesKey;
import com.intellij.openapi.fileTypes.SyntaxHighlighter;
import com.intellij.openapi.options.colors.AttributesDescriptor;
import com.intellij.openapi.options.colors.ColorDescriptor;
import com.intellij.openapi.options.colors.ColorSettingsPage;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import javax.swing.*;
import java.util.Map;

public class HoonColorSettingsPage implements ColorSettingsPage {

    private static final AttributesDescriptor[] DESCRIPTORS = new AttributesDescriptor[]{

            new AttributesDescriptor("Runes//Hoon", HoonSyntaxHighlighter.RUNE),
            new AttributesDescriptor("Runes//Ford", HoonSyntaxHighlighter.FORD_RUNE),

            new AttributesDescriptor("Loobeans", HoonSyntaxHighlighter.LOOBEAN),

            new AttributesDescriptor("Numbers//Signed", HoonSyntaxHighlighter.SIGNED_NUMBER),
            new AttributesDescriptor("Numbers//Unsigned", HoonSyntaxHighlighter.UNSIGNED_NUMBER),
            new AttributesDescriptor("Numbers//Floating point", HoonSyntaxHighlighter.FLOATING_POINT),

            new AttributesDescriptor("Ship names", HoonSyntaxHighlighter.SHIP),

            new AttributesDescriptor("IP addresses", HoonSyntaxHighlighter.IP_ADDRESS),

            new AttributesDescriptor("Dates", HoonSyntaxHighlighter.DATE),

            new AttributesDescriptor("Strings//Cord", HoonSyntaxHighlighter.CORD),
            new AttributesDescriptor("Strings//Tape", HoonSyntaxHighlighter.TAPE),
            new AttributesDescriptor("Strings//Knot", HoonSyntaxHighlighter.KNOT),

            new AttributesDescriptor("Terms", HoonSyntaxHighlighter.TERM),
            new AttributesDescriptor("Constants", HoonSyntaxHighlighter.CONSTANT),

            new AttributesDescriptor("Paths", HoonSyntaxHighlighter.PATH),

            new AttributesDescriptor("Unicode codepoints", HoonSyntaxHighlighter.UNICODE_POINT),

            new AttributesDescriptor("Grouping//Brackets", HoonSyntaxHighlighter.BRACKETS),
            new AttributesDescriptor("Grouping//Parentheses", HoonSyntaxHighlighter.PARENTHESES),

            new AttributesDescriptor("Comment", HoonSyntaxHighlighter.COMMENT)
    };

    @Nullable
    @Override
    public Icon getIcon() {
        return HoonIcons.FILE;
    }

    @NotNull
    @Override
    public SyntaxHighlighter getHighlighter() {
        return new HoonSyntaxHighlighter();
    }

    @NotNull
    @Override
    public String getDemoText() {
        return "/+  some-lib" +
                "=<  :: comment\n" +
                "  =>  [a @]=[1 2]\n" +
                "  (add 2 2)\n" +
                ":*  %.y\n" +
                "    123\n" +
                "    123.456\n" +
                "    0b1100\n" +
                "    0xdead.beef\n" +
                "    0v1df64.49beg\n" +
                "    0wbnC.8haTg\n" +
                "    0c1111111111111111111114oLvT2\n" +
                "    -123.456\n" +
                "    --0b1100\n" +
                "    -0xdead.beef\n" +
                "    --0v1df64.49beg\n" +
                "    -0wbnC.8haTg\n" +
                "    --0c1111111111111111111114oLvT2\n" +
                "    .6.022141e23\n" +
                "    .~6.02214085774e23\n" +
                "    .~~3.14\n" +
                "    .~~~6.02214085774e23\n" +
                "    ~zod\n" +
                "    .~litsyn-polbel\n" +
                "    .195.198.143.90\n" +
                "    .0.0.0.0.0.1c.c3c6.8f5a\n" +
                "    ~2018.5.14..22.31.46..1435\n" +
                "    ~h5.m30.s12\n" +
                "    'cord'\n" +
                "    \"tape\"\n" +
                "    ~.knot\n" +
                "    %term\n" +
                "    %12.345\n" +
                "    ~-~1F44C.\n" +
                "    /a/b/[`@ta`(cat 3 %c %d)]/e\n" +
                "==";
    }

    @Nullable
    @Override
    public Map<String, TextAttributesKey> getAdditionalHighlightingTagToDescriptorMap() {
        return null;
    }

    @NotNull
    @Override
    public AttributesDescriptor[] getAttributeDescriptors() {
        return DESCRIPTORS;
    }

    @NotNull
    @Override
    public ColorDescriptor[] getColorDescriptors() {
        return ColorDescriptor.EMPTY_ARRAY;
    }

    @NotNull
    @Override
    public String getDisplayName() {
        return "Hoon";
    }

}