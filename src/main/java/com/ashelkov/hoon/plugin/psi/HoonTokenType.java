package com.ashelkov.hoon.plugin.psi;

import com.intellij.psi.tree.IElementType;
import org.jetbrains.annotations.NonNls;
import org.jetbrains.annotations.NotNull;

import com.ashelkov.hoon.plugin.HoonLanguage;

public class HoonTokenType extends IElementType {

    public HoonTokenType(@NotNull @NonNls String debugName) {
        super(debugName, HoonLanguage.INSTANCE);
    }

    @Override
    public String toString() {
        return "HoonTokenType." + super.toString();
    }

}
