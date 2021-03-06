# MIT License
# 
# Copyright (c) 2020 Francesco Cameli
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#C file to compile together
{.compile: "./omni_print.c".}

#Pass optimization flag to C compiler
{.localPassc: "-O3".}
{.passC: "-O3".}

proc omni_print_debug*   (format_string : cstring, value : culong) : void {.importc: "omni_print_debug_C", cdecl.}
proc omni_print_str*     (format_string : cstring)                 : void {.importc: "omni_print_str_C", cdecl.}
proc omni_print_float*   (value : cfloat)                          : void {.importc: "omni_print_float_C", cdecl.}
proc omni_print_int*     (value : cint)                            : void {.importc: "omni_print_int_C", cdecl.}

#string
template print*(str : string) : untyped =
    omni_print_str(str)

#float
template print*[T : SomeFloat](val : T) : untyped =
    omni_print_float(cfloat(val))

#int
template print*[T : SomeInteger](val : T) : untyped =
    omni_print_int(cint(val))