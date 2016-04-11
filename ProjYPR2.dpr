program ProjYPR2;

uses
  Vcl.Forms,
  UnMain in 'UnMain.pas' {FormMain},
  Unglobal in 'Unglobal.pas',
  UnDM in 'UnDM.pas' {DM: TDataModule},
  Unlogin in 'Unlogin.pas' {Formlogin},
  Ungetdata2 in 'Ungetdata2.pas' {Formgetdata2},
  Undatacompute in 'Undatacompute.pas' {Formdatacompute},
  Unshowcol in 'Unshowcol.pas' {Formshowcol},
  Unuserlog in 'Unuserlog.pas' {Formuserlog},
  Unerrorlog in 'Unerrorlog.pas' {Formerrorlog},
  Unrole in 'Unrole.pas' {Formrole},
  Unroleedit in 'Unroleedit.pas' {Formroleedit},
  Unuser in 'Unuser.pas' {Formuser},
  Unuseredit in 'Unuseredit.pas' {Formuseredit},
  Unpermission in 'Unpermission.pas' {Formpermission},
  Unproper in 'Unproper.pas' {Formproper},
  Unproperedit in 'Unproperedit.pas' {Formproperedit},
  Unparam in 'Unparam.pas' {Formparam},
  Unparaminedit in 'Unparaminedit.pas' {Formparaminedit},
  Unparamoutedit in 'Unparamoutedit.pas' {Formparamoutedit},
  Unout in 'Unout.pas' {Formout},
  Unin in 'Unin.pas' {Formin},
  Unmonitor in 'Unmonitor.pas' {Formmonitor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TDM, DM);
  //Application.CreateForm(TFormmonitor, Formmonitor);
  //Application.CreateForm(TFormin, Formin);
  //Application.CreateForm(TFormout, Formout);
  //Application.CreateForm(TFormparam, Formparam);
  //Application.CreateForm(TFormparaminedit, Formparaminedit);
 // Application.CreateForm(TFormparamoutedit, Formparamoutedit);
  //Application.CreateForm(TFormproper, Formproper);
  //Application.CreateForm(TFormproperedit, Formproperedit);
  // Application.CreateForm(TFormpermission, Formpermission);
  //Application.CreateForm(TFormuser, Formuser);
  //Application.CreateForm(TFormuseredit, Formuseredit);
  //Application.CreateForm(TFormrole, Formrole);
  //Application.CreateForm(TFormroleedit, Formroleedit);
  //Application.CreateForm(TForm8, Form8);
  //Application.CreateForm(TFormerrorlog, Formerrorlog);
  //Application.CreateForm(TFormuserlog, Formuserlog);
  //Application.CreateForm(TFormdatacompute, Formdatacompute);
  //Application.CreateForm(TFormshowcol, Formshowcol);
  //Application.CreateForm(TForm2, Form2);
  //Application.CreateForm(TFormlogin, Formlogin);
  //Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
