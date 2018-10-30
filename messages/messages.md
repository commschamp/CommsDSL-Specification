# Messages
Every message is defined using **&lt;message&gt;** XML element.

#### Message Name
Every message definition must specify its [name](../intro/names.md) using
**name** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" ...>
        ...
    </message>
</schema> 
```

#### Numeric ID
Every message definition must specify its [numeric](../intro/numeric.md) ID using
**id** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="0x1">
        ...
    </message>
</schema> 
```

It is higly recommended to define "message ID" numeric values as external
[&lt;enum&gt;](../fields/enum.md) field and reuse its values.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <enum name="MsgId" type="uint8" semanticType="messageId">
            <validValue name="Msg1" val=0x1" />
            <validValue name="Msg2" val=0x2" />
        </enum>
    </fields>
    
    <message name="Msg1" id="MsgId.Msg1">
        ...
    </message>
    
    <message name="Msg2" id="MsgId.Msg2">
        ...
    </message>
</schema> 
```

#### Description
It is possible to provide a description of the message about what it is and
how it is expected to be used. This description is only for documentation
purposes and may find it's way into the generated code as a comment for the
generated class. The [property](../intro/properties.md) is **description**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1">
        <description>
            Some long
            multiline
            description
        </description>
        ...
    </message>
</schema>
```

#### Display Name
When various analysis tools display message details, the preference is to 
display proper space separated name (which is defined using **displayName**
[property](../intro/properties.md)) rather than using a [name](../intro/names.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1" displayName="Message 1">
        ...
    </message>
</schema>
```
In case **displayName** is empty, the analysis tools are expected to use value
of **name** [property](../intro/properties.md) instead.

#### Fields
Every **&lt;message&gt;** has zero or more [fields](../fields/fields.md) that 
can be specified as child XML elements.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeCommonField" type="uint16" defaultValue="10" />
    </fields>
    
    <message name="Msg1" id="1">
        <int name="F1" type="uint8" />
        <enum name="F2" type="uint8">
            ...
        </enum>
        <ref field="SomeCommonField" name="F3" />
        <string name="F4" length="8" />
        ...
    </message>
</schema>
```
If there is any other [property](../intro/properties.md) defined as XML child
of the **&lt;message&gt;**, then all the fields must be wrapped in 
**&lt;fields&gt;** XML element for separation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <message name="Msg1" id="1">
        <displayName value="Message 1" />
        <fields>
            <int name="F1" type="uint8" />
        </fields>
    </message>
</schema>
```

Sometimes different messages have the same fields. In order to avoid duplication,
use **copyFieldsFrom** property to specify origininal message.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1">
        <int name="F1" type="uint32" />
    </message>
    
    <message name="Msg2" id="2" copyFieldsFrom="Msg1" />
</schema>
```
In the example above *Msg2* will have the same fields as *Msg1*. 

After copying fields from other message, all other defined fileds will be
appended to copied ones.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1">
        <int name="F1" type="uint32" />
    </message>
    
    <message name="Msg2" id="2" copyFieldsFrom="Msg1">
        <float name="F2" type="float" />
    </message>
</schema>
```
In the example above *Msg2* will have 2 fields: *F1* and *F2*.

#### Ordering
There are protocols that may define various forms of the same message, 
which share the same numberic ID, but are differentiated by a serialization 
length or value of some particular
field inside the message. It can be convenient to define such variants as separate
classes. In case there are multiple **&lt;message&gt;**-es with the same
[numeric ID](#numeric-id), it is required to specify order 
in which they are expected to be processed (read). The ordering is specified
using **order** [property](../intro/properties.md) with unsigned [numeric](../intro/numeric.md)
value. The message object with lower **order** value gets created and its
*read* operation attempted **before** message object with higher value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" nonUniqueMsgIdAllowed="true">
    <message name="Msg1Form1" id="1" order="0" >
        ...
    </message>
    
    <message name="Msg1Form2" id="1" order="1">
        ...
    </message>    
</schema>
```
**NOTE** that there is a need to set **nonUniqueMsgIdAllowed** property of
the [schema](../schema/schema.md) to **true** to allow multiple message objects
with the same numeric ID.

All the **order** values for the same numeric ID must be unique, but not necessarily
sequential.

#### Versioning
**CommsDSL** allows providing an information in what version the message was added
to the protocol, as well as in what version it was deprecated, and whether
it was removed (not supported any more) after deprecation.

To specify the version in which message was introduced, use **sinceVersion**
property. To specify the version in which the message was deprecated, use
**deprecated** property. To specify whether the message was removed after being deprecated
use **removed** property in addition to **deprecated**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big" version="5" >
    <message name="SomeMessage" id="100" sinceVersion="2" >
        ...
    </message>

    <message name="SomeOtherMessage" id="101" sinceVersion="3" deprecated="4" removed="true">
        ...
    </message>
    
</schema>
```
In the example above *SomeMessage* was introduced in version *2*, and 
*SomeOtherMessage* was introduced in version *3*, but deprecated and removed in
version *4*.

**NOTE**, that all the specified versions mustn't be greater that the version
of the [schema](../schema/schema.md). Also value of **sinceVersion** must be
**less** than value of **deprecated**.

The code generator is expected to be able to generate support for specific versions
and include / exclude support for some messages based on their version information.

#### Platforms
Some protocols may be used in multiple independent platforms, while having 
some platform-specific messages. The **CommsDSL** allows listing of the
supported platforms using [&lt;platform&gt;](../intro/platforms.md) XML nodes.
Every message may list platforms in which it must be supported using **platforms**
[property](../intro/properties.md). In case the property's value is empty (default),
the message is supported in **all** the available platforms (if any defined).
The **platforms** property value is coma-separated list of platform names with
preceding **+** if the listed platforms are the one supported, or **-** if 
the listed platforms need to be **excluded** from all available ones.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <platform name="Plat1" />
    <platform name="Plat2" />
    <platform name="Plat3" />
    <platform name="Plat4" />
    
    <message name="Msg1" id="1" platforms="+Plat1,Plat4">
        ...
    </message>
    
    <message name="Msg2" id="2" platforms="-Plat1, Plat2">
        ...
    </message>
</schema> 
```
In the example above *Msg1* is supported only for platforms *Plat1* and *Plat4*,
while *Msg2* is **NOT** supported in *Plat1*, and *Plat2* (i.e. supported in
*Plat3* and *Plat4*).

The main consideration for what format to choose should be whether the platforms 
support for the message should or should **NOT** be added automatically when
new **&lt;platform&gt;** is defined.

#### Sender
In most protocols there are uni-directional messages. The **CommsDSL**
allows definition of entity that sends a particular message using **sender**
property. Available values are **both** (default), **server**, and **client**.
The code generator may use provided information and generate some auxiliary code
and/or data structures to be used for *client* and/or *server* implementation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1" sender="client">
        ...
    </message>
    
    <message name="Msg2" id="2" sender="server">
        ...
    </message>

    <message name="Msg3" id="2">
        ...
    </message>
</schema> 
```
In the example above *Msg1* and *Msg2* are uni-directional messages, while
*Msg3* is bi-directional.

#### Customization
The code generator is expected to allow some level of compile time customization of the 
generated code, such as enable/disable generation of particular virtual functions. 
The code generator is also expected to provide command line
options to choose required level of customization. Sometimes it may be required
to allow generated message class to be customizable regardless of the customization
level requested from the code generator. **CommsDSL** provides **customizable**
property with [boolean](../intro/boolean.md) value to force any message to being
customizable at compile time.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1" customizable="true">
        ...
    </message>
</schema>
```

Use [properties table](../appendix/message.md) for future references.

