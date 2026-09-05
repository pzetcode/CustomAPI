namespace CustomAPI;

page 50113 CustomAPISetupCard
{
    ApplicationArea = All;
    Caption = 'Custom API Setup Card';
    PageType = Card;
    SourceTable = CustomAPISetup;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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

                field(ArrayRoot; Rec.ArrayRoot)
                {
                    ToolTip = 'Records array root element', Comment = '%';
                }

                field(LimitRecords; Rec.LimitRecords)
                {
                    ToolTip = 'Limit number of records to retrieve from API', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ParseJSONAndDisplayNodes)
            {
                Caption = 'Display nodes';
                ToolTip = 'Parse JSON and display nodes';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    CustomAPIHandler: Codeunit CustomAPIHandler;
                begin
                    CustomAPIHandler.JSONParseAndDisplayNodes(Rec.URL);
                end;
            }

            action(ParseJSONAndSelectNodes)
            {
                Caption = 'Select array nodes (one array scope)';
                ToolTip = 'Parse JSON and select nodes';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    CustomAPIHandler: Codeunit CustomAPIHandler;
                begin
                    CustomAPIHandler.JSONParseAndSelectNodes(Rec);
                end;
            }

            action(ShowJSONArrayMapping)
            {
                Caption = 'Show array mapping';
                ToolTip = 'Show JSON array mapping properties';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page CustomAPIJSONArrayMapping;
                RunPageLink = "API Code" = field("API Code");
            }

            action(GetValuesFromAPI)
            {
                Caption = 'Get values from API';
                ToolTip = 'Get values from API and show';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    CustomAPIHandler: Codeunit CustomAPIHandler;
                begin
                    CustomAPIHandler.GetValues(Rec);
                end;
            }

        }
    }
}
