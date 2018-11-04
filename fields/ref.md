## &lt;ref&gt; Field
This field serves as reference (alias) to other fields. It can be used 
to avoid duplication of field definition for multiple messages.
```
<?xml version="1.0" encoding="UTF-8"? version="10">
<schema ...>
    <fields>
        <int name="SomeIntField" type="uint8" defaultValue="Special2">
            <displayName value="Some Int Field" />
            <special name="Special1" val="0" />
            <special name="Special2" val="0xff" />
        </int>
    </fields>
    
    <message name="Msg1" id="1">
        <ref field="SomeIntField" />
        ...
    </message>
    
    <message name="Msg2" id="2">
        <ref field="SomeIntField" name="RenamedIntField" />
    </message>
</schema>
```
The **&lt;ref&gt;** field has all the [common](common.md) properties. It
also copies **name** and **displayName** [properties](../intro/properties.md)
from the referenced field and allows overriding them with new values.
Note, that in the example above **&lt;ref&gt;** field defined as a member of
**Msg1** message hasn't provided any **name** value. It is allowed because
it has taken a name of the referenced field (*SomeIntField*).

#### Referencing the Field
The only extra property the **&lt;ref&gt;** field has is **field** to 
specify a [reference](../intro/references.md) to other field.


Use [properties table](../appendix/ref.md) for future references.
