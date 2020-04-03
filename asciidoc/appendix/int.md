## Properties of &lt;int&gt; Field
The **&lt;int&gt;** field has all the [common](fields.md) properties as
well as ones listed below. Refer to [&lt;int&gt; Field](../fields/int.md) chapter
for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**type**|"int8", "uint8", "int16", "uint16", "int32", "uint32", "int64", "uint64", "intvar", "uintvar"|1|yes||Underlying primitive type.|
|**defaultValue**|[numeric](../intro/numeric.md) or [name](../intro/names.md)|1|no|0|Default value. Must fit the underlying **type**.|
|**endian**|"big" or "little"|1|no|endian of [schema](../schema/schema.md)|Endian of the field.|
|**length**|[unsigned](../intro/numeric.md)|1|no|length of **type**|Forced serialization length.|
|**bitLength**|[unsigned](../intro/numeric.md)|1|no|length of **type** in bits|Serialization length in bits, applicable only to a member of [&lt;bitfield&gt;](../fields/bitfield.md).|
|**serOffset**|[numeric](../intro/numeric.md)|1|no|0|Extra value that needs to be added to the field's value when the latter is being serialized.|
|**signExt**|[bool](../intro/boolean.md)|1|no|true|Enable / Disable sign extension of the signed value when **length** property is used to reduce the default serialization length.|
|**scaling**|"[numeric](../intro/numeric.md) / [numeric](../intro/numeric.md)"|1|no|1/1|Scaling ratio.|
|**units**|[units](units.md)|1|no||Units of the value.|
|**validRange**|"[ [numeric](../intro/numeric.md), [numeric](../intro/numeric.md) ]"|1|no||Range of valid values.|
|**validValue**|[numeric](../intro/numeric.md)|1|no||Valid value.|
|**validMin**|[numeric](../intro/numeric.md)|1|no||Valid minimal value. All the numbers above it are considered to be valid.|
|**validMax**|[numeric](../intro/numeric.md)|1|no||Valid maximal value. All the numbers below it are considered to be valid.|
|**validCheckVersion**|[bool](../intro/boolean.md)|1|no|false|Take into account protocol version when generating code for field's value validity check.|
|**displayDecimals**|[numeric](../intro/numeric.md)|1|no|0|Indicates to GUI analysis tools to display this field as floating point value with specified number of digits after the fraction point.|
|**displayOffset**|[numeric](../intro/numeric.md)|1|no|0|Indicates to GUI analysis tools to add specified offset value to a field's value when displaying it.|
|**nonUniqueSpecialsAllowed**|[bool](../intro/boolean.md)|2|no|false|Allow non unique **&lt;special&gt;**-s.|
|**displaySpecials**|[bool](../intro/boolean.md)|2|no|true|Control displaying **&lt;special&gt;** values in analysis tools.|

#### Properties of &lt;special&gt; Child Element of &lt;int&gt; Field
|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|[name](../intro/names.md) string|1|yes||Name of the value.|
|**val**|[numeric](../intro/numeric.md)|1|yes||Numeric value.|
|**description**|string|1|no||Human readable description of the value.|
|**sinceVersion**|[unsigned](../intro/numeric.md)|1|no|0|Version of the protocol in which value was introduced.|
|**deprecated**|[unsigned](../intro/numeric.md)|1|no|max unsigned|Version of the protocol in which value was deprecated.<br />Must be greater than value of **sinceVersion**.|
|**displayName**|string|2|no||Name to display in various analysis tools.|

