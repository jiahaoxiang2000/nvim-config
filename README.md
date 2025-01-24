# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Goal

Using **no mouse** operation while coding allows us to be more efficient at work.
And let the  **plugin** can easy modify and extend.

## Issue

- FIXME: Document Scrolling Issue
  - The <c-u> and <c-d> keys do not work for scrolling the document.
- FIXME: Command Line Issue
  - The <c-u> and <c-d> keys do not work in the command line.
- NOTE: Configuration Override
  - If you add custom configurations to lua/plugins/*.lua, it will override the default LazyVim configuration.
  - If you do not properly handle the configuration to preserve LazyVim's defaults, some features that rely on integrations with other plugins in the LazyVim ecosystem may break.
