// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

/// <summary>
/// Provides an example of slowly running code.
/// </summary>
codeunit 50105 "Fridge Race"
{
    Access = Internal;

    trigger OnRun()
    var
        Milk: Record Milk;
    begin
        if FetchMilk(Milk) then begin
            GoToAnotherRoom();
            DrinkMilk(Milk);
        end;
    end;

    local procedure FetchMilk(var Milk: Record Milk): Boolean
    begin
        Milk.SetFilter("Amount Left", '>%1', 0.2);
        Milk.LockTable();
        exit(Milk.FindFirst());
    end;

    local procedure DrinkMilk(var Milk: Record Milk): Boolean
    begin
        Milk."Amount Left" := Milk."Amount Left" - 0.2;
        Milk.Modify();
    end;

    local procedure GoToAnotherRoom()
    begin
        Sleep(30000);
    end;
}