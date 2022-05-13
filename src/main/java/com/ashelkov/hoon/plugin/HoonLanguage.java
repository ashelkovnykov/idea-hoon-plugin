package com.ashelkov.hoon.plugin;

import com.intellij.lang.Language;

public class HoonLanguage extends Language {

    public static final HoonLanguage INSTANCE = new HoonLanguage();

    private HoonLanguage() {
        super("Hoon");
    }

}
