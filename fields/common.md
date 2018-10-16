## Common Properties of Fields
Every field is different, and defines its own properties and/or other aspects.
However, there are common properties, that are applicable to every field. 
The are summarized below.

#### Name 
Every field must define it's [name](../intro/names.md), which is expected to be 
used by a code generator when defining a relevant class. The name is defined
using **name** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeField> ... />
    </fields>
</schema>
```

#### Reusing Other Fields
Sometimes two different fields are very similar, but differ in one particular
aspect. **CommsDSL** allows copying all the properties from previously defined
field and change value of some properties after the copy. For example:

```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeIntField> type="uint8" defaultValue="3" />
        <bitfield name="SomeBitfield>
            <int name="Member1" reuse="SomeIntField" bitLength="3" />
            <int name="Member2" type="uint8" defaultValue="10" bitLength="5" />
        </bitfield>
    </fields>
</schema>
```
In the example above member of the bitfield **Member1** copies all the properties
from **SomeIntField** field, then overrides its **name** and adds **bitLength**
one to specify its length in bits.

The **reuse** is allowed only between from the field of the same **kind**, i.e.
it is **NOT** allowed for [&lt;enum&gt;](enum.md) field to reuse definition of
[&lt;int&gt;](int.md), only other [&lt;enum&gt;](enum.md).




