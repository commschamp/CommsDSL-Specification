# Properties
Almost every element in **CommsDSL** has one or more properties, such as **name**.
Any property can be defined using multiple ways. In can be useful when an
element has too many properties to specify in a single line for a convenient
reading. Any of the described below supported ways of defining a single property
can be used for any element in the schema.

The property can be defined as an XML attribute.
```
<int name="SomeField" type="uint8" />
```
Or as child node with **value** attribute:
```
<int>
    <name value="SomeField" />
    <type value="uint8" />
</int>
```
Property value can also be defined as a text of the child XML element.
```
<int>
    <name>SomeField</name>
    <type>uint8</type>
</int>
```
It is allowed to mix ways of defining properties for a single element
```
<int name="SomeField">
    <type value="uint8" />
    <endian>big</endian>
</int>
```
Many properties must be defined only once for a specific element. In this case,
repetition of it is prohibited. The definition below must cause an error (even
if provided **type** value is not changed).
```
<int name="SomeField" type="uint8" >
    <type value="uint8" />
</int>
```
