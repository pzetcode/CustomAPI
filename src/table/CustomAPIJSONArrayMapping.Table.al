namespace CustomAPI;

table 50106 CustomAPIJSONArrayMapping
{
    Caption = 'JSON Array Mapping';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "API Code"; Code[50])
        {
            Caption = 'API Code';
            validateTableRelation = true;
            tableRelation = CustomAPISetup."API Code";
            editable = false;
        }
        field(2; "Line No."; Integer)
        {
            editable = false;
            Caption = 'Line No.';
        }
        field(3; "Property Name"; Text[50])
        {
            editable = false;
            Caption = 'Property Name';
        }
    }
    keys
    {
        key(PK; "API Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
