## Properties of &lt;enum&gt; Field
The **&lt;enum&gt;** field has all the [common](fields.md) properties as
well as ones listed below.

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**type**|"int8", "uint8", "int16", "uint16", "int32", "uint32", "int64", "uint64"|1|yes||Underlying primitive type.|
|**defaultValue**|[unsigned](../intro/numeric.md) or [name](../intro/names.md) of **&lt;validValue&gt;**|1|no|0|Default value.|
|**endian**|"big" or "little"|1|no|endian of [schema](../schema/schema.md)|Endian of the field.|
|**length**|[unsigned](../intro/numeric.md)|1|no|length of **type**|Forced serialization length.|
|**bitLength**|[unsigned](../intro/numeric.md)|1|no|length of **type** in bits|Serialization length in bits, applicable only to a member of [&lt;bitfield&gt;](../fields/bitfield.md).|
|**hexAssign**|[bool](../intro/boolean.md)|1|no|false|Assign generated enum values using hexadecimal numbers.|
|**nonUniqueAllowed**|[bool](../intro/boolean.md)|1|no|false|Allow non unique **&lt;validValue&gt;**-es.|
|**validCheckVersion**|[bool](../intro/boolean.md)|1|no|false|Take into account protocol version when generating code for field's value validity check.|

#### Properties of &lt;validValue&gt; Child Element of &lt;enum&gt; Field

