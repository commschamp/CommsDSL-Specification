# Interfaces
There are protocols that attach some extra information, such as version and/or
extra flags, to the message transport [framing](../frames/frames.md). This extra information
usually influences how message fields are deserialized and/or how message object
is handled. It means that these received extra values need to be attached to
**every** message object. The **CommsDSL** allows specification of such extra
information as **&lt;interface&gt;** XML element with extra [fields](../fields/fields.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <interface name="CommonInterface">
        <int name="Version" type="uint8" semanticType="version" />
        <set name="Flags" length="1">
            ...
        </set>
    </interface>
</schema> 
```
The code generator may use provided information to generate common interface
class(es) for all the messages. Such class will serve as base class of every
message object and will contain required extra information.

**NOTE** that specified fields, are **NOT** part of every message's payload.
These fields are there to hold extra values delivered as part of message 
[framing](../frames/frames.md).

#### Interface Name
Every interface definition must specify its [name](../intro/names.md) using
**name** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <interface name="CommonInterface">
        ...
    </interface>
</schema> 
```

#### Description
It is possible to provide a description of the interface about what it is and
how it is expected to be used. This description is only for documentation
purposes and may find it's way into the generated code as a comment for the
generated class. The [property](../intro/properties.md) is **description**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <interface name="CommonInterface">
        <description>
            Some long
            multiline
            description
        </description>
        ...
    </interface>
</schema>
```

#### More About Fields
Similar to **&lt;message&gt;** every **&lt;interface&gt;** has zero or more [fields](../fields/fields.md) that 
can be specified as child XML elements. If there is any other 
[property](../intro/properties.md) defined as XML child
of the **&lt;interface&gt;**, then all the fields must be wrapped in 
**&lt;fields&gt;** XML element for separation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <interface>
        <name value="CommonInterface" />
        <fields>
            <int name="Version" type="uint8" semanticType="version" />
        </fields>
    </message>
</schema>
```

Sometimes different interfaces have common set of fields. In order to avoid duplication,
use **copyFieldsFrom** property to specify original interface and then add
extra fields when needed.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <interface name="Interface1">
        <int name="Version" type="uint8" semanticType="version" />
    </interface>
    
    <interface name="Interface2" copyFieldsFrom="Interface1">
        <set name="Flags" length="1">
            ...
        </set>
    </interface>
</schema>
```
In the example above *Interface2* will have **2** fields: "Version" and "Flags". 

If the protocol doesn't have any extra values delivered in message framing, then
the whole definition of the  **&lt;interface&gt;** XML element can be omitted.
If no **&lt;interface&gt;** node has been added to the protocol schema, then 
the code generator must treat schema as if the schema has implicit definition
of the single **&lt;interface&gt;** with no fields. It is up to the code generator
to choose name for the common interface class it creates.

**NOTE** usage of **semanticType="version"** for the field holding protocol
version in the examples above. It is required to be used for proper 
[protocol versioning](../versioning/versioning.md). The value of the field
having "version" value as **semanticType** property, will be considered 
for fields that, were introduced and/or deprecated at some stage, i.e. use
**sinceVersion** and/or **derecated** + **removed** properties.

#### Alias Names to Fields
Sometimes an contained field may be renamed and/or moved. It is possible to
create alias names for the fields to keep the old client code being able to compile
and work. Please refer to [Aliases](../aliases/aliases.md) chapter for more details.

Use [properties table](../appendix/interface.md) for future references.
