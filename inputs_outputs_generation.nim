import macros

#This will create a series of statemtns like:
#[ 
template in1() : untyped =
    ins[0][audio_index_loop]
template in2() : untyped =
    ins[1][audio_index_loop]  
]#
#etc...
macro generate_inputs_and_outputs_templates(num_of_inputs : typed, num_of_outputs : typed) : untyped =
    var final_statement = nnkStmtList.newTree()

    #Tree retrieved thanks to:
    #[
        dumpAstGen:
            template in1() : untyped =
                ins[0][audio_index_loop] 
    ]#

    let 
        num_of_inputs_VAL = num_of_inputs.intVal()
        num_of_outputs_VAL = num_of_outputs.intVal()

    for i in 1..max(num_of_inputs_VAL, num_of_outputs_VAL):
        if i <= num_of_inputs_VAL:
            var temp_in_stmt_list = nnkTemplateDef.newTree(
                nnkPostfix.newTree(
                newIdentNode("*"),
                newIdentNode("in" & $i), #name of template
                ),
                newEmptyNode(),
                newEmptyNode(),
                nnkFormalParams.newTree(
                newIdentNode("untyped")
                ),
                newEmptyNode(),
                newEmptyNode(),
                nnkStmtList.newTree(
                nnkBracketExpr.newTree(
                    nnkBracketExpr.newTree(
                    newIdentNode("ins"),             #name of the ins buffer
                    newLit(i - 1)                    #literal value
                    ),
                    newIdentNode("audio_index_loop") #name of the looping variable
                )
                )
            )

            #Accumulate result
            final_statement.add(temp_in_stmt_list)
        
        if i <= num_of_outputs_VAL:
            var temp_out_stmt_list = nnkTemplateDef.newTree(
                nnkPostfix.newTree(
                newIdentNode("*"),
                newIdentNode("out" & $i), #name of template
                ),
                newEmptyNode(),
                newEmptyNode(),
                nnkFormalParams.newTree(
                newIdentNode("untyped")
                ),
                newEmptyNode(),
                newEmptyNode(),
                nnkStmtList.newTree(
                nnkBracketExpr.newTree(
                    nnkBracketExpr.newTree(
                    newIdentNode("outs"),             #name of the ins buffer
                    newLit(i - 1)                    #literal value
                    ),
                    newIdentNode("audio_index_loop") #name of the looping variable
                )
                )
            )
            
            #Accumulate result
            final_statement.add(temp_out_stmt_list)

    return final_statement



generate_inputs_and_outputs_templates(1, 1)

var ins = [[0.0, 0.0, 0.0], [0.0, 0.0, 0.0]]

for audio_index_loop in 0..2:
    in1 = 2.0

echo ins
    
#expandMacros(generate_inputs_templates())


dumpAstGen:
    template in1*() : untyped =
        ins[0][audio_index_loop] 