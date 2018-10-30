## Schema
Schema definition may contain various global (protocol-wide) 
[properties](../intro/properties.md).

#### Protocol Name
The protocol name is defined using **name** property. It may contain any
alphanumeric character, but mustn't start with a number. 
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol">
    ...
</schema>
```
The **name** property is a **required** one. The code generator must report
an error in case first processed schema file doesn't define one.

The code generator is expected to use the specified name as main namespace
for the protocol definition, unless new name is provided via command line
parameters.

#### Endian
Default endian for the protocol can be defined using **endian** property. Supported
values are either **big** or **little** (case insensitive). Defaults to **little**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="Big">
    ...
</schema>
```
The **endian** property of any subsequently defined [field](../fields/fields.md) 
will default to the specified value, but can be overridden using
its own **endian** property. 

#### Description
It is possible to provide a human readable description of the protocol definition
just for documentation purposes. The description is provided using **description**
property of the **&lt;schema&gt;** node. Just like any [property](../intro/properties.md)
the description can be provided using one of the accepted ways. In case of
long multiline description it is recommended to define it as a text child element.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol">
    <description> 
        Some 
        multiline
        description
    </description>
    ...
</schema>
```

#### Protocol (Schema) Version
As was mentioned in [Protocol Versioning](../intro/protocol_versioning.md) section
**CommsDSL** supports (but doesn't enforce) versioning of the schema / protocol.
In order to specify the version use **version** property with unsigned integral
value. Defaults to **0**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" version="5">
    ...
</schema>
```
In case the protocol definition uses[semantic versioning](https://semver.org/) 
with major / minor numbers, it is recommended to combine multiple numbers into one
mentally using "shift" operation(s).
For example version **1.5** can be defined and used throughout the schema as **0x105**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" version="0x105">
    ...
</schema>
```

#### DSL Version
As this specification evolves over time it can introduce new properties or
other elements. It is possible to specify the version of the **DSL** as the schema's
property. If code generator expects earlier version of the schema it is expected
to report an error (or at least warning). 

The DSL version is specified using **dslVersion** property with unsigned integral
value. Defaults to **0**, which means any version of code generator will try to
parse the schema and will report error / warning in case it encounters unrecognized
property or other construct.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" dsLVersion="2">
    ...
</schema>
```

#### Allowing Non-Unique Message IDs
By default every defined [message](../messages/messages.md) must have unique 
numeric message ID. If this is not the case, the code generator must report an
error in case message definition with repeating ID number is encountered.
It is done as protection against various copy/paste or typo errors. 

However, there are protocols that may define various forms of the same message, 
which are differentiated by a serialization length or value of some particular
field inside the message. It can be convenient to define such variants as separate
classes. **CommsDSL** allows doing so by setting **nonUniqueMsgIdAllowed** property
of the schema to **true**. In this case, code generator must allow definition of
different messages with the same numeric ID.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" nonUniqueMsgIdAllowed="true">
    <message name="SomeMessageForm1" id="1">
        ...
    </message>
    
    <message name="SomeMessageForm2" id="1">
        ...
    </message>    
</schema>
```

Use [properties table](../appendix/schema.md) for future references.
