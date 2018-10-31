## Common Properties of Layers
Every layer is different, and defines its own properties and/or other aspects.
However, there are common properties, that are applicable to every layer. 
They are summarized below.

#### Name 
Every layer must define it's [name](../intro/names.md), which is expected to be 
used by a code generator when defining a relevant class. The name is defined
using **name** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <id name="Id" ... />
        <payload name="Data">
    </frame>
</schema>
```

#### Description
It is possible to provide a description of the layer about what it is and
how it is expected to be used. This description is only for documentation
purposes and may find it's way into the generated code as a comment for the
generated class. The [property](../intro/properties.md) is **description**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <id name="Id" ...>
            <description>
                Some long
                multiline
                description
            </description>        
        </id>
        <payload name="Data">
    </frame>
</schema>
```

#### Inner Field
Every layer, except for [&lt;payload&gt;](frames/payload.md), needs to specify
its inner [field](../fields/fields.md) it wraps. The field can be specified
as XML child element.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <id name="Id">
            <int name="IdField" type="uint8" />  
        </id>
        <payload name="Data">
    </frame>
</schema>
```
If there is any other [property](../intro/properties.md) defined as XML child
of the layer, then the inner field must be wrapped in 
**&lt;field&gt;** XML element for separation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <id>
            <name value="Id" />
            <field>
                <int name="IdField" type="uint8" />  
            </field>
        </id>
        <payload name="Data">
    </frame>
</schema>
```
If the inner field is defined globally in **&lt;fields&gt;** section, it can
be referenced using **field** property.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <enum name="MsgId" type="uint8" semanticType="messageId">
            <validValue name="Msg1" val=0x1" />
            <validValue name="Msg2" val=0x2" />
        </enum>
    </fields>
    
    <frame name="ProtocolFrame">
        <id name="Id" field="MsgId" />
        <payload name="Data">
    </frame>
</schema>
```

Use [properties table](../appendix/layers.md) for future references.
