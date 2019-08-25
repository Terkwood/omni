#nim c --app:lib --gc:none --noMain:on -d:supercollider -d:release -d:danger

import macros
import dsp_macros
import dsp_print
import sc_types
import math

#For rt_alloc/rt_alloc0/rt_realloc/rt_free
import RTAlloc/rt_alloc

import RTAlloc/sc_data
    
ins 1:
    "freq"

outs 1:
    "sine_out"


expandMacros:
    struct Phasor[T]:
        phase : T

expandMacros:
    struct Something[T, Y]:
        a : T
        b : Data[Y]

expandMacros:
    struct SomeOtherStruct[T, Y]:
        phasor : Phasor[T]
        something : Something[T, Y]

proc PhasorDefault() : Phasor[float] =
    result = Phasor.init(0.0)

proc someProcForPhasor[T](p : Phasor[T]) : void =
    p.phase = 0.23
 
expandMacros:
    constructor:
        let 
            sampleRate = 48000.0
            phasor   = PhasorDefault()
            something = Something.init(0.0, Data.init(100))
            someOtherStruct = SomeOtherStruct.init(phasor, something)
            someData = Data.init(100)

        var 
            phase = 0.0
            anotherVar = phase
        
        new phase, sampleRate, phasor, someData, anotherVar, someOtherStruct

expandMacros:
    perform:
        var 
            frequency : float
            sine_out : float

        sample:
            frequency = in1

            if phase >= 1.0:
                phase = 0.0
            
            #Can still access the var inside the object, even if named the same as another "var" declared variable (which produces a template with same name)
            phasor.phase = 2.3
            
            #Test fuctions aswell
            someProcForPhasor(phasor)

            sine_out = cos(phase * 2 * PI) #phase equals to phase_var[]
            
            out1 = sine_out

            phase += abs(frequency) / (sampleRate - 1) #phase equals to phase_var[]

#################
# TESTING SUITE #
#################
#[ 
var 
    ins_ptr_void  = alloc0(sizeof(ptr cfloat) * 2)      #float**
    in_ptr1_void = alloc0(sizeof(cfloat) * 512)         #float*

    ins_ptr_SC = cast[ptr ptr cfloat](ins_ptr_void)
    ins_ptr = cast[CFloatPtrPtr](ins_ptr_void)
    in_ptr1 = cast[CFloatPtr](in_ptr1_void)

    outs_ptr_void  = alloc0(sizeof(ptr cfloat) * 2)     #float**
    out_ptr1_void = alloc0(sizeof(cfloat) * 512)        #float*
    
    outs_ptr_SC = cast[ptr ptr cfloat](outs_ptr_void)
    outs_ptr = cast[CFloatPtrPtr](outs_ptr_void)
    out_ptr1 = cast[CFloatPtr](out_ptr1_void)

#Fill frequency input with 200hz
for i in 0 .. 511:
    in_ptr1[i] = 200.0

ins_ptr[0]  = in_ptr1
outs_ptr[0] = out_ptr1

var ugen = UGenConstructor()

UGenPerform(ugen, cast[cint](512), ins_ptr_SC, outs_ptr_SC)

dealloc(ins_ptr_void)
dealloc(in_ptr1_void)
dealloc(outs_ptr_void)
dealloc(out_ptr1_void)

UGenDestructor(ugen)
 ]#