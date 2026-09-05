namespace CustomAPI;

page 50112 CustomAPISetupList
{
    ApplicationArea = All;
    Caption = 'Custom API Setup';
    PageType = List;
    CardPageId = CustomAPISetupCard;
    SourceTable = CustomAPISetup;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("API Code"; Rec."API Code")
                {
                    ShowMandatory = true;
                    ToolTip = 'Distinct API Code', Comment = '%';
                }
                field(URL; Rec.URL)
                {
                    ShowMandatory = true;
                    ToolTip = 'API URL.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'API Description', Comment = '%';
                }
            }
        }
    }
}
