package com.ashelkov.hoon.plugin.psi;

import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

import com.ashelkov.hoon.plugin.HoonLanguage;

public class HoonElementType extends IElementType {

    public HoonElementType(@NotNull @NonNls String debugName) {
        super(debugName, HoonLanguage.INSTANCE);
    }

}
