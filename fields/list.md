## &lt;list&gt; Field
This field stores and abstracts away a list of other fields. 
The **&lt;list&gt;** field has all the [common](common.md) properties
as well as extra properties and elements described below.

#### Element Field of the List
Every **&lt;list&gt;** must specify its element [field](fields.md). The
element field can be defined as XML child of the **&lt;list&gt;** definition.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <list name="SomeListField">
            <int name="Element" type="uint32" />
        </list>
    </fields>
</schema>
```
If a list element contains multiple fields, they must be bundled as members
of the [&lt;bundle&gt;](bundle.md) field.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <list name="SomeListField">
            <bundle name="Element">
                <int name="Mem1" type="uint32" />
                <int name="Mem2" type="int16" />
                <enum name="Mem3" type="uint16">
                    ...
                </enum>
            </bundle>
        </list>
    </fields>
</schema>
```
In case other properties of the **&lt;list&gt;** field are defined as child
XML elements, then the element field definition needs to be wrapped by 
**&lt;element&gt;** XML child.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <list name="SomeListField">
            <displayName value="Some descriptive name" />
            <element>
                <bundle name="Element">
                    ...
                </bundle>
            </element>
        </list>
    </fields>
</schema>
```
The **CommsDSL** also allows reference of externally defined field to be
an element using **element** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <bundle name="ExternallyDefinedElement">
            ...
        </bundle>
        
        <list name="SomeListField" element="ExternallyDefinedElement" />
    </fields>
</schema>
```

#### Fixed Count
If the defined list must contain predefined number of elements, use **count**
[property](../intro/properties.md) to provide the required information.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <list name="SomeListField" count="8">
            <int name="Element" type="uint32" />
        </list>
    </fields>
</schema>
```

#### Count Prefix
Most protocols prefix the variable length lists with number of elements that
are going to follow, use **countPrefix** child XML element to specify a field
that is going to be used is such prefix.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <list name="SomeListField">
            <element>
                <int name="Element" type="uint32" />
            </element>
            <countPrefix>
                <int name="CountPrefix" type="uint16" />
            </countPrefix>
        </list>
    </fields>
</schema>
```

In case the count prefix field is defined as external field, **CommsDSL** allows
usage of **countPrefix** as [property](../intro/properties.md), value of
which contains name of the referenced field.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="ExternalCountPrefix" type="uint16" />

        <list name="SomeListField" countPrefix="ExternalCountPrefix">
            <int name="Element" type="uint32" />
        </list>
    </fields>
</schema>
```
The **CommsDSL** also supports **detached** count prefix, when there are
several other fields in the [&lt;message&gt;](../messages/messages.md) or in the
[&lt;bundle&gt;](bundle.md) between the count field and the **&lt;list&gt;**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <bundle name=SomeBundle">
            <int name="DataCountPrefixMember" type="uint16" />
            <int name="SomeOtherFieldMember" type="uint16" />
            <list name="SomeDataFieldMember" countPrefix="$DataCountPrefixMember">
                ...
            </list>
        </bundle>
    </fields>
    
    <message name="Msg1" id="1">
        <int name="DataCountPrefix" type="uint16" />
        <int name="SomeOtherField" type="uint16" />
        <list name="SomeListField" countPrefix="$DataCountPrefix">
            ...
        </list>
    </message>
</schema>
```
**NOTE**, the existence of **$** prefix when specifying **countPrefix** value.
It indicates that the referenced field is in the containing
[&lt;message&gt;](../messages/messages.md) or the
[&lt;bundle&gt;](bundle.md) field.

The code generator is expected to take the existence of such detached prefix
into account and generate correct code for various field operations
(read, write, etc...).

#### Length Prefix
There are protocols that prefix a list with **serialization length** rather
than number of elements. In this case use **lengthPrefix** instead of **countPrefix**.
The allowed usage scenarios are exactly the same as described above in
the [Count Prefix](#count-prefix) section.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <list name="List1">
            <element>
                <int name="Element" type="uint32" />
            </element>
            <lengthPrefix>
                <int name="LengthPrefix" type="uint16" />
            </lengthPrefix>
        </list>
        
        <int name="ExternalLengthPrefix" type="uint16" />
        <list name="List2" lengthPrefix="ExternalLengthPrefix">
            <int name="Element" type="uint32" />
        </list>
    </fields>
    
    <message name="Msg1" id="1">
        <int name="DetachedLengthPrefix" type="uint16" />
        <int name="SomeOtherField" type="uint16" />
        <list name="List3" lengthPrefix="$DetachedLengthPrefix">
            ...
        </list>
    </message>
</schema>
```

**NOTE**, that **count**, **countPrefix** and **lengthPrefix** properties
are mutually exclusive, i.e. cannot be used together.

#### Element Length Prefix
Some protocols for its forward / backward compatibility prefix every element
with its serialization length. If there is such need, use **elemLengthPrefix**
to specify a field that will prefix every element of the list.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <list name="List1">
            <element>
                <bundle name="Element>
                    ...
                </bundle>
            </element>
            <countPrefix>
                <int name="CountPrefix" type="uint16" />
            </countPrefix>
            <elemLengthPrefix>
                <int name="ElemLengthPrefix" type="uint8" />
            </elemLengthPrefix>
        </list>

        <int name="ExternalElemLengthPrefix" type="uint8" />
        <list name="List2" count="16" elemLengthPrefix="ExternalElemLengthPrefix">
            <bundle name="Element>
                ...
            </bundle>
        </list>
    </fields>
</schema>
```
In case every list element has fixed length and protocol specification doesn't
allow adding extra variable length fields to the element in the future, some
protocols prefix only **first** element in the list with its serialization 
length. **CommsDSL** supports such lists with **elemFixedLength** 
[property](../intro/properties.md), that has [boolean](../intro/boolean.md) value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <list name="SomeListField" elemFixedLength="true" count="8">
            <element>
                <bundle name="Element">
                    <int name="Mem1" type="uint32" />
                    <int name="Mem2" type="uint32" />
                    ...
                </bundle>
            </element>
            <elemLengthPrefix>
                <int name="ElemLengthPrefix" type="uint8" />
            </elemLenghtPrefix>
        </list>
    </fields>
</schema>
```
The code generator must report an error when element of such list, 
with **elemFixedLength** property set to **true**, has variable length.

Use [properties table](../appendix/list.md) for future references.
