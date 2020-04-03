## Properties of &lt;set&gt; Field
The **&lt;set&gt;** field has all the [common](fields.md) properties as
well as ones listed below. Refer to [&lt;set&gt; Field](../fields/set.md) chapter
for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**type**|"uint8", "uint16", "uint32", "uint64"|1|yes (no if **length** is specified)||Underlying primitive type.|
|**length**|[unsigned](../intro/numeric.md)|1|yes (no if **type** is specifed)|length of **type**|Serialization length.|
|**bitLength**|[unsigned](../intro/numeric.md)|1|no|length of **type** in bits|Serialization length in bits, applicable only to a member of [&lt;bitfield&gt;](../fields/bitfield.md).|
|**defaultValue**|[bool](../intro/boolean.md)|1|no|false|Default initialization value of every bit.|
|**reservedValue**|[bool](../intro/boolean.md)|1|no|false|Expected value of every reserved bit.|
|**endian**|"big" or "little"|1|no|endian of [schema](../schema/schema.md)|Endian of the field.|
|**nonUniqueAllowed**|[bool](../intro/boolean.md)|1|no|false|Allow non unique **&lt;bit&gt;**-s.|
|**validCheckVersion**|[bool](../intro/boolean.md)|1|no|false|Take into account protocol version when generating code for field's value validity check.|

#### Properties of &lt;bit&gt; Child Element of &lt;set&gt; Field
|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|[name](../intro/names.md) string|1|yes||Name of the value.|
|**idx**|[numeric](../intro/numeric.md)|1|yes||Index of the specified bit. Counting starts from least significant bit.|
|**description**|string|1|no||Human readable description of the bit.|
|**displayName**|string|1|no||Human readable name of the bit to display in various analysis tools.|
|**defaultValue**|[bool](../intro/boolean.md)|1|no|**defaultValue** of the **&lt;set&gt;** field|Default value of the bit (when constructed).|
|**reservedValue**|[bool](../intro/boolean.md)|1|no|**reservedValue** of the **&lt;set&gt;** field|Expected value of the bit if it is reserved.|
|**reserved**|[bool](../intro/boolean.md)|1|no|false|Mark / Unmark the bit as being reserved.|
|**sinceVersion**|[unsigned](../intro/numeric.md)|1|no|0|Version of the protocol in which bit was introduced (became non-reserved).|
|**deprecated**|[unsigned](../intro/numeric.md)|1|no|max unsigned|Version of the protocol in which bit was deprecated (became reserved).<br />Must be greater than value of **sinceVersion**.|

