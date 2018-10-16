## References
The **CommsDSL** allows references to fields or other definitions in order not
to duplicate information and avoid various copy/paste errors. The referenced
element **must** be defined (if in the same file) or processed (if in 
[different](multiple_files.md) schema file) **before** the definition of the 
referencing element.

For example, message defines its payload as a reference (alias) to the 
globally defined field. This field is defined before the message definition. 
the opposite order **must** cause an error. It allows easy avoidance of 
circular references.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeField> type="uint8" />
    </fields>
    
    <message name="SomeMessage" id="1">
        <ref field="SomeField" />
    </message>
</schema>
```
When referencing a field or a value from a namespace (any namespace, not just
different one), the former must be prefixed with a namespace(s) name(s) 
separated by a **.** (dot).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <ns name="myns">
        <fields>
            <int name="SomeField> type="uint8" />
        </fields>
        
        <ns name="subns">
            <fields>
                <int name="SomeOtherField> type="uint16" />
            </fields>
        </ns>
        
        <message name="SomeMessage" id="1">
            <ref field="myns.SomeField" />
            <ref field="myns.subns.SomeOtherField" />
        </message>
    </ns>
</schema>
```
