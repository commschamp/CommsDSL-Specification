## &lt;variant&gt; Field
This field is basically a *union* of other [fields](fields.md). 
It can hold only one field at a time out of the provided list of supported
[fields](fields.md). The **&lt;variant&gt;** field has all the [common](common.md) properties
as well as extra properties and elements described below.

#### Member Fields
The **&lt;variant&gt;** field is there to support heterogeneous lists of fields.
The classic example would be a list of *key-value* pairs, where numeric *key*
defines what type of *value* follows. Similar to [&lt;bundle&gt;](bundle.md)
field, member fields need to be listed as children XML elements of the **&lt;variant&gt;**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <int name="Key" type="uint8" failOnInvalid="true" displayReadOnly="true" />
        
        <variant name="Property">
            <bundle name="Prop1">
                <int reuse="Key" defaultValue="0" validValue="0"  />
                <int name="Value" type="uint32" />
            </bundle>
            <bundle name="Prop2">
                <int reuse="Key" defaultValue="1" validValue="1"  />
                <string name="Value" length="16" />
            </bundle>
        </variant>
        
        <list name="PropertiesList" element="Property" />
    </fields>
</schema>
```
The example above defines every *key-value* pair as [&lt;bundle&gt;](bundle.md)
field, where first field (*key*) reuses external definition of *Key* field and
adds its default construction value as well as what value considered to be valid.
**NOTE**, that every *key* member sets **failOnInvalid** property to **true**. 
The code generator is expected to generate code that attempts *read* operation
of every defined member field in the order of their definition. Once the *read*
operation is successful, the right member has been found and the *read* operation 
needs to terminate. The *in-order* read is high level logic, the code generator
is allowed to introduce optimizations as long as the outcome of detecting the
right member is the same.

In the example above, in order to support future versions of the protocol, 
that may introduce new properties, it is recommended to add "unknown" property
with non-failing *read* operation at the bottom of the members list.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <int name="Key" type="uint8" failOnInvalid="true" displayReadOnly="true" />
        
        <variant name="Property">
            <bundle name="Prop1">
                <int reuse="Key" defaultValue="0" validValue="0"  />
                <int name="Value" type="uint32" />
            </bundle>
            <bundle name="Prop2">
                <int reuse="Key" defaultValue="1" validValue="1"  />
                <string name="Value" length="16" />
            </bundle>
            <bundle name="Unknown">
                <int reuse="Key" failOnInvalid="false"  />
                <data name="Value"/>
            </bundle>
        </variant>
        
        <list name="PropertiesList" element="Property" />
    </fields>
</schema>
```
If there is any other [property](../intro/properties.md) defined as XML child
of the **&lt;variant&gt;**, then all the members must be wrapped in 
**&lt;members&gt;** XML element for separation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <variant name="Property">
            <displayName value="Proper Variant Name" />
            <members>
                <bundle name="Prop1">
                    ...
                </bundle>
                ...
            </members>
        </variant>
    </fields>
</schema>
```

#### Default Member
When **&lt;variant&gt;** field is constructed, it should not hold any
field and when serialized, it mustn't produce any output. 
However, it is possible to specify default member to which
the **&lt;variant&gt;** field should be initialized when constructed.
To specify such member use **defaultMember** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <variant name="Property" defaultMember="Prop1">
            <bundle name="Prop1">
                ...
            </bundle>
            ...
        </variant>
    </fields>
</schema>
```
The **defaultMember** property may also specify index instead of the member 
name.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <variant name="Property" defaultMember="0">
            <bundle name="Prop1">
                ...
            </bundle>
            ...
        </variant>
    </fields>
</schema>
```
Negative number as value of **defaultMember** property will force the 
**&lt;variant&gt;** field not to have a default member.

#### Extra Display Property
By default GUI protocol analysis tools should display the index of the 
held member when displaying **&lt;variant&gt;** field in "read only" mode.
However, for some occasions this information may be irrelevant. To hide
display of index use **displayIdxReadOnlyHidden** 
[property](../intro/properties.md) with [boolean](../intro/boolean.md) value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <variant name="Property" displayIdxReadOnlyHidden="true">
            <bundle name="Prop1">
                ...
            </bundle>
            ...
        </variant>
    </fields>
</schema>
```

Use [properties table](../appendix/variant.md) for future references.

