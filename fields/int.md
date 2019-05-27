## &lt;int&gt; Field
This field stores and abstracts away value of integral type. 
The **&lt;int&gt;** field has all the [common](common.md) properties
as well as extra properties and elements described below.

#### Underlying Type
Every **&lt;int&gt;** field must provide its underlying storage type using 
**type** [property](../intro/properties.md). Available 
values are:
- **int8** - 1 byte signed integer.
- **uint8** - 1 byte unsigned integer.
- **int16** - 2 bytes signed integer.
- **uint16** - 2 bytes unsigned integer.
- **int32** - 4 bytes signed integer.
- **uint32** - 4 bytes unsigned integer.
- **int64** - 8 bytes signed integer.
- **uint64** - 8 bytes unsigned integer.
- **intvar** - up to 8 bytes variable length signed integer
- **uintvar** - up to 8 bytes variable length unsigned integer

```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntield" type="uint8" />
    </fields>
</schema>
```
The variable length types are encoded using **Base-128** form, such as
[LEB128](https://en.wikipedia.org/wiki/LEB128) for *little* endian or similar for
*big* endian.

#### Special Values
Some protocol may assign a special meaning for some values. For example, some
field specifies configuration of some timer duration, when **0** value means
infinite. Such values (if exist) must be listed as **&lt;special&gt;** child of the 
**&lt;int&gt;** XML element.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="Duration" type="uint8">
            <special name="Infinite" val="0" />
        </int>
    </fields>
</schema>
```
The code generator is expected to generate extra convenience functions that 
check whether field has special value as well as updating the stored value
with special one.

Every **&lt;special&gt;** must define a valid [name](../intro/names.md) 
(using **name** [property](../intro/properties.md)) as 
well as [numeric](../intro/numeric.md) value (using **val** 
[property](../intro/properties.md)), that fits chosen 
[underlying type](#underlying-type). The **&lt;special&gt;**-s may be listed
in any order, not necessarily sorted.

Every **&lt;special&gt;** has extra optional properties:
- **description** - Extra description and documentation on how to use the value.
- **sinceVersion** - Version of the protocol when the special name / meaning was introduced.
- **deprecated** - Version of the protocol when the special name / meaning was deprecated.

All these extra properties are described in detail in 
[Common Properties of Fields](common.md).

#### Default Value
The default value of the **&lt;int&gt;** field when constructed can be specified
using **defaultValue** property. If not specified, defaults to **0**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8" defaultValue="5" />
    </fields>
</schema>
```
The default value can also be specified using the name of one of the 
**&lt;special&gt;**-s:
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8" defaultValue="Special2">
            <special name="Special1" val="0" />
            <special name="Special2" val="0xff" />
        </int>
    </fields>
</schema>
```

#### Endian
The default serialization endian of the protocol is specified in **endian**
property of the [schema](../schema/schema.md). It is possible to override the
default endian value with extra **endian** property.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <int name="SomeIntField" type="uint16" endian="little" />
    </fields>
</schema>
```

#### Serialization Length
The [underlying type](#underlying-type) dictates the serialization length
of the **&lt;int&gt;** field. However there may be protocols, that limit serialization
length of the field to non-standard lengths, such as **3** bytes. In this case
use **length** property to specify custom serialization length.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <int name="SomeIntField" type="uint32" length="3" />
    </fields>
</schema>
```

<span style="color:red">**IMPORTANT**</span>: When **length** property is used with variable length 
[underlying types](#underlying-type) (**intvar** and **uintvar**), 
it means **maximum** allowed length.

#### Length in Bits
**&lt;int&gt;** field can be a member of [&lt;bitfield&gt;](bitfield.md) field.
In this case the serialization length may be specified in bits using **bitLength**
[property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <bitfield name="SomeBitfield">
            <int name="SomeIntMember" type="uint8" bitLength="2" />
            <int name="SomeOtherIntMember" type="uint8" bitLength="6" />
        </bitfield>
    </fields>
</schema>
```

#### Serialization Offset
Some protocols may require adding/subtracting some value before serialization, and
performing the opposite operation when the field is deserialized. Such operation
can be forced using **serOffset** property with [numeric](../intro/numeric.md) 
value. The classic example would be defining a **year** field that is being
serialized using 1 byte as offset from year 2000. Although it is possible to
define such field as 1 byte integer 
```
<int name="Year" type="uint8"  />
```
it is quite inconvenient to work with it in a client code. The client code needs to be
aware what offset needs to be added to get the proper year value. It is
much better to use **serOffset** property to manipulate value before and after
serialization.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <int name="Year" type="int16" defaultValue="2000" serOffset="-2000" length="1" />
    </fields>
</schema>
```
**NOTE**, that value of **serOffset** property must fit into the underlying type
defined using **type** property.


#### Sign Extension
When limiting [serialization length](#serialization-length) using **length** 
property, the performed **read** operation is expected to sign 
extend read signed value. However, such default behavior may be incorrect
for some cases, especially when [serialization offset](#serialization-offset) is
also used. There are protocols that disallow serialization of a negative value.
Any signed integer must add predefined offset to make it non-negative first, and only
then serialize. The deserialization procedure is the opposite, first deserialize
the non-negative value, and then subtract predefined offset to get the real value.

For example, there is an integer field with expected valid values between 
-8,000,000 and +8,000,000. This range fits into 3 bytes, which are used to 
serialize such field. Such field is serialized using the
following math:
- Add 8,000,000 to the field's value to get non-negative number.
- Serialize the result using only 3 bytes.

In order to implement such example correctly there is a need to switch off the
automatic sign extension when value is deserialized.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeField" type="int32" serOffset="8000000" length="3" signExt="false" />
    </fields>
</schema>
```
**NOTE**, that **signExt** property is relevant only for signed types with 
non-default [serialization length](#serialization-length).

#### Scaling
Some protocols may not support serialization of floating point values, and 
use scaling instead. It is done by multiplying the original floating point value
by some number, dropping the fraction part and serializing the value as integer.
Upon reception, the integer value is divided by predefined number to get a 
proper floating point value. 

For example, there is a distance measured in millimeters with precision of 
4 digits after decimal point. The value is multiplied by 10,000 and serialized
as **&lt;int&gt;** field. Such scenario is supported by **CommsDSL** via 
introduction of **scaling** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="Distance" type="uint32" scaling="1/10000" />
    </fields>
</schema>
```
**NOTE**, that format of **scaling** value is "**numerator / denominator**". 
The code generator is expected to define such field like any other 
**&lt;int&gt;**, but also provide functions that allow set / get of 
scaled floating point value.

It is possible to omit the **denominator** value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" type="int16" scaling="4" />
    </fields>
</schema>
```
In the example above it is equivalent to having **scaling="4/1"** defined.

#### Units
Protocols quite often specify what units are being transfered. The **CommsDSL**
provides **units** [property](../intro/properties.md) to specify this information.
The code generator may use this information to generate a functionality that allows 
retrieval of proper value for requested units, while doing all the conversion 
math internally. Such behavior will allow developers, that use generated
protocol code, to focus on their business logic without getting into details
on how value was transfered and what units are used by default.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="Distance" type="uint32" units="mm" />
    </fields>
</schema>
```
For list of supported **units** values, refer to appended [units](../appendix/units.md) 
table.

Quite often, **units** and **scaling** need to be used together. For example
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="Latitude" type="int32" units="deg" scaling="1/10000000" />
    </fields>
</schema>
```
The code generator may generate code that allows retrieval of proper
(floating point) value of either **degrees** or **radians**, while all the
scaling and conversion math is done automatically.

#### Valid Values
Many protocols specify ranges of values the field is allowed to have and how
client code is expected to behave on reception of invalid values. The code
generator is expected to generate code that checks whether field's value
is valid. The **CommsDSL** provides multiple properties to help with such
task.

One of such properties if **validRange**. The format of it's value is 
"[*min_value*, *max_value*]".
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8" validRange="[0, 10]" />
    </fields>
</schema>
```
It is possible to have multiple valid ranges for the same field. However XML
does NOT allow having multiple attributes with the same name. As the result
it is required to put extra valid ranges as **&lt;validRange&gt;** children
elements.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8">
             <validRange value="[0, 10]" />
             <validRange value="[25, 40]" />
        </int>
    </fields>
</schema>
```
Another property is **validValue**, which adds single value (not range) to 
already defined valid ranges / values. Just like with **validRange**, multiple
values need to be added as XML children elements.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8" validRange="[0, 10]" validValue="15">
            <validValue value="40" />
        </int>
    </fields>
</schema>
```

There are also **validMin** and **validMax**, which specify single 
[numeric](../intro/numeric.md) value and are equivalent to having
**validRange="[*provided_min_value*, *max_value_allowed_by_type*]"** and
**validRange="[*min_value_allowed_by_type*, *provided_max_value*]"** respectively.

```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField" type="int8" validMin="-20" />
        <int name="SomeOtherIntField" type="int8" validMax="100" />
    </fields>
</schema>
```
The specified valid ranges and values are allowed to intersect. The code 
generator may warn about such cases and/or unify them to limit number of
**if** conditions in the generated code for better performance.

If none of the mentioned above validity related options has been used, the
whole range of available values is considered to be valid.

All the validity related [properties](../intro/properties.md) mentioned in this
section (**validRange**, **validValue**, **validMin**, and **validMax**) may
also add information about version they were introduced / deprecated in. 
Adding such information is possible only when the property is defined as
XML child element.
```
<?xml version="1.0" encoding="UTF-8"? version="10">
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8">
             <validRange value="[0, 10]" />
             <validValue value="25" sinceVersion="2" deprecated="5" />
             <validRange value="[55, 80]" sinceVersion="7" />
        </int>
    </fields>
</schema>
```
The **sinceVersion** and **deprecated** properties are described in detail as 
[Common Properties of Fields](common.md).


#### Version Based Validity
The code generator is expected to generate functionality checking that 
**&lt;int&gt;** field contains a valid value. By default if the field's value 
is within any of the specified ranges / values, then the it is considered to be valid
regardless of version the containing range was
introduced and/or deprecated. However, it is possible to force code generator to
generate validity check code that takes into account reported version of the
protocol by using **validCheckVersion** [property](../intro/properties.md), which
is set to **true**.
```
<?xml version="1.0" encoding="UTF-8"? version="10">
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8" validCheckVersion="true">
             <validRange value="[0, 10]" />
             <validValue value="25" sinceVersion="2" deprecated="5" />
             <validRange value="[55, 80]" sinceVersion="7" />
        </int>
    </fields>
</schema>
```

#### Extra Display Properties
When [scaling](#scaling) information is specified, it is possible to notify 
GUI analysis tools that value of **&lt;int&gt;** field should be displayed as
scaled floating point number. To do so, use **displayDecimals** [property](../intro/properties.md) 
with numeric value of how many digits need to be displayed after decimal point.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="Distance" type="uint32" scaling="1/10000" displayDecimals="4" />
    </fields>
</schema>
```

Also when [serialization offset](#serialization-offset) is provided, sometimes
it may be desirable to display the value in the GUI analysis tool(s) with such offset.

For example, many protocols define some kind of remaining length field
when defining a transport [frame](../frames/frames.md) or other places. Sometimes
the value of such field should also include its own length. However, it 
is much more convenient to work with it, when the retrieved value 
shows only **remaining** length of subsequent fields, without worrying whether
the value needs to be reduced by the serialization length of holding field, and what exactly
this length is. Such field can be defined like this:
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="RemLength" type="uint16" serOffset="2" />
    </fields>
</schema>
```
In the example above, the field is expected to hold only **remaining** length,
**excluding** the length of itself, but adding it when value is serialized.

However, when such field is displayed in GUI analysis tool(s), it is desirable 
to display the value with serialization offset as well. It can be achieved using
**displayOffset** [property](../intro/properties.md) with 
[numeric](../intro/numeric.md) value. 
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="RemLength" type="uint16" serOffset="2" displayOffset="2"/>
    </fields>
</schema>
```

Use [properties table](../appendix/int.md) for future references.
