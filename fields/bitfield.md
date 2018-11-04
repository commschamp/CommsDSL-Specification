## &lt;bitfield&gt; Field
The **&lt;bitfield&gt;** is a container field, which allows wrapped member fields
to be serialized using limited number of bits (instead of bytes). 
The supported fields, that can be members of the **&lt;bitfield&gt;**, are:
- [&lt;enum&gt;](enum.md)
- [&lt;int&gt;](int.md)
- [&lt;set&gt;](set.md)

The **&lt;bitfield&gt;** field has all the [common](common.md) properties
as well as extra properties and elements described below.

#### Member Fields
Member fields need to be listed as children XML elements of the **&lt;bitfield&gt;**.
Every such member is expected to use **bitLength** property to specify its
serialization length **in bits**. If it is not specified, then length in bits
is calculated automatically as length **in bytes** multiplied by **8**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <bitfield name="SomeBitfield">
            <int name="SomeIntMember" type="uint8" bitLength="3" />
            <set name="SomeSetMember" bitLength="3">
                ...
            </set>
            <enum name="SomeEnumMember" type="uint8" bitLength="2">
                ...
            </enum>
        </bitfield>
    </fields>
</schema>
```
**NOTE** that summary of all the lengths in bits of all the members must be
divisible by **8** and mustn't exceed **64** bits, otherwise the code generator 
must report an error.

The members of **&lt;bitfield&gt;** must be listed in order starting from the
**least** significant bit. In the example above *SomeIntMember* occupies bits
[0 - 2], *SomeSetMember* occupies bits [3 - 5], and *SomeEnumMember* occupies
bits [6 -7].

If there is any other [property](../intro/properties.md) defined as XML child
of the **&lt;bitfield&gt;**, then all the members must be wrapped in 
**&lt;members&gt;** XML element for separation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <bitfield name="SomeBitfield">
            <displayName value="Proper Bitfield Name" />
            <members>
                <int name="SomeIntMember" type="uint8" bitLength="3" />
                <set name="SomeSetMember" bitLength="3">
                    ...
                </set>
                <enum name="SomeEnumMember" type="uint8" bitLength="2">
                    ...
                </enum>
            </members>
        </bitfield>
    </fields>
</schema>
```

#### Endian
When serializing, the **&lt;bitfield&gt;** object needs to combine the
values of all the members into single unsigned raw value of appropriate length,
and write the received value using appropriate endian.
By default **endian** of the [schema](../schema/schema.md) is used, unless it
is overridden using extra **endian** property of the **&lt;bitfield&gt;** field.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <bitfield name="SomeBitfield" endian="little">
            ...
        </bitfield>
    </fields>
</schema>
```

Use [properties table](../appendix/bitfield.md) for future references.
