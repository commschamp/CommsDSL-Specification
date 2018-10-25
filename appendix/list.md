## Properties of &lt;list&gt; Field
The **&lt;list&gt;** field has all the [common](fields.md) properties as
well as ones listed below. Refer to [&lt;list&gt; Field](../fields/list.md) chapter
for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**element**|[field](../fields/fields.md) or [reference](../intro/references.md)|1|yes||Element of the field.|
|**count**|[unsigned](../intro/numeric.md)|1|no|0|Fixed number of elements in the list. Cannot be used tegether with **lengthPrefix** or **countPrefix**.|
|**countPrefix**|[field](../fields/fields.md) or [reference](../intro/references.md)|1|no||Prefix field containing number of elements in the list. Cannot be used tegether with **count** or **lengthPrefix**.|
|**lengthPrefix**|[field](../fields/fields.md) or [reference](../intro/references.md)|1|no||Prefix field containing serialization length of the list. Cannot be used tegether with **count** or **countPrefix**.|
|**elemLengthPrefix**|[field](../fields/fields.md)|1|no||Prefix field containing serialization length of the list element.|
|**elemFixedLength**|[bool](../intro/boolean.md)|1|no|false|Indication of whether list has and will allways have fixed length element, so **elemLengthPrefix** prefixes only the first element and not the rest.|



