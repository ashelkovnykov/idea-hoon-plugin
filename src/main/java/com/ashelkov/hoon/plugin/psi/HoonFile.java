package com.ashelkov.hoon.plugin.psi;

import com.intellij.extapi.psi.PsiFileBase;
import com.intellij.openapi.fileTypes.FileType;
import com.intellij.psi.FileViewProvider;
import org.jetbrains.annotations.NotNull;

import com.ashelkov.hoon.plugin.HoonFileType;
import com.ashelkov.hoon.plugin.HoonLanguage;

public class HoonFile extends PsiFileBase {

    public HoonFile(@NotNull FileViewProvider viewProvider) {
        super(viewProvider, HoonLanguage.INSTANCE);
    }

    @NotNull
    @Override
    public FileType getFileType() {
        return HoonFileType.INSTANCE;
    }

    @Override
    public String toString() {
        return "Hoon File";
    }

}
