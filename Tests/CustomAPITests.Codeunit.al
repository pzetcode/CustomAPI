namespace CustomAPI.Tests;
using CustomAPI;

codeunit 50200 "CustomAPI Tests"
{
    Subtype = Test;

    [Test]
    procedure SetupRecordUsesTenAsDefaultLimit()
    var
        CustomAPISetupRec: Record CustomAPISetup;
    begin
        CustomAPISetupRec.Init();

        AssertEquals(10, CustomAPISetupRec.LimitRecords, 'The default record limit should be 10.');
    end;

    [Test]
    procedure SetupRecordAcceptsLimitWithinConfiguredRange()
    var
        CustomAPISetupRec: Record CustomAPISetup;
    begin
        CustomAPISetupRec.Init();
        CustomAPISetupRec.Validate(LimitRecords, 100);

        AssertEquals(100, CustomAPISetupRec.LimitRecords, 'The maximum configured record limit should be accepted.');
    end;

    [Test]
    procedure JSONPathMarksArrayValueAsArray()
    var
        CustomApiJSONParsedRec: Record CustomApiJSONParsed;
    begin
        CustomApiJSONParsedRec.Init();
        CustomApiJSONParsedRec.Validate(Path, 'products[0].name');

        AssertTrue(CustomApiJSONParsedRec."Is Array", 'A path containing an array segment should be marked as an array value.');
    end;

    [Test]
    procedure JSONPathWithoutArraySegmentIsNotMarkedAsArray()
    var
        CustomApiJSONParsedRec: Record CustomApiJSONParsed;
    begin
        CustomApiJSONParsedRec.Init();
        CustomApiJSONParsedRec.Validate(Path, 'metadata.name');

        AssertTrue(not CustomApiJSONParsedRec."Is Array", 'A path without an array segment should not be marked as an array value.');
    end;

    local procedure AssertEquals(Expected: Integer; Actual: Integer; FailureMessage: Text)
    begin
        if Expected <> Actual then
            Error('%1 Expected %2, but got %3.', FailureMessage, Expected, Actual);
    end;

    local procedure AssertTrue(Condition: Boolean; FailureMessage: Text)
    begin
        if not Condition then
            Error(FailureMessage);
    end;
}
