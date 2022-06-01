package com.ashelkov.hoon.plugin;

import com.intellij.lang.annotation.AnnotationHolder;
import com.intellij.lang.annotation.Annotator;
import com.intellij.lang.annotation.HighlightSeverity;
import com.intellij.psi.PsiElement;
import org.jetbrains.annotations.NotNull;

import com.ashelkov.hoon.plugin.psi.*;

public class HoonAnnotator implements Annotator {

    private void annotateConstant(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
        holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
                .range(element.getTextRange())
                .textAttributes(HoonSyntaxHighlighter.TERM)
                .create();
    }

    private void annotatePath(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
        holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
                .range(element.getTextRange())
                .textAttributes(HoonSyntaxHighlighter.PATH)
                .create();
    }

    private void annotateRune(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
        holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
                .range(element.getTextRange())
                .textAttributes(HoonSyntaxHighlighter.RUNE)
                .create();
    }

    private void annotateFordRune(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
        holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
                .range(element.getTextRange())
                .textAttributes(HoonSyntaxHighlighter.FORD_RUNE)
                .create();
    }

    @Override
    public void annotate(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
        if (element instanceof HoonConstant) {
            annotateConstant(element, holder);
        } else if (element instanceof HoonPath) {
            annotatePath(element, holder);
        } else if (element instanceof HoonHoonRune) {
            annotateRune(element, holder);
        } else if (element instanceof HoonFordRune) {
            annotateFordRune(element, holder);
        }
    }

}