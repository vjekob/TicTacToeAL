page 50141 "Demo Page"
{
    PageType = Card;
    
    layout
    {
        area(Content)
        {
            field(Name; Name) {
                CaptionML = ENU='Name';
                
                trigger OnValidate();
                begin
                    UpdateName();
                end;
            }
            
            usercontrol(Demo; DemoControl)
            {
                trigger ControlReady();
                begin
                    ControlIsReady := true;
                    UpdateName();
                end;
                
                trigger MovePlayer(Position : JsonObject);
                var
                    TokenX: JsonToken;
                    TokenY: JsonToken;
                    X: Integer;
                    Y: Integer;
                begin
                    if not Position.Get('x',TokenX) or not Position.Get('y',TokenY) then
                        Error('Invalid JSON received: %1',Position);
                    X := TokenX.AsValue().AsInteger();
                    Y := TokenY.AsValue().AsInteger();
                    PlayAI(X,Y);
                end;
            }
        }
    }
    
    var
        ControlIsReady: Boolean;
        Moves: Integer;
        Game: Array[3, 3] of Text;
        Name: Text;
        
    local procedure UpdateName();
    begin
        if not ControlIsReady then
            exit;
            
        CurrPage.Demo.SetName(Name);
    end;
    
    local procedure Win(Winner: Text);
    begin
        Message('%1 wins!',Winner);
        Error('');
    end;
    
    local procedure Draw();
    begin
        Message('It' 's a draw.');
        Error('');
    end;
    
    local procedure CheckWin();
    var
        Column: Integer;
        Row: Integer;
    begin
        for Column := 1 to 3 do
        if(Game [Column,1] = Game [Column,2]) and (Game [Column,1] = Game [Column,3]) and (Game [Column,1] <> '') then
            Win(Game [Column,1]);
        for Row := 1 to 3 do
        if(Game [1,Row] = Game [2,Row]) and (Game [1,Row] = Game [3,Row]) and (Game [1,Row] <> '') then
            Win(Game [1,Row]);
        if(Game [1,1] = Game [2,2]) and (Game [1,1] = Game [3,3]) and (Game [2,2] <> '') then
            Win(Game [2,2]);
        if(Game [1,3] = Game [2,2]) and (Game [1,3] = Game [3,1]) and (Game [2,2] <> '') then
            Win(Game [2,2]);
    end;
    
    local procedure PlayAI(x: Integer; y: Integer);
    var
        Position: JsonObject;
        Free: Boolean;
        Handled: Boolean;
        XAI: Integer;
        YAI: Integer;
    begin
        Moves += 1;
        Game [x + 1,y + 1] := 'x';
        CheckWin();
        
        if(Moves = 9) then
            Draw();
            
        OnGetAIMove(Game, XAI, YAI, Handled);

        if not Handled then
            while not Free do begin
                XAI := Random(3);
                YAI := Random(3);
                Free := Game [XAI,YAI] = '';
            end;
        Game [XAI,YAI] := 'o';
        
        Sleep(1000); // Just to mimic some "thinking"
        Moves += 1;
        Position.Add('x',XAI - 1);
        Position.Add('y',YAI - 1);
        CurrPage.Demo.MoveAI(Position);
    end;
    
    [IntegrationEvent(false, false)]
    local procedure OnGetAIMove(Position: Array[3, 3] of Text; var X: Integer; var Y: Integer; var Handled: Boolean); begin end;

    trigger OnInit();
    begin
        Name := 'Vjeko';
    end;
    
    trigger OnOpenPage();
    begin
        UpdateName();
    end;
}