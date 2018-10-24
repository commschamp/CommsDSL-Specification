## Properties of &lt;data&gt; Field
The **&lt;data&gt;** field has all the [common](fields.md) properties as
well as ones listed below. Refer to [&lt;data&gt; Field](../fields/data.md) chapter
for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**defaultValue**|string|1|no||Default value. Case-insensitive hexadecimal string.|
|**length**|[unsigned](../intro/numeric.md)|1|no|0|Fixed serialization length. **0** means no length limit. Cannot be used tegether with **lengthPrefix**.|
|**lengthPrefix**|[name](../intro/names.md) data|1|no||Prefix field containing length of the data.Cannot be used tegether with **length**.|



