## &lt;bundle&gt; Field
The **&lt;bundle&gt;** is a container field, which aggregates multiple 
independent fields (of any kind) into a single one. 
The **&lt;bundle&gt;** field has all the [common](common.md) properties.

#### Member Fields
Member fields need to be listed as children XML elements of the **&lt;bundle&gt;**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <bundle name="SomeBundle">
            <int name="SomeIntMember" type="uint8" />
            <set name="SomeSetMember" length="1">
                ...
            </set>
            <enum name="SomeEnumMember" type="uint8">
                ...
            </enum>
            <bundle name="SomeInnerBundle">
                ...
            </bundle>
        </bundle>
    </fields>
</schema>
```
If there is any other [property](../intro/properties.md) defined as XML child
of the **&lt;bundle&gt;**, then all the members must be wrapped in 
**&lt;members&gt;** XML element for separation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big">
    <fields>
        <bundle name="SomeBitfield">
            <displayName value="Proper Bitfield Name" />
            <members>
                <int name="SomeIntMember" type="uint8" bitLength="3" />
                <set name="SomeSetMember" length="1">
                    ...
                </set>
                <enum name="SomeEnumMember" type="uint8">
                    ...
                </enum>
                <bundle name="SomeInnerBundle">
                    ...
                </bundle>
            </members>
        </bundle>
    </fields>
</schema>
```

Use [properties table](../appendix/bundle.md) for future references.
