## Properties of &lt;interface&gt;
Refer to [Interfaces](../interfaces/interfaces.md) chapter
for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|[name](../intro/names.md) string|1|yes||Name of the interface.|
|**description**|string|1|no||Human readable description of the interface.|
|**copyFieldsFrom**|[reference](../intro/references.md) string|1|no||Interface definition from which fields need to be copied.|

The **&lt;interfaces&gt;** also allows listing of fields using
**&lt;fields&gt;** child XML element.

