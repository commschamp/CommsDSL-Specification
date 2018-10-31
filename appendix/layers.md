## Common Properties for Fields
Refer to [Common Properties of Layers](../frames/common.md) chapter for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|[name](../intro/names.md) string|1|yes||Name of the layer.|
|**description**|string|1|no||Human readable description of the layer.|
|**field**|[reference](../intro/references.md) string|1|yes (except for [&lt;payload&gt;](../frames/payload.md))||Wrapped field definition.|
