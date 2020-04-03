## Properties of &lt;alias&gt;
Refer to [Aliases](../aliases/aliases.md) chapter for detailed description. 
Introduced in DSL version **3**.

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|[name](../intro/names.md) string|3|yes||Name of the alias.|
|**description**|string|3|no||Human readable description of the alias.|
|**field**|relative [reference](../intro/references.md) string|3|yes||Reference to the aliased field, must start with `$` character.|

