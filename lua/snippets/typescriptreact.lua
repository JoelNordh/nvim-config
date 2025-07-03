
return {
  s("InputField",
    fmt([[
    <InputField
      id={}
      label="{}"
      type="{}"
      value={{useBlackboardValue(`{}`)}}
      command={{(value) => ( {{
        commandName= "{}",
        arguments: {{
        //PLACEHOLDER
        }}
      }})}}
    ]], {
        i(1, "Id"),
        i(2, "label"),
        i(3, "type"),
        i(4, "BlackboardPath"),
        i(5, "CommandName")
      })
  )
}
