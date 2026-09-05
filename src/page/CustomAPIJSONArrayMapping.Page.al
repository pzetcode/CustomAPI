namespace CustomAPI;

page 50115 CustomAPIJSONArrayMapping
{
    ApplicationArea = All;
    Caption = 'JSON Array Mapping';
    PageType = List;
    SourceTable = CustomAPIJSONArrayMapping;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("API Code"; Rec."API Code")
                {
                    ToolTip = 'Specifies the value of the API Code field.', Comment = '%';
                    visible = false;
                    enabled = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    visible = false;
                    enabled = false;
                }
                field("Property Name"; Rec."Property Name")
                {
                    ToolTip = 'Specifies the value of the Property Name field.', Comment = '%';
                }
            }
        }
    }
}
