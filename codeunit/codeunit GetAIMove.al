codeunit 50141 GetAIMove
{
    EventSubscriberInstance=StaticAutomatic;
    var
        Game: Array[9] of Integer;

    trigger OnRun();
    begin        
    end;

    [EventSubscriber(ObjectType::Page, 50141, 'OnGetAIMove','',true,true)]
    procedure GetAIMove(Position: Array[3, 3] of Text; var X: Integer; var Y: Integer; var Handled: Boolean);
    var
        BestMove: Integer;
    begin        
        case DetermineMove(Position) of
            1: begin
                BestMove := 1;
            end;
            2: begin
                if Game[5] = 2 then 
                    BestMove := 5
                else 
                    BestMove := 1;
            end;
            3: begin
                if Game[9] = 2 then 
                    BestMove := 9
                else 
                    BestMove := 3;
            end;
            4: begin
                If FindWinningMove('x') <> 0 then 
                    BestMove := FindWinningMove('x') 
                else 
                    BestMove := FindNonCornerMove;
            end;
            5: begin
                if FindWinningMove('x') <> 0 then 
                    BestMove := FindWinningMove('x') 
                else if FindWinningMove('o') <> 0 then 
                    BestMove := FindWinningMove('o') 
                else if Game[7] = 2 then 
                    BestMove := 7 
                else BestMove := 3
            end;
            6: begin
                If FindWinningMove('o') <> 0 then 
                    BestMove := FindWinningMove('o') 
                else if FindWinningMove('x') <> 0 then 
                    BestMove := FindWinningMove('x') 
                else BestMove := FindNonCornerMove
            end;
            7: begin
                If FindWinningMove('x') <> 0 then 
                    BestMove := FindWinningMove('x') 
                else if FindWinningMove('x') <> 0 then 
                    BestMove := FindWinningMove('o') 
                else 
                    BestMove := FindAnyMove
            end;
            8: begin
                if FindWinningMove('o') <> 0 then 
                    BestMove := FindWinningMove('o')
                else if FindWinningMove('x') <> 0 then 
                    BestMove := FindWinningMove('x')
                else 
                    BestMove := FindAnyMove
            end;
            9: begin
                If FindWinningMove('x') <> 0 then 
                    BestMove := FindWinningMove('x') 
                else if FindWinningMove('x') <> 0 then 
                    BestMove := FindWinningMove('o') 
                else 
                    BestMove := FindAnyMove
            end;
        end;

        ConvertBestMoveToXY(BestMove, X, Y);
        Handled := true;
    end;

    local procedure DetermineMove(Position: Array[3, 3] of Text) Move: Integer
    var
        x: Integer;
        y: Integer;

    begin
        Move := 1;
        for y := 0 to 2 do
          for x := 1 to 3 do begin
            case Position[x,y+1] of
                '': Game[(y * 3) + x] := 2;
                'x': begin
                    Game[(y * 3) + x] := 3;
                    Move += 1;
                end;
                'o': begin
                    Game[(y * 3) + x] := 5;
                    Move += 1;                    
                end;
            end;
        end;
    end;

    local procedure FindWinningMove(color: Text[1]): Integer
    var 
        goal: Integer;
        vector: Text;
        i: Integer;
        first: Integer;
        second: Integer;
        third: Integer;

    begin
        case color of
            'x': goal := 18;
            'o': goal := 50;
        end;
        
        vector := '123456789147258369159357';
        for i := 0 to 7 do begin
            evaluate(first,vector[i * 3 + 1]);
            evaluate(second,vector[i * 3 + 2]);
            evaluate(third,vector[i * 3 + 3]);
            if Game[first] * Game[second] * Game[third] = goal then begin
                if Game[first] = 2 then
                    exit(first);
                if Game[second] = 2 then
                    exit(second);
                exit(third);
            end;
        end;
    end;

    local procedure FindNonCornerMove() : Integer
    begin        
        if Game[5] = 2 then
            exit(5);
        if Game[2] = 2 then
            exit(2);
        if Game[4] = 2 then
            exit(4);
        if Game[6] = 2 then
            exit(6);
        if Game[8] = 2 then
            exit(8);
    end;

    local procedure FindAnyMove() : Integer
    var
        i: Integer;

    begin
        for i := 1 to 9 do
            if Game[i] = 2 then
                exit(i);
    end;

    local procedure ConvertBestMoveToXY(BestMove: Integer; var X: Integer; var Y: Integer)
    begin
        X := ((BestMove-1) MOD 3)+1;
        Y := ((BestMove-1) DIV 3)+1;
    end;
}
