namespace CustomAPI;

codeunit 50123 "CustomAPIHandler"
{
    procedure JSONParseAndSelectNodes(var CustomApiSetup: Record CustomAPISetup)
    var
        TempCustomApiJsonParsedRec: Record CustomApiJSONParsed temporary;
        TempCustomApiJsonResultRec: Record CustomApiJSONParsed temporary;
        CustomAPIJSONSchemaBrowserCU: Codeunit CustomAPIJSONSchemaBrowser;
        ResponseStringTxt: Text;
        ArrayPath: Text[50];
        counter: Integer;
    begin
        ResponseStringTxt := this.GetResponseString(customApiSetup.URL);
        CustomAPIJSONSchemaBrowserCU.BrowseCustomJson(ResponseStringTxt, TempCustomApiJsonParsedRec);
        this.CollectNodes(TempCustomApiJsonParsedRec, TempCustomApiJsonResultRec);
        ArrayPath := this.CheckConistencyGetArrayPath(TempCustomApiJsonResultRec);
        if ArrayPath <> '' then begin
            CustomApiSetup.ArrayRoot := ArrayPath;
            CustomApiSetup.Modify();
            counter := this.FillJSONArrayMappingTable(TempCustomApiJsonResultRec, customApiSetup);
            Message('Done, added %1 nodes', counter);
        end else
            error('Array path is empty');
    end;

    local procedure FillJSONArrayMappingTable(var TempCustomApiJsonResultRec: Record CustomApiJSONParsed; CustomApiSetup: Record CustomAPISetup): integer
    var
        CustomAPIJSONArrayMappingRec: Record CustomAPIJSONArrayMapping;
        i: integer;
    begin
        customAPIJSONArrayMappingRec.SetRange("API Code", customApiSetup."API Code");
        if CustomAPIJSONArrayMappingRec.FindSet() then
            CustomAPIJSONArrayMappingRec.DeleteAll();
        customAPIJSONArrayMappingRec.reset();
        i := 0;
        if TempCustomApiJsonResultRec.FindSet() then
            repeat
                CustomAPIJSONArrayMappingRec.Init();
                CustomAPIJSONArrayMappingRec."API Code" := customApiSetup."API Code";
                CustomAPIJSONArrayMappingRec."Line No." := i;
                CustomAPIJSONArrayMappingRec."Property Name" := this.GetArrayProperty(TempCustomApiJsonResultRec.Path);
                CustomAPIJSONArrayMappingRec.Insert();
                i += 1;
            until (TempCustomApiJsonResultRec.Next() = 0) or (i = 10);
        exit(i);
    end;

    procedure GetValues(CustomApiSetup: Record CustomAPISetup)
    var
        CustomAPIJSONArrayMappingRec: Record CustomAPIJSONArrayMapping;
        CustomAPIRecRefInsertCU: codeunit CustomAPIRecRefInsert;
        ResponseStringTxt: Text;

    begin
        ResponseStringTxt := this.GetResponseString(customApiSetup.URL);
        CustomAPIJSONArrayMappingRec.SetRange("API Code", customApiSetup."API Code");
        CustomAPIRecRefInsertCU.GetAPIValuesAndDisplay(CustomAPIJSONArrayMappingRec, ResponseStringTxt, CustomApiSetup);

    end;

    local procedure CheckConistencyGetArrayPath(var TempCustomApiJsonResultRec: Record CustomApiJSONParsed): text[50];
    var
        ArrayPath: Text[50];
    begin

        if TempCustomApiJsonResultRec.FindFirst() then
            ArrayPath := this.GetArrayPath(TempCustomApiJsonResultRec.Path);

        if TempCustomApiJsonResultRec.FindSet() then
            repeat
                if this.GetArrayPath(TempCustomApiJsonResultRec.Path) <> arrayPath then
                    Error('Selected nodes are not in the same array scope. Please select nodes from the same array.');
            until TempCustomApiJsonResultRec.Next() = 0;

        exit(ArrayPath);
    end;

    local procedure GetArrayPath(TokenPath: Text): Text[50];
    var
        StringParts: List of [Text];
        Separators: List of [Text];
    begin
        Separators.Add('[');
        StringParts := TokenPath.Split(Separators);

        exit(CopyStr(StringParts.Get(1), 1, 50));
    end;

    local procedure GetArrayProperty(TokenPath: Text): Text[50];
    var
        StringParts: List of [Text];
        Separators: List of [Text];
    begin
        Separators.Add('].');
        StringParts := TokenPath.Split(Separators);

        exit(CopyStr(StringParts.Get(2), 1, 50));
    end;

    local procedure CollectNodes(var TempCustomApiJsonParsedRec: Record CustomApiJSONParsed; var TempCustomApiJsonResultRec: Record CustomApiJSONParsed)
    var
        CustomApiJSONParsedPage: Page "CustomApiJSONParsed";
    begin
        tempCustomApiJsonParsedRec.setrange("Node Type", 'Value');
        tempCustomApiJsonParsedRec.setrange("Is Array", true);
        CustomApiJSONParsedPage.SetRecords(TempCustomApiJsonParsedRec);
        CustomApiJSONParsedPage.LookupMode(true);

        if CustomApiJSONParsedPage.RunModal() = Action::LookupOK then
            CustomApiJSONParsedPage.GetSelectedRecords(TempCustomApiJsonResultRec);
    end;

    procedure JSONParseAndDisplayNodes(ApiUrl: Text)
    var
        TempCustomApiJsonParsedRec: Record CustomApiJSONParsed temporary;
        CustomAPIJSONSchemaBrowserCU: Codeunit CustomAPIJSONSchemaBrowser;
        ResponseStringTxt: Text;

    begin
        ResponseStringTxt := this.GetResponseString(ApiUrl);
        CustomAPIJSONSchemaBrowserCU.BrowseCustomJson(ResponseStringTxt, TempCustomApiJsonParsedRec);
        Page.Run(Page::CustomApiJSONParsed, TempCustomApiJsonParsedRec);
    end;

    local procedure GetResponseString(ApiUrl: Text): Text
    var
        Client: HttpClient;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        Headers: HttpHeaders;
        ResponseString: Text;
    begin
        Request.SetRequestUri(ApiUrl);
        Request.Method('GET');
        Request.GetHeaders(Headers);
        Headers.Add('Accept', 'application/json');

        if not Client.Send(Request, Response) then
            Error('Error Api call.');

        if not Response.IsSuccessStatusCode() then
            Error('API error: %1 (%2)', Response.HttpStatusCode(), Response.ReasonPhrase());

        Response.Content().ReadAs(ResponseString);

        exit(ResponseString);
    end;


}
