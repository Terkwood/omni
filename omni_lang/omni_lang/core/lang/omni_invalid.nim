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

let omni_invalid_idents* {.compileTime.} = [
    "Data", "Delay", "Buffer", "UGen"
]

let omni_invalid_ends_with* {.compileTime.} = [
    "def_export", "def_dummy",
    "module_inner",
    "struct_inner", "struct_new_inner", "struct_export"
]

let omni_invalid_variable_names* {.compileTime.} = [
    "ins", "inputs",
    "outs", "outputs",
    "init", "initialize", "initialise", "build",
    "perform", "sample",
    "sig", "sig32", "sig64",
    "signal", "signal32", "signal64",
    "Data", "Buffer", "Delay"
]