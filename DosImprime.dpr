program DosImprime;

uses
  Forms,
  Windows,
  Dialogs,
  DosImprimeUnit1 in 'DosImprimeUnit1.pas' {Form1};

{$R *.RES}
Var
  Hwnd: THandle;

begin

  Hwnd := FindWindow('TApplication', 'Dataprol Dosimprime');
  if Hwnd = 0 then begin
        Application.Initialize;
        //Application.MainFormOnTaskbar := True;
        Application.CreateForm(TForm1, Form1);
        Application.ShowMainForm := False;
        Application.Title := 'Dataprol Dosimprime';
        Application.Run;
  end else begin
        SetForegroundWindow(Hwnd);
        ShowMessage('Aplicação já está aberta e em uso!');
  end;

end.




