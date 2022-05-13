package com.ashelkov.hoon.plugin;

import com.intellij.lexer.FlexAdapter;

public class HoonLexerAdapter extends FlexAdapter {

    public HoonLexerAdapter() {
        super(new HoonLexer(null));
    }

}