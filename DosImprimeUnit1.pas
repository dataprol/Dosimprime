unit DosImprimeUnit1;

interface

uses
  Printers, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FileCtrl, ComCtrls, ShellAPI, Menus, jpeg, Registry, StrUtils;

const
  WM_ICONTRAY = WM_USER + 1;

type
  TForm1 = class(TForm)
    Button1: TButton;
    PrintDialog1: TPrintDialog;
    Timer1: TTimer;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    ListBox1: TListBox;
    Label4: TLabel;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    PopupMenu1: TPopupMenu;
    Iniciar1: TMenuItem;
    Parar1: TMenuItem;
    Abrir1: TMenuItem;
    Fechar1: TMenuItem;
    Esconder1: TMenuItem;
    Edit2: TEdit;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Button3: TButton;
    Button4: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
    CheckBox2: TCheckBox;
    Edit7: TEdit;
    Label9: TLabel;
    MainMenu1: TMainMenu;
    Panel1: TPanel;
    Image7: TImage;
    Label6: TLabel;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    CheckBoxASCIIANSI: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure Esconder1Click(Sender: TObject);
    procedure Iniciar1Click(Sender: TObject);
    procedure Parar1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Impressora1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure CheckBoxASCIIANSIClick(Sender: TObject);
  private
    { Private declarations }
    TrayIconData: TNotifyIconData;
  public
    { Public declarations }
    procedure TrayMessage(var Msg: TMessage); message WM_ICONTRAY;   end;
    function VersaoExe: String;
    function GravaRegIni: boolean;
    Function AtualizaArquivoIni: boolean;
    Function QtdLinhasArq( cArq: string): integer;
    function DosToAnsi(S: String): String;
    function AnsiToDos(S: String): String;


var
  Form1: TForm1;
  Fcfg: textfile;
  NomeArquivoCfg: string;
  TextoCfg: string;
  ImpSel1: string;
  ImpSel2: string;
  ImpSel3: string;
  Caminho1: string;
  Caminho2: string;
  Caminho3: string;
  ExecIniWin: string;
  ClicouX: string;
  FonteFixa: string;
  FonteTamanho: string;
  FonteNome: string;
  Ejetar: string;
  ASCIIparaANSI: string;

implementation

{$R *.DFM}

{
*  ASCIIANSI:
*  - Conversão de caracteres ASCII para ANSI.
*
*-----------\ASCIIANSI
}
function ASCIIANSI( cTexto: string; cOpcao: string ): string;
begin

   {
   If cOpcao = NIL or vartype(cOpcao) <> "C" then begin
   If cOpcao = Null then begin
      cOpcao := '1';
   End;
   }
   If cOpcao = '4' then begin
      // Remove quebra de linha.
      cTexto := AnsiReplaceStr( cTexto, CHR(10)+CHR(13), '' );
   End;

   If cOpcao = '3' then begin
      //&& Remove o '' do ANSI, 'ì' do ASCII. Gerado pelo campo Memo/PCM
      //&& da linguagem xBase, no final de cada linha.
      cTexto := AnsiReplaceStr( cTexto, '', '' );
   End;

   If cOpcao = '2' then begin
      //&& Remove o '' do ANSI, 'ì' do ASCII. Gerado pelo campo Memo/PCM
      //&& da linguagem xBase, no final de cada linha.
      cTexto:=AnsiReplaceStr( cTexto, 'ì', '' );
   End;

   //If cOpcao $ '12' then begin
   If (cOpcao = '1') or (cOpcao = '2') then begin
      cTexto:=AnsiReplaceStr( cTexto, '¿', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, 'À', '|' );
      cTexto:=AnsiReplaceStr( cTexto, 'Á', '_' );
      cTexto:=AnsiReplaceStr( cTexto, 'Â', '_' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ã', '|' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ä', '_' );
      cTexto:=AnsiReplaceStr( cTexto, 'Å', '+' );
      cTexto:=AnsiReplaceStr( cTexto, 'È', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, 'É', '|' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ê', '_' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ë', '_' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ì', '|' );
      cTexto:=AnsiReplaceStr( cTexto, 'Í', '=' );
      cTexto:=AnsiReplaceStr( cTexto, 'Î', '+' );
      cTexto:=AnsiReplaceStr( cTexto, '³', '|' );
      cTexto:=AnsiReplaceStr( cTexto, '´', '|' );
      cTexto:=AnsiReplaceStr( cTexto, '¹', '|' );
      cTexto:=AnsiReplaceStr( cTexto, 'º', '|' );
      cTexto:=AnsiReplaceStr( cTexto, '»', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, '¼', '|' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ù', '|' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ú', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, 'ß', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, 'Û', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ü', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, 'þ', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, '°', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, '±', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, '²', ' ' );
      cTexto:=AnsiReplaceStr( cTexto, 'ê', 'Û' );
      cTexto:=AnsiReplaceStr( cTexto, '§', 'º' );
      cTexto:=AnsiReplaceStr( cTexto, '¦', 'ª' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ž', 'Ä' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ó', 'Ë' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ø', 'Ï' );
      cTexto:=AnsiReplaceStr( cTexto, 'š', 'Ü' );
      cTexto:=AnsiReplaceStr( cTexto, 'ë', 'Ù' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ç', 'Ã' );
      cTexto:=AnsiReplaceStr( cTexto, 'å', 'Õ' );
      cTexto:=AnsiReplaceStr( cTexto, '¶', 'Â' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ò', 'Ê' );
      cTexto:=AnsiReplaceStr( cTexto, '×', 'Î' );
      cTexto:=AnsiReplaceStr( cTexto, '·', 'À' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ô', 'È' );
      cTexto:=AnsiReplaceStr( cTexto, 'Þ', 'Ì' );
      cTexto:=AnsiReplaceStr( cTexto, 'µ', 'Á' );
      cTexto:=AnsiReplaceStr( cTexto, '', 'É' );
      cTexto:=AnsiReplaceStr( cTexto, 'Ö', 'Í' );
      cTexto:=AnsiReplaceStr( cTexto, '‹', 'ï' );
      cTexto:=AnsiReplaceStr( cTexto, '”', 'ö' );
      cTexto:=AnsiReplaceStr( cTexto, '', 'ü' );
      cTexto:=AnsiReplaceStr( cTexto, 'Œ', 'î' );
      cTexto:=AnsiReplaceStr( cTexto, '“', 'ô' );
      cTexto:=AnsiReplaceStr( cTexto, '–', 'û' );
      cTexto:=AnsiReplaceStr( cTexto, 'Š', 'è' );
      cTexto:=AnsiReplaceStr( cTexto, '', 'ì' );
      cTexto:=AnsiReplaceStr( cTexto, '•', 'ò' );
      cTexto:=AnsiReplaceStr( cTexto, '£', 'ú' );
      cTexto:=AnsiReplaceStr( cTexto, 'é', 'Ú' );
      cTexto:=AnsiReplaceStr( cTexto, '¢', 'ó' );
      cTexto:=AnsiReplaceStr( cTexto, ' ', 'á' );
      cTexto:=AnsiReplaceStr( cTexto, '‰', 'ë' );
      cTexto:=AnsiReplaceStr( cTexto, '—', 'ù' );
      cTexto:=AnsiReplaceStr( cTexto, 'à', 'Ó' );
      cTexto:=AnsiReplaceStr( cTexto, 'ã', 'Ò' );
      cTexto:=AnsiReplaceStr( cTexto, 'â', 'Ô' );
      cTexto:=AnsiReplaceStr( cTexto, '‚', 'é' );
      cTexto:=AnsiReplaceStr( cTexto, '¡', 'í' );
      cTexto:=AnsiReplaceStr( cTexto, '™', 'Ö' );
      cTexto:=AnsiReplaceStr( cTexto, '…', 'à' );
      cTexto:=AnsiReplaceStr( cTexto, 'Æ', 'ã' );
      cTexto:=AnsiReplaceStr( cTexto, 'ä', 'õ' );
      cTexto:=AnsiReplaceStr( cTexto, 'ƒ', 'â' );
      cTexto:=AnsiReplaceStr( cTexto, 'ˆ', 'ê' );
      cTexto:=AnsiReplaceStr( cTexto, '„', 'ä' );
      cTexto:=AnsiReplaceStr( cTexto, '€', 'Ç' );
      cTexto:=AnsiReplaceStr( cTexto, '‡', 'ç' );
   End;

   Result := cTexto;
end;

procedure ConvTextOut(CV: TCanvas; const sText: String; x, y, angle:integer);
var
  LogFont: TLogFont;
  SaveFont: TFont;
begin
  SaveFont := TFont.Create;
  SaveFont.Assign(CV.Font);
  GetObject(SaveFont.Handle, sizeof(TLogFont), @LogFont);
  with LogFont do
  begin
    lfEscapement := angle *10;
    lfPitchAndFamily := FIXED_PITCH or FF_DONTCARE;
  end;
  CV.Font.Handle := CreateFontIndirect(LogFont);
  SetBkMode(CV.Handle, TRANSPARENT);
  CV.TextOut(x, y, sText);
  CV.Font.Assign(SaveFont);
  SaveFont.Free;
end;

procedure TForm1.TrayMessage(var Msg: TMessage);
begin
  Case Msg.LParam of
    WM_LBUTTONDOWN:
    begin
      If form1.visible then
      begin
        Form1.Hide;
      end
      else
      begin
        Form1.Show;
      end;
    end;
    WM_RBUTTONDOWN:
    begin
      begin PopupMenu1.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
      end;
    end;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
Var
  cDirLocal: string;
  Dummy: DWORD;
  S: string;
begin


     With TrayIconData do
     begin
          cbSize := SizeOf();
          Wnd := Handle;
          uID := 0;
          uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
          uCallbackMessage := WM_ICONTRAY;
          hIcon := Application.Icon.Handle;
          StrPCopy(szTip, Application.Title);
     end;
     Shell_NotifyIcon(NIM_ADD, @TrayIconData);

     Combobox1.Items := Screen.Fonts;

     if printer.printers.Text = '' then begin
        ShowMessage( 'Não há impressoras instaladas para que o Dosimprime funcione.'+#13+'Verifique em Painel de Controle->Impressoras.'+#13+'DICA: se for utilizar uma impressora do tipo matricial ou não tiver driver original, instale o driver '+#13+'Genérico/Text Only, para uma impressão mais rápida.' );
        timer1.Enabled := false;
        button2.caption := '&Ativar';
        //image1.visible := false;
        TrayIconData.szTip := 'Dosimprime - Inativo';
        //Application.Terminate;
     end;

     Form1.Caption := 'Dosimprime '+ VersaoExe() +' - Luiz Carlos Costa Rodrigues(Dataprol)';

     GetDir( 0, cDirLocal );

     Caminho1 := Edit1.text;
     Caminho2 := Edit5.text;
     Caminho3 := Edit6.text;

      if not DirectoryExists(Caminho1) then begin
          CreateDir(Caminho1);
      end;
      if not DirectoryExists(Caminho2) then begin
          CreateDir(Caminho2);
      end;
      if not DirectoryExists(Caminho3) then begin
          CreateDir(Caminho3);
      end;

     NomeArquivoCfg := ExtractFileDir(Application.ExeName)+'\'+'Dosimprime.ini';

     if FileExists(NomeArquivoCfg) then begin
       AssignFile( Fcfg, NomeArquivoCfg );
       FileMode := 2;
       Reset( Fcfg );
       Readln( Fcfg, ImpSel1 );
       Readln( Fcfg, ImpSel2 );
       Readln( Fcfg, ImpSel3 );
       Readln( Fcfg, Ejetar );
       Readln( Fcfg, Caminho1 );
       Readln( Fcfg, ExecIniWin );
       Readln( Fcfg, Caminho2 );
       Readln( Fcfg, Caminho3 );
       Readln( Fcfg, ClicouX );
       Readln( Fcfg, FonteFixa );
       Readln( Fcfg, FonteTamanho );
       Readln( Fcfg, FonteNome );
       Readln( Fcfg, ASCIIparaANSI );
       CloseFile( Fcfg );
       Edit7.Text := FonteTamanho;
       ComboBox1.Text := FonteNome;
       Edit1.text := Caminho1;
       Edit5.text := Caminho2;
       Edit6.text := Caminho3;
       Edit2.text := printer.Printers.Strings[strtoint( ImpSel1 )];
       Edit3.text := printer.Printers.Strings[strtoint( ImpSel2 )];
       Edit4.text := printer.Printers.Strings[strtoint( ImpSel3 )];
       if Ejetar = '1' then begin
            checkbox1.Checked:=true;
       end else begin
            checkbox1.Checked:=false;
       end;
       GravaRegIni();
       if ImpSel1 > '' then begin
         Printer.PrinterIndex := strtoint( ImpSel1 );
       end;
       if ExecIniWin = '1' then begin
            checkbox3.Checked := true;
       end else begin
            checkbox3.Checked := false;
       end;
       if FonteFixa = '1' then begin
            checkbox2.Checked := true;
            edit7.Enabled := true;
            combobox1.Enabled := true;
       end else begin
            checkbox2.Checked := false;
            edit7.Enabled := false;
            combobox1.Enabled := false;
       end;
       if impsel1 = '' then begin
            impsel1 := impsel1;
       end;
       if impsel2 = '' then begin
            impsel2 := impsel1;
       end;
       if impsel3 = '' then begin
            impsel3 := impsel1;
       end;
      if ASCIIparaANSI = '1' then begin
          checkboxASCIIANSI.Checked := true;
      end else begin
          checkboxASCIIANSI.Checked := false;
      end;


     end else begin

       ShowMessage('Como é a 1ª vez que acessa o Dosimprime, neste computador, deverá escolher uma impressora, agora.');
       If PrintDialog1.Execute then Begin
         StatusBar1.SimpleText := 'Definido uma impressora para uso com Dosimprime.';
       end
       else begin
         StatusBar1.SimpleText := 'A impressora padrão será utilizada.';
         Showmessage('A impressora padrão será utilizada.');
       end;
       Edit2.text := Printer.Printers.Strings[Printer.Printerindex];
       ImpSel1 := inttostr(printer.PrinterIndex);
       ImpSel2 := inttostr(printer.PrinterIndex);
       ImpSel3 := inttostr(printer.PrinterIndex);
       AssignFile( Fcfg, NomeArquivoCfg );
       FileMode := 2;
       Rewrite( Fcfg );
       Writeln( Fcfg, ImpSel1 );
       Writeln( Fcfg, ImpSel2 );
       Writeln( Fcfg, ImpSel3 );
       Writeln( Fcfg, '1' );
       Writeln( Fcfg, Caminho1 );
       Writeln( Fcfg, '1' );
       Writeln( Fcfg, Caminho2 );
       Writeln( Fcfg, Caminho3 );
       Writeln( Fcfg, '0' );
       Writeln( Fcfg, '0' );
       Writeln( Fcfg, 11 );
       Writeln( Fcfg, 'Courier New' );
       Writeln( Fcfg, '1' );
       Flush( Fcfg );
       CloseFile( Fcfg );
       ShowMessage('Sempre que executar o Dosimprime, o mesmo ficará'+#13+'minimizado como um ícone, na bandeija do sistema.')

     end;

     filelistbox1.Directory := Caminho1;
     filelistbox1.Update;
     timer1.Enabled := true;
     button2.caption := '&Desativar';
     image1.visible := true;
     Iniciar1.Enabled := false;
     Parar1.Enabled := true;
     Abrir1.Enabled:=true;
     Esconder1.Enabled:=false;

end;


procedure TForm1.Timer1Timer(Sender: TObject);
var
  nLinha: integer;
  nLinhaAtual: integer;
  nLinhasTotais: integer;
  DupAlt: boolean;
  DupLarg: boolean;
  nIndice: integer;
  FontPadrao: string;
  TituloImprime: string;
  PadraoImprime: integer;
  TamanhoPadrao: integer;
  nFimDeLinha: boolean;
  nPesquisa: integer;
  Simprime: string;
  X: integer;
  Y: integer;
  ArqRef: TextFile;
  ArqRef2: string;
  Texto: string;
  TextoANSI: string;
  cESC: string;
  cNormal: string;
  cCondensado: string;
  cExpandido: string;
  cNegritoON : string;
  cNegritoOFF: string;
  cItalicoOn: string;
  cItalicoOff: string;
  cSubliOn: string;
  cSubliOff: string;
  cEliteON : string;
  cEliteOFF: string;
  cLandOn: string;
  cLandOff: string;
  cReset: string;
  cDupImpOn: string;
  cDupImpOff: string;
  cDupLargOn: string;
  cDupLargOff: string;
  cDupAltOn: string;
  cDupAltOff: string;
  c15cpiOn:string;
  c15cpiOff: string;
  cImpPreto: string;
  cImpMagenta: string;
  cImpCiano: string;
  cImpAzul: string;
  cImpAmarelo: string;
  cImpVermelho: string;
  cImpVerde: string;
  cPropSpON: string;
  cPropSpOFF: String;
  cEjetar: string;
  cLinSp16: string;
  cLinSp18: string;
  cLinSp772: string;
begin


  if not DirectoryExists(Caminho1) then begin
      CreateDir(Caminho1);
  end;
  if not DirectoryExists(Caminho2) then begin
      CreateDir(Caminho2);
  end;
  if not DirectoryExists(Caminho3) then begin
      CreateDir(Caminho3);
  end;

  if not DirectoryExists(Caminho1 + '\WIN1') then begin
      CreateDir(Caminho1 + '\WIN1');
  end;
  if not DirectoryExists(Caminho2 + '\WIN2') then begin
      CreateDir(Caminho2 + '\WIN2');
  end;
  if not DirectoryExists(Caminho3 + '\WIN3') then begin
      CreateDir(Caminho3 + '\WIN3');
  end;

  if filelistbox1.Directory = Caminho2 + '\WIN2' then begin
      filelistbox1.Directory := Caminho3 + '\WIN3';
      filelistbox1.Update;
      If FileListBox1.items.Count > 0 then begin
          Printer.PrinterIndex := strtoint( ImpSel3 );
      end;
  end else if filelistbox1.Directory = Caminho1 then begin
      filelistbox1.Directory := Caminho1 + '\WIN1';
       filelistbox1.Update;
      If FileListBox1.items.Count > 0 then begin
          Printer.PrinterIndex := strtoint( ImpSel1 );
      end;
  end else if filelistbox1.Directory = Caminho3 + '\WIN3' then begin
      filelistbox1.Directory := Caminho1;
      filelistbox1.Update;
      If FileListBox1.items.Count > 0 then begin
          Printer.PrinterIndex := strtoint( ImpSel1 );
      end;
  end else if filelistbox1.Directory = Caminho1 + '\WIN1' then begin
      filelistbox1.Directory := Caminho2 + '\WIN2';
      filelistbox1.Update;
      If FileListBox1.items.Count > 0 then begin
          Printer.PrinterIndex := strtoint( ImpSel2 );
      end;
  end;



  If FileListBox1.items.Count > 0 then begin

    if printer.printers.Text > '' then begin

        StatusBar1.SimpleText := 'Arquivo de impressão encontrado, abrindo...';

        timer1.Interval:=2000;
        timer1.Enabled := false;
        button2.caption := '&Ativar';

        Try
            ArqRef2 := FileListBox1.Items.Strings[0];
            nLinhasTotais := QtdLinhasArq( ArqRef2 );

            AssignFile( ArqRef, FileListBox1.Items.Strings[0] );
            { Define acesso somente para leitura: }
            FileMode := 0;
            { Abre o arquivo }
            Reset( ArqRef );

            StatusBar1.SimpleText := 'Arquivo de pedido de impressão aberto com sucesso.';
            memo1.Lines.Add('Arquivo de pedido de impressão foi aberto.');
        Except
            timer1.interval := 5000;
            //MessageDlg('Erro ao acessar arquivo', mtWarning, [mbOk], 0);
            StatusBar1.SimpleText := 'Erro retornado ao tentar abrir pedido de impressão.';
            memo1.Lines.Add('Erro retornado na abertura de arquivo.');
            timer1.Enabled := true;
            button2.caption := '&Desativar';
            Exit();
        End;

        If IOResult <> 0 then begin
            //MessageDlg('Erro ao acessar arquivo', mtWarning, [mbOk], 0);
           timer1.Enabled := true;
           button2.caption := '&Desativar';
           Exit();
        end;

        { Lê uma linha do arquivo }
        StatusBar1.SimpleText := 'Lendo 1ª linha do arquivo...';
        Readln(ArqRef, Texto);
        { Carrega primeira linha com as configurações }
        Try
              If (copy(texto,1,2) < 'A') and (copy(texto,1,2) > '0') then begin
                 FontPadrao    := 'Courier New';
                 TamanhoPadrao := StrToInt( copy(texto,1,2) );
                 PadraoImprime := StrToInt( copy(texto,3,1) );
                 TituloImprime := copy(texto,4,20);
                 StatusBar1.SimpleText := 'Configurações iniciais carregadas com o conteúdo da 1ª linha...';
              end else begin
                   //showmessage('1ª Linha para configuração está vazia!');
                   FontPadrao    := 'Courier New';
                   TamanhoPadrao := 12 ;
                   PadraoImprime := 1 ;
                   TituloImprime := 'Dosimprime.';
                   StatusBar1.SimpleText := 'Configurações iniciais carregadas com definições padrão...';
              end;
        Except
              //showmessage('1ª Linha contem textos mas não os comandos esperados!');
              FontPadrao    := 'Courier New';
              TamanhoPadrao := 12;
              PadraoImprime := 1;
              TituloImprime := 'DosImprime.';
              StatusBar1.SimpleText := 'Configurações iniciais carregadas com definições padrão...';
        end;

        If PadraoImprime = 2 then begin // padrão HP
           cESC        := Chr(27);
           cNormal     := cESC + '(s10H';
           cCondensado := cESC + '(s16.66H';
           cExpandido  := '';
           cNegritoON  := cESC + '(s3B';
           cNegritoOFF := cESC + '(s0B';
           cItalicoOn  := cESC + '(s1S';
           cItalicoOff := cESC + '(s0S';
           cSubliOn    := cESC + '&dD';
           cSubliOff   := cESC + '&d@';
           cEliteOn    := cESC + '(s12H';
           cEliteOff   := cNormal;
           cLandOn     := cESC + '&l1O'; // Impressão estilo paisagem
           cLandOff    := cESC + '&l0O'; // Desativa
           cReset      := cESC + 'E';
           cEjetar     := CHR(12);
           StatusBar1.SimpleText := 'Comandos da HP carregados...';
        end
        Else if PadraoImprime = 1 then begin // padrão EPSON
             cESC        := Chr(27);
             cNormal     := Chr(18);
             cCondensado := Chr(15);   // Mais de 16.66cpi. Bem pequeno. Mas, há menor.
             cExpandido  := Chr(14);   // Expandido só em na linha onde for ativado.
             c15cpiOn    := Chr(27)+'g';  // 15cpi. Tamanho pequeno maior que condensado, fixo, mesmo alternando Condensado e Normal.
             c15cpiOff   := CHR(27)+'P';  // Desativa 15cpi e Elite. Retorna ao tamanho em uso antes.
             cDupImpOn   := Chr(27)+'G';  // Imprime duas vezes sobre si mesmo. Destaca.
             cDupImpOff  := Chr(27)+'H';  // Desativa
             cDupLargOn  := Chr(27)+'W1'; // Dupla Largura. Como expandido, porém, para várias linhas, até que desative-o.
             cDupLargOff := Chr(27)+'W0'; // Desativa
             cDupAltOn   := Chr(27)+'w1'; // Dupla altura, ligado. Linhas bem finas.
             cDupAltOff  := Chr(27)+'w0'; // Desativa
             cEliteOn    := CHR(27)+'M';  // 12cpi. Se condensado ativado, fica menor. Se Normal, fica pouco menor.
             cEliteOff   := c15cpiOff;    // Desativa Elite/15CPI.
             cNegritoOn  := Chr(27)+'E';
             cNegritoOff := Chr(27)+'F';
             cItalicoOn  := Chr(27)+'4';
             cItalicoOff := Chr(27)+'5';
             cSubliOn    := Chr(27)+'-'+CHR(1);
             cSubliOff   := Chr(27)+'-'+CHR(0);
             cImpPreto   := Chr(27)+'r'+CHR(0);   // Preto
             cImpMagenta := Chr(27)+'r'+CHR(1);   // Magenta
             cImpCiano   := Chr(27)+'r'+CHR(2);   // Ciano
             cImpAzul    := Chr(27)+'r'+CHR(3);   // Azul
             cImpAmarelo := Chr(27)+'r'+CHR(4);   // Amarelo
             cImpVermelho:= Chr(27)+'r'+CHR(5);   // Vermelho
             cImpVerde   := Chr(27)+'r'+CHR(6);   // Verde
             cLandOn     := '';           // Impressão estilo paisagem
             cLandOff    := '';           // Desativa
             cPropSpON   := CHR(27)+'p'+CHR(1);   // Espaço proporcional
             cPropSpOFF  := CHR(27)+'p'+CHR(0);   // Espaço normal
             cLinSp16    := Chr(27)+'0';          // Fixed Line Spacing 1/6
             cLinSp18    := Chr(27)+'2';          // Fixed Line Spacing 1/8
             cLinSp772   := Chr(27)+'1';          // Fixed Line Spacing 7/72
             cReset      := cPropSpOff+cDupLargOff+cDupAltOff+cDupImpOff+cNormal+cNegritoOff+cItalicoOff+cSubliOff;
             cEjetar     := CHR(12);
             StatusBar1.SimpleText := 'Comandos da EPSON carregados...';
        end
        Else if PadraoImprime = 3 then begin // padrão DOSIMPRIME
             cESC        := Chr(27);
             cNormal     := Chr(18);
             cCondensado := Chr(15);   // Mais de 16.66cpi. Bem pequeno. Mas, existe menor.
             cExpandido  := Chr(14);   // Expandido só em na linha onde for ativado.
             cNegritoOn  := Chr(27)+'E';
             cNegritoOff := Chr(27)+'F';
             cItalicoOn  := Chr(27)+'4';
             cItalicoOff := Chr(27)+'5';
             cSubliOn    := Chr(27)+'-'+CHR(1);
             cSubliOff   := Chr(27)+'-'+CHR(0);
             cEliteOn    := CHR(27)+'M';          // 12cpi continuous enlarged
             cEliteOff   := CHR(27)+'P';          // 10cpi
             cLandOn     := '';
             cLandOff    := '';
             cDupImpOn   := Chr(27)+'G';
             cDupImpOff  := Chr(27)+'H';
             cDupLargOn  := Chr(27)+'W1';         // 10cpi continuous enlarged
             cDupLargOff := Chr(27)+'W0';         // Normal caracter density
             cDupAltOn   := Chr(27)+'w1';         // Dupla altura, ligado
             cDupAltOff  := Chr(27)+'w0';
             c15CPIon    := Chr(27)+'g';          // 15cpi (parece condensado)
             c15CPIoff   := cEliteOff;          //
             cPropSpON   := CHR(27)+'P'+CHR(1);   // Espaço proporcional
             cPropSpOFF  := CHR(27)+'P'+CHR(0);   // Espaço normal
             cImpPreto   := Chr(27)+'r'+CHR(0);   // Preto
             cImpMagenta := Chr(27)+'r'+CHR(1);   // Magenta
             cImpCiano   := Chr(27)+'r'+CHR(2);   // Ciano
             cImpAzul    := Chr(27)+'r'+CHR(3);   // Azul
             cImpAmarelo := Chr(27)+'r'+CHR(4);   // Amarelo
             cImpVermelho:= Chr(27)+'r'+CHR(5);   // Vermelho
             cImpVerde   := Chr(27)+'r'+CHR(6);   // Verde
             cReset      := cDupLargOff + cDupAltOff + cDupImpOff + cNegritoOff;
             cEjetar     := CHR(12);
             StatusBar1.SimpleText := 'Comandos do DOSIMPRIME carregados...';
        end;


        memo1.Lines.Add('Enviando à impressora '+ printer.Printers.Strings[printer.printerindex]);
        { Ajustes iniciais de impressão }
        Printer.BeginDoc;
        Printer.Title := 'Dosimprime: ' + TituloImprime;
        Printer.Canvas.Font.Name := FontPadrao;
        Printer.Canvas.Font.Charset := OEM_CHARSET;
        Printer.canvas.font.Pitch := fpFixed;
        printer.canvas.font.Size := TamanhoPadrao;
        Printer.canvas.font.Style := [];
        Printer.canvas.font.Color := clBlack;
        Y := 1;
        X := 1;
        StatusBar1.SimpleText := 'Ajustes inciais concluídos...';
        memo1.Clear;

        Try

        { Começa a verificação do arquivo e envio da impressão }
        while not eof(ArqRef) do begin

                memo1.lines.add('Lendo linha de texto para impressão...');
                StatusBar1.SimpleText := 'Lendo linha de texto para impressão...';
                Readln( ArqRef, Texto );
                nFimDeLinha := false;
                X           := 1;
                Y           := Y + printer.canvas.TextHeight( Texto );
                DupAlt      := false;
                DupLarg     := false;
                nLinhaAtual := 0;

                While nFimDeLinha = false Do begin

                  StatusBar1.SimpleText := 'Pesquisando por comandos de impressão...';
                  nPesquisa := 0;
                  For nIndice := 1 to Length(Texto) do begin
                      If Copy( Texto, nIndice, 1 ) < Chr(32) then begin
                         nPesquisa := nIndice;
                         break;
                      end;
                  end;

                  If nPesquisa > 0 then begin

                     If nPesquisa > 1 then begin
                        StatusBar1.SimpleText := 'Imprimindo texto...';
                        memo1.Lines.Add('Imprimindo texto...');
                        Simprime := Copy( Texto, 1, nPesquisa - 1 );
                        Printer.Canvas.TextOut(X, Y, Simprime);
                        X := X + printer.canvas.TextWidth(Simprime) ;
                     end;

                     If Pos( cEjetar, Copy(Texto,nPesquisa,Length(cEjetar)) ) > 0 then begin
                        StatusBar1.SimpleText := 'Ejeção...';
                        memo1.Lines.Add('Ejeção...');
                        Texto := Copy( Texto, nPesquisa + Length( cEjetar ), Length(Texto) );
                        Printer.Canvas.TextOut(X, Y, Texto);
                        If checkbox1.Checked then begin
                          Printer.NewPage;
                          Y := 1;
                          X := 1;
                        end;
                     end
                     else If Pos( cNormal, Copy(Texto,nPesquisa,Length(cNormal)) ) > 0 then begin
                        StatusBar1.SimpleText := 'Normal Ativado...';
                        memo1.Lines.Add('Normal Ativado...');
                        printer.canvas.font.Size := TamanhoPadrao;
                        Printer.canvas.font.Pitch := fpFixed;
                        Texto := Copy( Texto, nPesquisa + Length( cNormal ), Length(Texto) );
                     end
                     else If Pos( cExpandido, Copy(Texto,nPesquisa,Length( cExpandido )) ) > 0 then begin
                        memo1.Lines.Add('Expandido Ativado, somente 1 linha...');
                        //StatusBar1.SimpleText := 'Expandido Ativado, somente 1 linha...';
                        //Printer.canvas.font... :=;
                        Texto := Copy( Texto, nPesquisa + Length( cExpandido ), Length(Texto) );
                     end
                     else If Pos( cCondensado, Copy(Texto,nPesquisa,Length(cCondensado)) ) > 0 then begin
                        memo1.Lines.Add('Condensado...');
                        StatusBar1.SimpleText := 'Condensado...';
                        printer.canvas.font.Size := 6;
                        Texto := Copy( Texto, nPesquisa + Length( cCondensado ), Length(Texto) );
                     end
                     else If Pos( cPropSpON, Copy(Texto,nPesquisa,length(cPropSpON)) ) > 0 then begin
                        memo1.Lines.Add('Espaço Proporcional Ativado...');
                        //StatusBar1.SimpleText := 'Espaço Proporcional Ativado...';
                        //Printer.canvas.font... :=;
                        Texto := Copy( Texto, nPesquisa + length(cPropSpON), Length(Texto) );
                     end
                     else if Pos( cPropSpOFF, Copy(Texto,nPesquisa,length(cPropSpOFF)) ) > 0 then begin
                        memo1.Lines.Add('Espaço Fixo/Padrão...');
                        //StatusBar1.SimpleText := 'Espaço Fixo...';
                        //Printer.canvas.font.... :=;
                        Texto := Copy( Texto, nPesquisa + Length(cPropSpOFF), Length(Texto) );
                     end
                     else If Pos( cSubliOn, Copy(Texto,nPesquisa,Length(cSubliOn)) ) > 0 then begin
                        memo1.Lines.Add('Sublinhado Ativado...');
                        StatusBar1.SimpleText := 'Sublinhado Ativado...';
                        Printer.canvas.font.style := Printer.canvas.font.style + [fsUnderline];
                        Texto := Copy( Texto, nPesquisa + Length(cSubliOn), Length(Texto) );
                     end
                     else If Pos( cSubliOff, Copy(Texto,nPesquisa,Length(cSubliOff)) ) > 0 then begin
                        memo1.Lines.Add('Sem Sublinhado...');
                        StatusBar1.SimpleText := 'Sem Sublinhado...';
                        Printer.canvas.font.style := Printer.canvas.font.style - [fsUnderline];
                        Texto := Copy( Texto, nPesquisa + Length(cSubliOff), Length(Texto) );
                     end
                     else If Pos( c15cpiOn, Copy(Texto,nPesquisa,Length( c15cpiOn )) ) > 0 then begin
                        memo1.Lines.Add('15 CPI Ativado...');
                        StatusBar1.SimpleText := '15 CPI Ativado...';
                        Printer.canvas.font.size := 8;
                        Texto := Copy( Texto, nPesquisa + Length( c15cpiOn ), Length(Texto) );
                     end
                     else If Pos( c15cpiOff, Copy(Texto,nPesquisa,Length( c15cpiOff )+1) ) > 0 then begin
                        memo1.Lines.Add('Sem 15 CPI e sem Elite(12CPI)...');
                        StatusBar1.SimpleText := 'Sem 15 CPI ou Elite...';
                        Printer.canvas.font.size := TamanhoPadrao;
                        Texto := Copy( Texto, nPesquisa + Length( c15cpiOff ), Length(Texto) );
                     end
                     else If Pos( cDupImpOn, Copy(Texto,nPesquisa,Length(cDupImpOn)) ) > 0 then begin
                        memo1.Lines.Add('Dupla Impressão Ativado...');
                        StatusBar1.SimpleText := 'Dupla Impressão Ativado...';
                        Printer.canvas.font.style := Printer.canvas.font.style + [fsBold];
                        Texto := Copy( Texto, nPesquisa + Length( cDupImpOn ), Length(Texto) );
                     end
                     else If Pos( cDupImpOff, Copy(Texto,nPesquisa,Length( cDupImpOff )) ) > 0 then begin
                        memo1.Lines.Add('Sem Dupla Impressão...');
                        StatusBar1.SimpleText := 'Sem Dupla Impressão...';
                        Printer.canvas.font.style := Printer.canvas.font.style - [fsBold];
                        Texto := Copy( Texto, nPesquisa + Length( cDupImpOff ), Length(Texto) );
                     end
                     else If Pos( cEliteOn, Copy(Texto,nPesquisa,Length( cEliteOn )) ) > 0 then begin
                        memo1.Lines.Add('Elite 12CPI Ativado...');
                        //StatusBar1.SimpleText := 'Elite 12CPI Ativado...';
                        //Printer.canvas.font... :=;
                        Texto := Copy( Texto, nPesquisa + Length( cEliteOn ), Length(Texto) );
                     end
                     else If Pos( cEliteOff, Copy(Texto,nPesquisa,Length( cEliteOff )) ) > 0 then begin
                        { *** É o mesmo comando c15cpiOFF, na EPSON e mesmo que cNormal na HP *** }
                     end
                     else If Pos( cNegritoOn, Copy(Texto,nPesquisa,Length(cNegritoOn)) ) > 0 then begin
                        memo1.Lines.Add('Negrito Ativado...');
                        StatusBar1.SimpleText := 'Negrito Ativado...';
                        Printer.canvas.font.style := Printer.canvas.font.style + [fsBold];
                        Texto := Copy( Texto, nPesquisa + Length( cNegritoOn ), Length(Texto) );
                     end
                     else If Pos( cNegritoOff, Copy(Texto,nPesquisa,Length(cNegritoOff)) ) > 0 then begin
                        memo1.Lines.Add('Sem Negrito...');
                        StatusBar1.SimpleText := 'Sem Negrito...';
                        Printer.canvas.font.style := Printer.canvas.font.style - [fsBold];
                        Texto := Copy( Texto, nPesquisa + Length( cNegritoOff ), Length(Texto) );
                     end
                     else If Pos( cItalicoOn, Copy(Texto,nPesquisa,Length(cItalicoOn)) ) > 0 then begin
                        memo1.Lines.Add('Itálico Ativado...');
                        StatusBar1.SimpleText := 'Itálico Ativado...';
                        Printer.canvas.font.style := Printer.canvas.font.style + [fsItalic];
                        Texto := Copy( Texto, nPesquisa + Length( cItalicoOn ), Length(Texto) );
                     end
                     else If Pos( cItalicoOff, Copy(Texto,nPesquisa,Length(cItalicoOff)) ) > 0 then begin
                        memo1.Lines.Add('Sem Itálico...');
                        StatusBar1.SimpleText := 'Sem Itálico...';
                        Printer.canvas.font.style := Printer.canvas.font.style - [fsItalic];
                        Texto := Copy( Texto, nPesquisa + Length( cItalicoOff ), Length(Texto) );
                     end
                     else If Pos( cLinSp16, Copy(Texto,nPesquisa,Length( cLinSp16 )) ) > 0 then begin
                        memo1.Lines.Add('Fixed Line Spacing 1/6...');
                        //StatusBar1.SimpleText := 'Fixed Line Spacing 1/6...';
                        //Printer.canvas.font... :=;
                        Texto := Copy( Texto, nPesquisa + Length( cLinSp16 ), Length(Texto) );
                     end
                     else If Pos( cLinSp18, Copy(Texto,nPesquisa,Length( cLinSp18 )) ) > 0 then begin
                        memo1.Lines.Add('Fixed Line Spacing 1/8...');
                        //StatusBar1.SimpleText := 'Fixed Line Spacing 1/8...';
                        //Printer.canvas.font.... :=;
                        Texto := Copy( Texto, nPesquisa + Length( cLinSp18 ), Length(Texto) );
                     end
                     else If Pos( cLinSp772, Copy(Texto,nPesquisa,Length( cLinSp772 )) ) > 0 then begin
                        memo1.Lines.Add('Fixed Line Spacing 7/72...');
                        //StatusBar1.SimpleText := 'Fixed Line Spacing 7/72...';
                        //Printer.canvas.font.... :=;
                        Texto := Copy( Texto, nPesquisa + Length( cLinSp772 ), Length(Texto) );
                     end
                     else If Pos( cDupAltOn, Copy(Texto,nPesquisa,Length( cDupAltOn )) ) > 0 then begin
                        memo1.Lines.Add('Dupla Altura Ativado...');
                        StatusBar1.SimpleText := 'Dupla Altura Ativado...';
                        //AddFontResource('onuava__.ttf');
                        //printer.Canvas.Font.Name := 'Onuava';
                        //Printer.canvas.font.Pitch := fpFixed;
                        //printer.canvas.font.size := TamanhoPadrao + 3;
                        //Printer.canvas.Font.Height:= 70;
                        Y := Y - 30;
                        DupAlt := true;
                        Texto := Copy( Texto, nPesquisa + Length( cDupAltOn ), Length(Texto) );
                     end
                     else If Pos( cDupAltOff, Copy(Texto,nPesquisa,Length( cDupAltOff )) ) > 0 then begin
                        memo1.Lines.Add('Sem Dupla Altura...');
                        StatusBar1.SimpleText := 'Sem Dupla Altura...';
                        If DupAlt then begin
                           Printer.Canvas.Font.Name := FontPadrao;
                           Printer.canvas.font.Pitch := fpFixed;
                           Printer.canvas.font.size := TamanhoPadrao;
                           Y := Y + 30;
                           DupAlt := false;
                        end;
                        Texto := Copy( Texto, nPesquisa + Length( cDupAltOff ), Length(Texto) );
                     end
                     else If Pos( cDupLargOn, Copy(Texto,nPesquisa,Length( cDupLargOn )) ) > 0 then begin
                        memo1.Lines.Add('Dupla Largura Ativado...');
                        StatusBar1.SimpleText := 'Dupla Largura Ativado...';
                        //AddFontResource('binchrt.ttf');
                        //Printer.Canvas.Font.Name := 'Courier New';
                        Printer.canvas.font.Pitch := fpFixed;
                        Printer.canvas.font.Size := TamanhoPadrao*2;
                        Y := Y - 30;
                        //ConvTextOut(Printer.Canvas, 'Imagem de texto', X, Y, 0);
                        DupLarg := true;
                        Texto := Copy( Texto, nPesquisa + Length( cDupLargOn ), Length(Texto) );
                     end
                     else If Pos( cDupLargOff, Copy(Texto,nPesquisa,Length( cDupLargOff )) ) > 0 then begin
                        memo1.Lines.Add('Sem Dupla Largura...');
                        StatusBar1.SimpleText := 'Sem Dupla Largura...';
                        If DupLarg then begin
                           Printer.Canvas.Font.Name := FontPadrao;
                           Printer.canvas.font.Pitch := fpFixed;
                           Printer.canvas.font.size := TamanhoPadrao;
                           Y := Y + 30;
                           DupLarg := false;
                        End;
                        Texto := Copy( Texto, nPesquisa + Length( cDupLargOff ), Length(Texto) );
                     end
                     else If Pos( cLandOn, Copy(Texto,nPesquisa,Length( cLandOn )) ) > 0 then begin
                        memo1.Lines.Add('Modo Paisagem Ativado...');
                        //StatusBar1.SimpleText := 'Modo Paisagem Ativado...';
                        //Printer.canvas.font... :=;
                        Texto := Copy( Texto, nPesquisa + Length( cLandOn ), Length(Texto) );
                     end
                     else If Pos( cLandOff, Copy(Texto,nPesquisa,Length( cLandOff )) ) > 0 then begin
                        memo1.Lines.Add('Modo Retrato...');
                        //StatusBar1.SimpleText := 'Modo Retrato...';
                        //Printer.canvas.font.... :=;
                        Texto := Copy( Texto, nPesquisa + Length( cLandOff ), Length(Texto) );
                     end
                     else begin
                        memo1.Lines.Add('Comando não reconhecido...');
                        StatusBar1.SimpleText := 'Comando não reconhecido...';
                        Texto := Copy( Texto, nPesquisa + 1, Length(Texto) );
                     end;
                  End
                  Else begin
                      if checkbox2.Checked then begin
                          printer.canvas.font.Size := strtoint(edit7.Text);
                          printer.canvas.font.Name := combobox1.Text;
                      end;
                      StatusBar1.SimpleText := 'Imprimindo linha... ';
                      if checkboxasciiansi.Checked = true then begin
                           Texto := ASCIIANSI( Texto, '1' );
                      end;
                      Printer.Canvas.TextOut( X, Y, Texto );
                      memo1.Lines.Add('Imprimindo texto..."'+Texto+'"');
                      nFimDeLinha := true;
                      nLinhaAtual := nLinhaAtual + 1
                  End;

                end;

                if Y >= Printer.PageHeight - (printer.canvas.TextHeight( Texto ) + 3) then begin
                     memo1.Lines.Add('Atingiu fim de página. Ejetando...');
                     StatusBar1.SimpleText := 'Atingiu fim de página. Ejetando...';
                     If checkbox1.Checked then begin
                          if nLinha < nLInhasTotais then begin
                               Printer.NewPage;
                               Y := 1;
                               X := 1;
                          end;
                     end;
                end;

        end;

        {
        printer.canvas.font.Size    := 12;
        ABarraPrinter1.Codigo       := '123456789123';
        ABarraPrinter1.Digito       := '1';
        ABarraPrinter1.Tipo	       := cdEAN13;
        ABarraPrinter1.CorBarra     := clBlack;
        ABarraPrinter1.CorEspaco    := clWhite;
        ABarraPrinter1.Largura	    := 5;
        ABarraPrinter1.Comprimento	 := 15;
        ABarraPrinter1.LinhaPrinter := 1;
        ABarraPrinter1.ColunaPrinter:= 55;
        ABarraPrinter1.Execute;
        }

        StatusBar1.SimpleText := 'Encerrando...';
        Printer.EndDoc;
        ListBox1.Items.Add( DateTimeToStr(Now) + ' - ' + FileListBox1.Items.Strings[0] );
        CloseFile(ArqRef);
        DeleteFile(FileListBox1.Items.Strings[0]);
        filelistbox1.Update;
        timer1.Enabled := true;
        button2.caption := '&Desativar';
        StatusBar1.SimpleText := 'Concluído. Documento enviado à impressora.';

        Except

         memo1.Lines.Add('Erro durante a tentativa de impressão.');
         StatusBar1.SimpleText := 'Erro durante a tentativa de impressão.';
         end;

      filelistbox1.Update;

    end
    else begin
      StatusBar1.SimpleText := 'Inativo. Sem impressora instalada.';
    end;

  end;

  { Alterna imagens do ícone, dando sensação de estar girando }
    // exibe ícone diferente enquanto conecta ao FTP
  If image4.Visible = true then begin
     image4.visible := false;
     image1.visible := true;
     TrayIconData.hIcon := Image1.Picture.Icon.Handle;
  end
  else If image3.Visible = true then begin
     image3.visible := false;
     image4.visible := true;
     TrayIconData.hIcon := Image4.Picture.Icon.Handle;
  end
  else If image2.Visible = true then begin
     image2.visible := false;
     image3.visible := true;
     TrayIconData.hIcon := Image3.Picture.Icon.Handle;
  end
  else If image1.Visible = true then begin
     image1.visible := false;
     image2.visible := true;
     TrayIconData.hIcon := Image2.Picture.Icon.Handle;
  end;
  //Shell_NotifyIcon(NIM_MODIFY, @TrayIconData);

  timer1.Interval:=100;


end;


procedure TForm1.Button1Click(Sender: TObject);
begin
     timer1.Enabled := false;

     printer.PrinterIndex := strtoint(ImpSel1);
     If PrintDialog1.Execute then Begin
         filelistbox1.Update;
         timer1.Enabled := true;
         Edit2.text := printer.Printers.Strings[printer.printerindex];
         StatusBar1.SimpleText := 'Configuração da impressora nº1 foi alterada.';
       ImpSel1 := inttostr(printer.PrinterIndex);
     end;

     timer1.Enabled := true;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     if button2.caption = '&Desativar' then begin
        button2.caption := '&Ativar';
        timer1.Enabled := false;
        Application.Icon.Handle;
        TrayIconData.hIcon := Application.Icon.Handle;
        Shell_NotifyIcon(NIM_MODIFY, @TrayIconData);
     end
     else begin
        button2.caption := '&Desativar';
        timer1.Enabled := true;
     end;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
     timer1.Enabled := false;

     printer.PrinterIndex := strtoint(ImpSel2);
     If PrintDialog1.Execute then Begin
       filelistbox1.Update;
       timer1.Enabled := true;
       Edit3.text := printer.Printers.Strings[printer.printerindex];
       StatusBar1.SimpleText := 'Configuração da impressora nº2 foi alterada.';
       ImpSel2 := inttostr(printer.PrinterIndex);
     end;

     timer1.Enabled := true;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
     timer1.Enabled := false;

     printer.PrinterIndex := strtoint(ImpSel3);
     If PrintDialog1.Execute then Begin
       filelistbox1.Update;
       timer1.Enabled := true;
       Edit4.text := printer.Printers.Strings[printer.printerindex];
       StatusBar1.SimpleText := 'Configuração da impressora nº3 foi alterada.';
       ImpSel3 := inttostr(printer.PrinterIndex);
     end;

     timer1.Enabled := true;

end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
    if checkbox1.Checked then begin
        Ejetar := '1';
    end else begin
        Ejetar := '0';
    end;
    AtualizaArquivoIni();
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin

    if checkbox2.Checked then begin
        edit7.Enabled := true;
        combobox1.Enabled := true;
        FonteFixa := '1';
        FonteTamanho := edit7.Text;
        FonteNome := combobox1.Text;
    end else begin
        FonteFixa := '0';
        FonteTamanho := edit7.Text;
        FonteNome := combobox1.Text;
        edit7.Enabled := false;
        combobox1.Enabled := false;
    end;
    AtualizaArquivoIni();

end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin

    if checkbox3.Checked then begin
        ExecIniWin := '1'
    end else begin
        ExecIniWin := '0'
    end;
    GravaRegIni();
    AtualizaArquivoIni();

end;

procedure TForm1.CheckBoxASCIIANSIClick(Sender: TObject);
begin
    if checkboxasciiansi.Checked = true then begin
        ASCIIparaANSI := '1';
    end else begin
        ASCIIparaANSI := '0';
    end;
    AtualizaArquivoIni();
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
    FonteNome := ComboBox1.Text;
    AtualizaArquivoIni();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    AtualizaArquivoIni();
    Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

procedure TForm1.Abrir1Click(Sender: TObject);
begin
     Form1.Show;
     Abrir1.Enabled:=false;
     Esconder1.Enabled:=true;
end;

procedure TForm1.Esconder1Click(Sender: TObject);
begin
     Form1.Hide;
     Abrir1.Enabled:=true;
     Esconder1.Enabled:=false;
end;


procedure TForm1.Iniciar1Click(Sender: TObject);
begin

     button2.caption := '&Desativar';
     timer1.Enabled := true;
     StatusBar1.SimpleText := 'Reiniciado pelo usuário...';
     Iniciar1.Enabled := false;
     Parar1.Enabled := true;

end;

procedure TForm1.Parar1Click(Sender: TObject);
begin

     button2.caption := '&Ativar';
     timer1.Enabled := false;
     StatusBar1.SimpleText := 'Interrompido pelo usuário...';
     Parar1.Enabled := false;
     Iniciar1.Enabled := true;
end;

procedure TForm1.Fechar1Click(Sender: TObject);
begin

     if Application.MessageBox( 'Deseja realmente fechar o Dosimprime?', 'Dosimprime - Encerramento', MB_YESNO + MB_DEFBUTTON1 ) = IDYES then begin
        timer1.Enabled := false;
        Application.Terminate;
     end;

end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     CanClose := false;
     Form1.Hide;
     if ClicouX <> '1' then begin
        ShowMessage('Ao clicar no botão [X] para fechar o programa, o mesmo ficará na bandeija do sistema, ao lado do relógio.'+#13+'Se desejar que volte ao estado normal, clique com o botão do mouse sobre seu ícone.');
        ClicouX := '1';
     end;
end;

procedure TForm1.Impressora1Click(Sender: TObject);
begin
     Button1click(button1);
end;

procedure TForm1.FormClick(Sender: TObject);
begin
  Form1.Refresh;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Form1.Refresh;
end;



procedure TForm1.Image7Click(Sender: TObject);
begin
  WinExec( 'EXPLORER http://www.dataprol.com.br', Sw_Show );
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
  WinExec( 'EXPLORER http://www.dataprol.com.br', Sw_Show );
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
     Caminho1 := Edit1.text;
     timer1.Enabled := true;
end;

procedure TForm1.Edit5Exit(Sender: TObject);
begin
     Caminho2 := Edit5.text;
     timer1.Enabled := true;
end;

procedure TForm1.Edit6Exit(Sender: TObject);
begin
     Caminho3 := Edit6.text;
     timer1.Enabled := true;
end;


procedure TForm1.Edit7Change(Sender: TObject);
begin
       FonteTamanho := edit7.Text;
       AtualizaArquivoIni();
end;

Function VersaoExe: String;
type
   PFFI = ^vs_FixedFileInfo;
var
   F       : PFFI;
   Handle  : Dword;
   Len     : Longint;
   Data    : Pchar;
   Buffer  : Pointer;
   Tamanho : Dword;
   Parquivo: Pchar;
   Arquivo : String;
begin
   Arquivo  := Application.ExeName;
   Parquivo := StrAlloc(Length(Arquivo) + 1);
   StrPcopy(Parquivo, Arquivo);
   Len := GetFileVersionInfoSize(Parquivo, Handle);
   Result := '';
   if Len > 0 then
   begin
      Data:=StrAlloc(Len+1);
      if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
      begin
         VerQueryValue(Data, '',Buffer,Tamanho);
         F := PFFI(Buffer);
         Result := Format('%d.%d.%d.%d',
                          [HiWord(F^.dwFileVersionMs),
                           LoWord(F^.dwFileVersionMs),
                           HiWord(F^.dwFileVersionLs),
                           Loword(F^.dwFileVersionLs)]
                         );
      end;
      StrDispose(Data);
   end;
   StrDispose(Parquivo);
end;

Function GravaRegIni: boolean;
var reg: tregistry;
    s: string;
begin

   if ExecIniWin = '1' then begin
       Reg := TRegistry.Create;
       S:=ExtractFileDir(Application.ExeName)+'\'+ExtractFileName(Application.ExeName);
       Reg.rootkey:=HKEY_CURRENT_USER;
       Reg.Openkey('SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\RUN',false);
       Reg.WriteString('Dosimprime',S);
       Reg.closekey;
       Reg.Free;
   end else begin
       Reg := TRegistry.Create;
       S:=ExtractFileDir(Application.ExeName)+'\'+ExtractFileName(Application.ExeName);
       Reg.rootkey:=HKEY_CURRENT_USER;
       Reg.Openkey('SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\RUN',false);
       Reg.WriteString('Dosimprime','');
       Reg.closekey;
       Reg.Free;
   end;

   Result := true;

end;

Function AtualizaArquivoIni: boolean;
begin
       NomeArquivoCfg := ExtractFileDir(Application.ExeName) + '\' + 'Dosimprime.ini';
       AssignFile( Fcfg, NomeArquivoCfg );
       FileMode := 2;
       Rewrite( Fcfg );
       Writeln( Fcfg, ImpSel1 );
       Writeln( Fcfg, ImpSel2 );
       Writeln( Fcfg, ImpSel3 );
       Writeln( Fcfg, Ejetar );
       Writeln( Fcfg, Caminho1 );
       Writeln( Fcfg, ExecIniWin );
       Writeln( Fcfg, Caminho2 );
       Writeln( Fcfg, Caminho3 );
       Writeln( Fcfg, ClicouX );
       Writeln( Fcfg, FonteFixa );
       Writeln( Fcfg, FonteTamanho );
       Writeln( Fcfg, FonteNome );
       Writeln( Fcfg, ASCIIparaANSI );
       Flush( Fcfg );
       CloseFile( Fcfg );
end;

Function QtdLinhasArq( cArq: string): integer;
Var
 Linhas : integer;
 Lista: TStringList;
begin
   Lista := TStringList.Create;
   try
     Lista.LoadFromFile( cArq );
     Linhas:= Lista.Count;
   finally
     Lista.Free;
   end;
   cArq := IntToStr(Linhas);
   Result := Linhas;
end;

function DosToAnsi(S: String): String;
begin
  SetLength(Result, Length(S));
  OEMToCharBuff( pAnsichar(S), PChar(Result), Length(S));
end;

function AnsiToDos(S: String): String;
begin
  SetLength(Result, Length(S));
  AnsiToOEMBuff(PAnsiChar(S), PANSiChar(Result), Length(S));
end;

end.
