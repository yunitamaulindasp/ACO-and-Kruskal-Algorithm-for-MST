{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, StdCtrls, ExtCtrls, Math;

type  matrik = array of array of real;
      Graph = record
        mtBobot : matrik;
        size : integer;
      end;

type  Titik = record
        posisi : TPoint;
        warna : TColor;
      end;

type
  TForm2 = class(TForm)
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Tbhitung: TButton;
    btHapus: TButton;
    imgTitik: TImage;
    sgMatriks: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edA: TEdit;
    edB: TEdit;
    edT: TEdit;
    btBuka: TButton;
    procedure TbHitungClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImgTitikMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SgMatriksDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SgMatriksKeyPress(Sender: TObject; var Key: Char);
    procedure SgMatriksSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SgMatriksSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure btBukaClick(Sender: TObject);
    procedure btHapusClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edAKeyPress(Sender: TObject; var Key: Char);
    procedure edBKeyPress(Sender: TObject; var Key: Char);
    procedure TbSaveClick(Sender: TObject);
  private
    G : Graph;
    arTitik : array of Titik;
    nilaivisability,nilaiprob: matrik;
  public
    procedure GambarBobot(const v1, v2: byte);
    procedure GambarSisi(const v1, v2: byte);
    procedure GambarTitik (const index : Integer; const repaint: Boolean);
    procedure HapusBobot(const v1, v2: byte);
    procedure HapusSisi(const v1, v2: byte);
    procedure Buka;
    procedure Hapus;
    procedure Simpan;
    procedure KruskalxACO;
    function cekbobot(b: matrik): string;
  end;

var
  Form2: TForm2;
  alfa,beta,Tij,ij,nTij: real;

implementation

uses Unit3;

{$R *.dfm}

procedure TForm2.TbHitungClick(Sender: TObject);
begin
  if (cekbobot(G.mtBobot)='') then
    Application.MessageBox('Nilai Bobot Kosong!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  else
  begin
    if (edA.Text='') then
      Application.MessageBox('Nilai Parameter Alfa Kosong!', 'Information', MB_OK or MB_ICONEXCLAMATION)
    else
    begin
      alfa:=strtofloat(edA.Text);
      if (alfa=0) then
        Application.MessageBox('Nilai parameter tidak boleh NOL!', 'Information', MB_OK or MB_ICONEXCLAMATION)
      else
      begin
        if (alfa>1) then
          Application.MessageBox('Nilai Alfa tidak boleh lebih dari 1!', 'Information', MB_OK or MB_ICONEXCLAMATION)
        else
        begin
          if (edB.Text='') then
            Application.MessageBox('Nilai Parameter Beta Kosong!', 'Information', MB_OK or MB_ICONEXCLAMATION)
          else
          begin
            beta:=strtofloat(edB.Text);
            if (beta=0) then
              Application.MessageBox('Nilai parameter tidak boleh NOL!', 'Information', MB_OK or MB_ICONEXCLAMATION)
            else
            begin
              if (edT.Text='') then
                Application.MessageBox('Nilai Parameter Tij Kosong!', 'Information', MB_OK or MB_ICONEXCLAMATION)
              else
              begin
                Tij:=strtofloat(edT.Text);
                if (Tij=0) then
                  Application.MessageBox('Nilai parameter tidak boleh NOL!', 'Information', MB_OK or MB_ICONEXCLAMATION)
                else
                begin
                  form3.mmOutput.Clear;
                  kruskalxaco;
                  Form3.show;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Simpan;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  imgTitik.Canvas.Brush.Color := clWhite;
  imgTitik.Canvas.FillRect(Rect(0, 0, imgTitik.Width, imgTitik.Height));

  sgMatriks.Cells[0, 0] := 'Titik';
  sgMatriks.Cells[1, 0] := '1';
  sgMatriks.Cells[0, 1] := '1';
  ij:=0;
end;

procedure TForm2.GambarBobot(const v1, v2: byte);
var P1, P2: TPoint; xC, yC: integer; bobot : real;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;

  xC := Round((P1.X + P2.X)/2);
  yC := Round((P1.Y + P2.Y)/2);
  bobot := G.mtBobot[v1, v2];

  imgTitik.Canvas.Font.Color := clBlue;
  imgTitik.Canvas.TextOut(xC, yC+6, FloatToStr(bobot));
  imgTitik.Canvas.Font.Color := clBlack;
end;

procedure TForm2.GambarSisi(const v1, v2: byte);
var P1, P2: TPoint;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;
  imgTitik.Canvas.Pen.Color := clBlack;
  imgTitik.Canvas.MoveTo(P1.X, P1.Y);
  imgTitik.Canvas.LineTo(P2.X, P2.Y);

  GambarBobot(v1, v2);
  GambarTitik(v1, true);
  GambarTitik(v2, true);
end;

procedure TForm2.GambarTitik(const index: Integer; const repaint: Boolean);
var X, Y : Integer;
begin
    X := arTitik[index].posisi.X;
    Y := arTitik[index].posisi.Y;

    imgTitik.Canvas.Pen.Color := clBlack;
    imgTitik.Canvas.Ellipse(X-6, Y-6, X+6, Y+6);
    imgtitik.Canvas.Brush.Color := arTitik[index].warna;

    imgTitik.Canvas.FloodFill(X, Y, clBlack, fsBorder);
    imgTitik.Canvas.Brush.Color := clWhite;
    imgTitik.Canvas.Font.Color := clRed;
    imgTitik.Canvas.Font.Style := [fsBold];

    imgTitik.Canvas.TextOut(X-5, Y+10, Format('%d', [index+1]));
    imgTitik.Canvas.Font.Color := clBlack;
    imgTitik.Canvas.Font.Style := [];

    Form3.imgHasil.Canvas.Pen.Color := clBlack;
    Form3.imgHasil.Canvas.Ellipse(X-6, Y-6, X+6, Y+6);
    Form3.imgHasil.Canvas.Brush.Color := arTitik[index].warna;

    Form3.imgHasil.Canvas.FloodFill(X, Y, clBlack, fsBorder);
    Form3.imgHasil.Canvas.Brush.Color := clWhite;
    Form3.imgHasil.Canvas.Font.Color := clRed;
    Form3.imgHasil.Canvas.Font.Style := [fsBold];

    Form3.imgHasil.Canvas.TextOut(X-5, Y+10, Format('%d', [index+1]));
    Form3.imgHasil.Canvas.Font.Color := clBlack;
    Form3.imgHasil.Canvas.Font.Style := [];

    if repaint then imgTitik.Repaint();
end;

procedure TForm2.HapusBobot(const v1, v2: byte);
var P1, P2: TPoint; xC, yC: integer; bobot : real;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;

  xC := Round((P1.X + P2.X)/2);
  yC := Round((P1.Y + P2.Y)/2);
  bobot := G.mtBobot[v1, v2];

  imgTitik.Canvas.Font.Color := clwhite;
  imgTitik.Canvas.TextOut(xC, yC+6, FloatToStr(bobot));
  imgTitik.Canvas.Font.Color := clBlack;
end;

procedure TForm2.HapusSisi(const v1, v2: byte);
var p1, p2: TPoint;
begin
  P1 := arTitik[v1].posisi;
  P2 := arTitik[v2].posisi;
  imgTitik.Canvas.Pen.Color := clWhite;
  imgTitik.Canvas.MoveTo(P1.X, P1.Y);
  imgTitik.Canvas.LineTo(P2.X, P2.Y);

  HapusBobot(v1, v2);
  GambarTitik(v1, true);
  GambarTitik(v2, true);
end;

procedure TForm2.ImgTitikMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var P, b : Integer;
begin
  if (Button = mbLeft) then
  begin
    P := Length(arTitik);
    setLength(arTitik, P+1);
    arTitik[P].posisi := Point(X,Y);
    arTitik[P].warna := clYellow;
    G.size := P+1;
    setLength(G.mtBobot, G.size, G.size);
    if G.size > 1 then
    begin
      sgMatriks.ColCount := sgMatriks.ColCount + 1;
      sgMatriks.RowCount := sgMatriks.RowCount + 1;
      sgMatriks.Col := 2;
      sgMatriks.Row := 1;
    end;
    b := sgMatriks.ColCount - 1;
    sgMatriks.Cells[0, b] := Format('%d', [b]);
    sgMatriks.Cells[b, 0] := Format('%d', [b]);
    GambarTitik(P, true);
  end;
end;

procedure TForm2.SgMatriksDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (ACol = ARow) then
  begin
    if not (gdFixed in State) then
    begin
      sgMatriks.Canvas.Brush.Color := clGray;
      sgMatriks.Canvas.FillRect(Rect);
      sgMatriks.Canvas.Brush.Color := clWhite; 
    end;
  end
  else
  if not (gdSelected in State) and not (gdFixed in State) then
  begin
    if sgMatriks.Cells[ACol, ARow] = '' then
    begin
      sgMatriks.Cells[ACol, ARow] := '0';
    end;
  end;
end;

procedure TForm2.SgMatriksKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
    Key := #00
  else
  if (Key = #13) then
    if sgMatriks.Col > sgMatriks.Row then
      if sgMatriks.Col < (sgMatriks.ColCount - 1) then
        sgMatriks.Col := sgMatriks.Col + 1
      else
        if sgMatriks.Row < (sgMatriks.RowCount - 2) then
        begin
          sgMatriks.Row := sgMatriks.Row + 1;
          sgMatriks.Col := sgMatriks.Row + 1;
        end
    else
    begin
      if sgMatriks.Col = sgMatriks.RowCount then
        if sgMatriks.Row < (sgMatriks.RowCount - 1) then
        begin
          sgMatriks.Row := sgMatriks.Row + 1;
          sgMatriks.Col := 1;
        end
        else
          sgMatriks.Col := sgMatriks.Col + 1;
      Key := #00;
    end;
end;

procedure TForm2.SgMatriksSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  CanSelect := ACol <> ARow;
end;

procedure TForm2.SgMatriksSetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
var bobotLama, bobotBaru : real ;
begin
  bobotLama :=  G.mtBobot[ARow-1, ACol-1];
  if (Value='') and (bobotLama <> 0) then
  begin
    HapusSisi(ARow-1, ACol-1);
    sgMatriks.Cells[ARow, ACol] := value;
    G.mtBobot[ARow-1, ACol-1] := bobotBaru;
    G.mtBobot[ACol-1, ARow-1] := bobotBaru;
    ij:=ij+bobotbaru;
    nTij:=1/ij;
    edT.Text:=formatfloat('0.#####',nTij);
  end
  else
  if Value <> '' then
  begin
    bobotBaru := StrTofloat(Value);
    if (bobotLama=0) and (bobotBaru <> 0) then
    begin
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := bobotBaru;
      G.mtBobot[ACol-1, ARow-1] := bobotBaru;
      GambarSisi(ARow-1, ACol-1);
      ij:=ij+bobotbaru;
    nTij:=1/ij;
    edT.Text:=formatfloat('0.#####',nTij);
    end
    else
    if (bobotLama <> 0) and (bobotBaru = 0) then
    begin
      HapusSisi(ARow-1, ACol-1);
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := 0;
      G.mtBobot[ACol-1, ARow-1] := 0;
      ij:=ij+bobotbaru;
    nTij:=1/ij;
    edT.Text:=formatfloat('0.#####',nTij);
    end
    else
    if (bobotLama <> 0) and (bobotBaru <> 0) and (bobotLama <> bobotBaru) then
    begin
      HapusSisi(ARow-1, ACol-1);
      sgMatriks.Cells[ARow, ACol] := Value;
      G.mtBobot[ARow-1, ACol-1] := bobotBaru;
      G.mtBobot[ACol-1, ARow-1] := bobotBaru;
      GambarSisi(ARow-1, ACol-1);
      ij:=ij+bobotbaru;
    end
  end;
end;

procedure TForm2.Buka;
var myfile: textfile;
    jenis, namafile : string;
    i, j, bykTitik: byte;
    X, Y, banyak : integer;
    bobot, Tij, alfa, beta : real;
begin
  if opendialog1.Execute then
  begin
    Hapus;
    namafile := opendialog1.FileName;
    assignfile(myfile, namafile);
    reset(myfile);

    readln(myfile, jenis);
    readln(myfile, bykTitik);
    setLength(G.mtBobot, bykTitik, bykTitik);

    G.size := bykTitik;

    setlength(arTitik, bykTitik);
    sgMatriks.ColCount := bykTitik+1;
    SgMatriks.RowCount := bykTitik+1;

    readln(myfile, jenis);
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
        begin
          readln(myfile, bobot);
          G.mtBobot[i, j] := bobot;
          G.mtBobot[j, i] := bobot;
          sgMatriks.Cells[j+1, i+1] := FloatToStr (bobot);
          sgMatriks.Cells[i+1, j+1] := FloatToStr (bobot);
          ij:=ij+bobot;
        end;
    for i := 1 to bykTitik do
    begin
      sgMatriks.Cells[0, i] := Format('%d', [i]);
      sgMatriks.Cells[i, 0] := Format('%d', [i]);
    end;
    nTij:=1/ij;
    edT.Text:=formatfloat('0.#####',nTij);

    readln(myfile, jenis);
    readln(myfile, alfa);
    edA.Text:=floattostr(alfa);

    readln(myfile, jenis);
    readln(myfile, beta);
    edB.Text:=floattostr(beta);

    setLength(arTitik, bykTitik);
    readln(myfile, jenis);
    for i := 0 to bykTitik-1 do
    begin
      readln(myfile, X, Y);
      arTitik[i].posisi := Point(X, Y);
      arTitik[i].warna := clYellow;
    end;
    for i := 0 to bykTitik-1 do
      for j := 0 to bykTitik-1 do
        if j > i then
          if G.mtBobot[i, j] <> 0 then
            GambarSisi(i, j);

    closefile(myfile);
  end;
end;

procedure TForm2.Hapus;
var i, j, bykTitik: byte;
begin
  Form3.mmOutput.Lines.Clear;
  imgTitik.Canvas.Brush.Color := clWhite;
  imgTitik.Canvas.FillRect(Rect(0, 0, imgTitik.Width, imgTitik.Height));
  Form3.imgHasil.Canvas.Brush.Color := clWhite;
  Form3.imgHasil.Canvas.FillRect(Rect(0, 0, Form3.imgHasil.Width, Form3.imgHasil.Height));
  bykTitik := G.size;
  if bykTitik <> 0 then
  begin
    setLength(arTitik, 0);
    for i := 1 to bykTitik do
    begin
      for j := 1 to bykTitik do
      begin
        sgMatriks.Cells[i, j] := '';
      end;
    end;
    for i := 0 to bykTitik-1 do
    begin
      for j := 0 to bykTitik-1 do
      begin
        G.mtBobot[i,j] := 0;
      end;
    end;
    G.size := 0;
    setLength(G.mtBobot, 0, 0);
    sgMatriks.ColCount := 2;
    sgMatriks.RowCount := 2;
  end;

  edA.Text:='';
  edB.Text:='';
  edT.Text:='';
  ij:=0;
end;

procedure TForm2.Simpan;
var i, j, bykTitik : byte;
    namafile: string;
    myfile: textfile;
    X, Y : Integer;
begin
  if savedialog1.Execute then
  begin
    bykTitik := G.size;
    namafile := savedialog1.FileName;
    assignfile(myfile, namafile);
    rewrite(myfile);
    writeln(myfile, '[Banyak titik]');
    writeln(myfile, bykTitik);
    writeln(myfile, '[Bobot sisi]');
    for i := 0 to bykTitik-1 do
    begin
      for j := 0 to bykTitik-1 do
      begin
        if j > i then
        begin
          writeln(myfile, G.mtBobot[i, j]);
        end;
      end;
    end;
    writeln(myfile, '[alfa]');
    writeln(myfile, strtofloat(edA.Text));
    writeln(myfile, '[beta]');
    writeln(myfile, strtofloat(edB.Text));
    writeln(myfile, '[Posisi titik]');
    for i := 0 to bykTitik do
    begin
      X := arTitik[i].posisi.X;
      Y := arTitik[i].posisi.Y;
      writeln(myfile, X, ' ', Y);
    end;
    closefile(myfile);
  end;
end;

procedure TForm2.KruskalxACO;
Var i, j, k, l, p, q, u, v, m: integer;
    n,penyebut,peluang,nProb,panjang: real;
    P1, P2: TPoint;
    Rute: string;
    HimpJ: array of set of byte;
begin
//menghitung probabilitas
  //nilai visability
  setLength(nilaivisability, g.size, g.size);
  for i:=0 to g.size-1 do
    for j:=0 to g.size-1 do
    begin
      if (i<>j) then
      begin
        if (g.mtbobot[i,j]<>0) then
        begin
          nilaivisability[i,j]:=1/g.mtBobot[i,j];
          nilaivisability[j,i]:=1/g.mtbobot[j,i];
        end
        else
        begin
          nilaivisability[i,j]:=0;
          nilaivisability[j,i]:=0;
        end;
      end
      else
      begin
        nilaivisability[i,j]:=0;
        nilaivisability[j,i]:=0;
      end;
    end;
  //hitung nilai Probabilitas
  setLength(nilaiprob, g.size, g.size);
  penyebut:=0;
  for i:=0 to g.size-1 do
    for j:=0 to g.size-1 do
      penyebut:=penyebut+(power(Tij,alfa)*power(nilaivisability[i,j],beta));
  for i:=0 to g.size-1 do
    for j:=0 to g.size-1 do
      if i<>j then
      begin
        peluang:=(power(Tij,alfa)*power(nilaivisability[i,j],beta))/penyebut;
        nilaiprob[i,j]:=peluang;
        nilaiprob[j,i]:=peluang;
      end
      else
      begin
        nilaiprob[i,j]:=0;
        nilaiprob[j,i]:=0;
      end;
      
//buat array untuk menampung himpunan titik
  setlength(himpJ, G.size);
  //isi array
  for k:=0 to G.size-1 do
    himpJ[k]:=[k];

//mengurutkan sisi graph dari terbesar ke terkecil
  m:=0;
  nProb:= 0;
  panjang:=0;
  Rute:= '';
  while (m < g.size-1) do
  begin
    n:= 0;
    //mencari bobot terbesar
    for i:= 0 to G.size-1 do
      for j:= 0 to G.size-1 do
        if (n < nilaiprob[i,j]) then
        begin
          n:= nilaiprob[i,j];
          u:= i;
          v:= j;
        end;
    //cari lokasi titik disimpan
    for k:=0 to G.size-1 do
    begin
      if (u in himpJ[k]) then p:= k;
      if (v in himpJ[k]) then q:= k;
    end;
    //cek siklus
    if (p <> q) then
    begin
      HimpJ[p]:= HimpJ[p] + HimpJ[q];
      HimpJ[q]:= [];
      //menuliskan rute
      if Rute='' then
        Rute:= Rute + ('('+InttoStr(u+1)+','+InttoStr(v+1)+') ')
      else
        Rute:= Rute + ', ' + ('('+InttoStr(u+1)+','+InttoStr(v+1)+') ');
      //hitung nilai probabilitas yang dipilih
      nProb:= nProb + n;
      //membuat garis pada jalur terpilih
      P1 := arTitik[u].posisi; //dapatkan posisi titik awal u
      P2 := arTitik[v].posisi; //dapatkan posisi titik awal v
      Form3.imgHasil.Canvas.Pen.Width := 2; //tentukan ketebalan garis
      Form3.imgHasil.Canvas.Pen.Color := clRed; //warna pen fuchsia
      Form3.imgHasil.Canvas.MoveTo(P1.X, P1.Y); //pindah ke titik awal
      Form3.imgHasil.Canvas.LineTo(P2.X, P2.Y); //gambar garis ke titik tujuan
      Form3.imgHasil.Canvas.Pen.Color := clBlack; //warna brush hitam
      //tampilkan data
      Form3.mmOutput.Lines.Add('Iterasi ke-' + InttoStr(m+1));
      Form3.mmOutput.Lines.Add('Didapat sisi (' + InttoStr(u+1) + ',' + InttoStr(v+1)
                          + ') dengan nilai probabilitas ' + floattostr(n));

      //hitung panjang jalur
      panjang:= panjang + G.mtBobot[u,v];

      //hitung iterasi
      m:= m+1;
    end
    else
      m:=m+0;

    //hapus sisi=hapus bobot
    nilaiprob[u,v]:=0;
    nilaiprob[v,u]:=0;
  end;

  //menampilkan hasil akhir
  Form3.mmOutput.Lines.Add('');
  Form3.mmOutput.Lines.Add  ('------' +
                       'Hasil pencarian rute terpendek dengan Algoritma Kruskal' +
                       '------');
  Form3.mmOutput.Lines.Add('Rute yang dilalui adalah ' + Rute + '.');
  Form3.mmOutput.Lines.Add('Dengan total probabilitas ' + formatfloat('0.######',nProb) + ' dan panjang jalur '+
                            formatfloat('0.##',panjang)+' meter.');
end;

procedure TForm2.btBukaClick(Sender: TObject);
begin
  Buka;
end;

procedure TForm2.btHapusClick(Sender: TObject);
begin
  Hapus;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
form3.Show;
end;

procedure TForm2.edAKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in ['A'..'Z', 'a'..'z', '-']) then
  begin
    Key := #00;
    Application.MessageBox('a>0', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end
  else if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Gunakan Tanda Koma!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

procedure TForm2.edBKeyPress(Sender: TObject; var Key: Char);
begin
  if (key in ['A'..'Z', 'a'..'z', '-']) then
  begin
    Key := #00;
    Application.MessageBox('b>0', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end
  else if not(Key in ['0'..'9', ',']) and not (Key = #13) and not(Key = #8) then
  begin
    Key := #00;
    Application.MessageBox('Gunakan Tanda Koma!', 'Information', MB_OK or MB_ICONEXCLAMATION)
  end;
end;

procedure TForm2.TbSaveClick(Sender: TObject);
begin
  simpan;
end;

function TForm2.cekbobot(b: matrik): string;
var i,j: integer; total:real;
begin
  if G.size=0 then
    result:=''
  else
  begin
  total:=0;
  for i:=0 to g.size-1 do
    for j:=0 to g.size-1 do
      total:=total+G.mtBobot[i,j];
  if (total=0) then
    result:=''
  else
    result:='ada';
  end;
end;

end.
