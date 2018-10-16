# Fields
Any **field** can be defined as independent elements of **&lt;fields&gt;**
child of the [schema](../intro/schema_def.md) or any [namespace](../intro/namespaces.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeField> type="uint8" />
        ...
    </fields>
</schema>
```
It can also be defined as a member of a message.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="SomeMessage" id="1">
        <int name="SomeField> type="uint8" />
        ...
    </message>
</schema>
```
Field that is defined as a child of **&lt;fields&gt;** element of 
[&lt;schema&gt;](../intro/schema_def.md) or 
[&lt;ns&gt;](../intro/namespaces.md) can be referenced by other fields to avoid
definition duplication.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <ns name="ns1">
        <int name="SomeField> type="uint8" />
        <ref name="AliasToField" field="ns1.SomeField" />
    </ns>
    <message name="SomeMessage" id="1">
        <ref name="Mem1> field="ns1.SomeField"" />
        ...
    </message>
</schema>
```

The available fields are described in details in the sections to follow. They are:
- [&lt;enum&gt;](enum.md) - Enumeration field.

All this fields have [common](common.md) as well as their own specific set of 
properties.



