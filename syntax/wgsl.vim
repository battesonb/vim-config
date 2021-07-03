" Vim syntax file
" Language: WebGPU Shader Language

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "wgsl"

" Basics
syn keyword conditional if else
syn keyword repeat for
syn keyword basicKeyword struct var fn let return
syn keyword operator * + - /
syn match float '\d*\.\d\+'
syn match comment '//.*'
syn keyword builtinFunctions
  \ cos
  \ dot
  \ max
  \ min
  \ normalize
  \ pow
  \ sin
  \ tan
  \ textureSample

hi def link conditional      Conditional
hi def link repeat           Repeat
hi def link basicKeyword     Keyword
hi def link operator         Operator
hi def link float            Number
hi def link comment          Comment
hi def link builtinFunctions Special

" Pre-processors
syn match preProcStart '\[\[' nextgroup=preProcKeyword,preProcFunction,preProcEnd
syn keyword preProcKeyword nextgroup=preProcEnd contained
  \ block
syn match preProcEnd '\]\]' contained

syn keyword preProcFunction nextgroup=preProcFunctionStart contained
  \ binding
  \ builtin
  \ group
  \ location
  \ stage

syn match preProcFunctionSeparator ', *' nextgroup=preProcFunction contained

syn match preProcFunctionStart '(' nextgroup=preProcFunctionArgument,preProcFunctionNumericArgument contained
syn match preProcFunctionEnd ')' nextgroup=preProcFunctionSeparator,preProcEnd contained

syn match preProcFunctionNumericArgument '\d*' nextgroup=preProcFunctionEnd contained
syn keyword preProcFunctionArgument nextgroup=preProcFunctionEnd contained
  \ fragment
  \ position
  \ vertex

hi def link preProcStart             PreProc
hi def link preProcEnd               PreProc
hi def link preProcKeyword           PreProc
hi def link preProcFunction          PreProc
hi def link preProcFunctionArgument  PreProc
hi def link preProcFunctionNumericArgument Number
hi def link preProcFunctionStart     PreProc
hi def link preProcFunctionEnd       PreProc

" Types
syn keyword typeTemplateKey
  \ vec2
  \ vec3
  \ vec4
  \ texture_2d
  \ mat3x3
  \ mat4x4
  \ nextgroup=typeTemplate
syn region typeTemplate matchgroup=typeTemplateKey start='<' end='>' contains=basicType contained
syn keyword basicType f32 sampler

syn match customType 'struct \w+'hs=s+7

hi def link typeTemplateKey Type
hi def link basicType       Type
hi def link customType      Type

