## &lt;set&gt; Field
This field stores and abstracts away value of bitset (bitmask) type. 
The **&lt;set&gt;** field has all the [common](common.md) properties
as well as extra properties and elements described below.

#### Underlying Type
The underlying type of the **&lt;set&gt;** field can be provided its underlying storage type using 
**type** [property](../intro/properties.md). Available 
values are:
- **uint8** - 1 byte unsigned integer.
- **uint16** - 2 bytes unsigned integer.
- **uint32** - 4 bytes unsigned integer.
- **uint64** - 8 bytes unsigned integer.

```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <set name="SomeSetield" type="uint8">
            ...
        </set>
    </fields>
</schema>
```
**NOTE** that the available types are all fixed length unsigned ones.

#### Serialization Length
The [underlying type](#underlying-type) specification may be omitted
if serialization length (in number of bytes) is specified using **length** property. In this case
type [underlying type](#underlying-type) is automatically selected based on
the provided serialization length.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <set name="SomeSetield" length="1">
            ...
        </set>
    </fields>
</schema>
```

#### Length in Bits
**&lt;set&gt;** field can be a member of [&lt;bitfield&gt;](bitfield.md) field.
In this case the serialization length may be specified in bits using **bitLength**
[property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <bitfield name="SomeBitfield">
            <int name="SomeIntMember" type="uint8" bitLength="4" />
            <set name="SomeSetMember" bitLength="4" >
                ...
            </set>
        </bitfield>
    </fields>
</schema>
```
**NOTE** that the [underlying type](#underlying-type) information can be
omitted when **bitLength** property is in use, just like with **length**.

#### Bits
The **&lt;set&gt;** field may list its bits as **&lt;bit&gt;** XML child elements.
Every such element must specify its [name](../intro/names.md) using 
**name** property as well as its index using **idx** property.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <set name="SomeSetField" length="1">
            <bit name="SomeBitName" idx="0" />
            <bit name="SomeOtherBitName" idx="1" />
        </set>
    </fields>
</schema>
```
The bit indexing starts from **Least** significant bit, and mustn't exceed number
of bits allowed by the [underlying type](#underlying-type). The **&lt;bit&gt;**-s 
may be listed in any order, not necessarily sorted.

The code generator is expected to generate convenience functions (or other means) 
to set / get the value of every listed bit.

Every **&lt;bit&gt;** element may also define extra [properties](../intro/properties.md) 
listed below for better readability:
- **description** - Extra description and documentation on the bit.
- **displayName** - String specifying how to name the bit in various analysis tools.

These properties are described in detail in 
[Common Properties of Fields](common.md).


#### Default Bit Value
When the **&lt;set&gt;** field object is default constructed, all bits are initialized
to **false**, i.e. **0**. Such default behavior cat be modified using 
**defaultValue** [property](../intro/properties.md) with 
[boolean](../intro/boolean.md) value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <set name="SomeSetField" length="1" defaultValue="true">
            <bit name="SomeBitName" idx="0" />
            <bit name="SomeOtherBitName" idx="1" />
        </set>
    </fields>
</schema>
```
The *SomeSetField* field from the example above is expected to be initialized
to **0xff** when default constructed.

The **defaultValue** may also be specified per-bit, which overrides the 
**defaultValue** specified for the whole field.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <set name="SomeSetField" length="1" defaultValue="true">
            <bit name="SomeBitName" idx="0" defaultValue="false"/>
            <bit name="SomeOtherBitName" idx="1" />
        </set>
    </fields>
</schema>
```
The *SomeSetField* field from the example above is expected to be initialized
to **0xfe** when default constructed.


#### Reserved Bits
All the bits that weren't listed as **&lt;bit&gt;** XML child element
are considered to be reserved. By default every reserved bit is expected to be 
zeroed when field is checked to have a valid value. Such expectation can be changed using
**reservedValue** property.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <set name="SomeSetField" length="1" defaultValue="true" reservedValue="true">
            <bit name="SomeBitName" idx="0" defaultValue="false" />
            <bit name="SomeOtherBitName" idx="1" defaultValue="false"/>
        </set>
    </fields>
</schema>
```
The *SomeSetField* field from the example above is expected to be initialized
to **0xfc** and all the reserved (non-listed) bits are expected to remain **true**.

Reserved bits can also be specified as **&lt;bit&gt;** XML child element
with usage of **reserved** [property](../intro/properties.md) with 
[boolean](../intro/boolean.md) value.
 ```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <set name="SomeSetField" length="1">
            <bit name="SomeBitName" idx="0" />
            <bit name="SomeOtherBitName" idx="1" />
            <bit name="ReservedBit" idx="2" reserved="true">
                <defaultValue value="true" /> 
                <reservedValue value="true" />
            </bit>
        </set>
    </fields>
</schema>
```
The example above marks bit **2** to be reserved, that is initialized to 
**true** and must always stay **true**.

The *SomeSetField* field from the example above is expected to be initialized
to **0x04** when default constructed.

#### Endian
The default serialization endian of the protocol is specified in **endian**
property of the [schema](../schema/schema.md). It is possible to override the
default endian value with extra **endian** property.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <enum name="SomeEnumField" type="uint16" endian="little">
            <bit name="Bit0" idx="0" />
            <bit name="Bit5" idx="5" />
            <bit name="Bit10" idx="10" />
            <bit name="Bit15" idx="15" />
        </enum>
    </fields>
</schema>
```

#### Allow Non-Unique Bit Names
By default, having multiple names for the same bit is not allowed, 
the code generator must report an error if two different 
**&lt;bit&gt;**-s use the same value of **idx**
property. It is done as protection against copy-paste errors. However,
**CommsDSL** allows usage of multiple names for the same bit in case **nonUniqueAllowed** 
[property](../intro/properties.md) has been set to **true**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <set name="SomeSetField" length="1" nonUniqueAllowed="true">
            <bit name="SomeBitName" idx="0" />
            <bit name="DifferentName" idx="0" />
        </set>
    </fields>
</schema>
```

#### Versioning
In addition to mentioned earlier [properties](../intro/properties.md),
every **&lt;bit&gt;** element supports extra ones for versioning:
- **sinceVersion** - Version of the protocol when the bit was introduced (became non-reserved).
- **deprecated** - Version of the protocol when the value was deprecated (became reserved again).

These extra properties are described in detail in 
[Common Properties of Fields](common.md).

#### Version Based Validity
The code generator is expected to generate functionality checking that 
**&lt;set&gt;** field contains a valid value. Any specified non-reserved
bit can have any value, while reserved bits (implicit or explicit) must have value
specified by **reservedValue** property (either of the field or the bit itself).
By default, the validity check must ignore the version in which particular
bit became reserved / non-reserved, and check only values of the bits that have
always stayed reserved. However, it is possible to force code generator to
generate validity check code that takes into account reported version of the
protocol by using **validCheckVersion** [property](../intro/properties.md), which
is set to **true**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big" version="5">
    <fields>
        <enum name="SomeEnumField" type="uint16" validCheckVersion="true">
            <bit name="Bit0" idx="0" />
            <bit name="Bit5" idx="5" />
            <bit name="Bit10" idx="10" sinceVersion="2" />
            <bit name="Bit15" idx="15" sinceVersion="3" deprecated="4"/>
        </enum>
    </fields>
</schema>
```
In the example above bits **0** and **5** will always have valid values. However
bit **10** will be considered valid only if it is cleared before version **2**, and
may have any value after. The bit **15** will be allowed any value when version **3**
of the protocol is reported, and must be cleared for any other version.

Use [properties table](../appendix/set.md) for future references.
