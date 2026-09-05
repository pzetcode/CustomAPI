namespace CustomAPI;

table 50107 CustomAPIValues
{
    Caption = 'CustomAPIValues';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PK; Integer)
        {
            Caption = 'PK';
        }
        field(2; Value1; Text[250])
        {
            Caption = 'Value1';
        }
        field(3; Value2; Text[250])
        {
            Caption = 'Value2';
        }
        field(4; Value3; Text[250])
        {
            Caption = 'Value3';
        }
        field(5; Value4; Text[250])
        {
            Caption = 'Value4';
        }
        field(6; Value5; Text[250])
        {
            Caption = 'Value5';
        }
        field(7; Value6; Text[250])
        {
            Caption = 'Value6';
        }
        field(8; Value7; Text[250])
        {
            Caption = 'Value7';
        }
        field(9; Value8; Text[250])
        {
            Caption = 'Value8';
        }
        field(10; Value9; Text[250])
        {
            Caption = 'Value9';
        }
        field(11; Value10; Text[250])
        {
            Caption = 'Value10';
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
