namespace CustomAPI;

page 50116 CustomAPIValues
{
    ApplicationArea = All;
    Caption = 'Custom API Values';
    PageType = List;
    Editable = false;
    SourceTable = CustomAPIValues;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(PK; Rec.PK)
                {
                    Visible = false;
                    enabled = false;
                    ToolTip = 'Specifies the value of the PK field.', Comment = '%';
                }
                field(Value1; Rec.Value1)
                {
                    ToolTip = 'Specifies the value of the Value1 field.', Comment = '%';
                }
                field(Value2; Rec.Value2)
                {
                    ToolTip = 'Specifies the value of the Value2 field.', Comment = '%';
                }
                field(Value3; Rec.Value3)
                {
                    ToolTip = 'Specifies the value of the Value3 field.', Comment = '%';
                }
                field(Value4; Rec.Value4)
                {
                    ToolTip = 'Specifies the value of the Value4 field.', Comment = '%';
                }
                field(Value5; Rec.Value5)
                {
                    ToolTip = 'Specifies the value of the Value5 field.', Comment = '%';
                }
                field(Value6; Rec.Value6)
                {
                    ToolTip = 'Specifies the value of the Value6 field.', Comment = '%';
                }
                field(Value7; Rec.Value7)
                {
                    ToolTip = 'Specifies the value of the Value7 field.', Comment = '%';
                }
                field(Value8; Rec.Value8)
                {
                    ToolTip = 'Specifies the value of the Value8 field.', Comment = '%';
                }
                field(Value9; Rec.Value9)
                {
                    ToolTip = 'Specifies the value of the Value9 field.', Comment = '%';
                }
                field(Value10; Rec.Value10)
                {
                    ToolTip = 'Specifies the value of the Value10 field.', Comment = '%';
                }
            }
        }
    }
}
