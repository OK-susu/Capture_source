unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, PngImage;

type
  Tfrm_Main = class(TForm)
    btn: TButton;
    memo_log: TMemo;
    procedure btnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Main: Tfrm_Main;

implementation

{$R *.dfm}

procedure Tfrm_Main.btnClick(Sender: TObject);
var
  _Bitmap : TBitmap;
  _TPNGObject : TPNGObject;
  hHandle : HWND;
  width, height: Integer;
  Path: array [0..MAX_PATH-1] of Char;
begin
    GetModuleFileName(HInstance, Path, MAX_PATH);

     if not DirectoryExists(ExtractFilePath(Path) + '\log') then
          forcedirectories(ExtractFilePath(Path) + '\log');

    _Bitmap:= TBitmap.Create;
    _TPNGObject:= TPNGObject.Create;
    try
        width:= GetSystemMetrics(SM_CXSCREEN);
        height:= GetSystemMetrics(SM_CYSCREEN);

        _Bitmap.PixelFormat := pfDevice;
        _Bitmap.Width:= width;
        _Bitmap.Height:= height;
        hHandle := GetWindowDC(GetDeskTopWindow);

        if not BitBlt(_Bitmap.Canvas.Handle, 0, 0, Width, Height, hHandle, 0, 0, cmSrcCopy) then begin
          memo_log.Lines.Add('ĸó Error');
        end else begin
          _TPNGObject.Assign(_Bitmap);
          _TPNGObject.SaveToFile(ExtractFilePath(Path) + '\log\'+ FormatDateTime('yyyymmdd_hhnnss', Now) +'_.png');
          memo_log.Lines.Add('ĸó �Ϸ�');
        end;

        ReleaseDC(0, hHandle);
    finally
        if Assigned(_Bitmap) then FreeAndNil(_Bitmap);
        if Assigned(_TPNGObject) then FreeAndNil(_TPNGObject);
    end;
end;


end.
