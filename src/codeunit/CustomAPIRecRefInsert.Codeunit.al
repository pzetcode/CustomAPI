namespace CustomAPI;

using System.Reflection;

codeunit 50125 CustomAPIRecRefInsert
{
    procedure GetAPIValuesAndDisplay(var CustomAPIJSONArrayMappingRec: Record CustomAPIJSONArrayMapping; ResponseStringTxt: Text; CustomApiSetup: Record CustomAPISetup)
    var
        FieldRec: Record Field;
        TempCustomAPIValuesRec: Record CustomAPIValues temporary;
        RecRef: RecordRef;
        FldRef: FieldRef;
        PrimaryKeyFieldRef: FieldRef;
        iFieldCounter: Integer;
        iRecCounter: Integer;
        ExpectedFieldName: Text;
        RootToken: JsonToken;
        ArrayToken: JsonToken;
        JSArrayToken: JsonToken;
        JSArray: JsonArray;
        JSArrayObject: JsonObject;

    begin
        RootToken.ReadFrom(responseStringTxt);
        RootToken.SelectToken('$.' + CustomApiSetup.ArrayRoot, ArrayToken);
        JSArray := ArrayToken.AsArray();
        iRecCounter := 0;

        RecRef.Open(Database::CustomAPIValues, true);

        foreach JSArrayToken in JSArray do begin

            if iRecCounter >= CustomApiSetup.LimitRecords then
                break;

            JSArrayObject := JSArrayToken.AsObject();

            RecRef.Init();
            PrimaryKeyFieldRef := RecRef.Field(1);
            PrimaryKeyFieldRef.Value := iRecCounter;

            iFieldCounter := 1;

            if CustomAPIJSONArrayMappingRec.FindSet() then
                repeat
                    ExpectedFieldName := 'Value' + Format(iFieldCounter);
                    FieldRec.SetRange(TableNo, RecRef.Number);
                    FieldRec.SetRange(FieldName, ExpectedFieldName);
                    if FieldRec.FindFirst() then begin
                        FldRef := RecRef.Field(FieldRec."No.");
                        FldRef.Value := CopyStr(this.GetText(JSArrayObject, CustomAPIJSONArrayMappingRec."Property Name"), 1, 250);
                    end else
                        Error('Fieldname not found %1', ExpectedFieldName);

                    //Message(CustomAPIJSONArrayMappingRec."Property Name" + '  ' + Format(iRecCounter) + ' ' + this.GetText(JSArrayObject, CustomAPIJSONArrayMappingRec."Property Name"));
                    iFieldCounter += 1;
                until CustomAPIJSONArrayMappingRec.Next() = 0;

            RecRef.Insert(true);
            iRecCounter += 1;

        end;

        if RecRef.FindSet() then
            repeat
                TempCustomAPIValuesRec.Init();
                RecRef.SetTable(TempCustomAPIValuesRec);
                TempCustomAPIValuesRec.Insert();
            until RecRef.Next() = 0;
        RecRef.Close();
        page.Run(Page::CustomAPIValues, TempCustomAPIValuesRec);

    end;

    local procedure GetText(JObject: JsonObject; PropertyName: Text): Text
    var
        JToken: JsonToken;
    begin
        if JObject.Get(PropertyName, JToken) then
            exit(JToken.AsValue().AsText());
        exit('');
    end;
}
