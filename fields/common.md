## Common Properties of Fields
Every field is different, and defines its own properties and/or other aspects.
However, there are common properties, that are applicable to every field. 
The are summarized below.

#### Name 
Every field must define it's [name](../intro/names.md), which is expected to be 
used by a code generator when defining a relevant class. The name is defined
using **name** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeField" ... />
    </fields>
</schema>
```

#### Description
It is possible to provide a description to the field of what it is and
how it is expected to be used. This description is only for documentation
purposes and may find it's way into the generated code as a comment for the
generated class. The property is **description**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeField" type="uint8">
            <description>
                Some long
                multiline
                description
            </description>
        </int>
    </fields>
</schema>
```

#### Reusing Other Fields
Sometimes two different fields are very similar, but differ in one particular
aspect. **CommsDSL** allows copying all the properties from previously defined
field and change value of some properties after the copy. For example:

```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8" defaultValue="3" />
        <bitfield name="SomeBitfield>
            <int name="Member1" reuse="SomeIntField" bitLength="3" />
            <int name="Member2" type="uint8" defaultValue="10" bitLength="5" />
        </bitfield>
    </fields>
</schema>
```
In the example above member of the bitfield **Member1** copies all the properties
from **SomeIntField** field, then overrides its **name** and adds **bitLength**
one to specify its length in bits.

The **reuse** is allowed only from the field of the same **kind**. For example,
it is **NOT** allowed for [&lt;enum&gt;](enum.md) field to reuse definition of
[&lt;int&gt;](int.md), only other [&lt;enum&gt;](enum.md).

#### Display Properties
**CommsDSL** allows also generation of not only field's serialization and
value access functionality, but also of various GUI protocol visualization, debugging and
analysis tools. There are some allowed properties, that indicate how the 
field is expected to be displayed by such tools.

The **displayName** property is there to specify proper string of the field's
name, with spaces, dots and other characters that are not allowed to exist in
the [name](../intro/names.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" displayName="Some Int Field" ... />
    </fields>
</schema>
```

If **displayName** is not specified, the code generator must use value of property
**name** instead. In order to force empty name to display, use "_" (underscore).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" displayName="_" ... />
    </fields>
</schema>
```

The values of some fields may be controlled by other fields. In this case, it
could be wise to disable manual update of such fields. To enable/disable such
behavior use **displayReadOnly** property with [boolean](../intro/boolean.md)
value.

Sometimes, it can be desirable to completely hide some field 
from being displayed in the protocol analysis GUI application. In this case
use **displayHidden** property with [boolean](../intro/boolean.md)
value.

#### Versioning
**CommsDSL** allows providing an information in what version the field was added
to a particular message, as well as in what version it was deprecated, and whether
it was removed from being serialized after deprecation.

To specify the version in which field was introduced, use **sinceVersion**
property. To specify the version in which the field was deprecated, use
**deprecated** property. To specify whether the field was removed after deprecated
use **removed** property in addition to **deprecated**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big" version="5" >
    <message name="SomeMessage" id="1">
        <int name="F1" type="uint16" />
        <int name="F2" type="int8" deprecated="5" />
        <int name="F3" type="uint8" sinceVersion="2" />
        <int name="F4" type="int32" sinceVersion="3" deprecated="4" removed="true" />
    </message>
</schema>
```
In the example above:
- **F1** was introduced in version **0** and hasn't been deprecated yet.
- **F2** was also introduced in version **0**, deprecated in version **5**, but **not**
removed from being serialized.
- **F3** was introduced in version **2** and hasn't been deprecated yet.
- **F4** was introduced in version **3**, deprecated in removed in version **4**.

**NOTE**, that all the specified version mustn't be greater that the version
of the [schema](../schema/schema.md). Also value of **sinceVersion** must be
**less** than value of **deprecated**.

The version information on the field in global **&lt;fields&gt;** area or 
inside some [namespace](../intro/namespaces.md) does **NOT** make sense and 
should be ignored by the code generator. It is allowed when field is a member
of a [message](../messages/messages.md) or a [bundle](bundle.md) field.


#### Failing Read of the Field on Invalid Value
Some fields may specify what values are considered to be valid, and there may
be a need to fail the **read** operation in case the received value is invalid.

To achieve this, **failOnInvalid** property with [boolean](../intro/boolean.md)
value can be used. There are two main scenarios that may require usage of this
property. One is the protocol being implemented requires such behavior in its
specification. The second is when there are multiple forms of the same message 
which are differentiated by the value of some specific field in its payload.
For example:
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big" nonUniqueMsgIdAllowed="true" >
    <message name="Msg1Kind0" id="1" order="0">
        <int name="Kind" type="uint8" validValue="0" failOnInvalid="true" />
        ...
    </message>

    <message name="Msg1Kind1" id="1" order="1">
        <int name="Kind" type="uint8" defaultValue="1" validValue="1" failOnInvalid="true" />
        ...
    </message>

    <message name="Msg1Kind2" id="1" order="2">
        <int name="Kind" type="uint8" defaultValue="2" validValue="2" failOnInvalid="true" />
        ...
    </message>
</schema>
```
The example above defined 3 variants of the message with numeric ID equals to **1**.
When new message with this ID comes in, the [framing](../frames/frames.md) code 
is expected to try reading all of the variants and choose one, on which **read** 
operation doesn't fail. The **order** property of the message specifies in
what order the messages with the same ID must be read. It described in more
detail in [messages](../messages/messages.md) chapter.

#### Pseudo Fields
Sometimes there may be a need to have "psuedo" fields, which are implemented
using proper field abstration, and are handled as
any other field, but not actually getting serialized when written (or deserialized
when read). It can be achieved using **pseudo** property with [boolean](../intro/boolean.md) 
value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big" version="5" >
    <message name="SomeMessage" id="1">
        <int name="SomePseudoField" type="uint16" defaultValue="0xabcd" pseudo="true" />
        <int name="SomeRealField" type="int8">
        ...
    </message>
</schema>
```

#### Customizable Fields
The code generator is expected to allow some level of compile time customization of the 
generated code, such as choosing different data structures and/or adding/replacing
some runtime logic. The code generator is also expected to provide command line
options to choose required level of customization. Sometimes it may be required
to allow generated field abstraction to be customizable regardless of the customization
level requested from the code generator. **CommsDSL** provides **customizable**
option with [boolean](../intro/boolean.md) value to force any field being
customizable at compile time.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <string name="SomeField" customizable="true" />
    </fields>
</schema>
```

#### Semantic Type
Sometimes code generator may generate a bit different (or better) code for fields that are
used for some particular purpose. To specify such purpose use **semanticType**
property. 

Available semantic types are:
- **messageId** - Used to specify what type/field is used for holding numeric 
message ID. Applicable to [&lt;enum&gt;](enum.md) and [&lt;int&gt;](int.md)
fields.
- **version** - Used to specify that the field is used to hold protocol version.
Applicable to [&lt;int&gt;](int.md) field.

```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <enum name="MsgId" type="uint8" semanticType="messageId" >
            <validValue name="Msg1" val="0x01" />
            <validValue name="Msg2" val="0x02" />
            <validValue name="Msg3" val="0x03" />
            ...
        </enum>
    </fields>
</schema>
```

Use [properties table](../appendix/fields.md) for future references.
