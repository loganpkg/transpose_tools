
<!--

Copyright (c) 2025 Commonwealth of Australia

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

-->

Transpose Tools
===============

Transpose Tools is a scripting language with an interactive editor for
modifying huge files. Interactive editing producing a script of changes, which
can later be executed on the original file to replay the same modifications.
That is, the interactive editing and scripting language are equivalent. The
internal data structures are immutable and there is unlimited undo. Huge files
are efficiently edited, even on machines with limited random access memory, by
leveraging off the virtual memory mappings provide by x86-64 CPUs and modern
kernels.


Assembly Style
--------------

When performing system calls, the specific Application Binary Interface (ABI)
of the target kernel must be used.

Beyond this, this projects uses the following assembly rules:

* Arguments are passes as per the System V ABI.
* Return value is as per the System V ABI.
* No 16-byte stack alignment is required (only 8-byte).
* All registers are non-volatile (that is "callee-saved" or "call-preserved"),
    except for the register used to hold the return value.
* Stack frames are always used, even in leaf functions.



Abbreviations
-------------

| Abbreviation | Expansion                    |
| :----------- | :--------------------------- |
| tt           | Transpose Tools              |
| lib          | Library                      |
| str          | String                       |
| len          | Length                       |
| fd           | File descriptor              |
| std          | Standard                     |
| err          | Error                        |
| asm          | Assembler / Assembly         |
| defs         | Definitions                  |
| func         | Function                     |
| arg          | Argument                     |
| sys          | System (Kernel)              |
| num          | Number                       |
| ABI          | Application Binary Interface |
| hdl          | Handle                       |
| opt          | Option                       |
