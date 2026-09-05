namespace CustomAPI;

table 50105 CustomApiJSONParsed
{
    Caption = 'CustomApiJSONParsed.Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Node ID"; Integer)
        {
            Caption = 'Node ID';
        }
        field(2; Path; Text[250])
        {
            Caption = 'Path';

            trigger OnValidate()
            begin
                if strpos(Rec.Path, '].') <> 0 then
                    Rec."Is Array" := true
                else
                    Rec."Is Array" := false;
            end;
        }
        field(3; "Node Type"; Text[30])
        {
            Caption = 'Node Type';
        }

        field(4; "Is Array"; boolean)
        {
            editable = false;
            Caption = 'Is Array';
        }

    }
    keys
    {
        key(PK; "Node ID")
        {
            Clustered = true;
        }
    }
}
