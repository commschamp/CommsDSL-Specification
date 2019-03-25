## Properties of &lt;float&gt; Field
The **&lt;float&gt;** field has all the [common](fields.md) properties as
well as ones listed below. Refer to [&lt;float&gt; Field](../fields/float.md) chapter
for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**type**|"float", "double"|1|yes||Underlying primitive type.|
|**defaultValue**|floating point value, **nan**, **inf**, **-inf**|1|no|0.0|Default value. Must fit the underlying **type**.|
|**endian**|"big" or "little"|1|no|endian of [schema](../schema/schema.md)|Endian of the field.|
|**units**|[units](units.md)|1|no||Units of the value.|
|**validRange**|"[ fp_value, fp_value ]"|1|no||Range of valid values.|
|**validValue**|floating point value, **nan**, **inf**, **-inf**|1|no||Valid value.|
|**validMin**|floating point value|1|no||Valid minimal value. All the numbers above it are considered to be valid.|
|**validMax**|floating point value|1|no||Valid maximal value. All the numbers below it are considered to be valid.|
|**validFullRange**|[bool](../intro/boolean.md)|1|no|false|Mark all the range of existing FP values to be valid, excluding **nan**, **inf**, and **-inf**.|
|**validCheckVersion**|[bool](../intro/boolean.md)|1|no|false|Take into account protocol version when generating code for field's value validity check.|
|**displayDecimals**|[numeric](../intro/numeric.md)|1|no|0|Indicates to GUI analysis how many digits need to be displayed after the fraction point.|

#### Properties of &lt;special&gt; Child Element of &lt;float&gt; Field
|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|[name](../intro/names.md) string|1|yes||Name of the value.|
|**val**|floating point value, **nan**, **inf**, **-inf**|1|yes||Numeric value.|
|**description**|string|1|no||Human readable description of the value.|
|**sinceVersion**|[unsigned](../intro/numeric.md)|1|no|0|Version of the protocol in which value was introduced.|
|**deprecated**|[unsigned](../intro/numeric.md)|1|no|max unsigned|Version of the protocol in which value was deprecated.<br />Must be greater than value of **sinceVersion**.|

