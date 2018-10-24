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
- [&lt;int&gt;](int.md) - Integral value field.
- [&lt;set&gt;](set.md) - Bitset (bitmask) field.
- [&lt;bitfield&gt;](bitfield.md) - Bitfield field.
- [&lt;bundle&gt;](bundle.md) - Bundle field.
- [&lt;string&gt;](bundle.md) - String field.
- [&lt;data&gt;](data.md) - Raw data field.
- [&lt;list&gt;](list.md) - List of other fields.
- [&lt;float&gt;](float.md) - Floating point value field.
- [&lt;ref&gt;](ref.md) - Reference to (alias of) other field.
- [&lt;optional&gt;](optional.md)- Optional field.


All this fields have [common](common.md) as well as their own specific set of 
properties.


