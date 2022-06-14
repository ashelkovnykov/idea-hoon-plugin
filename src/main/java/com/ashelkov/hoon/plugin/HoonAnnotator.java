package com.ashelkov.hoon.plugin;

import com.intellij.lang.annotation.AnnotationHolder;
import com.intellij.lang.annotation.Annotator;
import com.intellij.lang.annotation.HighlightSeverity;
import com.intellij.openapi.editor.DefaultLanguageHighlighterColors;
import com.intellij.openapi.util.TextRange;
import com.intellij.psi.PsiElement;
import org.jetbrains.annotations.NotNull;

import com.ashelkov.hoon.plugin.psi.HoonComplexPath;
import com.ashelkov.hoon.plugin.psi.HoonIrregularNotEqExpression;

public class HoonAnnotator implements Annotator {

    private void annotateComplexPath(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
        holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
                .range(element.getTextRange())
                .textAttributes(HoonSyntaxHighlighter.PATH)
                .create();
    }

    private void annotateNotEq(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
        holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
                .range(TextRange.create(element.getTextRange().getStartOffset(), element.getTextRange().getStartOffset() + 2))
                .textAttributes(DefaultLanguageHighlighterColors.IDENTIFIER)
                .create();
    }

    @Override
    public void annotate(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
        if (element instanceof HoonComplexPath) {
            annotateComplexPath(element, holder);
        } else if (element instanceof HoonIrregularNotEqExpression) {
            annotateNotEq(element, holder);
        }
    }

}