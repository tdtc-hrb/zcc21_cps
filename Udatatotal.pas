unit Udatatotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Grids, DBGrids, StdCtrls, DB, ADODB, UfunLibA;

type
  Tfrm_sa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    cmbox_dz: TComboBox;
    Label2: TLabel;
    cmbox_mz: TComboBox;
    Label4: TLabel;
    cmbox_dd: TComboBox;
    DataSource1: TDataSource;
    totals1: TADODataSet;
    FindData: TADOQuery;
    pnl_btn: TPanel;
    btn_find: TButton;
    btn_print2: TButton;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    edt_carnum: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_print2Click(Sender: TObject);
    procedure btn_findClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_sa: Tfrm_sa;

implementation
uses
  Udispatch;

{$R *.dfm}

procedure Tfrm_sa.FormShow(Sender: TObject);
var
  PstationStr,breedStr,OperatorStr:string;
  //gsStr:string;
begin
  totals1.Close;
  totals1.CommandText:='select total_weight1, suttle1, car_marque, car_number,'
                +' carry_weight1, self_weight1, yk_weight, breed, Pstation,'
                +' past_date, past_time,OperID from TotalTable';
  totals1.Open;
  //
  //??վ????
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  Pstation from TotalTable';
  FindData.Open;  
  while not FindData.Eof do
  begin
    PstationStr:=FindData.Fields[0].AsString;
    cmbox_dz.Items.Add(PstationStr);
    FindData.Next;
  end;
  //
  //ú??????
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  breed from TotalTable';
  FindData.Open;  
  while not FindData.Eof do
  begin
    breedStr:=FindData.Fields[0].AsString;
    cmbox_mz.Items.Add(breedStr);
    FindData.Next;
  end;
  //
  //????Ա????
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  OperID from TotalTable';
  FindData.Open;  
  while not FindData.Eof do
  begin
    OperatorStr:=FindData.Fields[0].AsString;
    cmbox_dd.Items.Add(OperatorStr);
    FindData.Next;
  end;
  //
  {//????????
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  cumulateConsist from TotalTable';
  FindData.Open;  
  while not FindData.Eof do
  begin
    gsStr:=FindData.Fields[0].AsString;
    cmb_gs.Items.Add(gsStr);
    FindData.Next;
  end;
  //}

end;

procedure Tfrm_sa.FormCreate(Sender: TObject);
begin
  //
  DateTimePicker1.Date:=Date-1;
  DateTimePicker2.Date:=Date;
end;

procedure Tfrm_sa.btn_print2Click(Sender: TObject);
begin
  //
  if GridPrintA(DataSource1.DataSet,DBGrid1) then
        Application.MessageBox('??ӡ????','??ӡ',32);
end;

procedure Tfrm_sa.btn_findClick(Sender: TObject);
var
  sqlstr11,sqlstr12,sqlstr13,sqlstr14,sqlstr15:string;
  datestr1,datestr2:string;
  //
  sqlCollocation:integer;
  cmb_dzINT,cmb_mzINT,cmb_ddINT:integer;
begin
  sqlstr11:='select total_weight1, suttle1, car_marque, car_number, carry_weight1,'
        +' self_weight1, yk_weight, breed, Pstation, past_date, past_time,OperID from TotalTable';
  //
  DataSource1.DataSet:=FindData;
  //
  datestr1:=DateToStr(DateTimePicker1.Date);
  datestr2:=DateToStr(DateTimePicker2.Date);

  sqlstr12:=' where past_date between '+''''+datestr1+''''+' and '+''''+datestr2+'''';
  sqlstr13:=' and Pstation='+''''+cmbox_dz.Text+'''';//??վ
  sqlstr14:=' and breed='+''''+cmbox_mz.Text+'''';   //ú??
  sqlstr15:=' and OperID='+''''+cmbox_dd.Text+'''';  //????Ա

  {//?????߼???ѯ?Ƿ?ѡ??
  if CheckBox1.Checked then
  begin
    if cmb_gs.Text='' then
    begin
      Exit;
    end;
    FindData.Close;
    FindData.SQL.Clear;
    FindData.SQL.Text:=sqlstr11+' where cumulateConsist='+trim(cmb_gs.Text);
    FindData.Open;
    Exit;
  end;}
  if CheckBox1.Checked then
  begin
    if edt_carnum.Text='' then
    begin
      Exit;
    end;
    FindData.Close;
    FindData.SQL.Clear;
    FindData.SQL.Text:=sqlstr11+sqlstr12+' and car_number='+''''+trim(edt_carnum.Text)+'''';
    FindData.Open;
    Exit;
  end;
  //
  if cmbox_dz.Text='' then
  begin
    cmb_dzINT:=1;
  end
  else
  begin
    cmb_dzINT:=2;
  end;
  if cmbox_mz.Text='' then
  begin
    cmb_mzINT:=10;
  end
  else
  begin
    cmb_mzINT:=20;
  end;
  if cmbox_dd.Text='' then
  begin
    cmb_ddINT:=100;
  end
  else
  begin
    cmb_ddINT:=200;
  end;
  
  sqlCollocation:=cmb_dzINT+cmb_mzINT+cmb_ddINT;
  
  case sqlCollocation of
  //??վΪ?յ?
  111:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12;
      FindData.Open;
    end;
  211:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr15;
      FindData.Open;
    end;
  121:
     begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr14;
      FindData.Open;
    end;
  221:
     begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr14+sqlstr15;
      FindData.Open;
    end;
  //??վΪ?ǿյ?
  112:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13;
      FindData.Open;
    end;
  212:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr15;
      FindData.Open;
    end;
  122:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr14;
      FindData.Open;
    end;
  222:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr14+sqlstr15;
      FindData.Open;
    end;
  end;


end;

procedure Tfrm_sa.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Label1.Visible:=False;
    Label2.Visible:=False;
    Label4.Visible:=False;
    cmbox_dz.Visible:=False;
    cmbox_mz.Visible:=False;
    cmbox_dd.Visible:=False;
    //
    Label5.Visible:=True;
    edt_carnum.Visible:=True;
  end
  else
  begin
    Label1.Visible:=True;
    Label2.Visible:=True;
    Label4.Visible:=True;
    cmbox_dz.Visible:=True;
    cmbox_mz.Visible:=True;
    cmbox_dd.Visible:=True;
    //
    Label5.Visible:=False;
    edt_carnum.Visible:=False;
  end;
end;

end.
