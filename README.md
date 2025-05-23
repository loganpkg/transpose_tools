
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

Transpose Tools is scripting language for editing huge files. Files can also be
edited interactively, producing a script of changes, which can later be
executed on the original file to replay the same changes. The internal data
structures are immutable and there is unlimited undo. Huge files are
efficiently edited, even on machines with limited random access memory, by
leveraging off the virtual memory mappings provide by x86-64 CPUs and modern
kernels.
