## Protocol Versioning
The **CommsDSL** allows provides a way to specify version of the binary
protocol by using **version** property of the [schema](../schema/schema.md)
element.

Other elements, such as [fields](../fields/fields.md) or 
[messages](../messages/messages.md) allow specification of version they were
introduced by using **sinceVersion** property. It is also possible to provide
an information about version since which the element has been deprecated using
**deprecated** property. Usage of **deprecated** property is just an indication for
developers that the element should not be used any more. The code generator may
introduce this information as a comment in the generated code. However, it does not remove
a deprecated [field](../fields/fields.md) from being serialized to preserve
backward compatibility of the protocol. If the protocol definition does require
removal of the deprecated field from being serialized, the **deprecated**
property must be supplemented with **removed** property.

For example:
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big" version="5" >
    <message name="SomeMessage" id="1">
        <int name="F1" type="uint16" />
        <int name="F2" type="uint8" sinceVersion="2" />
        <int name="F3" type="int32" sinceVersion="3" deprecated="4" removed="true" />
    </message>
</schema>
```
In the example above field **F2** was introduced in version 2. The field **F3**
was introduced in version 3, but deprecated and removed in version 4.

All these version numbers in the schema definition allow generation of proper version checks
and correct code for protocols that communicate their version in their 
[framing](../frames/frames.md) or selected messages. Please refer to
[Protocol Versioning Summary](../versioning/versioning.md) chapter for more details on
the subject.

For all other protocols that don't report their version and/or don't care about
backward compatibility, the version information in the schema just serves as 
documentation. The code generator must ignore the version information when
generating code for such protocols. The code generator may also allow generation
of the code for a specific version and take provided version information on
determining whether specific field exists for a particular version.
