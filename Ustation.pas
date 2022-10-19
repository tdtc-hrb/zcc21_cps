unit Ustation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Grids, DBGrids, DB, ADODB;

type
  Tfrm_station = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    StatusBar1: TStatusBar;
    Button3: TButton;
    Button4: TButton;
    ADODataSet1: TADODataSet;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_station: Tfrm_station;

implementation
uses
Udispatch;
{$R *.dfm}

procedure Tfrm_station.FormShow(Sender: TObject);
begin
  ADODataSet1.Close;
  ADODataSet1.Open;
end;

procedure Tfrm_station.Button3Click(Sender: TObject);
begin
  DBGrid1.ReadOnly:=False;
  ADODataSet1.Append;
end;

procedure Tfrm_station.Button4Click(Sender: TObject);
begin
  ADODataSet1.Delete;
end;

procedure Tfrm_station.Button1Click(Sender: TObject);
begin
  DBGrid1.ReadOnly:=False;
  ADODataSet1.Edit;
end;

procedure Tfrm_station.Button2Click(Sender: TObject);
begin
  ADODataSet1.Post;
  DBGrid1.ReadOnly:=True;
end;

end.
