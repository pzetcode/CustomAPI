namespace CustomAPI;

page 50114 CustomApiJSONParsed
{
    ApplicationArea = All;
    Caption = 'JSON Nodes';
    PageType = List;
    SourceTable = CustomApiJSONParsed;
    SourceTableTemporary = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Node ID"; Rec."Node ID")
                {
                    ToolTip = 'Specifies the value of the Node ID field.', Comment = '%';
                }

                field("Node Type"; Rec."Node Type")
                {
                    ToolTip = 'Specifies the value of the Node Type field.', Comment = '%';
                }
                field(Path; Rec.Path)
                {
                    ToolTip = 'Specifies the value of the Path field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if this.TempCustomApiJSONRec.FindSet() then
            repeat
                Rec.Copy(this.TempCustomApiJSONRec, false);
                Rec.Insert();
            until this.TempCustomApiJSONRec.Next() = 0;
    end;

    var
        TempCustomApiJSONRec: Record CustomApiJSONParsed temporary;

    procedure SetRecords(var InCustomApiJSONParsed: Record CustomApiJSONParsed)
    begin
        this.TempCustomApiJSONRec.Copy(InCustomApiJSONParsed, true);
    end;

    procedure GetSelectedRecords(var OutCustomApiJSONParsed: Record CustomApiJSONParsed)
    begin
        OutCustomApiJSONParsed.Copy(Rec, true);
        CurrPage.SetSelectionFilter(OutCustomApiJSONParsed);
    end;
}
