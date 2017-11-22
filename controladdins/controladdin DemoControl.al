controladdin DemoControl
{
    Scripts =
        'scripts/jquery-2.1.0.min.js',
        'scripts/demo.js';
    StartupScript = 'scripts/start.js';

    StyleSheets = 'stylesheets/demo.css';

    Images = 
        'images/o.png',
        'images/x.png';

    RequestedHeight = 500;
    RequestedWidth = 500;

    MaximumWidth = 1920;
    MaximumHeight = 1080;
    VerticalShrink = false;
    HorizontalShrink = false;
    VerticalStretch = true;
    HorizontalStretch = true;

    procedure SetName(Name: Text);
    event ControlReady();
}