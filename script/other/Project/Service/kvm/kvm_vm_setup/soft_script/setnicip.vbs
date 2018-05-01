'Option Explicit

call auto_setup_ip()
'��ȡ�����ļ��������������ļ�����ip��ַ����������ļ���һ��ipsetupΪ1��ֱ���˳�
sub auto_setup_ip
Const ForReading=1,ForWriting=2,ForAppending=8
Dim   fso,file,msg,logfile
Dim   WshShell,Path_init_file,Path_log_file
Dim   mac(10),ip(10),mask(10),gw(10)
Dim   k,m
Dim   ifrun
Dim   i,j,x,y
Dim   nicfile(20)
Dim   objFSO,logFSO
Dim   rtime
Dim   name,reval

i=0
j=1
x=0
y=0
Set   WshShell=WScript.CreateObject( "WScript.Shell")    '�õ��������ڵĵ�ǰ·��


Path_init_file=left(Wscript.ScriptFullName,len(Wscript.ScriptFullName)-len(Wscript.ScriptName))& "nicinfo.ini"   '���������ļ�Ϊ��ǰ·���µ�nicinfo.ini
Path_log_file=left(Wscript.ScriptFullName,len(Wscript.ScriptFullName)-len(Wscript.ScriptName))& "nicinfo.log"    '���������ļ�Ϊ��ǰ·���µ�nicinfo.log

'msgbox(path_init_file)



wrlog("�ű���ʼ����ʱ���� :")


Set objFSO = Createobject("Scripting.FileSystemObject")
If  objFSO.Fileexists(path_init_file) Then 
'msgbox("fil now")
else
'msgbox("fil now ---")
    exit sub
end if



Set fso=CreateObject("Scripting.FileSystemObject")
Set file=fso.OpenTextFile(Path_init_file,ForReading)

While (Not file.AtEndOfLine)
  
  msg=file.ReadLine
  nicfile(i)=msg
  i=i+1
  msg=trim(msg)

  if instr(msg, "c_name:")>0 then
      k = Instr(msg, ":")
      m = Len(msg)
      reval = Right(msg, m - k)
  else
  end if

  if instr(msg,"ipsetup:")>0 then
       k = InStr(msg, ":")
       m = Len(msg)
       ifrun = Right(msg, m - k)
       'msgbox(ifrun)
            if (ifrun="0") then 
               ifrun="1"
            else
                exit sub
            end if
       'msgbox(ifrun)
             
  else
  end if

  if instr(msg,"mac:")>0 then
       k = InStr(msg, ":")
       m = Len(msg)
       mac(x) = Right(msg, m - k)
       x=x+1
	   'msgbox(routmac)
  else
  end if

  if instr(msg,"ip:")>0 then
       k = InStr(msg, ":")
       m = Len(msg)
       ip(x) = Right(msg, m - k)
       'msgbox(routip)
  else
  end if

  if instr(msg,"mask:")>0 then
       k = InStr(msg, ":")
       m = Len(msg)
       mask(x) = Right(msg, m - k)
       'msgbox(routmask)
  else
  end if

  if instr(msg,"gw:")>0 then
       k = InStr(msg, ":")
       m = Len(msg)
       gw(x) = Right(msg, m - k)
       'msgbox(routgw)
  else
  end if


Wend
file.Close
Set file=Nothing
Set fso=Nothing


'wrlog("Configure Compute Name :")
'Set objnet = CreateObject ("WScript.Network")
'Set R = CreateObject("WScript.Shell")

'if (ifrun="1") then
'  strComputer = "."

 ' Set objWMIService = GetObject("winmgmts:" _
  '  & "{impersonationLevel=impersonate}!\\" _
   ' & strComputer & "\root\cimv2")

  'Set colComputers = objWMIService.ExecQuery _
   ' ("Select * from Win32_ComputerSystem")

  'For Each objComputer in colComputers
   ' If reval <> "" Then 
    'errReturn = ObjComputer.Rename (reval)
    
  'R.run("Shutdown.exe -r -t 0")
   'end If
  'next
'else
'end if


wrlog("��������ip :")
WScript.Sleep   50000

strGatewaymetric = Array(1)
For y=0 To x-1
  'Dim strComputer,objWMIService,colNetAdapters,strIPAddress,strSubnetMask,strGateway,errEnable,errGateways,objNetAdapter 
  strComputer = "."
  Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
  Set colNetAdapters = objWMIService.ExecQuery("Select * from Win32_NetworkAdapterConfiguration where (MACAddress ='"+ mac(y)+"' )")
  strIPAddress = Array(ip(y))
  strSubnetMask = Array(mask(y))
  strGateway = Array(gw(y))
  For Each objNetAdapter In colNetAdapters
    errEnable = objNetAdapter.EnableStatic(strIPAddress, strSubnetMask)
    errGateways = objNetAdapter.SetGateways(strGateway, strGatewaymetric)
  next
next


wrlog("ip������� :")





Set fso=CreateObject("Scripting.FileSystemObject")
Set file=fso.OpenTextFile(Path_init_file,ForWriting)

file.write("ipsetup:"+ifrun + vbCrLf)
file.Close

Set fso=CreateObject("Scripting.FileSystemObject")
Set file=fso.OpenTextFile(Path_init_file,8)
do until j > i
'msgbox(j)
file.writeline(nicfile(j))
j=j+1
loop
file.Close

wrlog("�޸������ļ���� :")




Set file=Nothing
Set fso=Nothing

'ɾ������������ļ�
Set fso=CreateObject("Scripting.FileSystemObject")
'fso.deletefile("C:\WINDOWS\system32\GroupPolicy\Machine\Scripts\Scripts.ini"),true
Set fso=Nothing

Set   shell=WScript.CreateObject("WScript.Shell")

'shell.run("del  C:\WINDOWS\system32\GroupPolicy\Machine\Scripts\Scripts.ini /f /q /a")
' ǿ�Ƹ��������
'shell.run("c:\windows\system32\gpupdate /force ")

WScript.Sleep   5000
' ����



'WScript.Sleep   10000
'set win32_OS=getobject("winmgmts:{(Shutdown)}//./root/cimv2").execQuery("select * from win32_operatingsystem where primary=true")
'for each OS in win32_OS
'OS.win32shutdown(6)
'next
'set win32_OS=nothing



end sub



function wrlog(logmsg)

Set   WshShell=WScript.CreateObject( "WScript.Shell")    '�õ��������ڵĵ�ǰ·��
Path_log_file=left(Wscript.ScriptFullName,len(Wscript.ScriptFullName)-len(Wscript.ScriptName))& "nicinfo.log"    '���������ļ�Ϊ��ǰ·���µ�nicinfo.log

'�ж���־�ļ��Ƿ���ڣ���������ڣ�����
Set logfso=CreateObject("Scripting.FileSystemObject")
If  logfso.Fileexists(Path_log_file) Then 
'msgbox("fil now")
else
  set ts=logfso.CreateTextFile(Path_log_file, True)
  ts.close
end if

'д��־

Set logfile=logfso.OpenTextFile(Path_log_file,8)
rtime=cstr(now())
logfile.write(logmsg+rtime + vbCrLf)
logfile.Close

end function
