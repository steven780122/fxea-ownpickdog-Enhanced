#import "shell32.dll"
   int ShellExecuteW(int hWnd, string lpVerb, string lpFile, string lpParameters, string lpDirectory, int nCmdShow);
#import 

void openWebBroswer(string furl) export
{
   Shell32::ShellExecuteW(0, "open", furl, "", "", 3);
}