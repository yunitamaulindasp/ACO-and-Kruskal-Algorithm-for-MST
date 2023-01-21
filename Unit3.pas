unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TForm3 = class(TForm)
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    mmOutput: TMemo;
    imgHasil: TImage;
    TbKeluar: TButton;
    procedure TbKeluarClick(Sender: TObject);
    procedure TbSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Unit2;

{$R *.dfm}

procedure TForm3.TbKeluarClick(Sender: TObject);
begin
  if Application.MessageBox('Anda Yakin Ingin Keluar?','Konfirmasi',MB_ICONINFORMATION+MB_YESNO)=IDYES
  then Form2.Close;
end;

procedure TForm3.TbSaveClick(Sender: TObject);
begin
  Form2.Simpan;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage.PageIndex:=0;
end;

end.
