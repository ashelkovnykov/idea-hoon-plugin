# Hoon Plugin for IntelliJ IDEA

This is the source code for a plugin to add language support for [Hoon](https://urbit.org/docs/hoon/overview) to the
[IntelliJ IDEA IDE](https://www.jetbrains.com/idea/).

![Hoon Plugin Example](https://plugins.jetbrains.com/files/19294/screenshot_d8eb344d-82c6-4d90-a059-b118dd6f68ed)

## Features

- Syntax checking
- Customizable syntax highlighting
- Comment/uncomment shortcut
- Custom Hoon file icon

## Potential Future Features

- Code completion for faces (6, 10)
- Find usages of faces (11)
- Fold/collapse expressions (12)
- Structure view of file (14)
- Auto-format to code style (15, 16)

## Usage

The plugin is available for download natively through the IDEA plugin marketplace. You can also manually download and
install the plugin from the [JetBrains Marketplace](https://plugins.jetbrains.com/plugin/19294-hoon-language) or from
the [releases page](https://github.com/ashelkovnykov/idea-hoon-plugin/releases) of this repository.

Once downloaded, files ending in `.hoon` will automatically be processed by the plugin. The plugin will check for syntax
errors and highlight tokens/expressions. 

## Development

To help develop this plugin, please complete the prerequisites of the
[IntelliJ Custom Language Support Tutorial](https://plugins.jetbrains.com/docs/intellij/prerequisites.html). Then,
fork this repository, clone your version of the source code, and submit a pull request with whatever changes you think
are needed.

## Known Issues

My guiding principle when writing the plugin was to catch as many syntax errors as possible, while never marking a
correct expression as incorrect. It's impossible for me to capture every single language scenario without re-writing the
entire Hoon compiler in `.bnf` format. For that reason, some syntax errors may slip through.

With that in mind, due to tokenization issues, the following **correct** Hoon language features are currently marked as
incorrect by the plugin:
- Some uses of irregular wutzap (`?!`) (e.g. `!=(1 2)` interpreted as poorly-formed zaptis expression instead of
`?!  .=  1  2`)
- Some uses of irregular tisgal (`=<`) (e.g. `result:~(arm core arg)` interpreted as poorly-formed colsig expression 
instead of `=<  result  %~  arm  core  arg`)
- Some uses of irregular colhep (`:-`) (e.g. `-^+` interpreted as poorly-formed ketlus expression instead of `:-  -  +`)
- siggal (`~<`) and siggar (`~>`) runes, with input `p` taking form `[p=term q=hoon]`, and using form `%foo.hoon`, where
`hoon` begins with a number
- Hoon 151 mold syntax (e.g. `$~`)
- Irregular ketcol (`^:`) form on wing expressions (e.g. `,+.a`)
- Using generic text in the tall SAIL format
