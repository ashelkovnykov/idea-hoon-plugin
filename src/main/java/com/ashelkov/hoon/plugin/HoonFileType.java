package com.ashelkov.hoon.plugin;

import javax.swing.*;

import com.intellij.openapi.fileTypes.LanguageFileType;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class HoonFileType extends LanguageFileType {

    public static final HoonFileType INSTANCE = new HoonFileType();

    private HoonFileType() {
        super(HoonLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public String getName() {
        return "Hoon File";
    }

    @NotNull
    @Override
    public String getDescription() {
        return "Hoon language file";
    }

    @NotNull
    @Override
    public String getDefaultExtension() {
        return "hoon";
    }

    @Nullable
    @Override
    public Icon getIcon() {
        return HoonIcons.FileType;
    }
}
