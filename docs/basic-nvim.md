# Basic Neovim User Guide

## Quick Read help.txt

For unclear commands, you can use `:help <command>` to get more information

| WHAT                 | PREPEND | EXAMPLE             |
| -------------------- | ------- | ------------------- |
| Normal mode command  |         | `:help x`           |
| Visual mode command  | v\_     | `:help v_u`         |
| Insert mode command  | i\_     | `:help i_<Esc>`     |
| Command-line command | :       | `:help :quit`       |
| Command-line editing | c\_     | `:help c_<Del>`     |
| Vim command argument | -       | `:help -r`          |
| Option               | '       | `:help 'textwidth'` |
| Regular expression   | /       | `:help /[`          |

### Basic Editing

Editing a file with Vim means:

1. reading the file into a _buffer_
2. changing the _buffer_ with editor commands
3. writing the _buffer_ into a file

### cursor motions

Experienced users prefer the hjkl keys because they are always right under their fingers.
The motion commands can be used after an operator command, to have the command operate on the text that was moved over.

The following operators are available:

| Operator | Description                                   |
| -------- | --------------------------------------------- |
| c        | change                                        |
| d        | delete                                        |
| y        | yank into register (does not change the text) |
| ~        | swap case (only if 'tildeop' is set)          |
| g~       | swap case                                     |
| !        | filter through an external program            |
| >        | shift right                                   |
| <        | shift left                                    |

e.g "2d2w" two time delete two words. "yfe" yanks from the cursor to the next e, not to change the course position, if use the "yFe" the cursor will be moved to the before e.

#### left-right motions

| Motion | Description                      |
| ------ | -------------------------------- |
| h      | move left                        |
| l      | move right                       |
| Home   | move start of line               |
| End    | move end of line                 |
| f      | forward to next character        |
| t      | forward to before next character |
| , ;    | repeat last f or t               |

#### up-down motions

| Motion   | Description           |
| -------- | --------------------- |
| j        | move down             |
| k        | move up               |
| G        | move to end of file   |
| gg       | move to start of file |
| {count}% | move to line {count}  |

#### word motions

| Motion | Description                    |
| ------ | ------------------------------ |
| w      | move to start of next word     |
| e      | move to end of word            |
| b      | move to start of previous word |

#### text object motions

| Motion | Description                    |
| ------ | ------------------------------ |
| ( )    | move to start/end of sentence  |
| { }    | move to start/end of paragraph |

_section motions_

| Motion | Description                       |
| ------ | --------------------------------- |
| `]]`   | move forward to next section      |
| `[[`   | move backward to previous section |
| `][`   | move to end of current section    |
| `[]`   | move to start of current section  |

**Examples of section motions:**

Sections are typically defined by function definitions, class declarations, or other structural elements in code files. In markdown files, sections are usually headers.

```python
# Example Python file structure:

def function1():     # <- [[ will jump to previous function
    pass             #    ]] will jump to next function

def function2():     # <- Current cursor position
    pass

def function3():     # <- ]] will jump here from function2
    pass             #    [[ will jump back to function2
```

**Note:** The exact behavior of `]]` and `[[` depends on the file type and can be customized. In some languages, they jump between functions, classes, or other syntactic structures.

#### text object selection

This is a series of commands that can only be used while in Visual mode or after an operator. "a", "i" used to select text objects, "a" means "around" and "i" means "inner".

| command | Description                               |
| ------- | ----------------------------------------- |
| v_aw    | select a word (including spaces)          |
| v_iw    | select inner word (excluding spaces)      |
| v_as    | select a sentence                         |
| v_is    | select inner sentence                     |
| v_ap    | select a paragraph (including spaces)     |
| v_ip    | select inner paragraph (excluding spaces) |

#### Marks

use the `m{a-zA-Z}` command to set a mark at the current cursor position, and use `'{a-zA-Z}` to jump to that mark.

#### Jumps

A "jump" is a command that normally moves the cursor several lines away. If
you make the cursor "jump" the position of the cursor before the jump is
remembered. You can return to that position with the "''" and "``" commands,
unless the line containing that position was changed or deleted.  The
following commands are "jump" commands: "'", "`", "G", "/", "?", "n", "N",
"%", "(", ")", "[[", "]]", "{", "}", ":s", ":tag", "L", "M", "H" and the
commands that start editing a new file.

| Jump   | Description            |
| ------ | ---------------------- |
| ctrl-o | jump to older position |
| ctrl-i | jump to newer position |

#### various motions

| command | Description          |
| ------- | -------------------- |
| `]m`    | start of next method |
