## &lt;data&gt; Field
This field stores and abstracts away value of a raw bytes data. 
The **&lt;data&gt;** field has all the [common](common.md) properties
as well as extra properties and elements described below.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <data name="SomeDataField" />
    </fields>
</schema>
```
Such definition of the **&lt;data&gt;** does **NOT** have any limit on
the length of the data, and will consume all the available bytes in the 
input buffer.

#### Default Value
The default value of the **&lt;data&gt;** field when constructed can be specified
using **defaultValue** [property](../intro/properties.md). The value of the
property must be case-insestive string of hexadecimal values with even number 
of characters. The allowed ranges of the characters are: ['0' - '9'], and ['a' - 'f'].
The ' ' (space) character is also allowed for convenient separation of the bytes.
If not specified, defaults to empty data.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <data name="SomeDataField" defaultValue="0123 45 67 89 ab cd eF" />
    </fields>
</schema>
```
The example above is expected to create approprate raw data abstracting field, 
containing 8 bytes: [0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef] when
default constructed.

#### Fixed Length
In case the data value needs to be serialized using predefined fixed length,
use **length** property to specify the required value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <data name="SomeDataField" length="16" />
    </fields>
</schema>
```

#### Length Prefix
Many protocols prefix raw binary data with its length. The **CommsDSL** allows definition
of such prefix using **lengthPrefix** child element, which must define prefix as
[&lt;int&gt;](int.md) field.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <data name="SomeDataField">
            <lengthPrefix>
                <int name="LengthPrefix" type="uint16" />
            </lengthPrefix>
        <data>
    </fields>
</schema>
```
In case the prefix field is defined as external field, **CommsDSL** allows
usage of **lengthPrefix** as [property](../intro/properties.md), value of
which contains name of the referenced field.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="DataLengthPrefix" type="uint8" />
        <data name="SomeDataField" lengthPrefix="DataLengthPrefix" />
    </fields>
</schema>
```
The **CommsDSL** also supports **detached** length prefix, when there is
several other fields in the [&lt;message&gt;](../messages/messages.md) or in the
[&lt;bundle&gt;](bundle.md) between the length field and the **&lt;data&gt;**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <bundle name=SomeBundle">
            <int name="DataLengthPrefixMember" type="uint16" />
            <int name="SomeOtherFieldMember" type="uint16" />
            <data name="SomeDataFieldMember" lengthPrefix="$DataLengthPrefixMember" />
        </bundle>
    </fields>
    
    <message name="Msg1" id="1">
        <int name="DataLengthPrefix" type="uint16" />
        <int name="SomeOtherField" type="uint16" />
        <data name="SomeDataField" lengthPrefix="$DataLengthPrefix" />
    </message>
</schema>
```
**NOTE**, the existence of **$** prefix when specifying **lengthPrefix** value.
It indicates that the referenced field is in the containing
[&lt;message&gt;](../messages/messages.md) or the
[&lt;bundle&gt;](bundle.md) field.

The code generator is expected to take the existence of such detached prefix
into account and generate correct code for various field operations
(read, write, etc...).

**NOTE**, that **length** and **lengthPrefix** properties
are mutually exclusive, i.e. cannot be used together.

Use [properties table](../appendix/data.md) for future references.
