namespace CustomAPI;

table 50104 CustomAPISetup
{
    Caption = 'Custom API Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "API Code"; Code[50])
        {
            NotBlank = true;
            Caption = 'API Code';
        }
        field(2; URL; Text[100])
        {
            NotBlank = true;
            Caption = 'URL';
        }

        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }

        field(4; ArrayRoot; Text[50])
        {
            editable = false;
            Caption = 'Array Root Element';
        }

        field(5; LimitRecords; integer)
        {
            Caption = 'Limit Records';
            InitValue = 10;
            MinValue = 1;
            MaxValue = 100;
        }
    }
    keys
    {
        key(PK; "API Code")
        {
            Clustered = true;
        }
    }
}
