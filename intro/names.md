## Names
Almost every element has a required **name** [property](properties.md). Provided
value will be used to generate appropriate classes and/or relevant access functions.
As the result, the chosen names must be only alphanumeric and
'_' (underscore) characters, but also mustn't start with a number.
The provided value is case sensitive. However, the code generator is allowed
to change the case of to first letter of the provided value. It is up to the
code generator to choose whether to use **camelCase** or **PascalCase** when
generating appropriate classes and/or access functions.

As the result, the code generator may report an error for the following definition
of fields, which use different names, but differ only in the case of the first
letter.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="someField" type="uint8" />
        <int name="SomeField" type="uint16" />
    </fields>
</schema>
```

The names of the elements must be unique in their scope. It is allowed to 
use the same name in different [namespaces](namespaces.md) or different 
[messages](../messages/messages.md). 
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1">
        <int name="F1"> type="uint8" />
        ...
    </message>

    <message name="Msg2" id="2">
        <int name="F1"> type="int32" />
        ...
    </message>
</schema>
```

