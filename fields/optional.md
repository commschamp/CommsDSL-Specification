## &lt;optional&gt; Field
This field wraps other [fields](fields.md) and makes the wrapped field optional, i.e.
the serialization of the latter may be skipped if it is marked as "missing".
The **&lt;optional&gt;** field has all the [common](common.md) properties
as well as extra properties and elements described below.

#### Inner (Wrapped) Field
Every **&lt;optional&gt;** must specify its inner [field](fields.md). The
wrapped field can be defined as XML child of the **&lt;optional&gt;** definition.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <optional name="SomeOptionalField">
            <int name="SomeOptionalField" type="uint32" />
        </optional>
    </fields>
</schema>
```
In case other properties of the **&lt;optional&gt;** field are defined as child
XML elements, then the element field definition needs to be wrapped by 
**&lt;field&gt;** XML child.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <optional name="SomeOptionalField">
            <displayName value="Some descriptive name" />
            <field>
                <int name="SomeOptionalField" type="uint32" />
            </field>
        </optional>
    </fields>
</schema>
```
The **CommsDSL** also allows reference of externally defined field to be
specified as inner (wrapped) field type using **field** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeExternalField" type="uint32" />
        <optional name="SomeOptionalField" field="SomeExternalField" />
    </fields>
</schema>
```

#### Default Mode
Every **&lt;optional&gt;** field has 3 modes: **tenative** (default), **exist**,
and **missing**. The **exist** and **missing** modes are self explanatory. 
The **tentative** mode is there to perform *read* operation on the inner field
only if there are non-consumed bytes left in the input buffer. This mode
can be useful with protocols that just add fields at the end of the 
[message](../messages/messages.md) in the new version, 
but the protocol itself doesn't report its version in any other way.

The default mode of the newly constructed **&lt;optional&gt;** field can be
specified using **defaultMode** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <optional name="SomeOptionalField" defaultMode="missing">
            <int name="SomeOptionalField" type="uint32" />
        </optional>
    </fields>
</schema>
```

#### Existence Condition
Many protocols introduce optional fields, and the existence of such fields
depend on the value of some other field. Classic example would be having 
some kind of flags field (see [**&lt;set&gt;**](set.md)) where some bit specifies
whether other field that follows exists or not. Such conditions can be expressed
using **cond** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1">
        <set name="Flags">
            <bit name="Val1Exists" idx="0" />
        </set>
        <optional name="Val1" defaultMode="missing" cond="$Flags.Val1Exists">
            <int name="WrappedVal1" type="uint32" />
        </optional>
    </fields>
</schema>
```
**NOTE**, that **cond** property can be used only for **&lt;optional&gt;** field
that is a member of a [**&lt;bundle&gt;**](bundle.md) or a 
[**&lt;message&gt;**](../messages/messages.md). The **cond** expression 
specifies condition when the **&lt;optional&gt;** field exists, and must always
reference other **sibling** field. Such reference is always prefixed with **$** character
to indicate that the field is a **sibling** of the **&lt;optional&gt;** and 
not some external field.

The allowed **cond** expressions are:
- $*set_field_name.bit_name* - The wrapped field exists if specified bit is set to **true** (**1**).
- !$*set_field_name.bit_name* - The wrapped field exists if specified bit is set to **false** (**0**).
- $*field_name* *compare_op* *value* - The wrapped field exists if comparison 
of the specified field with specified value is true. The *compare_op* can be:
**=** (equality), **!=** (inequality), **&lt;** (less than), **&lt;=** (less than or equal),
**&gt;** (greater than), **&gt;=** (greater than or equal).
- $*field_name* *compare_op* $*other_field_name* - The wrapped field exists if comparison 
of the specified fields is true. 

<span style="color:red">**NOTE**</span>, that XML doesn't allow usage of `<`
or `>` symbols in condition values directly. They need to be substituted with `&lt;` and
`&gt;` strings respectively.

For example, there are 2 normal fields followed by a third optional one. The
latter exists, only if value of **F1** is less than value of **F2**
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1">
        <int name="F1" type="uint16" />
        <int name="F2" type="uint16" />
        <optional name="F3" defaultMode="exists" cond="$F1 &lt; $F2">
            <int name="WrappedF3" type="uint32" />
        </optional>
    </fields>
</schema>
```

#### Multiple Existence Conditions
The **CommsDSL** also allows usage of multiple existence condition statements. However,
they need to be wrapped by either **&lt;and&gt;** or **&lt;or&gt;** 
XML child elements, which represent "**and**" and "**or**" logical conditions
respectively. 
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1">
        <int name="F1" type="uint16" />
        <int name="F2" type="uint16" />
        <optional name="F3" defaultMode="exists">
            <field>
                <int name="WrappedF3" type="uint32" />
            </field>
            <or>
                <cond value="$F1 = 0" />
                <and>
                    <cond value="$F1 = 1" />
                    <cond value="$F2 != 0" />
                </and>
            </or>
        </optional>
    </fields>
</schema>
```
In the example the **F3** field exists in one of the following conditions:
- Value of **F1** is 0.
- Value of **F1** is 1 and value of **F2** is not 0.

#### Extra Display Property
By default GUI protocol analysis tools should allow manual update of the
**&lt;optional&gt;** field mode. However, if the mode is controlled by the 
values of other fields, it is possible to disable manual update of the 
mode by using **displayExtModeCtrl** 
(stands for "display external mode control") [property](../intro/properties.md)
with [boolean](../intro/boolean.md) value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="Msg1" id="1">
        <set name="Flags">
            <bit name="Val1Exists" idx="0" />
        </set>
        <optional name="Val1" defaultMode="missing" cond="$Flags.Val1Exists">
            <displayExtModeCtrl value="true" />
            <field>
                <int name="WrappedVal1" type="uint32" />
            </field>
        </optional>
    </fields>
</schema>
```
Use [properties table](../appendix/optional.md) for future references.

