namespace CustomAPI;

codeunit 50124 CustomAPIJSONSchemaBrowser
{

    procedure BrowseCustomJson(JsonText: Text; var TempJsonNode: Record CustomApiJSONParsed)
    var
        RootToken: JsonToken;
    begin
        if JsonText = '' then exit;
        if not RootToken.ReadFrom(JsonText) then
            Error('JSON invalid structure.');

        this.IterateJsonToken(RootToken, '', TempJsonNode);
    end;

    local procedure IterateJsonToken(CurrentToken: JsonToken; CurrentPath: Text; var TempJsonNode: Record CustomApiJSONParsed)
    var
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        ChildToken: JsonToken;
        KeyName: Text;
    begin
        //object node
        if CurrentToken.IsObject() then begin
            JsonObject := CurrentToken.AsObject();
            this.InsertNode(CurrentPath, 'Object', TempJsonNode);

            foreach KeyName in JsonObject.Keys() do begin
                JsonObject.Get(KeyName, ChildToken);
                this.IterateJsonToken(ChildToken, this.CombinePath(CurrentPath, KeyName, false), TempJsonNode);
            end;
            exit;
        end;

        //array node
        if CurrentToken.IsArray() then begin
            JsonArray := CurrentToken.AsArray();
            InsertNode(CurrentPath, 'Array', TempJsonNode);

            if JsonArray.Get(0, ChildToken) then
                this.IterateJsonToken(ChildToken, this.CombinePath(CurrentPath, Format(0), true), TempJsonNode);

            exit;
        end;

        //value node
        if CurrentToken.IsValue() then begin
            this.InsertNode(CurrentPath, 'Value', TempJsonNode);
            exit;
        end;
    end;

    local procedure CombinePath(ParentPath: Text; ChildKey: Text; IsArrayItem: Boolean): Text
    begin
        if ParentPath = '' then
            if IsArrayItem then exit('[' + ChildKey + ']') else exit(ChildKey);

        if IsArrayItem then
            exit(ParentPath + '[' + ChildKey + ']')
        else
            exit(ParentPath + '.' + ChildKey);
    end;

    local procedure InsertNode(NodePath: Text; NodeType: Text; var TempJsonNode: Record CustomApiJSONParsed)
    begin
        TempJsonNode.Init();
        TempJsonNode."Node ID" := TempJsonNode."Node ID" + 1;

        if NodePath = '' then
            TempJsonNode.Path := 'ROOT'
        else
            TempJsonNode.Validate(Path, CopyStr(NodePath, 1, 250));

        TempJsonNode."Node Type" := CopyStr(NodeType, 1, 30);

        TempJsonNode.Insert();
    end;

}
