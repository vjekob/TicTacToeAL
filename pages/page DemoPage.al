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
            }
        }
    }
    
    var
        Name: Text;
        ControlIsReady: Boolean;
        
    local procedure UpdateName();
    begin
        if not ControlIsReady then
            exit;

        CurrPage.Demo.SetName(Name);
    end;

    trigger OnInit();
    begin
        Name := 'Vjeko';
    end;

    trigger OnOpenPage();
    begin
        UpdateName();
    end;
}