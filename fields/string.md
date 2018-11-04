## &lt;string&gt; Field
This field stores and abstracts away value of a text string. 
The **&lt;string&gt;** field has all the [common](common.md) properties
as well as extra properties and elements described below.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <string name="SomeStringField" />
    </fields>
</schema>
```
Such definition of the **&lt;string&gt;** does **NOT** have any limit on
the length of the string, and will consume all the available data in the 
input buffer.

#### Default Value
The default value of the **&lt;string&gt;** field when constructed can be specified
using **defaultValue** [property](../intro/properties.md). If not specified, defaults to empty string.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <string name="SomeStringField" defaultValue="hello" />
    </fields>
</schema>
```

#### Fixed Length
In case the string value needs to be serialized using predefined fixed length,
use **length** property to specify the required value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <string name="SomeStringField" length="16" />
    </fields>
</schema>
```

#### Length Prefix
Many protocols prefix string with its length. The **CommsDSL** allows definition
of such prefix using **lengthPrefix** child element, which must define prefix as
[&lt;int&gt;](int.md) field.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <string name="SomeStringField">
            <lengthPrefix>
                <int name="LengthPrefix" type="uint8" />
            </lengthPrefix>
        <string>
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
        <int name="StringLengthPrefix" type="uint8" />
        <string name="SomeStringField" lengthPrefix="StringLengthPrefix" />
    </fields>
</schema>
```
The **CommsDSL** also supports **detached** length prefix, when there are
several other fields in the [&lt;message&gt;](../messages/messages.md) or in the
[&lt;bundle&gt;](bundle.md) between the length field and the **&lt;string&gt;**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <bundle name=SomeBundle">
            <int name="StringLengthPrefixMember" type="uint8" />
            <int name="SomeOtherFieldMember" type="uint8" />
            <string name="SomeStringFieldMember" lengthPrefix="$StringLengthPrefixMember" />
        </bundle>
    </fields>
    
    <message name="Msg1" id="1">
        <int name="StringLengthPrefix" type="uint8" />
        <int name="SomeOtherField" type="uint8" />
        <string name="SomeStringField" lengthPrefix="$StringLengthPrefix" />
    </message>
</schema>
```
**NOTE**, the existence of **$** prefix when specifying **lengthPrefix** value.
It indicates that the referenced field is a sibling in the containing
[&lt;message&gt;](../messages/messages.md) or the
[&lt;bundle&gt;](bundle.md) field.

The code generator is expected to take the existence of such detached prefix
into account and generate correct code for various field operations
(read, write, etc...).

#### Zero Termination Suffix
Some protocols may terminate strings with **0** (zero) byte. The **CommsDSL**
support such cases with existence of **zeroTermSuffix** [property](../intro/properties.md)
with [boolean](../intro/boolean.md) value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <string name="SomeStringField" zeroTermSuffix="true" />
    </fields>
</schema>
```

**NOTE**, that **length**, **lengthPrefix** and **zeroTermSuffix** properties
are mutually exclusive, i.e. cannot be used together.

Use [properties table](../appendix/string.md) for future references.
